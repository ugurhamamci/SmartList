// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppNotification _$AppNotificationFromJson(Map<String, dynamic> json) =>
    _AppNotification(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
      createdBy: json['createdBy'] as String,
      updatedBy: json['updatedBy'] as String,
      params:
          (json['params'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const <String, String>{},
      isRead: json['isRead'] as bool? ?? false,
      readAt: const NullableTimestampConverter().fromJson(json['readAt']),
      listId: json['listId'] as String?,
      itemId: json['itemId'] as String?,
      messageId: json['messageId'] as String?,
      invitationId: json['invitationId'] as String?,
      actorId: json['actorId'] as String?,
      actorName: json['actorName'] as String? ?? '',
      actorPhotoUrl: json['actorPhotoUrl'] as String?,
      deletedAt: const NullableTimestampConverter().fromJson(json['deletedAt']),
      version: (json['version'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$AppNotificationToJson(
  _AppNotification instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'type': _$NotificationTypeEnumMap[instance.type]!,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
  'createdBy': instance.createdBy,
  'updatedBy': instance.updatedBy,
  'params': instance.params,
  'isRead': instance.isRead,
  'readAt': const NullableTimestampConverter().toJson(instance.readAt),
  'listId': instance.listId,
  'itemId': instance.itemId,
  'messageId': instance.messageId,
  'invitationId': instance.invitationId,
  'actorId': instance.actorId,
  'actorName': instance.actorName,
  'actorPhotoUrl': instance.actorPhotoUrl,
  'deletedAt': const NullableTimestampConverter().toJson(instance.deletedAt),
  'version': instance.version,
};

const _$NotificationTypeEnumMap = {
  NotificationType.invitationReceived: 'invitation_received',
  NotificationType.invitationAccepted: 'invitation_accepted',
  NotificationType.itemAdded: 'item_added',
  NotificationType.itemDeleted: 'item_deleted',
  NotificationType.itemCompleted: 'item_completed',
  NotificationType.listCompleted: 'list_completed',
  NotificationType.listShared: 'list_shared',
  NotificationType.memberJoined: 'member_joined',
  NotificationType.memberLeft: 'member_left',
  NotificationType.messageReceived: 'message_received',
  NotificationType.mention: 'mention',
  NotificationType.reminder: 'reminder',
  NotificationType.system: 'system',
};
