import 'package:smartlist/models/enums.dart';

/// Sesli cümleden çıkarılan tek ürün.
class VoiceItem {
  const VoiceItem({
    required this.name,
    required this.quantity,
    required this.unit,
    required this.sourcePhrase,
  });

  final String name;
  final double quantity;
  final MeasurementUnit unit;

  /// Bu ürünün türetildiği cümle parçası. Kullanıcı sonucu düzeltmek isterse
  /// neyin nereden geldiğini gösterebilmek için tutuluyor.
  final String sourcePhrase;

  /// "2 Litre" gibi okunabilir miktar etiketi.
  String get quantityLabel {
    final amount = quantity == quantity.roundToDouble()
        ? quantity.round().toString()
        : quantity.toString();
    return '$amount ${unit.wire}';
  }
}

/// Türkçe konuşmadan ürün listesi çıkarır.
///
/// Konuşma tanıma tek bir uzun metin döndürüyor: *"iki litre süt üç ekmek ve
/// yarım kilo domates al"*. Bu sınıf o metni ürünlere böler, miktar ve birimi
/// ayıklar.
///
/// Ayrıştırma kural tabanlı, yapay zekâ kullanmıyor. Bilinçli bir tercih:
/// ürün ekleme her gün onlarca kez yapılan bir işlem, her seferinde ağ isteği
/// ve token maliyeti anlamsız. Kurallar yetmediğinde kullanıcı sonucu ekranda
/// düzeltiyor; yapay zekâ katmanı liste üretimi gibi gerçekten belirsiz işler
/// için duruyor.
class VoiceParser {
  const VoiceParser();

  /// Türkçe sayı sözcükleri. Konuşma tanıma bazen "2", bazen "iki" döndürüyor.
  static const Map<String, double> _numberWords = {
    'yarım': 0.5,
    'buçuk': 0.5,
    'bir': 1,
    'iki': 2,
    'üç': 3,
    'dört': 4,
    'beş': 5,
    'altı': 6,
    'yedi': 7,
    'sekiz': 8,
    'dokuz': 9,
    'on': 10,
    'onbir': 11,
    'oniki': 12,
    'yirmi': 20,
    'otuz': 30,
    'kırk': 40,
    'elli': 50,
    'yüz': 100,
    'düzine': 12,
  };

  /// Birim sözcükleri ve ekleri. Konuşmada "kilo", "kg", "kilogram" hepsi
  /// geçiyor; hepsi aynı birime bağlanıyor.
  static const Map<String, MeasurementUnit> _unitWords = {
    'kilo': MeasurementUnit.kilogram,
    'kilogram': MeasurementUnit.kilogram,
    'kg': MeasurementUnit.kilogram,
    'gram': MeasurementUnit.gram,
    'gr': MeasurementUnit.gram,
    'g': MeasurementUnit.gram,
    'litre': MeasurementUnit.liter,
    'lt': MeasurementUnit.liter,
    'l': MeasurementUnit.liter,
    'mililitre': MeasurementUnit.milliliter,
    'ml': MeasurementUnit.milliliter,
    'paket': MeasurementUnit.pack,
    'kutu': MeasurementUnit.box,
    'şişe': MeasurementUnit.bottle,
    'teneke': MeasurementUnit.can,
    'poşet': MeasurementUnit.bag,
    'demet': MeasurementUnit.bunch,
    'bağ': MeasurementUnit.bunch,
    'düzine': MeasurementUnit.dozen,
    'adet': MeasurementUnit.piece,
    'tane': MeasurementUnit.piece,
  };

  /// Ürünleri birbirinden ayıran sözcükler.
  static const Set<String> _separators = {'ve', 'ayrıca', 'birde', 'artı'};

  /// Ondalık ayırıcıyı cümle ayırıcısından korumak için kullanılan geçici
  /// işaret. Konuşma metninde geçemeyecek bir denetim karakteri seçildi.
  static const String _decimalMark = '';

  /// Cümlenin sonuna eklenen ve ürün adı olmayan sözcükler.
  ///
  /// "süt al" dendiğinde ürün "süt", "al" değil. Bu liste olmadan her cümlenin
  /// sonunda hayali bir ürün oluşuyor.
  static const Set<String> _fillerWords = {
    'al',
    'alalım',
    'alır',
    'alırız',
    'ekle',
    'ekler',
    'ekleyelim',
    'ekleyebilir',
    'listeye',
    'lütfen',
    'bana',
    'bize',
    'da',
    'de',
    'ile',
    'için',
    'tamam',
    'olsun',
    'gerek',
    'gerekiyor',
    'lazım',
    'unutma',
    'unutmayalım',
  };

  /// [transcript] içindeki ürünleri çıkarır. Anlamlı bir şey bulunamazsa boş
  /// liste döner.
  List<VoiceItem> parse(String transcript) {
    final normalised = transcript.toLowerCase().trim();
    if (normalised.isEmpty) {
      return const [];
    }

    // Ondalık ayırıcıyı geçici bir işaretle koruyoruz. Noktalama cümle
    // ayırıcısı sayıldığı için, önlem alınmazsa "1,5 kg soğan" ikiye bölünüp
    // miktar 5 olarak okunuyor.
    final guarded = normalised.replaceAllMapped(
      RegExp(r'(\d)\s?[.,]\s?(\d)'),
      (match) => '${match[1]}$_decimalMark${match[2]}',
    );

    // Noktalama ayırıcı sayılıyor: "süt, ekmek, yumurta" tek nefeste
    // söylendiğinde de üç ürün çıkması gerekiyor.
    final chunks = guarded
        .split(RegExp(r'[,;.!?\n]+'))
        .expand(_splitOnSeparators)
        .map((chunk) => chunk.replaceAll(_decimalMark, '.').trim())
        .where((chunk) => chunk.isNotEmpty);

    final items = <VoiceItem>[];
    for (final chunk in chunks) {
      final item = _parseChunk(chunk);
      if (item != null) {
        items.add(item);
      }
    }
    return items;
  }

  /// "süt ve ekmek" → ["süt", "ekmek"].
  Iterable<String> _splitOnSeparators(String chunk) {
    final words = chunk.split(RegExp(r'\s+'));
    final parts = <String>[];
    var current = <String>[];

    for (final word in words) {
      if (_separators.contains(word)) {
        if (current.isNotEmpty) {
          parts.add(current.join(' '));
          current = <String>[];
        }
        continue;
      }
      current.add(word);
    }
    if (current.isNotEmpty) {
      parts.add(current.join(' '));
    }
    return parts;
  }

  VoiceItem? _parseChunk(String chunk) {
    final words = chunk.split(RegExp(r'\s+')).where((w) => w.isNotEmpty);

    double? amount;
    MeasurementUnit? unit;
    final nameWords = <String>[];

    for (final word in words) {
      final cleaned = word.replaceAll(RegExp("[^0-9a-zçğıöşü',.]"), '');
      if (cleaned.isEmpty) {
        continue;
      }

      // 1) Rakam mı? ("2", "1,5", "1.5")
      final numeric = double.tryParse(cleaned.replaceAll(',', '.'));
      if (numeric != null) {
        // "iki buçuk" gibi durumda ikinci sayı ilkine eklenir.
        amount = amount == null ? numeric : amount + numeric;
        continue;
      }

      // 2) Sayı sözcüğü mü? ("iki", "yarım", "buçuk")
      final asWord = _numberWords[cleaned];
      if (asWord != null) {
        // "buçuk" tek başına 0.5 değil, önceki sayıya eklenen yarımdır:
        // "iki buçuk kilo" → 2.5.
        amount = amount == null ? asWord : amount + asWord;
        // "düzine" hem sayı hem birim; birim olarak da işaretliyoruz.
        if (cleaned == 'düzine') {
          unit ??= MeasurementUnit.dozen;
        }
        continue;
      }

      // 3) Birim mi? ("kilo", "litre", "paket")
      final asUnit = _unitWords[cleaned];
      if (asUnit != null) {
        unit ??= asUnit;
        continue;
      }

      // 4) Dolgu sözcüğü mü? ("al", "listeye", "lütfen")
      if (_fillerWords.contains(cleaned)) {
        continue;
      }

      // 5) Geri kalanı ürün adı.
      nameWords.add(cleaned);
    }

    if (nameWords.isEmpty) {
      return null;
    }

    // "15'li paket" gibi eklerden arta kalan kesme işaretini temizliyoruz.
    final name = nameWords
        .map((word) => word.replaceAll(RegExp(r"^'|'$"), ''))
        .where((word) => word.isNotEmpty)
        .join(' ');

    if (name.isEmpty) {
      return null;
    }

    return VoiceItem(
      name: _capitalise(name),
      // Miktar söylenmediyse 1 adet varsayılıyor; kullanıcı listede
      // değiştirebiliyor.
      quantity: amount ?? 1,
      unit: unit ?? MeasurementUnit.piece,
      sourcePhrase: chunk,
    );
  }

  /// Ürün adının ilk harfini büyütür; listede tutarlı görünsün.
  ///
  /// Türkçe'ye özgü ayrıntı: "ı" harfinin büyüğü "I" değil, "İ" değil — 'i'
  /// büyürken "İ" olur. Dart'ın `toUpperCase()` bunu doğru yapmadığı için
  /// el ile eşliyoruz.
  String _capitalise(String value) {
    if (value.isEmpty) {
      return value;
    }
    final first = value[0];
    final upper = switch (first) {
      'i' => 'İ',
      'ı' => 'I',
      _ => first.toUpperCase(),
    };
    return upper + value.substring(1);
  }
}
