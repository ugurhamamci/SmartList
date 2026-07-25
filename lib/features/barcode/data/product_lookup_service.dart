import 'package:dio/dio.dart';

import 'package:smartlist/core/errors/app_exception.dart';
import 'package:smartlist/core/errors/error_mapper.dart';
import 'package:smartlist/models/enums.dart';

/// Barkoddan çözülen ürün bilgisi.
class ProductInfo {
  const ProductInfo({
    required this.barcode,
    required this.name,
    this.brand = '',
    this.quantity = '',
    this.imageUrl,
    this.categoryHint = '',
  });

  /// Open Food Facts `product` nesnesinden okur.
  ///
  /// Türkçe ürün adı varsa onu tercih eder; yoksa genel ada düşer. İki alan da
  /// boşsa ürün adsız sayılır ve [isUsable] false döner.
  factory ProductInfo.fromOpenFoodFacts(
    String barcode,
    Map<String, dynamic> json,
  ) {
    String pick(List<String> keys) {
      for (final key in keys) {
        final value = json[key];
        if (value is String && value.trim().isNotEmpty) {
          return value.trim();
        }
      }
      return '';
    }

    // `brands` virgülle ayrılmış liste döner ("Nutella, Ferrero, Yum yum");
    // ilk marka en belirleyici olanıdır.
    final brands = pick(['brands']);
    final firstBrand = brands.isEmpty ? '' : brands.split(',').first.trim();

    return ProductInfo(
      barcode: barcode,
      name: pick(['product_name_tr', 'product_name']),
      brand: firstBrand,
      quantity: pick(['quantity']),
      imageUrl: pick(['image_front_small_url', 'image_url']).isEmpty
          ? null
          : pick(['image_front_small_url', 'image_url']),
      categoryHint: _categoryFrom(json['categories_tags']),
    );
  }

  /// `categories_tags` en özelden en genele sıralı gelir; sondaki en geniş
  /// kategoriyi alıp dil önekini ("en:") atıyoruz.
  static String _categoryFrom(Object? tags) {
    if (tags is! List || tags.isEmpty) {
      return '';
    }
    final first = tags.first;
    if (first is! String) {
      return '';
    }
    final withoutPrefix = first.contains(':') ? first.split(':').last : first;
    return withoutPrefix.replaceAll('-', ' ');
  }

  final String barcode;
  final String name;
  final String brand;
  final String quantity;
  final String? imageUrl;

  /// Kategori eşlemesi için ipucu; kullanıcıya doğrudan gösterilmez.
  final String categoryHint;

  /// Ürünün listeye eklenebilmesi için en azından bir adı olmalı.
  bool get isUsable => name.isNotEmpty;

  /// Listede gösterilecek ad. Marka biliniyorsa başa eklenir.
  String get displayName {
    if (brand.isEmpty || name.toLowerCase().contains(brand.toLowerCase())) {
      return name;
    }
    return '$brand $name';
  }
}

/// Barkoddan ürün adı çözer.
///
/// Kaynak **Open Food Facts** — açık veritabanı, API anahtarı gerektirmez. Bu
/// tercih bilinçli: uygulama ürün araması için kullanıcıdan anahtar istemek
/// veya bir proxy kurmak zorunda kalmıyor.
///
/// Servis, kendi kullanım koşulları gereği tanımlayıcı bir `User-Agent`
/// bekliyor; anonim istekler kısıtlanabiliyor.
class ProductLookupService {
  ProductLookupService({required this._dio, String? userAgent})
    : _userAgent = userAgent ?? _defaultUserAgent;

  static const String _defaultUserAgent =
      'SmartList/1.0 (Flutter; https://github.com/ugurhamamci/SmartList)';

  static const String _base = 'https://world.openfoodfacts.org/api/v2/product';

  /// Yalnızca ihtiyaç duyulan alanlar istenir; tüm ürün belgesi yüzlerce alan
  /// içeriyor ve mobil bağlantıda gereksiz veri demek.
  static const String _fields =
      'code,product_name,product_name_tr,brands,quantity,'
      'categories_tags,image_front_small_url,image_url';

  final Dio _dio;
  final String _userAgent;

  /// [barcode] için ürünü çözer. Bulunamazsa `null` döner — bu bir hata
  /// değildir, veritabanında olmayan ürün normaldir ve kullanıcı adı elle
  /// yazarak devam edebilir.
  ///
  /// Ağ veya sunucu hatasında `AppException` fırlatır.
  Future<ProductInfo?> lookup(String barcode) async {
    final normalised = normaliseBarcode(barcode);
    if (normalised == null) {
      throw ValidationException(
        code: 'barcode.invalid',
        field: 'barcode',
        details: 'Geçersiz barkod: $barcode',
      );
    }

    final response = await ErrorMapper.guard(
      () => _dio.get<Map<String, dynamic>>(
        '$_base/$normalised.json',
        queryParameters: {'fields': _fields},
        options: Options(
          headers: {'User-Agent': _userAgent},
          // Bulunamayan ürün 404 dönebiliyor; bunu istisna olarak değil
          // "sonuç yok" olarak ele almak istiyoruz.
          validateStatus: (status) =>
              status != null && (status == 404 || status < 400),
        ),
      ),
    );

    final payload = response.data;
    if (payload == null) {
      return null;
    }

    // `status` 1 ise ürün var, 0 ise yok. Alan bazen sayı bazen metin gelir.
    final status = payload['status'];
    final found = status == 1 || status == '1';
    if (!found) {
      return null;
    }

    final product = payload['product'];
    if (product is! Map<String, dynamic>) {
      return null;
    }

    final info = ProductInfo.fromOpenFoodFacts(normalised, product);
    return info.isUsable ? info : null;
  }

  /// Barkodu doğrular ve normalleştirir.
  ///
  /// Tarayıcılar bazen boşluk veya tire ile kod döndürür. Geçerli ürün kodları
  /// 8–14 hane arası rakamdır (EAN-8, UPC-A, EAN-13, ITF-14). Geçersizse
  /// `null` döner.
  static String? normaliseBarcode(String raw) {
    final digits = raw.replaceAll(RegExp('[^0-9]'), '');
    if (digits.length < 8 || digits.length > 14) {
      return null;
    }
    return digits;
  }

  /// Kodun simgeleme türünü hane sayısına ve önekine göre tahmin eder.
  ///
  /// 978/979 ile başlayan 13 haneli kod Bookland EAN'idir, yani ISBN.
  static BarcodeSymbology symbologyOf(String raw) {
    final digits = normaliseBarcode(raw);
    if (digits == null) {
      return BarcodeSymbology.unknown;
    }
    return switch (digits.length) {
      13 =>
        digits.startsWith('978') || digits.startsWith('979')
            ? BarcodeSymbology.isbn
            : BarcodeSymbology.ean13,
      12 => BarcodeSymbology.upcA,
      8 => BarcodeSymbology.ean8,
      14 => BarcodeSymbology.itf,
      _ => BarcodeSymbology.unknown,
    };
  }
}
