// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUser _$AppUserFromJson(Map<String, dynamic> json) => _AppUser(
  id: json['id'] as String,
  email: json['email'] as String,
  displayName: json['displayName'] as String,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
  createdBy: json['createdBy'] as String,
  updatedBy: json['updatedBy'] as String,
  photoUrl: json['photoUrl'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  isEmailVerified: json['isEmailVerified'] as bool? ?? false,
  isPremium: json['isPremium'] as bool? ?? false,
  subscriptionTier:
      $enumDecodeNullable(
        _$SubscriptionTierEnumMap,
        json['subscriptionTier'],
      ) ??
      SubscriptionTier.free,
  isOnline: json['isOnline'] as bool? ?? false,
  lastSeenAt: const NullableTimestampConverter().fromJson(json['lastSeenAt']),
  locale: json['locale'] as String? ?? 'en',
  timezone: json['timezone'] as String?,
  providerIds:
      (json['providerIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  listCount: (json['listCount'] as num?)?.toInt() ?? 0,
  completedItemCount: (json['completedItemCount'] as num?)?.toInt() ?? 0,
  aiGenerationsThisMonth:
      (json['aiGenerationsThisMonth'] as num?)?.toInt() ?? 0,
  aiQuotaResetAt: const NullableTimestampConverter().fromJson(
    json['aiQuotaResetAt'],
  ),
  deletedAt: const NullableTimestampConverter().fromJson(json['deletedAt']),
  version: (json['version'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$AppUserToJson(_AppUser instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'displayName': instance.displayName,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
  'createdBy': instance.createdBy,
  'updatedBy': instance.updatedBy,
  'photoUrl': instance.photoUrl,
  'phoneNumber': instance.phoneNumber,
  'isEmailVerified': instance.isEmailVerified,
  'isPremium': instance.isPremium,
  'subscriptionTier': _$SubscriptionTierEnumMap[instance.subscriptionTier]!,
  'isOnline': instance.isOnline,
  'lastSeenAt': const NullableTimestampConverter().toJson(instance.lastSeenAt),
  'locale': instance.locale,
  'timezone': instance.timezone,
  'providerIds': instance.providerIds,
  'listCount': instance.listCount,
  'completedItemCount': instance.completedItemCount,
  'aiGenerationsThisMonth': instance.aiGenerationsThisMonth,
  'aiQuotaResetAt': const NullableTimestampConverter().toJson(
    instance.aiQuotaResetAt,
  ),
  'deletedAt': const NullableTimestampConverter().toJson(instance.deletedAt),
  'version': instance.version,
};

const _$SubscriptionTierEnumMap = {
  SubscriptionTier.free: 'free',
  SubscriptionTier.plus: 'plus',
  SubscriptionTier.family: 'family',
};
