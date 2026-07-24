import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:smartlist/core/utils/json_converters.dart';
import 'package:smartlist/models/enums.dart';

part 'shopping_template.freezed.dart';
part 'shopping_template.g.dart';

/// One line of a [ShoppingTemplate]. Embedded rather than stored in a
/// subcollection because a template is always read in full and is small.
@freezed
abstract class TemplateItem with _$TemplateItem {
  const factory TemplateItem({
    required String name,
    @Default(1) @FlexibleDoubleConverter() double quantity,
    @Default(MeasurementUnit.piece) MeasurementUnit unit,
    String? categoryId,
    @Default('') String notes,
    @Default(ItemPriority.normal) ItemPriority priority,
    @NullableDoubleConverter() double? estimatedPrice,
    @Default(0) @FlexibleDoubleConverter() double sortOrder,
  }) = _TemplateItem;

  factory TemplateItem.fromJson(Map<String, dynamic> json) =>
      _$TemplateItemFromJson(json);
}

/// A reusable list blueprint at `shopping_templates/{id}`.
///
/// Curated templates carry [isPublic]; a user's own saved templates are private
/// to them. Applying a template materialises its [items] into a new list.
@freezed
abstract class ShoppingTemplate with _$ShoppingTemplate {
  const factory ShoppingTemplate({
    required String id,
    required String name,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
    required String createdBy,
    required String updatedBy,

    /// Null for curated templates authored by the backend.
    String? ownerId,
    @Default(false) bool isPublic,
    @Default('') String description,
    @Default('🛒') String emoji,
    @Default('FF6C63FF') String colorHex,

    /// Grouping used by the template browser, e.g. `weekly`, `party`.
    @Default('') String category,
    @Default(<TemplateItem>[]) List<TemplateItem> items,
    @Default(0) int usageCount,

    /// Set when the template was produced by the AI generator.
    AiListKind? generatedFrom,
    @NullableTimestampConverter() DateTime? deletedAt,
    @Default(1) int version,
  }) = _ShoppingTemplate;

  factory ShoppingTemplate.fromJson(Map<String, dynamic> json) =>
      _$ShoppingTemplateFromJson(json);
}

/// Derived properties of a [ShoppingTemplate].
extension ShoppingTemplateX on ShoppingTemplate {
  bool get isDeleted => deletedAt != null;

  bool get isCurated => ownerId == null;

  int get itemCount => items.length;

  /// Sum of the per-line estimates, or `null` when no line carries a price.
  double? get estimatedTotal {
    final priced = items.where((item) => item.estimatedPrice != null);
    if (priced.isEmpty) {
      return null;
    }
    return priced.fold<double>(
      0,
      (total, item) => total + item.estimatedPrice! * item.quantity,
    );
  }
}
