// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SharedLink _$SharedLinkFromJson(Map<String, dynamic> json) => _SharedLink(
  id: json['id'] as String,
  listId: json['listId'] as String,
  role: $enumDecode(_$MemberRoleEnumMap, json['role']),
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
  createdBy: json['createdBy'] as String,
  updatedBy: json['updatedBy'] as String,
  slug: json['slug'] as String,
  isActive: json['isActive'] as bool? ?? true,
  listTitle: json['listTitle'] as String? ?? '',
  listEmoji: json['listEmoji'] as String? ?? '🛒',
  useCount: (json['useCount'] as num?)?.toInt() ?? 0,
  maxUses: (json['maxUses'] as num?)?.toInt(),
  expiresAt: const NullableTimestampConverter().fromJson(json['expiresAt']),
  deletedAt: const NullableTimestampConverter().fromJson(json['deletedAt']),
  version: (json['version'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$SharedLinkToJson(
  _SharedLink instance,
) => <String, dynamic>{
  'id': instance.id,
  'listId': instance.listId,
  'role': _$MemberRoleEnumMap[instance.role]!,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
  'createdBy': instance.createdBy,
  'updatedBy': instance.updatedBy,
  'slug': instance.slug,
  'isActive': instance.isActive,
  'listTitle': instance.listTitle,
  'listEmoji': instance.listEmoji,
  'useCount': instance.useCount,
  'maxUses': instance.maxUses,
  'expiresAt': const NullableTimestampConverter().toJson(instance.expiresAt),
  'deletedAt': const NullableTimestampConverter().toJson(instance.deletedAt),
  'version': instance.version,
};

const _$MemberRoleEnumMap = {
  MemberRole.owner: 'owner',
  MemberRole.editor: 'editor',
  MemberRole.viewer: 'viewer',
  MemberRole.guest: 'guest',
};
