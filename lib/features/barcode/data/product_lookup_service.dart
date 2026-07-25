import 'package:dio/dio.dart';

import 'package:smartlist/core/errors/app_exception.dart';
import 'package:smartlist/core/errors/error_mapper.dart';
import 'package:smartlist/models/enums.dart';

/// Barkodun sorgulanacağı açık veritabanı.
///
/// Aynı kuruluşun (Open Food Facts) dört ayrı veritabanı var ve **bir ürün
/// yalnızca birinde bulunuyor**. Canlı ölçümle doğrulandı:
///
/// | Barkod | Ürün | Veritabanı |
/// |---|---|---|
/// | 8691381000486 | Beypazarı Maden Suyu | food |
/// | 8690504017301 | Ülker Çubuk Kraker | food |
/// | 8690530031012 | Uni Baby | products |
/// | 9000101591460 | Henkel Yüzey Temizleyici | products |
/// | 4005900253668 | Nivea Sun | beauty |
///
/// Alışveriş listesi gıda, temizlik, kozmetik ve bebek ürünü karışık olduğu
/// için tek veritabanına bakmak listenin yarısını kaçırıyor.
enum OpenFactsDatabase {
  /// Gıda ve içecek. Kapsamı en geniş olan, o yüzden ilk sorgulanan.
  food('world.openfoodfacts.org', 'gıda'),

  /// Temizlik, bebek, kırtasiye — gıda dışı her şey.
  products('world.openproductsfacts.org', 'genel ürün'),

  /// Kozmetik ve kişisel bakım.
  beauty('world.openbeautyfacts.org', 'kozmetik'),

  /// Evcil hayvan maması.
  petFood('world.openpetfoodfacts.org', 'evcil hayvan');

  const OpenFactsDatabase(this.host, this.label);

  final String host;

  /// Kullanıcıya gösterilebilecek kısa ad.
  final String label;
}

/// Barkoddan çözülen ürün bilgisi.
class ProductInfo {
  const ProductInfo({
    required this.barcode,
    required this.name,
    required this.source,
    this.brand = '',
    this.quantity = '',
    this.imageUrl,
    this.categoryHint = '',
  });

  /// Open Food Facts ailesinden gelen `product` nesnesinden okur.
  ///
  /// Türkçe ürün adı varsa onu tercih eder; yoksa genel ada düşer. İki alan da
  /// boşsa ürün adsız sayılır ve [isUsable] false döner. Adsız kayıt sık:
  /// veritabanına barkod girilmiş ama ad henüz doldurulmamış oluyor.
  factory ProductInfo.fromOpenFacts(
    String barcode,
    Map<String, dynamic> json, {
    required OpenFactsDatabase source,
  }) {
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
    final image = pick(['image_front_small_url', 'image_url']);

    return ProductInfo(
      barcode: barcode,
      name: pick(['product_name_tr', 'product_name']),
      source: source,
      brand: firstBrand,
      quantity: pick(['quantity']),
      imageUrl: image.isEmpty ? null : image,
      categoryHint: _categoryFrom(json['categories_tags']),
    );
  }

  /// `categories_tags` en özelden en genele sıralı gelir; ilk etiketi alıp
  /// dil önekini ("en:") atıyoruz.
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

  /// Ürünün hangi veritabanından geldiği. Kategori tahmininde ipucu olarak
  /// kullanılıyor: `beauty` sonucu büyük olasılıkla kişisel bakım.
  final OpenFactsDatabase source;

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
/// Kaynak **Open Food Facts ailesi** — açık veritabanları, API anahtarı
/// gerektirmiyor. Bu tercih bilinçli: uygulama ürün araması için kullanıcıdan
/// anahtar istemek veya bir ödeme geçidi kurmak zorunda kalmıyor.
///
/// Servis, kendi kullanım koşulları gereği tanımlayıcı bir `User-Agent`
/// bekliyor; anonim istekler kısıtlanabiliyor.
///
/// `prefer_initializing_formals` bastırıldı: Dart özel adlı parametreye izin
/// vermiyor, alanlar özel kalmalı.
// ignore_for_file: prefer_initializing_formals
class ProductLookupService {
  ProductLookupService({required Dio dio, String? userAgent})
    : _dio = dio,
      _userAgent = userAgent ?? _defaultUserAgent;

  static const String _defaultUserAgent =
      'SmartList/1.0 (Flutter; https://github.com/ugurhamamci/SmartList)';

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
  /// Sorgu iki aşamalı: önce gıda veritabanı (en yüksek isabet oranı), sonuç
  /// yoksa kalan üçü **paralel** sorgulanır. Böylece en sık durum tek gidiş
  /// dönüşle biterken, nadir durumda da dört ardışık isteğin gecikmesi
  /// yaşanmıyor.
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

    final primary = await _lookupIn(OpenFactsDatabase.food, normalised);
    if (primary != null) {
      return primary;
    }

    final fallbacks = await Future.wait([
      _lookupIn(OpenFactsDatabase.products, normalised),
      _lookupIn(OpenFactsDatabase.beauty, normalised),
      _lookupIn(OpenFactsDatabase.petFood, normalised),
    ]);

    for (final hit in fallbacks) {
      if (hit != null) {
        return hit;
      }
    }
    return null;
  }

  /// Tek bir veritabanını sorgular. Bulunamazsa `null`.
  Future<ProductInfo?> _lookupIn(
    OpenFactsDatabase database,
    String normalisedBarcode,
  ) async {
    final response = await ErrorMapper.guard(
      () => _dio.get<Map<String, dynamic>>(
        'https://${database.host}/api/v2/product/$normalisedBarcode.json',
        queryParameters: {'fields': _fields},
        options: Options(
          headers: {'User-Agent': _userAgent},
          // Bulunamayan ürün 404 dönüyor; bunu istisna olarak değil
          // "sonuç yok" olarak ele almak istiyoruz. Ölçümde asıl ayırt edici
          // durum bu: bir ürün bir veritabanında 200, diğerlerinde 404.
          validateStatus: (status) =>
              status != null && (status == 404 || status < 400),
        ),
      ),
    );

    if (response.statusCode == 404) {
      return null;
    }

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

    final info = ProductInfo.fromOpenFacts(
      normalisedBarcode,
      product,
      source: database,
    );
    // Kayıt var ama adı boş olabiliyor; adsız sonuç kullanıcıya yardım etmez,
    // o yüzden "bulunamadı" sayıp diğer veritabanına bakıyoruz.
    return info.isUsable ? info : null;
  }

  /// Barkodu doğrular ve normalleştirir.
  ///
  /// Tarayıcılar bazen boşluk veya tire ile kod döndürür. Geçerli ürün kodları
  /// 8–14 hane arası rakamdır (EAN-8, UPC-A, EAN-13, ITF-14).
  ///
  /// EAN/UPC uzunluklarında **kontrol hanesi de doğrulanır**: son hane diğer
  /// hanelerden hesaplanan bir sağlama toplamıdır. Yanlış okunmuş bir barkod
  /// bu sınavı geçemez, yani ağa gitmeden eleniyor. Bunu eklemenin nedeni
  /// somut: elle uydurduğum test kodları geçerli görünüyordu ama gerçek bir
  /// barkod servisi onları "INVALID_UPC" ile reddetti.
  static String? normaliseBarcode(String raw) {
    final digits = raw.replaceAll(RegExp('[^0-9]'), '');
    if (digits.length < 8 || digits.length > 14) {
      return null;
    }
    // 9, 10 ve 11 hane standart bir simgelemeye karşılık gelmiyor; sağlama
    // toplamı da tanımlı değil, o yüzden yalnızca uzunluk denetleniyor.
    if (const {8, 12, 13, 14}.contains(digits.length) &&
        !hasValidCheckDigit(digits)) {
      return null;
    }
    return digits;
  }

  /// GS1 sağlama toplamı (EAN-8, UPC-A, EAN-13, ITF-14 için aynı kural).
  ///
  /// Sağdan sola ağırlıklar 3, 1, 3, 1… şeklinde uygulanır; toplamın 10'a
  /// tamamlayanı kontrol hanesine eşit olmalıdır.
  static bool hasValidCheckDigit(String digits) {
    if (digits.length < 2) {
      return false;
    }
    final body = digits.substring(0, digits.length - 1);
    final expected = int.parse(digits[digits.length - 1]);

    var sum = 0;
    for (var i = 0; i < body.length; i++) {
      // En sağdaki gövde hanesi 3 ağırlıklı; oradan sola doğru dönüşümlü.
      final weight = (body.length - 1 - i).isEven ? 3 : 1;
      sum += int.parse(body[i]) * weight;
    }

    return (10 - (sum % 10)) % 10 == expected;
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

  /// Barkodun kuruluş önekinden Türkiye ürünü olup olmadığını söyler.
  ///
  /// GS1 Türkiye'ye 868–869 aralığı ayrılmıştır. Bilgi kullanıcıya
  /// gösterilmiyor; veritabanında bulunamayan Türk ürünlerinde "bu ürün henüz
  /// veritabanında yok, adını siz yazın" mesajını doğru bağlamda vermek için
  /// kullanılıyor.
  static bool isTurkishPrefix(String raw) {
    final digits = normaliseBarcode(raw);
    if (digits == null || digits.length < 3) {
      return false;
    }
    final prefix = int.tryParse(digits.substring(0, 3));
    return prefix != null && prefix >= 868 && prefix <= 869;
  }
}
