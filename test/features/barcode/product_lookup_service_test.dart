import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartlist/core/errors/app_exception.dart';
import 'package:smartlist/features/barcode/data/product_lookup_service.dart';
import 'package:smartlist/models/enums.dart';

/// Ağ yerine hazır yanıt döner; böylece Open Food Facts'in gerçek yanıt
/// biçimini ayrıştırma davranışı ağ olmadan doğrulanabilir.
class _StubAdapter implements HttpClientAdapter {
  _StubAdapter({required this.statusCode, required this.body});

  final int statusCode;
  final Object body;

  RequestOptions? lastRequest;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastRequest = options;
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

/// Nutella için servisin gerçekte döndürdüğü alanların kısaltılmış hâli.
const Map<String, Object> _nutellaPayload = {
  'code': '3017620422003',
  'status': 1,
  'status_verbose': 'product found',
  'product': {
    'code': '3017620422003',
    'product_name': 'Nutella',
    'brands': 'Nutella, Ferrero, Yum yum',
    'quantity': '400 g',
    'categories_tags': ['en:breakfasts', 'en:spreads'],
    'image_front_small_url': 'https://images.openfoodfacts.org/front_small.jpg',
  },
};

void main() {
  group('normaliseBarcode', () {
    test('rakam olmayan karakterleri atar', () {
      expect(
        ProductLookupService.normaliseBarcode(' 3017-6204 22003 '),
        '3017620422003',
      );
    });

    test('8 haneden kısa veya 14 haneden uzun kodu reddeder', () {
      expect(ProductLookupService.normaliseBarcode('1234567'), isNull);
      expect(ProductLookupService.normaliseBarcode('123456789012345'), isNull);
    });

    test('sınır uzunlukları kabul eder', () {
      expect(ProductLookupService.normaliseBarcode('12345678'), '12345678');
      expect(
        ProductLookupService.normaliseBarcode('12345678901234'),
        '12345678901234',
      );
    });
  });

  group('symbologyOf', () {
    test('hane sayısına göre türü belirler', () {
      expect(
        ProductLookupService.symbologyOf('3017620422003'),
        BarcodeSymbology.ean13,
      );
      expect(
        ProductLookupService.symbologyOf('012345678905'),
        BarcodeSymbology.upcA,
      );
      expect(
        ProductLookupService.symbologyOf('96385074'),
        BarcodeSymbology.ean8,
      );
      expect(
        ProductLookupService.symbologyOf('12345678901234'),
        BarcodeSymbology.itf,
      );
    });

    test('978/979 ile başlayan 13 haneli kod ISBN sayılır', () {
      expect(
        ProductLookupService.symbologyOf('9780306406157'),
        BarcodeSymbology.isbn,
      );
      expect(
        ProductLookupService.symbologyOf('9791234567896'),
        BarcodeSymbology.isbn,
      );
    });

    test('geçersiz kodda unknown döner', () {
      expect(
        ProductLookupService.symbologyOf('abc'),
        BarcodeSymbology.unknown,
      );
    });
  });

  group('ProductInfo.fromOpenFoodFacts', () {
    test('ilk markayı alır ve adın başına ekler', () {
      final info = ProductInfo.fromOpenFoodFacts(
        '3017620422003',
        Map<String, dynamic>.from(_nutellaPayload['product']! as Map),
      );

      expect(info.brand, 'Nutella');
      expect(info.quantity, '400 g');
      expect(info.categoryHint, 'breakfasts');
      expect(info.imageUrl, isNotNull);
      // Ad zaten markayı içeriyor; iki kez yazılmamalı.
      expect(info.displayName, 'Nutella');
      expect(info.isUsable, isTrue);
    });

    test('marka adın içinde yoksa başa eklenir', () {
      final info = ProductInfo.fromOpenFoodFacts('12345678', const {
        'product_name': 'Kakaolu Fındık Kreması',
        'brands': 'Ferrero',
      });

      expect(info.displayName, 'Ferrero Kakaolu Fındık Kreması');
    });

    test('Türkçe ad varsa tercih edilir', () {
      final info = ProductInfo.fromOpenFoodFacts('12345678', const {
        'product_name': 'Hazelnut spread',
        'product_name_tr': 'Fındık kreması',
      });

      expect(info.name, 'Fındık kreması');
    });

    test('adı olmayan ürün kullanılamaz sayılır', () {
      final info = ProductInfo.fromOpenFoodFacts('12345678', const {
        'brands': 'Ferrero',
      });

      expect(info.isUsable, isFalse);
    });
  });

  group('lookup', () {
    test('bulunan ürünü çözer ve yalnızca gerekli alanları ister', () async {
      final adapter = _StubAdapter(statusCode: 200, body: _nutellaPayload);
      final info = await _serviceWith(adapter).lookup('3017620422003');

      expect(info, isNotNull);
      expect(info!.displayName, 'Nutella');
      expect(info.barcode, '3017620422003');

      final request = adapter.lastRequest!;
      expect(request.path, endsWith('/3017620422003.json'));
      expect(request.queryParameters['fields'], contains('product_name_tr'));
      // Servisin kullanım koşulu tanımlayıcı bir User-Agent bekliyor.
      expect(request.headers['User-Agent'], contains('SmartList'));
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
      ).lookup('1234567890123');

      expect(info, isNull);
    });

    test('status metin olarak gelse de ürünü çözer', () async {
      final info = await _serviceWith(
        _StubAdapter(
          statusCode: 200,
          body: {
            'status': '1',
            'product': {'product_name': 'Süt'},
          },
        ),
      ).lookup('12345678');

      expect(info?.name, 'Süt');
    });

    test('adsız ürün null döner', () async {
      final info = await _serviceWith(
        _StubAdapter(
          statusCode: 200,
          body: const {
            'status': 1,
            'product': {'brands': 'Ferrero'},
          },
        ),
      ).lookup('12345678');

      expect(info, isNull);
    });

    test('geçersiz barkod ağa gitmeden reddedilir', () async {
      final adapter = _StubAdapter(statusCode: 200, body: _nutellaPayload);

      await expectLater(
        _serviceWith(adapter).lookup('12'),
        throwsA(isA<ValidationException>()),
      );
      expect(adapter.lastRequest, isNull);
    });

    test('sunucu hatası AppException olarak yüzeye çıkar', () async {
      await expectLater(
        _serviceWith(
          _StubAdapter(statusCode: 500, body: const {'error': 'boom'}),
        ).lookup('3017620422003'),
        throwsA(isA<AppException>()),
      );
    });
  });
}
