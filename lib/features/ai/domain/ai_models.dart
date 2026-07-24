import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:smartlist/core/utils/json_converters.dart';
import 'package:smartlist/models/enums.dart';

part 'ai_models.freezed.dart';
part 'ai_models.g.dart';

/// One turn in a provider-agnostic conversation.
@freezed
abstract class AiMessage with _$AiMessage {
  const factory AiMessage({
    required AiMessageRole role,
    required String content,
  }) = _AiMessage;

  factory AiMessage.fromJson(Map<String, dynamic> json) =>
      _$AiMessageFromJson(json);

  factory AiMessage.system(String content) =>
      AiMessage(role: AiMessageRole.system, content: content);

  factory AiMessage.user(String content) =>
      AiMessage(role: AiMessageRole.user, content: content);

  factory AiMessage.assistant(String content) =>
      AiMessage(role: AiMessageRole.assistant, content: content);
}

/// A completion request expressed independently of any vendor.
///
/// [jsonSchema] requests a structured response. Every provider enforces it with
/// its own mechanism — Anthropic's `output_config.format`, OpenAI's
/// `response_format`, Gemini's `responseSchema` — so call sites never branch on
/// the active vendor.
@freezed
abstract class AiRequest with _$AiRequest {
  const factory AiRequest({
    required List<AiMessage> messages,

    /// Instruction turn hoisted out of [messages]; providers that carry a
    /// dedicated system field use it, the rest prepend it.
    String? systemPrompt,
    @Default(4096) int maxTokens,

    /// JSON Schema the response must satisfy. Null requests free-form text.
    Map<String, dynamic>? jsonSchema,

    /// Sampling temperature. Ignored by providers that reject it — notably
    /// Claude Opus 5, which returns HTTP 400 if the field is present.
    double? temperature,

    /// Overrides the provider's configured default model.
    String? model,
  }) = _AiRequest;

  factory AiRequest.fromJson(Map<String, dynamic> json) =>
      _$AiRequestFromJson(json);
}

/// Why a provider stopped generating.
@JsonEnum(valueField: 'wire')
enum AiStopReason {
  completed('completed'),

  /// The output token ceiling was reached; the payload may be truncated.
  maxTokens('max_tokens'),

  /// The provider's safety systems declined the request.
  refusal('refusal'),
  toolUse('tool_use'),
  unknown('unknown');

  const AiStopReason(this.wire);

  final String wire;
}

/// A normalised completion.
@freezed
abstract class AiResponse with _$AiResponse {
  const factory AiResponse({
    required String text,
    required AiProviderKind provider,
    required String model,
    @Default(AiStopReason.completed) AiStopReason stopReason,
    @Default(0) int inputTokens,
    @Default(0) int outputTokens,

    /// Populated when [stopReason] is [AiStopReason.refusal].
    String? refusalCategory,
  }) = _AiResponse;

  factory AiResponse.fromJson(Map<String, dynamic> json) =>
      _$AiResponseFromJson(json);
}

/// Derived properties of an [AiResponse].
extension AiResponseX on AiResponse {
  bool get isRefusal => stopReason == AiStopReason.refusal;

  bool get isTruncated => stopReason == AiStopReason.maxTokens;

  int get totalTokens => inputTokens + outputTokens;
}

/// One product proposed by the generator, before it becomes a `ShoppingItem`.
@freezed
abstract class GeneratedItem with _$GeneratedItem {
  const factory GeneratedItem({
    required String name,
    @Default(1) @FlexibleDoubleConverter() double quantity,
    @Default(MeasurementUnit.piece) MeasurementUnit unit,

    /// Category name as proposed by the model; resolved against the category
    /// collection before the item is written.
    @Default('') String category,
    @Default('') String notes,
    @Default(ItemPriority.normal) ItemPriority priority,
    @NullableDoubleConverter() double? estimatedPrice,
  }) = _GeneratedItem;

  factory GeneratedItem.fromJson(Map<String, dynamic> json) =>
      _$GeneratedItemFromJson(json);
}

/// A complete list proposed by the generator, held for user review before
/// anything is written to Firestore.
@freezed
abstract class GeneratedList with _$GeneratedList {
  const factory GeneratedList({
    required String title,
    required AiListKind kind,
    @Default('') String description,
    @Default('🛒') String emoji,
    @Default(<GeneratedItem>[]) List<GeneratedItem> items,
    @NullableDoubleConverter() double? estimatedTotal,
    @Default('USD') String currency,

    /// Short rationale the model gives for its choices, shown on the review
    /// sheet so the suggestion is auditable rather than opaque.
    @Default('') String rationale,
  }) = _GeneratedList;

  factory GeneratedList.fromJson(Map<String, dynamic> json) =>
      _$GeneratedListFromJson(json);
}

/// Derived properties of a [GeneratedList].
extension GeneratedListX on GeneratedList {
  int get itemCount => items.length;

  bool get isEmpty => items.isEmpty;

  /// Sum of the per-line estimates, or `null` when no line carries a price.
  double? get computedTotal {
    final priced = items.where((item) => item.estimatedPrice != null);
    if (priced.isEmpty) {
      return null;
    }
    return priced.fold<double>(
      0,
      (total, item) => total + item.estimatedPrice! * item.quantity,
    );
  }
}

/// Inputs the user supplies when asking for a generated list.
@freezed
abstract class GenerationBrief with _$GenerationBrief {
  const factory GenerationBrief({
    required AiListKind kind,

    /// Free-text request, used verbatim for [AiListKind.custom].
    @Default('') String prompt,
    @Default(1) int peopleCount,
    @Default(7) int days,
    @Default('USD') String currency,
    @NullableDoubleConverter() double? budget,

    /// Dietary restrictions and allergies to respect.
    @Default(<String>[]) List<String> restrictions,

    /// Cuisines, brands or products the user prefers.
    @Default(<String>[]) List<String> preferences,

    /// Products already at home, which must not be suggested again.
    @Default(<String>[]) List<String> pantryItems,
    @Default('en') String localeCode,
    @Default(MeasurementSystem.metric) MeasurementSystem measurementSystem,

    /// Age in months, for [AiListKind.baby].
    int? babyAgeMonths,
  }) = _GenerationBrief;

  factory GenerationBrief.fromJson(Map<String, dynamic> json) =>
      _$GenerationBriefFromJson(json);
}
