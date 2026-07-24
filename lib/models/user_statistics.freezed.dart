// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_statistics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserStatistics {

 String get id; String get userId; StatisticsPeriod get period;@TimestampConverter() DateTime get periodStart;@TimestampConverter() DateTime get periodEnd;@TimestampConverter() DateTime get updatedAt; int get listsCreated; int get listsCompleted; int get itemsAdded; int get itemsCompleted;@FlexibleDoubleConverter() double get totalSpent; String get currency;/// Spend keyed by category id.
 Map<String, double> get spendByCategory;/// Completed-item counts keyed by category id.
 Map<String, int> get itemsByCategory;/// Purchase counts keyed by normalised product name, used for the
/// "most purchased" ranking and for autocomplete suggestions.
 Map<String, int> get itemFrequency;/// Spend per day of the period, keyed by `yyyy-MM-dd`, used for the chart.
 Map<String, double> get spendByDay;
/// Create a copy of UserStatistics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserStatisticsCopyWith<UserStatistics> get copyWith => _$UserStatisticsCopyWithImpl<UserStatistics>(this as UserStatistics, _$identity);

  /// Serializes this UserStatistics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserStatistics&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.period, period) || other.period == period)&&(identical(other.periodStart, periodStart) || other.periodStart == periodStart)&&(identical(other.periodEnd, periodEnd) || other.periodEnd == periodEnd)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.listsCreated, listsCreated) || other.listsCreated == listsCreated)&&(identical(other.listsCompleted, listsCompleted) || other.listsCompleted == listsCompleted)&&(identical(other.itemsAdded, itemsAdded) || other.itemsAdded == itemsAdded)&&(identical(other.itemsCompleted, itemsCompleted) || other.itemsCompleted == itemsCompleted)&&(identical(other.totalSpent, totalSpent) || other.totalSpent == totalSpent)&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other.spendByCategory, spendByCategory)&&const DeepCollectionEquality().equals(other.itemsByCategory, itemsByCategory)&&const DeepCollectionEquality().equals(other.itemFrequency, itemFrequency)&&const DeepCollectionEquality().equals(other.spendByDay, spendByDay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,period,periodStart,periodEnd,updatedAt,listsCreated,listsCompleted,itemsAdded,itemsCompleted,totalSpent,currency,const DeepCollectionEquality().hash(spendByCategory),const DeepCollectionEquality().hash(itemsByCategory),const DeepCollectionEquality().hash(itemFrequency),const DeepCollectionEquality().hash(spendByDay));

@override
String toString() {
  return 'UserStatistics(id: $id, userId: $userId, period: $period, periodStart: $periodStart, periodEnd: $periodEnd, updatedAt: $updatedAt, listsCreated: $listsCreated, listsCompleted: $listsCompleted, itemsAdded: $itemsAdded, itemsCompleted: $itemsCompleted, totalSpent: $totalSpent, currency: $currency, spendByCategory: $spendByCategory, itemsByCategory: $itemsByCategory, itemFrequency: $itemFrequency, spendByDay: $spendByDay)';
}


}

/// @nodoc
abstract mixin class $UserStatisticsCopyWith<$Res>  {
  factory $UserStatisticsCopyWith(UserStatistics value, $Res Function(UserStatistics) _then) = _$UserStatisticsCopyWithImpl;
@useResult
$Res call({
 String id, String userId, StatisticsPeriod period,@TimestampConverter() DateTime periodStart,@TimestampConverter() DateTime periodEnd,@TimestampConverter() DateTime updatedAt, int listsCreated, int listsCompleted, int itemsAdded, int itemsCompleted,@FlexibleDoubleConverter() double totalSpent, String currency, Map<String, double> spendByCategory, Map<String, int> itemsByCategory, Map<String, int> itemFrequency, Map<String, double> spendByDay
});




}
/// @nodoc
class _$UserStatisticsCopyWithImpl<$Res>
    implements $UserStatisticsCopyWith<$Res> {
  _$UserStatisticsCopyWithImpl(this._self, this._then);

  final UserStatistics _self;
  final $Res Function(UserStatistics) _then;

/// Create a copy of UserStatistics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? period = null,Object? periodStart = null,Object? periodEnd = null,Object? updatedAt = null,Object? listsCreated = null,Object? listsCompleted = null,Object? itemsAdded = null,Object? itemsCompleted = null,Object? totalSpent = null,Object? currency = null,Object? spendByCategory = null,Object? itemsByCategory = null,Object? itemFrequency = null,Object? spendByDay = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as StatisticsPeriod,periodStart: null == periodStart ? _self.periodStart : periodStart // ignore: cast_nullable_to_non_nullable
as DateTime,periodEnd: null == periodEnd ? _self.periodEnd : periodEnd // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,listsCreated: null == listsCreated ? _self.listsCreated : listsCreated // ignore: cast_nullable_to_non_nullable
as int,listsCompleted: null == listsCompleted ? _self.listsCompleted : listsCompleted // ignore: cast_nullable_to_non_nullable
as int,itemsAdded: null == itemsAdded ? _self.itemsAdded : itemsAdded // ignore: cast_nullable_to_non_nullable
as int,itemsCompleted: null == itemsCompleted ? _self.itemsCompleted : itemsCompleted // ignore: cast_nullable_to_non_nullable
as int,totalSpent: null == totalSpent ? _self.totalSpent : totalSpent // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,spendByCategory: null == spendByCategory ? _self.spendByCategory : spendByCategory // ignore: cast_nullable_to_non_nullable
as Map<String, double>,itemsByCategory: null == itemsByCategory ? _self.itemsByCategory : itemsByCategory // ignore: cast_nullable_to_non_nullable
as Map<String, int>,itemFrequency: null == itemFrequency ? _self.itemFrequency : itemFrequency // ignore: cast_nullable_to_non_nullable
as Map<String, int>,spendByDay: null == spendByDay ? _self.spendByDay : spendByDay // ignore: cast_nullable_to_non_nullable
as Map<String, double>,
  ));
}

}


/// Adds pattern-matching-related methods to [UserStatistics].
extension UserStatisticsPatterns on UserStatistics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserStatistics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserStatistics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserStatistics value)  $default,){
final _that = this;
switch (_that) {
case _UserStatistics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserStatistics value)?  $default,){
final _that = this;
switch (_that) {
case _UserStatistics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  StatisticsPeriod period, @TimestampConverter()  DateTime periodStart, @TimestampConverter()  DateTime periodEnd, @TimestampConverter()  DateTime updatedAt,  int listsCreated,  int listsCompleted,  int itemsAdded,  int itemsCompleted, @FlexibleDoubleConverter()  double totalSpent,  String currency,  Map<String, double> spendByCategory,  Map<String, int> itemsByCategory,  Map<String, int> itemFrequency,  Map<String, double> spendByDay)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserStatistics() when $default != null:
return $default(_that.id,_that.userId,_that.period,_that.periodStart,_that.periodEnd,_that.updatedAt,_that.listsCreated,_that.listsCompleted,_that.itemsAdded,_that.itemsCompleted,_that.totalSpent,_that.currency,_that.spendByCategory,_that.itemsByCategory,_that.itemFrequency,_that.spendByDay);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  StatisticsPeriod period, @TimestampConverter()  DateTime periodStart, @TimestampConverter()  DateTime periodEnd, @TimestampConverter()  DateTime updatedAt,  int listsCreated,  int listsCompleted,  int itemsAdded,  int itemsCompleted, @FlexibleDoubleConverter()  double totalSpent,  String currency,  Map<String, double> spendByCategory,  Map<String, int> itemsByCategory,  Map<String, int> itemFrequency,  Map<String, double> spendByDay)  $default,) {final _that = this;
switch (_that) {
case _UserStatistics():
return $default(_that.id,_that.userId,_that.period,_that.periodStart,_that.periodEnd,_that.updatedAt,_that.listsCreated,_that.listsCompleted,_that.itemsAdded,_that.itemsCompleted,_that.totalSpent,_that.currency,_that.spendByCategory,_that.itemsByCategory,_that.itemFrequency,_that.spendByDay);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  StatisticsPeriod period, @TimestampConverter()  DateTime periodStart, @TimestampConverter()  DateTime periodEnd, @TimestampConverter()  DateTime updatedAt,  int listsCreated,  int listsCompleted,  int itemsAdded,  int itemsCompleted, @FlexibleDoubleConverter()  double totalSpent,  String currency,  Map<String, double> spendByCategory,  Map<String, int> itemsByCategory,  Map<String, int> itemFrequency,  Map<String, double> spendByDay)?  $default,) {final _that = this;
switch (_that) {
case _UserStatistics() when $default != null:
return $default(_that.id,_that.userId,_that.period,_that.periodStart,_that.periodEnd,_that.updatedAt,_that.listsCreated,_that.listsCompleted,_that.itemsAdded,_that.itemsCompleted,_that.totalSpent,_that.currency,_that.spendByCategory,_that.itemsByCategory,_that.itemFrequency,_that.spendByDay);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserStatistics implements UserStatistics {
  const _UserStatistics({required this.id, required this.userId, required this.period, @TimestampConverter() required this.periodStart, @TimestampConverter() required this.periodEnd, @TimestampConverter() required this.updatedAt, this.listsCreated = 0, this.listsCompleted = 0, this.itemsAdded = 0, this.itemsCompleted = 0, @FlexibleDoubleConverter() this.totalSpent = 0, this.currency = 'USD', final  Map<String, double> spendByCategory = const <String, double>{}, final  Map<String, int> itemsByCategory = const <String, int>{}, final  Map<String, int> itemFrequency = const <String, int>{}, final  Map<String, double> spendByDay = const <String, double>{}}): _spendByCategory = spendByCategory,_itemsByCategory = itemsByCategory,_itemFrequency = itemFrequency,_spendByDay = spendByDay;
  factory _UserStatistics.fromJson(Map<String, dynamic> json) => _$UserStatisticsFromJson(json);

@override final  String id;
@override final  String userId;
@override final  StatisticsPeriod period;
@override@TimestampConverter() final  DateTime periodStart;
@override@TimestampConverter() final  DateTime periodEnd;
@override@TimestampConverter() final  DateTime updatedAt;
@override@JsonKey() final  int listsCreated;
@override@JsonKey() final  int listsCompleted;
@override@JsonKey() final  int itemsAdded;
@override@JsonKey() final  int itemsCompleted;
@override@JsonKey()@FlexibleDoubleConverter() final  double totalSpent;
@override@JsonKey() final  String currency;
/// Spend keyed by category id.
 final  Map<String, double> _spendByCategory;
/// Spend keyed by category id.
@override@JsonKey() Map<String, double> get spendByCategory {
  if (_spendByCategory is EqualUnmodifiableMapView) return _spendByCategory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_spendByCategory);
}

/// Completed-item counts keyed by category id.
 final  Map<String, int> _itemsByCategory;
/// Completed-item counts keyed by category id.
@override@JsonKey() Map<String, int> get itemsByCategory {
  if (_itemsByCategory is EqualUnmodifiableMapView) return _itemsByCategory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_itemsByCategory);
}

/// Purchase counts keyed by normalised product name, used for the
/// "most purchased" ranking and for autocomplete suggestions.
 final  Map<String, int> _itemFrequency;
/// Purchase counts keyed by normalised product name, used for the
/// "most purchased" ranking and for autocomplete suggestions.
@override@JsonKey() Map<String, int> get itemFrequency {
  if (_itemFrequency is EqualUnmodifiableMapView) return _itemFrequency;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_itemFrequency);
}

/// Spend per day of the period, keyed by `yyyy-MM-dd`, used for the chart.
 final  Map<String, double> _spendByDay;
/// Spend per day of the period, keyed by `yyyy-MM-dd`, used for the chart.
@override@JsonKey() Map<String, double> get spendByDay {
  if (_spendByDay is EqualUnmodifiableMapView) return _spendByDay;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_spendByDay);
}


/// Create a copy of UserStatistics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserStatisticsCopyWith<_UserStatistics> get copyWith => __$UserStatisticsCopyWithImpl<_UserStatistics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserStatisticsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserStatistics&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.period, period) || other.period == period)&&(identical(other.periodStart, periodStart) || other.periodStart == periodStart)&&(identical(other.periodEnd, periodEnd) || other.periodEnd == periodEnd)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.listsCreated, listsCreated) || other.listsCreated == listsCreated)&&(identical(other.listsCompleted, listsCompleted) || other.listsCompleted == listsCompleted)&&(identical(other.itemsAdded, itemsAdded) || other.itemsAdded == itemsAdded)&&(identical(other.itemsCompleted, itemsCompleted) || other.itemsCompleted == itemsCompleted)&&(identical(other.totalSpent, totalSpent) || other.totalSpent == totalSpent)&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other._spendByCategory, _spendByCategory)&&const DeepCollectionEquality().equals(other._itemsByCategory, _itemsByCategory)&&const DeepCollectionEquality().equals(other._itemFrequency, _itemFrequency)&&const DeepCollectionEquality().equals(other._spendByDay, _spendByDay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,period,periodStart,periodEnd,updatedAt,listsCreated,listsCompleted,itemsAdded,itemsCompleted,totalSpent,currency,const DeepCollectionEquality().hash(_spendByCategory),const DeepCollectionEquality().hash(_itemsByCategory),const DeepCollectionEquality().hash(_itemFrequency),const DeepCollectionEquality().hash(_spendByDay));

@override
String toString() {
  return 'UserStatistics(id: $id, userId: $userId, period: $period, periodStart: $periodStart, periodEnd: $periodEnd, updatedAt: $updatedAt, listsCreated: $listsCreated, listsCompleted: $listsCompleted, itemsAdded: $itemsAdded, itemsCompleted: $itemsCompleted, totalSpent: $totalSpent, currency: $currency, spendByCategory: $spendByCategory, itemsByCategory: $itemsByCategory, itemFrequency: $itemFrequency, spendByDay: $spendByDay)';
}


}

/// @nodoc
abstract mixin class _$UserStatisticsCopyWith<$Res> implements $UserStatisticsCopyWith<$Res> {
  factory _$UserStatisticsCopyWith(_UserStatistics value, $Res Function(_UserStatistics) _then) = __$UserStatisticsCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, StatisticsPeriod period,@TimestampConverter() DateTime periodStart,@TimestampConverter() DateTime periodEnd,@TimestampConverter() DateTime updatedAt, int listsCreated, int listsCompleted, int itemsAdded, int itemsCompleted,@FlexibleDoubleConverter() double totalSpent, String currency, Map<String, double> spendByCategory, Map<String, int> itemsByCategory, Map<String, int> itemFrequency, Map<String, double> spendByDay
});




}
/// @nodoc
class __$UserStatisticsCopyWithImpl<$Res>
    implements _$UserStatisticsCopyWith<$Res> {
  __$UserStatisticsCopyWithImpl(this._self, this._then);

  final _UserStatistics _self;
  final $Res Function(_UserStatistics) _then;

/// Create a copy of UserStatistics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? period = null,Object? periodStart = null,Object? periodEnd = null,Object? updatedAt = null,Object? listsCreated = null,Object? listsCompleted = null,Object? itemsAdded = null,Object? itemsCompleted = null,Object? totalSpent = null,Object? currency = null,Object? spendByCategory = null,Object? itemsByCategory = null,Object? itemFrequency = null,Object? spendByDay = null,}) {
  return _then(_UserStatistics(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as StatisticsPeriod,periodStart: null == periodStart ? _self.periodStart : periodStart // ignore: cast_nullable_to_non_nullable
as DateTime,periodEnd: null == periodEnd ? _self.periodEnd : periodEnd // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,listsCreated: null == listsCreated ? _self.listsCreated : listsCreated // ignore: cast_nullable_to_non_nullable
as int,listsCompleted: null == listsCompleted ? _self.listsCompleted : listsCompleted // ignore: cast_nullable_to_non_nullable
as int,itemsAdded: null == itemsAdded ? _self.itemsAdded : itemsAdded // ignore: cast_nullable_to_non_nullable
as int,itemsCompleted: null == itemsCompleted ? _self.itemsCompleted : itemsCompleted // ignore: cast_nullable_to_non_nullable
as int,totalSpent: null == totalSpent ? _self.totalSpent : totalSpent // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,spendByCategory: null == spendByCategory ? _self._spendByCategory : spendByCategory // ignore: cast_nullable_to_non_nullable
as Map<String, double>,itemsByCategory: null == itemsByCategory ? _self._itemsByCategory : itemsByCategory // ignore: cast_nullable_to_non_nullable
as Map<String, int>,itemFrequency: null == itemFrequency ? _self._itemFrequency : itemFrequency // ignore: cast_nullable_to_non_nullable
as Map<String, int>,spendByDay: null == spendByDay ? _self._spendByDay : spendByDay // ignore: cast_nullable_to_non_nullable
as Map<String, double>,
  ));
}


}

// dart format on
