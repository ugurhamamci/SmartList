// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shopping_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShoppingList {

 String get id; String get title; String get ownerId;@TimestampConverter() DateTime get createdAt;@TimestampConverter() DateTime get updatedAt; String get createdBy; String get updatedBy; String get description;/// Emoji shown as the list glyph.
 String get emoji;/// Colour label, stored as an `AARRGGBB` hex string.
 String get colorHex; String? get categoryId; List<String> get memberIds; Map<String, MemberRole> get memberRoles; int get memberCount; int get itemCount; int get completedItemCount; bool get isArchived; bool get isPinned; bool get isFavorite; bool get isCompleted;@NullableTimestampConverter() DateTime? get completedAt;/// Last time an item or message changed, used to order "continue shopping".
@NullableTimestampConverter() DateTime? get lastActivityAt; ItemSortOption get itemSortOption;@NullableDoubleConverter() double? get budget; String get currency; List<String> get tags;/// Total recorded spend, maintained by Cloud Functions as items are ticked.
@FlexibleDoubleConverter() double get totalSpent;/// Set when the list was produced by the AI generator.
 AiListKind? get generatedFrom;@NullableTimestampConverter() DateTime? get deletedAt; int get version;
/// Create a copy of ShoppingList
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShoppingListCopyWith<ShoppingList> get copyWith => _$ShoppingListCopyWithImpl<ShoppingList>(this as ShoppingList, _$identity);

  /// Serializes this ShoppingList to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShoppingList&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.updatedBy, updatedBy) || other.updatedBy == updatedBy)&&(identical(other.description, description) || other.description == description)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&const DeepCollectionEquality().equals(other.memberIds, memberIds)&&const DeepCollectionEquality().equals(other.memberRoles, memberRoles)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.itemCount, itemCount) || other.itemCount == itemCount)&&(identical(other.completedItemCount, completedItemCount) || other.completedItemCount == completedItemCount)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.lastActivityAt, lastActivityAt) || other.lastActivityAt == lastActivityAt)&&(identical(other.itemSortOption, itemSortOption) || other.itemSortOption == itemSortOption)&&(identical(other.budget, budget) || other.budget == budget)&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.totalSpent, totalSpent) || other.totalSpent == totalSpent)&&(identical(other.generatedFrom, generatedFrom) || other.generatedFrom == generatedFrom)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,ownerId,createdAt,updatedAt,createdBy,updatedBy,description,emoji,colorHex,categoryId,const DeepCollectionEquality().hash(memberIds),const DeepCollectionEquality().hash(memberRoles),memberCount,itemCount,completedItemCount,isArchived,isPinned,isFavorite,isCompleted,completedAt,lastActivityAt,itemSortOption,budget,currency,const DeepCollectionEquality().hash(tags),totalSpent,generatedFrom,deletedAt,version]);

@override
String toString() {
  return 'ShoppingList(id: $id, title: $title, ownerId: $ownerId, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy, description: $description, emoji: $emoji, colorHex: $colorHex, categoryId: $categoryId, memberIds: $memberIds, memberRoles: $memberRoles, memberCount: $memberCount, itemCount: $itemCount, completedItemCount: $completedItemCount, isArchived: $isArchived, isPinned: $isPinned, isFavorite: $isFavorite, isCompleted: $isCompleted, completedAt: $completedAt, lastActivityAt: $lastActivityAt, itemSortOption: $itemSortOption, budget: $budget, currency: $currency, tags: $tags, totalSpent: $totalSpent, generatedFrom: $generatedFrom, deletedAt: $deletedAt, version: $version)';
}


}

/// @nodoc
abstract mixin class $ShoppingListCopyWith<$Res>  {
  factory $ShoppingListCopyWith(ShoppingList value, $Res Function(ShoppingList) _then) = _$ShoppingListCopyWithImpl;
@useResult
$Res call({
 String id, String title, String ownerId,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, String createdBy, String updatedBy, String description, String emoji, String colorHex, String? categoryId, List<String> memberIds, Map<String, MemberRole> memberRoles, int memberCount, int itemCount, int completedItemCount, bool isArchived, bool isPinned, bool isFavorite, bool isCompleted,@NullableTimestampConverter() DateTime? completedAt,@NullableTimestampConverter() DateTime? lastActivityAt, ItemSortOption itemSortOption,@NullableDoubleConverter() double? budget, String currency, List<String> tags,@FlexibleDoubleConverter() double totalSpent, AiListKind? generatedFrom,@NullableTimestampConverter() DateTime? deletedAt, int version
});




}
/// @nodoc
class _$ShoppingListCopyWithImpl<$Res>
    implements $ShoppingListCopyWith<$Res> {
  _$ShoppingListCopyWithImpl(this._self, this._then);

  final ShoppingList _self;
  final $Res Function(ShoppingList) _then;

/// Create a copy of ShoppingList
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? ownerId = null,Object? createdAt = null,Object? updatedAt = null,Object? createdBy = null,Object? updatedBy = null,Object? description = null,Object? emoji = null,Object? colorHex = null,Object? categoryId = freezed,Object? memberIds = null,Object? memberRoles = null,Object? memberCount = null,Object? itemCount = null,Object? completedItemCount = null,Object? isArchived = null,Object? isPinned = null,Object? isFavorite = null,Object? isCompleted = null,Object? completedAt = freezed,Object? lastActivityAt = freezed,Object? itemSortOption = null,Object? budget = freezed,Object? currency = null,Object? tags = null,Object? totalSpent = null,Object? generatedFrom = freezed,Object? deletedAt = freezed,Object? version = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,updatedBy: null == updatedBy ? _self.updatedBy : updatedBy // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,memberIds: null == memberIds ? _self.memberIds : memberIds // ignore: cast_nullable_to_non_nullable
as List<String>,memberRoles: null == memberRoles ? _self.memberRoles : memberRoles // ignore: cast_nullable_to_non_nullable
as Map<String, MemberRole>,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,itemCount: null == itemCount ? _self.itemCount : itemCount // ignore: cast_nullable_to_non_nullable
as int,completedItemCount: null == completedItemCount ? _self.completedItemCount : completedItemCount // ignore: cast_nullable_to_non_nullable
as int,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,isPinned: null == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastActivityAt: freezed == lastActivityAt ? _self.lastActivityAt : lastActivityAt // ignore: cast_nullable_to_non_nullable
as DateTime?,itemSortOption: null == itemSortOption ? _self.itemSortOption : itemSortOption // ignore: cast_nullable_to_non_nullable
as ItemSortOption,budget: freezed == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as double?,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,totalSpent: null == totalSpent ? _self.totalSpent : totalSpent // ignore: cast_nullable_to_non_nullable
as double,generatedFrom: freezed == generatedFrom ? _self.generatedFrom : generatedFrom // ignore: cast_nullable_to_non_nullable
as AiListKind?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ShoppingList].
extension ShoppingListPatterns on ShoppingList {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShoppingList value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShoppingList() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShoppingList value)  $default,){
final _that = this;
switch (_that) {
case _ShoppingList():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShoppingList value)?  $default,){
final _that = this;
switch (_that) {
case _ShoppingList() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String ownerId, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String createdBy,  String updatedBy,  String description,  String emoji,  String colorHex,  String? categoryId,  List<String> memberIds,  Map<String, MemberRole> memberRoles,  int memberCount,  int itemCount,  int completedItemCount,  bool isArchived,  bool isPinned,  bool isFavorite,  bool isCompleted, @NullableTimestampConverter()  DateTime? completedAt, @NullableTimestampConverter()  DateTime? lastActivityAt,  ItemSortOption itemSortOption, @NullableDoubleConverter()  double? budget,  String currency,  List<String> tags, @FlexibleDoubleConverter()  double totalSpent,  AiListKind? generatedFrom, @NullableTimestampConverter()  DateTime? deletedAt,  int version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShoppingList() when $default != null:
return $default(_that.id,_that.title,_that.ownerId,_that.createdAt,_that.updatedAt,_that.createdBy,_that.updatedBy,_that.description,_that.emoji,_that.colorHex,_that.categoryId,_that.memberIds,_that.memberRoles,_that.memberCount,_that.itemCount,_that.completedItemCount,_that.isArchived,_that.isPinned,_that.isFavorite,_that.isCompleted,_that.completedAt,_that.lastActivityAt,_that.itemSortOption,_that.budget,_that.currency,_that.tags,_that.totalSpent,_that.generatedFrom,_that.deletedAt,_that.version);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String ownerId, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String createdBy,  String updatedBy,  String description,  String emoji,  String colorHex,  String? categoryId,  List<String> memberIds,  Map<String, MemberRole> memberRoles,  int memberCount,  int itemCount,  int completedItemCount,  bool isArchived,  bool isPinned,  bool isFavorite,  bool isCompleted, @NullableTimestampConverter()  DateTime? completedAt, @NullableTimestampConverter()  DateTime? lastActivityAt,  ItemSortOption itemSortOption, @NullableDoubleConverter()  double? budget,  String currency,  List<String> tags, @FlexibleDoubleConverter()  double totalSpent,  AiListKind? generatedFrom, @NullableTimestampConverter()  DateTime? deletedAt,  int version)  $default,) {final _that = this;
switch (_that) {
case _ShoppingList():
return $default(_that.id,_that.title,_that.ownerId,_that.createdAt,_that.updatedAt,_that.createdBy,_that.updatedBy,_that.description,_that.emoji,_that.colorHex,_that.categoryId,_that.memberIds,_that.memberRoles,_that.memberCount,_that.itemCount,_that.completedItemCount,_that.isArchived,_that.isPinned,_that.isFavorite,_that.isCompleted,_that.completedAt,_that.lastActivityAt,_that.itemSortOption,_that.budget,_that.currency,_that.tags,_that.totalSpent,_that.generatedFrom,_that.deletedAt,_that.version);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String ownerId, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String createdBy,  String updatedBy,  String description,  String emoji,  String colorHex,  String? categoryId,  List<String> memberIds,  Map<String, MemberRole> memberRoles,  int memberCount,  int itemCount,  int completedItemCount,  bool isArchived,  bool isPinned,  bool isFavorite,  bool isCompleted, @NullableTimestampConverter()  DateTime? completedAt, @NullableTimestampConverter()  DateTime? lastActivityAt,  ItemSortOption itemSortOption, @NullableDoubleConverter()  double? budget,  String currency,  List<String> tags, @FlexibleDoubleConverter()  double totalSpent,  AiListKind? generatedFrom, @NullableTimestampConverter()  DateTime? deletedAt,  int version)?  $default,) {final _that = this;
switch (_that) {
case _ShoppingList() when $default != null:
return $default(_that.id,_that.title,_that.ownerId,_that.createdAt,_that.updatedAt,_that.createdBy,_that.updatedBy,_that.description,_that.emoji,_that.colorHex,_that.categoryId,_that.memberIds,_that.memberRoles,_that.memberCount,_that.itemCount,_that.completedItemCount,_that.isArchived,_that.isPinned,_that.isFavorite,_that.isCompleted,_that.completedAt,_that.lastActivityAt,_that.itemSortOption,_that.budget,_that.currency,_that.tags,_that.totalSpent,_that.generatedFrom,_that.deletedAt,_that.version);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShoppingList implements ShoppingList {
  const _ShoppingList({required this.id, required this.title, required this.ownerId, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt, required this.createdBy, required this.updatedBy, this.description = '', this.emoji = '🛒', this.colorHex = 'FF6C63FF', this.categoryId, final  List<String> memberIds = const <String>[], final  Map<String, MemberRole> memberRoles = const <String, MemberRole>{}, this.memberCount = 1, this.itemCount = 0, this.completedItemCount = 0, this.isArchived = false, this.isPinned = false, this.isFavorite = false, this.isCompleted = false, @NullableTimestampConverter() this.completedAt, @NullableTimestampConverter() this.lastActivityAt, this.itemSortOption = ItemSortOption.manual, @NullableDoubleConverter() this.budget, this.currency = 'USD', final  List<String> tags = const <String>[], @FlexibleDoubleConverter() this.totalSpent = 0, this.generatedFrom, @NullableTimestampConverter() this.deletedAt, this.version = 1}): _memberIds = memberIds,_memberRoles = memberRoles,_tags = tags;
  factory _ShoppingList.fromJson(Map<String, dynamic> json) => _$ShoppingListFromJson(json);

@override final  String id;
@override final  String title;
@override final  String ownerId;
@override@TimestampConverter() final  DateTime createdAt;
@override@TimestampConverter() final  DateTime updatedAt;
@override final  String createdBy;
@override final  String updatedBy;
@override@JsonKey() final  String description;
/// Emoji shown as the list glyph.
@override@JsonKey() final  String emoji;
/// Colour label, stored as an `AARRGGBB` hex string.
@override@JsonKey() final  String colorHex;
@override final  String? categoryId;
 final  List<String> _memberIds;
@override@JsonKey() List<String> get memberIds {
  if (_memberIds is EqualUnmodifiableListView) return _memberIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_memberIds);
}

 final  Map<String, MemberRole> _memberRoles;
@override@JsonKey() Map<String, MemberRole> get memberRoles {
  if (_memberRoles is EqualUnmodifiableMapView) return _memberRoles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_memberRoles);
}

@override@JsonKey() final  int memberCount;
@override@JsonKey() final  int itemCount;
@override@JsonKey() final  int completedItemCount;
@override@JsonKey() final  bool isArchived;
@override@JsonKey() final  bool isPinned;
@override@JsonKey() final  bool isFavorite;
@override@JsonKey() final  bool isCompleted;
@override@NullableTimestampConverter() final  DateTime? completedAt;
/// Last time an item or message changed, used to order "continue shopping".
@override@NullableTimestampConverter() final  DateTime? lastActivityAt;
@override@JsonKey() final  ItemSortOption itemSortOption;
@override@NullableDoubleConverter() final  double? budget;
@override@JsonKey() final  String currency;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

/// Total recorded spend, maintained by Cloud Functions as items are ticked.
@override@JsonKey()@FlexibleDoubleConverter() final  double totalSpent;
/// Set when the list was produced by the AI generator.
@override final  AiListKind? generatedFrom;
@override@NullableTimestampConverter() final  DateTime? deletedAt;
@override@JsonKey() final  int version;

/// Create a copy of ShoppingList
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShoppingListCopyWith<_ShoppingList> get copyWith => __$ShoppingListCopyWithImpl<_ShoppingList>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShoppingListToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShoppingList&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.updatedBy, updatedBy) || other.updatedBy == updatedBy)&&(identical(other.description, description) || other.description == description)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&const DeepCollectionEquality().equals(other._memberIds, _memberIds)&&const DeepCollectionEquality().equals(other._memberRoles, _memberRoles)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.itemCount, itemCount) || other.itemCount == itemCount)&&(identical(other.completedItemCount, completedItemCount) || other.completedItemCount == completedItemCount)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.lastActivityAt, lastActivityAt) || other.lastActivityAt == lastActivityAt)&&(identical(other.itemSortOption, itemSortOption) || other.itemSortOption == itemSortOption)&&(identical(other.budget, budget) || other.budget == budget)&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.totalSpent, totalSpent) || other.totalSpent == totalSpent)&&(identical(other.generatedFrom, generatedFrom) || other.generatedFrom == generatedFrom)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,ownerId,createdAt,updatedAt,createdBy,updatedBy,description,emoji,colorHex,categoryId,const DeepCollectionEquality().hash(_memberIds),const DeepCollectionEquality().hash(_memberRoles),memberCount,itemCount,completedItemCount,isArchived,isPinned,isFavorite,isCompleted,completedAt,lastActivityAt,itemSortOption,budget,currency,const DeepCollectionEquality().hash(_tags),totalSpent,generatedFrom,deletedAt,version]);

@override
String toString() {
  return 'ShoppingList(id: $id, title: $title, ownerId: $ownerId, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy, description: $description, emoji: $emoji, colorHex: $colorHex, categoryId: $categoryId, memberIds: $memberIds, memberRoles: $memberRoles, memberCount: $memberCount, itemCount: $itemCount, completedItemCount: $completedItemCount, isArchived: $isArchived, isPinned: $isPinned, isFavorite: $isFavorite, isCompleted: $isCompleted, completedAt: $completedAt, lastActivityAt: $lastActivityAt, itemSortOption: $itemSortOption, budget: $budget, currency: $currency, tags: $tags, totalSpent: $totalSpent, generatedFrom: $generatedFrom, deletedAt: $deletedAt, version: $version)';
}


}

/// @nodoc
abstract mixin class _$ShoppingListCopyWith<$Res> implements $ShoppingListCopyWith<$Res> {
  factory _$ShoppingListCopyWith(_ShoppingList value, $Res Function(_ShoppingList) _then) = __$ShoppingListCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String ownerId,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, String createdBy, String updatedBy, String description, String emoji, String colorHex, String? categoryId, List<String> memberIds, Map<String, MemberRole> memberRoles, int memberCount, int itemCount, int completedItemCount, bool isArchived, bool isPinned, bool isFavorite, bool isCompleted,@NullableTimestampConverter() DateTime? completedAt,@NullableTimestampConverter() DateTime? lastActivityAt, ItemSortOption itemSortOption,@NullableDoubleConverter() double? budget, String currency, List<String> tags,@FlexibleDoubleConverter() double totalSpent, AiListKind? generatedFrom,@NullableTimestampConverter() DateTime? deletedAt, int version
});




}
/// @nodoc
class __$ShoppingListCopyWithImpl<$Res>
    implements _$ShoppingListCopyWith<$Res> {
  __$ShoppingListCopyWithImpl(this._self, this._then);

  final _ShoppingList _self;
  final $Res Function(_ShoppingList) _then;

/// Create a copy of ShoppingList
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? ownerId = null,Object? createdAt = null,Object? updatedAt = null,Object? createdBy = null,Object? updatedBy = null,Object? description = null,Object? emoji = null,Object? colorHex = null,Object? categoryId = freezed,Object? memberIds = null,Object? memberRoles = null,Object? memberCount = null,Object? itemCount = null,Object? completedItemCount = null,Object? isArchived = null,Object? isPinned = null,Object? isFavorite = null,Object? isCompleted = null,Object? completedAt = freezed,Object? lastActivityAt = freezed,Object? itemSortOption = null,Object? budget = freezed,Object? currency = null,Object? tags = null,Object? totalSpent = null,Object? generatedFrom = freezed,Object? deletedAt = freezed,Object? version = null,}) {
  return _then(_ShoppingList(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,updatedBy: null == updatedBy ? _self.updatedBy : updatedBy // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,memberIds: null == memberIds ? _self._memberIds : memberIds // ignore: cast_nullable_to_non_nullable
as List<String>,memberRoles: null == memberRoles ? _self._memberRoles : memberRoles // ignore: cast_nullable_to_non_nullable
as Map<String, MemberRole>,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,itemCount: null == itemCount ? _self.itemCount : itemCount // ignore: cast_nullable_to_non_nullable
as int,completedItemCount: null == completedItemCount ? _self.completedItemCount : completedItemCount // ignore: cast_nullable_to_non_nullable
as int,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,isPinned: null == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastActivityAt: freezed == lastActivityAt ? _self.lastActivityAt : lastActivityAt // ignore: cast_nullable_to_non_nullable
as DateTime?,itemSortOption: null == itemSortOption ? _self.itemSortOption : itemSortOption // ignore: cast_nullable_to_non_nullable
as ItemSortOption,budget: freezed == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as double?,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,totalSpent: null == totalSpent ? _self.totalSpent : totalSpent // ignore: cast_nullable_to_non_nullable
as double,generatedFrom: freezed == generatedFrom ? _self.generatedFrom : generatedFrom // ignore: cast_nullable_to_non_nullable
as AiListKind?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
