// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'barcode_scan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BarcodeScan {

 String get id; String get userId; String get code; BarcodeSymbology get format;@TimestampConverter() DateTime get scannedAt;@TimestampConverter() DateTime get createdAt;@TimestampConverter() DateTime get updatedAt;/// Product name resolved from history, a catalogue lookup, or typed by the
/// user when the code was previously unknown.
 String get productName; String get brand; String? get categoryId; String? get imageUrl;@NullableDoubleConverter() double? get lastPrice; String get currency;/// Number of times this code has been scanned by the user.
 int get scanCount;/// List the scan was added to, when it produced an item.
 String? get listId; String? get itemId;
/// Create a copy of BarcodeScan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BarcodeScanCopyWith<BarcodeScan> get copyWith => _$BarcodeScanCopyWithImpl<BarcodeScan>(this as BarcodeScan, _$identity);

  /// Serializes this BarcodeScan to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BarcodeScan&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.code, code) || other.code == code)&&(identical(other.format, format) || other.format == format)&&(identical(other.scannedAt, scannedAt) || other.scannedAt == scannedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.lastPrice, lastPrice) || other.lastPrice == lastPrice)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.scanCount, scanCount) || other.scanCount == scanCount)&&(identical(other.listId, listId) || other.listId == listId)&&(identical(other.itemId, itemId) || other.itemId == itemId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,code,format,scannedAt,createdAt,updatedAt,productName,brand,categoryId,imageUrl,lastPrice,currency,scanCount,listId,itemId);

@override
String toString() {
  return 'BarcodeScan(id: $id, userId: $userId, code: $code, format: $format, scannedAt: $scannedAt, createdAt: $createdAt, updatedAt: $updatedAt, productName: $productName, brand: $brand, categoryId: $categoryId, imageUrl: $imageUrl, lastPrice: $lastPrice, currency: $currency, scanCount: $scanCount, listId: $listId, itemId: $itemId)';
}


}

/// @nodoc
abstract mixin class $BarcodeScanCopyWith<$Res>  {
  factory $BarcodeScanCopyWith(BarcodeScan value, $Res Function(BarcodeScan) _then) = _$BarcodeScanCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String code, BarcodeSymbology format,@TimestampConverter() DateTime scannedAt,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, String productName, String brand, String? categoryId, String? imageUrl,@NullableDoubleConverter() double? lastPrice, String currency, int scanCount, String? listId, String? itemId
});




}
/// @nodoc
class _$BarcodeScanCopyWithImpl<$Res>
    implements $BarcodeScanCopyWith<$Res> {
  _$BarcodeScanCopyWithImpl(this._self, this._then);

  final BarcodeScan _self;
  final $Res Function(BarcodeScan) _then;

/// Create a copy of BarcodeScan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? code = null,Object? format = null,Object? scannedAt = null,Object? createdAt = null,Object? updatedAt = null,Object? productName = null,Object? brand = null,Object? categoryId = freezed,Object? imageUrl = freezed,Object? lastPrice = freezed,Object? currency = null,Object? scanCount = null,Object? listId = freezed,Object? itemId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as BarcodeSymbology,scannedAt: null == scannedAt ? _self.scannedAt : scannedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,brand: null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,lastPrice: freezed == lastPrice ? _self.lastPrice : lastPrice // ignore: cast_nullable_to_non_nullable
as double?,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,scanCount: null == scanCount ? _self.scanCount : scanCount // ignore: cast_nullable_to_non_nullable
as int,listId: freezed == listId ? _self.listId : listId // ignore: cast_nullable_to_non_nullable
as String?,itemId: freezed == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BarcodeScan].
extension BarcodeScanPatterns on BarcodeScan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BarcodeScan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BarcodeScan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BarcodeScan value)  $default,){
final _that = this;
switch (_that) {
case _BarcodeScan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BarcodeScan value)?  $default,){
final _that = this;
switch (_that) {
case _BarcodeScan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String code,  BarcodeSymbology format, @TimestampConverter()  DateTime scannedAt, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String productName,  String brand,  String? categoryId,  String? imageUrl, @NullableDoubleConverter()  double? lastPrice,  String currency,  int scanCount,  String? listId,  String? itemId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BarcodeScan() when $default != null:
return $default(_that.id,_that.userId,_that.code,_that.format,_that.scannedAt,_that.createdAt,_that.updatedAt,_that.productName,_that.brand,_that.categoryId,_that.imageUrl,_that.lastPrice,_that.currency,_that.scanCount,_that.listId,_that.itemId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String code,  BarcodeSymbology format, @TimestampConverter()  DateTime scannedAt, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String productName,  String brand,  String? categoryId,  String? imageUrl, @NullableDoubleConverter()  double? lastPrice,  String currency,  int scanCount,  String? listId,  String? itemId)  $default,) {final _that = this;
switch (_that) {
case _BarcodeScan():
return $default(_that.id,_that.userId,_that.code,_that.format,_that.scannedAt,_that.createdAt,_that.updatedAt,_that.productName,_that.brand,_that.categoryId,_that.imageUrl,_that.lastPrice,_that.currency,_that.scanCount,_that.listId,_that.itemId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String code,  BarcodeSymbology format, @TimestampConverter()  DateTime scannedAt, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String productName,  String brand,  String? categoryId,  String? imageUrl, @NullableDoubleConverter()  double? lastPrice,  String currency,  int scanCount,  String? listId,  String? itemId)?  $default,) {final _that = this;
switch (_that) {
case _BarcodeScan() when $default != null:
return $default(_that.id,_that.userId,_that.code,_that.format,_that.scannedAt,_that.createdAt,_that.updatedAt,_that.productName,_that.brand,_that.categoryId,_that.imageUrl,_that.lastPrice,_that.currency,_that.scanCount,_that.listId,_that.itemId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BarcodeScan implements BarcodeScan {
  const _BarcodeScan({required this.id, required this.userId, required this.code, required this.format, @TimestampConverter() required this.scannedAt, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt, this.productName = '', this.brand = '', this.categoryId, this.imageUrl, @NullableDoubleConverter() this.lastPrice, this.currency = 'USD', this.scanCount = 1, this.listId, this.itemId});
  factory _BarcodeScan.fromJson(Map<String, dynamic> json) => _$BarcodeScanFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String code;
@override final  BarcodeSymbology format;
@override@TimestampConverter() final  DateTime scannedAt;
@override@TimestampConverter() final  DateTime createdAt;
@override@TimestampConverter() final  DateTime updatedAt;
/// Product name resolved from history, a catalogue lookup, or typed by the
/// user when the code was previously unknown.
@override@JsonKey() final  String productName;
@override@JsonKey() final  String brand;
@override final  String? categoryId;
@override final  String? imageUrl;
@override@NullableDoubleConverter() final  double? lastPrice;
@override@JsonKey() final  String currency;
/// Number of times this code has been scanned by the user.
@override@JsonKey() final  int scanCount;
/// List the scan was added to, when it produced an item.
@override final  String? listId;
@override final  String? itemId;

/// Create a copy of BarcodeScan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BarcodeScanCopyWith<_BarcodeScan> get copyWith => __$BarcodeScanCopyWithImpl<_BarcodeScan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BarcodeScanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BarcodeScan&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.code, code) || other.code == code)&&(identical(other.format, format) || other.format == format)&&(identical(other.scannedAt, scannedAt) || other.scannedAt == scannedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.lastPrice, lastPrice) || other.lastPrice == lastPrice)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.scanCount, scanCount) || other.scanCount == scanCount)&&(identical(other.listId, listId) || other.listId == listId)&&(identical(other.itemId, itemId) || other.itemId == itemId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,code,format,scannedAt,createdAt,updatedAt,productName,brand,categoryId,imageUrl,lastPrice,currency,scanCount,listId,itemId);

@override
String toString() {
  return 'BarcodeScan(id: $id, userId: $userId, code: $code, format: $format, scannedAt: $scannedAt, createdAt: $createdAt, updatedAt: $updatedAt, productName: $productName, brand: $brand, categoryId: $categoryId, imageUrl: $imageUrl, lastPrice: $lastPrice, currency: $currency, scanCount: $scanCount, listId: $listId, itemId: $itemId)';
}


}

/// @nodoc
abstract mixin class _$BarcodeScanCopyWith<$Res> implements $BarcodeScanCopyWith<$Res> {
  factory _$BarcodeScanCopyWith(_BarcodeScan value, $Res Function(_BarcodeScan) _then) = __$BarcodeScanCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String code, BarcodeSymbology format,@TimestampConverter() DateTime scannedAt,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, String productName, String brand, String? categoryId, String? imageUrl,@NullableDoubleConverter() double? lastPrice, String currency, int scanCount, String? listId, String? itemId
});




}
/// @nodoc
class __$BarcodeScanCopyWithImpl<$Res>
    implements _$BarcodeScanCopyWith<$Res> {
  __$BarcodeScanCopyWithImpl(this._self, this._then);

  final _BarcodeScan _self;
  final $Res Function(_BarcodeScan) _then;

/// Create a copy of BarcodeScan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? code = null,Object? format = null,Object? scannedAt = null,Object? createdAt = null,Object? updatedAt = null,Object? productName = null,Object? brand = null,Object? categoryId = freezed,Object? imageUrl = freezed,Object? lastPrice = freezed,Object? currency = null,Object? scanCount = null,Object? listId = freezed,Object? itemId = freezed,}) {
  return _then(_BarcodeScan(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as BarcodeSymbology,scannedAt: null == scannedAt ? _self.scannedAt : scannedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,brand: null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,lastPrice: freezed == lastPrice ? _self.lastPrice : lastPrice // ignore: cast_nullable_to_non_nullable
as double?,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,scanCount: null == scanCount ? _self.scanCount : scanCount // ignore: cast_nullable_to_non_nullable
as int,listId: freezed == listId ? _self.listId : listId // ignore: cast_nullable_to_non_nullable
as String?,itemId: freezed == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
