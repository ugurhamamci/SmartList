// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserSettings _$UserSettingsFromJson(
  Map<String, dynamic> json,
) => _UserSettings(
  userId: json['userId'] as String,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
  themeMode:
      $enumDecodeNullable(_$AppThemeModeEnumMap, json['themeMode']) ??
      AppThemeMode.system,
  locale: json['locale'] as String? ?? 'en',
  currency: json['currency'] as String? ?? 'USD',
  measurementSystem:
      $enumDecodeNullable(
        _$MeasurementSystemEnumMap,
        json['measurementSystem'],
      ) ??
      MeasurementSystem.metric,
  pushEnabled: json['pushEnabled'] as bool? ?? true,
  notifyOnItemAdded: json['notifyOnItemAdded'] as bool? ?? true,
  notifyOnItemCompleted: json['notifyOnItemCompleted'] as bool? ?? true,
  notifyOnItemDeleted: json['notifyOnItemDeleted'] as bool? ?? true,
  notifyOnListCompleted: json['notifyOnListCompleted'] as bool? ?? true,
  notifyOnNewMessage: json['notifyOnNewMessage'] as bool? ?? true,
  notifyOnMention: json['notifyOnMention'] as bool? ?? true,
  notifyOnInvitation: json['notifyOnInvitation'] as bool? ?? true,
  quietHoursStartMinute: (json['quietHoursStartMinute'] as num?)?.toInt() ?? 0,
  quietHoursEndMinute: (json['quietHoursEndMinute'] as num?)?.toInt() ?? 0,
  showOnlineStatus: json['showOnlineStatus'] as bool? ?? true,
  showReadReceipts: json['showReadReceipts'] as bool? ?? true,
  showTypingIndicator: json['showTypingIndicator'] as bool? ?? true,
  allowAnalytics: json['allowAnalytics'] as bool? ?? true,
  allowCrashReporting: json['allowCrashReporting'] as bool? ?? true,
  defaultListSort:
      $enumDecodeNullable(_$ListSortOptionEnumMap, json['defaultListSort']) ??
      ListSortOption.recentlyUpdated,
  defaultItemSort:
      $enumDecodeNullable(_$ItemSortOptionEnumMap, json['defaultItemSort']) ??
      ItemSortOption.manual,
  moveCompletedToBottom: json['moveCompletedToBottom'] as bool? ?? true,
  hideCompletedItems: json['hideCompletedItems'] as bool? ?? false,
  confirmBeforeDelete: json['confirmBeforeDelete'] as bool? ?? true,
  hapticFeedback: json['hapticFeedback'] as bool? ?? true,
  aiProvider:
      $enumDecodeNullable(_$AiProviderKindEnumMap, json['aiProvider']) ??
      AiProviderKind.claude,
  version: (json['version'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$UserSettingsToJson(
  _UserSettings instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
  'themeMode': _$AppThemeModeEnumMap[instance.themeMode]!,
  'locale': instance.locale,
  'currency': instance.currency,
  'measurementSystem': _$MeasurementSystemEnumMap[instance.measurementSystem]!,
  'pushEnabled': instance.pushEnabled,
  'notifyOnItemAdded': instance.notifyOnItemAdded,
  'notifyOnItemCompleted': instance.notifyOnItemCompleted,
  'notifyOnItemDeleted': instance.notifyOnItemDeleted,
  'notifyOnListCompleted': instance.notifyOnListCompleted,
  'notifyOnNewMessage': instance.notifyOnNewMessage,
  'notifyOnMention': instance.notifyOnMention,
  'notifyOnInvitation': instance.notifyOnInvitation,
  'quietHoursStartMinute': instance.quietHoursStartMinute,
  'quietHoursEndMinute': instance.quietHoursEndMinute,
  'showOnlineStatus': instance.showOnlineStatus,
  'showReadReceipts': instance.showReadReceipts,
  'showTypingIndicator': instance.showTypingIndicator,
  'allowAnalytics': instance.allowAnalytics,
  'allowCrashReporting': instance.allowCrashReporting,
  'defaultListSort': _$ListSortOptionEnumMap[instance.defaultListSort]!,
  'defaultItemSort': _$ItemSortOptionEnumMap[instance.defaultItemSort]!,
  'moveCompletedToBottom': instance.moveCompletedToBottom,
  'hideCompletedItems': instance.hideCompletedItems,
  'confirmBeforeDelete': instance.confirmBeforeDelete,
  'hapticFeedback': instance.hapticFeedback,
  'aiProvider': _$AiProviderKindEnumMap[instance.aiProvider]!,
  'version': instance.version,
};

const _$AppThemeModeEnumMap = {
  AppThemeMode.light: 'light',
  AppThemeMode.dark: 'dark',
  AppThemeMode.system: 'system',
};

const _$MeasurementSystemEnumMap = {
  MeasurementSystem.metric: 'metric',
  MeasurementSystem.imperial: 'imperial',
};

const _$ListSortOptionEnumMap = {
  ListSortOption.recentlyUpdated: 'recently_updated',
  ListSortOption.createdNewest: 'created_newest',
  ListSortOption.createdOldest: 'created_oldest',
  ListSortOption.alphabetical: 'alphabetical',
  ListSortOption.completion: 'completion',
  ListSortOption.memberCount: 'member_count',
};

const _$ItemSortOptionEnumMap = {
  ItemSortOption.manual: 'manual',
  ItemSortOption.alphabetical: 'alphabetical',
  ItemSortOption.category: 'category',
  ItemSortOption.priority: 'priority',
  ItemSortOption.completion: 'completion',
  ItemSortOption.recentlyAdded: 'recently_added',
};

const _$AiProviderKindEnumMap = {
  AiProviderKind.openAi: 'openai',
  AiProviderKind.gemini: 'gemini',
  AiProviderKind.claude: 'claude',
};
