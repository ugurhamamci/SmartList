// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TemplateItem _$TemplateItemFromJson(Map<String, dynamic> json) =>
    _TemplateItem(
      name: json['name'] as String,
      quantity: json['quantity'] == null
          ? 1
          : const FlexibleDoubleConverter().fromJson(json['quantity']),
      unit:
          $enumDecodeNullable(_$MeasurementUnitEnumMap, json['unit']) ??
          MeasurementUnit.piece,
      categoryId: json['categoryId'] as String?,
      notes: json['notes'] as String? ?? '',
      priority:
          $enumDecodeNullable(_$ItemPriorityEnumMap, json['priority']) ??
          ItemPriority.normal,
      estimatedPrice: const NullableDoubleConverter().fromJson(
        json['estimatedPrice'],
      ),
      sortOrder: json['sortOrder'] == null
          ? 0
          : const FlexibleDoubleConverter().fromJson(json['sortOrder']),
    );

Map<String, dynamic> _$TemplateItemToJson(_TemplateItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'quantity': const FlexibleDoubleConverter().toJson(instance.quantity),
      'unit': _$MeasurementUnitEnumMap[instance.unit]!,
      'categoryId': instance.categoryId,
      'notes': instance.notes,
      'priority': _$ItemPriorityEnumMap[instance.priority]!,
      'estimatedPrice': const NullableDoubleConverter().toJson(
        instance.estimatedPrice,
      ),
      'sortOrder': const FlexibleDoubleConverter().toJson(instance.sortOrder),
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

_ShoppingTemplate _$ShoppingTemplateFromJson(Map<String, dynamic> json) =>
    _ShoppingTemplate(
      id: json['id'] as String,
      name: json['name'] as String,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
      createdBy: json['createdBy'] as String,
      updatedBy: json['updatedBy'] as String,
      ownerId: json['ownerId'] as String?,
      isPublic: json['isPublic'] as bool? ?? false,
      description: json['description'] as String? ?? '',
      emoji: json['emoji'] as String? ?? '🛒',
      colorHex: json['colorHex'] as String? ?? 'FF6C63FF',
      category: json['category'] as String? ?? '',
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => TemplateItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TemplateItem>[],
      usageCount: (json['usageCount'] as num?)?.toInt() ?? 0,
      generatedFrom: $enumDecodeNullable(
        _$AiListKindEnumMap,
        json['generatedFrom'],
      ),
      deletedAt: const NullableTimestampConverter().fromJson(json['deletedAt']),
      version: (json['version'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$ShoppingTemplateToJson(
  _ShoppingTemplate instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
  'createdBy': instance.createdBy,
  'updatedBy': instance.updatedBy,
  'ownerId': instance.ownerId,
  'isPublic': instance.isPublic,
  'description': instance.description,
  'emoji': instance.emoji,
  'colorHex': instance.colorHex,
  'category': instance.category,
  'items': instance.items,
  'usageCount': instance.usageCount,
  'generatedFrom': _$AiListKindEnumMap[instance.generatedFrom],
  'deletedAt': const NullableTimestampConverter().toJson(instance.deletedAt),
  'version': instance.version,
};

const _$AiListKindEnumMap = {
  AiListKind.weeklyShopping: 'weekly_shopping',
  AiListKind.mealPlan: 'meal_plan',
  AiListKind.party: 'party',
  AiListKind.baby: 'baby',
  AiListKind.diet: 'diet',
  AiListKind.custom: 'custom',
};
