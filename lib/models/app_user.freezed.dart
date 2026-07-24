// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppUser {

 String get id; String get email; String get displayName;@TimestampConverter() DateTime get createdAt;@TimestampConverter() DateTime get updatedAt; String get createdBy; String get updatedBy; String? get photoUrl; String? get phoneNumber; bool get isEmailVerified; bool get isPremium; SubscriptionTier get subscriptionTier; bool get isOnline;@NullableTimestampConverter() DateTime? get lastSeenAt; String get locale; String? get timezone;/// Identity providers linked to the account, e.g. `password`, `google.com`,
/// `apple.com`.
 List<String> get providerIds;/// Denormalised counters maintained by Cloud Functions; cheap to render on
/// the profile screen without fanning out reads.
 int get listCount; int get completedItemCount;/// Number of AI generations consumed in the current billing month, used to
/// enforce the free-plan ceiling.
 int get aiGenerationsThisMonth;@NullableTimestampConverter() DateTime? get aiQuotaResetAt;@NullableTimestampConverter() DateTime? get deletedAt; int get version;
/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppUserCopyWith<AppUser> get copyWith => _$AppUserCopyWithImpl<AppUser>(this as AppUser, _$identity);

  /// Serializes this AppUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppUser&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.updatedBy, updatedBy) || other.updatedBy == updatedBy)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.isEmailVerified, isEmailVerified) || other.isEmailVerified == isEmailVerified)&&(identical(other.isPremium, isPremium) || other.isPremium == isPremium)&&(identical(other.subscriptionTier, subscriptionTier) || other.subscriptionTier == subscriptionTier)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.lastSeenAt, lastSeenAt) || other.lastSeenAt == lastSeenAt)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&const DeepCollectionEquality().equals(other.providerIds, providerIds)&&(identical(other.listCount, listCount) || other.listCount == listCount)&&(identical(other.completedItemCount, completedItemCount) || other.completedItemCount == completedItemCount)&&(identical(other.aiGenerationsThisMonth, aiGenerationsThisMonth) || other.aiGenerationsThisMonth == aiGenerationsThisMonth)&&(identical(other.aiQuotaResetAt, aiQuotaResetAt) || other.aiQuotaResetAt == aiQuotaResetAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,email,displayName,createdAt,updatedAt,createdBy,updatedBy,photoUrl,phoneNumber,isEmailVerified,isPremium,subscriptionTier,isOnline,lastSeenAt,locale,timezone,const DeepCollectionEquality().hash(providerIds),listCount,completedItemCount,aiGenerationsThisMonth,aiQuotaResetAt,deletedAt,version]);

@override
String toString() {
  return 'AppUser(id: $id, email: $email, displayName: $displayName, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy, photoUrl: $photoUrl, phoneNumber: $phoneNumber, isEmailVerified: $isEmailVerified, isPremium: $isPremium, subscriptionTier: $subscriptionTier, isOnline: $isOnline, lastSeenAt: $lastSeenAt, locale: $locale, timezone: $timezone, providerIds: $providerIds, listCount: $listCount, completedItemCount: $completedItemCount, aiGenerationsThisMonth: $aiGenerationsThisMonth, aiQuotaResetAt: $aiQuotaResetAt, deletedAt: $deletedAt, version: $version)';
}


}

/// @nodoc
abstract mixin class $AppUserCopyWith<$Res>  {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) _then) = _$AppUserCopyWithImpl;
@useResult
$Res call({
 String id, String email, String displayName,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, String createdBy, String updatedBy, String? photoUrl, String? phoneNumber, bool isEmailVerified, bool isPremium, SubscriptionTier subscriptionTier, bool isOnline,@NullableTimestampConverter() DateTime? lastSeenAt, String locale, String? timezone, List<String> providerIds, int listCount, int completedItemCount, int aiGenerationsThisMonth,@NullableTimestampConverter() DateTime? aiQuotaResetAt,@NullableTimestampConverter() DateTime? deletedAt, int version
});




}
/// @nodoc
class _$AppUserCopyWithImpl<$Res>
    implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._self, this._then);

  final AppUser _self;
  final $Res Function(AppUser) _then;

/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? displayName = null,Object? createdAt = null,Object? updatedAt = null,Object? createdBy = null,Object? updatedBy = null,Object? photoUrl = freezed,Object? phoneNumber = freezed,Object? isEmailVerified = null,Object? isPremium = null,Object? subscriptionTier = null,Object? isOnline = null,Object? lastSeenAt = freezed,Object? locale = null,Object? timezone = freezed,Object? providerIds = null,Object? listCount = null,Object? completedItemCount = null,Object? aiGenerationsThisMonth = null,Object? aiQuotaResetAt = freezed,Object? deletedAt = freezed,Object? version = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,updatedBy: null == updatedBy ? _self.updatedBy : updatedBy // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,isEmailVerified: null == isEmailVerified ? _self.isEmailVerified : isEmailVerified // ignore: cast_nullable_to_non_nullable
as bool,isPremium: null == isPremium ? _self.isPremium : isPremium // ignore: cast_nullable_to_non_nullable
as bool,subscriptionTier: null == subscriptionTier ? _self.subscriptionTier : subscriptionTier // ignore: cast_nullable_to_non_nullable
as SubscriptionTier,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,lastSeenAt: freezed == lastSeenAt ? _self.lastSeenAt : lastSeenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,timezone: freezed == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String?,providerIds: null == providerIds ? _self.providerIds : providerIds // ignore: cast_nullable_to_non_nullable
as List<String>,listCount: null == listCount ? _self.listCount : listCount // ignore: cast_nullable_to_non_nullable
as int,completedItemCount: null == completedItemCount ? _self.completedItemCount : completedItemCount // ignore: cast_nullable_to_non_nullable
as int,aiGenerationsThisMonth: null == aiGenerationsThisMonth ? _self.aiGenerationsThisMonth : aiGenerationsThisMonth // ignore: cast_nullable_to_non_nullable
as int,aiQuotaResetAt: freezed == aiQuotaResetAt ? _self.aiQuotaResetAt : aiQuotaResetAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AppUser].
extension AppUserPatterns on AppUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppUser value)  $default,){
final _that = this;
switch (_that) {
case _AppUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppUser value)?  $default,){
final _that = this;
switch (_that) {
case _AppUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  String displayName, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String createdBy,  String updatedBy,  String? photoUrl,  String? phoneNumber,  bool isEmailVerified,  bool isPremium,  SubscriptionTier subscriptionTier,  bool isOnline, @NullableTimestampConverter()  DateTime? lastSeenAt,  String locale,  String? timezone,  List<String> providerIds,  int listCount,  int completedItemCount,  int aiGenerationsThisMonth, @NullableTimestampConverter()  DateTime? aiQuotaResetAt, @NullableTimestampConverter()  DateTime? deletedAt,  int version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppUser() when $default != null:
return $default(_that.id,_that.email,_that.displayName,_that.createdAt,_that.updatedAt,_that.createdBy,_that.updatedBy,_that.photoUrl,_that.phoneNumber,_that.isEmailVerified,_that.isPremium,_that.subscriptionTier,_that.isOnline,_that.lastSeenAt,_that.locale,_that.timezone,_that.providerIds,_that.listCount,_that.completedItemCount,_that.aiGenerationsThisMonth,_that.aiQuotaResetAt,_that.deletedAt,_that.version);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  String displayName, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String createdBy,  String updatedBy,  String? photoUrl,  String? phoneNumber,  bool isEmailVerified,  bool isPremium,  SubscriptionTier subscriptionTier,  bool isOnline, @NullableTimestampConverter()  DateTime? lastSeenAt,  String locale,  String? timezone,  List<String> providerIds,  int listCount,  int completedItemCount,  int aiGenerationsThisMonth, @NullableTimestampConverter()  DateTime? aiQuotaResetAt, @NullableTimestampConverter()  DateTime? deletedAt,  int version)  $default,) {final _that = this;
switch (_that) {
case _AppUser():
return $default(_that.id,_that.email,_that.displayName,_that.createdAt,_that.updatedAt,_that.createdBy,_that.updatedBy,_that.photoUrl,_that.phoneNumber,_that.isEmailVerified,_that.isPremium,_that.subscriptionTier,_that.isOnline,_that.lastSeenAt,_that.locale,_that.timezone,_that.providerIds,_that.listCount,_that.completedItemCount,_that.aiGenerationsThisMonth,_that.aiQuotaResetAt,_that.deletedAt,_that.version);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  String displayName, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String createdBy,  String updatedBy,  String? photoUrl,  String? phoneNumber,  bool isEmailVerified,  bool isPremium,  SubscriptionTier subscriptionTier,  bool isOnline, @NullableTimestampConverter()  DateTime? lastSeenAt,  String locale,  String? timezone,  List<String> providerIds,  int listCount,  int completedItemCount,  int aiGenerationsThisMonth, @NullableTimestampConverter()  DateTime? aiQuotaResetAt, @NullableTimestampConverter()  DateTime? deletedAt,  int version)?  $default,) {final _that = this;
switch (_that) {
case _AppUser() when $default != null:
return $default(_that.id,_that.email,_that.displayName,_that.createdAt,_that.updatedAt,_that.createdBy,_that.updatedBy,_that.photoUrl,_that.phoneNumber,_that.isEmailVerified,_that.isPremium,_that.subscriptionTier,_that.isOnline,_that.lastSeenAt,_that.locale,_that.timezone,_that.providerIds,_that.listCount,_that.completedItemCount,_that.aiGenerationsThisMonth,_that.aiQuotaResetAt,_that.deletedAt,_that.version);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppUser implements AppUser {
  const _AppUser({required this.id, required this.email, required this.displayName, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt, required this.createdBy, required this.updatedBy, this.photoUrl, this.phoneNumber, this.isEmailVerified = false, this.isPremium = false, this.subscriptionTier = SubscriptionTier.free, this.isOnline = false, @NullableTimestampConverter() this.lastSeenAt, this.locale = 'en', this.timezone, final  List<String> providerIds = const <String>[], this.listCount = 0, this.completedItemCount = 0, this.aiGenerationsThisMonth = 0, @NullableTimestampConverter() this.aiQuotaResetAt, @NullableTimestampConverter() this.deletedAt, this.version = 1}): _providerIds = providerIds;
  factory _AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);

@override final  String id;
@override final  String email;
@override final  String displayName;
@override@TimestampConverter() final  DateTime createdAt;
@override@TimestampConverter() final  DateTime updatedAt;
@override final  String createdBy;
@override final  String updatedBy;
@override final  String? photoUrl;
@override final  String? phoneNumber;
@override@JsonKey() final  bool isEmailVerified;
@override@JsonKey() final  bool isPremium;
@override@JsonKey() final  SubscriptionTier subscriptionTier;
@override@JsonKey() final  bool isOnline;
@override@NullableTimestampConverter() final  DateTime? lastSeenAt;
@override@JsonKey() final  String locale;
@override final  String? timezone;
/// Identity providers linked to the account, e.g. `password`, `google.com`,
/// `apple.com`.
 final  List<String> _providerIds;
/// Identity providers linked to the account, e.g. `password`, `google.com`,
/// `apple.com`.
@override@JsonKey() List<String> get providerIds {
  if (_providerIds is EqualUnmodifiableListView) return _providerIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_providerIds);
}

/// Denormalised counters maintained by Cloud Functions; cheap to render on
/// the profile screen without fanning out reads.
@override@JsonKey() final  int listCount;
@override@JsonKey() final  int completedItemCount;
/// Number of AI generations consumed in the current billing month, used to
/// enforce the free-plan ceiling.
@override@JsonKey() final  int aiGenerationsThisMonth;
@override@NullableTimestampConverter() final  DateTime? aiQuotaResetAt;
@override@NullableTimestampConverter() final  DateTime? deletedAt;
@override@JsonKey() final  int version;

/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppUserCopyWith<_AppUser> get copyWith => __$AppUserCopyWithImpl<_AppUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppUser&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.updatedBy, updatedBy) || other.updatedBy == updatedBy)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.isEmailVerified, isEmailVerified) || other.isEmailVerified == isEmailVerified)&&(identical(other.isPremium, isPremium) || other.isPremium == isPremium)&&(identical(other.subscriptionTier, subscriptionTier) || other.subscriptionTier == subscriptionTier)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.lastSeenAt, lastSeenAt) || other.lastSeenAt == lastSeenAt)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&const DeepCollectionEquality().equals(other._providerIds, _providerIds)&&(identical(other.listCount, listCount) || other.listCount == listCount)&&(identical(other.completedItemCount, completedItemCount) || other.completedItemCount == completedItemCount)&&(identical(other.aiGenerationsThisMonth, aiGenerationsThisMonth) || other.aiGenerationsThisMonth == aiGenerationsThisMonth)&&(identical(other.aiQuotaResetAt, aiQuotaResetAt) || other.aiQuotaResetAt == aiQuotaResetAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,email,displayName,createdAt,updatedAt,createdBy,updatedBy,photoUrl,phoneNumber,isEmailVerified,isPremium,subscriptionTier,isOnline,lastSeenAt,locale,timezone,const DeepCollectionEquality().hash(_providerIds),listCount,completedItemCount,aiGenerationsThisMonth,aiQuotaResetAt,deletedAt,version]);

@override
String toString() {
  return 'AppUser(id: $id, email: $email, displayName: $displayName, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy, photoUrl: $photoUrl, phoneNumber: $phoneNumber, isEmailVerified: $isEmailVerified, isPremium: $isPremium, subscriptionTier: $subscriptionTier, isOnline: $isOnline, lastSeenAt: $lastSeenAt, locale: $locale, timezone: $timezone, providerIds: $providerIds, listCount: $listCount, completedItemCount: $completedItemCount, aiGenerationsThisMonth: $aiGenerationsThisMonth, aiQuotaResetAt: $aiQuotaResetAt, deletedAt: $deletedAt, version: $version)';
}


}

/// @nodoc
abstract mixin class _$AppUserCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$AppUserCopyWith(_AppUser value, $Res Function(_AppUser) _then) = __$AppUserCopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String displayName,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, String createdBy, String updatedBy, String? photoUrl, String? phoneNumber, bool isEmailVerified, bool isPremium, SubscriptionTier subscriptionTier, bool isOnline,@NullableTimestampConverter() DateTime? lastSeenAt, String locale, String? timezone, List<String> providerIds, int listCount, int completedItemCount, int aiGenerationsThisMonth,@NullableTimestampConverter() DateTime? aiQuotaResetAt,@NullableTimestampConverter() DateTime? deletedAt, int version
});




}
/// @nodoc
class __$AppUserCopyWithImpl<$Res>
    implements _$AppUserCopyWith<$Res> {
  __$AppUserCopyWithImpl(this._self, this._then);

  final _AppUser _self;
  final $Res Function(_AppUser) _then;

/// Create a copy of AppUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? displayName = null,Object? createdAt = null,Object? updatedAt = null,Object? createdBy = null,Object? updatedBy = null,Object? photoUrl = freezed,Object? phoneNumber = freezed,Object? isEmailVerified = null,Object? isPremium = null,Object? subscriptionTier = null,Object? isOnline = null,Object? lastSeenAt = freezed,Object? locale = null,Object? timezone = freezed,Object? providerIds = null,Object? listCount = null,Object? completedItemCount = null,Object? aiGenerationsThisMonth = null,Object? aiQuotaResetAt = freezed,Object? deletedAt = freezed,Object? version = null,}) {
  return _then(_AppUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,updatedBy: null == updatedBy ? _self.updatedBy : updatedBy // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,isEmailVerified: null == isEmailVerified ? _self.isEmailVerified : isEmailVerified // ignore: cast_nullable_to_non_nullable
as bool,isPremium: null == isPremium ? _self.isPremium : isPremium // ignore: cast_nullable_to_non_nullable
as bool,subscriptionTier: null == subscriptionTier ? _self.subscriptionTier : subscriptionTier // ignore: cast_nullable_to_non_nullable
as SubscriptionTier,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,lastSeenAt: freezed == lastSeenAt ? _self.lastSeenAt : lastSeenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,timezone: freezed == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String?,providerIds: null == providerIds ? _self._providerIds : providerIds // ignore: cast_nullable_to_non_nullable
as List<String>,listCount: null == listCount ? _self.listCount : listCount // ignore: cast_nullable_to_non_nullable
as int,completedItemCount: null == completedItemCount ? _self.completedItemCount : completedItemCount // ignore: cast_nullable_to_non_nullable
as int,aiGenerationsThisMonth: null == aiGenerationsThisMonth ? _self.aiGenerationsThisMonth : aiGenerationsThisMonth // ignore: cast_nullable_to_non_nullable
as int,aiQuotaResetAt: freezed == aiQuotaResetAt ? _self.aiQuotaResetAt : aiQuotaResetAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
