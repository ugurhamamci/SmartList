import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:smartlist/core/config/app_config.dart';
import 'package:smartlist/core/config/firebase_options.dart';
import 'package:smartlist/core/database/local_cache.dart';
import 'package:smartlist/core/errors/error_mapper.dart';
import 'package:smartlist/core/utils/app_logger.dart';
import 'package:smartlist/providers/core_providers.dart';

/// Starts the application.
///
/// Every initialisation step that can fail is contained: a failure produces a
/// diagnostic screen rather than a blank window, because a crash before
/// `runApp` leaves the user with no way to understand or report the problem.
/// The whole startup runs inside `runZonedGuarded` so an asynchronous error
/// raised during initialisation is still reported.
Future<void> bootstrap(Widget Function() appBuilder) async {
  final config = AppConfig.fromEnvironment();
  AppLogger.configure(verbose: config.verboseLogging);

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Hanken Grotesk uygulamaya gömülü. Bu bayrak, herhangi bir kod yolunun
      // yazı tipini kazayla ağdan çekmesini engeller: fetch denemesi sessizce
      // ağa çıkmak yerine hata verir.
      GoogleFonts.config.allowRuntimeFetching = false;

      try {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      } on Object catch (error, stackTrace) {
        AppLogger.fatal('Firebase initialisation failed', error, stackTrace);
        runApp(_StartupFailureApp(error: error, config: config));
        return;
      }

      _installErrorHandlers(config);

      try {
        await _configureFirestore(config);
        await LocalCache.initialize();
      } on Object catch (error, stackTrace) {
        // Persistence is an optimisation, not a requirement: log and continue
        // so the app still works against the network.
        AppLogger.error('Local persistence unavailable', error, stackTrace);
      }

      runApp(
        ProviderScope(
          overrides: [appConfigProvider.overrideWithValue(config)],
          child: appBuilder(),
        ),
      );
    },
    (error, stackTrace) {
      AppLogger.fatal('Uncaught zone error', error, stackTrace);
      if (config.enableCrashlytics) {
        unawaited(
          FirebaseCrashlytics.instance.recordError(
            error,
            stackTrace,
            fatal: true,
          ),
        );
      }
    },
  );
}

/// Routes framework and platform errors into the logger and Crashlytics.
void _installErrorHandlers(AppConfig config) {
  final crashlytics = FirebaseCrashlytics.instance;

  FlutterError.onError = (details) {
    AppLogger.error(
      'Flutter framework error',
      details.exception,
      details.stack,
    );
    if (config.enableCrashlytics) {
      unawaited(crashlytics.recordFlutterError(details));
    } else {
      FlutterError.presentError(details);
    }
  };

  // Errors that escape the Flutter framework entirely, e.g. from a platform
  // channel callback.
  PlatformDispatcher.instance.onError = (error, stackTrace) {
    final mapped = ErrorMapper.map(error, stackTrace);
    AppLogger.fatal(
      'Unhandled platform error: ${mapped.code}',
      error,
      stackTrace,
    );
    if (config.enableCrashlytics) {
      unawaited(crashlytics.recordError(error, stackTrace, fatal: true));
    }
    return true;
  };

  unawaited(
    crashlytics.setCrashlyticsCollectionEnabled(config.enableCrashlytics),
  );
}

Future<void> _configureFirestore(AppConfig config) async {
  FirebaseFirestore.instance.settings = Settings(
    persistenceEnabled: config.enableFirestorePersistence,
    cacheSizeBytes: config.enableFirestorePersistence
        ? Settings.CACHE_SIZE_UNLIMITED
        : null,
  );
}

/// Shown when the app cannot initialise at all.
///
/// Names the missing configuration explicitly, since the usual cause is a build
/// launched without the required `--dart-define` values.
class _StartupFailureApp extends StatelessWidget {
  const _StartupFailureApp({required this.error, required this.config});

  final Object error;
  final AppConfig config;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: config.appName,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.error_outline, size: 48),
                const SizedBox(height: 16),
                Text(
                  'SmartList could not start',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Firebase could not be initialised. Check that the build '
                  'supplies the required --dart-define values; see README.md.',
                ),
                const SizedBox(height: 16),
                if (kDebugMode)
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        '$error',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
