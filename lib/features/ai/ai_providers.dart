import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:smartlist/features/ai/data/claude_ai_provider.dart';
import 'package:smartlist/features/ai/data/gemini_ai_provider.dart';
import 'package:smartlist/features/ai/data/open_router_ai_provider.dart';
import 'package:smartlist/features/ai/data/openai_ai_provider.dart';
import 'package:smartlist/features/ai/domain/ai_provider.dart';
import 'package:smartlist/features/ai/domain/ai_service.dart';
import 'package:smartlist/providers/core_providers.dart';

/// Dio instance dedicated to AI traffic, with its own longer timeouts.
final aiDioProvider = Provider<Dio>((ref) {
  final config = ref.watch(appConfigProvider);
  final dio = Dio(
    BaseOptions(
      connectTimeout: config.connectTimeout,
      receiveTimeout: config.receiveTimeout,
      sendTimeout: config.sendTimeout,
      // Non-2xx responses are surfaced as DioException so ErrorMapper can
      // classify them, rather than being handed back as successful payloads.
      validateStatus: (status) =>
          status != null && status >= 200 && status < 300,
    ),
  );
  ref.onDispose(dio.close);
  return dio;
});

final claudeProviderRef = Provider<AiProvider>((ref) {
  final config = ref.watch(appConfigProvider);
  return ClaudeAiProvider(
    dio: ref.watch(aiDioProvider),
    apiKey: config.anthropicApiKey,
    proxyBaseUrl: config.aiProxyBaseUrl,
  );
});

final openAiProviderRef = Provider<AiProvider>((ref) {
  final config = ref.watch(appConfigProvider);
  return OpenAiProvider(
    dio: ref.watch(aiDioProvider),
    apiKey: config.openAiApiKey,
    proxyBaseUrl: config.aiProxyBaseUrl,
  );
});

final geminiProviderRef = Provider<AiProvider>((ref) {
  final config = ref.watch(appConfigProvider);
  return GeminiAiProvider(
    dio: ref.watch(aiDioProvider),
    apiKey: config.geminiApiKey,
    proxyBaseUrl: config.aiProxyBaseUrl,
  );
});

final openRouterProviderRef = Provider<AiProvider>((ref) {
  final config = ref.watch(appConfigProvider);
  return OpenRouterAiProvider(
    dio: ref.watch(aiDioProvider),
    apiKey: config.openRouterApiKey,
    proxyBaseUrl: config.aiProxyBaseUrl,
    model: config.openRouterModel,
  );
});

/// Registration order is the fallback order used when the vendor selected in
/// settings has no credentials in this build.
final aiProviderRegistryProvider = Provider<AiProviderRegistry>((ref) {
  return AiProviderRegistry([
    // OpenRouter basta: tek anahtarla calisiyor ve ucretsiz katmani var, yani
    // digerleri icin anahtar girilmemis bir kurulumda ozellik yine acik olur.
    ref.watch(openRouterProviderRef),
    ref.watch(claudeProviderRef),
    ref.watch(openAiProviderRef),
    ref.watch(geminiProviderRef),
  ]);
});

final aiServiceProvider = Provider<AiService>((ref) {
  return AiService(ref.watch(aiProviderRegistryProvider));
});
