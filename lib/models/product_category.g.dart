// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductCategory _$ProductCategoryFromJson(Map<String, dynamic> json) =>
    _ProductCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
      createdBy: json['createdBy'] as String,
      updatedBy: json['updatedBy'] as String,
      ownerId: json['ownerId'] as String?,
      isGlobal: json['isGlobal'] as bool? ?? false,
      emoji: json['emoji'] as String? ?? '📦',
      colorHex: json['colorHex'] as String? ?? 'FF6C63FF',
      localizationKey: json['localizationKey'] as String? ?? '',
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
      deletedAt: const NullableTimestampConverter().fromJson(json['deletedAt']),
      version: (json['version'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$ProductCategoryToJson(
  _ProductCategory instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
  'createdBy': instance.createdBy,
  'updatedBy': instance.updatedBy,
  'ownerId': instance.ownerId,
  'isGlobal': instance.isGlobal,
  'emoji': instance.emoji,
  'colorHex': instance.colorHex,
  'localizationKey': instance.localizationKey,
  'sortOrder': instance.sortOrder,
  'deletedAt': const NullableTimestampConverter().toJson(instance.deletedAt),
  'version': instance.version,
};
