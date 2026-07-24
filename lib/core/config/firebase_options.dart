import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// Firebase project configuration, supplied at build time.
///
/// `flutterfire configure` normally writes these values into a generated file.
/// This project instead reads them from `--dart-define` so that a single
/// codebase can target the development, staging and production Firebase
/// projects without swapping checked-in files, and so that no project
/// identifier is committed. CI injects the values per flavor from its secret
/// store; `scripts/run_dev.ps1` supplies them locally.
///
/// Every value is a client-side identifier rather than a secret — Firebase
/// access is governed by the security rules — but keeping them out of source
/// control avoids cross-environment mistakes.
abstract final class DefaultFirebaseOptions {
  /// Options for the platform the app is currently running on.
  ///
  /// Throws [UnsupportedError] on a platform the project does not target and
  /// [StateError] when the build did not supply the required defines, which
  /// fails fast at startup instead of producing confusing runtime errors.
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return _web;
    }
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => _android,
      TargetPlatform.iOS => _ios,
      _ => throw UnsupportedError(
        'SmartList targets Android, iOS and web; '
        '$defaultTargetPlatform is not configured.',
      ),
    };
  }

  static const String _apiKeyAndroid = String.fromEnvironment(
    'FIREBASE_API_KEY_ANDROID',
  );
  static const String _apiKeyIos = String.fromEnvironment(
    'FIREBASE_API_KEY_IOS',
  );
  static const String _apiKeyWeb = String.fromEnvironment(
    'FIREBASE_API_KEY_WEB',
  );
  static const String _appIdAndroid = String.fromEnvironment(
    'FIREBASE_APP_ID_ANDROID',
  );
  static const String _appIdIos = String.fromEnvironment(
    'FIREBASE_APP_ID_IOS',
  );
  static const String _appIdWeb = String.fromEnvironment(
    'FIREBASE_APP_ID_WEB',
  );
  static const String _projectId = String.fromEnvironment(
    'FIREBASE_PROJECT_ID',
  );
  static const String _messagingSenderId = String.fromEnvironment(
    'FIREBASE_MESSAGING_SENDER_ID',
  );
  static const String _storageBucket = String.fromEnvironment(
    'FIREBASE_STORAGE_BUCKET',
  );
  static const String _authDomain = String.fromEnvironment(
    'FIREBASE_AUTH_DOMAIN',
  );
  static const String _iosBundleId = String.fromEnvironment(
    'FIREBASE_IOS_BUNDLE_ID',
    defaultValue: 'com.mudo.smartlist',
  );
  static const String _measurementId = String.fromEnvironment(
    'FIREBASE_MEASUREMENT_ID',
  );

  static FirebaseOptions get _android => FirebaseOptions(
    apiKey: _require(_apiKeyAndroid, 'FIREBASE_API_KEY_ANDROID'),
    appId: _require(_appIdAndroid, 'FIREBASE_APP_ID_ANDROID'),
    messagingSenderId: _require(
      _messagingSenderId,
      'FIREBASE_MESSAGING_SENDER_ID',
    ),
    projectId: _require(_projectId, 'FIREBASE_PROJECT_ID'),
    storageBucket: _optional(_storageBucket),
  );

  static FirebaseOptions get _ios => FirebaseOptions(
    apiKey: _require(_apiKeyIos, 'FIREBASE_API_KEY_IOS'),
    appId: _require(_appIdIos, 'FIREBASE_APP_ID_IOS'),
    messagingSenderId: _require(
      _messagingSenderId,
      'FIREBASE_MESSAGING_SENDER_ID',
    ),
    projectId: _require(_projectId, 'FIREBASE_PROJECT_ID'),
    storageBucket: _optional(_storageBucket),
    iosBundleId: _iosBundleId,
  );

  static FirebaseOptions get _web => FirebaseOptions(
    apiKey: _require(_apiKeyWeb, 'FIREBASE_API_KEY_WEB'),
    appId: _require(_appIdWeb, 'FIREBASE_APP_ID_WEB'),
    messagingSenderId: _require(
      _messagingSenderId,
      'FIREBASE_MESSAGING_SENDER_ID',
    ),
    projectId: _require(_projectId, 'FIREBASE_PROJECT_ID'),
    storageBucket: _optional(_storageBucket),
    authDomain: _optional(_authDomain),
    measurementId: _optional(_measurementId),
  );

  static String _require(String value, String define) {
    if (value.isEmpty) {
      throw StateError(
        'Missing Firebase configuration: pass --dart-define=$define=... '
        'See README.md for the full set of required defines.',
      );
    }
    return value;
  }

  static String? _optional(String value) => value.isEmpty ? null : value;
}
