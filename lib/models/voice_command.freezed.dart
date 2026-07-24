// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voice_command.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ParsedVoiceItem {

 String get name;@FlexibleDoubleConverter() double get quantity; MeasurementUnit get unit; String? get categoryId; ItemPriority get priority;@FlexibleDoubleConverter() double get confidence;/// Substring of the transcript this item was derived from.
 String get sourcePhrase;
/// Create a copy of ParsedVoiceItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParsedVoiceItemCopyWith<ParsedVoiceItem> get copyWith => _$ParsedVoiceItemCopyWithImpl<ParsedVoiceItem>(this as ParsedVoiceItem, _$identity);

  /// Serializes this ParsedVoiceItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParsedVoiceItem&&(identical(other.name, name) || other.name == name)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.sourcePhrase, sourcePhrase) || other.sourcePhrase == sourcePhrase));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,quantity,unit,categoryId,priority,confidence,sourcePhrase);

@override
String toString() {
  return 'ParsedVoiceItem(name: $name, quantity: $quantity, unit: $unit, categoryId: $categoryId, priority: $priority, confidence: $confidence, sourcePhrase: $sourcePhrase)';
}


}

/// @nodoc
abstract mixin class $ParsedVoiceItemCopyWith<$Res>  {
  factory $ParsedVoiceItemCopyWith(ParsedVoiceItem value, $Res Function(ParsedVoiceItem) _then) = _$ParsedVoiceItemCopyWithImpl;
@useResult
$Res call({
 String name,@FlexibleDoubleConverter() double quantity, MeasurementUnit unit, String? categoryId, ItemPriority priority,@FlexibleDoubleConverter() double confidence, String sourcePhrase
});




}
/// @nodoc
class _$ParsedVoiceItemCopyWithImpl<$Res>
    implements $ParsedVoiceItemCopyWith<$Res> {
  _$ParsedVoiceItemCopyWithImpl(this._self, this._then);

  final ParsedVoiceItem _self;
  final $Res Function(ParsedVoiceItem) _then;

/// Create a copy of ParsedVoiceItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? quantity = null,Object? unit = null,Object? categoryId = freezed,Object? priority = null,Object? confidence = null,Object? sourcePhrase = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as MeasurementUnit,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as ItemPriority,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,sourcePhrase: null == sourcePhrase ? _self.sourcePhrase : sourcePhrase // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ParsedVoiceItem].
extension ParsedVoiceItemPatterns on ParsedVoiceItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParsedVoiceItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParsedVoiceItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParsedVoiceItem value)  $default,){
final _that = this;
switch (_that) {
case _ParsedVoiceItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParsedVoiceItem value)?  $default,){
final _that = this;
switch (_that) {
case _ParsedVoiceItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name, @FlexibleDoubleConverter()  double quantity,  MeasurementUnit unit,  String? categoryId,  ItemPriority priority, @FlexibleDoubleConverter()  double confidence,  String sourcePhrase)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParsedVoiceItem() when $default != null:
return $default(_that.name,_that.quantity,_that.unit,_that.categoryId,_that.priority,_that.confidence,_that.sourcePhrase);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name, @FlexibleDoubleConverter()  double quantity,  MeasurementUnit unit,  String? categoryId,  ItemPriority priority, @FlexibleDoubleConverter()  double confidence,  String sourcePhrase)  $default,) {final _that = this;
switch (_that) {
case _ParsedVoiceItem():
return $default(_that.name,_that.quantity,_that.unit,_that.categoryId,_that.priority,_that.confidence,_that.sourcePhrase);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name, @FlexibleDoubleConverter()  double quantity,  MeasurementUnit unit,  String? categoryId,  ItemPriority priority, @FlexibleDoubleConverter()  double confidence,  String sourcePhrase)?  $default,) {final _that = this;
switch (_that) {
case _ParsedVoiceItem() when $default != null:
return $default(_that.name,_that.quantity,_that.unit,_that.categoryId,_that.priority,_that.confidence,_that.sourcePhrase);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ParsedVoiceItem implements ParsedVoiceItem {
  const _ParsedVoiceItem({required this.name, @FlexibleDoubleConverter() this.quantity = 1, this.unit = MeasurementUnit.piece, this.categoryId, this.priority = ItemPriority.normal, @FlexibleDoubleConverter() this.confidence = 1, this.sourcePhrase = ''});
  factory _ParsedVoiceItem.fromJson(Map<String, dynamic> json) => _$ParsedVoiceItemFromJson(json);

@override final  String name;
@override@JsonKey()@FlexibleDoubleConverter() final  double quantity;
@override@JsonKey() final  MeasurementUnit unit;
@override final  String? categoryId;
@override@JsonKey() final  ItemPriority priority;
@override@JsonKey()@FlexibleDoubleConverter() final  double confidence;
/// Substring of the transcript this item was derived from.
@override@JsonKey() final  String sourcePhrase;

/// Create a copy of ParsedVoiceItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParsedVoiceItemCopyWith<_ParsedVoiceItem> get copyWith => __$ParsedVoiceItemCopyWithImpl<_ParsedVoiceItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParsedVoiceItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParsedVoiceItem&&(identical(other.name, name) || other.name == name)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.sourcePhrase, sourcePhrase) || other.sourcePhrase == sourcePhrase));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,quantity,unit,categoryId,priority,confidence,sourcePhrase);

@override
String toString() {
  return 'ParsedVoiceItem(name: $name, quantity: $quantity, unit: $unit, categoryId: $categoryId, priority: $priority, confidence: $confidence, sourcePhrase: $sourcePhrase)';
}


}

/// @nodoc
abstract mixin class _$ParsedVoiceItemCopyWith<$Res> implements $ParsedVoiceItemCopyWith<$Res> {
  factory _$ParsedVoiceItemCopyWith(_ParsedVoiceItem value, $Res Function(_ParsedVoiceItem) _then) = __$ParsedVoiceItemCopyWithImpl;
@override @useResult
$Res call({
 String name,@FlexibleDoubleConverter() double quantity, MeasurementUnit unit, String? categoryId, ItemPriority priority,@FlexibleDoubleConverter() double confidence, String sourcePhrase
});




}
/// @nodoc
class __$ParsedVoiceItemCopyWithImpl<$Res>
    implements _$ParsedVoiceItemCopyWith<$Res> {
  __$ParsedVoiceItemCopyWithImpl(this._self, this._then);

  final _ParsedVoiceItem _self;
  final $Res Function(_ParsedVoiceItem) _then;

/// Create a copy of ParsedVoiceItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? quantity = null,Object? unit = null,Object? categoryId = freezed,Object? priority = null,Object? confidence = null,Object? sourcePhrase = null,}) {
  return _then(_ParsedVoiceItem(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as MeasurementUnit,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as ItemPriority,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,sourcePhrase: null == sourcePhrase ? _self.sourcePhrase : sourcePhrase // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$VoiceCommand {

 String get id; String get userId;@TimestampConverter() DateTime get createdAt;@TimestampConverter() DateTime get updatedAt; VoiceCommandStatus get status; String get transcript; String get localeId;@FlexibleDoubleConverter() double get confidence; List<ParsedVoiceItem> get parsedItems;/// List the items were added to once the parse was accepted.
 String? get listId;/// Ids of the items actually created, so the action can be undone.
 List<String> get createdItemIds;/// Failure reason when [status] is `failed`, as an `AppException` code.
 String? get errorCode;@NullableDurationConverter() Duration? get captureDuration;
/// Create a copy of VoiceCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoiceCommandCopyWith<VoiceCommand> get copyWith => _$VoiceCommandCopyWithImpl<VoiceCommand>(this as VoiceCommand, _$identity);

  /// Serializes this VoiceCommand to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceCommand&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.transcript, transcript) || other.transcript == transcript)&&(identical(other.localeId, localeId) || other.localeId == localeId)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&const DeepCollectionEquality().equals(other.parsedItems, parsedItems)&&(identical(other.listId, listId) || other.listId == listId)&&const DeepCollectionEquality().equals(other.createdItemIds, createdItemIds)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.captureDuration, captureDuration) || other.captureDuration == captureDuration));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,createdAt,updatedAt,status,transcript,localeId,confidence,const DeepCollectionEquality().hash(parsedItems),listId,const DeepCollectionEquality().hash(createdItemIds),errorCode,captureDuration);

@override
String toString() {
  return 'VoiceCommand(id: $id, userId: $userId, createdAt: $createdAt, updatedAt: $updatedAt, status: $status, transcript: $transcript, localeId: $localeId, confidence: $confidence, parsedItems: $parsedItems, listId: $listId, createdItemIds: $createdItemIds, errorCode: $errorCode, captureDuration: $captureDuration)';
}


}

/// @nodoc
abstract mixin class $VoiceCommandCopyWith<$Res>  {
  factory $VoiceCommandCopyWith(VoiceCommand value, $Res Function(VoiceCommand) _then) = _$VoiceCommandCopyWithImpl;
@useResult
$Res call({
 String id, String userId,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, VoiceCommandStatus status, String transcript, String localeId,@FlexibleDoubleConverter() double confidence, List<ParsedVoiceItem> parsedItems, String? listId, List<String> createdItemIds, String? errorCode,@NullableDurationConverter() Duration? captureDuration
});




}
/// @nodoc
class _$VoiceCommandCopyWithImpl<$Res>
    implements $VoiceCommandCopyWith<$Res> {
  _$VoiceCommandCopyWithImpl(this._self, this._then);

  final VoiceCommand _self;
  final $Res Function(VoiceCommand) _then;

/// Create a copy of VoiceCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? createdAt = null,Object? updatedAt = null,Object? status = null,Object? transcript = null,Object? localeId = null,Object? confidence = null,Object? parsedItems = null,Object? listId = freezed,Object? createdItemIds = null,Object? errorCode = freezed,Object? captureDuration = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as VoiceCommandStatus,transcript: null == transcript ? _self.transcript : transcript // ignore: cast_nullable_to_non_nullable
as String,localeId: null == localeId ? _self.localeId : localeId // ignore: cast_nullable_to_non_nullable
as String,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,parsedItems: null == parsedItems ? _self.parsedItems : parsedItems // ignore: cast_nullable_to_non_nullable
as List<ParsedVoiceItem>,listId: freezed == listId ? _self.listId : listId // ignore: cast_nullable_to_non_nullable
as String?,createdItemIds: null == createdItemIds ? _self.createdItemIds : createdItemIds // ignore: cast_nullable_to_non_nullable
as List<String>,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,captureDuration: freezed == captureDuration ? _self.captureDuration : captureDuration // ignore: cast_nullable_to_non_nullable
as Duration?,
  ));
}

}


/// Adds pattern-matching-related methods to [VoiceCommand].
extension VoiceCommandPatterns on VoiceCommand {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VoiceCommand value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VoiceCommand() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VoiceCommand value)  $default,){
final _that = this;
switch (_that) {
case _VoiceCommand():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VoiceCommand value)?  $default,){
final _that = this;
switch (_that) {
case _VoiceCommand() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  VoiceCommandStatus status,  String transcript,  String localeId, @FlexibleDoubleConverter()  double confidence,  List<ParsedVoiceItem> parsedItems,  String? listId,  List<String> createdItemIds,  String? errorCode, @NullableDurationConverter()  Duration? captureDuration)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VoiceCommand() when $default != null:
return $default(_that.id,_that.userId,_that.createdAt,_that.updatedAt,_that.status,_that.transcript,_that.localeId,_that.confidence,_that.parsedItems,_that.listId,_that.createdItemIds,_that.errorCode,_that.captureDuration);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  VoiceCommandStatus status,  String transcript,  String localeId, @FlexibleDoubleConverter()  double confidence,  List<ParsedVoiceItem> parsedItems,  String? listId,  List<String> createdItemIds,  String? errorCode, @NullableDurationConverter()  Duration? captureDuration)  $default,) {final _that = this;
switch (_that) {
case _VoiceCommand():
return $default(_that.id,_that.userId,_that.createdAt,_that.updatedAt,_that.status,_that.transcript,_that.localeId,_that.confidence,_that.parsedItems,_that.listId,_that.createdItemIds,_that.errorCode,_that.captureDuration);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  VoiceCommandStatus status,  String transcript,  String localeId, @FlexibleDoubleConverter()  double confidence,  List<ParsedVoiceItem> parsedItems,  String? listId,  List<String> createdItemIds,  String? errorCode, @NullableDurationConverter()  Duration? captureDuration)?  $default,) {final _that = this;
switch (_that) {
case _VoiceCommand() when $default != null:
return $default(_that.id,_that.userId,_that.createdAt,_that.updatedAt,_that.status,_that.transcript,_that.localeId,_that.confidence,_that.parsedItems,_that.listId,_that.createdItemIds,_that.errorCode,_that.captureDuration);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VoiceCommand implements VoiceCommand {
  const _VoiceCommand({required this.id, required this.userId, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt, this.status = VoiceCommandStatus.listening, this.transcript = '', this.localeId = 'en', @FlexibleDoubleConverter() this.confidence = 1, final  List<ParsedVoiceItem> parsedItems = const <ParsedVoiceItem>[], this.listId, final  List<String> createdItemIds = const <String>[], this.errorCode, @NullableDurationConverter() this.captureDuration}): _parsedItems = parsedItems,_createdItemIds = createdItemIds;
  factory _VoiceCommand.fromJson(Map<String, dynamic> json) => _$VoiceCommandFromJson(json);

@override final  String id;
@override final  String userId;
@override@TimestampConverter() final  DateTime createdAt;
@override@TimestampConverter() final  DateTime updatedAt;
@override@JsonKey() final  VoiceCommandStatus status;
@override@JsonKey() final  String transcript;
@override@JsonKey() final  String localeId;
@override@JsonKey()@FlexibleDoubleConverter() final  double confidence;
 final  List<ParsedVoiceItem> _parsedItems;
@override@JsonKey() List<ParsedVoiceItem> get parsedItems {
  if (_parsedItems is EqualUnmodifiableListView) return _parsedItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_parsedItems);
}

/// List the items were added to once the parse was accepted.
@override final  String? listId;
/// Ids of the items actually created, so the action can be undone.
 final  List<String> _createdItemIds;
/// Ids of the items actually created, so the action can be undone.
@override@JsonKey() List<String> get createdItemIds {
  if (_createdItemIds is EqualUnmodifiableListView) return _createdItemIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_createdItemIds);
}

/// Failure reason when [status] is `failed`, as an `AppException` code.
@override final  String? errorCode;
@override@NullableDurationConverter() final  Duration? captureDuration;

/// Create a copy of VoiceCommand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VoiceCommandCopyWith<_VoiceCommand> get copyWith => __$VoiceCommandCopyWithImpl<_VoiceCommand>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VoiceCommandToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VoiceCommand&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.transcript, transcript) || other.transcript == transcript)&&(identical(other.localeId, localeId) || other.localeId == localeId)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&const DeepCollectionEquality().equals(other._parsedItems, _parsedItems)&&(identical(other.listId, listId) || other.listId == listId)&&const DeepCollectionEquality().equals(other._createdItemIds, _createdItemIds)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.captureDuration, captureDuration) || other.captureDuration == captureDuration));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,createdAt,updatedAt,status,transcript,localeId,confidence,const DeepCollectionEquality().hash(_parsedItems),listId,const DeepCollectionEquality().hash(_createdItemIds),errorCode,captureDuration);

@override
String toString() {
  return 'VoiceCommand(id: $id, userId: $userId, createdAt: $createdAt, updatedAt: $updatedAt, status: $status, transcript: $transcript, localeId: $localeId, confidence: $confidence, parsedItems: $parsedItems, listId: $listId, createdItemIds: $createdItemIds, errorCode: $errorCode, captureDuration: $captureDuration)';
}


}

/// @nodoc
abstract mixin class _$VoiceCommandCopyWith<$Res> implements $VoiceCommandCopyWith<$Res> {
  factory _$VoiceCommandCopyWith(_VoiceCommand value, $Res Function(_VoiceCommand) _then) = __$VoiceCommandCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, VoiceCommandStatus status, String transcript, String localeId,@FlexibleDoubleConverter() double confidence, List<ParsedVoiceItem> parsedItems, String? listId, List<String> createdItemIds, String? errorCode,@NullableDurationConverter() Duration? captureDuration
});




}
/// @nodoc
class __$VoiceCommandCopyWithImpl<$Res>
    implements _$VoiceCommandCopyWith<$Res> {
  __$VoiceCommandCopyWithImpl(this._self, this._then);

  final _VoiceCommand _self;
  final $Res Function(_VoiceCommand) _then;

/// Create a copy of VoiceCommand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? createdAt = null,Object? updatedAt = null,Object? status = null,Object? transcript = null,Object? localeId = null,Object? confidence = null,Object? parsedItems = null,Object? listId = freezed,Object? createdItemIds = null,Object? errorCode = freezed,Object? captureDuration = freezed,}) {
  return _then(_VoiceCommand(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as VoiceCommandStatus,transcript: null == transcript ? _self.transcript : transcript // ignore: cast_nullable_to_non_nullable
as String,localeId: null == localeId ? _self.localeId : localeId // ignore: cast_nullable_to_non_nullable
as String,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,parsedItems: null == parsedItems ? _self._parsedItems : parsedItems // ignore: cast_nullable_to_non_nullable
as List<ParsedVoiceItem>,listId: freezed == listId ? _self.listId : listId // ignore: cast_nullable_to_non_nullable
as String?,createdItemIds: null == createdItemIds ? _self._createdItemIds : createdItemIds // ignore: cast_nullable_to_non_nullable
as List<String>,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,captureDuration: freezed == captureDuration ? _self.captureDuration : captureDuration // ignore: cast_nullable_to_non_nullable
as Duration?,
  ));
}


}

// dart format on
