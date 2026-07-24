import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:smartlist/core/utils/json_converters.dart';
import 'package:smartlist/models/enums.dart';

part 'barcode_scan.freezed.dart';
part 'barcode_scan.g.dart';

/// A scan at `users/{userId}/barcode_history/{id}`.
///
/// History is kept per user rather than per list so that rescanning a familiar
/// product resolves to a name offline, without a network lookup.
@freezed
abstract class BarcodeScan with _$BarcodeScan {
  const factory BarcodeScan({
    required String id,
    required String userId,
    required String code,
    required BarcodeSymbology format,
    @TimestampConverter() required DateTime scannedAt,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,

    /// Product name resolved from history, a catalogue lookup, or typed by the
    /// user when the code was previously unknown.
    @Default('') String productName,
    @Default('') String brand,
    String? categoryId,
    String? imageUrl,
    @NullableDoubleConverter() double? lastPrice,
    @Default('USD') String currency,

    /// Number of times this code has been scanned by the user.
    @Default(1) int scanCount,

    /// List the scan was added to, when it produced an item.
    String? listId,
    String? itemId,
  }) = _BarcodeScan;

  factory BarcodeScan.fromJson(Map<String, dynamic> json) =>
      _$BarcodeScanFromJson(json);
}

/// Derived properties of a [BarcodeScan].
extension BarcodeScanX on BarcodeScan {
  bool get isResolved => productName.trim().isNotEmpty;

  /// True when the code is a Bookland EAN, i.e. an ISBN.
  bool get isIsbn =>
      format == BarcodeSymbology.isbn ||
      (format == BarcodeSymbology.ean13 &&
          (code.startsWith('978') || code.startsWith('979')));
}
