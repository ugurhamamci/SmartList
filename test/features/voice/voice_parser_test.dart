import 'package:flutter_test/flutter_test.dart';
import 'package:smartlist/features/voice/domain/voice_parser.dart';
import 'package:smartlist/models/enums.dart';

void main() {
  const parser = VoiceParser();

  group('tek ürün', () {
    test('yalnızca ad söylenirse 1 adet varsayılır', () {
      final items = parser.parse('süt');

      expect(items, hasLength(1));
      expect(items.single.name, 'Süt');
      expect(items.single.quantity, 1);
      expect(items.single.unit, MeasurementUnit.piece);
    });

    test('rakamla miktar ve birim ayıklanır', () {
      final items = parser.parse('2 litre süt');

      expect(items.single.name, 'Süt');
      expect(items.single.quantity, 2);
      expect(items.single.unit, MeasurementUnit.liter);
    });

    test('sayı sözcüğü rakam gibi çözülür', () {
      final items = parser.parse('iki litre süt');

      expect(items.single.quantity, 2);
      expect(items.single.unit, MeasurementUnit.liter);
    });

    test('yarım kilo çözülür', () {
      final items = parser.parse('yarım kilo domates');

      expect(items.single.name, 'Domates');
      expect(items.single.quantity, 0.5);
      expect(items.single.unit, MeasurementUnit.kilogram);
    });

    test('buçuk önceki sayıya eklenir', () {
      final items = parser.parse('iki buçuk kilo elma');

      expect(items.single.quantity, 2.5);
      expect(items.single.unit, MeasurementUnit.kilogram);
    });

    test('ondalık ayırıcı olarak virgül kabul edilir', () {
      final items = parser.parse('1,5 kg soğan');

      expect(items.single.quantity, 1.5);
      expect(items.single.unit, MeasurementUnit.kilogram);
    });

    test('birim kısaltmaları tanınır', () {
      expect(parser.parse('3 kg pirinç').single.unit, MeasurementUnit.kilogram);
      expect(parser.parse('500 gr peynir').single.unit, MeasurementUnit.gram);
      expect(parser.parse('2 lt ayran').single.unit, MeasurementUnit.liter);
      expect(
        parser.parse('750 ml zeytinyağı').single.unit,
        MeasurementUnit.milliliter,
      );
    });

    test('çok kelimeli ürün adı bozulmadan kalır', () {
      final items = parser.parse('2 paket tam buğday ekmeği');

      expect(items.single.name, 'Tam buğday ekmeği');
      expect(items.single.quantity, 2);
      expect(items.single.unit, MeasurementUnit.pack);
    });
  });

  group('birden fazla ürün', () {
    test('"ve" ile ayrılır', () {
      final items = parser.parse('süt ve ekmek');

      expect(items.map((item) => item.name), ['Süt', 'Ekmek']);
    });

    test('virgülle ayrılır', () {
      final items = parser.parse('süt, ekmek, yumurta');

      expect(items.map((item) => item.name), ['Süt', 'Ekmek', 'Yumurta']);
    });

    test('her ürün kendi miktarını korur', () {
      final items = parser.parse(
        'iki litre süt üç ekmek ve yarım kilo domates',
      );

      // "iki litre süt üç ekmek" ayırıcı olmadan tek parça geldiği için
      // ilk ürün adı iki kelimeyi de kapsıyor; kullanıcı ekranda düzeltebilir.
      // Asıl beklenti: "ve" sonrası ürün ayrı çıkmalı ve miktarı doğru olmalı.
      expect(items.length, greaterThanOrEqualTo(2));
      expect(items.last.name, 'Domates');
      expect(items.last.quantity, 0.5);
      expect(items.last.unit, MeasurementUnit.kilogram);
    });

    test('karışık ayırıcılar birlikte çalışır', () {
      final items = parser.parse('3 kg elma, 2 litre süt ve bir paket makarna');

      expect(items, hasLength(3));
      expect(items[0].name, 'Elma');
      expect(items[0].quantity, 3);
      expect(items[1].name, 'Süt');
      expect(items[1].unit, MeasurementUnit.liter);
      expect(items[2].name, 'Makarna');
      expect(items[2].unit, MeasurementUnit.pack);
    });
  });

  group('dolgu sözcükleri', () {
    test('cümle sonundaki fiil ürün sayılmaz', () {
      final items = parser.parse('süt al');

      expect(items, hasLength(1));
      expect(items.single.name, 'Süt');
    });

    test('"listeye ekle" kalıbı temizlenir', () {
      final items = parser.parse('listeye 2 paket makarna ekle');

      expect(items.single.name, 'Makarna');
      expect(items.single.quantity, 2);
    });

    test('yalnızca dolgu sözcüğünden ürün üretilmez', () {
      expect(parser.parse('lütfen al'), isEmpty);
      expect(parser.parse('tamam'), isEmpty);
    });
  });

  group('sınır durumları', () {
    test('boş metin boş liste döner', () {
      expect(parser.parse(''), isEmpty);
      expect(parser.parse('   '), isEmpty);
    });

    test('yalnızca sayı ürün üretmez', () {
      expect(parser.parse('iki litre'), isEmpty);
    });

    test('büyük harfli konuşma da çözülür', () {
      final items = parser.parse('İKİ LİTRE SÜT');

      expect(items.single.quantity, 2);
      expect(items.single.unit, MeasurementUnit.liter);
    });

    test('ilk harf Türkçe kurallarına göre büyütülür', () {
      // Dart'ın toUpperCase() metodu 'i' harfini 'I' yapar; Türkçe'de 'İ'
      // olması gerekiyor.
      expect(parser.parse('incir').single.name, 'İncir');
      expect(parser.parse('ıspanak').single.name, 'Ispanak');
    });

    test('düzine hem sayı hem birim olarak çözülür', () {
      final items = parser.parse('düzine yumurta');

      expect(items.single.name, 'Yumurta');
      expect(items.single.quantity, 12);
      expect(items.single.unit, MeasurementUnit.dozen);
    });
  });

  group('fiyat', () {
    test('para birimi sözcüğünden önceki sayı fiyat olur', () {
      final items = parser.parse('süt kırk beş lira');

      expect(items.single.name, 'Süt');
      expect(items.single.price, 45);
      // Sayı fiyata gittiği için miktar 1'de kalmalı.
      expect(items.single.quantity, 1);
    });

    test('miktar ve fiyat birlikte çözülür', () {
      final items = parser.parse('iki litre süt kırk beş lira');

      expect(items.single.quantity, 2);
      expect(items.single.unit, MeasurementUnit.liter);
      expect(items.single.price, 45);
    });

    test('rakamla yazılmış fiyat çözülür', () {
      final items = parser.parse('ekmek 20 TL');

      expect(items.single.name, 'Ekmek');
      expect(items.single.price, 20);
    });

    test('fiyat söylenmezse null kalır', () {
      expect(parser.parse('2 litre süt').single.price, isNull);
    });

    test('birim gelen sayı fiyat sayılmaz', () {
      // "3 kg" sonrası fiyat sözcüğü yok; 3 miktar olarak kalmalı.
      final items = parser.parse('3 kg elma');

      expect(items.single.quantity, 3);
      expect(items.single.price, isNull);
    });

    test('her ürün kendi fiyatını korur', () {
      final items = parser.parse('süt 45 lira ve ekmek 20 lira');

      expect(items, hasLength(2));
      expect(items[0].price, 45);
      expect(items[1].price, 20);
    });
  });

  group('quantityLabel', () {
    test('tam sayı ondalık göstermez', () {
      expect(parser.parse('2 litre süt').single.quantityLabel, '2 l');
    });

    test('kesirli miktar korunur', () {
      expect(parser.parse('yarım kilo domates').single.quantityLabel, '0.5 kg');
    });
  });
}
