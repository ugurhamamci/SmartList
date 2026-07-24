// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_scan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BarcodeScan _$BarcodeScanFromJson(Map<String, dynamic> json) => _BarcodeScan(
  id: json['id'] as String,
  userId: json['userId'] as String,
  code: json['code'] as String,
  format: $enumDecode(_$BarcodeSymbologyEnumMap, json['format']),
  scannedAt: const TimestampConverter().fromJson(json['scannedAt']),
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
  productName: json['productName'] as String? ?? '',
  brand: json['brand'] as String? ?? '',
  categoryId: json['categoryId'] as String?,
  imageUrl: json['imageUrl'] as String?,
  lastPrice: const NullableDoubleConverter().fromJson(json['lastPrice']),
  currency: json['currency'] as String? ?? 'USD',
  scanCount: (json['scanCount'] as num?)?.toInt() ?? 1,
  listId: json['listId'] as String?,
  itemId: json['itemId'] as String?,
);

Map<String, dynamic> _$BarcodeScanToJson(_BarcodeScan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'code': instance.code,
      'format': _$BarcodeSymbologyEnumMap[instance.format]!,
      'scannedAt': const TimestampConverter().toJson(instance.scannedAt),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'productName': instance.productName,
      'brand': instance.brand,
      'categoryId': instance.categoryId,
      'imageUrl': instance.imageUrl,
      'lastPrice': const NullableDoubleConverter().toJson(instance.lastPrice),
      'currency': instance.currency,
      'scanCount': instance.scanCount,
      'listId': instance.listId,
      'itemId': instance.itemId,
    };

const _$BarcodeSymbologyEnumMap = {
  BarcodeSymbology.ean13: 'ean13',
  BarcodeSymbology.ean8: 'ean8',
  BarcodeSymbology.upcA: 'upc_a',
  BarcodeSymbology.upcE: 'upc_e',
  BarcodeSymbology.qr: 'qr',
  BarcodeSymbology.isbn: 'isbn',
  BarcodeSymbology.code128: 'code128',
  BarcodeSymbology.code39: 'code39',
  BarcodeSymbology.itf: 'itf',
  BarcodeSymbology.dataMatrix: 'data_matrix',
  BarcodeSymbology.unknown: 'unknown',
};
