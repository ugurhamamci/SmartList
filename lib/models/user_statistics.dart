import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:smartlist/core/utils/json_converters.dart';
import 'package:smartlist/models/enums.dart';

part 'user_statistics.freezed.dart';
part 'user_statistics.g.dart';

/// One aggregation bucket at `users/{userId}/statistics/{id}`.
///
/// Written only by the aggregation Cloud Function, which folds activity logs
/// into per-period counters. Pre-aggregating keeps the statistics screen to a
/// single document read instead of scanning a user's entire purchase history.
@freezed
abstract class UserStatistics with _$UserStatistics {
  const factory UserStatistics({
    required String id,
    required String userId,
    required StatisticsPeriod period,
    @TimestampConverter() required DateTime periodStart,
    @TimestampConverter() required DateTime periodEnd,
    @TimestampConverter() required DateTime updatedAt,
    @Default(0) int listsCreated,
    @Default(0) int listsCompleted,
    @Default(0) int itemsAdded,
    @Default(0) int itemsCompleted,
    @Default(0) @FlexibleDoubleConverter() double totalSpent,
    @Default('USD') String currency,

    /// Spend keyed by category id.
    @Default(<String, double>{}) Map<String, double> spendByCategory,

    /// Completed-item counts keyed by category id.
    @Default(<String, int>{}) Map<String, int> itemsByCategory,

    /// Purchase counts keyed by normalised product name, used for the
    /// "most purchased" ranking and for autocomplete suggestions.
    @Default(<String, int>{}) Map<String, int> itemFrequency,

    /// Spend per day of the period, keyed by `yyyy-MM-dd`, used for the chart.
    @Default(<String, double>{}) Map<String, double> spendByDay,
  }) = _UserStatistics;

  factory UserStatistics.fromJson(Map<String, dynamic> json) =>
      _$UserStatisticsFromJson(json);
}

/// Derived properties of a [UserStatistics] bucket.
extension UserStatisticsX on UserStatistics {
  /// Mean spend per completed item, or `0` when nothing was purchased.
  double get averageItemSpend =>
      itemsCompleted == 0 ? 0 : totalSpent / itemsCompleted;

  /// Mean spend per completed list.
  double get averageListSpend =>
      listsCompleted == 0 ? 0 : totalSpent / listsCompleted;

  /// Share of added items that were actually purchased, in `0..1`.
  double get completionRate =>
      itemsAdded == 0 ? 0 : (itemsCompleted / itemsAdded).clamp(0, 1);

  /// Product names ordered by purchase count, most frequent first.
  List<({String name, int count})> get mostPurchased {
    final entries = itemFrequency.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return entries
        .map((entry) => (name: entry.key, count: entry.value))
        .toList();
  }

  /// Category ids ordered by spend, highest first.
  List<({String categoryId, double amount})> get topCategoriesBySpend {
    final entries = spendByCategory.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return entries
        .map((entry) => (categoryId: entry.key, amount: entry.value))
        .toList();
  }
}
