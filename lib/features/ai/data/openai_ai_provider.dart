import 'package:dio/dio.dart';

import 'package:smartlist/core/errors/app_exception.dart';
import 'package:smartlist/core/errors/error_mapper.dart';
import 'package:smartlist/features/ai/domain/ai_models.dart';
import 'package:smartlist/features/ai/domain/ai_provider.dart';
import 'package:smartlist/models/enums.dart';

/// OpenAI Chat Completions implementation.
///
/// `prefer_initializing_formals` is suppressed because Dart forbids private
/// named parameters, so `required this._dio` will not compile — the credential
/// fields must stay private.
// ignore_for_file: prefer_initializing_formals
class OpenAiProvider implements AiProvider {
  OpenAiProvider({
    required Dio dio,
    required String apiKey,
    required String proxyBaseUrl,
    this.model = _defaultModel,
  }) : _dio = dio,
       _apiKey = apiKey,
       _proxyBaseUrl = proxyBaseUrl;

  static const String _defaultModel = 'gpt-4o';

  static const String _directEndpoint =
      'https://api.openai.com/v1/chat/completions';

  final Dio _dio;
  final String _apiKey;
  final String _proxyBaseUrl;
  final String model;

  @override
  AiProviderKind get kind => AiProviderKind.openAi;

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
        details: 'No OpenAI proxy URL or API key was supplied.',
      );
    }

    final body = <String, dynamic>{
      'model': request.model ?? model,
      'max_tokens': request.maxTokens,
      'messages': _messages(request),
      if (request.temperature != null) 'temperature': request.temperature,
      if (request.jsonSchema != null)
        'response_format': {
          'type': 'json_schema',
          'json_schema': {
            'name': 'smartlist_response',
            'strict': true,
            'schema': request.jsonSchema,
          },
        },
    };

    final response = await ErrorMapper.guard(
      () => _dio.post<Map<String, dynamic>>(
        _useProxy ? '$_proxyBaseUrl/openai/chat' : _directEndpoint,
        data: body,
        options: Options(
          headers: {
            'content-type': 'application/json',
            if (!_useProxy) 'authorization': 'Bearer $_apiKey',
          },
        ),
      ),
    );

    final payload = response.data;
    if (payload == null) {
      throw AiException(code: 'ai.empty_response', provider: kind.wire);
    }
    return _parse(payload);
  }

  List<Map<String, dynamic>> _messages(AiRequest request) {
    return <Map<String, dynamic>>[
      if (request.systemPrompt != null && request.systemPrompt!.isNotEmpty)
        {'role': 'system', 'content': request.systemPrompt},
      ...request.messages.map(
        (message) => <String, dynamic>{
          'role': message.role.wire,
          'content': message.content,
        },
      ),
    ];
  }

  AiResponse _parse(Map<String, dynamic> payload) {
    final choices = payload['choices'] as List<dynamic>? ?? const [];
    if (choices.isEmpty) {
      throw AiException(code: 'ai.empty_response', provider: kind.wire);
    }
    final choice = choices.first as Map<String, dynamic>;
    final message = choice['message'] as Map<String, dynamic>?;
    final usage = payload['usage'] as Map<String, dynamic>?;
    final finishReason = choice['finish_reason'] as String?;

    // A content filter stop carries no usable text.
    final refusal = message?['refusal'] as String?;
    if (finishReason == 'content_filter' || refusal != null) {
      return AiResponse(
        text: '',
        provider: kind,
        model: payload['model'] as String? ?? model,
        stopReason: AiStopReason.refusal,
        refusalCategory: refusal,
        inputTokens: usage?['prompt_tokens'] as int? ?? 0,
        outputTokens: usage?['completion_tokens'] as int? ?? 0,
      );
    }

    return AiResponse(
      text: message?['content'] as String? ?? '',
      provider: kind,
      model: payload['model'] as String? ?? model,
      stopReason: switch (finishReason) {
        'stop' => AiStopReason.completed,
        'length' => AiStopReason.maxTokens,
        'tool_calls' || 'function_call' => AiStopReason.toolUse,
        _ => AiStopReason.unknown,
      },
      inputTokens: usage?['prompt_tokens'] as int? ?? 0,
      outputTokens: usage?['completion_tokens'] as int? ?? 0,
    );
  }
}
