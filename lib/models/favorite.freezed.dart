// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Favorite {

 String get id; String get userId; String get targetId; FavoriteTargetType get targetType;@TimestampConverter() DateTime get createdAt;@TimestampConverter() DateTime get updatedAt;/// Denormalised label and glyph so the favourites row renders from one read.
 String get label; String get emoji;/// For an item favourite, the list it came from.
 String? get listId;
/// Create a copy of Favorite
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoriteCopyWith<Favorite> get copyWith => _$FavoriteCopyWithImpl<Favorite>(this as Favorite, _$identity);

  /// Serializes this Favorite to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Favorite&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.targetType, targetType) || other.targetType == targetType)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.label, label) || other.label == label)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.listId, listId) || other.listId == listId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,targetId,targetType,createdAt,updatedAt,label,emoji,listId);

@override
String toString() {
  return 'Favorite(id: $id, userId: $userId, targetId: $targetId, targetType: $targetType, createdAt: $createdAt, updatedAt: $updatedAt, label: $label, emoji: $emoji, listId: $listId)';
}


}

/// @nodoc
abstract mixin class $FavoriteCopyWith<$Res>  {
  factory $FavoriteCopyWith(Favorite value, $Res Function(Favorite) _then) = _$FavoriteCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String targetId, FavoriteTargetType targetType,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, String label, String emoji, String? listId
});




}
/// @nodoc
class _$FavoriteCopyWithImpl<$Res>
    implements $FavoriteCopyWith<$Res> {
  _$FavoriteCopyWithImpl(this._self, this._then);

  final Favorite _self;
  final $Res Function(Favorite) _then;

/// Create a copy of Favorite
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? targetId = null,Object? targetType = null,Object? createdAt = null,Object? updatedAt = null,Object? label = null,Object? emoji = null,Object? listId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,targetId: null == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String,targetType: null == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as FavoriteTargetType,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,listId: freezed == listId ? _self.listId : listId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Favorite].
extension FavoritePatterns on Favorite {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Favorite value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Favorite() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Favorite value)  $default,){
final _that = this;
switch (_that) {
case _Favorite():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Favorite value)?  $default,){
final _that = this;
switch (_that) {
case _Favorite() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String targetId,  FavoriteTargetType targetType, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String label,  String emoji,  String? listId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Favorite() when $default != null:
return $default(_that.id,_that.userId,_that.targetId,_that.targetType,_that.createdAt,_that.updatedAt,_that.label,_that.emoji,_that.listId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String targetId,  FavoriteTargetType targetType, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String label,  String emoji,  String? listId)  $default,) {final _that = this;
switch (_that) {
case _Favorite():
return $default(_that.id,_that.userId,_that.targetId,_that.targetType,_that.createdAt,_that.updatedAt,_that.label,_that.emoji,_that.listId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String targetId,  FavoriteTargetType targetType, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String label,  String emoji,  String? listId)?  $default,) {final _that = this;
switch (_that) {
case _Favorite() when $default != null:
return $default(_that.id,_that.userId,_that.targetId,_that.targetType,_that.createdAt,_that.updatedAt,_that.label,_that.emoji,_that.listId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Favorite implements Favorite {
  const _Favorite({required this.id, required this.userId, required this.targetId, required this.targetType, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt, this.label = '', this.emoji = '⭐', this.listId});
  factory _Favorite.fromJson(Map<String, dynamic> json) => _$FavoriteFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String targetId;
@override final  FavoriteTargetType targetType;
@override@TimestampConverter() final  DateTime createdAt;
@override@TimestampConverter() final  DateTime updatedAt;
/// Denormalised label and glyph so the favourites row renders from one read.
@override@JsonKey() final  String label;
@override@JsonKey() final  String emoji;
/// For an item favourite, the list it came from.
@override final  String? listId;

/// Create a copy of Favorite
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavoriteCopyWith<_Favorite> get copyWith => __$FavoriteCopyWithImpl<_Favorite>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FavoriteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Favorite&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.targetType, targetType) || other.targetType == targetType)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.label, label) || other.label == label)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.listId, listId) || other.listId == listId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,targetId,targetType,createdAt,updatedAt,label,emoji,listId);

@override
String toString() {
  return 'Favorite(id: $id, userId: $userId, targetId: $targetId, targetType: $targetType, createdAt: $createdAt, updatedAt: $updatedAt, label: $label, emoji: $emoji, listId: $listId)';
}


}

/// @nodoc
abstract mixin class _$FavoriteCopyWith<$Res> implements $FavoriteCopyWith<$Res> {
  factory _$FavoriteCopyWith(_Favorite value, $Res Function(_Favorite) _then) = __$FavoriteCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String targetId, FavoriteTargetType targetType,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, String label, String emoji, String? listId
});




}
/// @nodoc
class __$FavoriteCopyWithImpl<$Res>
    implements _$FavoriteCopyWith<$Res> {
  __$FavoriteCopyWithImpl(this._self, this._then);

  final _Favorite _self;
  final $Res Function(_Favorite) _then;

/// Create a copy of Favorite
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? targetId = null,Object? targetType = null,Object? createdAt = null,Object? updatedAt = null,Object? label = null,Object? emoji = null,Object? listId = freezed,}) {
  return _then(_Favorite(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,targetId: null == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String,targetType: null == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as FavoriteTargetType,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,listId: freezed == listId ? _self.listId : listId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$RecentSearch {

 String get id; String get userId; String get query;@TimestampConverter() DateTime get searchedAt;@TimestampConverter() DateTime get createdAt;@TimestampConverter() DateTime get updatedAt; int get searchCount; int get resultCount;
/// Create a copy of RecentSearch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecentSearchCopyWith<RecentSearch> get copyWith => _$RecentSearchCopyWithImpl<RecentSearch>(this as RecentSearch, _$identity);

  /// Serializes this RecentSearch to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecentSearch&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.query, query) || other.query == query)&&(identical(other.searchedAt, searchedAt) || other.searchedAt == searchedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.searchCount, searchCount) || other.searchCount == searchCount)&&(identical(other.resultCount, resultCount) || other.resultCount == resultCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,query,searchedAt,createdAt,updatedAt,searchCount,resultCount);

@override
String toString() {
  return 'RecentSearch(id: $id, userId: $userId, query: $query, searchedAt: $searchedAt, createdAt: $createdAt, updatedAt: $updatedAt, searchCount: $searchCount, resultCount: $resultCount)';
}


}

/// @nodoc
abstract mixin class $RecentSearchCopyWith<$Res>  {
  factory $RecentSearchCopyWith(RecentSearch value, $Res Function(RecentSearch) _then) = _$RecentSearchCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String query,@TimestampConverter() DateTime searchedAt,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, int searchCount, int resultCount
});




}
/// @nodoc
class _$RecentSearchCopyWithImpl<$Res>
    implements $RecentSearchCopyWith<$Res> {
  _$RecentSearchCopyWithImpl(this._self, this._then);

  final RecentSearch _self;
  final $Res Function(RecentSearch) _then;

/// Create a copy of RecentSearch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? query = null,Object? searchedAt = null,Object? createdAt = null,Object? updatedAt = null,Object? searchCount = null,Object? resultCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,searchedAt: null == searchedAt ? _self.searchedAt : searchedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,searchCount: null == searchCount ? _self.searchCount : searchCount // ignore: cast_nullable_to_non_nullable
as int,resultCount: null == resultCount ? _self.resultCount : resultCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RecentSearch].
extension RecentSearchPatterns on RecentSearch {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecentSearch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecentSearch() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecentSearch value)  $default,){
final _that = this;
switch (_that) {
case _RecentSearch():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecentSearch value)?  $default,){
final _that = this;
switch (_that) {
case _RecentSearch() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String query, @TimestampConverter()  DateTime searchedAt, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  int searchCount,  int resultCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecentSearch() when $default != null:
return $default(_that.id,_that.userId,_that.query,_that.searchedAt,_that.createdAt,_that.updatedAt,_that.searchCount,_that.resultCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String query, @TimestampConverter()  DateTime searchedAt, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  int searchCount,  int resultCount)  $default,) {final _that = this;
switch (_that) {
case _RecentSearch():
return $default(_that.id,_that.userId,_that.query,_that.searchedAt,_that.createdAt,_that.updatedAt,_that.searchCount,_that.resultCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String query, @TimestampConverter()  DateTime searchedAt, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  int searchCount,  int resultCount)?  $default,) {final _that = this;
switch (_that) {
case _RecentSearch() when $default != null:
return $default(_that.id,_that.userId,_that.query,_that.searchedAt,_that.createdAt,_that.updatedAt,_that.searchCount,_that.resultCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecentSearch implements RecentSearch {
  const _RecentSearch({required this.id, required this.userId, required this.query, @TimestampConverter() required this.searchedAt, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt, this.searchCount = 1, this.resultCount = 0});
  factory _RecentSearch.fromJson(Map<String, dynamic> json) => _$RecentSearchFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String query;
@override@TimestampConverter() final  DateTime searchedAt;
@override@TimestampConverter() final  DateTime createdAt;
@override@TimestampConverter() final  DateTime updatedAt;
@override@JsonKey() final  int searchCount;
@override@JsonKey() final  int resultCount;

/// Create a copy of RecentSearch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecentSearchCopyWith<_RecentSearch> get copyWith => __$RecentSearchCopyWithImpl<_RecentSearch>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecentSearchToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecentSearch&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.query, query) || other.query == query)&&(identical(other.searchedAt, searchedAt) || other.searchedAt == searchedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.searchCount, searchCount) || other.searchCount == searchCount)&&(identical(other.resultCount, resultCount) || other.resultCount == resultCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,query,searchedAt,createdAt,updatedAt,searchCount,resultCount);

@override
String toString() {
  return 'RecentSearch(id: $id, userId: $userId, query: $query, searchedAt: $searchedAt, createdAt: $createdAt, updatedAt: $updatedAt, searchCount: $searchCount, resultCount: $resultCount)';
}


}

/// @nodoc
abstract mixin class _$RecentSearchCopyWith<$Res> implements $RecentSearchCopyWith<$Res> {
  factory _$RecentSearchCopyWith(_RecentSearch value, $Res Function(_RecentSearch) _then) = __$RecentSearchCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String query,@TimestampConverter() DateTime searchedAt,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, int searchCount, int resultCount
});




}
/// @nodoc
class __$RecentSearchCopyWithImpl<$Res>
    implements _$RecentSearchCopyWith<$Res> {
  __$RecentSearchCopyWithImpl(this._self, this._then);

  final _RecentSearch _self;
  final $Res Function(_RecentSearch) _then;

/// Create a copy of RecentSearch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? query = null,Object? searchedAt = null,Object? createdAt = null,Object? updatedAt = null,Object? searchCount = null,Object? resultCount = null,}) {
  return _then(_RecentSearch(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,searchedAt: null == searchedAt ? _self.searchedAt : searchedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,searchCount: null == searchCount ? _self.searchCount : searchCount // ignore: cast_nullable_to_non_nullable
as int,resultCount: null == resultCount ? _self.resultCount : resultCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
