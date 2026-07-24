// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeviceToken {

 String get id; String get userId; String get token; DevicePlatform get platform;@TimestampConverter() DateTime get createdAt;@TimestampConverter() DateTime get updatedAt; bool get isActive; String get deviceModel; String get osVersion; String get appVersion; String get locale; String get timezone;@NullableTimestampConverter() DateTime? get lastUsedAt;
/// Create a copy of DeviceToken
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceTokenCopyWith<DeviceToken> get copyWith => _$DeviceTokenCopyWithImpl<DeviceToken>(this as DeviceToken, _$identity);

  /// Serializes this DeviceToken to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceToken&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.token, token) || other.token == token)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.deviceModel, deviceModel) || other.deviceModel == deviceModel)&&(identical(other.osVersion, osVersion) || other.osVersion == osVersion)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.lastUsedAt, lastUsedAt) || other.lastUsedAt == lastUsedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,token,platform,createdAt,updatedAt,isActive,deviceModel,osVersion,appVersion,locale,timezone,lastUsedAt);

@override
String toString() {
  return 'DeviceToken(id: $id, userId: $userId, token: $token, platform: $platform, createdAt: $createdAt, updatedAt: $updatedAt, isActive: $isActive, deviceModel: $deviceModel, osVersion: $osVersion, appVersion: $appVersion, locale: $locale, timezone: $timezone, lastUsedAt: $lastUsedAt)';
}


}

/// @nodoc
abstract mixin class $DeviceTokenCopyWith<$Res>  {
  factory $DeviceTokenCopyWith(DeviceToken value, $Res Function(DeviceToken) _then) = _$DeviceTokenCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String token, DevicePlatform platform,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, bool isActive, String deviceModel, String osVersion, String appVersion, String locale, String timezone,@NullableTimestampConverter() DateTime? lastUsedAt
});




}
/// @nodoc
class _$DeviceTokenCopyWithImpl<$Res>
    implements $DeviceTokenCopyWith<$Res> {
  _$DeviceTokenCopyWithImpl(this._self, this._then);

  final DeviceToken _self;
  final $Res Function(DeviceToken) _then;

/// Create a copy of DeviceToken
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? token = null,Object? platform = null,Object? createdAt = null,Object? updatedAt = null,Object? isActive = null,Object? deviceModel = null,Object? osVersion = null,Object? appVersion = null,Object? locale = null,Object? timezone = null,Object? lastUsedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as DevicePlatform,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,deviceModel: null == deviceModel ? _self.deviceModel : deviceModel // ignore: cast_nullable_to_non_nullable
as String,osVersion: null == osVersion ? _self.osVersion : osVersion // ignore: cast_nullable_to_non_nullable
as String,appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,lastUsedAt: freezed == lastUsedAt ? _self.lastUsedAt : lastUsedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceToken].
extension DeviceTokenPatterns on DeviceToken {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceToken value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceToken() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceToken value)  $default,){
final _that = this;
switch (_that) {
case _DeviceToken():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceToken value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceToken() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String token,  DevicePlatform platform, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  bool isActive,  String deviceModel,  String osVersion,  String appVersion,  String locale,  String timezone, @NullableTimestampConverter()  DateTime? lastUsedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceToken() when $default != null:
return $default(_that.id,_that.userId,_that.token,_that.platform,_that.createdAt,_that.updatedAt,_that.isActive,_that.deviceModel,_that.osVersion,_that.appVersion,_that.locale,_that.timezone,_that.lastUsedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String token,  DevicePlatform platform, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  bool isActive,  String deviceModel,  String osVersion,  String appVersion,  String locale,  String timezone, @NullableTimestampConverter()  DateTime? lastUsedAt)  $default,) {final _that = this;
switch (_that) {
case _DeviceToken():
return $default(_that.id,_that.userId,_that.token,_that.platform,_that.createdAt,_that.updatedAt,_that.isActive,_that.deviceModel,_that.osVersion,_that.appVersion,_that.locale,_that.timezone,_that.lastUsedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String token,  DevicePlatform platform, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  bool isActive,  String deviceModel,  String osVersion,  String appVersion,  String locale,  String timezone, @NullableTimestampConverter()  DateTime? lastUsedAt)?  $default,) {final _that = this;
switch (_that) {
case _DeviceToken() when $default != null:
return $default(_that.id,_that.userId,_that.token,_that.platform,_that.createdAt,_that.updatedAt,_that.isActive,_that.deviceModel,_that.osVersion,_that.appVersion,_that.locale,_that.timezone,_that.lastUsedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceToken implements DeviceToken {
  const _DeviceToken({required this.id, required this.userId, required this.token, required this.platform, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt, this.isActive = true, this.deviceModel = '', this.osVersion = '', this.appVersion = '', this.locale = 'en', this.timezone = '', @NullableTimestampConverter() this.lastUsedAt});
  factory _DeviceToken.fromJson(Map<String, dynamic> json) => _$DeviceTokenFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String token;
@override final  DevicePlatform platform;
@override@TimestampConverter() final  DateTime createdAt;
@override@TimestampConverter() final  DateTime updatedAt;
@override@JsonKey() final  bool isActive;
@override@JsonKey() final  String deviceModel;
@override@JsonKey() final  String osVersion;
@override@JsonKey() final  String appVersion;
@override@JsonKey() final  String locale;
@override@JsonKey() final  String timezone;
@override@NullableTimestampConverter() final  DateTime? lastUsedAt;

/// Create a copy of DeviceToken
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceTokenCopyWith<_DeviceToken> get copyWith => __$DeviceTokenCopyWithImpl<_DeviceToken>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceTokenToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceToken&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.token, token) || other.token == token)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.deviceModel, deviceModel) || other.deviceModel == deviceModel)&&(identical(other.osVersion, osVersion) || other.osVersion == osVersion)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.lastUsedAt, lastUsedAt) || other.lastUsedAt == lastUsedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,token,platform,createdAt,updatedAt,isActive,deviceModel,osVersion,appVersion,locale,timezone,lastUsedAt);

@override
String toString() {
  return 'DeviceToken(id: $id, userId: $userId, token: $token, platform: $platform, createdAt: $createdAt, updatedAt: $updatedAt, isActive: $isActive, deviceModel: $deviceModel, osVersion: $osVersion, appVersion: $appVersion, locale: $locale, timezone: $timezone, lastUsedAt: $lastUsedAt)';
}


}

/// @nodoc
abstract mixin class _$DeviceTokenCopyWith<$Res> implements $DeviceTokenCopyWith<$Res> {
  factory _$DeviceTokenCopyWith(_DeviceToken value, $Res Function(_DeviceToken) _then) = __$DeviceTokenCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String token, DevicePlatform platform,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, bool isActive, String deviceModel, String osVersion, String appVersion, String locale, String timezone,@NullableTimestampConverter() DateTime? lastUsedAt
});




}
/// @nodoc
class __$DeviceTokenCopyWithImpl<$Res>
    implements _$DeviceTokenCopyWith<$Res> {
  __$DeviceTokenCopyWithImpl(this._self, this._then);

  final _DeviceToken _self;
  final $Res Function(_DeviceToken) _then;

/// Create a copy of DeviceToken
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? token = null,Object? platform = null,Object? createdAt = null,Object? updatedAt = null,Object? isActive = null,Object? deviceModel = null,Object? osVersion = null,Object? appVersion = null,Object? locale = null,Object? timezone = null,Object? lastUsedAt = freezed,}) {
  return _then(_DeviceToken(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as DevicePlatform,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,deviceModel: null == deviceModel ? _self.deviceModel : deviceModel // ignore: cast_nullable_to_non_nullable
as String,osVersion: null == osVersion ? _self.osVersion : osVersion // ignore: cast_nullable_to_non_nullable
as String,appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,lastUsedAt: freezed == lastUsedAt ? _self.lastUsedAt : lastUsedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
