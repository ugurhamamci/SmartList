// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ListMember _$ListMemberFromJson(Map<String, dynamic> json) => _ListMember(
  id: json['id'] as String,
  userId: json['userId'] as String,
  listId: json['listId'] as String,
  role: $enumDecode(_$MemberRoleEnumMap, json['role']),
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
  createdBy: json['createdBy'] as String,
  updatedBy: json['updatedBy'] as String,
  displayName: json['displayName'] as String? ?? '',
  email: json['email'] as String? ?? '',
  photoUrl: json['photoUrl'] as String?,
  joinedAt: const NullableTimestampConverter().fromJson(json['joinedAt']),
  invitedBy: json['invitedBy'] as String?,
  itemsAdded: (json['itemsAdded'] as num?)?.toInt() ?? 0,
  itemsCompleted: (json['itemsCompleted'] as num?)?.toInt() ?? 0,
  deletedAt: const NullableTimestampConverter().fromJson(json['deletedAt']),
  version: (json['version'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$ListMemberToJson(
  _ListMember instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'listId': instance.listId,
  'role': _$MemberRoleEnumMap[instance.role]!,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
  'createdBy': instance.createdBy,
  'updatedBy': instance.updatedBy,
  'displayName': instance.displayName,
  'email': instance.email,
  'photoUrl': instance.photoUrl,
  'joinedAt': const NullableTimestampConverter().toJson(instance.joinedAt),
  'invitedBy': instance.invitedBy,
  'itemsAdded': instance.itemsAdded,
  'itemsCompleted': instance.itemsCompleted,
  'deletedAt': const NullableTimestampConverter().toJson(instance.deletedAt),
  'version': instance.version,
};

const _$MemberRoleEnumMap = {
  MemberRole.owner: 'owner',
  MemberRole.editor: 'editor',
  MemberRole.viewer: 'viewer',
  MemberRole.guest: 'guest',
};
