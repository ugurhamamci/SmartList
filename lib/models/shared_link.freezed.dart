// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shared_link.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SharedLink {

 String get id; String get listId; MemberRole get role;@TimestampConverter() DateTime get createdAt;@TimestampConverter() DateTime get updatedAt; String get createdBy; String get updatedBy;/// Short, URL-safe token embedded in the shareable URL.
 String get slug; bool get isActive;/// Preview shown on the join screen before membership is granted.
 String get listTitle; String get listEmoji; int get useCount;/// Optional ceiling on redemptions; null means unlimited.
 int? get maxUses;@NullableTimestampConverter() DateTime? get expiresAt;@NullableTimestampConverter() DateTime? get deletedAt; int get version;
/// Create a copy of SharedLink
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SharedLinkCopyWith<SharedLink> get copyWith => _$SharedLinkCopyWithImpl<SharedLink>(this as SharedLink, _$identity);

  /// Serializes this SharedLink to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SharedLink&&(identical(other.id, id) || other.id == id)&&(identical(other.listId, listId) || other.listId == listId)&&(identical(other.role, role) || other.role == role)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.updatedBy, updatedBy) || other.updatedBy == updatedBy)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.listTitle, listTitle) || other.listTitle == listTitle)&&(identical(other.listEmoji, listEmoji) || other.listEmoji == listEmoji)&&(identical(other.useCount, useCount) || other.useCount == useCount)&&(identical(other.maxUses, maxUses) || other.maxUses == maxUses)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,listId,role,createdAt,updatedAt,createdBy,updatedBy,slug,isActive,listTitle,listEmoji,useCount,maxUses,expiresAt,deletedAt,version);

@override
String toString() {
  return 'SharedLink(id: $id, listId: $listId, role: $role, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy, slug: $slug, isActive: $isActive, listTitle: $listTitle, listEmoji: $listEmoji, useCount: $useCount, maxUses: $maxUses, expiresAt: $expiresAt, deletedAt: $deletedAt, version: $version)';
}


}

/// @nodoc
abstract mixin class $SharedLinkCopyWith<$Res>  {
  factory $SharedLinkCopyWith(SharedLink value, $Res Function(SharedLink) _then) = _$SharedLinkCopyWithImpl;
@useResult
$Res call({
 String id, String listId, MemberRole role,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, String createdBy, String updatedBy, String slug, bool isActive, String listTitle, String listEmoji, int useCount, int? maxUses,@NullableTimestampConverter() DateTime? expiresAt,@NullableTimestampConverter() DateTime? deletedAt, int version
});




}
/// @nodoc
class _$SharedLinkCopyWithImpl<$Res>
    implements $SharedLinkCopyWith<$Res> {
  _$SharedLinkCopyWithImpl(this._self, this._then);

  final SharedLink _self;
  final $Res Function(SharedLink) _then;

/// Create a copy of SharedLink
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? listId = null,Object? role = null,Object? createdAt = null,Object? updatedAt = null,Object? createdBy = null,Object? updatedBy = null,Object? slug = null,Object? isActive = null,Object? listTitle = null,Object? listEmoji = null,Object? useCount = null,Object? maxUses = freezed,Object? expiresAt = freezed,Object? deletedAt = freezed,Object? version = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,listId: null == listId ? _self.listId : listId // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as MemberRole,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,updatedBy: null == updatedBy ? _self.updatedBy : updatedBy // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,listTitle: null == listTitle ? _self.listTitle : listTitle // ignore: cast_nullable_to_non_nullable
as String,listEmoji: null == listEmoji ? _self.listEmoji : listEmoji // ignore: cast_nullable_to_non_nullable
as String,useCount: null == useCount ? _self.useCount : useCount // ignore: cast_nullable_to_non_nullable
as int,maxUses: freezed == maxUses ? _self.maxUses : maxUses // ignore: cast_nullable_to_non_nullable
as int?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SharedLink].
extension SharedLinkPatterns on SharedLink {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SharedLink value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SharedLink() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SharedLink value)  $default,){
final _that = this;
switch (_that) {
case _SharedLink():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SharedLink value)?  $default,){
final _that = this;
switch (_that) {
case _SharedLink() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String listId,  MemberRole role, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String createdBy,  String updatedBy,  String slug,  bool isActive,  String listTitle,  String listEmoji,  int useCount,  int? maxUses, @NullableTimestampConverter()  DateTime? expiresAt, @NullableTimestampConverter()  DateTime? deletedAt,  int version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SharedLink() when $default != null:
return $default(_that.id,_that.listId,_that.role,_that.createdAt,_that.updatedAt,_that.createdBy,_that.updatedBy,_that.slug,_that.isActive,_that.listTitle,_that.listEmoji,_that.useCount,_that.maxUses,_that.expiresAt,_that.deletedAt,_that.version);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String listId,  MemberRole role, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String createdBy,  String updatedBy,  String slug,  bool isActive,  String listTitle,  String listEmoji,  int useCount,  int? maxUses, @NullableTimestampConverter()  DateTime? expiresAt, @NullableTimestampConverter()  DateTime? deletedAt,  int version)  $default,) {final _that = this;
switch (_that) {
case _SharedLink():
return $default(_that.id,_that.listId,_that.role,_that.createdAt,_that.updatedAt,_that.createdBy,_that.updatedBy,_that.slug,_that.isActive,_that.listTitle,_that.listEmoji,_that.useCount,_that.maxUses,_that.expiresAt,_that.deletedAt,_that.version);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String listId,  MemberRole role, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String createdBy,  String updatedBy,  String slug,  bool isActive,  String listTitle,  String listEmoji,  int useCount,  int? maxUses, @NullableTimestampConverter()  DateTime? expiresAt, @NullableTimestampConverter()  DateTime? deletedAt,  int version)?  $default,) {final _that = this;
switch (_that) {
case _SharedLink() when $default != null:
return $default(_that.id,_that.listId,_that.role,_that.createdAt,_that.updatedAt,_that.createdBy,_that.updatedBy,_that.slug,_that.isActive,_that.listTitle,_that.listEmoji,_that.useCount,_that.maxUses,_that.expiresAt,_that.deletedAt,_that.version);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SharedLink implements SharedLink {
  const _SharedLink({required this.id, required this.listId, required this.role, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt, required this.createdBy, required this.updatedBy, required this.slug, this.isActive = true, this.listTitle = '', this.listEmoji = '🛒', this.useCount = 0, this.maxUses, @NullableTimestampConverter() this.expiresAt, @NullableTimestampConverter() this.deletedAt, this.version = 1});
  factory _SharedLink.fromJson(Map<String, dynamic> json) => _$SharedLinkFromJson(json);

@override final  String id;
@override final  String listId;
@override final  MemberRole role;
@override@TimestampConverter() final  DateTime createdAt;
@override@TimestampConverter() final  DateTime updatedAt;
@override final  String createdBy;
@override final  String updatedBy;
/// Short, URL-safe token embedded in the shareable URL.
@override final  String slug;
@override@JsonKey() final  bool isActive;
/// Preview shown on the join screen before membership is granted.
@override@JsonKey() final  String listTitle;
@override@JsonKey() final  String listEmoji;
@override@JsonKey() final  int useCount;
/// Optional ceiling on redemptions; null means unlimited.
@override final  int? maxUses;
@override@NullableTimestampConverter() final  DateTime? expiresAt;
@override@NullableTimestampConverter() final  DateTime? deletedAt;
@override@JsonKey() final  int version;

/// Create a copy of SharedLink
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SharedLinkCopyWith<_SharedLink> get copyWith => __$SharedLinkCopyWithImpl<_SharedLink>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SharedLinkToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SharedLink&&(identical(other.id, id) || other.id == id)&&(identical(other.listId, listId) || other.listId == listId)&&(identical(other.role, role) || other.role == role)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.updatedBy, updatedBy) || other.updatedBy == updatedBy)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.listTitle, listTitle) || other.listTitle == listTitle)&&(identical(other.listEmoji, listEmoji) || other.listEmoji == listEmoji)&&(identical(other.useCount, useCount) || other.useCount == useCount)&&(identical(other.maxUses, maxUses) || other.maxUses == maxUses)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,listId,role,createdAt,updatedAt,createdBy,updatedBy,slug,isActive,listTitle,listEmoji,useCount,maxUses,expiresAt,deletedAt,version);

@override
String toString() {
  return 'SharedLink(id: $id, listId: $listId, role: $role, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy, slug: $slug, isActive: $isActive, listTitle: $listTitle, listEmoji: $listEmoji, useCount: $useCount, maxUses: $maxUses, expiresAt: $expiresAt, deletedAt: $deletedAt, version: $version)';
}


}

/// @nodoc
abstract mixin class _$SharedLinkCopyWith<$Res> implements $SharedLinkCopyWith<$Res> {
  factory _$SharedLinkCopyWith(_SharedLink value, $Res Function(_SharedLink) _then) = __$SharedLinkCopyWithImpl;
@override @useResult
$Res call({
 String id, String listId, MemberRole role,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, String createdBy, String updatedBy, String slug, bool isActive, String listTitle, String listEmoji, int useCount, int? maxUses,@NullableTimestampConverter() DateTime? expiresAt,@NullableTimestampConverter() DateTime? deletedAt, int version
});




}
/// @nodoc
class __$SharedLinkCopyWithImpl<$Res>
    implements _$SharedLinkCopyWith<$Res> {
  __$SharedLinkCopyWithImpl(this._self, this._then);

  final _SharedLink _self;
  final $Res Function(_SharedLink) _then;

/// Create a copy of SharedLink
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? listId = null,Object? role = null,Object? createdAt = null,Object? updatedAt = null,Object? createdBy = null,Object? updatedBy = null,Object? slug = null,Object? isActive = null,Object? listTitle = null,Object? listEmoji = null,Object? useCount = null,Object? maxUses = freezed,Object? expiresAt = freezed,Object? deletedAt = freezed,Object? version = null,}) {
  return _then(_SharedLink(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,listId: null == listId ? _self.listId : listId // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as MemberRole,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,updatedBy: null == updatedBy ? _self.updatedBy : updatedBy // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,listTitle: null == listTitle ? _self.listTitle : listTitle // ignore: cast_nullable_to_non_nullable
as String,listEmoji: null == listEmoji ? _self.listEmoji : listEmoji // ignore: cast_nullable_to_non_nullable
as String,useCount: null == useCount ? _self.useCount : useCount // ignore: cast_nullable_to_non_nullable
as int,maxUses: freezed == maxUses ? _self.maxUses : maxUses // ignore: cast_nullable_to_non_nullable
as int?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
