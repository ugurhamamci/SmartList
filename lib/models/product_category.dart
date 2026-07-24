import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:smartlist/core/utils/json_converters.dart';

part 'product_category.freezed.dart';
part 'product_category.g.dart';

/// A product category, stored at `categories/{id}`.
///
/// Curated categories are seeded by the backend with [isGlobal] set and no
/// [ownerId]; user-defined categories carry the creator's id and are private
/// to them.
@freezed
abstract class ProductCategory with _$ProductCategory {
  const factory ProductCategory({
    required String id,
    required String name,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
    required String createdBy,
    required String updatedBy,

    /// Null for curated global categories.
    String? ownerId,
    @Default(false) bool isGlobal,
    @Default('📦') String emoji,
    @Default('FF6C63FF') String colorHex,

    /// Stable key for looking up the localized display name; empty for
    /// user-defined categories, whose [name] is already in the user's language.
    @Default('') String localizationKey,
    @Default(0) int sortOrder,
    @NullableTimestampConverter() DateTime? deletedAt,
    @Default(1) int version,
  }) = _ProductCategory;

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryFromJson(json);
}

/// Derived properties of a [ProductCategory].
extension ProductCategoryX on ProductCategory {
  bool get isDeleted => deletedAt != null;

  bool get isUserDefined => ownerId != null;

  bool get hasLocalizedName => localizationKey.isNotEmpty;
}
