// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => _ChatMessage(
  id: json['id'] as String,
  roomId: json['roomId'] as String,
  senderId: json['senderId'] as String,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
  createdBy: json['createdBy'] as String,
  updatedBy: json['updatedBy'] as String,
  type:
      $enumDecodeNullable(_$MessageTypeEnumMap, json['type']) ??
      MessageType.text,
  body: json['body'] as String? ?? '',
  senderName: json['senderName'] as String? ?? '',
  senderPhotoUrl: json['senderPhotoUrl'] as String?,
  attachmentUrl: json['attachmentUrl'] as String?,
  attachmentPath: json['attachmentPath'] as String?,
  attachmentSizeBytes: (json['attachmentSizeBytes'] as num?)?.toInt() ?? 0,
  voiceDuration: const NullableDurationConverter().fromJson(
    (json['voiceDuration'] as num?)?.toInt(),
  ),
  waveform:
      (json['waveform'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList() ??
      const <double>[],
  imageWidth: (json['imageWidth'] as num?)?.toInt(),
  imageHeight: (json['imageHeight'] as num?)?.toInt(),
  readBy: json['readBy'] == null
      ? const <String, DateTime>{}
      : const TimestampMapConverter().fromJson(json['readBy']),
  reactions:
      (json['reactions'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const <String, String>{},
  mentions:
      (json['mentions'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  replyToMessageId: json['replyToMessageId'] as String?,
  replyToPreview: json['replyToPreview'] as String? ?? '',
  isEdited: json['isEdited'] as bool? ?? false,
  editedAt: const NullableTimestampConverter().fromJson(json['editedAt']),
  systemAction: $enumDecodeNullable(
    _$ActivityActionEnumMap,
    json['systemAction'],
  ),
  systemParams:
      (json['systemParams'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const <String, String>{},
  deletedAt: const NullableTimestampConverter().fromJson(json['deletedAt']),
  version: (json['version'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$ChatMessageToJson(
  _ChatMessage instance,
) => <String, dynamic>{
  'id': instance.id,
  'roomId': instance.roomId,
  'senderId': instance.senderId,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
  'createdBy': instance.createdBy,
  'updatedBy': instance.updatedBy,
  'type': _$MessageTypeEnumMap[instance.type]!,
  'body': instance.body,
  'senderName': instance.senderName,
  'senderPhotoUrl': instance.senderPhotoUrl,
  'attachmentUrl': instance.attachmentUrl,
  'attachmentPath': instance.attachmentPath,
  'attachmentSizeBytes': instance.attachmentSizeBytes,
  'voiceDuration': const NullableDurationConverter().toJson(
    instance.voiceDuration,
  ),
  'waveform': instance.waveform,
  'imageWidth': instance.imageWidth,
  'imageHeight': instance.imageHeight,
  'readBy': const TimestampMapConverter().toJson(instance.readBy),
  'reactions': instance.reactions,
  'mentions': instance.mentions,
  'replyToMessageId': instance.replyToMessageId,
  'replyToPreview': instance.replyToPreview,
  'isEdited': instance.isEdited,
  'editedAt': const NullableTimestampConverter().toJson(instance.editedAt),
  'systemAction': _$ActivityActionEnumMap[instance.systemAction],
  'systemParams': instance.systemParams,
  'deletedAt': const NullableTimestampConverter().toJson(instance.deletedAt),
  'version': instance.version,
};

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
  MessageType.image: 'image',
  MessageType.voice: 'voice',
  MessageType.system: 'system',
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
