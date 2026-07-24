// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatMessage {

 String get id; String get roomId; String get senderId;@TimestampConverter() DateTime get createdAt;@TimestampConverter() DateTime get updatedAt; String get createdBy; String get updatedBy; MessageType get type; String get body;/// Denormalised sender profile so history renders without extra reads.
 String get senderName; String? get senderPhotoUrl;/// Storage download URL for an image or voice attachment.
 String? get attachmentUrl; String? get attachmentPath; int get attachmentSizeBytes;/// Duration of a voice note, in milliseconds.
@NullableDurationConverter() Duration? get voiceDuration;/// Waveform samples used to draw a voice note, normalised to `0..1`.
 List<double> get waveform; int? get imageWidth; int? get imageHeight;/// uid -> time the message was read.
@TimestampMapConverter() Map<String, DateTime> get readBy;/// uid -> emoji. One reaction per member.
 Map<String, String> get reactions;/// Members mentioned in [body], used to raise mention notifications.
 List<String> get mentions;/// Set when the message replies to another message in the room.
 String? get replyToMessageId; String get replyToPreview; bool get isEdited;@NullableTimestampConverter() DateTime? get editedAt;/// Populated for [MessageType.system] messages so the client can render a
/// localized sentence rather than server-generated English.
 ActivityAction? get systemAction; Map<String, String> get systemParams;@NullableTimestampConverter() DateTime? get deletedAt; int get version;
/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageCopyWith<ChatMessage> get copyWith => _$ChatMessageCopyWithImpl<ChatMessage>(this as ChatMessage, _$identity);

  /// Serializes this ChatMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.updatedBy, updatedBy) || other.updatedBy == updatedBy)&&(identical(other.type, type) || other.type == type)&&(identical(other.body, body) || other.body == body)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.senderPhotoUrl, senderPhotoUrl) || other.senderPhotoUrl == senderPhotoUrl)&&(identical(other.attachmentUrl, attachmentUrl) || other.attachmentUrl == attachmentUrl)&&(identical(other.attachmentPath, attachmentPath) || other.attachmentPath == attachmentPath)&&(identical(other.attachmentSizeBytes, attachmentSizeBytes) || other.attachmentSizeBytes == attachmentSizeBytes)&&(identical(other.voiceDuration, voiceDuration) || other.voiceDuration == voiceDuration)&&const DeepCollectionEquality().equals(other.waveform, waveform)&&(identical(other.imageWidth, imageWidth) || other.imageWidth == imageWidth)&&(identical(other.imageHeight, imageHeight) || other.imageHeight == imageHeight)&&const DeepCollectionEquality().equals(other.readBy, readBy)&&const DeepCollectionEquality().equals(other.reactions, reactions)&&const DeepCollectionEquality().equals(other.mentions, mentions)&&(identical(other.replyToMessageId, replyToMessageId) || other.replyToMessageId == replyToMessageId)&&(identical(other.replyToPreview, replyToPreview) || other.replyToPreview == replyToPreview)&&(identical(other.isEdited, isEdited) || other.isEdited == isEdited)&&(identical(other.editedAt, editedAt) || other.editedAt == editedAt)&&(identical(other.systemAction, systemAction) || other.systemAction == systemAction)&&const DeepCollectionEquality().equals(other.systemParams, systemParams)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,roomId,senderId,createdAt,updatedAt,createdBy,updatedBy,type,body,senderName,senderPhotoUrl,attachmentUrl,attachmentPath,attachmentSizeBytes,voiceDuration,const DeepCollectionEquality().hash(waveform),imageWidth,imageHeight,const DeepCollectionEquality().hash(readBy),const DeepCollectionEquality().hash(reactions),const DeepCollectionEquality().hash(mentions),replyToMessageId,replyToPreview,isEdited,editedAt,systemAction,const DeepCollectionEquality().hash(systemParams),deletedAt,version]);

@override
String toString() {
  return 'ChatMessage(id: $id, roomId: $roomId, senderId: $senderId, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy, type: $type, body: $body, senderName: $senderName, senderPhotoUrl: $senderPhotoUrl, attachmentUrl: $attachmentUrl, attachmentPath: $attachmentPath, attachmentSizeBytes: $attachmentSizeBytes, voiceDuration: $voiceDuration, waveform: $waveform, imageWidth: $imageWidth, imageHeight: $imageHeight, readBy: $readBy, reactions: $reactions, mentions: $mentions, replyToMessageId: $replyToMessageId, replyToPreview: $replyToPreview, isEdited: $isEdited, editedAt: $editedAt, systemAction: $systemAction, systemParams: $systemParams, deletedAt: $deletedAt, version: $version)';
}


}

/// @nodoc
abstract mixin class $ChatMessageCopyWith<$Res>  {
  factory $ChatMessageCopyWith(ChatMessage value, $Res Function(ChatMessage) _then) = _$ChatMessageCopyWithImpl;
@useResult
$Res call({
 String id, String roomId, String senderId,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, String createdBy, String updatedBy, MessageType type, String body, String senderName, String? senderPhotoUrl, String? attachmentUrl, String? attachmentPath, int attachmentSizeBytes,@NullableDurationConverter() Duration? voiceDuration, List<double> waveform, int? imageWidth, int? imageHeight,@TimestampMapConverter() Map<String, DateTime> readBy, Map<String, String> reactions, List<String> mentions, String? replyToMessageId, String replyToPreview, bool isEdited,@NullableTimestampConverter() DateTime? editedAt, ActivityAction? systemAction, Map<String, String> systemParams,@NullableTimestampConverter() DateTime? deletedAt, int version
});




}
/// @nodoc
class _$ChatMessageCopyWithImpl<$Res>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._self, this._then);

  final ChatMessage _self;
  final $Res Function(ChatMessage) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? roomId = null,Object? senderId = null,Object? createdAt = null,Object? updatedAt = null,Object? createdBy = null,Object? updatedBy = null,Object? type = null,Object? body = null,Object? senderName = null,Object? senderPhotoUrl = freezed,Object? attachmentUrl = freezed,Object? attachmentPath = freezed,Object? attachmentSizeBytes = null,Object? voiceDuration = freezed,Object? waveform = null,Object? imageWidth = freezed,Object? imageHeight = freezed,Object? readBy = null,Object? reactions = null,Object? mentions = null,Object? replyToMessageId = freezed,Object? replyToPreview = null,Object? isEdited = null,Object? editedAt = freezed,Object? systemAction = freezed,Object? systemParams = null,Object? deletedAt = freezed,Object? version = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,updatedBy: null == updatedBy ? _self.updatedBy : updatedBy // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MessageType,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,senderPhotoUrl: freezed == senderPhotoUrl ? _self.senderPhotoUrl : senderPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,attachmentUrl: freezed == attachmentUrl ? _self.attachmentUrl : attachmentUrl // ignore: cast_nullable_to_non_nullable
as String?,attachmentPath: freezed == attachmentPath ? _self.attachmentPath : attachmentPath // ignore: cast_nullable_to_non_nullable
as String?,attachmentSizeBytes: null == attachmentSizeBytes ? _self.attachmentSizeBytes : attachmentSizeBytes // ignore: cast_nullable_to_non_nullable
as int,voiceDuration: freezed == voiceDuration ? _self.voiceDuration : voiceDuration // ignore: cast_nullable_to_non_nullable
as Duration?,waveform: null == waveform ? _self.waveform : waveform // ignore: cast_nullable_to_non_nullable
as List<double>,imageWidth: freezed == imageWidth ? _self.imageWidth : imageWidth // ignore: cast_nullable_to_non_nullable
as int?,imageHeight: freezed == imageHeight ? _self.imageHeight : imageHeight // ignore: cast_nullable_to_non_nullable
as int?,readBy: null == readBy ? _self.readBy : readBy // ignore: cast_nullable_to_non_nullable
as Map<String, DateTime>,reactions: null == reactions ? _self.reactions : reactions // ignore: cast_nullable_to_non_nullable
as Map<String, String>,mentions: null == mentions ? _self.mentions : mentions // ignore: cast_nullable_to_non_nullable
as List<String>,replyToMessageId: freezed == replyToMessageId ? _self.replyToMessageId : replyToMessageId // ignore: cast_nullable_to_non_nullable
as String?,replyToPreview: null == replyToPreview ? _self.replyToPreview : replyToPreview // ignore: cast_nullable_to_non_nullable
as String,isEdited: null == isEdited ? _self.isEdited : isEdited // ignore: cast_nullable_to_non_nullable
as bool,editedAt: freezed == editedAt ? _self.editedAt : editedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,systemAction: freezed == systemAction ? _self.systemAction : systemAction // ignore: cast_nullable_to_non_nullable
as ActivityAction?,systemParams: null == systemParams ? _self.systemParams : systemParams // ignore: cast_nullable_to_non_nullable
as Map<String, String>,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatMessage].
extension ChatMessagePatterns on ChatMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMessage value)  $default,){
final _that = this;
switch (_that) {
case _ChatMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMessage value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String roomId,  String senderId, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String createdBy,  String updatedBy,  MessageType type,  String body,  String senderName,  String? senderPhotoUrl,  String? attachmentUrl,  String? attachmentPath,  int attachmentSizeBytes, @NullableDurationConverter()  Duration? voiceDuration,  List<double> waveform,  int? imageWidth,  int? imageHeight, @TimestampMapConverter()  Map<String, DateTime> readBy,  Map<String, String> reactions,  List<String> mentions,  String? replyToMessageId,  String replyToPreview,  bool isEdited, @NullableTimestampConverter()  DateTime? editedAt,  ActivityAction? systemAction,  Map<String, String> systemParams, @NullableTimestampConverter()  DateTime? deletedAt,  int version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that.id,_that.roomId,_that.senderId,_that.createdAt,_that.updatedAt,_that.createdBy,_that.updatedBy,_that.type,_that.body,_that.senderName,_that.senderPhotoUrl,_that.attachmentUrl,_that.attachmentPath,_that.attachmentSizeBytes,_that.voiceDuration,_that.waveform,_that.imageWidth,_that.imageHeight,_that.readBy,_that.reactions,_that.mentions,_that.replyToMessageId,_that.replyToPreview,_that.isEdited,_that.editedAt,_that.systemAction,_that.systemParams,_that.deletedAt,_that.version);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String roomId,  String senderId, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String createdBy,  String updatedBy,  MessageType type,  String body,  String senderName,  String? senderPhotoUrl,  String? attachmentUrl,  String? attachmentPath,  int attachmentSizeBytes, @NullableDurationConverter()  Duration? voiceDuration,  List<double> waveform,  int? imageWidth,  int? imageHeight, @TimestampMapConverter()  Map<String, DateTime> readBy,  Map<String, String> reactions,  List<String> mentions,  String? replyToMessageId,  String replyToPreview,  bool isEdited, @NullableTimestampConverter()  DateTime? editedAt,  ActivityAction? systemAction,  Map<String, String> systemParams, @NullableTimestampConverter()  DateTime? deletedAt,  int version)  $default,) {final _that = this;
switch (_that) {
case _ChatMessage():
return $default(_that.id,_that.roomId,_that.senderId,_that.createdAt,_that.updatedAt,_that.createdBy,_that.updatedBy,_that.type,_that.body,_that.senderName,_that.senderPhotoUrl,_that.attachmentUrl,_that.attachmentPath,_that.attachmentSizeBytes,_that.voiceDuration,_that.waveform,_that.imageWidth,_that.imageHeight,_that.readBy,_that.reactions,_that.mentions,_that.replyToMessageId,_that.replyToPreview,_that.isEdited,_that.editedAt,_that.systemAction,_that.systemParams,_that.deletedAt,_that.version);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String roomId,  String senderId, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String createdBy,  String updatedBy,  MessageType type,  String body,  String senderName,  String? senderPhotoUrl,  String? attachmentUrl,  String? attachmentPath,  int attachmentSizeBytes, @NullableDurationConverter()  Duration? voiceDuration,  List<double> waveform,  int? imageWidth,  int? imageHeight, @TimestampMapConverter()  Map<String, DateTime> readBy,  Map<String, String> reactions,  List<String> mentions,  String? replyToMessageId,  String replyToPreview,  bool isEdited, @NullableTimestampConverter()  DateTime? editedAt,  ActivityAction? systemAction,  Map<String, String> systemParams, @NullableTimestampConverter()  DateTime? deletedAt,  int version)?  $default,) {final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that.id,_that.roomId,_that.senderId,_that.createdAt,_that.updatedAt,_that.createdBy,_that.updatedBy,_that.type,_that.body,_that.senderName,_that.senderPhotoUrl,_that.attachmentUrl,_that.attachmentPath,_that.attachmentSizeBytes,_that.voiceDuration,_that.waveform,_that.imageWidth,_that.imageHeight,_that.readBy,_that.reactions,_that.mentions,_that.replyToMessageId,_that.replyToPreview,_that.isEdited,_that.editedAt,_that.systemAction,_that.systemParams,_that.deletedAt,_that.version);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatMessage implements ChatMessage {
  const _ChatMessage({required this.id, required this.roomId, required this.senderId, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt, required this.createdBy, required this.updatedBy, this.type = MessageType.text, this.body = '', this.senderName = '', this.senderPhotoUrl, this.attachmentUrl, this.attachmentPath, this.attachmentSizeBytes = 0, @NullableDurationConverter() this.voiceDuration, final  List<double> waveform = const <double>[], this.imageWidth, this.imageHeight, @TimestampMapConverter() final  Map<String, DateTime> readBy = const <String, DateTime>{}, final  Map<String, String> reactions = const <String, String>{}, final  List<String> mentions = const <String>[], this.replyToMessageId, this.replyToPreview = '', this.isEdited = false, @NullableTimestampConverter() this.editedAt, this.systemAction, final  Map<String, String> systemParams = const <String, String>{}, @NullableTimestampConverter() this.deletedAt, this.version = 1}): _waveform = waveform,_readBy = readBy,_reactions = reactions,_mentions = mentions,_systemParams = systemParams;
  factory _ChatMessage.fromJson(Map<String, dynamic> json) => _$ChatMessageFromJson(json);

@override final  String id;
@override final  String roomId;
@override final  String senderId;
@override@TimestampConverter() final  DateTime createdAt;
@override@TimestampConverter() final  DateTime updatedAt;
@override final  String createdBy;
@override final  String updatedBy;
@override@JsonKey() final  MessageType type;
@override@JsonKey() final  String body;
/// Denormalised sender profile so history renders without extra reads.
@override@JsonKey() final  String senderName;
@override final  String? senderPhotoUrl;
/// Storage download URL for an image or voice attachment.
@override final  String? attachmentUrl;
@override final  String? attachmentPath;
@override@JsonKey() final  int attachmentSizeBytes;
/// Duration of a voice note, in milliseconds.
@override@NullableDurationConverter() final  Duration? voiceDuration;
/// Waveform samples used to draw a voice note, normalised to `0..1`.
 final  List<double> _waveform;
/// Waveform samples used to draw a voice note, normalised to `0..1`.
@override@JsonKey() List<double> get waveform {
  if (_waveform is EqualUnmodifiableListView) return _waveform;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_waveform);
}

@override final  int? imageWidth;
@override final  int? imageHeight;
/// uid -> time the message was read.
 final  Map<String, DateTime> _readBy;
/// uid -> time the message was read.
@override@JsonKey()@TimestampMapConverter() Map<String, DateTime> get readBy {
  if (_readBy is EqualUnmodifiableMapView) return _readBy;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_readBy);
}

/// uid -> emoji. One reaction per member.
 final  Map<String, String> _reactions;
/// uid -> emoji. One reaction per member.
@override@JsonKey() Map<String, String> get reactions {
  if (_reactions is EqualUnmodifiableMapView) return _reactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_reactions);
}

/// Members mentioned in [body], used to raise mention notifications.
 final  List<String> _mentions;
/// Members mentioned in [body], used to raise mention notifications.
@override@JsonKey() List<String> get mentions {
  if (_mentions is EqualUnmodifiableListView) return _mentions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mentions);
}

/// Set when the message replies to another message in the room.
@override final  String? replyToMessageId;
@override@JsonKey() final  String replyToPreview;
@override@JsonKey() final  bool isEdited;
@override@NullableTimestampConverter() final  DateTime? editedAt;
/// Populated for [MessageType.system] messages so the client can render a
/// localized sentence rather than server-generated English.
@override final  ActivityAction? systemAction;
 final  Map<String, String> _systemParams;
@override@JsonKey() Map<String, String> get systemParams {
  if (_systemParams is EqualUnmodifiableMapView) return _systemParams;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_systemParams);
}

@override@NullableTimestampConverter() final  DateTime? deletedAt;
@override@JsonKey() final  int version;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMessageCopyWith<_ChatMessage> get copyWith => __$ChatMessageCopyWithImpl<_ChatMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.updatedBy, updatedBy) || other.updatedBy == updatedBy)&&(identical(other.type, type) || other.type == type)&&(identical(other.body, body) || other.body == body)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.senderPhotoUrl, senderPhotoUrl) || other.senderPhotoUrl == senderPhotoUrl)&&(identical(other.attachmentUrl, attachmentUrl) || other.attachmentUrl == attachmentUrl)&&(identical(other.attachmentPath, attachmentPath) || other.attachmentPath == attachmentPath)&&(identical(other.attachmentSizeBytes, attachmentSizeBytes) || other.attachmentSizeBytes == attachmentSizeBytes)&&(identical(other.voiceDuration, voiceDuration) || other.voiceDuration == voiceDuration)&&const DeepCollectionEquality().equals(other._waveform, _waveform)&&(identical(other.imageWidth, imageWidth) || other.imageWidth == imageWidth)&&(identical(other.imageHeight, imageHeight) || other.imageHeight == imageHeight)&&const DeepCollectionEquality().equals(other._readBy, _readBy)&&const DeepCollectionEquality().equals(other._reactions, _reactions)&&const DeepCollectionEquality().equals(other._mentions, _mentions)&&(identical(other.replyToMessageId, replyToMessageId) || other.replyToMessageId == replyToMessageId)&&(identical(other.replyToPreview, replyToPreview) || other.replyToPreview == replyToPreview)&&(identical(other.isEdited, isEdited) || other.isEdited == isEdited)&&(identical(other.editedAt, editedAt) || other.editedAt == editedAt)&&(identical(other.systemAction, systemAction) || other.systemAction == systemAction)&&const DeepCollectionEquality().equals(other._systemParams, _systemParams)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,roomId,senderId,createdAt,updatedAt,createdBy,updatedBy,type,body,senderName,senderPhotoUrl,attachmentUrl,attachmentPath,attachmentSizeBytes,voiceDuration,const DeepCollectionEquality().hash(_waveform),imageWidth,imageHeight,const DeepCollectionEquality().hash(_readBy),const DeepCollectionEquality().hash(_reactions),const DeepCollectionEquality().hash(_mentions),replyToMessageId,replyToPreview,isEdited,editedAt,systemAction,const DeepCollectionEquality().hash(_systemParams),deletedAt,version]);

@override
String toString() {
  return 'ChatMessage(id: $id, roomId: $roomId, senderId: $senderId, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy, type: $type, body: $body, senderName: $senderName, senderPhotoUrl: $senderPhotoUrl, attachmentUrl: $attachmentUrl, attachmentPath: $attachmentPath, attachmentSizeBytes: $attachmentSizeBytes, voiceDuration: $voiceDuration, waveform: $waveform, imageWidth: $imageWidth, imageHeight: $imageHeight, readBy: $readBy, reactions: $reactions, mentions: $mentions, replyToMessageId: $replyToMessageId, replyToPreview: $replyToPreview, isEdited: $isEdited, editedAt: $editedAt, systemAction: $systemAction, systemParams: $systemParams, deletedAt: $deletedAt, version: $version)';
}


}

/// @nodoc
abstract mixin class _$ChatMessageCopyWith<$Res> implements $ChatMessageCopyWith<$Res> {
  factory _$ChatMessageCopyWith(_ChatMessage value, $Res Function(_ChatMessage) _then) = __$ChatMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, String roomId, String senderId,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, String createdBy, String updatedBy, MessageType type, String body, String senderName, String? senderPhotoUrl, String? attachmentUrl, String? attachmentPath, int attachmentSizeBytes,@NullableDurationConverter() Duration? voiceDuration, List<double> waveform, int? imageWidth, int? imageHeight,@TimestampMapConverter() Map<String, DateTime> readBy, Map<String, String> reactions, List<String> mentions, String? replyToMessageId, String replyToPreview, bool isEdited,@NullableTimestampConverter() DateTime? editedAt, ActivityAction? systemAction, Map<String, String> systemParams,@NullableTimestampConverter() DateTime? deletedAt, int version
});




}
/// @nodoc
class __$ChatMessageCopyWithImpl<$Res>
    implements _$ChatMessageCopyWith<$Res> {
  __$ChatMessageCopyWithImpl(this._self, this._then);

  final _ChatMessage _self;
  final $Res Function(_ChatMessage) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? roomId = null,Object? senderId = null,Object? createdAt = null,Object? updatedAt = null,Object? createdBy = null,Object? updatedBy = null,Object? type = null,Object? body = null,Object? senderName = null,Object? senderPhotoUrl = freezed,Object? attachmentUrl = freezed,Object? attachmentPath = freezed,Object? attachmentSizeBytes = null,Object? voiceDuration = freezed,Object? waveform = null,Object? imageWidth = freezed,Object? imageHeight = freezed,Object? readBy = null,Object? reactions = null,Object? mentions = null,Object? replyToMessageId = freezed,Object? replyToPreview = null,Object? isEdited = null,Object? editedAt = freezed,Object? systemAction = freezed,Object? systemParams = null,Object? deletedAt = freezed,Object? version = null,}) {
  return _then(_ChatMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,updatedBy: null == updatedBy ? _self.updatedBy : updatedBy // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MessageType,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,senderPhotoUrl: freezed == senderPhotoUrl ? _self.senderPhotoUrl : senderPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,attachmentUrl: freezed == attachmentUrl ? _self.attachmentUrl : attachmentUrl // ignore: cast_nullable_to_non_nullable
as String?,attachmentPath: freezed == attachmentPath ? _self.attachmentPath : attachmentPath // ignore: cast_nullable_to_non_nullable
as String?,attachmentSizeBytes: null == attachmentSizeBytes ? _self.attachmentSizeBytes : attachmentSizeBytes // ignore: cast_nullable_to_non_nullable
as int,voiceDuration: freezed == voiceDuration ? _self.voiceDuration : voiceDuration // ignore: cast_nullable_to_non_nullable
as Duration?,waveform: null == waveform ? _self._waveform : waveform // ignore: cast_nullable_to_non_nullable
as List<double>,imageWidth: freezed == imageWidth ? _self.imageWidth : imageWidth // ignore: cast_nullable_to_non_nullable
as int?,imageHeight: freezed == imageHeight ? _self.imageHeight : imageHeight // ignore: cast_nullable_to_non_nullable
as int?,readBy: null == readBy ? _self._readBy : readBy // ignore: cast_nullable_to_non_nullable
as Map<String, DateTime>,reactions: null == reactions ? _self._reactions : reactions // ignore: cast_nullable_to_non_nullable
as Map<String, String>,mentions: null == mentions ? _self._mentions : mentions // ignore: cast_nullable_to_non_nullable
as List<String>,replyToMessageId: freezed == replyToMessageId ? _self.replyToMessageId : replyToMessageId // ignore: cast_nullable_to_non_nullable
as String?,replyToPreview: null == replyToPreview ? _self.replyToPreview : replyToPreview // ignore: cast_nullable_to_non_nullable
as String,isEdited: null == isEdited ? _self.isEdited : isEdited // ignore: cast_nullable_to_non_nullable
as bool,editedAt: freezed == editedAt ? _self.editedAt : editedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,systemAction: freezed == systemAction ? _self.systemAction : systemAction // ignore: cast_nullable_to_non_nullable
as ActivityAction?,systemParams: null == systemParams ? _self._systemParams : systemParams // ignore: cast_nullable_to_non_nullable
as Map<String, String>,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
