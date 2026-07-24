import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:smartlist/core/utils/json_converters.dart';
import 'package:smartlist/models/enums.dart';

part 'favorite.freezed.dart';
part 'favorite.g.dart';

/// A favourite at `users/{userId}/favorites/{id}`.
///
/// Favourites are user-scoped rather than a flag on the target, so marking a
/// shared list as a favourite does not change what collaborators see.
@freezed
abstract class Favorite with _$Favorite {
  const factory Favorite({
    required String id,
    required String userId,
    required String targetId,
    required FavoriteTargetType targetType,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,

    /// Denormalised label and glyph so the favourites row renders from one read.
    @Default('') String label,
    @Default('⭐') String emoji,

    /// For an item favourite, the list it came from.
    String? listId,
  }) = _Favorite;

  factory Favorite.fromJson(Map<String, dynamic> json) =>
      _$FavoriteFromJson(json);
}

/// A search at `users/{userId}/recent_searches/{id}`.
///
/// The document id is a hash of the normalised query so repeating a search
/// updates one row instead of appending duplicates.
@freezed
abstract class RecentSearch with _$RecentSearch {
  const factory RecentSearch({
    required String id,
    required String userId,
    required String query,
    @TimestampConverter() required DateTime searchedAt,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
    @Default(1) int searchCount,
    @Default(0) int resultCount,
  }) = _RecentSearch;

  factory RecentSearch.fromJson(Map<String, dynamic> json) =>
      _$RecentSearchFromJson(json);
}
