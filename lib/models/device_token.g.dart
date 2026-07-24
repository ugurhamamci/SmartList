// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeviceToken _$DeviceTokenFromJson(Map<String, dynamic> json) => _DeviceToken(
  id: json['id'] as String,
  userId: json['userId'] as String,
  token: json['token'] as String,
  platform: $enumDecode(_$DevicePlatformEnumMap, json['platform']),
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
  isActive: json['isActive'] as bool? ?? true,
  deviceModel: json['deviceModel'] as String? ?? '',
  osVersion: json['osVersion'] as String? ?? '',
  appVersion: json['appVersion'] as String? ?? '',
  locale: json['locale'] as String? ?? 'en',
  timezone: json['timezone'] as String? ?? '',
  lastUsedAt: const NullableTimestampConverter().fromJson(json['lastUsedAt']),
);

Map<String, dynamic> _$DeviceTokenToJson(
  _DeviceToken instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'token': instance.token,
  'platform': _$DevicePlatformEnumMap[instance.platform]!,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
  'isActive': instance.isActive,
  'deviceModel': instance.deviceModel,
  'osVersion': instance.osVersion,
  'appVersion': instance.appVersion,
  'locale': instance.locale,
  'timezone': instance.timezone,
  'lastUsedAt': const NullableTimestampConverter().toJson(instance.lastUsedAt),
};

const _$DevicePlatformEnumMap = {
  DevicePlatform.android: 'android',
  DevicePlatform.ios: 'ios',
  DevicePlatform.web: 'web',
  DevicePlatform.other: 'other',
};
