// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_presence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserPresence _$UserPresenceFromJson(Map<String, dynamic> json) =>
    _UserPresence(
      id: json['id'] as String,
      userId: json['userId'] as String,
      listId: json['listId'] as String,
      lastSeenAt: const TimestampConverter().fromJson(json['lastSeenAt']),
      isOnline: json['isOnline'] as bool? ?? false,
      displayName: json['displayName'] as String? ?? '',
      photoUrl: json['photoUrl'] as String?,
      editingItemId: json['editingItemId'] as String?,
      deviceId: json['deviceId'] as String? ?? '',
    );

Map<String, dynamic> _$UserPresenceToJson(_UserPresence instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'listId': instance.listId,
      'lastSeenAt': const TimestampConverter().toJson(instance.lastSeenAt),
      'isOnline': instance.isOnline,
      'displayName': instance.displayName,
      'photoUrl': instance.photoUrl,
      'editingItemId': instance.editingItemId,
      'deviceId': instance.deviceId,
    };
