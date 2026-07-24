// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AiMessage {

 AiMessageRole get role; String get content;
/// Create a copy of AiMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiMessageCopyWith<AiMessage> get copyWith => _$AiMessageCopyWithImpl<AiMessage>(this as AiMessage, _$identity);

  /// Serializes this AiMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiMessage&&(identical(other.role, role) || other.role == role)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,role,content);

@override
String toString() {
  return 'AiMessage(role: $role, content: $content)';
}


}

/// @nodoc
abstract mixin class $AiMessageCopyWith<$Res>  {
  factory $AiMessageCopyWith(AiMessage value, $Res Function(AiMessage) _then) = _$AiMessageCopyWithImpl;
@useResult
$Res call({
 AiMessageRole role, String content
});




}
/// @nodoc
class _$AiMessageCopyWithImpl<$Res>
    implements $AiMessageCopyWith<$Res> {
  _$AiMessageCopyWithImpl(this._self, this._then);

  final AiMessage _self;
  final $Res Function(AiMessage) _then;

/// Create a copy of AiMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? role = null,Object? content = null,}) {
  return _then(_self.copyWith(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as AiMessageRole,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AiMessage].
extension AiMessagePatterns on AiMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiMessage value)  $default,){
final _that = this;
switch (_that) {
case _AiMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiMessage value)?  $default,){
final _that = this;
switch (_that) {
case _AiMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AiMessageRole role,  String content)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiMessage() when $default != null:
return $default(_that.role,_that.content);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AiMessageRole role,  String content)  $default,) {final _that = this;
switch (_that) {
case _AiMessage():
return $default(_that.role,_that.content);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AiMessageRole role,  String content)?  $default,) {final _that = this;
switch (_that) {
case _AiMessage() when $default != null:
return $default(_that.role,_that.content);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiMessage implements AiMessage {
  const _AiMessage({required this.role, required this.content});
  factory _AiMessage.fromJson(Map<String, dynamic> json) => _$AiMessageFromJson(json);

@override final  AiMessageRole role;
@override final  String content;

/// Create a copy of AiMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiMessageCopyWith<_AiMessage> get copyWith => __$AiMessageCopyWithImpl<_AiMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiMessage&&(identical(other.role, role) || other.role == role)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,role,content);

@override
String toString() {
  return 'AiMessage(role: $role, content: $content)';
}


}

/// @nodoc
abstract mixin class _$AiMessageCopyWith<$Res> implements $AiMessageCopyWith<$Res> {
  factory _$AiMessageCopyWith(_AiMessage value, $Res Function(_AiMessage) _then) = __$AiMessageCopyWithImpl;
@override @useResult
$Res call({
 AiMessageRole role, String content
});




}
/// @nodoc
class __$AiMessageCopyWithImpl<$Res>
    implements _$AiMessageCopyWith<$Res> {
  __$AiMessageCopyWithImpl(this._self, this._then);

  final _AiMessage _self;
  final $Res Function(_AiMessage) _then;

/// Create a copy of AiMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? role = null,Object? content = null,}) {
  return _then(_AiMessage(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as AiMessageRole,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$AiRequest {

 List<AiMessage> get messages;/// Instruction turn hoisted out of [messages]; providers that carry a
/// dedicated system field use it, the rest prepend it.
 String? get systemPrompt; int get maxTokens;/// JSON Schema the response must satisfy. Null requests free-form text.
 Map<String, dynamic>? get jsonSchema;/// Sampling temperature. Ignored by providers that reject it — notably
/// Claude Opus 5, which returns HTTP 400 if the field is present.
 double? get temperature;/// Overrides the provider's configured default model.
 String? get model;
/// Create a copy of AiRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiRequestCopyWith<AiRequest> get copyWith => _$AiRequestCopyWithImpl<AiRequest>(this as AiRequest, _$identity);

  /// Serializes this AiRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiRequest&&const DeepCollectionEquality().equals(other.messages, messages)&&(identical(other.systemPrompt, systemPrompt) || other.systemPrompt == systemPrompt)&&(identical(other.maxTokens, maxTokens) || other.maxTokens == maxTokens)&&const DeepCollectionEquality().equals(other.jsonSchema, jsonSchema)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.model, model) || other.model == model));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(messages),systemPrompt,maxTokens,const DeepCollectionEquality().hash(jsonSchema),temperature,model);

@override
String toString() {
  return 'AiRequest(messages: $messages, systemPrompt: $systemPrompt, maxTokens: $maxTokens, jsonSchema: $jsonSchema, temperature: $temperature, model: $model)';
}


}

/// @nodoc
abstract mixin class $AiRequestCopyWith<$Res>  {
  factory $AiRequestCopyWith(AiRequest value, $Res Function(AiRequest) _then) = _$AiRequestCopyWithImpl;
@useResult
$Res call({
 List<AiMessage> messages, String? systemPrompt, int maxTokens, Map<String, dynamic>? jsonSchema, double? temperature, String? model
});




}
/// @nodoc
class _$AiRequestCopyWithImpl<$Res>
    implements $AiRequestCopyWith<$Res> {
  _$AiRequestCopyWithImpl(this._self, this._then);

  final AiRequest _self;
  final $Res Function(AiRequest) _then;

/// Create a copy of AiRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messages = null,Object? systemPrompt = freezed,Object? maxTokens = null,Object? jsonSchema = freezed,Object? temperature = freezed,Object? model = freezed,}) {
  return _then(_self.copyWith(
messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<AiMessage>,systemPrompt: freezed == systemPrompt ? _self.systemPrompt : systemPrompt // ignore: cast_nullable_to_non_nullable
as String?,maxTokens: null == maxTokens ? _self.maxTokens : maxTokens // ignore: cast_nullable_to_non_nullable
as int,jsonSchema: freezed == jsonSchema ? _self.jsonSchema : jsonSchema // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AiRequest].
extension AiRequestPatterns on AiRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiRequest value)  $default,){
final _that = this;
switch (_that) {
case _AiRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiRequest value)?  $default,){
final _that = this;
switch (_that) {
case _AiRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<AiMessage> messages,  String? systemPrompt,  int maxTokens,  Map<String, dynamic>? jsonSchema,  double? temperature,  String? model)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiRequest() when $default != null:
return $default(_that.messages,_that.systemPrompt,_that.maxTokens,_that.jsonSchema,_that.temperature,_that.model);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<AiMessage> messages,  String? systemPrompt,  int maxTokens,  Map<String, dynamic>? jsonSchema,  double? temperature,  String? model)  $default,) {final _that = this;
switch (_that) {
case _AiRequest():
return $default(_that.messages,_that.systemPrompt,_that.maxTokens,_that.jsonSchema,_that.temperature,_that.model);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<AiMessage> messages,  String? systemPrompt,  int maxTokens,  Map<String, dynamic>? jsonSchema,  double? temperature,  String? model)?  $default,) {final _that = this;
switch (_that) {
case _AiRequest() when $default != null:
return $default(_that.messages,_that.systemPrompt,_that.maxTokens,_that.jsonSchema,_that.temperature,_that.model);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiRequest implements AiRequest {
  const _AiRequest({required final  List<AiMessage> messages, this.systemPrompt, this.maxTokens = 4096, final  Map<String, dynamic>? jsonSchema, this.temperature, this.model}): _messages = messages,_jsonSchema = jsonSchema;
  factory _AiRequest.fromJson(Map<String, dynamic> json) => _$AiRequestFromJson(json);

 final  List<AiMessage> _messages;
@override List<AiMessage> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

/// Instruction turn hoisted out of [messages]; providers that carry a
/// dedicated system field use it, the rest prepend it.
@override final  String? systemPrompt;
@override@JsonKey() final  int maxTokens;
/// JSON Schema the response must satisfy. Null requests free-form text.
 final  Map<String, dynamic>? _jsonSchema;
/// JSON Schema the response must satisfy. Null requests free-form text.
@override Map<String, dynamic>? get jsonSchema {
  final value = _jsonSchema;
  if (value == null) return null;
  if (_jsonSchema is EqualUnmodifiableMapView) return _jsonSchema;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Sampling temperature. Ignored by providers that reject it — notably
/// Claude Opus 5, which returns HTTP 400 if the field is present.
@override final  double? temperature;
/// Overrides the provider's configured default model.
@override final  String? model;

/// Create a copy of AiRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiRequestCopyWith<_AiRequest> get copyWith => __$AiRequestCopyWithImpl<_AiRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiRequest&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.systemPrompt, systemPrompt) || other.systemPrompt == systemPrompt)&&(identical(other.maxTokens, maxTokens) || other.maxTokens == maxTokens)&&const DeepCollectionEquality().equals(other._jsonSchema, _jsonSchema)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.model, model) || other.model == model));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_messages),systemPrompt,maxTokens,const DeepCollectionEquality().hash(_jsonSchema),temperature,model);

@override
String toString() {
  return 'AiRequest(messages: $messages, systemPrompt: $systemPrompt, maxTokens: $maxTokens, jsonSchema: $jsonSchema, temperature: $temperature, model: $model)';
}


}

/// @nodoc
abstract mixin class _$AiRequestCopyWith<$Res> implements $AiRequestCopyWith<$Res> {
  factory _$AiRequestCopyWith(_AiRequest value, $Res Function(_AiRequest) _then) = __$AiRequestCopyWithImpl;
@override @useResult
$Res call({
 List<AiMessage> messages, String? systemPrompt, int maxTokens, Map<String, dynamic>? jsonSchema, double? temperature, String? model
});




}
/// @nodoc
class __$AiRequestCopyWithImpl<$Res>
    implements _$AiRequestCopyWith<$Res> {
  __$AiRequestCopyWithImpl(this._self, this._then);

  final _AiRequest _self;
  final $Res Function(_AiRequest) _then;

/// Create a copy of AiRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messages = null,Object? systemPrompt = freezed,Object? maxTokens = null,Object? jsonSchema = freezed,Object? temperature = freezed,Object? model = freezed,}) {
  return _then(_AiRequest(
messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<AiMessage>,systemPrompt: freezed == systemPrompt ? _self.systemPrompt : systemPrompt // ignore: cast_nullable_to_non_nullable
as String?,maxTokens: null == maxTokens ? _self.maxTokens : maxTokens // ignore: cast_nullable_to_non_nullable
as int,jsonSchema: freezed == jsonSchema ? _self._jsonSchema : jsonSchema // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,temperature: freezed == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double?,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AiResponse {

 String get text; AiProviderKind get provider; String get model; AiStopReason get stopReason; int get inputTokens; int get outputTokens;/// Populated when [stopReason] is [AiStopReason.refusal].
 String? get refusalCategory;
/// Create a copy of AiResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiResponseCopyWith<AiResponse> get copyWith => _$AiResponseCopyWithImpl<AiResponse>(this as AiResponse, _$identity);

  /// Serializes this AiResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiResponse&&(identical(other.text, text) || other.text == text)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.model, model) || other.model == model)&&(identical(other.stopReason, stopReason) || other.stopReason == stopReason)&&(identical(other.inputTokens, inputTokens) || other.inputTokens == inputTokens)&&(identical(other.outputTokens, outputTokens) || other.outputTokens == outputTokens)&&(identical(other.refusalCategory, refusalCategory) || other.refusalCategory == refusalCategory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,provider,model,stopReason,inputTokens,outputTokens,refusalCategory);

@override
String toString() {
  return 'AiResponse(text: $text, provider: $provider, model: $model, stopReason: $stopReason, inputTokens: $inputTokens, outputTokens: $outputTokens, refusalCategory: $refusalCategory)';
}


}

/// @nodoc
abstract mixin class $AiResponseCopyWith<$Res>  {
  factory $AiResponseCopyWith(AiResponse value, $Res Function(AiResponse) _then) = _$AiResponseCopyWithImpl;
@useResult
$Res call({
 String text, AiProviderKind provider, String model, AiStopReason stopReason, int inputTokens, int outputTokens, String? refusalCategory
});




}
/// @nodoc
class _$AiResponseCopyWithImpl<$Res>
    implements $AiResponseCopyWith<$Res> {
  _$AiResponseCopyWithImpl(this._self, this._then);

  final AiResponse _self;
  final $Res Function(AiResponse) _then;

/// Create a copy of AiResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? provider = null,Object? model = null,Object? stopReason = null,Object? inputTokens = null,Object? outputTokens = null,Object? refusalCategory = freezed,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as AiProviderKind,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,stopReason: null == stopReason ? _self.stopReason : stopReason // ignore: cast_nullable_to_non_nullable
as AiStopReason,inputTokens: null == inputTokens ? _self.inputTokens : inputTokens // ignore: cast_nullable_to_non_nullable
as int,outputTokens: null == outputTokens ? _self.outputTokens : outputTokens // ignore: cast_nullable_to_non_nullable
as int,refusalCategory: freezed == refusalCategory ? _self.refusalCategory : refusalCategory // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AiResponse].
extension AiResponsePatterns on AiResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiResponse value)  $default,){
final _that = this;
switch (_that) {
case _AiResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AiResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String text,  AiProviderKind provider,  String model,  AiStopReason stopReason,  int inputTokens,  int outputTokens,  String? refusalCategory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiResponse() when $default != null:
return $default(_that.text,_that.provider,_that.model,_that.stopReason,_that.inputTokens,_that.outputTokens,_that.refusalCategory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String text,  AiProviderKind provider,  String model,  AiStopReason stopReason,  int inputTokens,  int outputTokens,  String? refusalCategory)  $default,) {final _that = this;
switch (_that) {
case _AiResponse():
return $default(_that.text,_that.provider,_that.model,_that.stopReason,_that.inputTokens,_that.outputTokens,_that.refusalCategory);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String text,  AiProviderKind provider,  String model,  AiStopReason stopReason,  int inputTokens,  int outputTokens,  String? refusalCategory)?  $default,) {final _that = this;
switch (_that) {
case _AiResponse() when $default != null:
return $default(_that.text,_that.provider,_that.model,_that.stopReason,_that.inputTokens,_that.outputTokens,_that.refusalCategory);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiResponse implements AiResponse {
  const _AiResponse({required this.text, required this.provider, required this.model, this.stopReason = AiStopReason.completed, this.inputTokens = 0, this.outputTokens = 0, this.refusalCategory});
  factory _AiResponse.fromJson(Map<String, dynamic> json) => _$AiResponseFromJson(json);

@override final  String text;
@override final  AiProviderKind provider;
@override final  String model;
@override@JsonKey() final  AiStopReason stopReason;
@override@JsonKey() final  int inputTokens;
@override@JsonKey() final  int outputTokens;
/// Populated when [stopReason] is [AiStopReason.refusal].
@override final  String? refusalCategory;

/// Create a copy of AiResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiResponseCopyWith<_AiResponse> get copyWith => __$AiResponseCopyWithImpl<_AiResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiResponse&&(identical(other.text, text) || other.text == text)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.model, model) || other.model == model)&&(identical(other.stopReason, stopReason) || other.stopReason == stopReason)&&(identical(other.inputTokens, inputTokens) || other.inputTokens == inputTokens)&&(identical(other.outputTokens, outputTokens) || other.outputTokens == outputTokens)&&(identical(other.refusalCategory, refusalCategory) || other.refusalCategory == refusalCategory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,provider,model,stopReason,inputTokens,outputTokens,refusalCategory);

@override
String toString() {
  return 'AiResponse(text: $text, provider: $provider, model: $model, stopReason: $stopReason, inputTokens: $inputTokens, outputTokens: $outputTokens, refusalCategory: $refusalCategory)';
}


}

/// @nodoc
abstract mixin class _$AiResponseCopyWith<$Res> implements $AiResponseCopyWith<$Res> {
  factory _$AiResponseCopyWith(_AiResponse value, $Res Function(_AiResponse) _then) = __$AiResponseCopyWithImpl;
@override @useResult
$Res call({
 String text, AiProviderKind provider, String model, AiStopReason stopReason, int inputTokens, int outputTokens, String? refusalCategory
});




}
/// @nodoc
class __$AiResponseCopyWithImpl<$Res>
    implements _$AiResponseCopyWith<$Res> {
  __$AiResponseCopyWithImpl(this._self, this._then);

  final _AiResponse _self;
  final $Res Function(_AiResponse) _then;

/// Create a copy of AiResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? provider = null,Object? model = null,Object? stopReason = null,Object? inputTokens = null,Object? outputTokens = null,Object? refusalCategory = freezed,}) {
  return _then(_AiResponse(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as AiProviderKind,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,stopReason: null == stopReason ? _self.stopReason : stopReason // ignore: cast_nullable_to_non_nullable
as AiStopReason,inputTokens: null == inputTokens ? _self.inputTokens : inputTokens // ignore: cast_nullable_to_non_nullable
as int,outputTokens: null == outputTokens ? _self.outputTokens : outputTokens // ignore: cast_nullable_to_non_nullable
as int,refusalCategory: freezed == refusalCategory ? _self.refusalCategory : refusalCategory // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$GeneratedItem {

 String get name;@FlexibleDoubleConverter() double get quantity; MeasurementUnit get unit;/// Category name as proposed by the model; resolved against the category
/// collection before the item is written.
 String get category; String get notes; ItemPriority get priority;@NullableDoubleConverter() double? get estimatedPrice;
/// Create a copy of GeneratedItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeneratedItemCopyWith<GeneratedItem> get copyWith => _$GeneratedItemCopyWithImpl<GeneratedItem>(this as GeneratedItem, _$identity);

  /// Serializes this GeneratedItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeneratedItem&&(identical(other.name, name) || other.name == name)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.category, category) || other.category == category)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.estimatedPrice, estimatedPrice) || other.estimatedPrice == estimatedPrice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,quantity,unit,category,notes,priority,estimatedPrice);

@override
String toString() {
  return 'GeneratedItem(name: $name, quantity: $quantity, unit: $unit, category: $category, notes: $notes, priority: $priority, estimatedPrice: $estimatedPrice)';
}


}

/// @nodoc
abstract mixin class $GeneratedItemCopyWith<$Res>  {
  factory $GeneratedItemCopyWith(GeneratedItem value, $Res Function(GeneratedItem) _then) = _$GeneratedItemCopyWithImpl;
@useResult
$Res call({
 String name,@FlexibleDoubleConverter() double quantity, MeasurementUnit unit, String category, String notes, ItemPriority priority,@NullableDoubleConverter() double? estimatedPrice
});




}
/// @nodoc
class _$GeneratedItemCopyWithImpl<$Res>
    implements $GeneratedItemCopyWith<$Res> {
  _$GeneratedItemCopyWithImpl(this._self, this._then);

  final GeneratedItem _self;
  final $Res Function(GeneratedItem) _then;

/// Create a copy of GeneratedItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? quantity = null,Object? unit = null,Object? category = null,Object? notes = null,Object? priority = null,Object? estimatedPrice = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as MeasurementUnit,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as ItemPriority,estimatedPrice: freezed == estimatedPrice ? _self.estimatedPrice : estimatedPrice // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [GeneratedItem].
extension GeneratedItemPatterns on GeneratedItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GeneratedItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GeneratedItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GeneratedItem value)  $default,){
final _that = this;
switch (_that) {
case _GeneratedItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GeneratedItem value)?  $default,){
final _that = this;
switch (_that) {
case _GeneratedItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name, @FlexibleDoubleConverter()  double quantity,  MeasurementUnit unit,  String category,  String notes,  ItemPriority priority, @NullableDoubleConverter()  double? estimatedPrice)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GeneratedItem() when $default != null:
return $default(_that.name,_that.quantity,_that.unit,_that.category,_that.notes,_that.priority,_that.estimatedPrice);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name, @FlexibleDoubleConverter()  double quantity,  MeasurementUnit unit,  String category,  String notes,  ItemPriority priority, @NullableDoubleConverter()  double? estimatedPrice)  $default,) {final _that = this;
switch (_that) {
case _GeneratedItem():
return $default(_that.name,_that.quantity,_that.unit,_that.category,_that.notes,_that.priority,_that.estimatedPrice);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name, @FlexibleDoubleConverter()  double quantity,  MeasurementUnit unit,  String category,  String notes,  ItemPriority priority, @NullableDoubleConverter()  double? estimatedPrice)?  $default,) {final _that = this;
switch (_that) {
case _GeneratedItem() when $default != null:
return $default(_that.name,_that.quantity,_that.unit,_that.category,_that.notes,_that.priority,_that.estimatedPrice);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GeneratedItem implements GeneratedItem {
  const _GeneratedItem({required this.name, @FlexibleDoubleConverter() this.quantity = 1, this.unit = MeasurementUnit.piece, this.category = '', this.notes = '', this.priority = ItemPriority.normal, @NullableDoubleConverter() this.estimatedPrice});
  factory _GeneratedItem.fromJson(Map<String, dynamic> json) => _$GeneratedItemFromJson(json);

@override final  String name;
@override@JsonKey()@FlexibleDoubleConverter() final  double quantity;
@override@JsonKey() final  MeasurementUnit unit;
/// Category name as proposed by the model; resolved against the category
/// collection before the item is written.
@override@JsonKey() final  String category;
@override@JsonKey() final  String notes;
@override@JsonKey() final  ItemPriority priority;
@override@NullableDoubleConverter() final  double? estimatedPrice;

/// Create a copy of GeneratedItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeneratedItemCopyWith<_GeneratedItem> get copyWith => __$GeneratedItemCopyWithImpl<_GeneratedItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GeneratedItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeneratedItem&&(identical(other.name, name) || other.name == name)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.category, category) || other.category == category)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.estimatedPrice, estimatedPrice) || other.estimatedPrice == estimatedPrice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,quantity,unit,category,notes,priority,estimatedPrice);

@override
String toString() {
  return 'GeneratedItem(name: $name, quantity: $quantity, unit: $unit, category: $category, notes: $notes, priority: $priority, estimatedPrice: $estimatedPrice)';
}


}

/// @nodoc
abstract mixin class _$GeneratedItemCopyWith<$Res> implements $GeneratedItemCopyWith<$Res> {
  factory _$GeneratedItemCopyWith(_GeneratedItem value, $Res Function(_GeneratedItem) _then) = __$GeneratedItemCopyWithImpl;
@override @useResult
$Res call({
 String name,@FlexibleDoubleConverter() double quantity, MeasurementUnit unit, String category, String notes, ItemPriority priority,@NullableDoubleConverter() double? estimatedPrice
});




}
/// @nodoc
class __$GeneratedItemCopyWithImpl<$Res>
    implements _$GeneratedItemCopyWith<$Res> {
  __$GeneratedItemCopyWithImpl(this._self, this._then);

  final _GeneratedItem _self;
  final $Res Function(_GeneratedItem) _then;

/// Create a copy of GeneratedItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? quantity = null,Object? unit = null,Object? category = null,Object? notes = null,Object? priority = null,Object? estimatedPrice = freezed,}) {
  return _then(_GeneratedItem(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as MeasurementUnit,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as ItemPriority,estimatedPrice: freezed == estimatedPrice ? _self.estimatedPrice : estimatedPrice // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$GeneratedList {

 String get title; AiListKind get kind; String get description; String get emoji; List<GeneratedItem> get items;@NullableDoubleConverter() double? get estimatedTotal; String get currency;/// Short rationale the model gives for its choices, shown on the review
/// sheet so the suggestion is auditable rather than opaque.
 String get rationale;
/// Create a copy of GeneratedList
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeneratedListCopyWith<GeneratedList> get copyWith => _$GeneratedListCopyWithImpl<GeneratedList>(this as GeneratedList, _$identity);

  /// Serializes this GeneratedList to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeneratedList&&(identical(other.title, title) || other.title == title)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.description, description) || other.description == description)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.estimatedTotal, estimatedTotal) || other.estimatedTotal == estimatedTotal)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.rationale, rationale) || other.rationale == rationale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,kind,description,emoji,const DeepCollectionEquality().hash(items),estimatedTotal,currency,rationale);

@override
String toString() {
  return 'GeneratedList(title: $title, kind: $kind, description: $description, emoji: $emoji, items: $items, estimatedTotal: $estimatedTotal, currency: $currency, rationale: $rationale)';
}


}

/// @nodoc
abstract mixin class $GeneratedListCopyWith<$Res>  {
  factory $GeneratedListCopyWith(GeneratedList value, $Res Function(GeneratedList) _then) = _$GeneratedListCopyWithImpl;
@useResult
$Res call({
 String title, AiListKind kind, String description, String emoji, List<GeneratedItem> items,@NullableDoubleConverter() double? estimatedTotal, String currency, String rationale
});




}
/// @nodoc
class _$GeneratedListCopyWithImpl<$Res>
    implements $GeneratedListCopyWith<$Res> {
  _$GeneratedListCopyWithImpl(this._self, this._then);

  final GeneratedList _self;
  final $Res Function(GeneratedList) _then;

/// Create a copy of GeneratedList
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? kind = null,Object? description = null,Object? emoji = null,Object? items = null,Object? estimatedTotal = freezed,Object? currency = null,Object? rationale = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as AiListKind,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<GeneratedItem>,estimatedTotal: freezed == estimatedTotal ? _self.estimatedTotal : estimatedTotal // ignore: cast_nullable_to_non_nullable
as double?,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,rationale: null == rationale ? _self.rationale : rationale // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GeneratedList].
extension GeneratedListPatterns on GeneratedList {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GeneratedList value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GeneratedList() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GeneratedList value)  $default,){
final _that = this;
switch (_that) {
case _GeneratedList():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GeneratedList value)?  $default,){
final _that = this;
switch (_that) {
case _GeneratedList() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  AiListKind kind,  String description,  String emoji,  List<GeneratedItem> items, @NullableDoubleConverter()  double? estimatedTotal,  String currency,  String rationale)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GeneratedList() when $default != null:
return $default(_that.title,_that.kind,_that.description,_that.emoji,_that.items,_that.estimatedTotal,_that.currency,_that.rationale);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  AiListKind kind,  String description,  String emoji,  List<GeneratedItem> items, @NullableDoubleConverter()  double? estimatedTotal,  String currency,  String rationale)  $default,) {final _that = this;
switch (_that) {
case _GeneratedList():
return $default(_that.title,_that.kind,_that.description,_that.emoji,_that.items,_that.estimatedTotal,_that.currency,_that.rationale);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  AiListKind kind,  String description,  String emoji,  List<GeneratedItem> items, @NullableDoubleConverter()  double? estimatedTotal,  String currency,  String rationale)?  $default,) {final _that = this;
switch (_that) {
case _GeneratedList() when $default != null:
return $default(_that.title,_that.kind,_that.description,_that.emoji,_that.items,_that.estimatedTotal,_that.currency,_that.rationale);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GeneratedList implements GeneratedList {
  const _GeneratedList({required this.title, required this.kind, this.description = '', this.emoji = '🛒', final  List<GeneratedItem> items = const <GeneratedItem>[], @NullableDoubleConverter() this.estimatedTotal, this.currency = 'USD', this.rationale = ''}): _items = items;
  factory _GeneratedList.fromJson(Map<String, dynamic> json) => _$GeneratedListFromJson(json);

@override final  String title;
@override final  AiListKind kind;
@override@JsonKey() final  String description;
@override@JsonKey() final  String emoji;
 final  List<GeneratedItem> _items;
@override@JsonKey() List<GeneratedItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@NullableDoubleConverter() final  double? estimatedTotal;
@override@JsonKey() final  String currency;
/// Short rationale the model gives for its choices, shown on the review
/// sheet so the suggestion is auditable rather than opaque.
@override@JsonKey() final  String rationale;

/// Create a copy of GeneratedList
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeneratedListCopyWith<_GeneratedList> get copyWith => __$GeneratedListCopyWithImpl<_GeneratedList>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GeneratedListToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeneratedList&&(identical(other.title, title) || other.title == title)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.description, description) || other.description == description)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.estimatedTotal, estimatedTotal) || other.estimatedTotal == estimatedTotal)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.rationale, rationale) || other.rationale == rationale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,kind,description,emoji,const DeepCollectionEquality().hash(_items),estimatedTotal,currency,rationale);

@override
String toString() {
  return 'GeneratedList(title: $title, kind: $kind, description: $description, emoji: $emoji, items: $items, estimatedTotal: $estimatedTotal, currency: $currency, rationale: $rationale)';
}


}

/// @nodoc
abstract mixin class _$GeneratedListCopyWith<$Res> implements $GeneratedListCopyWith<$Res> {
  factory _$GeneratedListCopyWith(_GeneratedList value, $Res Function(_GeneratedList) _then) = __$GeneratedListCopyWithImpl;
@override @useResult
$Res call({
 String title, AiListKind kind, String description, String emoji, List<GeneratedItem> items,@NullableDoubleConverter() double? estimatedTotal, String currency, String rationale
});




}
/// @nodoc
class __$GeneratedListCopyWithImpl<$Res>
    implements _$GeneratedListCopyWith<$Res> {
  __$GeneratedListCopyWithImpl(this._self, this._then);

  final _GeneratedList _self;
  final $Res Function(_GeneratedList) _then;

/// Create a copy of GeneratedList
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? kind = null,Object? description = null,Object? emoji = null,Object? items = null,Object? estimatedTotal = freezed,Object? currency = null,Object? rationale = null,}) {
  return _then(_GeneratedList(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as AiListKind,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<GeneratedItem>,estimatedTotal: freezed == estimatedTotal ? _self.estimatedTotal : estimatedTotal // ignore: cast_nullable_to_non_nullable
as double?,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,rationale: null == rationale ? _self.rationale : rationale // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$GenerationBrief {

 AiListKind get kind;/// Free-text request, used verbatim for [AiListKind.custom].
 String get prompt; int get peopleCount; int get days; String get currency;@NullableDoubleConverter() double? get budget;/// Dietary restrictions and allergies to respect.
 List<String> get restrictions;/// Cuisines, brands or products the user prefers.
 List<String> get preferences;/// Products already at home, which must not be suggested again.
 List<String> get pantryItems; String get localeCode; MeasurementSystem get measurementSystem;/// Age in months, for [AiListKind.baby].
 int? get babyAgeMonths;
/// Create a copy of GenerationBrief
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GenerationBriefCopyWith<GenerationBrief> get copyWith => _$GenerationBriefCopyWithImpl<GenerationBrief>(this as GenerationBrief, _$identity);

  /// Serializes this GenerationBrief to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GenerationBrief&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&(identical(other.peopleCount, peopleCount) || other.peopleCount == peopleCount)&&(identical(other.days, days) || other.days == days)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.budget, budget) || other.budget == budget)&&const DeepCollectionEquality().equals(other.restrictions, restrictions)&&const DeepCollectionEquality().equals(other.preferences, preferences)&&const DeepCollectionEquality().equals(other.pantryItems, pantryItems)&&(identical(other.localeCode, localeCode) || other.localeCode == localeCode)&&(identical(other.measurementSystem, measurementSystem) || other.measurementSystem == measurementSystem)&&(identical(other.babyAgeMonths, babyAgeMonths) || other.babyAgeMonths == babyAgeMonths));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,prompt,peopleCount,days,currency,budget,const DeepCollectionEquality().hash(restrictions),const DeepCollectionEquality().hash(preferences),const DeepCollectionEquality().hash(pantryItems),localeCode,measurementSystem,babyAgeMonths);

@override
String toString() {
  return 'GenerationBrief(kind: $kind, prompt: $prompt, peopleCount: $peopleCount, days: $days, currency: $currency, budget: $budget, restrictions: $restrictions, preferences: $preferences, pantryItems: $pantryItems, localeCode: $localeCode, measurementSystem: $measurementSystem, babyAgeMonths: $babyAgeMonths)';
}


}

/// @nodoc
abstract mixin class $GenerationBriefCopyWith<$Res>  {
  factory $GenerationBriefCopyWith(GenerationBrief value, $Res Function(GenerationBrief) _then) = _$GenerationBriefCopyWithImpl;
@useResult
$Res call({
 AiListKind kind, String prompt, int peopleCount, int days, String currency,@NullableDoubleConverter() double? budget, List<String> restrictions, List<String> preferences, List<String> pantryItems, String localeCode, MeasurementSystem measurementSystem, int? babyAgeMonths
});




}
/// @nodoc
class _$GenerationBriefCopyWithImpl<$Res>
    implements $GenerationBriefCopyWith<$Res> {
  _$GenerationBriefCopyWithImpl(this._self, this._then);

  final GenerationBrief _self;
  final $Res Function(GenerationBrief) _then;

/// Create a copy of GenerationBrief
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? prompt = null,Object? peopleCount = null,Object? days = null,Object? currency = null,Object? budget = freezed,Object? restrictions = null,Object? preferences = null,Object? pantryItems = null,Object? localeCode = null,Object? measurementSystem = null,Object? babyAgeMonths = freezed,}) {
  return _then(_self.copyWith(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as AiListKind,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,peopleCount: null == peopleCount ? _self.peopleCount : peopleCount // ignore: cast_nullable_to_non_nullable
as int,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,budget: freezed == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as double?,restrictions: null == restrictions ? _self.restrictions : restrictions // ignore: cast_nullable_to_non_nullable
as List<String>,preferences: null == preferences ? _self.preferences : preferences // ignore: cast_nullable_to_non_nullable
as List<String>,pantryItems: null == pantryItems ? _self.pantryItems : pantryItems // ignore: cast_nullable_to_non_nullable
as List<String>,localeCode: null == localeCode ? _self.localeCode : localeCode // ignore: cast_nullable_to_non_nullable
as String,measurementSystem: null == measurementSystem ? _self.measurementSystem : measurementSystem // ignore: cast_nullable_to_non_nullable
as MeasurementSystem,babyAgeMonths: freezed == babyAgeMonths ? _self.babyAgeMonths : babyAgeMonths // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [GenerationBrief].
extension GenerationBriefPatterns on GenerationBrief {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GenerationBrief value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GenerationBrief() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GenerationBrief value)  $default,){
final _that = this;
switch (_that) {
case _GenerationBrief():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GenerationBrief value)?  $default,){
final _that = this;
switch (_that) {
case _GenerationBrief() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AiListKind kind,  String prompt,  int peopleCount,  int days,  String currency, @NullableDoubleConverter()  double? budget,  List<String> restrictions,  List<String> preferences,  List<String> pantryItems,  String localeCode,  MeasurementSystem measurementSystem,  int? babyAgeMonths)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GenerationBrief() when $default != null:
return $default(_that.kind,_that.prompt,_that.peopleCount,_that.days,_that.currency,_that.budget,_that.restrictions,_that.preferences,_that.pantryItems,_that.localeCode,_that.measurementSystem,_that.babyAgeMonths);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AiListKind kind,  String prompt,  int peopleCount,  int days,  String currency, @NullableDoubleConverter()  double? budget,  List<String> restrictions,  List<String> preferences,  List<String> pantryItems,  String localeCode,  MeasurementSystem measurementSystem,  int? babyAgeMonths)  $default,) {final _that = this;
switch (_that) {
case _GenerationBrief():
return $default(_that.kind,_that.prompt,_that.peopleCount,_that.days,_that.currency,_that.budget,_that.restrictions,_that.preferences,_that.pantryItems,_that.localeCode,_that.measurementSystem,_that.babyAgeMonths);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AiListKind kind,  String prompt,  int peopleCount,  int days,  String currency, @NullableDoubleConverter()  double? budget,  List<String> restrictions,  List<String> preferences,  List<String> pantryItems,  String localeCode,  MeasurementSystem measurementSystem,  int? babyAgeMonths)?  $default,) {final _that = this;
switch (_that) {
case _GenerationBrief() when $default != null:
return $default(_that.kind,_that.prompt,_that.peopleCount,_that.days,_that.currency,_that.budget,_that.restrictions,_that.preferences,_that.pantryItems,_that.localeCode,_that.measurementSystem,_that.babyAgeMonths);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GenerationBrief implements GenerationBrief {
  const _GenerationBrief({required this.kind, this.prompt = '', this.peopleCount = 1, this.days = 7, this.currency = 'USD', @NullableDoubleConverter() this.budget, final  List<String> restrictions = const <String>[], final  List<String> preferences = const <String>[], final  List<String> pantryItems = const <String>[], this.localeCode = 'en', this.measurementSystem = MeasurementSystem.metric, this.babyAgeMonths}): _restrictions = restrictions,_preferences = preferences,_pantryItems = pantryItems;
  factory _GenerationBrief.fromJson(Map<String, dynamic> json) => _$GenerationBriefFromJson(json);

@override final  AiListKind kind;
/// Free-text request, used verbatim for [AiListKind.custom].
@override@JsonKey() final  String prompt;
@override@JsonKey() final  int peopleCount;
@override@JsonKey() final  int days;
@override@JsonKey() final  String currency;
@override@NullableDoubleConverter() final  double? budget;
/// Dietary restrictions and allergies to respect.
 final  List<String> _restrictions;
/// Dietary restrictions and allergies to respect.
@override@JsonKey() List<String> get restrictions {
  if (_restrictions is EqualUnmodifiableListView) return _restrictions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_restrictions);
}

/// Cuisines, brands or products the user prefers.
 final  List<String> _preferences;
/// Cuisines, brands or products the user prefers.
@override@JsonKey() List<String> get preferences {
  if (_preferences is EqualUnmodifiableListView) return _preferences;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_preferences);
}

/// Products already at home, which must not be suggested again.
 final  List<String> _pantryItems;
/// Products already at home, which must not be suggested again.
@override@JsonKey() List<String> get pantryItems {
  if (_pantryItems is EqualUnmodifiableListView) return _pantryItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pantryItems);
}

@override@JsonKey() final  String localeCode;
@override@JsonKey() final  MeasurementSystem measurementSystem;
/// Age in months, for [AiListKind.baby].
@override final  int? babyAgeMonths;

/// Create a copy of GenerationBrief
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GenerationBriefCopyWith<_GenerationBrief> get copyWith => __$GenerationBriefCopyWithImpl<_GenerationBrief>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GenerationBriefToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GenerationBrief&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&(identical(other.peopleCount, peopleCount) || other.peopleCount == peopleCount)&&(identical(other.days, days) || other.days == days)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.budget, budget) || other.budget == budget)&&const DeepCollectionEquality().equals(other._restrictions, _restrictions)&&const DeepCollectionEquality().equals(other._preferences, _preferences)&&const DeepCollectionEquality().equals(other._pantryItems, _pantryItems)&&(identical(other.localeCode, localeCode) || other.localeCode == localeCode)&&(identical(other.measurementSystem, measurementSystem) || other.measurementSystem == measurementSystem)&&(identical(other.babyAgeMonths, babyAgeMonths) || other.babyAgeMonths == babyAgeMonths));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,prompt,peopleCount,days,currency,budget,const DeepCollectionEquality().hash(_restrictions),const DeepCollectionEquality().hash(_preferences),const DeepCollectionEquality().hash(_pantryItems),localeCode,measurementSystem,babyAgeMonths);

@override
String toString() {
  return 'GenerationBrief(kind: $kind, prompt: $prompt, peopleCount: $peopleCount, days: $days, currency: $currency, budget: $budget, restrictions: $restrictions, preferences: $preferences, pantryItems: $pantryItems, localeCode: $localeCode, measurementSystem: $measurementSystem, babyAgeMonths: $babyAgeMonths)';
}


}

/// @nodoc
abstract mixin class _$GenerationBriefCopyWith<$Res> implements $GenerationBriefCopyWith<$Res> {
  factory _$GenerationBriefCopyWith(_GenerationBrief value, $Res Function(_GenerationBrief) _then) = __$GenerationBriefCopyWithImpl;
@override @useResult
$Res call({
 AiListKind kind, String prompt, int peopleCount, int days, String currency,@NullableDoubleConverter() double? budget, List<String> restrictions, List<String> preferences, List<String> pantryItems, String localeCode, MeasurementSystem measurementSystem, int? babyAgeMonths
});




}
/// @nodoc
class __$GenerationBriefCopyWithImpl<$Res>
    implements _$GenerationBriefCopyWith<$Res> {
  __$GenerationBriefCopyWithImpl(this._self, this._then);

  final _GenerationBrief _self;
  final $Res Function(_GenerationBrief) _then;

/// Create a copy of GenerationBrief
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? prompt = null,Object? peopleCount = null,Object? days = null,Object? currency = null,Object? budget = freezed,Object? restrictions = null,Object? preferences = null,Object? pantryItems = null,Object? localeCode = null,Object? measurementSystem = null,Object? babyAgeMonths = freezed,}) {
  return _then(_GenerationBrief(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as AiListKind,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,peopleCount: null == peopleCount ? _self.peopleCount : peopleCount // ignore: cast_nullable_to_non_nullable
as int,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,budget: freezed == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as double?,restrictions: null == restrictions ? _self._restrictions : restrictions // ignore: cast_nullable_to_non_nullable
as List<String>,preferences: null == preferences ? _self._preferences : preferences // ignore: cast_nullable_to_non_nullable
as List<String>,pantryItems: null == pantryItems ? _self._pantryItems : pantryItems // ignore: cast_nullable_to_non_nullable
as List<String>,localeCode: null == localeCode ? _self.localeCode : localeCode // ignore: cast_nullable_to_non_nullable
as String,measurementSystem: null == measurementSystem ? _self.measurementSystem : measurementSystem // ignore: cast_nullable_to_non_nullable
as MeasurementSystem,babyAgeMonths: freezed == babyAgeMonths ? _self.babyAgeMonths : babyAgeMonths // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
