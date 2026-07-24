// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserStatistics _$UserStatisticsFromJson(Map<String, dynamic> json) =>
    _UserStatistics(
      id: json['id'] as String,
      userId: json['userId'] as String,
      period: $enumDecode(_$StatisticsPeriodEnumMap, json['period']),
      periodStart: const TimestampConverter().fromJson(json['periodStart']),
      periodEnd: const TimestampConverter().fromJson(json['periodEnd']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
      listsCreated: (json['listsCreated'] as num?)?.toInt() ?? 0,
      listsCompleted: (json['listsCompleted'] as num?)?.toInt() ?? 0,
      itemsAdded: (json['itemsAdded'] as num?)?.toInt() ?? 0,
      itemsCompleted: (json['itemsCompleted'] as num?)?.toInt() ?? 0,
      totalSpent: json['totalSpent'] == null
          ? 0
          : const FlexibleDoubleConverter().fromJson(json['totalSpent']),
      currency: json['currency'] as String? ?? 'USD',
      spendByCategory:
          (json['spendByCategory'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const <String, double>{},
      itemsByCategory:
          (json['itemsByCategory'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const <String, int>{},
      itemFrequency:
          (json['itemFrequency'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const <String, int>{},
      spendByDay:
          (json['spendByDay'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const <String, double>{},
    );

Map<String, dynamic> _$UserStatisticsToJson(_UserStatistics instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'period': _$StatisticsPeriodEnumMap[instance.period]!,
      'periodStart': const TimestampConverter().toJson(instance.periodStart),
      'periodEnd': const TimestampConverter().toJson(instance.periodEnd),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'listsCreated': instance.listsCreated,
      'listsCompleted': instance.listsCompleted,
      'itemsAdded': instance.itemsAdded,
      'itemsCompleted': instance.itemsCompleted,
      'totalSpent': const FlexibleDoubleConverter().toJson(instance.totalSpent),
      'currency': instance.currency,
      'spendByCategory': instance.spendByCategory,
      'itemsByCategory': instance.itemsByCategory,
      'itemFrequency': instance.itemFrequency,
      'spendByDay': instance.spendByDay,
    };

const _$StatisticsPeriodEnumMap = {
  StatisticsPeriod.daily: 'daily',
  StatisticsPeriod.weekly: 'weekly',
  StatisticsPeriod.monthly: 'monthly',
  StatisticsPeriod.yearly: 'yearly',
  StatisticsPeriod.allTime: 'all_time',
};
