import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
// FirebaseException is re-exported by firebase_auth.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'package:smartlist/core/errors/app_exception.dart';

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
      final FirebaseAuthException e => _auth(e, stackTrace),
      final FirebaseException e => _firebase(e, stackTrace),
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

  static AppException _auth(
    FirebaseAuthException e,
    StackTrace? stackTrace,
  ) {
    final code = switch (e.code) {
      'invalid-email' => 'auth.invalid_email',
      'user-disabled' => 'auth.user_disabled',
      'user-not-found' => 'auth.user_not_found',
      'wrong-password' => 'auth.wrong_password',
      'invalid-credential' => 'auth.invalid_credential',
      'email-already-in-use' => 'auth.email_already_in_use',
      'weak-password' => 'auth.weak_password',
      'operation-not-allowed' => 'auth.operation_not_allowed',
      'requires-recent-login' => 'auth.requires_recent_login',
      'account-exists-with-different-credential' =>
        'auth.account_exists_with_different_credential',
      'credential-already-in-use' => 'auth.credential_already_in_use',
      'invalid-verification-code' => 'auth.invalid_verification_code',
      'expired-action-code' => 'auth.expired_action_code',
      'invalid-action-code' => 'auth.invalid_action_code',
      'unverified-email' => 'auth.unverified_email',
      'sign_in_canceled' || 'canceled' => 'auth.cancelled',
      'network-request-failed' => 'network.unavailable',
      'too-many-requests' => 'quota.rate_limited',
      _ => 'auth.failed',
    };

    if (code == 'network.unavailable') {
      return NetworkException(
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      );
    }
    if (code == 'quota.rate_limited') {
      return RateLimitException(
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      );
    }
    return AuthException(
      code: code,
      details: e.message,
      cause: e,
      stackTrace: stackTrace,
    );
  }

  static AppException _firebase(
    FirebaseException e,
    StackTrace? stackTrace,
  ) {
    return switch (e.code) {
      'permission-denied' ||
      'unauthorized' ||
      'unauthenticated' => PermissionDeniedException(
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      ),
      'not-found' || 'object-not-found' => NotFoundException(
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      ),
      'already-exists' ||
      'aborted' ||
      'failed-precondition' => ConflictException(
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      ),
      'unavailable' || 'internal' || 'data-loss' => ServerException(
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      ),
      'deadline-exceeded' => NetworkException(
        code: 'network.timeout',
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      ),
      'resource-exhausted' || 'quota-exceeded' => RateLimitException(
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      ),
      'invalid-argument' || 'out-of-range' => ValidationException(
        code: 'validation.invalid_argument',
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      ),
      'cancelled' => NetworkException(
        code: 'network.cancelled',
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      ),
      'unimplemented' => UnknownException(
        code: 'server.unimplemented',
        details: e.message,
        cause: e,
        stackTrace: stackTrace,
      ),
      _ => UnknownException(
        details: '${e.plugin}/${e.code}: ${e.message}',
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
