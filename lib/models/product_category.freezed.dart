// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductCategory {

 String get id; String get name;@TimestampConverter() DateTime get createdAt;@TimestampConverter() DateTime get updatedAt; String get createdBy; String get updatedBy;/// Null for curated global categories.
 String? get ownerId; bool get isGlobal; String get emoji; String get colorHex;/// Stable key for looking up the localized display name; empty for
/// user-defined categories, whose [name] is already in the user's language.
 String get localizationKey; int get sortOrder;@NullableTimestampConverter() DateTime? get deletedAt; int get version;
/// Create a copy of ProductCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductCategoryCopyWith<ProductCategory> get copyWith => _$ProductCategoryCopyWithImpl<ProductCategory>(this as ProductCategory, _$identity);

  /// Serializes this ProductCategory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.updatedBy, updatedBy) || other.updatedBy == updatedBy)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.isGlobal, isGlobal) || other.isGlobal == isGlobal)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.localizationKey, localizationKey) || other.localizationKey == localizationKey)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,createdAt,updatedAt,createdBy,updatedBy,ownerId,isGlobal,emoji,colorHex,localizationKey,sortOrder,deletedAt,version);

@override
String toString() {
  return 'ProductCategory(id: $id, name: $name, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy, ownerId: $ownerId, isGlobal: $isGlobal, emoji: $emoji, colorHex: $colorHex, localizationKey: $localizationKey, sortOrder: $sortOrder, deletedAt: $deletedAt, version: $version)';
}


}

/// @nodoc
abstract mixin class $ProductCategoryCopyWith<$Res>  {
  factory $ProductCategoryCopyWith(ProductCategory value, $Res Function(ProductCategory) _then) = _$ProductCategoryCopyWithImpl;
@useResult
$Res call({
 String id, String name,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, String createdBy, String updatedBy, String? ownerId, bool isGlobal, String emoji, String colorHex, String localizationKey, int sortOrder,@NullableTimestampConverter() DateTime? deletedAt, int version
});




}
/// @nodoc
class _$ProductCategoryCopyWithImpl<$Res>
    implements $ProductCategoryCopyWith<$Res> {
  _$ProductCategoryCopyWithImpl(this._self, this._then);

  final ProductCategory _self;
  final $Res Function(ProductCategory) _then;

/// Create a copy of ProductCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? createdAt = null,Object? updatedAt = null,Object? createdBy = null,Object? updatedBy = null,Object? ownerId = freezed,Object? isGlobal = null,Object? emoji = null,Object? colorHex = null,Object? localizationKey = null,Object? sortOrder = null,Object? deletedAt = freezed,Object? version = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,updatedBy: null == updatedBy ? _self.updatedBy : updatedBy // ignore: cast_nullable_to_non_nullable
as String,ownerId: freezed == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String?,isGlobal: null == isGlobal ? _self.isGlobal : isGlobal // ignore: cast_nullable_to_non_nullable
as bool,emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,localizationKey: null == localizationKey ? _self.localizationKey : localizationKey // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductCategory].
extension ProductCategoryPatterns on ProductCategory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductCategory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductCategory value)  $default,){
final _that = this;
switch (_that) {
case _ProductCategory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductCategory value)?  $default,){
final _that = this;
switch (_that) {
case _ProductCategory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String createdBy,  String updatedBy,  String? ownerId,  bool isGlobal,  String emoji,  String colorHex,  String localizationKey,  int sortOrder, @NullableTimestampConverter()  DateTime? deletedAt,  int version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductCategory() when $default != null:
return $default(_that.id,_that.name,_that.createdAt,_that.updatedAt,_that.createdBy,_that.updatedBy,_that.ownerId,_that.isGlobal,_that.emoji,_that.colorHex,_that.localizationKey,_that.sortOrder,_that.deletedAt,_that.version);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String createdBy,  String updatedBy,  String? ownerId,  bool isGlobal,  String emoji,  String colorHex,  String localizationKey,  int sortOrder, @NullableTimestampConverter()  DateTime? deletedAt,  int version)  $default,) {final _that = this;
switch (_that) {
case _ProductCategory():
return $default(_that.id,_that.name,_that.createdAt,_that.updatedAt,_that.createdBy,_that.updatedBy,_that.ownerId,_that.isGlobal,_that.emoji,_that.colorHex,_that.localizationKey,_that.sortOrder,_that.deletedAt,_that.version);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String createdBy,  String updatedBy,  String? ownerId,  bool isGlobal,  String emoji,  String colorHex,  String localizationKey,  int sortOrder, @NullableTimestampConverter()  DateTime? deletedAt,  int version)?  $default,) {final _that = this;
switch (_that) {
case _ProductCategory() when $default != null:
return $default(_that.id,_that.name,_that.createdAt,_that.updatedAt,_that.createdBy,_that.updatedBy,_that.ownerId,_that.isGlobal,_that.emoji,_that.colorHex,_that.localizationKey,_that.sortOrder,_that.deletedAt,_that.version);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductCategory implements ProductCategory {
  const _ProductCategory({required this.id, required this.name, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt, required this.createdBy, required this.updatedBy, this.ownerId, this.isGlobal = false, this.emoji = '📦', this.colorHex = 'FF6C63FF', this.localizationKey = '', this.sortOrder = 0, @NullableTimestampConverter() this.deletedAt, this.version = 1});
  factory _ProductCategory.fromJson(Map<String, dynamic> json) => _$ProductCategoryFromJson(json);

@override final  String id;
@override final  String name;
@override@TimestampConverter() final  DateTime createdAt;
@override@TimestampConverter() final  DateTime updatedAt;
@override final  String createdBy;
@override final  String updatedBy;
/// Null for curated global categories.
@override final  String? ownerId;
@override@JsonKey() final  bool isGlobal;
@override@JsonKey() final  String emoji;
@override@JsonKey() final  String colorHex;
/// Stable key for looking up the localized display name; empty for
/// user-defined categories, whose [name] is already in the user's language.
@override@JsonKey() final  String localizationKey;
@override@JsonKey() final  int sortOrder;
@override@NullableTimestampConverter() final  DateTime? deletedAt;
@override@JsonKey() final  int version;

/// Create a copy of ProductCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductCategoryCopyWith<_ProductCategory> get copyWith => __$ProductCategoryCopyWithImpl<_ProductCategory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductCategoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.updatedBy, updatedBy) || other.updatedBy == updatedBy)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.isGlobal, isGlobal) || other.isGlobal == isGlobal)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.localizationKey, localizationKey) || other.localizationKey == localizationKey)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,createdAt,updatedAt,createdBy,updatedBy,ownerId,isGlobal,emoji,colorHex,localizationKey,sortOrder,deletedAt,version);

@override
String toString() {
  return 'ProductCategory(id: $id, name: $name, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy, ownerId: $ownerId, isGlobal: $isGlobal, emoji: $emoji, colorHex: $colorHex, localizationKey: $localizationKey, sortOrder: $sortOrder, deletedAt: $deletedAt, version: $version)';
}


}

/// @nodoc
abstract mixin class _$ProductCategoryCopyWith<$Res> implements $ProductCategoryCopyWith<$Res> {
  factory _$ProductCategoryCopyWith(_ProductCategory value, $Res Function(_ProductCategory) _then) = __$ProductCategoryCopyWithImpl;
@override @useResult
$Res call({
 String id, String name,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, String createdBy, String updatedBy, String? ownerId, bool isGlobal, String emoji, String colorHex, String localizationKey, int sortOrder,@NullableTimestampConverter() DateTime? deletedAt, int version
});




}
/// @nodoc
class __$ProductCategoryCopyWithImpl<$Res>
    implements _$ProductCategoryCopyWith<$Res> {
  __$ProductCategoryCopyWithImpl(this._self, this._then);

  final _ProductCategory _self;
  final $Res Function(_ProductCategory) _then;

/// Create a copy of ProductCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? createdAt = null,Object? updatedAt = null,Object? createdBy = null,Object? updatedBy = null,Object? ownerId = freezed,Object? isGlobal = null,Object? emoji = null,Object? colorHex = null,Object? localizationKey = null,Object? sortOrder = null,Object? deletedAt = freezed,Object? version = null,}) {
  return _then(_ProductCategory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,updatedBy: null == updatedBy ? _self.updatedBy : updatedBy // ignore: cast_nullable_to_non_nullable
as String,ownerId: freezed == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String?,isGlobal: null == isGlobal ? _self.isGlobal : isGlobal // ignore: cast_nullable_to_non_nullable
as bool,emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,localizationKey: null == localizationKey ? _self.localizationKey : localizationKey // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
