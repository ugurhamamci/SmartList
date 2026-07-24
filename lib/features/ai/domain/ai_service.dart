import 'dart:convert';

import 'package:smartlist/core/errors/app_exception.dart';
import 'package:smartlist/core/utils/app_logger.dart';
import 'package:smartlist/features/ai/domain/ai_models.dart';
import 'package:smartlist/features/ai/domain/ai_provider.dart';
import 'package:smartlist/features/ai/domain/prompt_builder.dart';
import 'package:smartlist/models/enums.dart';

/// Vendor-independent entry point for every AI capability.
///
/// Feature code depends on this class alone; the active vendor is resolved per
/// call from the user's preference through [AiProviderRegistry], so switching
/// providers is a settings change rather than a code change.
class AiService {
  const AiService(this._registry);

  final AiProviderRegistry _registry;

  /// Vendors currently available to the user.
  List<AiProviderKind> get availableProviders =>
      _registry.configured.map((provider) => provider.kind).toList();

  /// Generates a shopping list from [brief].
  ///
  /// [preferred] is the vendor chosen in settings; when it is unavailable the
  /// registry falls back to another configured vendor rather than failing.
  Future<GeneratedList> generateList(
    GenerationBrief brief, {
    AiProviderKind? preferred,
  }) async {
    final provider = _registry.resolve(preferred);
    if (provider == null) {
      throw const AiException(
        code: 'ai.no_provider',
        details: 'No AI provider is configured for this build.',
      );
    }

    final schema = PromptBuilder.responseSchema();
    final systemPrompt = provider.supportsStructuredOutput
        ? PromptBuilder.systemPrompt(brief)
        : '${PromptBuilder.systemPrompt(brief)}\n\n'
              '${PromptBuilder.schemaInstruction()}';

    final response = await provider.complete(
      AiRequest(
        systemPrompt: systemPrompt,
        messages: [AiMessage.user(PromptBuilder.userPrompt(brief))],
        jsonSchema: provider.supportsStructuredOutput ? schema : null,
        maxTokens: 8192,
      ),
    );

    if (response.isRefusal) {
      throw AiException(
        code: 'ai.refused',
        provider: provider.kind.wire,
        details: response.refusalCategory,
      );
    }
    if (response.isTruncated) {
      // A truncated payload cannot be parsed as JSON; surfacing it as
      // retryable lets the caller offer a narrower brief.
      throw AiException(
        code: 'ai.truncated',
        provider: provider.kind.wire,
        details: 'The response exceeded the output limit.',
      );
    }

    return _parseList(response.text, brief, provider.kind);
  }

  /// Parses a shopping list out of the model's reply.
  ///
  /// Tolerates a payload wrapped in prose or a fenced code block, which can
  /// happen on providers without enforced structured output.
  GeneratedList _parseList(
    String text,
    GenerationBrief brief,
    AiProviderKind provider,
  ) {
    final json = _extractJsonObject(text);
    if (json == null) {
      throw AiException(
        code: 'ai.unparseable',
        provider: provider.wire,
        details: 'The reply did not contain a JSON object.',
      );
    }

    try {
      final items = (json['items'] as List<dynamic>? ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(_parseItem)
          .whereType<GeneratedItem>()
          .toList();

      if (items.isEmpty) {
        throw AiException(
          code: 'ai.empty_list',
          provider: provider.wire,
          details: 'The reply contained no items.',
        );
      }

      final list = GeneratedList(
        title: (json['title'] as String?)?.trim().isNotEmpty ?? false
            ? (json['title'] as String).trim()
            : _fallbackTitle(brief.kind),
        kind: brief.kind,
        description: (json['description'] as String?)?.trim() ?? '',
        emoji: (json['emoji'] as String?)?.trim().isNotEmpty ?? false
            ? (json['emoji'] as String).trim()
            : _fallbackEmoji(brief.kind),
        rationale: (json['rationale'] as String?)?.trim() ?? '',
        items: items,
        currency: brief.currency,
      );

      return list.copyWith(estimatedTotal: list.computedTotal);
    } on AppException {
      rethrow;
    } catch (error, stackTrace) {
      throw AiException(
        code: 'ai.unparseable',
        provider: provider.wire,
        details: error.toString(),
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// Parses one item, skipping entries that lack a usable name rather than
  /// failing the whole generation.
  GeneratedItem? _parseItem(Map<String, dynamic> json) {
    final name = (json['name'] as String?)?.trim() ?? '';
    if (name.isEmpty) {
      AppLogger.warn('Skipping generated item with no name');
      return null;
    }

    final rawQuantity = json['quantity'];
    final quantity = switch (rawQuantity) {
      final num value when value > 0 => value.toDouble(),
      final String value => double.tryParse(value) ?? 1,
      _ => 1.0,
    };

    final rawPrice = json['estimatedPrice'];
    final price = switch (rawPrice) {
      final num value => value.toDouble(),
      final String value => double.tryParse(value),
      _ => null,
    };

    return GeneratedItem(
      name: name,
      quantity: quantity,
      unit: MeasurementUnit.fromWire(json['unit'] as String?),
      category: (json['category'] as String?)?.trim() ?? '',
      notes: (json['notes'] as String?)?.trim() ?? '',
      priority: ItemPriority.fromWire(json['priority'] as String?),
      estimatedPrice: price,
    );
  }

  /// Finds the outermost JSON object in [text], allowing for a fenced block or
  /// surrounding commentary.
  Map<String, dynamic>? _extractJsonObject(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) {
      return null;
    }

    final start = trimmed.indexOf('{');
    final end = trimmed.lastIndexOf('}');
    if (start == -1 || end <= start) {
      return null;
    }

    try {
      final decoded = jsonDecode(trimmed.substring(start, end + 1));
      return decoded is Map<String, dynamic> ? decoded : null;
    } on FormatException catch (error) {
      AppLogger.warn('Failed to decode AI JSON payload', error);
      return null;
    }
  }

  String _fallbackTitle(AiListKind kind) => switch (kind) {
    AiListKind.weeklyShopping => 'Weekly Shopping',
    AiListKind.mealPlan => 'Meal Plan',
    AiListKind.party => 'Party Shopping',
    AiListKind.baby => 'Baby Essentials',
    AiListKind.diet => 'Diet Plan',
    AiListKind.custom => 'Shopping List',
  };

  String _fallbackEmoji(AiListKind kind) => switch (kind) {
    AiListKind.weeklyShopping => '🛒',
    AiListKind.mealPlan => '🍽️',
    AiListKind.party => '🎉',
    AiListKind.baby => '🍼',
    AiListKind.diet => '🥗',
    AiListKind.custom => '📝',
  };
}
