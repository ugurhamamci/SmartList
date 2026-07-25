import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartlist/core/errors/app_exception.dart';
import 'package:smartlist/features/barcode/data/product_lookup_service.dart';
import 'package:smartlist/models/enums.dart';

/// Ağ yerine hazır yanıt döner; böylece Open Food Facts ailesinin gerçek yanıt
/// biçimini ayrıştırma davranışı ağ olmadan doğrulanabilir.
///
/// Yanıt **sunucuya göre** verilebiliyor: servisin "ürün gıda veritabanında
/// yok, genel ürün veritabanında var" durumunu doğru ele aldığını sınamanın
/// tek yolu bu.
class _StubAdapter implements HttpClientAdapter {
  _StubAdapter({required this.statusCode, required this.body})
    : perHost = const {};

  /// Her sunucu için ayrı yanıt. Listelenmeyen sunucu 404 döner.
  _StubAdapter.perHost(this.perHost) : statusCode = 404, body = const {};

  final int statusCode;
  final Object body;
  final Map<String, Object> perHost;

  final List<RequestOptions> requests = [];

  RequestOptions? get lastRequest => requests.isEmpty ? null : requests.last;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);

    if (perHost.isNotEmpty) {
      final match = perHost[options.uri.host];
      return ResponseBody.fromString(
        jsonEncode(match ?? const {'status': 0}),
        match == null ? 404 : 200,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      );
    }

    return ResponseBody.fromString(
      jsonEncode(body),
      statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

ProductLookupService _serviceWith(_StubAdapter adapter) {
  final dio = Dio()..httpClientAdapter = adapter;
  return ProductLookupService(dio: dio);
}

// Aşağıdaki barkodların tamamı GERÇEK ve kontrol hanesi geçerli. Uydurma kod
// kullanmak yanıltıcıydı: geçerli görünüyorlardı ama sağlama toplamı yanlıştı
// ve gerçek bir barkod servisi onları reddetti.
const _nutella = '3017620422003'; // EAN-13, gıda veritabanında
const _beypazari = '8691381000486'; // EAN-13, Türk ürünü, gıda
const _uniBaby = '8690530031012'; // EAN-13, Türk ürünü, genel ürün veritabanı
const _niveaSun = '4005900253668'; // EAN-13, kozmetik veritabanı
const _validEan8 = '96385074';
const _validUpcA = '012345678905';
const _validItf14 = '12345678901231';
const _validIsbn = '9780306406157';

/// Nutella için servisin gerçekte döndürdüğü alanların kısaltılmış hâli.
const Map<String, Object> _nutellaPayload = {
  'code': _nutella,
  'status': 1,
  'status_verbose': 'product found',
  'product': {
    'code': _nutella,
    'product_name': 'Nutella',
    'brands': 'Nutella, Ferrero, Yum yum',
    'quantity': '400 g',
    'categories_tags': ['en:breakfasts', 'en:spreads'],
    'image_front_small_url': 'https://images.openfoodfacts.org/front_small.jpg',
  },
};

void main() {
  group('kontrol hanesi', () {
    test('gerçek barkodlar geçerli sayılır', () {
      for (final code in [
        _nutella,
        _beypazari,
        _uniBaby,
        _niveaSun,
        _validEan8,
        _validUpcA,
        _validItf14,
        _validIsbn,
      ]) {
        expect(
          ProductLookupService.hasValidCheckDigit(code),
          isTrue,
          reason: '$code geçerli olmalı',
        );
      }
    });

    test('son hanesi bozulmuş kod reddedilir', () {
      // Nutella barkodunun yalnızca kontrol hanesi değiştirildi.
      expect(ProductLookupService.hasValidCheckDigit('3017620422004'), isFalse);
      expect(ProductLookupService.normaliseBarcode('3017620422004'), isNull);
    });

    test('hane sırası bozulmuş kod reddedilir', () {
      // Ortadaki iki hane yer değiştirdi; yanlış okuma bu biçimde oluyor.
      expect(ProductLookupService.hasValidCheckDigit('3017624022003'), isFalse);
    });
  });

  group('normaliseBarcode', () {
    test('rakam olmayan karakterleri atar', () {
      expect(
        ProductLookupService.normaliseBarcode(' 3017-6204 22003 '),
        _nutella,
      );
    });

    test('8 haneden kısa veya 14 haneden uzun kodu reddeder', () {
      expect(ProductLookupService.normaliseBarcode('1234567'), isNull);
      expect(ProductLookupService.normaliseBarcode('123456789012345'), isNull);
    });

    test('sınır uzunluklarını kabul eder', () {
      expect(ProductLookupService.normaliseBarcode(_validEan8), _validEan8);
      expect(ProductLookupService.normaliseBarcode(_validItf14), _validItf14);
    });

    test('sağlama toplamı tanımsız uzunlukta yalnızca uzunluk denetlenir', () {
      // 9, 10 ve 11 hane standart bir simgelemeye karşılık gelmiyor.
      expect(ProductLookupService.normaliseBarcode('123456789'), '123456789');
    });
  });

  group('symbologyOf', () {
    test('hane sayısına göre türü belirler', () {
      expect(
        ProductLookupService.symbologyOf(_nutella),
        BarcodeSymbology.ean13,
      );
      expect(
        ProductLookupService.symbologyOf(_validUpcA),
        BarcodeSymbology.upcA,
      );
      expect(
        ProductLookupService.symbologyOf(_validEan8),
        BarcodeSymbology.ean8,
      );
      expect(
        ProductLookupService.symbologyOf(_validItf14),
        BarcodeSymbology.itf,
      );
    });

    test('978/979 ile başlayan 13 haneli kod ISBN sayılır', () {
      expect(
        ProductLookupService.symbologyOf(_validIsbn),
        BarcodeSymbology.isbn,
      );
    });

    test('geçersiz kodda unknown döner', () {
      expect(ProductLookupService.symbologyOf('abc'), BarcodeSymbology.unknown);
    });
  });

  group('isTurkishPrefix', () {
    test('868–869 aralığı Türkiye ürünü sayılır', () {
      expect(ProductLookupService.isTurkishPrefix(_beypazari), isTrue);
      expect(ProductLookupService.isTurkishPrefix(_uniBaby), isTrue);
    });

    test('diğer önekler Türkiye ürünü sayılmaz', () {
      expect(ProductLookupService.isTurkishPrefix(_nutella), isFalse);
      expect(ProductLookupService.isTurkishPrefix(_niveaSun), isFalse);
    });
  });

  group('ProductInfo.fromOpenFacts', () {
    test('ilk markayı alır ve adın başına ekler', () {
      final info = ProductInfo.fromOpenFacts(
        _nutella,
        Map<String, dynamic>.from(_nutellaPayload['product']! as Map),
        source: OpenFactsDatabase.food,
      );

      expect(info.brand, 'Nutella');
      expect(info.quantity, '400 g');
      expect(info.categoryHint, 'breakfasts');
      expect(info.imageUrl, isNotNull);
      // Ad zaten markayı içeriyor; iki kez yazılmamalı.
      expect(info.displayName, 'Nutella');
      expect(info.isUsable, isTrue);
      expect(info.source, OpenFactsDatabase.food);
    });

    test('marka adın içinde yoksa başa eklenir', () {
      final info = ProductInfo.fromOpenFacts(
        _validEan8,
        const {'product_name': 'Kakaolu Fındık Kreması', 'brands': 'Ferrero'},
        source: OpenFactsDatabase.food,
      );

      expect(info.displayName, 'Ferrero Kakaolu Fındık Kreması');
    });

    test('Türkçe ad varsa tercih edilir', () {
      final info = ProductInfo.fromOpenFacts(
        _validEan8,
        const {
          'product_name': 'Hazelnut spread',
          'product_name_tr': 'Fındık kreması',
        },
        source: OpenFactsDatabase.food,
      );

      expect(info.name, 'Fındık kreması');
    });

    test('adı olmayan ürün kullanılamaz sayılır', () {
      final info = ProductInfo.fromOpenFacts(
        _validEan8,
        const {'brands': 'Ferrero'},
        source: OpenFactsDatabase.food,
      );

      expect(info.isUsable, isFalse);
    });
  });

  group('lookup', () {
    test('gıda veritabanında bulunursa başka sunucuya gidilmez', () async {
      final adapter = _StubAdapter(statusCode: 200, body: _nutellaPayload);
      final info = await _serviceWith(adapter).lookup(_nutella);

      expect(info, isNotNull);
      expect(info!.displayName, 'Nutella');
      expect(info.barcode, _nutella);
      expect(info.source, OpenFactsDatabase.food);

      // Tek istek: ilk isabette kalan üç veritabanı sorgulanmıyor.
      expect(adapter.requests, hasLength(1));

      final request = adapter.lastRequest!;
      expect(request.uri.host, OpenFactsDatabase.food.host);
      expect(request.path, endsWith('/$_nutella.json'));
      expect(request.queryParameters['fields'], contains('product_name_tr'));
      // Servisin kullanım koşulu tanımlayıcı bir User-Agent bekliyor.
      expect(request.headers['User-Agent'], contains('SmartList'));
    });

    test('gıdada yoksa genel ürün veritabanında bulunur', () async {
      // Gerçek durum: Uni Baby yalnızca Open Products Facts'te var.
      final adapter = _StubAdapter.perHost({
        OpenFactsDatabase.products.host: const {
          'status': 1,
          'product': {'product_name': 'Uni Baby', 'brands': 'Uni Baby'},
        },
      });

      final info = await _serviceWith(adapter).lookup(_uniBaby);

      expect(info, isNotNull);
      expect(info!.name, 'Uni Baby');
      expect(info.source, OpenFactsDatabase.products);
      // Gıda + kalan üç veritabanı = 4 istek.
      expect(adapter.requests, hasLength(4));
    });

    test('gıdada yoksa kozmetik veritabanında bulunur', () async {
      final adapter = _StubAdapter.perHost({
        OpenFactsDatabase.beauty.host: const {
          'status': 1,
          'product': {
            'product_name_tr': 'NIVEA SUN Güneş Spreyi',
            'brands': 'Nivea Sun',
            'quantity': '200 ml',
          },
        },
      });

      final info = await _serviceWith(adapter).lookup(_niveaSun);

      expect(info?.source, OpenFactsDatabase.beauty);
      expect(info?.quantity, '200 ml');
    });

    test('hiçbir veritabanında yoksa null döner', () async {
      final adapter = _StubAdapter.perHost(const {});
      final info = await _serviceWith(adapter).lookup(_beypazari);

      expect(info, isNull);
      expect(adapter.requests, hasLength(4));
    });

    test('status 0 ise null döner', () async {
      final info = await _serviceWith(
        _StubAdapter(
          statusCode: 200,
          body: const {'status': 0, 'status_verbose': 'product not found'},
        ),
      ).lookup('0000000000000');

      expect(info, isNull);
    });

    test('404 hata değildir, sonuç yok demektir', () async {
      final info = await _serviceWith(
        _StubAdapter(statusCode: 404, body: const {'status': 0}),
      ).lookup(_nutella);

      expect(info, isNull);
    });

    test('status metin olarak gelse de ürünü çözer', () async {
      final info = await _serviceWith(
        _StubAdapter(
          statusCode: 200,
          body: const {
            'status': '1',
            'product': {'product_name': 'Süt'},
          },
        ),
      ).lookup(_validEan8);

      expect(info?.name, 'Süt');
    });

    test('adsız kayıt bulunmamış sayılır', () async {
      // Veritabanında barkod var ama adı doldurulmamış; kullanıcıya yardımı
      // olmadığı için diğer veritabanlarına bakılıyor ve sonuçta null dönüyor.
      final adapter = _StubAdapter(
        statusCode: 200,
        body: const {
          'status': 1,
          'product': {'brands': 'Ferrero'},
        },
      );

      expect(await _serviceWith(adapter).lookup(_validEan8), isNull);
      expect(adapter.requests, hasLength(4));
    });

    test('geçersiz barkod ağa gitmeden reddedilir', () async {
      final adapter = _StubAdapter(statusCode: 200, body: _nutellaPayload);

      await expectLater(
        _serviceWith(adapter).lookup('12'),
        throwsA(isA<ValidationException>()),
      );
      expect(adapter.requests, isEmpty);
    });

    test('kontrol hanesi bozuk barkod ağa gitmeden reddedilir', () async {
      final adapter = _StubAdapter(statusCode: 200, body: _nutellaPayload);

      await expectLater(
        _serviceWith(adapter).lookup('3017620422004'),
        throwsA(isA<ValidationException>()),
      );
      expect(adapter.requests, isEmpty);
    });

    test('sunucu hatası AppException olarak yüzeye çıkar', () async {
      await expectLater(
        _serviceWith(
          _StubAdapter(statusCode: 500, body: const {'error': 'boom'}),
        ).lookup(_nutella),
        throwsA(isA<AppException>()),
      );
    });
  });
}
