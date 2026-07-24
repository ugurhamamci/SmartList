// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserSettings {

 String get userId;@TimestampConverter() DateTime get createdAt;@TimestampConverter() DateTime get updatedAt; AppThemeMode get themeMode; String get locale; String get currency; MeasurementSystem get measurementSystem; bool get pushEnabled; bool get notifyOnItemAdded; bool get notifyOnItemCompleted; bool get notifyOnItemDeleted; bool get notifyOnListCompleted; bool get notifyOnNewMessage; bool get notifyOnMention; bool get notifyOnInvitation;/// Local quiet hours, expressed as minutes from midnight. Equal values
/// disable the window.
 int get quietHoursStartMinute; int get quietHoursEndMinute; bool get showOnlineStatus; bool get showReadReceipts; bool get showTypingIndicator; bool get allowAnalytics; bool get allowCrashReporting; ListSortOption get defaultListSort; ItemSortOption get defaultItemSort; bool get moveCompletedToBottom; bool get hideCompletedItems; bool get confirmBeforeDelete; bool get hapticFeedback; AiProviderKind get aiProvider; int get version;
/// Create a copy of UserSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSettingsCopyWith<UserSettings> get copyWith => _$UserSettingsCopyWithImpl<UserSettings>(this as UserSettings, _$identity);

  /// Serializes this UserSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSettings&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.measurementSystem, measurementSystem) || other.measurementSystem == measurementSystem)&&(identical(other.pushEnabled, pushEnabled) || other.pushEnabled == pushEnabled)&&(identical(other.notifyOnItemAdded, notifyOnItemAdded) || other.notifyOnItemAdded == notifyOnItemAdded)&&(identical(other.notifyOnItemCompleted, notifyOnItemCompleted) || other.notifyOnItemCompleted == notifyOnItemCompleted)&&(identical(other.notifyOnItemDeleted, notifyOnItemDeleted) || other.notifyOnItemDeleted == notifyOnItemDeleted)&&(identical(other.notifyOnListCompleted, notifyOnListCompleted) || other.notifyOnListCompleted == notifyOnListCompleted)&&(identical(other.notifyOnNewMessage, notifyOnNewMessage) || other.notifyOnNewMessage == notifyOnNewMessage)&&(identical(other.notifyOnMention, notifyOnMention) || other.notifyOnMention == notifyOnMention)&&(identical(other.notifyOnInvitation, notifyOnInvitation) || other.notifyOnInvitation == notifyOnInvitation)&&(identical(other.quietHoursStartMinute, quietHoursStartMinute) || other.quietHoursStartMinute == quietHoursStartMinute)&&(identical(other.quietHoursEndMinute, quietHoursEndMinute) || other.quietHoursEndMinute == quietHoursEndMinute)&&(identical(other.showOnlineStatus, showOnlineStatus) || other.showOnlineStatus == showOnlineStatus)&&(identical(other.showReadReceipts, showReadReceipts) || other.showReadReceipts == showReadReceipts)&&(identical(other.showTypingIndicator, showTypingIndicator) || other.showTypingIndicator == showTypingIndicator)&&(identical(other.allowAnalytics, allowAnalytics) || other.allowAnalytics == allowAnalytics)&&(identical(other.allowCrashReporting, allowCrashReporting) || other.allowCrashReporting == allowCrashReporting)&&(identical(other.defaultListSort, defaultListSort) || other.defaultListSort == defaultListSort)&&(identical(other.defaultItemSort, defaultItemSort) || other.defaultItemSort == defaultItemSort)&&(identical(other.moveCompletedToBottom, moveCompletedToBottom) || other.moveCompletedToBottom == moveCompletedToBottom)&&(identical(other.hideCompletedItems, hideCompletedItems) || other.hideCompletedItems == hideCompletedItems)&&(identical(other.confirmBeforeDelete, confirmBeforeDelete) || other.confirmBeforeDelete == confirmBeforeDelete)&&(identical(other.hapticFeedback, hapticFeedback) || other.hapticFeedback == hapticFeedback)&&(identical(other.aiProvider, aiProvider) || other.aiProvider == aiProvider)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,userId,createdAt,updatedAt,themeMode,locale,currency,measurementSystem,pushEnabled,notifyOnItemAdded,notifyOnItemCompleted,notifyOnItemDeleted,notifyOnListCompleted,notifyOnNewMessage,notifyOnMention,notifyOnInvitation,quietHoursStartMinute,quietHoursEndMinute,showOnlineStatus,showReadReceipts,showTypingIndicator,allowAnalytics,allowCrashReporting,defaultListSort,defaultItemSort,moveCompletedToBottom,hideCompletedItems,confirmBeforeDelete,hapticFeedback,aiProvider,version]);

@override
String toString() {
  return 'UserSettings(userId: $userId, createdAt: $createdAt, updatedAt: $updatedAt, themeMode: $themeMode, locale: $locale, currency: $currency, measurementSystem: $measurementSystem, pushEnabled: $pushEnabled, notifyOnItemAdded: $notifyOnItemAdded, notifyOnItemCompleted: $notifyOnItemCompleted, notifyOnItemDeleted: $notifyOnItemDeleted, notifyOnListCompleted: $notifyOnListCompleted, notifyOnNewMessage: $notifyOnNewMessage, notifyOnMention: $notifyOnMention, notifyOnInvitation: $notifyOnInvitation, quietHoursStartMinute: $quietHoursStartMinute, quietHoursEndMinute: $quietHoursEndMinute, showOnlineStatus: $showOnlineStatus, showReadReceipts: $showReadReceipts, showTypingIndicator: $showTypingIndicator, allowAnalytics: $allowAnalytics, allowCrashReporting: $allowCrashReporting, defaultListSort: $defaultListSort, defaultItemSort: $defaultItemSort, moveCompletedToBottom: $moveCompletedToBottom, hideCompletedItems: $hideCompletedItems, confirmBeforeDelete: $confirmBeforeDelete, hapticFeedback: $hapticFeedback, aiProvider: $aiProvider, version: $version)';
}


}

/// @nodoc
abstract mixin class $UserSettingsCopyWith<$Res>  {
  factory $UserSettingsCopyWith(UserSettings value, $Res Function(UserSettings) _then) = _$UserSettingsCopyWithImpl;
@useResult
$Res call({
 String userId,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, AppThemeMode themeMode, String locale, String currency, MeasurementSystem measurementSystem, bool pushEnabled, bool notifyOnItemAdded, bool notifyOnItemCompleted, bool notifyOnItemDeleted, bool notifyOnListCompleted, bool notifyOnNewMessage, bool notifyOnMention, bool notifyOnInvitation, int quietHoursStartMinute, int quietHoursEndMinute, bool showOnlineStatus, bool showReadReceipts, bool showTypingIndicator, bool allowAnalytics, bool allowCrashReporting, ListSortOption defaultListSort, ItemSortOption defaultItemSort, bool moveCompletedToBottom, bool hideCompletedItems, bool confirmBeforeDelete, bool hapticFeedback, AiProviderKind aiProvider, int version
});




}
/// @nodoc
class _$UserSettingsCopyWithImpl<$Res>
    implements $UserSettingsCopyWith<$Res> {
  _$UserSettingsCopyWithImpl(this._self, this._then);

  final UserSettings _self;
  final $Res Function(UserSettings) _then;

/// Create a copy of UserSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? createdAt = null,Object? updatedAt = null,Object? themeMode = null,Object? locale = null,Object? currency = null,Object? measurementSystem = null,Object? pushEnabled = null,Object? notifyOnItemAdded = null,Object? notifyOnItemCompleted = null,Object? notifyOnItemDeleted = null,Object? notifyOnListCompleted = null,Object? notifyOnNewMessage = null,Object? notifyOnMention = null,Object? notifyOnInvitation = null,Object? quietHoursStartMinute = null,Object? quietHoursEndMinute = null,Object? showOnlineStatus = null,Object? showReadReceipts = null,Object? showTypingIndicator = null,Object? allowAnalytics = null,Object? allowCrashReporting = null,Object? defaultListSort = null,Object? defaultItemSort = null,Object? moveCompletedToBottom = null,Object? hideCompletedItems = null,Object? confirmBeforeDelete = null,Object? hapticFeedback = null,Object? aiProvider = null,Object? version = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as AppThemeMode,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,measurementSystem: null == measurementSystem ? _self.measurementSystem : measurementSystem // ignore: cast_nullable_to_non_nullable
as MeasurementSystem,pushEnabled: null == pushEnabled ? _self.pushEnabled : pushEnabled // ignore: cast_nullable_to_non_nullable
as bool,notifyOnItemAdded: null == notifyOnItemAdded ? _self.notifyOnItemAdded : notifyOnItemAdded // ignore: cast_nullable_to_non_nullable
as bool,notifyOnItemCompleted: null == notifyOnItemCompleted ? _self.notifyOnItemCompleted : notifyOnItemCompleted // ignore: cast_nullable_to_non_nullable
as bool,notifyOnItemDeleted: null == notifyOnItemDeleted ? _self.notifyOnItemDeleted : notifyOnItemDeleted // ignore: cast_nullable_to_non_nullable
as bool,notifyOnListCompleted: null == notifyOnListCompleted ? _self.notifyOnListCompleted : notifyOnListCompleted // ignore: cast_nullable_to_non_nullable
as bool,notifyOnNewMessage: null == notifyOnNewMessage ? _self.notifyOnNewMessage : notifyOnNewMessage // ignore: cast_nullable_to_non_nullable
as bool,notifyOnMention: null == notifyOnMention ? _self.notifyOnMention : notifyOnMention // ignore: cast_nullable_to_non_nullable
as bool,notifyOnInvitation: null == notifyOnInvitation ? _self.notifyOnInvitation : notifyOnInvitation // ignore: cast_nullable_to_non_nullable
as bool,quietHoursStartMinute: null == quietHoursStartMinute ? _self.quietHoursStartMinute : quietHoursStartMinute // ignore: cast_nullable_to_non_nullable
as int,quietHoursEndMinute: null == quietHoursEndMinute ? _self.quietHoursEndMinute : quietHoursEndMinute // ignore: cast_nullable_to_non_nullable
as int,showOnlineStatus: null == showOnlineStatus ? _self.showOnlineStatus : showOnlineStatus // ignore: cast_nullable_to_non_nullable
as bool,showReadReceipts: null == showReadReceipts ? _self.showReadReceipts : showReadReceipts // ignore: cast_nullable_to_non_nullable
as bool,showTypingIndicator: null == showTypingIndicator ? _self.showTypingIndicator : showTypingIndicator // ignore: cast_nullable_to_non_nullable
as bool,allowAnalytics: null == allowAnalytics ? _self.allowAnalytics : allowAnalytics // ignore: cast_nullable_to_non_nullable
as bool,allowCrashReporting: null == allowCrashReporting ? _self.allowCrashReporting : allowCrashReporting // ignore: cast_nullable_to_non_nullable
as bool,defaultListSort: null == defaultListSort ? _self.defaultListSort : defaultListSort // ignore: cast_nullable_to_non_nullable
as ListSortOption,defaultItemSort: null == defaultItemSort ? _self.defaultItemSort : defaultItemSort // ignore: cast_nullable_to_non_nullable
as ItemSortOption,moveCompletedToBottom: null == moveCompletedToBottom ? _self.moveCompletedToBottom : moveCompletedToBottom // ignore: cast_nullable_to_non_nullable
as bool,hideCompletedItems: null == hideCompletedItems ? _self.hideCompletedItems : hideCompletedItems // ignore: cast_nullable_to_non_nullable
as bool,confirmBeforeDelete: null == confirmBeforeDelete ? _self.confirmBeforeDelete : confirmBeforeDelete // ignore: cast_nullable_to_non_nullable
as bool,hapticFeedback: null == hapticFeedback ? _self.hapticFeedback : hapticFeedback // ignore: cast_nullable_to_non_nullable
as bool,aiProvider: null == aiProvider ? _self.aiProvider : aiProvider // ignore: cast_nullable_to_non_nullable
as AiProviderKind,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UserSettings].
extension UserSettingsPatterns on UserSettings {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSettings() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSettings value)  $default,){
final _that = this;
switch (_that) {
case _UserSettings():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSettings value)?  $default,){
final _that = this;
switch (_that) {
case _UserSettings() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  AppThemeMode themeMode,  String locale,  String currency,  MeasurementSystem measurementSystem,  bool pushEnabled,  bool notifyOnItemAdded,  bool notifyOnItemCompleted,  bool notifyOnItemDeleted,  bool notifyOnListCompleted,  bool notifyOnNewMessage,  bool notifyOnMention,  bool notifyOnInvitation,  int quietHoursStartMinute,  int quietHoursEndMinute,  bool showOnlineStatus,  bool showReadReceipts,  bool showTypingIndicator,  bool allowAnalytics,  bool allowCrashReporting,  ListSortOption defaultListSort,  ItemSortOption defaultItemSort,  bool moveCompletedToBottom,  bool hideCompletedItems,  bool confirmBeforeDelete,  bool hapticFeedback,  AiProviderKind aiProvider,  int version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSettings() when $default != null:
return $default(_that.userId,_that.createdAt,_that.updatedAt,_that.themeMode,_that.locale,_that.currency,_that.measurementSystem,_that.pushEnabled,_that.notifyOnItemAdded,_that.notifyOnItemCompleted,_that.notifyOnItemDeleted,_that.notifyOnListCompleted,_that.notifyOnNewMessage,_that.notifyOnMention,_that.notifyOnInvitation,_that.quietHoursStartMinute,_that.quietHoursEndMinute,_that.showOnlineStatus,_that.showReadReceipts,_that.showTypingIndicator,_that.allowAnalytics,_that.allowCrashReporting,_that.defaultListSort,_that.defaultItemSort,_that.moveCompletedToBottom,_that.hideCompletedItems,_that.confirmBeforeDelete,_that.hapticFeedback,_that.aiProvider,_that.version);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  AppThemeMode themeMode,  String locale,  String currency,  MeasurementSystem measurementSystem,  bool pushEnabled,  bool notifyOnItemAdded,  bool notifyOnItemCompleted,  bool notifyOnItemDeleted,  bool notifyOnListCompleted,  bool notifyOnNewMessage,  bool notifyOnMention,  bool notifyOnInvitation,  int quietHoursStartMinute,  int quietHoursEndMinute,  bool showOnlineStatus,  bool showReadReceipts,  bool showTypingIndicator,  bool allowAnalytics,  bool allowCrashReporting,  ListSortOption defaultListSort,  ItemSortOption defaultItemSort,  bool moveCompletedToBottom,  bool hideCompletedItems,  bool confirmBeforeDelete,  bool hapticFeedback,  AiProviderKind aiProvider,  int version)  $default,) {final _that = this;
switch (_that) {
case _UserSettings():
return $default(_that.userId,_that.createdAt,_that.updatedAt,_that.themeMode,_that.locale,_that.currency,_that.measurementSystem,_that.pushEnabled,_that.notifyOnItemAdded,_that.notifyOnItemCompleted,_that.notifyOnItemDeleted,_that.notifyOnListCompleted,_that.notifyOnNewMessage,_that.notifyOnMention,_that.notifyOnInvitation,_that.quietHoursStartMinute,_that.quietHoursEndMinute,_that.showOnlineStatus,_that.showReadReceipts,_that.showTypingIndicator,_that.allowAnalytics,_that.allowCrashReporting,_that.defaultListSort,_that.defaultItemSort,_that.moveCompletedToBottom,_that.hideCompletedItems,_that.confirmBeforeDelete,_that.hapticFeedback,_that.aiProvider,_that.version);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  AppThemeMode themeMode,  String locale,  String currency,  MeasurementSystem measurementSystem,  bool pushEnabled,  bool notifyOnItemAdded,  bool notifyOnItemCompleted,  bool notifyOnItemDeleted,  bool notifyOnListCompleted,  bool notifyOnNewMessage,  bool notifyOnMention,  bool notifyOnInvitation,  int quietHoursStartMinute,  int quietHoursEndMinute,  bool showOnlineStatus,  bool showReadReceipts,  bool showTypingIndicator,  bool allowAnalytics,  bool allowCrashReporting,  ListSortOption defaultListSort,  ItemSortOption defaultItemSort,  bool moveCompletedToBottom,  bool hideCompletedItems,  bool confirmBeforeDelete,  bool hapticFeedback,  AiProviderKind aiProvider,  int version)?  $default,) {final _that = this;
switch (_that) {
case _UserSettings() when $default != null:
return $default(_that.userId,_that.createdAt,_that.updatedAt,_that.themeMode,_that.locale,_that.currency,_that.measurementSystem,_that.pushEnabled,_that.notifyOnItemAdded,_that.notifyOnItemCompleted,_that.notifyOnItemDeleted,_that.notifyOnListCompleted,_that.notifyOnNewMessage,_that.notifyOnMention,_that.notifyOnInvitation,_that.quietHoursStartMinute,_that.quietHoursEndMinute,_that.showOnlineStatus,_that.showReadReceipts,_that.showTypingIndicator,_that.allowAnalytics,_that.allowCrashReporting,_that.defaultListSort,_that.defaultItemSort,_that.moveCompletedToBottom,_that.hideCompletedItems,_that.confirmBeforeDelete,_that.hapticFeedback,_that.aiProvider,_that.version);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserSettings implements UserSettings {
  const _UserSettings({required this.userId, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt, this.themeMode = AppThemeMode.system, this.locale = 'en', this.currency = 'USD', this.measurementSystem = MeasurementSystem.metric, this.pushEnabled = true, this.notifyOnItemAdded = true, this.notifyOnItemCompleted = true, this.notifyOnItemDeleted = true, this.notifyOnListCompleted = true, this.notifyOnNewMessage = true, this.notifyOnMention = true, this.notifyOnInvitation = true, this.quietHoursStartMinute = 0, this.quietHoursEndMinute = 0, this.showOnlineStatus = true, this.showReadReceipts = true, this.showTypingIndicator = true, this.allowAnalytics = true, this.allowCrashReporting = true, this.defaultListSort = ListSortOption.recentlyUpdated, this.defaultItemSort = ItemSortOption.manual, this.moveCompletedToBottom = true, this.hideCompletedItems = false, this.confirmBeforeDelete = true, this.hapticFeedback = true, this.aiProvider = AiProviderKind.claude, this.version = 1});
  factory _UserSettings.fromJson(Map<String, dynamic> json) => _$UserSettingsFromJson(json);

@override final  String userId;
@override@TimestampConverter() final  DateTime createdAt;
@override@TimestampConverter() final  DateTime updatedAt;
@override@JsonKey() final  AppThemeMode themeMode;
@override@JsonKey() final  String locale;
@override@JsonKey() final  String currency;
@override@JsonKey() final  MeasurementSystem measurementSystem;
@override@JsonKey() final  bool pushEnabled;
@override@JsonKey() final  bool notifyOnItemAdded;
@override@JsonKey() final  bool notifyOnItemCompleted;
@override@JsonKey() final  bool notifyOnItemDeleted;
@override@JsonKey() final  bool notifyOnListCompleted;
@override@JsonKey() final  bool notifyOnNewMessage;
@override@JsonKey() final  bool notifyOnMention;
@override@JsonKey() final  bool notifyOnInvitation;
/// Local quiet hours, expressed as minutes from midnight. Equal values
/// disable the window.
@override@JsonKey() final  int quietHoursStartMinute;
@override@JsonKey() final  int quietHoursEndMinute;
@override@JsonKey() final  bool showOnlineStatus;
@override@JsonKey() final  bool showReadReceipts;
@override@JsonKey() final  bool showTypingIndicator;
@override@JsonKey() final  bool allowAnalytics;
@override@JsonKey() final  bool allowCrashReporting;
@override@JsonKey() final  ListSortOption defaultListSort;
@override@JsonKey() final  ItemSortOption defaultItemSort;
@override@JsonKey() final  bool moveCompletedToBottom;
@override@JsonKey() final  bool hideCompletedItems;
@override@JsonKey() final  bool confirmBeforeDelete;
@override@JsonKey() final  bool hapticFeedback;
@override@JsonKey() final  AiProviderKind aiProvider;
@override@JsonKey() final  int version;

/// Create a copy of UserSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSettingsCopyWith<_UserSettings> get copyWith => __$UserSettingsCopyWithImpl<_UserSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSettings&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.measurementSystem, measurementSystem) || other.measurementSystem == measurementSystem)&&(identical(other.pushEnabled, pushEnabled) || other.pushEnabled == pushEnabled)&&(identical(other.notifyOnItemAdded, notifyOnItemAdded) || other.notifyOnItemAdded == notifyOnItemAdded)&&(identical(other.notifyOnItemCompleted, notifyOnItemCompleted) || other.notifyOnItemCompleted == notifyOnItemCompleted)&&(identical(other.notifyOnItemDeleted, notifyOnItemDeleted) || other.notifyOnItemDeleted == notifyOnItemDeleted)&&(identical(other.notifyOnListCompleted, notifyOnListCompleted) || other.notifyOnListCompleted == notifyOnListCompleted)&&(identical(other.notifyOnNewMessage, notifyOnNewMessage) || other.notifyOnNewMessage == notifyOnNewMessage)&&(identical(other.notifyOnMention, notifyOnMention) || other.notifyOnMention == notifyOnMention)&&(identical(other.notifyOnInvitation, notifyOnInvitation) || other.notifyOnInvitation == notifyOnInvitation)&&(identical(other.quietHoursStartMinute, quietHoursStartMinute) || other.quietHoursStartMinute == quietHoursStartMinute)&&(identical(other.quietHoursEndMinute, quietHoursEndMinute) || other.quietHoursEndMinute == quietHoursEndMinute)&&(identical(other.showOnlineStatus, showOnlineStatus) || other.showOnlineStatus == showOnlineStatus)&&(identical(other.showReadReceipts, showReadReceipts) || other.showReadReceipts == showReadReceipts)&&(identical(other.showTypingIndicator, showTypingIndicator) || other.showTypingIndicator == showTypingIndicator)&&(identical(other.allowAnalytics, allowAnalytics) || other.allowAnalytics == allowAnalytics)&&(identical(other.allowCrashReporting, allowCrashReporting) || other.allowCrashReporting == allowCrashReporting)&&(identical(other.defaultListSort, defaultListSort) || other.defaultListSort == defaultListSort)&&(identical(other.defaultItemSort, defaultItemSort) || other.defaultItemSort == defaultItemSort)&&(identical(other.moveCompletedToBottom, moveCompletedToBottom) || other.moveCompletedToBottom == moveCompletedToBottom)&&(identical(other.hideCompletedItems, hideCompletedItems) || other.hideCompletedItems == hideCompletedItems)&&(identical(other.confirmBeforeDelete, confirmBeforeDelete) || other.confirmBeforeDelete == confirmBeforeDelete)&&(identical(other.hapticFeedback, hapticFeedback) || other.hapticFeedback == hapticFeedback)&&(identical(other.aiProvider, aiProvider) || other.aiProvider == aiProvider)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,userId,createdAt,updatedAt,themeMode,locale,currency,measurementSystem,pushEnabled,notifyOnItemAdded,notifyOnItemCompleted,notifyOnItemDeleted,notifyOnListCompleted,notifyOnNewMessage,notifyOnMention,notifyOnInvitation,quietHoursStartMinute,quietHoursEndMinute,showOnlineStatus,showReadReceipts,showTypingIndicator,allowAnalytics,allowCrashReporting,defaultListSort,defaultItemSort,moveCompletedToBottom,hideCompletedItems,confirmBeforeDelete,hapticFeedback,aiProvider,version]);

@override
String toString() {
  return 'UserSettings(userId: $userId, createdAt: $createdAt, updatedAt: $updatedAt, themeMode: $themeMode, locale: $locale, currency: $currency, measurementSystem: $measurementSystem, pushEnabled: $pushEnabled, notifyOnItemAdded: $notifyOnItemAdded, notifyOnItemCompleted: $notifyOnItemCompleted, notifyOnItemDeleted: $notifyOnItemDeleted, notifyOnListCompleted: $notifyOnListCompleted, notifyOnNewMessage: $notifyOnNewMessage, notifyOnMention: $notifyOnMention, notifyOnInvitation: $notifyOnInvitation, quietHoursStartMinute: $quietHoursStartMinute, quietHoursEndMinute: $quietHoursEndMinute, showOnlineStatus: $showOnlineStatus, showReadReceipts: $showReadReceipts, showTypingIndicator: $showTypingIndicator, allowAnalytics: $allowAnalytics, allowCrashReporting: $allowCrashReporting, defaultListSort: $defaultListSort, defaultItemSort: $defaultItemSort, moveCompletedToBottom: $moveCompletedToBottom, hideCompletedItems: $hideCompletedItems, confirmBeforeDelete: $confirmBeforeDelete, hapticFeedback: $hapticFeedback, aiProvider: $aiProvider, version: $version)';
}


}

/// @nodoc
abstract mixin class _$UserSettingsCopyWith<$Res> implements $UserSettingsCopyWith<$Res> {
  factory _$UserSettingsCopyWith(_UserSettings value, $Res Function(_UserSettings) _then) = __$UserSettingsCopyWithImpl;
@override @useResult
$Res call({
 String userId,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, AppThemeMode themeMode, String locale, String currency, MeasurementSystem measurementSystem, bool pushEnabled, bool notifyOnItemAdded, bool notifyOnItemCompleted, bool notifyOnItemDeleted, bool notifyOnListCompleted, bool notifyOnNewMessage, bool notifyOnMention, bool notifyOnInvitation, int quietHoursStartMinute, int quietHoursEndMinute, bool showOnlineStatus, bool showReadReceipts, bool showTypingIndicator, bool allowAnalytics, bool allowCrashReporting, ListSortOption defaultListSort, ItemSortOption defaultItemSort, bool moveCompletedToBottom, bool hideCompletedItems, bool confirmBeforeDelete, bool hapticFeedback, AiProviderKind aiProvider, int version
});




}
/// @nodoc
class __$UserSettingsCopyWithImpl<$Res>
    implements _$UserSettingsCopyWith<$Res> {
  __$UserSettingsCopyWithImpl(this._self, this._then);

  final _UserSettings _self;
  final $Res Function(_UserSettings) _then;

/// Create a copy of UserSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? createdAt = null,Object? updatedAt = null,Object? themeMode = null,Object? locale = null,Object? currency = null,Object? measurementSystem = null,Object? pushEnabled = null,Object? notifyOnItemAdded = null,Object? notifyOnItemCompleted = null,Object? notifyOnItemDeleted = null,Object? notifyOnListCompleted = null,Object? notifyOnNewMessage = null,Object? notifyOnMention = null,Object? notifyOnInvitation = null,Object? quietHoursStartMinute = null,Object? quietHoursEndMinute = null,Object? showOnlineStatus = null,Object? showReadReceipts = null,Object? showTypingIndicator = null,Object? allowAnalytics = null,Object? allowCrashReporting = null,Object? defaultListSort = null,Object? defaultItemSort = null,Object? moveCompletedToBottom = null,Object? hideCompletedItems = null,Object? confirmBeforeDelete = null,Object? hapticFeedback = null,Object? aiProvider = null,Object? version = null,}) {
  return _then(_UserSettings(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as AppThemeMode,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,measurementSystem: null == measurementSystem ? _self.measurementSystem : measurementSystem // ignore: cast_nullable_to_non_nullable
as MeasurementSystem,pushEnabled: null == pushEnabled ? _self.pushEnabled : pushEnabled // ignore: cast_nullable_to_non_nullable
as bool,notifyOnItemAdded: null == notifyOnItemAdded ? _self.notifyOnItemAdded : notifyOnItemAdded // ignore: cast_nullable_to_non_nullable
as bool,notifyOnItemCompleted: null == notifyOnItemCompleted ? _self.notifyOnItemCompleted : notifyOnItemCompleted // ignore: cast_nullable_to_non_nullable
as bool,notifyOnItemDeleted: null == notifyOnItemDeleted ? _self.notifyOnItemDeleted : notifyOnItemDeleted // ignore: cast_nullable_to_non_nullable
as bool,notifyOnListCompleted: null == notifyOnListCompleted ? _self.notifyOnListCompleted : notifyOnListCompleted // ignore: cast_nullable_to_non_nullable
as bool,notifyOnNewMessage: null == notifyOnNewMessage ? _self.notifyOnNewMessage : notifyOnNewMessage // ignore: cast_nullable_to_non_nullable
as bool,notifyOnMention: null == notifyOnMention ? _self.notifyOnMention : notifyOnMention // ignore: cast_nullable_to_non_nullable
as bool,notifyOnInvitation: null == notifyOnInvitation ? _self.notifyOnInvitation : notifyOnInvitation // ignore: cast_nullable_to_non_nullable
as bool,quietHoursStartMinute: null == quietHoursStartMinute ? _self.quietHoursStartMinute : quietHoursStartMinute // ignore: cast_nullable_to_non_nullable
as int,quietHoursEndMinute: null == quietHoursEndMinute ? _self.quietHoursEndMinute : quietHoursEndMinute // ignore: cast_nullable_to_non_nullable
as int,showOnlineStatus: null == showOnlineStatus ? _self.showOnlineStatus : showOnlineStatus // ignore: cast_nullable_to_non_nullable
as bool,showReadReceipts: null == showReadReceipts ? _self.showReadReceipts : showReadReceipts // ignore: cast_nullable_to_non_nullable
as bool,showTypingIndicator: null == showTypingIndicator ? _self.showTypingIndicator : showTypingIndicator // ignore: cast_nullable_to_non_nullable
as bool,allowAnalytics: null == allowAnalytics ? _self.allowAnalytics : allowAnalytics // ignore: cast_nullable_to_non_nullable
as bool,allowCrashReporting: null == allowCrashReporting ? _self.allowCrashReporting : allowCrashReporting // ignore: cast_nullable_to_non_nullable
as bool,defaultListSort: null == defaultListSort ? _self.defaultListSort : defaultListSort // ignore: cast_nullable_to_non_nullable
as ListSortOption,defaultItemSort: null == defaultItemSort ? _self.defaultItemSort : defaultItemSort // ignore: cast_nullable_to_non_nullable
as ItemSortOption,moveCompletedToBottom: null == moveCompletedToBottom ? _self.moveCompletedToBottom : moveCompletedToBottom // ignore: cast_nullable_to_non_nullable
as bool,hideCompletedItems: null == hideCompletedItems ? _self.hideCompletedItems : hideCompletedItems // ignore: cast_nullable_to_non_nullable
as bool,confirmBeforeDelete: null == confirmBeforeDelete ? _self.confirmBeforeDelete : confirmBeforeDelete // ignore: cast_nullable_to_non_nullable
as bool,hapticFeedback: null == hapticFeedback ? _self.hapticFeedback : hapticFeedback // ignore: cast_nullable_to_non_nullable
as bool,aiProvider: null == aiProvider ? _self.aiProvider : aiProvider // ignore: cast_nullable_to_non_nullable
as AiProviderKind,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
