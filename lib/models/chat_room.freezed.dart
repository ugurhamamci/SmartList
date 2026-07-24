// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_room.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatRoom {

 String get id; String get listId;@TimestampConverter() DateTime get createdAt;@TimestampConverter() DateTime get updatedAt; String get createdBy; String get updatedBy; List<String> get memberIds; int get messageCount;/// Denormalised preview of the newest message for the list overview.
 String get lastMessagePreview; String? get lastMessageSenderId; String get lastMessageSenderName; MessageType? get lastMessageType;@NullableTimestampConverter() DateTime? get lastMessageAt;/// uid -> id of the last message that member has read. Unread counts are
/// derived client-side from this marker.
 Map<String, String> get lastReadMessageIds;/// uid -> time that member last opened the room.
@TimestampMapConverter() Map<String, DateTime> get lastReadAt;@NullableTimestampConverter() DateTime? get deletedAt; int get version;
/// Create a copy of ChatRoom
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatRoomCopyWith<ChatRoom> get copyWith => _$ChatRoomCopyWithImpl<ChatRoom>(this as ChatRoom, _$identity);

  /// Serializes this ChatRoom to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatRoom&&(identical(other.id, id) || other.id == id)&&(identical(other.listId, listId) || other.listId == listId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.updatedBy, updatedBy) || other.updatedBy == updatedBy)&&const DeepCollectionEquality().equals(other.memberIds, memberIds)&&(identical(other.messageCount, messageCount) || other.messageCount == messageCount)&&(identical(other.lastMessagePreview, lastMessagePreview) || other.lastMessagePreview == lastMessagePreview)&&(identical(other.lastMessageSenderId, lastMessageSenderId) || other.lastMessageSenderId == lastMessageSenderId)&&(identical(other.lastMessageSenderName, lastMessageSenderName) || other.lastMessageSenderName == lastMessageSenderName)&&(identical(other.lastMessageType, lastMessageType) || other.lastMessageType == lastMessageType)&&(identical(other.lastMessageAt, lastMessageAt) || other.lastMessageAt == lastMessageAt)&&const DeepCollectionEquality().equals(other.lastReadMessageIds, lastReadMessageIds)&&const DeepCollectionEquality().equals(other.lastReadAt, lastReadAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,listId,createdAt,updatedAt,createdBy,updatedBy,const DeepCollectionEquality().hash(memberIds),messageCount,lastMessagePreview,lastMessageSenderId,lastMessageSenderName,lastMessageType,lastMessageAt,const DeepCollectionEquality().hash(lastReadMessageIds),const DeepCollectionEquality().hash(lastReadAt),deletedAt,version);

@override
String toString() {
  return 'ChatRoom(id: $id, listId: $listId, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy, memberIds: $memberIds, messageCount: $messageCount, lastMessagePreview: $lastMessagePreview, lastMessageSenderId: $lastMessageSenderId, lastMessageSenderName: $lastMessageSenderName, lastMessageType: $lastMessageType, lastMessageAt: $lastMessageAt, lastReadMessageIds: $lastReadMessageIds, lastReadAt: $lastReadAt, deletedAt: $deletedAt, version: $version)';
}


}

/// @nodoc
abstract mixin class $ChatRoomCopyWith<$Res>  {
  factory $ChatRoomCopyWith(ChatRoom value, $Res Function(ChatRoom) _then) = _$ChatRoomCopyWithImpl;
@useResult
$Res call({
 String id, String listId,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, String createdBy, String updatedBy, List<String> memberIds, int messageCount, String lastMessagePreview, String? lastMessageSenderId, String lastMessageSenderName, MessageType? lastMessageType,@NullableTimestampConverter() DateTime? lastMessageAt, Map<String, String> lastReadMessageIds,@TimestampMapConverter() Map<String, DateTime> lastReadAt,@NullableTimestampConverter() DateTime? deletedAt, int version
});




}
/// @nodoc
class _$ChatRoomCopyWithImpl<$Res>
    implements $ChatRoomCopyWith<$Res> {
  _$ChatRoomCopyWithImpl(this._self, this._then);

  final ChatRoom _self;
  final $Res Function(ChatRoom) _then;

/// Create a copy of ChatRoom
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? listId = null,Object? createdAt = null,Object? updatedAt = null,Object? createdBy = null,Object? updatedBy = null,Object? memberIds = null,Object? messageCount = null,Object? lastMessagePreview = null,Object? lastMessageSenderId = freezed,Object? lastMessageSenderName = null,Object? lastMessageType = freezed,Object? lastMessageAt = freezed,Object? lastReadMessageIds = null,Object? lastReadAt = null,Object? deletedAt = freezed,Object? version = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,listId: null == listId ? _self.listId : listId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,updatedBy: null == updatedBy ? _self.updatedBy : updatedBy // ignore: cast_nullable_to_non_nullable
as String,memberIds: null == memberIds ? _self.memberIds : memberIds // ignore: cast_nullable_to_non_nullable
as List<String>,messageCount: null == messageCount ? _self.messageCount : messageCount // ignore: cast_nullable_to_non_nullable
as int,lastMessagePreview: null == lastMessagePreview ? _self.lastMessagePreview : lastMessagePreview // ignore: cast_nullable_to_non_nullable
as String,lastMessageSenderId: freezed == lastMessageSenderId ? _self.lastMessageSenderId : lastMessageSenderId // ignore: cast_nullable_to_non_nullable
as String?,lastMessageSenderName: null == lastMessageSenderName ? _self.lastMessageSenderName : lastMessageSenderName // ignore: cast_nullable_to_non_nullable
as String,lastMessageType: freezed == lastMessageType ? _self.lastMessageType : lastMessageType // ignore: cast_nullable_to_non_nullable
as MessageType?,lastMessageAt: freezed == lastMessageAt ? _self.lastMessageAt : lastMessageAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastReadMessageIds: null == lastReadMessageIds ? _self.lastReadMessageIds : lastReadMessageIds // ignore: cast_nullable_to_non_nullable
as Map<String, String>,lastReadAt: null == lastReadAt ? _self.lastReadAt : lastReadAt // ignore: cast_nullable_to_non_nullable
as Map<String, DateTime>,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatRoom].
extension ChatRoomPatterns on ChatRoom {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatRoom value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatRoom() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatRoom value)  $default,){
final _that = this;
switch (_that) {
case _ChatRoom():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatRoom value)?  $default,){
final _that = this;
switch (_that) {
case _ChatRoom() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String listId, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String createdBy,  String updatedBy,  List<String> memberIds,  int messageCount,  String lastMessagePreview,  String? lastMessageSenderId,  String lastMessageSenderName,  MessageType? lastMessageType, @NullableTimestampConverter()  DateTime? lastMessageAt,  Map<String, String> lastReadMessageIds, @TimestampMapConverter()  Map<String, DateTime> lastReadAt, @NullableTimestampConverter()  DateTime? deletedAt,  int version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatRoom() when $default != null:
return $default(_that.id,_that.listId,_that.createdAt,_that.updatedAt,_that.createdBy,_that.updatedBy,_that.memberIds,_that.messageCount,_that.lastMessagePreview,_that.lastMessageSenderId,_that.lastMessageSenderName,_that.lastMessageType,_that.lastMessageAt,_that.lastReadMessageIds,_that.lastReadAt,_that.deletedAt,_that.version);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String listId, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String createdBy,  String updatedBy,  List<String> memberIds,  int messageCount,  String lastMessagePreview,  String? lastMessageSenderId,  String lastMessageSenderName,  MessageType? lastMessageType, @NullableTimestampConverter()  DateTime? lastMessageAt,  Map<String, String> lastReadMessageIds, @TimestampMapConverter()  Map<String, DateTime> lastReadAt, @NullableTimestampConverter()  DateTime? deletedAt,  int version)  $default,) {final _that = this;
switch (_that) {
case _ChatRoom():
return $default(_that.id,_that.listId,_that.createdAt,_that.updatedAt,_that.createdBy,_that.updatedBy,_that.memberIds,_that.messageCount,_that.lastMessagePreview,_that.lastMessageSenderId,_that.lastMessageSenderName,_that.lastMessageType,_that.lastMessageAt,_that.lastReadMessageIds,_that.lastReadAt,_that.deletedAt,_that.version);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String listId, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String createdBy,  String updatedBy,  List<String> memberIds,  int messageCount,  String lastMessagePreview,  String? lastMessageSenderId,  String lastMessageSenderName,  MessageType? lastMessageType, @NullableTimestampConverter()  DateTime? lastMessageAt,  Map<String, String> lastReadMessageIds, @TimestampMapConverter()  Map<String, DateTime> lastReadAt, @NullableTimestampConverter()  DateTime? deletedAt,  int version)?  $default,) {final _that = this;
switch (_that) {
case _ChatRoom() when $default != null:
return $default(_that.id,_that.listId,_that.createdAt,_that.updatedAt,_that.createdBy,_that.updatedBy,_that.memberIds,_that.messageCount,_that.lastMessagePreview,_that.lastMessageSenderId,_that.lastMessageSenderName,_that.lastMessageType,_that.lastMessageAt,_that.lastReadMessageIds,_that.lastReadAt,_that.deletedAt,_that.version);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatRoom implements ChatRoom {
  const _ChatRoom({required this.id, required this.listId, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt, required this.createdBy, required this.updatedBy, final  List<String> memberIds = const <String>[], this.messageCount = 0, this.lastMessagePreview = '', this.lastMessageSenderId, this.lastMessageSenderName = '', this.lastMessageType, @NullableTimestampConverter() this.lastMessageAt, final  Map<String, String> lastReadMessageIds = const <String, String>{}, @TimestampMapConverter() final  Map<String, DateTime> lastReadAt = const <String, DateTime>{}, @NullableTimestampConverter() this.deletedAt, this.version = 1}): _memberIds = memberIds,_lastReadMessageIds = lastReadMessageIds,_lastReadAt = lastReadAt;
  factory _ChatRoom.fromJson(Map<String, dynamic> json) => _$ChatRoomFromJson(json);

@override final  String id;
@override final  String listId;
@override@TimestampConverter() final  DateTime createdAt;
@override@TimestampConverter() final  DateTime updatedAt;
@override final  String createdBy;
@override final  String updatedBy;
 final  List<String> _memberIds;
@override@JsonKey() List<String> get memberIds {
  if (_memberIds is EqualUnmodifiableListView) return _memberIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_memberIds);
}

@override@JsonKey() final  int messageCount;
/// Denormalised preview of the newest message for the list overview.
@override@JsonKey() final  String lastMessagePreview;
@override final  String? lastMessageSenderId;
@override@JsonKey() final  String lastMessageSenderName;
@override final  MessageType? lastMessageType;
@override@NullableTimestampConverter() final  DateTime? lastMessageAt;
/// uid -> id of the last message that member has read. Unread counts are
/// derived client-side from this marker.
 final  Map<String, String> _lastReadMessageIds;
/// uid -> id of the last message that member has read. Unread counts are
/// derived client-side from this marker.
@override@JsonKey() Map<String, String> get lastReadMessageIds {
  if (_lastReadMessageIds is EqualUnmodifiableMapView) return _lastReadMessageIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_lastReadMessageIds);
}

/// uid -> time that member last opened the room.
 final  Map<String, DateTime> _lastReadAt;
/// uid -> time that member last opened the room.
@override@JsonKey()@TimestampMapConverter() Map<String, DateTime> get lastReadAt {
  if (_lastReadAt is EqualUnmodifiableMapView) return _lastReadAt;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_lastReadAt);
}

@override@NullableTimestampConverter() final  DateTime? deletedAt;
@override@JsonKey() final  int version;

/// Create a copy of ChatRoom
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatRoomCopyWith<_ChatRoom> get copyWith => __$ChatRoomCopyWithImpl<_ChatRoom>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatRoomToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatRoom&&(identical(other.id, id) || other.id == id)&&(identical(other.listId, listId) || other.listId == listId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.updatedBy, updatedBy) || other.updatedBy == updatedBy)&&const DeepCollectionEquality().equals(other._memberIds, _memberIds)&&(identical(other.messageCount, messageCount) || other.messageCount == messageCount)&&(identical(other.lastMessagePreview, lastMessagePreview) || other.lastMessagePreview == lastMessagePreview)&&(identical(other.lastMessageSenderId, lastMessageSenderId) || other.lastMessageSenderId == lastMessageSenderId)&&(identical(other.lastMessageSenderName, lastMessageSenderName) || other.lastMessageSenderName == lastMessageSenderName)&&(identical(other.lastMessageType, lastMessageType) || other.lastMessageType == lastMessageType)&&(identical(other.lastMessageAt, lastMessageAt) || other.lastMessageAt == lastMessageAt)&&const DeepCollectionEquality().equals(other._lastReadMessageIds, _lastReadMessageIds)&&const DeepCollectionEquality().equals(other._lastReadAt, _lastReadAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,listId,createdAt,updatedAt,createdBy,updatedBy,const DeepCollectionEquality().hash(_memberIds),messageCount,lastMessagePreview,lastMessageSenderId,lastMessageSenderName,lastMessageType,lastMessageAt,const DeepCollectionEquality().hash(_lastReadMessageIds),const DeepCollectionEquality().hash(_lastReadAt),deletedAt,version);

@override
String toString() {
  return 'ChatRoom(id: $id, listId: $listId, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy, memberIds: $memberIds, messageCount: $messageCount, lastMessagePreview: $lastMessagePreview, lastMessageSenderId: $lastMessageSenderId, lastMessageSenderName: $lastMessageSenderName, lastMessageType: $lastMessageType, lastMessageAt: $lastMessageAt, lastReadMessageIds: $lastReadMessageIds, lastReadAt: $lastReadAt, deletedAt: $deletedAt, version: $version)';
}


}

/// @nodoc
abstract mixin class _$ChatRoomCopyWith<$Res> implements $ChatRoomCopyWith<$Res> {
  factory _$ChatRoomCopyWith(_ChatRoom value, $Res Function(_ChatRoom) _then) = __$ChatRoomCopyWithImpl;
@override @useResult
$Res call({
 String id, String listId,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, String createdBy, String updatedBy, List<String> memberIds, int messageCount, String lastMessagePreview, String? lastMessageSenderId, String lastMessageSenderName, MessageType? lastMessageType,@NullableTimestampConverter() DateTime? lastMessageAt, Map<String, String> lastReadMessageIds,@TimestampMapConverter() Map<String, DateTime> lastReadAt,@NullableTimestampConverter() DateTime? deletedAt, int version
});




}
/// @nodoc
class __$ChatRoomCopyWithImpl<$Res>
    implements _$ChatRoomCopyWith<$Res> {
  __$ChatRoomCopyWithImpl(this._self, this._then);

  final _ChatRoom _self;
  final $Res Function(_ChatRoom) _then;

/// Create a copy of ChatRoom
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? listId = null,Object? createdAt = null,Object? updatedAt = null,Object? createdBy = null,Object? updatedBy = null,Object? memberIds = null,Object? messageCount = null,Object? lastMessagePreview = null,Object? lastMessageSenderId = freezed,Object? lastMessageSenderName = null,Object? lastMessageType = freezed,Object? lastMessageAt = freezed,Object? lastReadMessageIds = null,Object? lastReadAt = null,Object? deletedAt = freezed,Object? version = null,}) {
  return _then(_ChatRoom(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,listId: null == listId ? _self.listId : listId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,updatedBy: null == updatedBy ? _self.updatedBy : updatedBy // ignore: cast_nullable_to_non_nullable
as String,memberIds: null == memberIds ? _self._memberIds : memberIds // ignore: cast_nullable_to_non_nullable
as List<String>,messageCount: null == messageCount ? _self.messageCount : messageCount // ignore: cast_nullable_to_non_nullable
as int,lastMessagePreview: null == lastMessagePreview ? _self.lastMessagePreview : lastMessagePreview // ignore: cast_nullable_to_non_nullable
as String,lastMessageSenderId: freezed == lastMessageSenderId ? _self.lastMessageSenderId : lastMessageSenderId // ignore: cast_nullable_to_non_nullable
as String?,lastMessageSenderName: null == lastMessageSenderName ? _self.lastMessageSenderName : lastMessageSenderName // ignore: cast_nullable_to_non_nullable
as String,lastMessageType: freezed == lastMessageType ? _self.lastMessageType : lastMessageType // ignore: cast_nullable_to_non_nullable
as MessageType?,lastMessageAt: freezed == lastMessageAt ? _self.lastMessageAt : lastMessageAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastReadMessageIds: null == lastReadMessageIds ? _self._lastReadMessageIds : lastReadMessageIds // ignore: cast_nullable_to_non_nullable
as Map<String, String>,lastReadAt: null == lastReadAt ? _self._lastReadAt : lastReadAt // ignore: cast_nullable_to_non_nullable
as Map<String, DateTime>,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
