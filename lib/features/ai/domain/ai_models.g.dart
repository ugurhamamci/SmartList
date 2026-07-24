// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AiMessage _$AiMessageFromJson(Map<String, dynamic> json) => _AiMessage(
  role: $enumDecode(_$AiMessageRoleEnumMap, json['role']),
  content: json['content'] as String,
);

Map<String, dynamic> _$AiMessageToJson(_AiMessage instance) =>
    <String, dynamic>{
      'role': _$AiMessageRoleEnumMap[instance.role]!,
      'content': instance.content,
    };

const _$AiMessageRoleEnumMap = {
  AiMessageRole.system: 'system',
  AiMessageRole.user: 'user',
  AiMessageRole.assistant: 'assistant',
};

_AiRequest _$AiRequestFromJson(Map<String, dynamic> json) => _AiRequest(
  messages: (json['messages'] as List<dynamic>)
      .map((e) => AiMessage.fromJson(e as Map<String, dynamic>))
      .toList(),
  systemPrompt: json['systemPrompt'] as String?,
  maxTokens: (json['maxTokens'] as num?)?.toInt() ?? 4096,
  jsonSchema: json['jsonSchema'] as Map<String, dynamic>?,
  temperature: (json['temperature'] as num?)?.toDouble(),
  model: json['model'] as String?,
);

Map<String, dynamic> _$AiRequestToJson(_AiRequest instance) =>
    <String, dynamic>{
      'messages': instance.messages,
      'systemPrompt': instance.systemPrompt,
      'maxTokens': instance.maxTokens,
      'jsonSchema': instance.jsonSchema,
      'temperature': instance.temperature,
      'model': instance.model,
    };

_AiResponse _$AiResponseFromJson(Map<String, dynamic> json) => _AiResponse(
  text: json['text'] as String,
  provider: $enumDecode(_$AiProviderKindEnumMap, json['provider']),
  model: json['model'] as String,
  stopReason:
      $enumDecodeNullable(_$AiStopReasonEnumMap, json['stopReason']) ??
      AiStopReason.completed,
  inputTokens: (json['inputTokens'] as num?)?.toInt() ?? 0,
  outputTokens: (json['outputTokens'] as num?)?.toInt() ?? 0,
  refusalCategory: json['refusalCategory'] as String?,
);

Map<String, dynamic> _$AiResponseToJson(_AiResponse instance) =>
    <String, dynamic>{
      'text': instance.text,
      'provider': _$AiProviderKindEnumMap[instance.provider]!,
      'model': instance.model,
      'stopReason': _$AiStopReasonEnumMap[instance.stopReason]!,
      'inputTokens': instance.inputTokens,
      'outputTokens': instance.outputTokens,
      'refusalCategory': instance.refusalCategory,
    };

const _$AiProviderKindEnumMap = {
  AiProviderKind.openAi: 'openai',
  AiProviderKind.gemini: 'gemini',
  AiProviderKind.claude: 'claude',
};

const _$AiStopReasonEnumMap = {
  AiStopReason.completed: 'completed',
  AiStopReason.maxTokens: 'max_tokens',
  AiStopReason.refusal: 'refusal',
  AiStopReason.toolUse: 'tool_use',
  AiStopReason.unknown: 'unknown',
};

_GeneratedItem _$GeneratedItemFromJson(Map<String, dynamic> json) =>
    _GeneratedItem(
      name: json['name'] as String,
      quantity: json['quantity'] == null
          ? 1
          : const FlexibleDoubleConverter().fromJson(json['quantity']),
      unit:
          $enumDecodeNullable(_$MeasurementUnitEnumMap, json['unit']) ??
          MeasurementUnit.piece,
      category: json['category'] as String? ?? '',
      notes: json['notes'] as String? ?? '',
      priority:
          $enumDecodeNullable(_$ItemPriorityEnumMap, json['priority']) ??
          ItemPriority.normal,
      estimatedPrice: const NullableDoubleConverter().fromJson(
        json['estimatedPrice'],
      ),
    );

Map<String, dynamic> _$GeneratedItemToJson(_GeneratedItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'quantity': const FlexibleDoubleConverter().toJson(instance.quantity),
      'unit': _$MeasurementUnitEnumMap[instance.unit]!,
      'category': instance.category,
      'notes': instance.notes,
      'priority': _$ItemPriorityEnumMap[instance.priority]!,
      'estimatedPrice': const NullableDoubleConverter().toJson(
        instance.estimatedPrice,
      ),
    };

const _$MeasurementUnitEnumMap = {
  MeasurementUnit.piece: 'piece',
  MeasurementUnit.gram: 'g',
  MeasurementUnit.kilogram: 'kg',
  MeasurementUnit.milliliter: 'ml',
  MeasurementUnit.liter: 'l',
  MeasurementUnit.pack: 'pack',
  MeasurementUnit.box: 'box',
  MeasurementUnit.bottle: 'bottle',
  MeasurementUnit.can: 'can',
  MeasurementUnit.bag: 'bag',
  MeasurementUnit.bunch: 'bunch',
  MeasurementUnit.dozen: 'dozen',
  MeasurementUnit.ounce: 'oz',
  MeasurementUnit.pound: 'lb',
  MeasurementUnit.fluidOunce: 'fl_oz',
  MeasurementUnit.gallon: 'gal',
};

const _$ItemPriorityEnumMap = {
  ItemPriority.low: 'low',
  ItemPriority.normal: 'normal',
  ItemPriority.high: 'high',
  ItemPriority.urgent: 'urgent',
};

_GeneratedList _$GeneratedListFromJson(Map<String, dynamic> json) =>
    _GeneratedList(
      title: json['title'] as String,
      kind: $enumDecode(_$AiListKindEnumMap, json['kind']),
      description: json['description'] as String? ?? '',
      emoji: json['emoji'] as String? ?? '🛒',
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => GeneratedItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <GeneratedItem>[],
      estimatedTotal: const NullableDoubleConverter().fromJson(
        json['estimatedTotal'],
      ),
      currency: json['currency'] as String? ?? 'USD',
      rationale: json['rationale'] as String? ?? '',
    );

Map<String, dynamic> _$GeneratedListToJson(_GeneratedList instance) =>
    <String, dynamic>{
      'title': instance.title,
      'kind': _$AiListKindEnumMap[instance.kind]!,
      'description': instance.description,
      'emoji': instance.emoji,
      'items': instance.items,
      'estimatedTotal': const NullableDoubleConverter().toJson(
        instance.estimatedTotal,
      ),
      'currency': instance.currency,
      'rationale': instance.rationale,
    };

const _$AiListKindEnumMap = {
  AiListKind.weeklyShopping: 'weekly_shopping',
  AiListKind.mealPlan: 'meal_plan',
  AiListKind.party: 'party',
  AiListKind.baby: 'baby',
  AiListKind.diet: 'diet',
  AiListKind.custom: 'custom',
};

_GenerationBrief _$GenerationBriefFromJson(Map<String, dynamic> json) =>
    _GenerationBrief(
      kind: $enumDecode(_$AiListKindEnumMap, json['kind']),
      prompt: json['prompt'] as String? ?? '',
      peopleCount: (json['peopleCount'] as num?)?.toInt() ?? 1,
      days: (json['days'] as num?)?.toInt() ?? 7,
      currency: json['currency'] as String? ?? 'USD',
      budget: const NullableDoubleConverter().fromJson(json['budget']),
      restrictions:
          (json['restrictions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      preferences:
          (json['preferences'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      pantryItems:
          (json['pantryItems'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      localeCode: json['localeCode'] as String? ?? 'en',
      measurementSystem:
          $enumDecodeNullable(
            _$MeasurementSystemEnumMap,
            json['measurementSystem'],
          ) ??
          MeasurementSystem.metric,
      babyAgeMonths: (json['babyAgeMonths'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GenerationBriefToJson(
  _GenerationBrief instance,
) => <String, dynamic>{
  'kind': _$AiListKindEnumMap[instance.kind]!,
  'prompt': instance.prompt,
  'peopleCount': instance.peopleCount,
  'days': instance.days,
  'currency': instance.currency,
  'budget': const NullableDoubleConverter().toJson(instance.budget),
  'restrictions': instance.restrictions,
  'preferences': instance.preferences,
  'pantryItems': instance.pantryItems,
  'localeCode': instance.localeCode,
  'measurementSystem': _$MeasurementSystemEnumMap[instance.measurementSystem]!,
  'babyAgeMonths': instance.babyAgeMonths,
};

const _$MeasurementSystemEnumMap = {
  MeasurementSystem.metric: 'metric',
  MeasurementSystem.imperial: 'imperial',
};
