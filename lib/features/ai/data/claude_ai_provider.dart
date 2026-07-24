import 'package:dio/dio.dart';

import 'package:smartlist/core/errors/app_exception.dart';
import 'package:smartlist/core/errors/error_mapper.dart';
import 'package:smartlist/features/ai/domain/ai_models.dart';
import 'package:smartlist/features/ai/domain/ai_provider.dart';
import 'package:smartlist/models/enums.dart';

/// Anthropic Messages API implementation.
///
/// Requests go through the configured proxy when one is supplied so the API key
/// stays server-side; the direct-key path exists for local development only.
///
/// `prefer_initializing_formals` is suppressed because Dart forbids private
/// named parameters, so `required this._dio` will not compile — the credential
/// fields must stay private.
// ignore_for_file: prefer_initializing_formals
class ClaudeAiProvider implements AiProvider {
  ClaudeAiProvider({
    required Dio dio,
    required String apiKey,
    required String proxyBaseUrl,
    this.model = _defaultModel,
  }) : _dio = dio,
       _apiKey = apiKey,
       _proxyBaseUrl = proxyBaseUrl;

  /// Anthropic's current frontier model. The id carries no date suffix.
  static const String _defaultModel = 'claude-opus-5';

  static const String _directEndpoint = 'https://api.anthropic.com/v1/messages';

  /// Wire version pinned by the Messages API.
  static const String _apiVersion = '2023-06-01';

  final Dio _dio;
  final String _apiKey;
  final String _proxyBaseUrl;
  final String model;

  @override
  AiProviderKind get kind => AiProviderKind.claude;

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
        details: 'No Anthropic proxy URL or API key was supplied.',
      );
    }

    final systemPrompt = _resolveSystemPrompt(request);
    final body = <String, dynamic>{
      'model': request.model ?? model,
      'max_tokens': request.maxTokens,
      'messages': _conversationTurns(request.messages),
      'system': ?systemPrompt,
      if (request.jsonSchema != null)
        'output_config': {
          'format': {'type': 'json_schema', 'schema': request.jsonSchema},
        },
      // `temperature`, `top_p` and `top_k` are rejected with HTTP 400 on this
      // model family, so AiRequest.temperature is deliberately not forwarded.
    };

    final response = await ErrorMapper.guard(
      () => _dio.post<Map<String, dynamic>>(
        _useProxy ? '$_proxyBaseUrl/anthropic/messages' : _directEndpoint,
        data: body,
        options: Options(
          headers: {
            'content-type': 'application/json',
            if (!_useProxy) ...{
              'x-api-key': _apiKey,
              'anthropic-version': _apiVersion,
            },
          },
        ),
      ),
    );

    final payload = response.data;
    if (payload == null) {
      throw AiException(
        code: 'ai.empty_response',
        provider: kind.wire,
      );
    }
    return _parse(payload);
  }

  /// Anthropic carries instructions in a dedicated top-level `system` field
  /// rather than as a conversation turn.
  String? _resolveSystemPrompt(AiRequest request) {
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

  List<Map<String, dynamic>> _conversationTurns(List<AiMessage> messages) {
    return messages
        .where((message) => message.role != AiMessageRole.system)
        .map(
          (message) => <String, dynamic>{
            'role': message.role == AiMessageRole.assistant
                ? 'assistant'
                : 'user',
            'content': message.content,
          },
        )
        .toList();
  }

  AiResponse _parse(Map<String, dynamic> payload) {
    final stopReason = payload['stop_reason'] as String?;
    final usage = payload['usage'] as Map<String, dynamic>?;
    final resolvedModel = payload['model'] as String? ?? model;

    // A declined request arrives as a successful HTTP 200 with an empty or
    // partial content array, so stop_reason must be inspected before reading it.
    if (stopReason == 'refusal') {
      final details = payload['stop_details'] as Map<String, dynamic>?;
      return AiResponse(
        text: '',
        provider: kind,
        model: resolvedModel,
        stopReason: AiStopReason.refusal,
        refusalCategory: details?['category'] as String?,
        inputTokens: usage?['input_tokens'] as int? ?? 0,
        outputTokens: usage?['output_tokens'] as int? ?? 0,
      );
    }

    final blocks = payload['content'] as List<dynamic>? ?? const [];
    final text = blocks
        .whereType<Map<String, dynamic>>()
        .where((block) => block['type'] == 'text')
        .map((block) => block['text'] as String? ?? '')
        .join();

    return AiResponse(
      text: text,
      provider: kind,
      model: resolvedModel,
      stopReason: switch (stopReason) {
        'end_turn' || 'stop_sequence' => AiStopReason.completed,
        'max_tokens' => AiStopReason.maxTokens,
        'tool_use' => AiStopReason.toolUse,
        _ => AiStopReason.unknown,
      },
      inputTokens: usage?['input_tokens'] as int? ?? 0,
      outputTokens: usage?['output_tokens'] as int? ?? 0,
    );
  }
}
