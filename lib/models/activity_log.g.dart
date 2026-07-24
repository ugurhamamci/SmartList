// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActivityLog _$ActivityLogFromJson(Map<String, dynamic> json) => _ActivityLog(
  id: json['id'] as String,
  listId: json['listId'] as String,
  actorId: json['actorId'] as String,
  action: $enumDecode(_$ActivityActionEnumMap, json['action']),
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  actorName: json['actorName'] as String? ?? '',
  actorPhotoUrl: json['actorPhotoUrl'] as String?,
  targetId: json['targetId'] as String?,
  targetName: json['targetName'] as String? ?? '',
  metadata:
      (json['metadata'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const <String, String>{},
);

Map<String, dynamic> _$ActivityLogToJson(_ActivityLog instance) =>
    <String, dynamic>{
      'id': instance.id,
      'listId': instance.listId,
      'actorId': instance.actorId,
      'action': _$ActivityActionEnumMap[instance.action]!,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'actorName': instance.actorName,
      'actorPhotoUrl': instance.actorPhotoUrl,
      'targetId': instance.targetId,
      'targetName': instance.targetName,
      'metadata': instance.metadata,
    };

const _$ActivityActionEnumMap = {
  ActivityAction.listCreated: 'list_created',
  ActivityAction.listUpdated: 'list_updated',
  ActivityAction.listArchived: 'list_archived',
  ActivityAction.listUnarchived: 'list_unarchived',
  ActivityAction.listDeleted: 'list_deleted',
  ActivityAction.listDuplicated: 'list_duplicated',
  ActivityAction.listCompleted: 'list_completed',
  ActivityAction.itemAdded: 'item_added',
  ActivityAction.itemUpdated: 'item_updated',
  ActivityAction.itemCompleted: 'item_completed',
  ActivityAction.itemUncompleted: 'item_uncompleted',
  ActivityAction.itemDeleted: 'item_deleted',
  ActivityAction.itemReordered: 'item_reordered',
  ActivityAction.memberInvited: 'member_invited',
  ActivityAction.memberJoined: 'member_joined',
  ActivityAction.memberRemoved: 'member_removed',
  ActivityAction.memberLeft: 'member_left',
  ActivityAction.memberRoleChanged: 'member_role_changed',
  ActivityAction.messageSent: 'message_sent',
  ActivityAction.aiGenerated: 'ai_generated',
};
