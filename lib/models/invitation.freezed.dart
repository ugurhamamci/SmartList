// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invitation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Invitation {

 String get id; String get listId; String get inviteeEmail; String get invitedBy;@TimestampConverter() DateTime get createdAt;@TimestampConverter() DateTime get updatedAt; String get createdBy; String get updatedBy; MemberRole get role; InvitationStatus get status; String? get inviteeId;/// Denormalised so the invite card renders before the list is readable.
 String get listTitle; String get listEmoji; String get inviterName; String? get inviterPhotoUrl;@NullableTimestampConverter() DateTime? get respondedAt;@NullableTimestampConverter() DateTime? get revokedAt;@NullableTimestampConverter() DateTime? get expiresAt;@NullableTimestampConverter() DateTime? get deletedAt; int get version;
/// Create a copy of Invitation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvitationCopyWith<Invitation> get copyWith => _$InvitationCopyWithImpl<Invitation>(this as Invitation, _$identity);

  /// Serializes this Invitation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Invitation&&(identical(other.id, id) || other.id == id)&&(identical(other.listId, listId) || other.listId == listId)&&(identical(other.inviteeEmail, inviteeEmail) || other.inviteeEmail == inviteeEmail)&&(identical(other.invitedBy, invitedBy) || other.invitedBy == invitedBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.updatedBy, updatedBy) || other.updatedBy == updatedBy)&&(identical(other.role, role) || other.role == role)&&(identical(other.status, status) || other.status == status)&&(identical(other.inviteeId, inviteeId) || other.inviteeId == inviteeId)&&(identical(other.listTitle, listTitle) || other.listTitle == listTitle)&&(identical(other.listEmoji, listEmoji) || other.listEmoji == listEmoji)&&(identical(other.inviterName, inviterName) || other.inviterName == inviterName)&&(identical(other.inviterPhotoUrl, inviterPhotoUrl) || other.inviterPhotoUrl == inviterPhotoUrl)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,listId,inviteeEmail,invitedBy,createdAt,updatedAt,createdBy,updatedBy,role,status,inviteeId,listTitle,listEmoji,inviterName,inviterPhotoUrl,respondedAt,revokedAt,expiresAt,deletedAt,version]);

@override
String toString() {
  return 'Invitation(id: $id, listId: $listId, inviteeEmail: $inviteeEmail, invitedBy: $invitedBy, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy, role: $role, status: $status, inviteeId: $inviteeId, listTitle: $listTitle, listEmoji: $listEmoji, inviterName: $inviterName, inviterPhotoUrl: $inviterPhotoUrl, respondedAt: $respondedAt, revokedAt: $revokedAt, expiresAt: $expiresAt, deletedAt: $deletedAt, version: $version)';
}


}

/// @nodoc
abstract mixin class $InvitationCopyWith<$Res>  {
  factory $InvitationCopyWith(Invitation value, $Res Function(Invitation) _then) = _$InvitationCopyWithImpl;
@useResult
$Res call({
 String id, String listId, String inviteeEmail, String invitedBy,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, String createdBy, String updatedBy, MemberRole role, InvitationStatus status, String? inviteeId, String listTitle, String listEmoji, String inviterName, String? inviterPhotoUrl,@NullableTimestampConverter() DateTime? respondedAt,@NullableTimestampConverter() DateTime? revokedAt,@NullableTimestampConverter() DateTime? expiresAt,@NullableTimestampConverter() DateTime? deletedAt, int version
});




}
/// @nodoc
class _$InvitationCopyWithImpl<$Res>
    implements $InvitationCopyWith<$Res> {
  _$InvitationCopyWithImpl(this._self, this._then);

  final Invitation _self;
  final $Res Function(Invitation) _then;

/// Create a copy of Invitation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? listId = null,Object? inviteeEmail = null,Object? invitedBy = null,Object? createdAt = null,Object? updatedAt = null,Object? createdBy = null,Object? updatedBy = null,Object? role = null,Object? status = null,Object? inviteeId = freezed,Object? listTitle = null,Object? listEmoji = null,Object? inviterName = null,Object? inviterPhotoUrl = freezed,Object? respondedAt = freezed,Object? revokedAt = freezed,Object? expiresAt = freezed,Object? deletedAt = freezed,Object? version = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,listId: null == listId ? _self.listId : listId // ignore: cast_nullable_to_non_nullable
as String,inviteeEmail: null == inviteeEmail ? _self.inviteeEmail : inviteeEmail // ignore: cast_nullable_to_non_nullable
as String,invitedBy: null == invitedBy ? _self.invitedBy : invitedBy // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,updatedBy: null == updatedBy ? _self.updatedBy : updatedBy // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as MemberRole,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as InvitationStatus,inviteeId: freezed == inviteeId ? _self.inviteeId : inviteeId // ignore: cast_nullable_to_non_nullable
as String?,listTitle: null == listTitle ? _self.listTitle : listTitle // ignore: cast_nullable_to_non_nullable
as String,listEmoji: null == listEmoji ? _self.listEmoji : listEmoji // ignore: cast_nullable_to_non_nullable
as String,inviterName: null == inviterName ? _self.inviterName : inviterName // ignore: cast_nullable_to_non_nullable
as String,inviterPhotoUrl: freezed == inviterPhotoUrl ? _self.inviterPhotoUrl : inviterPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,respondedAt: freezed == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,revokedAt: freezed == revokedAt ? _self.revokedAt : revokedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Invitation].
extension InvitationPatterns on Invitation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Invitation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Invitation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Invitation value)  $default,){
final _that = this;
switch (_that) {
case _Invitation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Invitation value)?  $default,){
final _that = this;
switch (_that) {
case _Invitation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String listId,  String inviteeEmail,  String invitedBy, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String createdBy,  String updatedBy,  MemberRole role,  InvitationStatus status,  String? inviteeId,  String listTitle,  String listEmoji,  String inviterName,  String? inviterPhotoUrl, @NullableTimestampConverter()  DateTime? respondedAt, @NullableTimestampConverter()  DateTime? revokedAt, @NullableTimestampConverter()  DateTime? expiresAt, @NullableTimestampConverter()  DateTime? deletedAt,  int version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Invitation() when $default != null:
return $default(_that.id,_that.listId,_that.inviteeEmail,_that.invitedBy,_that.createdAt,_that.updatedAt,_that.createdBy,_that.updatedBy,_that.role,_that.status,_that.inviteeId,_that.listTitle,_that.listEmoji,_that.inviterName,_that.inviterPhotoUrl,_that.respondedAt,_that.revokedAt,_that.expiresAt,_that.deletedAt,_that.version);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String listId,  String inviteeEmail,  String invitedBy, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String createdBy,  String updatedBy,  MemberRole role,  InvitationStatus status,  String? inviteeId,  String listTitle,  String listEmoji,  String inviterName,  String? inviterPhotoUrl, @NullableTimestampConverter()  DateTime? respondedAt, @NullableTimestampConverter()  DateTime? revokedAt, @NullableTimestampConverter()  DateTime? expiresAt, @NullableTimestampConverter()  DateTime? deletedAt,  int version)  $default,) {final _that = this;
switch (_that) {
case _Invitation():
return $default(_that.id,_that.listId,_that.inviteeEmail,_that.invitedBy,_that.createdAt,_that.updatedAt,_that.createdBy,_that.updatedBy,_that.role,_that.status,_that.inviteeId,_that.listTitle,_that.listEmoji,_that.inviterName,_that.inviterPhotoUrl,_that.respondedAt,_that.revokedAt,_that.expiresAt,_that.deletedAt,_that.version);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String listId,  String inviteeEmail,  String invitedBy, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String createdBy,  String updatedBy,  MemberRole role,  InvitationStatus status,  String? inviteeId,  String listTitle,  String listEmoji,  String inviterName,  String? inviterPhotoUrl, @NullableTimestampConverter()  DateTime? respondedAt, @NullableTimestampConverter()  DateTime? revokedAt, @NullableTimestampConverter()  DateTime? expiresAt, @NullableTimestampConverter()  DateTime? deletedAt,  int version)?  $default,) {final _that = this;
switch (_that) {
case _Invitation() when $default != null:
return $default(_that.id,_that.listId,_that.inviteeEmail,_that.invitedBy,_that.createdAt,_that.updatedAt,_that.createdBy,_that.updatedBy,_that.role,_that.status,_that.inviteeId,_that.listTitle,_that.listEmoji,_that.inviterName,_that.inviterPhotoUrl,_that.respondedAt,_that.revokedAt,_that.expiresAt,_that.deletedAt,_that.version);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Invitation implements Invitation {
  const _Invitation({required this.id, required this.listId, required this.inviteeEmail, required this.invitedBy, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt, required this.createdBy, required this.updatedBy, this.role = MemberRole.editor, this.status = InvitationStatus.pending, this.inviteeId, this.listTitle = '', this.listEmoji = '🛒', this.inviterName = '', this.inviterPhotoUrl, @NullableTimestampConverter() this.respondedAt, @NullableTimestampConverter() this.revokedAt, @NullableTimestampConverter() this.expiresAt, @NullableTimestampConverter() this.deletedAt, this.version = 1});
  factory _Invitation.fromJson(Map<String, dynamic> json) => _$InvitationFromJson(json);

@override final  String id;
@override final  String listId;
@override final  String inviteeEmail;
@override final  String invitedBy;
@override@TimestampConverter() final  DateTime createdAt;
@override@TimestampConverter() final  DateTime updatedAt;
@override final  String createdBy;
@override final  String updatedBy;
@override@JsonKey() final  MemberRole role;
@override@JsonKey() final  InvitationStatus status;
@override final  String? inviteeId;
/// Denormalised so the invite card renders before the list is readable.
@override@JsonKey() final  String listTitle;
@override@JsonKey() final  String listEmoji;
@override@JsonKey() final  String inviterName;
@override final  String? inviterPhotoUrl;
@override@NullableTimestampConverter() final  DateTime? respondedAt;
@override@NullableTimestampConverter() final  DateTime? revokedAt;
@override@NullableTimestampConverter() final  DateTime? expiresAt;
@override@NullableTimestampConverter() final  DateTime? deletedAt;
@override@JsonKey() final  int version;

/// Create a copy of Invitation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvitationCopyWith<_Invitation> get copyWith => __$InvitationCopyWithImpl<_Invitation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InvitationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Invitation&&(identical(other.id, id) || other.id == id)&&(identical(other.listId, listId) || other.listId == listId)&&(identical(other.inviteeEmail, inviteeEmail) || other.inviteeEmail == inviteeEmail)&&(identical(other.invitedBy, invitedBy) || other.invitedBy == invitedBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.updatedBy, updatedBy) || other.updatedBy == updatedBy)&&(identical(other.role, role) || other.role == role)&&(identical(other.status, status) || other.status == status)&&(identical(other.inviteeId, inviteeId) || other.inviteeId == inviteeId)&&(identical(other.listTitle, listTitle) || other.listTitle == listTitle)&&(identical(other.listEmoji, listEmoji) || other.listEmoji == listEmoji)&&(identical(other.inviterName, inviterName) || other.inviterName == inviterName)&&(identical(other.inviterPhotoUrl, inviterPhotoUrl) || other.inviterPhotoUrl == inviterPhotoUrl)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,listId,inviteeEmail,invitedBy,createdAt,updatedAt,createdBy,updatedBy,role,status,inviteeId,listTitle,listEmoji,inviterName,inviterPhotoUrl,respondedAt,revokedAt,expiresAt,deletedAt,version]);

@override
String toString() {
  return 'Invitation(id: $id, listId: $listId, inviteeEmail: $inviteeEmail, invitedBy: $invitedBy, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy, role: $role, status: $status, inviteeId: $inviteeId, listTitle: $listTitle, listEmoji: $listEmoji, inviterName: $inviterName, inviterPhotoUrl: $inviterPhotoUrl, respondedAt: $respondedAt, revokedAt: $revokedAt, expiresAt: $expiresAt, deletedAt: $deletedAt, version: $version)';
}


}

/// @nodoc
abstract mixin class _$InvitationCopyWith<$Res> implements $InvitationCopyWith<$Res> {
  factory _$InvitationCopyWith(_Invitation value, $Res Function(_Invitation) _then) = __$InvitationCopyWithImpl;
@override @useResult
$Res call({
 String id, String listId, String inviteeEmail, String invitedBy,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, String createdBy, String updatedBy, MemberRole role, InvitationStatus status, String? inviteeId, String listTitle, String listEmoji, String inviterName, String? inviterPhotoUrl,@NullableTimestampConverter() DateTime? respondedAt,@NullableTimestampConverter() DateTime? revokedAt,@NullableTimestampConverter() DateTime? expiresAt,@NullableTimestampConverter() DateTime? deletedAt, int version
});




}
/// @nodoc
class __$InvitationCopyWithImpl<$Res>
    implements _$InvitationCopyWith<$Res> {
  __$InvitationCopyWithImpl(this._self, this._then);

  final _Invitation _self;
  final $Res Function(_Invitation) _then;

/// Create a copy of Invitation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? listId = null,Object? inviteeEmail = null,Object? invitedBy = null,Object? createdAt = null,Object? updatedAt = null,Object? createdBy = null,Object? updatedBy = null,Object? role = null,Object? status = null,Object? inviteeId = freezed,Object? listTitle = null,Object? listEmoji = null,Object? inviterName = null,Object? inviterPhotoUrl = freezed,Object? respondedAt = freezed,Object? revokedAt = freezed,Object? expiresAt = freezed,Object? deletedAt = freezed,Object? version = null,}) {
  return _then(_Invitation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,listId: null == listId ? _self.listId : listId // ignore: cast_nullable_to_non_nullable
as String,inviteeEmail: null == inviteeEmail ? _self.inviteeEmail : inviteeEmail // ignore: cast_nullable_to_non_nullable
as String,invitedBy: null == invitedBy ? _self.invitedBy : invitedBy // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,updatedBy: null == updatedBy ? _self.updatedBy : updatedBy // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as MemberRole,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as InvitationStatus,inviteeId: freezed == inviteeId ? _self.inviteeId : inviteeId // ignore: cast_nullable_to_non_nullable
as String?,listTitle: null == listTitle ? _self.listTitle : listTitle // ignore: cast_nullable_to_non_nullable
as String,listEmoji: null == listEmoji ? _self.listEmoji : listEmoji // ignore: cast_nullable_to_non_nullable
as String,inviterName: null == inviterName ? _self.inviterName : inviterName // ignore: cast_nullable_to_non_nullable
as String,inviterPhotoUrl: freezed == inviterPhotoUrl ? _self.inviterPhotoUrl : inviterPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,respondedAt: freezed == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,revokedAt: freezed == revokedAt ? _self.revokedAt : revokedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
