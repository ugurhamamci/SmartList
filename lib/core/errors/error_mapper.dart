import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:smartlist/core/errors/app_exception.dart';
// Supabase'in `AuthException`'i uygulamanin kendi tipiyle ayni ada sahip.
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthException;

/// Translates infrastructure errors into the [AppException] taxonomy.
///
/// This is the single boundary at which vendor error codes are interpreted.
abstract final class ErrorMapper {
  /// Maps [error] to an [AppException], passing through values that are
  /// already mapped.
  static AppException map(Object error, [StackTrace? stackTrace]) {
    if (error is AppException) {
      return error;
    }
    return switch (error) {
      final PostgrestException e => _postgrest(e, stackTrace),
      final StorageException e => _storage(e, stackTrace),
      final DioException e => _dio(e, stackTrace),
      final PlatformException e => _platform(e, stackTrace),
      final SocketException e => NetworkException(
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      ),
      final TimeoutException e => NetworkException(
        code: 'network.timeout',
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      ),
      final HttpException e => ServerException(
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      ),
      _ => UnknownException(
        details: error.toString(),
        cause: error,
        stackTrace: stackTrace,
      ),
    };
  }

  /// Runs [action] and rethrows any failure as an [AppException].
  static Future<T> guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } catch (error, stackTrace) {
      throw map(error, stackTrace);
    }
  }

  /// Stream equivalent of [guard]; errors are mapped in flight.
  static Stream<T> guardStream<T>(Stream<T> Function() action) {
    return action().handleError((Object error, StackTrace stackTrace) {
      throw map(error, stackTrace);
    });
  }

  /// PostgREST hatasini esler.
  ///
  /// `code` alani Postgres'in SQLSTATE degeri (5 karakter) ya da PostgREST'in
  /// kendi `PGRSTxxx` kodu oluyor. Ayirt etmek onemli: RLS reddi ile bir kisit
  /// ihlali kullaniciya farkli sey anlatmali.
  static AppException _postgrest(
    PostgrestException e,
    StackTrace? stackTrace,
  ) {
    return switch (e.code) {
      // 42501 insufficient_privilege: RLS politikasi ya da viewer alan
      // kisitlamasi trigger'i reddetti.
      '42501' || 'PGRST301' => PermissionDeniedException(
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      ),

      // PGRST116: tek satir beklenirken hicbiri donmedi.
      // P0002: fonksiyon icinde `no_data_found` firlatildi (gecersiz davet).
      'PGRST116' || 'P0002' => NotFoundException(
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      ),

      // 23505 tekillik ihlali: ayni uyeyi iki kez eklemek, ayni barkodu ikinci
      // kez kaydetmek gibi durumlar.
      '23505' => ConflictException(
        code: 'conflict.duplicate',
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      ),

      // 23503 foreign key: silinmis bir listeye urun eklemek.
      // 23514 check kisiti: negatif miktar, gecersiz renk kodu.
      // 22P02 gecersiz metin gosterimi: bozuk uuid veya enum degeri.
      '23503' || '23514' || '22P02' || '23502' => ValidationException(
        code: 'validation.invalid_argument',
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      ),

      // 40001 serialization_failure / 40P01 deadlock: eszamanli yazma
      // cakismasi. Yeniden denemek makul, o yuzden Conflict.
      '40001' || '40P01' => ConflictException(
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      ),

      // 57014 sorgu iptal edildi (zaman asimi).
      '57014' => NetworkException(
        code: 'network.timeout',
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      ),

      // 53300 too_many_connections: baglanti havuzu doldu.
      '53300' || '53400' => RateLimitException(
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      ),

      // PGRST202: cagirilan fonksiyon yok. PGRST205: tablo sema onbelleginde
      // yok - sema uygulanmamis demek, gelistirme hatasi.
      'PGRST202' || 'PGRST205' => UnknownException(
        code: 'server.schema_mismatch',
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      ),

      _ => ServerException(
        details: '${e.code}: ${e.message}',
        cause: e,
        stackTrace: stackTrace,
      ),
    };
  }

  /// Supabase Storage hatasini esler. Kodlar HTTP durumunu metin olarak
  /// tasiyor.
  static AppException _storage(
    StorageException e,
    StackTrace? stackTrace,
  ) {
    return switch (e.statusCode) {
      '401' || '403' => PermissionDeniedException(
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      ),
      '404' => NotFoundException(
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      ),
      '409' => ConflictException(
        code: 'conflict.duplicate',
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      ),
      // Dosya boyutu sinirini asmak en sik gorulen hata; kullaniciya
      // "gecersiz" degil "cok buyuk" demek gerekiyor.
      '413' => ValidationException(
        code: 'validation.file_too_large',
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      ),
      '429' => RateLimitException(
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      ),
      _ => ServerException(
        details: '${e.statusCode}: ${e.message}',
        cause: e,
        stackTrace: stackTrace,
      ),
    };
  }

  static AppException _dio(DioException e, StackTrace? stackTrace) {
    final status = e.response?.statusCode;

    return switch (e.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.transformTimeout => NetworkException(
        code: 'network.timeout',
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      ),
      DioExceptionType.connectionError => NetworkException(
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      ),
      DioExceptionType.cancel => NetworkException(
        code: 'network.cancelled',
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      ),
      DioExceptionType.badCertificate => NetworkException(
        code: 'network.bad_certificate',
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      ),
      DioExceptionType.badResponse => _httpStatus(e, status, stackTrace),
      DioExceptionType.unknown =>
        e.error is SocketException
            ? NetworkException(
                details: e.message,
                cause: e,
                stackTrace: stackTrace,
              )
            : UnknownException(
                details: e.message,
                cause: e,
                stackTrace: stackTrace,
              ),
    };
  }

  static AppException _httpStatus(
    DioException e,
    int? status,
    StackTrace? stackTrace,
  ) {
    if (status == null) {
      return ServerException(
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      );
    }
    if (status == 401 || status == 403) {
      return PermissionDeniedException(
        details: 'HTTP $status',
        cause: e,
        stackTrace: stackTrace,
      );
    }
    if (status == 404) {
      return NotFoundException(
        details: 'HTTP $status',
        cause: e,
        stackTrace: stackTrace,
      );
    }
    if (status == 409) {
      return ConflictException(
        details: 'HTTP $status',
        cause: e,
        stackTrace: stackTrace,
      );
    }
    if (status == 422) {
      return ValidationException(
        code: 'validation.rejected',
        details: 'HTTP $status',
        cause: e,
        stackTrace: stackTrace,
      );
    }
    if (status == 429) {
      return RateLimitException(
        retryAfter: _retryAfter(e),
        details: 'HTTP $status',
        cause: e,
        stackTrace: stackTrace,
      );
    }
    if (status >= 500) {
      return ServerException(
        statusCode: status,
        details: 'HTTP $status',
        cause: e,
        stackTrace: stackTrace,
      );
    }
    return UnknownException(
      details: 'HTTP $status',
      cause: e,
      stackTrace: stackTrace,
    );
  }

  static Duration? _retryAfter(DioException e) {
    final header = e.response?.headers.value('retry-after');
    if (header == null) {
      return null;
    }
    final seconds = int.tryParse(header);
    return seconds == null ? null : Duration(seconds: seconds);
  }

  static AppException _platform(
    PlatformException e,
    StackTrace? stackTrace,
  ) {
    return switch (e.code) {
      'camera_access_denied' ||
      'photo_access_denied' ||
      'microphone_access_denied' ||
      'permission_denied' ||
      'PermissionDenied' => PlatformCapabilityException(
        code: 'capability.denied',
        capability: e.code,
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      ),
      'unavailable' || 'not_available' => PlatformCapabilityException(
        code: 'capability.unavailable',
        capability: e.code,
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      ),
      _ => UnknownException(
        details: '${e.code}: ${e.message}',
        cause: e,
        stackTrace: stackTrace,
      ),
    };
  }
}
