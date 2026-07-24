import 'package:smartlist/core/config/app_flavor.dart';

/// Immutable, compile-time application configuration.
///
/// Values arrive through `--dart-define` so that no secret or environment
/// switch is committed to source control. Secrets are never shipped in the
/// binary for production: [aiProxyBaseUrl] points at a Cloud Function that
/// holds the provider keys server-side, and the direct-key fields exist only
/// to support local development against a provider sandbox.
final class AppConfig {
  const AppConfig({
    required this.flavor,
    required this.appName,
    required this.aiProxyBaseUrl,
    required this.defaultAiProvider,
    required this.enableCrashlytics,
    required this.enableAnalytics,
    required this.enableFirestorePersistence,
    required this.verboseLogging,
    required this.openAiApiKey,
    required this.geminiApiKey,
    required this.anthropicApiKey,
  });

  /// Builds the configuration from the ambient `--dart-define` values.
  factory AppConfig.fromEnvironment() {
    const flavorKey = String.fromEnvironment(
      'FLAVOR',
      defaultValue: 'development',
    );
    final flavor = AppFlavor.fromKey(flavorKey);

    return AppConfig(
      flavor: flavor,
      appName: 'SmartList${flavor.displaySuffix}',
      aiProxyBaseUrl: const String.fromEnvironment('AI_PROXY_BASE_URL'),
      defaultAiProvider: const String.fromEnvironment(
        'AI_PROVIDER',
        defaultValue: 'claude',
      ),
      enableCrashlytics: bool.fromEnvironment(
        'ENABLE_CRASHLYTICS',
        defaultValue: !flavor.isDevelopment,
      ),
      enableAnalytics: bool.fromEnvironment(
        'ENABLE_ANALYTICS',
        defaultValue: !flavor.isDevelopment,
      ),
      enableFirestorePersistence: const bool.fromEnvironment(
        'ENABLE_FIRESTORE_PERSISTENCE',
        defaultValue: true,
      ),
      verboseLogging: bool.fromEnvironment(
        'VERBOSE_LOGGING',
        defaultValue: !flavor.isProduction,
      ),
      openAiApiKey: const String.fromEnvironment('OPENAI_API_KEY'),
      geminiApiKey: const String.fromEnvironment('GEMINI_API_KEY'),
      anthropicApiKey: const String.fromEnvironment('ANTHROPIC_API_KEY'),
    );
  }

  final AppFlavor flavor;

  /// User-visible application name, flavor-suffixed outside production.
  final String appName;

  /// Base URL of the server-side AI proxy. Empty when unset, in which case the
  /// AI layer falls back to a direct provider call using a development key.
  final String aiProxyBaseUrl;

  /// Identifier of the AI provider selected on first launch.
  final String defaultAiProvider;

  final bool enableCrashlytics;
  final bool enableAnalytics;
  final bool enableFirestorePersistence;
  final bool verboseLogging;

  final String openAiApiKey;
  final String geminiApiKey;
  final String anthropicApiKey;

  /// True when requests should be routed through the server-side proxy.
  bool get useAiProxy => aiProxyBaseUrl.isNotEmpty;

  /// Direct provider keys must never be relied upon in a shipped build.
  bool get hasDirectAiKey =>
      openAiApiKey.isNotEmpty ||
      geminiApiKey.isNotEmpty ||
      anthropicApiKey.isNotEmpty;

  /// Network timeouts applied to the AI proxy and any direct provider call.
  Duration get connectTimeout => const Duration(seconds: 15);
  Duration get receiveTimeout => const Duration(seconds: 60);
  Duration get sendTimeout => const Duration(seconds: 30);
}
