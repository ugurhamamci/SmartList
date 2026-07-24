// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shopping_template.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TemplateItem {

 String get name;@FlexibleDoubleConverter() double get quantity; MeasurementUnit get unit; String? get categoryId; String get notes; ItemPriority get priority;@NullableDoubleConverter() double? get estimatedPrice;@FlexibleDoubleConverter() double get sortOrder;
/// Create a copy of TemplateItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TemplateItemCopyWith<TemplateItem> get copyWith => _$TemplateItemCopyWithImpl<TemplateItem>(this as TemplateItem, _$identity);

  /// Serializes this TemplateItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TemplateItem&&(identical(other.name, name) || other.name == name)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.estimatedPrice, estimatedPrice) || other.estimatedPrice == estimatedPrice)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,quantity,unit,categoryId,notes,priority,estimatedPrice,sortOrder);

@override
String toString() {
  return 'TemplateItem(name: $name, quantity: $quantity, unit: $unit, categoryId: $categoryId, notes: $notes, priority: $priority, estimatedPrice: $estimatedPrice, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $TemplateItemCopyWith<$Res>  {
  factory $TemplateItemCopyWith(TemplateItem value, $Res Function(TemplateItem) _then) = _$TemplateItemCopyWithImpl;
@useResult
$Res call({
 String name,@FlexibleDoubleConverter() double quantity, MeasurementUnit unit, String? categoryId, String notes, ItemPriority priority,@NullableDoubleConverter() double? estimatedPrice,@FlexibleDoubleConverter() double sortOrder
});




}
/// @nodoc
class _$TemplateItemCopyWithImpl<$Res>
    implements $TemplateItemCopyWith<$Res> {
  _$TemplateItemCopyWithImpl(this._self, this._then);

  final TemplateItem _self;
  final $Res Function(TemplateItem) _then;

/// Create a copy of TemplateItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? quantity = null,Object? unit = null,Object? categoryId = freezed,Object? notes = null,Object? priority = null,Object? estimatedPrice = freezed,Object? sortOrder = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as MeasurementUnit,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as ItemPriority,estimatedPrice: freezed == estimatedPrice ? _self.estimatedPrice : estimatedPrice // ignore: cast_nullable_to_non_nullable
as double?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [TemplateItem].
extension TemplateItemPatterns on TemplateItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TemplateItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TemplateItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TemplateItem value)  $default,){
final _that = this;
switch (_that) {
case _TemplateItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TemplateItem value)?  $default,){
final _that = this;
switch (_that) {
case _TemplateItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name, @FlexibleDoubleConverter()  double quantity,  MeasurementUnit unit,  String? categoryId,  String notes,  ItemPriority priority, @NullableDoubleConverter()  double? estimatedPrice, @FlexibleDoubleConverter()  double sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TemplateItem() when $default != null:
return $default(_that.name,_that.quantity,_that.unit,_that.categoryId,_that.notes,_that.priority,_that.estimatedPrice,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name, @FlexibleDoubleConverter()  double quantity,  MeasurementUnit unit,  String? categoryId,  String notes,  ItemPriority priority, @NullableDoubleConverter()  double? estimatedPrice, @FlexibleDoubleConverter()  double sortOrder)  $default,) {final _that = this;
switch (_that) {
case _TemplateItem():
return $default(_that.name,_that.quantity,_that.unit,_that.categoryId,_that.notes,_that.priority,_that.estimatedPrice,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name, @FlexibleDoubleConverter()  double quantity,  MeasurementUnit unit,  String? categoryId,  String notes,  ItemPriority priority, @NullableDoubleConverter()  double? estimatedPrice, @FlexibleDoubleConverter()  double sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _TemplateItem() when $default != null:
return $default(_that.name,_that.quantity,_that.unit,_that.categoryId,_that.notes,_that.priority,_that.estimatedPrice,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TemplateItem implements TemplateItem {
  const _TemplateItem({required this.name, @FlexibleDoubleConverter() this.quantity = 1, this.unit = MeasurementUnit.piece, this.categoryId, this.notes = '', this.priority = ItemPriority.normal, @NullableDoubleConverter() this.estimatedPrice, @FlexibleDoubleConverter() this.sortOrder = 0});
  factory _TemplateItem.fromJson(Map<String, dynamic> json) => _$TemplateItemFromJson(json);

@override final  String name;
@override@JsonKey()@FlexibleDoubleConverter() final  double quantity;
@override@JsonKey() final  MeasurementUnit unit;
@override final  String? categoryId;
@override@JsonKey() final  String notes;
@override@JsonKey() final  ItemPriority priority;
@override@NullableDoubleConverter() final  double? estimatedPrice;
@override@JsonKey()@FlexibleDoubleConverter() final  double sortOrder;

/// Create a copy of TemplateItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TemplateItemCopyWith<_TemplateItem> get copyWith => __$TemplateItemCopyWithImpl<_TemplateItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TemplateItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TemplateItem&&(identical(other.name, name) || other.name == name)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.estimatedPrice, estimatedPrice) || other.estimatedPrice == estimatedPrice)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,quantity,unit,categoryId,notes,priority,estimatedPrice,sortOrder);

@override
String toString() {
  return 'TemplateItem(name: $name, quantity: $quantity, unit: $unit, categoryId: $categoryId, notes: $notes, priority: $priority, estimatedPrice: $estimatedPrice, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$TemplateItemCopyWith<$Res> implements $TemplateItemCopyWith<$Res> {
  factory _$TemplateItemCopyWith(_TemplateItem value, $Res Function(_TemplateItem) _then) = __$TemplateItemCopyWithImpl;
@override @useResult
$Res call({
 String name,@FlexibleDoubleConverter() double quantity, MeasurementUnit unit, String? categoryId, String notes, ItemPriority priority,@NullableDoubleConverter() double? estimatedPrice,@FlexibleDoubleConverter() double sortOrder
});




}
/// @nodoc
class __$TemplateItemCopyWithImpl<$Res>
    implements _$TemplateItemCopyWith<$Res> {
  __$TemplateItemCopyWithImpl(this._self, this._then);

  final _TemplateItem _self;
  final $Res Function(_TemplateItem) _then;

/// Create a copy of TemplateItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? quantity = null,Object? unit = null,Object? categoryId = freezed,Object? notes = null,Object? priority = null,Object? estimatedPrice = freezed,Object? sortOrder = null,}) {
  return _then(_TemplateItem(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as MeasurementUnit,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as ItemPriority,estimatedPrice: freezed == estimatedPrice ? _self.estimatedPrice : estimatedPrice // ignore: cast_nullable_to_non_nullable
as double?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$ShoppingTemplate {

 String get id; String get name;@TimestampConverter() DateTime get createdAt;@TimestampConverter() DateTime get updatedAt; String get createdBy; String get updatedBy;/// Null for curated templates authored by the backend.
 String? get ownerId; bool get isPublic; String get description; String get emoji; String get colorHex;/// Grouping used by the template browser, e.g. `weekly`, `party`.
 String get category; List<TemplateItem> get items; int get usageCount;/// Set when the template was produced by the AI generator.
 AiListKind? get generatedFrom;@NullableTimestampConverter() DateTime? get deletedAt; int get version;
/// Create a copy of ShoppingTemplate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShoppingTemplateCopyWith<ShoppingTemplate> get copyWith => _$ShoppingTemplateCopyWithImpl<ShoppingTemplate>(this as ShoppingTemplate, _$identity);

  /// Serializes this ShoppingTemplate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShoppingTemplate&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.updatedBy, updatedBy) || other.updatedBy == updatedBy)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.description, description) || other.description == description)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.usageCount, usageCount) || other.usageCount == usageCount)&&(identical(other.generatedFrom, generatedFrom) || other.generatedFrom == generatedFrom)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,createdAt,updatedAt,createdBy,updatedBy,ownerId,isPublic,description,emoji,colorHex,category,const DeepCollectionEquality().hash(items),usageCount,generatedFrom,deletedAt,version);

@override
String toString() {
  return 'ShoppingTemplate(id: $id, name: $name, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy, ownerId: $ownerId, isPublic: $isPublic, description: $description, emoji: $emoji, colorHex: $colorHex, category: $category, items: $items, usageCount: $usageCount, generatedFrom: $generatedFrom, deletedAt: $deletedAt, version: $version)';
}


}

/// @nodoc
abstract mixin class $ShoppingTemplateCopyWith<$Res>  {
  factory $ShoppingTemplateCopyWith(ShoppingTemplate value, $Res Function(ShoppingTemplate) _then) = _$ShoppingTemplateCopyWithImpl;
@useResult
$Res call({
 String id, String name,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, String createdBy, String updatedBy, String? ownerId, bool isPublic, String description, String emoji, String colorHex, String category, List<TemplateItem> items, int usageCount, AiListKind? generatedFrom,@NullableTimestampConverter() DateTime? deletedAt, int version
});




}
/// @nodoc
class _$ShoppingTemplateCopyWithImpl<$Res>
    implements $ShoppingTemplateCopyWith<$Res> {
  _$ShoppingTemplateCopyWithImpl(this._self, this._then);

  final ShoppingTemplate _self;
  final $Res Function(ShoppingTemplate) _then;

/// Create a copy of ShoppingTemplate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? createdAt = null,Object? updatedAt = null,Object? createdBy = null,Object? updatedBy = null,Object? ownerId = freezed,Object? isPublic = null,Object? description = null,Object? emoji = null,Object? colorHex = null,Object? category = null,Object? items = null,Object? usageCount = null,Object? generatedFrom = freezed,Object? deletedAt = freezed,Object? version = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,updatedBy: null == updatedBy ? _self.updatedBy : updatedBy // ignore: cast_nullable_to_non_nullable
as String,ownerId: freezed == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String?,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<TemplateItem>,usageCount: null == usageCount ? _self.usageCount : usageCount // ignore: cast_nullable_to_non_nullable
as int,generatedFrom: freezed == generatedFrom ? _self.generatedFrom : generatedFrom // ignore: cast_nullable_to_non_nullable
as AiListKind?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ShoppingTemplate].
extension ShoppingTemplatePatterns on ShoppingTemplate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShoppingTemplate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShoppingTemplate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShoppingTemplate value)  $default,){
final _that = this;
switch (_that) {
case _ShoppingTemplate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShoppingTemplate value)?  $default,){
final _that = this;
switch (_that) {
case _ShoppingTemplate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String createdBy,  String updatedBy,  String? ownerId,  bool isPublic,  String description,  String emoji,  String colorHex,  String category,  List<TemplateItem> items,  int usageCount,  AiListKind? generatedFrom, @NullableTimestampConverter()  DateTime? deletedAt,  int version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShoppingTemplate() when $default != null:
return $default(_that.id,_that.name,_that.createdAt,_that.updatedAt,_that.createdBy,_that.updatedBy,_that.ownerId,_that.isPublic,_that.description,_that.emoji,_that.colorHex,_that.category,_that.items,_that.usageCount,_that.generatedFrom,_that.deletedAt,_that.version);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String createdBy,  String updatedBy,  String? ownerId,  bool isPublic,  String description,  String emoji,  String colorHex,  String category,  List<TemplateItem> items,  int usageCount,  AiListKind? generatedFrom, @NullableTimestampConverter()  DateTime? deletedAt,  int version)  $default,) {final _that = this;
switch (_that) {
case _ShoppingTemplate():
return $default(_that.id,_that.name,_that.createdAt,_that.updatedAt,_that.createdBy,_that.updatedBy,_that.ownerId,_that.isPublic,_that.description,_that.emoji,_that.colorHex,_that.category,_that.items,_that.usageCount,_that.generatedFrom,_that.deletedAt,_that.version);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String createdBy,  String updatedBy,  String? ownerId,  bool isPublic,  String description,  String emoji,  String colorHex,  String category,  List<TemplateItem> items,  int usageCount,  AiListKind? generatedFrom, @NullableTimestampConverter()  DateTime? deletedAt,  int version)?  $default,) {final _that = this;
switch (_that) {
case _ShoppingTemplate() when $default != null:
return $default(_that.id,_that.name,_that.createdAt,_that.updatedAt,_that.createdBy,_that.updatedBy,_that.ownerId,_that.isPublic,_that.description,_that.emoji,_that.colorHex,_that.category,_that.items,_that.usageCount,_that.generatedFrom,_that.deletedAt,_that.version);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShoppingTemplate implements ShoppingTemplate {
  const _ShoppingTemplate({required this.id, required this.name, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt, required this.createdBy, required this.updatedBy, this.ownerId, this.isPublic = false, this.description = '', this.emoji = '🛒', this.colorHex = 'FF6C63FF', this.category = '', final  List<TemplateItem> items = const <TemplateItem>[], this.usageCount = 0, this.generatedFrom, @NullableTimestampConverter() this.deletedAt, this.version = 1}): _items = items;
  factory _ShoppingTemplate.fromJson(Map<String, dynamic> json) => _$ShoppingTemplateFromJson(json);

@override final  String id;
@override final  String name;
@override@TimestampConverter() final  DateTime createdAt;
@override@TimestampConverter() final  DateTime updatedAt;
@override final  String createdBy;
@override final  String updatedBy;
/// Null for curated templates authored by the backend.
@override final  String? ownerId;
@override@JsonKey() final  bool isPublic;
@override@JsonKey() final  String description;
@override@JsonKey() final  String emoji;
@override@JsonKey() final  String colorHex;
/// Grouping used by the template browser, e.g. `weekly`, `party`.
@override@JsonKey() final  String category;
 final  List<TemplateItem> _items;
@override@JsonKey() List<TemplateItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  int usageCount;
/// Set when the template was produced by the AI generator.
@override final  AiListKind? generatedFrom;
@override@NullableTimestampConverter() final  DateTime? deletedAt;
@override@JsonKey() final  int version;

/// Create a copy of ShoppingTemplate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShoppingTemplateCopyWith<_ShoppingTemplate> get copyWith => __$ShoppingTemplateCopyWithImpl<_ShoppingTemplate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShoppingTemplateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShoppingTemplate&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.updatedBy, updatedBy) || other.updatedBy == updatedBy)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.description, description) || other.description == description)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.usageCount, usageCount) || other.usageCount == usageCount)&&(identical(other.generatedFrom, generatedFrom) || other.generatedFrom == generatedFrom)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,createdAt,updatedAt,createdBy,updatedBy,ownerId,isPublic,description,emoji,colorHex,category,const DeepCollectionEquality().hash(_items),usageCount,generatedFrom,deletedAt,version);

@override
String toString() {
  return 'ShoppingTemplate(id: $id, name: $name, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy, ownerId: $ownerId, isPublic: $isPublic, description: $description, emoji: $emoji, colorHex: $colorHex, category: $category, items: $items, usageCount: $usageCount, generatedFrom: $generatedFrom, deletedAt: $deletedAt, version: $version)';
}


}

/// @nodoc
abstract mixin class _$ShoppingTemplateCopyWith<$Res> implements $ShoppingTemplateCopyWith<$Res> {
  factory _$ShoppingTemplateCopyWith(_ShoppingTemplate value, $Res Function(_ShoppingTemplate) _then) = __$ShoppingTemplateCopyWithImpl;
@override @useResult
$Res call({
 String id, String name,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, String createdBy, String updatedBy, String? ownerId, bool isPublic, String description, String emoji, String colorHex, String category, List<TemplateItem> items, int usageCount, AiListKind? generatedFrom,@NullableTimestampConverter() DateTime? deletedAt, int version
});




}
/// @nodoc
class __$ShoppingTemplateCopyWithImpl<$Res>
    implements _$ShoppingTemplateCopyWith<$Res> {
  __$ShoppingTemplateCopyWithImpl(this._self, this._then);

  final _ShoppingTemplate _self;
  final $Res Function(_ShoppingTemplate) _then;

/// Create a copy of ShoppingTemplate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? createdAt = null,Object? updatedAt = null,Object? createdBy = null,Object? updatedBy = null,Object? ownerId = freezed,Object? isPublic = null,Object? description = null,Object? emoji = null,Object? colorHex = null,Object? category = null,Object? items = null,Object? usageCount = null,Object? generatedFrom = freezed,Object? deletedAt = freezed,Object? version = null,}) {
  return _then(_ShoppingTemplate(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,updatedBy: null == updatedBy ? _self.updatedBy : updatedBy // ignore: cast_nullable_to_non_nullable
as String,ownerId: freezed == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String?,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<TemplateItem>,usageCount: null == usageCount ? _self.usageCount : usageCount // ignore: cast_nullable_to_non_nullable
as int,generatedFrom: freezed == generatedFrom ? _self.generatedFrom : generatedFrom // ignore: cast_nullable_to_non_nullable
as AiListKind?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
