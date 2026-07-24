// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatRoom _$ChatRoomFromJson(Map<String, dynamic> json) => _ChatRoom(
  id: json['id'] as String,
  listId: json['listId'] as String,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
  createdBy: json['createdBy'] as String,
  updatedBy: json['updatedBy'] as String,
  memberIds:
      (json['memberIds'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  messageCount: (json['messageCount'] as num?)?.toInt() ?? 0,
  lastMessagePreview: json['lastMessagePreview'] as String? ?? '',
  lastMessageSenderId: json['lastMessageSenderId'] as String?,
  lastMessageSenderName: json['lastMessageSenderName'] as String? ?? '',
  lastMessageType: $enumDecodeNullable(
    _$MessageTypeEnumMap,
    json['lastMessageType'],
  ),
  lastMessageAt: const NullableTimestampConverter().fromJson(
    json['lastMessageAt'],
  ),
  lastReadMessageIds:
      (json['lastReadMessageIds'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const <String, String>{},
  lastReadAt: json['lastReadAt'] == null
      ? const <String, DateTime>{}
      : const TimestampMapConverter().fromJson(json['lastReadAt']),
  deletedAt: const NullableTimestampConverter().fromJson(json['deletedAt']),
  version: (json['version'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$ChatRoomToJson(_ChatRoom instance) => <String, dynamic>{
  'id': instance.id,
  'listId': instance.listId,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
  'createdBy': instance.createdBy,
  'updatedBy': instance.updatedBy,
  'memberIds': instance.memberIds,
  'messageCount': instance.messageCount,
  'lastMessagePreview': instance.lastMessagePreview,
  'lastMessageSenderId': instance.lastMessageSenderId,
  'lastMessageSenderName': instance.lastMessageSenderName,
  'lastMessageType': _$MessageTypeEnumMap[instance.lastMessageType],
  'lastMessageAt': const NullableTimestampConverter().toJson(
    instance.lastMessageAt,
  ),
  'lastReadMessageIds': instance.lastReadMessageIds,
  'lastReadAt': const TimestampMapConverter().toJson(instance.lastReadAt),
  'deletedAt': const NullableTimestampConverter().toJson(instance.deletedAt),
  'version': instance.version,
};

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
  MessageType.image: 'image',
  MessageType.voice: 'voice',
  MessageType.system: 'system',
};
