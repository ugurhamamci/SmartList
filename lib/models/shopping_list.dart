import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:smartlist/core/utils/json_converters.dart';
import 'package:smartlist/models/enums.dart';

part 'shopping_list.freezed.dart';
part 'shopping_list.g.dart';

/// A collaborative shopping list, stored at `shopping_lists/{id}`.
///
/// [memberIds] and [memberRoles] are denormalised onto the document so that a
/// single read authorises every operation on the list and its subcollections,
/// and so that "lists I belong to" is answerable with one `array-contains`
/// query. The two fields are kept consistent by the security rules.
@freezed
abstract class ShoppingList with _$ShoppingList {
  const factory ShoppingList({
    required String id,
    required String title,
    required String ownerId,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
    required String createdBy,
    required String updatedBy,
    @Default('') String description,

    /// Emoji shown as the list glyph.
    @Default('🛒') String emoji,

    /// Colour label, stored as an `AARRGGBB` hex string.
    @Default('FF6C63FF') String colorHex,
    String? categoryId,
    @Default(<String>[]) List<String> memberIds,
    @Default(<String, MemberRole>{}) Map<String, MemberRole> memberRoles,
    @Default(1) int memberCount,
    @Default(0) int itemCount,
    @Default(0) int completedItemCount,
    @Default(false) bool isArchived,
    @Default(false) bool isPinned,
    @Default(false) bool isFavorite,
    @Default(false) bool isCompleted,
    @NullableTimestampConverter() DateTime? completedAt,

    /// Last time an item or message changed, used to order "continue shopping".
    @NullableTimestampConverter() DateTime? lastActivityAt,
    @Default(ItemSortOption.manual) ItemSortOption itemSortOption,
    @NullableDoubleConverter() double? budget,
    @Default('USD') String currency,
    @Default(<String>[]) List<String> tags,

    /// Total recorded spend, maintained by Cloud Functions as items are ticked.
    @Default(0) @FlexibleDoubleConverter() double totalSpent,

    /// Set when the list was produced by the AI generator.
    AiListKind? generatedFrom,
    @NullableTimestampConverter() DateTime? deletedAt,
    @Default(1) int version,
  }) = _ShoppingList;

  factory ShoppingList.fromJson(Map<String, dynamic> json) =>
      _$ShoppingListFromJson(json);
}

/// Derived, presentation-independent properties of a [ShoppingList].
extension ShoppingListX on ShoppingList {
  bool get isDeleted => deletedAt != null;

  bool get isShared => memberCount > 1;

  int get remainingItemCount =>
      (itemCount - completedItemCount).clamp(0, itemCount);

  /// Completion ratio in `0..1`; an empty list reports `0`.
  double get progress {
    if (itemCount <= 0) {
      return 0;
    }
    return (completedItemCount / itemCount).clamp(0, 1);
  }

  bool get isFullyPurchased => itemCount > 0 && completedItemCount >= itemCount;

  /// Role held by [userId], or [MemberRole.guest] when not a member.
  MemberRole roleOf(String userId) => memberRoles[userId] ?? MemberRole.guest;

  bool isMember(String userId) => memberRoles.containsKey(userId);

  bool isOwnedBy(String userId) => ownerId == userId;

  /// Timestamp used to sort the list overview.
  DateTime get sortTimestamp => lastActivityAt ?? updatedAt;
}
