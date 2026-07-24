import 'package:dio/dio.dart';

import 'package:smartlist/core/errors/app_exception.dart';
import 'package:smartlist/core/errors/error_mapper.dart';
import 'package:smartlist/features/ai/domain/ai_models.dart';
import 'package:smartlist/features/ai/domain/ai_provider.dart';
import 'package:smartlist/models/enums.dart';

/// Google Gemini `generateContent` implementation.
///
/// `prefer_initializing_formals` is suppressed because Dart forbids private
/// named parameters, so `required this._dio` will not compile — the credential
/// fields must stay private.
// ignore_for_file: prefer_initializing_formals
class GeminiAiProvider implements AiProvider {
  GeminiAiProvider({
    required Dio dio,
    required String apiKey,
    required String proxyBaseUrl,
    this.model = _defaultModel,
  }) : _dio = dio,
       _apiKey = apiKey,
       _proxyBaseUrl = proxyBaseUrl;

  static const String _defaultModel = 'gemini-2.0-flash';

  static const String _directBase =
      'https://generativelanguage.googleapis.com/v1beta/models';

  final Dio _dio;
  final String _apiKey;
  final String _proxyBaseUrl;
  final String model;

  @override
  AiProviderKind get kind => AiProviderKind.gemini;

  @override
  String get defaultModel => model;

  @override
  bool get supportsStructuredOutput => true;

  @override
  bool get isConfigured => _proxyBaseUrl.isNotEmpty || _apiKey.isNotEmpty;

  bool get _useProxy => _proxyBaseUrl.isNotEmpty;

  @override
  Future<AiResponse> complete(AiRequest request) async {
    if (!isConfigured) {
      throw AiException(
        code: 'ai.not_configured',
        provider: kind.wire,
        details: 'No Gemini proxy URL or API key was supplied.',
      );
    }

    final resolvedModel = request.model ?? model;
    final systemPrompt = _systemPrompt(request);

    final body = <String, dynamic>{
      'contents': _contents(request),
      if (systemPrompt != null)
        'systemInstruction': {
          'parts': [
            {'text': systemPrompt},
          ],
        },
      'generationConfig': <String, dynamic>{
        'maxOutputTokens': request.maxTokens,
        if (request.temperature != null) 'temperature': request.temperature,
        if (request.jsonSchema != null) ...{
          'responseMimeType': 'application/json',
          'responseSchema': request.jsonSchema,
        },
      },
    };

    final url = _useProxy
        ? '$_proxyBaseUrl/gemini/generate'
        : '$_directBase/$resolvedModel:generateContent';

    final response = await ErrorMapper.guard(
      () => _dio.post<Map<String, dynamic>>(
        url,
        data: body,
        queryParameters: _useProxy ? null : {'key': _apiKey},
        options: Options(headers: {'content-type': 'application/json'}),
      ),
    );

    final payload = response.data;
    if (payload == null) {
      throw AiException(code: 'ai.empty_response', provider: kind.wire);
    }
    return _parse(payload, resolvedModel);
  }

  String? _systemPrompt(AiRequest request) {
    final fromMessages = request.messages
        .where((message) => message.role == AiMessageRole.system)
        .map((message) => message.content)
        .join('\n\n');
    final parts = [
      if (request.systemPrompt != null && request.systemPrompt!.isNotEmpty)
        request.systemPrompt!,
      if (fromMessages.isNotEmpty) fromMessages,
    ];
    return parts.isEmpty ? null : parts.join('\n\n');
  }

  /// Gemini names the assistant role `model` and carries text in `parts`.
  List<Map<String, dynamic>> _contents(AiRequest request) {
    return request.messages
        .where((message) => message.role != AiMessageRole.system)
        .map(
          (message) => <String, dynamic>{
            'role': message.role == AiMessageRole.assistant ? 'model' : 'user',
            'parts': [
              {'text': message.content},
            ],
          },
        )
        .toList();
  }

  AiResponse _parse(Map<String, dynamic> payload, String resolvedModel) {
    // A prompt rejected before generation carries promptFeedback instead of
    // candidates.
    final feedback = payload['promptFeedback'] as Map<String, dynamic>?;
    final blockReason = feedback?['blockReason'] as String?;
    final usage = payload['usageMetadata'] as Map<String, dynamic>?;

    if (blockReason != null) {
      return AiResponse(
        text: '',
        provider: kind,
        model: resolvedModel,
        stopReason: AiStopReason.refusal,
        refusalCategory: blockReason,
        inputTokens: usage?['promptTokenCount'] as int? ?? 0,
        outputTokens: usage?['candidatesTokenCount'] as int? ?? 0,
      );
    }

    final candidates = payload['candidates'] as List<dynamic>? ?? const [];
    if (candidates.isEmpty) {
      throw AiException(code: 'ai.empty_response', provider: kind.wire);
    }
    final candidate = candidates.first as Map<String, dynamic>;
    final finishReason = candidate['finishReason'] as String?;

    if (finishReason == 'SAFETY' || finishReason == 'PROHIBITED_CONTENT') {
      return AiResponse(
        text: '',
        provider: kind,
        model: resolvedModel,
        stopReason: AiStopReason.refusal,
        refusalCategory: finishReason,
        inputTokens: usage?['promptTokenCount'] as int? ?? 0,
        outputTokens: usage?['candidatesTokenCount'] as int? ?? 0,
      );
    }

    final content = candidate['content'] as Map<String, dynamic>?;
    final parts = content?['parts'] as List<dynamic>? ?? const [];
    final text = parts
        .whereType<Map<String, dynamic>>()
        .map((part) => part['text'] as String? ?? '')
        .join();

    return AiResponse(
      text: text,
      provider: kind,
      model: resolvedModel,
      stopReason: switch (finishReason) {
        'STOP' => AiStopReason.completed,
        'MAX_TOKENS' => AiStopReason.maxTokens,
        _ => AiStopReason.unknown,
      },
      inputTokens: usage?['promptTokenCount'] as int? ?? 0,
      outputTokens: usage?['candidatesTokenCount'] as int? ?? 0,
    );
  }
}
