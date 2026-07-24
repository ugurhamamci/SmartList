// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShoppingItem _$ShoppingItemFromJson(
  Map<String, dynamic> json,
) => _ShoppingItem(
  id: json['id'] as String,
  listId: json['listId'] as String,
  name: json['name'] as String,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
  createdBy: json['createdBy'] as String,
  updatedBy: json['updatedBy'] as String,
  quantity: json['quantity'] == null
      ? 1
      : const FlexibleDoubleConverter().fromJson(json['quantity']),
  unit:
      $enumDecodeNullable(_$MeasurementUnitEnumMap, json['unit']) ??
      MeasurementUnit.piece,
  categoryId: json['categoryId'] as String?,
  notes: json['notes'] as String? ?? '',
  price: const NullableDoubleConverter().fromJson(json['price']),
  currency: json['currency'] as String? ?? 'USD',
  priority:
      $enumDecodeNullable(_$ItemPriorityEnumMap, json['priority']) ??
      ItemPriority.normal,
  isCompleted: json['isCompleted'] as bool? ?? false,
  completedAt: const NullableTimestampConverter().fromJson(json['completedAt']),
  purchasedBy: json['purchasedBy'] as String?,
  purchasedAt: const NullableTimestampConverter().fromJson(json['purchasedAt']),
  imageUrl: json['imageUrl'] as String?,
  barcode: json['barcode'] as String?,
  barcodeFormat: $enumDecodeNullable(
    _$BarcodeSymbologyEnumMap,
    json['barcodeFormat'],
  ),
  sortOrder: json['sortOrder'] == null
      ? 0
      : const FlexibleDoubleConverter().fromJson(json['sortOrder']),
  source:
      $enumDecodeNullable(_$ItemSourceEnumMap, json['source']) ??
      ItemSource.manual,
  brand: json['brand'] as String?,
  deletedAt: const NullableTimestampConverter().fromJson(json['deletedAt']),
  version: (json['version'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$ShoppingItemToJson(
  _ShoppingItem instance,
) => <String, dynamic>{
  'id': instance.id,
  'listId': instance.listId,
  'name': instance.name,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
  'createdBy': instance.createdBy,
  'updatedBy': instance.updatedBy,
  'quantity': const FlexibleDoubleConverter().toJson(instance.quantity),
  'unit': _$MeasurementUnitEnumMap[instance.unit]!,
  'categoryId': instance.categoryId,
  'notes': instance.notes,
  'price': const NullableDoubleConverter().toJson(instance.price),
  'currency': instance.currency,
  'priority': _$ItemPriorityEnumMap[instance.priority]!,
  'isCompleted': instance.isCompleted,
  'completedAt': const NullableTimestampConverter().toJson(
    instance.completedAt,
  ),
  'purchasedBy': instance.purchasedBy,
  'purchasedAt': const NullableTimestampConverter().toJson(
    instance.purchasedAt,
  ),
  'imageUrl': instance.imageUrl,
  'barcode': instance.barcode,
  'barcodeFormat': _$BarcodeSymbologyEnumMap[instance.barcodeFormat],
  'sortOrder': const FlexibleDoubleConverter().toJson(instance.sortOrder),
  'source': _$ItemSourceEnumMap[instance.source]!,
  'brand': instance.brand,
  'deletedAt': const NullableTimestampConverter().toJson(instance.deletedAt),
  'version': instance.version,
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

const _$BarcodeSymbologyEnumMap = {
  BarcodeSymbology.ean13: 'ean13',
  BarcodeSymbology.ean8: 'ean8',
  BarcodeSymbology.upcA: 'upc_a',
  BarcodeSymbology.upcE: 'upc_e',
  BarcodeSymbology.qr: 'qr',
  BarcodeSymbology.isbn: 'isbn',
  BarcodeSymbology.code128: 'code128',
  BarcodeSymbology.code39: 'code39',
  BarcodeSymbology.itf: 'itf',
  BarcodeSymbology.dataMatrix: 'data_matrix',
  BarcodeSymbology.unknown: 'unknown',
};

const _$ItemSourceEnumMap = {
  ItemSource.manual: 'manual',
  ItemSource.voice: 'voice',
  ItemSource.barcode: 'barcode',
  ItemSource.ai: 'ai',
  ItemSource.template: 'template',
  ItemSource.duplicate: 'duplicate',
};
