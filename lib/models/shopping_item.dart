import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:smartlist/core/utils/json_converters.dart';
import 'package:smartlist/models/enums.dart';

part 'shopping_item.freezed.dart';
part 'shopping_item.g.dart';

/// A product on a list, stored at `shopping_lists/{listId}/items/{id}`.
///
/// [sortOrder] is a sparse double so that a drag-and-drop reorder writes a
/// single document — the moved item receives the midpoint of its new
/// neighbours instead of renumbering the collection.
@freezed
abstract class ShoppingItem with _$ShoppingItem {
  const factory ShoppingItem({
    required String id,
    required String listId,
    required String name,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
    required String createdBy,
    required String updatedBy,
    @Default(1) @FlexibleDoubleConverter() double quantity,
    @Default(MeasurementUnit.piece) MeasurementUnit unit,
    String? categoryId,
    @Default('') String notes,
    @NullableDoubleConverter() double? price,
    @Default('USD') String currency,
    @Default(ItemPriority.normal) ItemPriority priority,
    @Default(false) bool isCompleted,
    @NullableTimestampConverter() DateTime? completedAt,

    /// Member who ticked the item off, and when.
    String? purchasedBy,
    @NullableTimestampConverter() DateTime? purchasedAt,
    String? imageUrl,
    String? barcode,
    BarcodeSymbology? barcodeFormat,
    @Default(0) @FlexibleDoubleConverter() double sortOrder,
    @Default(ItemSource.manual) ItemSource source,

    /// Free-text brand captured from a barcode lookup.
    String? brand,
    @NullableTimestampConverter() DateTime? deletedAt,
    @Default(1) int version,
  }) = _ShoppingItem;

  factory ShoppingItem.fromJson(Map<String, dynamic> json) =>
      _$ShoppingItemFromJson(json);
}

/// Derived properties of a [ShoppingItem].
extension ShoppingItemX on ShoppingItem {
  bool get isDeleted => deletedAt != null;

  bool get hasImage => imageUrl != null && imageUrl!.isNotEmpty;

  bool get hasBarcode => barcode != null && barcode!.isNotEmpty;

  bool get hasNotes => notes.trim().isNotEmpty;

  bool get hasPrice => price != null;

  /// Line total, or `null` when no unit price was recorded.
  double? get lineTotal => price == null ? null : price! * quantity;

  bool get isUrgent => priority == ItemPriority.urgent;

  /// `2 kg` style label; whole quantities drop the decimal part.
  String get quantityLabel {
    final formatted = quantity == quantity.roundToDouble()
        ? quantity.round().toString()
        : quantity.toStringAsFixed(2);
    return unit == MeasurementUnit.piece
        ? formatted
        : '$formatted ${unit.wire}';
  }
}
