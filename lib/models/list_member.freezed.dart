// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ListMember {

 String get id; String get userId; String get listId; MemberRole get role;@TimestampConverter() DateTime get createdAt;@TimestampConverter() DateTime get updatedAt; String get createdBy; String get updatedBy; String get displayName; String get email; String? get photoUrl;@NullableTimestampConverter() DateTime? get joinedAt;/// Who invited this member; null for the list creator.
 String? get invitedBy;/// Denormalised per-member contribution counters, maintained by Cloud
/// Functions and surfaced in list statistics.
 int get itemsAdded; int get itemsCompleted;@NullableTimestampConverter() DateTime? get deletedAt; int get version;
/// Create a copy of ListMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListMemberCopyWith<ListMember> get copyWith => _$ListMemberCopyWithImpl<ListMember>(this as ListMember, _$identity);

  /// Serializes this ListMember to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListMember&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.listId, listId) || other.listId == listId)&&(identical(other.role, role) || other.role == role)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.updatedBy, updatedBy) || other.updatedBy == updatedBy)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.email, email) || other.email == email)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.invitedBy, invitedBy) || other.invitedBy == invitedBy)&&(identical(other.itemsAdded, itemsAdded) || other.itemsAdded == itemsAdded)&&(identical(other.itemsCompleted, itemsCompleted) || other.itemsCompleted == itemsCompleted)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,listId,role,createdAt,updatedAt,createdBy,updatedBy,displayName,email,photoUrl,joinedAt,invitedBy,itemsAdded,itemsCompleted,deletedAt,version);

@override
String toString() {
  return 'ListMember(id: $id, userId: $userId, listId: $listId, role: $role, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy, displayName: $displayName, email: $email, photoUrl: $photoUrl, joinedAt: $joinedAt, invitedBy: $invitedBy, itemsAdded: $itemsAdded, itemsCompleted: $itemsCompleted, deletedAt: $deletedAt, version: $version)';
}


}

/// @nodoc
abstract mixin class $ListMemberCopyWith<$Res>  {
  factory $ListMemberCopyWith(ListMember value, $Res Function(ListMember) _then) = _$ListMemberCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String listId, MemberRole role,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, String createdBy, String updatedBy, String displayName, String email, String? photoUrl,@NullableTimestampConverter() DateTime? joinedAt, String? invitedBy, int itemsAdded, int itemsCompleted,@NullableTimestampConverter() DateTime? deletedAt, int version
});




}
/// @nodoc
class _$ListMemberCopyWithImpl<$Res>
    implements $ListMemberCopyWith<$Res> {
  _$ListMemberCopyWithImpl(this._self, this._then);

  final ListMember _self;
  final $Res Function(ListMember) _then;

/// Create a copy of ListMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? listId = null,Object? role = null,Object? createdAt = null,Object? updatedAt = null,Object? createdBy = null,Object? updatedBy = null,Object? displayName = null,Object? email = null,Object? photoUrl = freezed,Object? joinedAt = freezed,Object? invitedBy = freezed,Object? itemsAdded = null,Object? itemsCompleted = null,Object? deletedAt = freezed,Object? version = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,listId: null == listId ? _self.listId : listId // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as MemberRole,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,updatedBy: null == updatedBy ? _self.updatedBy : updatedBy // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,invitedBy: freezed == invitedBy ? _self.invitedBy : invitedBy // ignore: cast_nullable_to_non_nullable
as String?,itemsAdded: null == itemsAdded ? _self.itemsAdded : itemsAdded // ignore: cast_nullable_to_non_nullable
as int,itemsCompleted: null == itemsCompleted ? _self.itemsCompleted : itemsCompleted // ignore: cast_nullable_to_non_nullable
as int,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ListMember].
extension ListMemberPatterns on ListMember {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListMember value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListMember() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListMember value)  $default,){
final _that = this;
switch (_that) {
case _ListMember():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListMember value)?  $default,){
final _that = this;
switch (_that) {
case _ListMember() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String listId,  MemberRole role, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String createdBy,  String updatedBy,  String displayName,  String email,  String? photoUrl, @NullableTimestampConverter()  DateTime? joinedAt,  String? invitedBy,  int itemsAdded,  int itemsCompleted, @NullableTimestampConverter()  DateTime? deletedAt,  int version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListMember() when $default != null:
return $default(_that.id,_that.userId,_that.listId,_that.role,_that.createdAt,_that.updatedAt,_that.createdBy,_that.updatedBy,_that.displayName,_that.email,_that.photoUrl,_that.joinedAt,_that.invitedBy,_that.itemsAdded,_that.itemsCompleted,_that.deletedAt,_that.version);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String listId,  MemberRole role, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String createdBy,  String updatedBy,  String displayName,  String email,  String? photoUrl, @NullableTimestampConverter()  DateTime? joinedAt,  String? invitedBy,  int itemsAdded,  int itemsCompleted, @NullableTimestampConverter()  DateTime? deletedAt,  int version)  $default,) {final _that = this;
switch (_that) {
case _ListMember():
return $default(_that.id,_that.userId,_that.listId,_that.role,_that.createdAt,_that.updatedAt,_that.createdBy,_that.updatedBy,_that.displayName,_that.email,_that.photoUrl,_that.joinedAt,_that.invitedBy,_that.itemsAdded,_that.itemsCompleted,_that.deletedAt,_that.version);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String listId,  MemberRole role, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String createdBy,  String updatedBy,  String displayName,  String email,  String? photoUrl, @NullableTimestampConverter()  DateTime? joinedAt,  String? invitedBy,  int itemsAdded,  int itemsCompleted, @NullableTimestampConverter()  DateTime? deletedAt,  int version)?  $default,) {final _that = this;
switch (_that) {
case _ListMember() when $default != null:
return $default(_that.id,_that.userId,_that.listId,_that.role,_that.createdAt,_that.updatedAt,_that.createdBy,_that.updatedBy,_that.displayName,_that.email,_that.photoUrl,_that.joinedAt,_that.invitedBy,_that.itemsAdded,_that.itemsCompleted,_that.deletedAt,_that.version);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ListMember implements ListMember {
  const _ListMember({required this.id, required this.userId, required this.listId, required this.role, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt, required this.createdBy, required this.updatedBy, this.displayName = '', this.email = '', this.photoUrl, @NullableTimestampConverter() this.joinedAt, this.invitedBy, this.itemsAdded = 0, this.itemsCompleted = 0, @NullableTimestampConverter() this.deletedAt, this.version = 1});
  factory _ListMember.fromJson(Map<String, dynamic> json) => _$ListMemberFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String listId;
@override final  MemberRole role;
@override@TimestampConverter() final  DateTime createdAt;
@override@TimestampConverter() final  DateTime updatedAt;
@override final  String createdBy;
@override final  String updatedBy;
@override@JsonKey() final  String displayName;
@override@JsonKey() final  String email;
@override final  String? photoUrl;
@override@NullableTimestampConverter() final  DateTime? joinedAt;
/// Who invited this member; null for the list creator.
@override final  String? invitedBy;
/// Denormalised per-member contribution counters, maintained by Cloud
/// Functions and surfaced in list statistics.
@override@JsonKey() final  int itemsAdded;
@override@JsonKey() final  int itemsCompleted;
@override@NullableTimestampConverter() final  DateTime? deletedAt;
@override@JsonKey() final  int version;

/// Create a copy of ListMember
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListMemberCopyWith<_ListMember> get copyWith => __$ListMemberCopyWithImpl<_ListMember>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListMemberToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListMember&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.listId, listId) || other.listId == listId)&&(identical(other.role, role) || other.role == role)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.updatedBy, updatedBy) || other.updatedBy == updatedBy)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.email, email) || other.email == email)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.invitedBy, invitedBy) || other.invitedBy == invitedBy)&&(identical(other.itemsAdded, itemsAdded) || other.itemsAdded == itemsAdded)&&(identical(other.itemsCompleted, itemsCompleted) || other.itemsCompleted == itemsCompleted)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,listId,role,createdAt,updatedAt,createdBy,updatedBy,displayName,email,photoUrl,joinedAt,invitedBy,itemsAdded,itemsCompleted,deletedAt,version);

@override
String toString() {
  return 'ListMember(id: $id, userId: $userId, listId: $listId, role: $role, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy, displayName: $displayName, email: $email, photoUrl: $photoUrl, joinedAt: $joinedAt, invitedBy: $invitedBy, itemsAdded: $itemsAdded, itemsCompleted: $itemsCompleted, deletedAt: $deletedAt, version: $version)';
}


}

/// @nodoc
abstract mixin class _$ListMemberCopyWith<$Res> implements $ListMemberCopyWith<$Res> {
  factory _$ListMemberCopyWith(_ListMember value, $Res Function(_ListMember) _then) = __$ListMemberCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String listId, MemberRole role,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, String createdBy, String updatedBy, String displayName, String email, String? photoUrl,@NullableTimestampConverter() DateTime? joinedAt, String? invitedBy, int itemsAdded, int itemsCompleted,@NullableTimestampConverter() DateTime? deletedAt, int version
});




}
/// @nodoc
class __$ListMemberCopyWithImpl<$Res>
    implements _$ListMemberCopyWith<$Res> {
  __$ListMemberCopyWithImpl(this._self, this._then);

  final _ListMember _self;
  final $Res Function(_ListMember) _then;

/// Create a copy of ListMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? listId = null,Object? role = null,Object? createdAt = null,Object? updatedAt = null,Object? createdBy = null,Object? updatedBy = null,Object? displayName = null,Object? email = null,Object? photoUrl = freezed,Object? joinedAt = freezed,Object? invitedBy = freezed,Object? itemsAdded = null,Object? itemsCompleted = null,Object? deletedAt = freezed,Object? version = null,}) {
  return _then(_ListMember(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,listId: null == listId ? _self.listId : listId // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as MemberRole,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,updatedBy: null == updatedBy ? _self.updatedBy : updatedBy // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,invitedBy: freezed == invitedBy ? _self.invitedBy : invitedBy // ignore: cast_nullable_to_non_nullable
as String?,itemsAdded: null == itemsAdded ? _self.itemsAdded : itemsAdded // ignore: cast_nullable_to_non_nullable
as int,itemsCompleted: null == itemsCompleted ? _self.itemsCompleted : itemsCompleted // ignore: cast_nullable_to_non_nullable
as int,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
