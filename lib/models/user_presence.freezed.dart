// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_presence.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserPresence {

 String get id; String get userId; String get listId;@TimestampConverter() DateTime get lastSeenAt; bool get isOnline; String get displayName; String? get photoUrl;/// Set while the member has a specific item open for editing, which the UI
/// uses to warn about a concurrent edit.
 String? get editingItemId; String get deviceId;
/// Create a copy of UserPresence
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserPresenceCopyWith<UserPresence> get copyWith => _$UserPresenceCopyWithImpl<UserPresence>(this as UserPresence, _$identity);

  /// Serializes this UserPresence to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserPresence&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.listId, listId) || other.listId == listId)&&(identical(other.lastSeenAt, lastSeenAt) || other.lastSeenAt == lastSeenAt)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.editingItemId, editingItemId) || other.editingItemId == editingItemId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,listId,lastSeenAt,isOnline,displayName,photoUrl,editingItemId,deviceId);

@override
String toString() {
  return 'UserPresence(id: $id, userId: $userId, listId: $listId, lastSeenAt: $lastSeenAt, isOnline: $isOnline, displayName: $displayName, photoUrl: $photoUrl, editingItemId: $editingItemId, deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class $UserPresenceCopyWith<$Res>  {
  factory $UserPresenceCopyWith(UserPresence value, $Res Function(UserPresence) _then) = _$UserPresenceCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String listId,@TimestampConverter() DateTime lastSeenAt, bool isOnline, String displayName, String? photoUrl, String? editingItemId, String deviceId
});




}
/// @nodoc
class _$UserPresenceCopyWithImpl<$Res>
    implements $UserPresenceCopyWith<$Res> {
  _$UserPresenceCopyWithImpl(this._self, this._then);

  final UserPresence _self;
  final $Res Function(UserPresence) _then;

/// Create a copy of UserPresence
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? listId = null,Object? lastSeenAt = null,Object? isOnline = null,Object? displayName = null,Object? photoUrl = freezed,Object? editingItemId = freezed,Object? deviceId = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,listId: null == listId ? _self.listId : listId // ignore: cast_nullable_to_non_nullable
as String,lastSeenAt: null == lastSeenAt ? _self.lastSeenAt : lastSeenAt // ignore: cast_nullable_to_non_nullable
as DateTime,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,editingItemId: freezed == editingItemId ? _self.editingItemId : editingItemId // ignore: cast_nullable_to_non_nullable
as String?,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UserPresence].
extension UserPresencePatterns on UserPresence {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserPresence value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserPresence() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserPresence value)  $default,){
final _that = this;
switch (_that) {
case _UserPresence():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserPresence value)?  $default,){
final _that = this;
switch (_that) {
case _UserPresence() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String listId, @TimestampConverter()  DateTime lastSeenAt,  bool isOnline,  String displayName,  String? photoUrl,  String? editingItemId,  String deviceId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserPresence() when $default != null:
return $default(_that.id,_that.userId,_that.listId,_that.lastSeenAt,_that.isOnline,_that.displayName,_that.photoUrl,_that.editingItemId,_that.deviceId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String listId, @TimestampConverter()  DateTime lastSeenAt,  bool isOnline,  String displayName,  String? photoUrl,  String? editingItemId,  String deviceId)  $default,) {final _that = this;
switch (_that) {
case _UserPresence():
return $default(_that.id,_that.userId,_that.listId,_that.lastSeenAt,_that.isOnline,_that.displayName,_that.photoUrl,_that.editingItemId,_that.deviceId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String listId, @TimestampConverter()  DateTime lastSeenAt,  bool isOnline,  String displayName,  String? photoUrl,  String? editingItemId,  String deviceId)?  $default,) {final _that = this;
switch (_that) {
case _UserPresence() when $default != null:
return $default(_that.id,_that.userId,_that.listId,_that.lastSeenAt,_that.isOnline,_that.displayName,_that.photoUrl,_that.editingItemId,_that.deviceId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserPresence implements UserPresence {
  const _UserPresence({required this.id, required this.userId, required this.listId, @TimestampConverter() required this.lastSeenAt, this.isOnline = false, this.displayName = '', this.photoUrl, this.editingItemId, this.deviceId = ''});
  factory _UserPresence.fromJson(Map<String, dynamic> json) => _$UserPresenceFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String listId;
@override@TimestampConverter() final  DateTime lastSeenAt;
@override@JsonKey() final  bool isOnline;
@override@JsonKey() final  String displayName;
@override final  String? photoUrl;
/// Set while the member has a specific item open for editing, which the UI
/// uses to warn about a concurrent edit.
@override final  String? editingItemId;
@override@JsonKey() final  String deviceId;

/// Create a copy of UserPresence
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserPresenceCopyWith<_UserPresence> get copyWith => __$UserPresenceCopyWithImpl<_UserPresence>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserPresenceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserPresence&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.listId, listId) || other.listId == listId)&&(identical(other.lastSeenAt, lastSeenAt) || other.lastSeenAt == lastSeenAt)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.editingItemId, editingItemId) || other.editingItemId == editingItemId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,listId,lastSeenAt,isOnline,displayName,photoUrl,editingItemId,deviceId);

@override
String toString() {
  return 'UserPresence(id: $id, userId: $userId, listId: $listId, lastSeenAt: $lastSeenAt, isOnline: $isOnline, displayName: $displayName, photoUrl: $photoUrl, editingItemId: $editingItemId, deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class _$UserPresenceCopyWith<$Res> implements $UserPresenceCopyWith<$Res> {
  factory _$UserPresenceCopyWith(_UserPresence value, $Res Function(_UserPresence) _then) = __$UserPresenceCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String listId,@TimestampConverter() DateTime lastSeenAt, bool isOnline, String displayName, String? photoUrl, String? editingItemId, String deviceId
});




}
/// @nodoc
class __$UserPresenceCopyWithImpl<$Res>
    implements _$UserPresenceCopyWith<$Res> {
  __$UserPresenceCopyWithImpl(this._self, this._then);

  final _UserPresence _self;
  final $Res Function(_UserPresence) _then;

/// Create a copy of UserPresence
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? listId = null,Object? lastSeenAt = null,Object? isOnline = null,Object? displayName = null,Object? photoUrl = freezed,Object? editingItemId = freezed,Object? deviceId = null,}) {
  return _then(_UserPresence(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,listId: null == listId ? _self.listId : listId // ignore: cast_nullable_to_non_nullable
as String,lastSeenAt: null == lastSeenAt ? _self.lastSeenAt : lastSeenAt // ignore: cast_nullable_to_non_nullable
as DateTime,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,editingItemId: freezed == editingItemId ? _self.editingItemId : editingItemId // ignore: cast_nullable_to_non_nullable
as String?,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
