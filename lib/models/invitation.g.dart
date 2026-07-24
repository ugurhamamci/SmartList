// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Invitation _$InvitationFromJson(Map<String, dynamic> json) => _Invitation(
  id: json['id'] as String,
  listId: json['listId'] as String,
  inviteeEmail: json['inviteeEmail'] as String,
  invitedBy: json['invitedBy'] as String,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
  createdBy: json['createdBy'] as String,
  updatedBy: json['updatedBy'] as String,
  role:
      $enumDecodeNullable(_$MemberRoleEnumMap, json['role']) ??
      MemberRole.editor,
  status:
      $enumDecodeNullable(_$InvitationStatusEnumMap, json['status']) ??
      InvitationStatus.pending,
  inviteeId: json['inviteeId'] as String?,
  listTitle: json['listTitle'] as String? ?? '',
  listEmoji: json['listEmoji'] as String? ?? '🛒',
  inviterName: json['inviterName'] as String? ?? '',
  inviterPhotoUrl: json['inviterPhotoUrl'] as String?,
  respondedAt: const NullableTimestampConverter().fromJson(json['respondedAt']),
  revokedAt: const NullableTimestampConverter().fromJson(json['revokedAt']),
  expiresAt: const NullableTimestampConverter().fromJson(json['expiresAt']),
  deletedAt: const NullableTimestampConverter().fromJson(json['deletedAt']),
  version: (json['version'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$InvitationToJson(
  _Invitation instance,
) => <String, dynamic>{
  'id': instance.id,
  'listId': instance.listId,
  'inviteeEmail': instance.inviteeEmail,
  'invitedBy': instance.invitedBy,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
  'createdBy': instance.createdBy,
  'updatedBy': instance.updatedBy,
  'role': _$MemberRoleEnumMap[instance.role]!,
  'status': _$InvitationStatusEnumMap[instance.status]!,
  'inviteeId': instance.inviteeId,
  'listTitle': instance.listTitle,
  'listEmoji': instance.listEmoji,
  'inviterName': instance.inviterName,
  'inviterPhotoUrl': instance.inviterPhotoUrl,
  'respondedAt': const NullableTimestampConverter().toJson(
    instance.respondedAt,
  ),
  'revokedAt': const NullableTimestampConverter().toJson(instance.revokedAt),
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

const _$InvitationStatusEnumMap = {
  InvitationStatus.pending: 'pending',
  InvitationStatus.accepted: 'accepted',
  InvitationStatus.declined: 'declined',
  InvitationStatus.revoked: 'revoked',
  InvitationStatus.expired: 'expired',
};
