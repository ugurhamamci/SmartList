import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:smartlist/core/utils/json_converters.dart';
import 'package:smartlist/models/enums.dart';

part 'user_settings.freezed.dart';
part 'user_settings.g.dart';

/// Per-user preferences at `users/{userId}/settings/preferences`.
///
/// Stored server-side so that settings follow the account across devices; the
/// theme and locale are additionally mirrored into the local preferences box so
/// the first frame after a cold start does not flash the wrong theme.
@freezed
abstract class UserSettings with _$UserSettings {
  const factory UserSettings({
    required String userId,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
    @Default(AppThemeMode.system) AppThemeMode themeMode,
    @Default('en') String locale,
    @Default('USD') String currency,
    @Default(MeasurementSystem.metric) MeasurementSystem measurementSystem,

    // --- notification channels ---
    @Default(true) bool pushEnabled,
    @Default(true) bool notifyOnItemAdded,
    @Default(true) bool notifyOnItemCompleted,
    @Default(true) bool notifyOnItemDeleted,
    @Default(true) bool notifyOnListCompleted,
    @Default(true) bool notifyOnNewMessage,
    @Default(true) bool notifyOnMention,
    @Default(true) bool notifyOnInvitation,

    /// Local quiet hours, expressed as minutes from midnight. Equal values
    /// disable the window.
    @Default(0) int quietHoursStartMinute,
    @Default(0) int quietHoursEndMinute,

    // --- privacy ---
    @Default(true) bool showOnlineStatus,
    @Default(true) bool showReadReceipts,
    @Default(true) bool showTypingIndicator,
    @Default(true) bool allowAnalytics,
    @Default(true) bool allowCrashReporting,

    // --- behaviour ---
    @Default(ListSortOption.recentlyUpdated) ListSortOption defaultListSort,
    @Default(ItemSortOption.manual) ItemSortOption defaultItemSort,
    @Default(true) bool moveCompletedToBottom,
    @Default(false) bool hideCompletedItems,
    @Default(true) bool confirmBeforeDelete,
    @Default(true) bool hapticFeedback,
    @Default(AiProviderKind.claude) AiProviderKind aiProvider,
    @Default(1) int version,
  }) = _UserSettings;

  factory UserSettings.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsFromJson(json);
}

/// Derived properties of [UserSettings].
extension UserSettingsX on UserSettings {
  bool get hasQuietHours => quietHoursStartMinute != quietHoursEndMinute;

  /// True when [now] falls inside the configured quiet window, handling a
  /// window that wraps past midnight.
  bool isWithinQuietHours(DateTime now) {
    if (!hasQuietHours) {
      return false;
    }
    final minute = now.hour * 60 + now.minute;
    if (quietHoursStartMinute < quietHoursEndMinute) {
      return minute >= quietHoursStartMinute && minute < quietHoursEndMinute;
    }
    return minute >= quietHoursStartMinute || minute < quietHoursEndMinute;
  }

  /// Default unit implied by the chosen measurement system.
  MeasurementUnit get defaultWeightUnit =>
      measurementSystem == MeasurementSystem.metric
      ? MeasurementUnit.kilogram
      : MeasurementUnit.pound;

  MeasurementUnit get defaultVolumeUnit =>
      measurementSystem == MeasurementSystem.metric
      ? MeasurementUnit.liter
      : MeasurementUnit.gallon;
}
