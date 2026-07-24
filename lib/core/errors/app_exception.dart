/// Application-level error taxonomy.
///
/// Repositories translate infrastructure errors (FirebaseException, DioException,
/// PlatformException) into one of these types so that the presentation layer
/// never inspects vendor-specific error codes. [code] is a stable identifier
/// resolved to localized copy by `AppExceptionL10n`.
sealed class AppException implements Exception {
  const AppException({
    required this.code,
    this.details,
    this.cause,
    this.stackTrace,
  });

  /// Stable, non-localized identifier, e.g. `auth.wrong_password`.
  final String code;

  /// Optional non-localized diagnostic context for logs and Crashlytics.
  final String? details;

  /// The originating error, retained for logging.
  final Object? cause;

  final StackTrace? stackTrace;

  /// Whether retrying the same operation could plausibly succeed.
  bool get isRetryable => switch (this) {
    NetworkException() => true,
    ServerException() => true,
    RateLimitException() => true,
    ConflictException() => true,
    AiException() => true,
    _ => false,
  };

  /// Stable type name, safe to use in release builds where `runtimeType` is
  /// minified.
  String get kind => switch (this) {
    NetworkException() => 'NetworkException',
    ServerException() => 'ServerException',
    AuthException() => 'AuthException',
    PermissionDeniedException() => 'PermissionDeniedException',
    NotFoundException() => 'NotFoundException',
    ConflictException() => 'ConflictException',
    ValidationException() => 'ValidationException',
    RateLimitException() => 'RateLimitException',
    PremiumRequiredException() => 'PremiumRequiredException',
    CacheException() => 'CacheException',
    PlatformCapabilityException() => 'PlatformCapabilityException',
    AiException() => 'AiException',
    UnknownException() => 'UnknownException',
  };

  @override
  String toString() {
    final buffer = StringBuffer('$kind($code)');
    if (details != null) {
      buffer.write(': $details');
    }
    if (cause != null) {
      buffer.write(' <- $cause');
    }
    return buffer.toString();
  }
}

/// No usable connectivity, DNS failure, or socket timeout.
final class NetworkException extends AppException {
  const NetworkException({
    super.code = 'network.unavailable',
    super.details,
    super.cause,
    super.stackTrace,
  });
}

/// The backend answered with a 5xx or an unavailable Firestore backend.
final class ServerException extends AppException {
  const ServerException({
    super.code = 'server.unavailable',
    this.statusCode,
    super.details,
    super.cause,
    super.stackTrace,
  });

  final int? statusCode;
}

/// Authentication and account-state problems.
final class AuthException extends AppException {
  const AuthException({
    required super.code,
    super.details,
    super.cause,
    super.stackTrace,
  });
}

/// The caller is authenticated but not authorised for the operation.
final class PermissionDeniedException extends AppException {
  const PermissionDeniedException({
    super.code = 'permission.denied',
    super.details,
    super.cause,
    super.stackTrace,
  });
}

/// The requested document does not exist or was soft deleted.
final class NotFoundException extends AppException {
  const NotFoundException({
    super.code = 'resource.not_found',
    super.details,
    super.cause,
    super.stackTrace,
  });
}

/// Optimistic concurrency conflict: the stored `version` moved on.
final class ConflictException extends AppException {
  const ConflictException({
    super.code = 'resource.conflict',
    this.localVersion,
    this.remoteVersion,
    super.details,
    super.cause,
    super.stackTrace,
  });

  final int? localVersion;
  final int? remoteVersion;
}

/// Client-side validation failure, keyed by field where applicable.
final class ValidationException extends AppException {
  const ValidationException({
    required super.code,
    this.field,
    super.details,
    super.cause,
    super.stackTrace,
  });

  final String? field;
}

/// Quota, plan limit or throttling.
final class RateLimitException extends AppException {
  const RateLimitException({
    super.code = 'quota.rate_limited',
    this.retryAfter,
    super.details,
    super.cause,
    super.stackTrace,
  });

  final Duration? retryAfter;
}

/// A premium-only capability was invoked on a free plan.
final class PremiumRequiredException extends AppException {
  const PremiumRequiredException({
    super.code = 'premium.required',
    this.feature,
    super.details,
    super.cause,
    super.stackTrace,
  });

  final String? feature;
}

/// Local cache read/write failure.
final class CacheException extends AppException {
  const CacheException({
    super.code = 'cache.failure',
    super.details,
    super.cause,
    super.stackTrace,
  });
}

/// A platform capability was denied or is unavailable (camera, mic, photos).
final class PlatformCapabilityException extends AppException {
  const PlatformCapabilityException({
    required super.code,
    this.capability,
    super.details,
    super.cause,
    super.stackTrace,
  });

  final String? capability;
}

/// Failure inside the AI provider layer.
final class AiException extends AppException {
  const AiException({
    required super.code,
    this.provider,
    super.details,
    super.cause,
    super.stackTrace,
  });

  final String? provider;
}

/// Anything that could not be classified.
final class UnknownException extends AppException {
  const UnknownException({
    super.code = 'unknown',
    super.details,
    super.cause,
    super.stackTrace,
  });
}
