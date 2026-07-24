// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActivityLog {

 String get id; String get listId; String get actorId; ActivityAction get action;@TimestampConverter() DateTime get createdAt;/// Denormalised actor identity; the feed must stay readable after a member
/// leaves the list.
 String get actorName; String? get actorPhotoUrl;/// Entity the action was performed on, when applicable.
 String? get targetId; String get targetName;/// Additional non-indexed context, e.g. the previous and new role.
 Map<String, String> get metadata;
/// Create a copy of ActivityLog
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityLogCopyWith<ActivityLog> get copyWith => _$ActivityLogCopyWithImpl<ActivityLog>(this as ActivityLog, _$identity);

  /// Serializes this ActivityLog to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityLog&&(identical(other.id, id) || other.id == id)&&(identical(other.listId, listId) || other.listId == listId)&&(identical(other.actorId, actorId) || other.actorId == actorId)&&(identical(other.action, action) || other.action == action)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.actorName, actorName) || other.actorName == actorName)&&(identical(other.actorPhotoUrl, actorPhotoUrl) || other.actorPhotoUrl == actorPhotoUrl)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.targetName, targetName) || other.targetName == targetName)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,listId,actorId,action,createdAt,actorName,actorPhotoUrl,targetId,targetName,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'ActivityLog(id: $id, listId: $listId, actorId: $actorId, action: $action, createdAt: $createdAt, actorName: $actorName, actorPhotoUrl: $actorPhotoUrl, targetId: $targetId, targetName: $targetName, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $ActivityLogCopyWith<$Res>  {
  factory $ActivityLogCopyWith(ActivityLog value, $Res Function(ActivityLog) _then) = _$ActivityLogCopyWithImpl;
@useResult
$Res call({
 String id, String listId, String actorId, ActivityAction action,@TimestampConverter() DateTime createdAt, String actorName, String? actorPhotoUrl, String? targetId, String targetName, Map<String, String> metadata
});




}
/// @nodoc
class _$ActivityLogCopyWithImpl<$Res>
    implements $ActivityLogCopyWith<$Res> {
  _$ActivityLogCopyWithImpl(this._self, this._then);

  final ActivityLog _self;
  final $Res Function(ActivityLog) _then;

/// Create a copy of ActivityLog
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? listId = null,Object? actorId = null,Object? action = null,Object? createdAt = null,Object? actorName = null,Object? actorPhotoUrl = freezed,Object? targetId = freezed,Object? targetName = null,Object? metadata = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,listId: null == listId ? _self.listId : listId // ignore: cast_nullable_to_non_nullable
as String,actorId: null == actorId ? _self.actorId : actorId // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as ActivityAction,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,actorName: null == actorName ? _self.actorName : actorName // ignore: cast_nullable_to_non_nullable
as String,actorPhotoUrl: freezed == actorPhotoUrl ? _self.actorPhotoUrl : actorPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,targetId: freezed == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String?,targetName: null == targetName ? _self.targetName : targetName // ignore: cast_nullable_to_non_nullable
as String,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivityLog].
extension ActivityLogPatterns on ActivityLog {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityLog value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityLog() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityLog value)  $default,){
final _that = this;
switch (_that) {
case _ActivityLog():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityLog value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityLog() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String listId,  String actorId,  ActivityAction action, @TimestampConverter()  DateTime createdAt,  String actorName,  String? actorPhotoUrl,  String? targetId,  String targetName,  Map<String, String> metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityLog() when $default != null:
return $default(_that.id,_that.listId,_that.actorId,_that.action,_that.createdAt,_that.actorName,_that.actorPhotoUrl,_that.targetId,_that.targetName,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String listId,  String actorId,  ActivityAction action, @TimestampConverter()  DateTime createdAt,  String actorName,  String? actorPhotoUrl,  String? targetId,  String targetName,  Map<String, String> metadata)  $default,) {final _that = this;
switch (_that) {
case _ActivityLog():
return $default(_that.id,_that.listId,_that.actorId,_that.action,_that.createdAt,_that.actorName,_that.actorPhotoUrl,_that.targetId,_that.targetName,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String listId,  String actorId,  ActivityAction action, @TimestampConverter()  DateTime createdAt,  String actorName,  String? actorPhotoUrl,  String? targetId,  String targetName,  Map<String, String> metadata)?  $default,) {final _that = this;
switch (_that) {
case _ActivityLog() when $default != null:
return $default(_that.id,_that.listId,_that.actorId,_that.action,_that.createdAt,_that.actorName,_that.actorPhotoUrl,_that.targetId,_that.targetName,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivityLog implements ActivityLog {
  const _ActivityLog({required this.id, required this.listId, required this.actorId, required this.action, @TimestampConverter() required this.createdAt, this.actorName = '', this.actorPhotoUrl, this.targetId, this.targetName = '', final  Map<String, String> metadata = const <String, String>{}}): _metadata = metadata;
  factory _ActivityLog.fromJson(Map<String, dynamic> json) => _$ActivityLogFromJson(json);

@override final  String id;
@override final  String listId;
@override final  String actorId;
@override final  ActivityAction action;
@override@TimestampConverter() final  DateTime createdAt;
/// Denormalised actor identity; the feed must stay readable after a member
/// leaves the list.
@override@JsonKey() final  String actorName;
@override final  String? actorPhotoUrl;
/// Entity the action was performed on, when applicable.
@override final  String? targetId;
@override@JsonKey() final  String targetName;
/// Additional non-indexed context, e.g. the previous and new role.
 final  Map<String, String> _metadata;
/// Additional non-indexed context, e.g. the previous and new role.
@override@JsonKey() Map<String, String> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}


/// Create a copy of ActivityLog
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityLogCopyWith<_ActivityLog> get copyWith => __$ActivityLogCopyWithImpl<_ActivityLog>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityLogToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityLog&&(identical(other.id, id) || other.id == id)&&(identical(other.listId, listId) || other.listId == listId)&&(identical(other.actorId, actorId) || other.actorId == actorId)&&(identical(other.action, action) || other.action == action)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.actorName, actorName) || other.actorName == actorName)&&(identical(other.actorPhotoUrl, actorPhotoUrl) || other.actorPhotoUrl == actorPhotoUrl)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.targetName, targetName) || other.targetName == targetName)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,listId,actorId,action,createdAt,actorName,actorPhotoUrl,targetId,targetName,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'ActivityLog(id: $id, listId: $listId, actorId: $actorId, action: $action, createdAt: $createdAt, actorName: $actorName, actorPhotoUrl: $actorPhotoUrl, targetId: $targetId, targetName: $targetName, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$ActivityLogCopyWith<$Res> implements $ActivityLogCopyWith<$Res> {
  factory _$ActivityLogCopyWith(_ActivityLog value, $Res Function(_ActivityLog) _then) = __$ActivityLogCopyWithImpl;
@override @useResult
$Res call({
 String id, String listId, String actorId, ActivityAction action,@TimestampConverter() DateTime createdAt, String actorName, String? actorPhotoUrl, String? targetId, String targetName, Map<String, String> metadata
});




}
/// @nodoc
class __$ActivityLogCopyWithImpl<$Res>
    implements _$ActivityLogCopyWith<$Res> {
  __$ActivityLogCopyWithImpl(this._self, this._then);

  final _ActivityLog _self;
  final $Res Function(_ActivityLog) _then;

/// Create a copy of ActivityLog
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? listId = null,Object? actorId = null,Object? action = null,Object? createdAt = null,Object? actorName = null,Object? actorPhotoUrl = freezed,Object? targetId = freezed,Object? targetName = null,Object? metadata = null,}) {
  return _then(_ActivityLog(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,listId: null == listId ? _self.listId : listId // ignore: cast_nullable_to_non_nullable
as String,actorId: null == actorId ? _self.actorId : actorId // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as ActivityAction,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,actorName: null == actorName ? _self.actorName : actorName // ignore: cast_nullable_to_non_nullable
as String,actorPhotoUrl: freezed == actorPhotoUrl ? _self.actorPhotoUrl : actorPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,targetId: freezed == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String?,targetName: null == targetName ? _self.targetName : targetName // ignore: cast_nullable_to_non_nullable
as String,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}


}

// dart format on
