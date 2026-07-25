import 'dart:async';

import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

/// Konuşma tanımanın anlık durumu.
enum SpeechPhase {
  /// Henüz izin istenmedi veya motor hazır değil.
  idle,

  /// Mikrofon açık, konuşma bekleniyor.
  listening,

  /// Dinleme bitti, sonuç elde.
  done,

  /// İzin verilmedi veya cihaz desteklemiyor.
  unavailable,

  /// Motor hata bildirdi.
  failed,
}

/// Konuşma tanıma oturumunun durumu.
class SpeechState {
  const SpeechState({
    this.phase = SpeechPhase.idle,
    this.transcript = '',
    this.isFinal = false,
    this.confidence = 0,
    this.soundLevel = 0,
    this.errorMessage,
  });

  final SpeechPhase phase;

  /// O ana kadar tanınan metin. Dinleme sürerken de güncellenir, böylece
  /// kullanıcı söylediklerini ekranda görür.
  final String transcript;

  /// Motorun bu metni kesinleşmiş sayıp saymadığı. Ara sonuçlar değişebilir.
  final bool isFinal;

  final double confidence;

  /// Mikrofon seviyesi; dalga animasyonunu beslemek için.
  final double soundLevel;

  final String? errorMessage;

  SpeechState copyWith({
    SpeechPhase? phase,
    String? transcript,
    bool? isFinal,
    double? confidence,
    double? soundLevel,
    String? errorMessage,
  }) {
    return SpeechState(
      phase: phase ?? this.phase,
      transcript: transcript ?? this.transcript,
      isFinal: isFinal ?? this.isFinal,
      confidence: confidence ?? this.confidence,
      soundLevel: soundLevel ?? this.soundLevel,
      errorMessage: errorMessage,
    );
  }
}

/// Cihazın konuşma tanıma motorunu sarar.
///
/// Motor **cihazın kendisi** — Android'de Google, iOS'ta Apple. Bu bilinçli:
/// sesi buluta göndermek gizlilik açısından ağır bir taahhüt ve ürün adı
/// söylemek için gereksiz. Ayrıca ağ olmadan da çalışıyor.
///
/// Dil öntanımlı olarak Türkçe (`tr_TR`); cihaz desteklemiyorsa motorun
/// bildirdiği ilk dile düşülüyor.
class SpeechService {
  SpeechService({SpeechToText? engine}) : _engine = engine ?? SpeechToText();

  final SpeechToText _engine;

  final _states = StreamController<SpeechState>.broadcast();

  SpeechState _state = const SpeechState();

  /// Durum akışı. Ekran bunu dinleyip metni ve dalga seviyesini çiziyor.
  Stream<SpeechState> get states => _states.stream;

  SpeechState get state => _state;

  bool get isListening => _engine.isListening;

  void _emit(SpeechState next) {
    _state = next;
    if (!_states.isClosed) {
      _states.add(next);
    }
  }

  /// Motoru hazırlar ve izni ister. Kullanılabilir değilse `false` döner.
  Future<bool> prepare() async {
    try {
      final available = await _engine.initialize(
        onError: (error) => _emit(
          _state.copyWith(
            phase: SpeechPhase.failed,
            // `permanent` kalıcı bir engel demek (izin reddi gibi); geçici
            // hatada kullanıcı tekrar denemekle sonuç alabiliyor.
            errorMessage: error.permanent
                ? 'Mikrofon kullanılamıyor: ${error.errorMsg}'
                : 'Ses anlaşılamadı, tekrar deneyin.',
          ),
        ),
        onStatus: (status) {
          if (status == 'done' || status == 'notListening') {
            // Kesinleşmiş metin gelmeden durum "done" olabiliyor; elde ne
            // varsa onu kullanıyoruz.
            _emit(_state.copyWith(phase: SpeechPhase.done));
          }
        },
      );

      if (!available) {
        _emit(
          _state.copyWith(
            phase: SpeechPhase.unavailable,
            errorMessage:
                'Cihazda konuşma tanıma kullanılamıyor. Ürünü elle yazabilirsiniz.',
          ),
        );
        return false;
      }

      return true;
    } on Exception catch (error) {
      _emit(
        _state.copyWith(
          phase: SpeechPhase.unavailable,
          errorMessage: 'Konuşma tanıma başlatılamadı: $error',
        ),
      );
      return false;
    }
  }

  /// Cihazın desteklediği diller arasından Türkçe'yi seçer; yoksa null döner
  /// ve motor kendi öntanımlısını kullanır.
  Future<String?> _resolveLocale() async {
    final locales = await _engine.locales();
    for (final locale in locales) {
      if (locale.localeId.startsWith('tr')) {
        return locale.localeId;
      }
    }
    return null;
  }

  /// Dinlemeyi başlatır.
  ///
  /// [pauseFor] kullanıcı sustuktan sonra ne kadar bekleneceğini belirler.
  /// Alışveriş listesi söylerken ürünler arasında doğal duraklama olduğu için
  /// öntanımlı değerden uzun tutuldu.
  Future<void> listen({
    Duration listenFor = const Duration(seconds: 30),
    Duration pauseFor = const Duration(seconds: 3),
  }) async {
    final localeId = await _resolveLocale();

    _emit(
      const SpeechState(phase: SpeechPhase.listening),
    );

    // Bu ayarların tamamı `SpeechListenOptions` içinde veriliyor; aynı
    // adlı üst düzey parametreler paketin yeni sürümünde kullanımdan kaldırıldı.
    await _engine.listen(
      listenOptions: SpeechListenOptions(
        localeId: localeId,
        listenFor: listenFor,
        pauseFor: pauseFor,
        // `partialResults` öntanımlı olarak açık ve öyle kalması gerekiyor:
        // kullanıcı söylediğini anında ekranda görmeli, yoksa mikrofonun
        // çalıştığından emin olamıyor.
        //
        // `dictation` kipi cümle sonunda kendiliğinden kesmiyor; alışveriş
        // listesi sayarken ürünler arası duraklama normal.
        listenMode: ListenMode.dictation,
      ),
      onResult: _onResult,
      onSoundLevelChange: (level) => _emit(_state.copyWith(soundLevel: level)),
    );
  }

  void _onResult(SpeechRecognitionResult result) {
    _emit(
      _state.copyWith(
        phase: result.finalResult ? SpeechPhase.done : SpeechPhase.listening,
        transcript: result.recognizedWords,
        isFinal: result.finalResult,
        confidence: result.confidence,
      ),
    );
  }

  /// Dinlemeyi bitirir ve o ana kadarki metni korur.
  Future<void> stop() async {
    await _engine.stop();
    _emit(_state.copyWith(phase: SpeechPhase.done));
  }

  /// Dinlemeyi iptal eder ve metni atar.
  Future<void> cancel() async {
    await _engine.cancel();
    _emit(const SpeechState());
  }

  Future<void> dispose() async {
    if (_engine.isListening) {
      await _engine.cancel();
    }
    await _states.close();
  }
}
