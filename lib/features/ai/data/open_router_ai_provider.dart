import 'package:dio/dio.dart';

import 'package:smartlist/core/errors/app_exception.dart';
import 'package:smartlist/core/errors/error_mapper.dart';
import 'package:smartlist/features/ai/domain/ai_models.dart';
import 'package:smartlist/features/ai/domain/ai_provider.dart';
import 'package:smartlist/models/enums.dart';

/// OpenRouter üzerinden model çağırır.
///
/// OpenRouter, tek anahtarla onlarca sağlayıcıya erişim veren bir geçit ve
/// API'si OpenAI Chat Completions ile uyumlu — bu yüzden ayrı bir istek biçimi
/// gerekmiyor. Yine de üç davranış farkı var ve hepsi canlı ölçümle
/// doğrulandı:
///
/// **1. `reasoning` alanı ayrı geliyor.** Öntanımlı model bir akıl yürütme
/// modeli; yanıtın düşünme kısmı `message.reasoning` içinde, asıl cevap
/// `message.content` içinde. İkisini birleştirmek JSON ayrıştırmayı bozar.
///
/// **2. Akıl yürütme token bütçesini yiyor.** Ölçümde 5 ürünlük bir liste için
/// 749 akıl yürütme token'ı harcandı. `max_tokens` düşük verilirse yanıt
/// `content` boş kalarak kesiliyor, o yüzden alt sınır yükseltildi.
///
/// **3. Dil talimatı katı olmak zorunda.** Zayıf bir Türkçe talimatla model
/// İngilizce yanıt verdi ve çıktıya Kiril/Arap harfleri sızdı
/// (`"unit":" изд"`). Talimat kesinleştirildiğinde aynı model temiz Türkçe
/// üretti. Bu yüzden [complete] sistem istemine dil kısıtını kendisi ekliyor
/// ve [sanitise] sızan yabancı yazı sistemlerini yakalıyor.
///
/// `prefer_initializing_formals` bastırıldı: Dart özel adlı parametreye izin
/// vermiyor, kimlik alanları özel kalmalı.
// ignore_for_file: prefer_initializing_formals
class OpenRouterAiProvider implements AiProvider {
  OpenRouterAiProvider({
    required Dio dio,
    required String apiKey,
    required String proxyBaseUrl,
    String model = defaultModelId,
    String appUrl = defaultAppUrl,
    String appTitle = defaultAppTitle,
  }) : _dio = dio,
       _apiKey = apiKey,
       _proxyBaseUrl = proxyBaseUrl,
       _model = model.isEmpty ? defaultModelId : model,
       _referer = appUrl,
       _title = appTitle;

  /// Ücretsiz katmanda çalışan model. Ölçümde denenen diğer ücretsiz modeller
  /// ("deepseek-chat-v3.1:free", "llama-3.3-70b-instruct:free",
  /// "gemma-3-27b-it:free", "qwen3-235b-a22b:free") artık 404 dönüp ücretli
  /// karşılıklarına yönlendiriyor; bu, şu an gerçekten ücretsiz olan seçenek.
  static const String defaultModelId = 'openai/gpt-oss-20b:free';

  static const String _directEndpoint =
      'https://openrouter.ai/api/v1/chat/completions';

  /// OpenRouter isteğin hangi uygulamadan geldiğini bu iki başlıkla izliyor;
  /// göndermek zorunlu değil ama kota ve sıralama tarafında uygulamayı
  /// tanınır kılıyor.
  static const String defaultAppUrl =
      'https://github.com/ugurhamamci/SmartList';
  static const String defaultAppTitle = 'SmartList';

  /// Akıl yürütme token'ları da bütçeden düştüğü için alt sınır. Ölçülen
  /// tüketim ~750 token; asıl cevaba yer kalsın diye bunun üstüne çıkıyoruz.
  static const int _minMaxTokens = 1200;

  /// Türkçe dışı yazı sistemleri: Kiril, Arapça, İbranice, CJK, Devanagari.
  /// Ücretsiz modelin çıktısına bunlar sızabiliyor.
  static final RegExp _foreignScripts = RegExp(
    '[Ѐ-ӿ֐-׿؀-ۿऀ-ॿ'
    '぀-ヿ一-鿿가-힯]',
  );

  /// Modelin Türkçe ve şema dışına çıkmasını engelleyen ek talimat.
  ///
  /// Ölçüm sonucu: bu satırlar olmadan model İngilizce yanıt verdi ve bozuk
  /// harf üretti; eklendiğinde çıktı temiz geldi.
  static const String _languageGuard =
      'ÇIKTI KURALLARI: Tüm metin Türkçe olmalı. Yalnızca Türkçe ve '
      'Latin harfleri kullan; Kiril, Arapça veya Çince karakter kullanma. '
      'Yalnızca geçerli JSON döndür, açıklama veya kod bloğu işareti ekleme.';

  final Dio _dio;
  final String _apiKey;
  final String _proxyBaseUrl;
  final String _model;
  final String _referer;
  final String _title;

  @override
  AiProviderKind get kind => AiProviderKind.openRouter;

  @override
  String get defaultModel => _model;

  /// OpenRouter `json_schema` desteğini modele göre iletiyor ve ücretsiz
  /// modeller bunu çoğunlukla desteklemiyor. Ölçümde `json_object` kipi de
  /// çıktıyı düzeltmedi; asıl işi istem yapıyor. Bu yüzden `false` — böylece
  /// `AiService` şemayı isteme yazıp yanıtı savunmacı ayrıştırıyor.
  @override
  bool get supportsStructuredOutput => false;

  @override
  bool get isConfigured => _proxyBaseUrl.isNotEmpty || _apiKey.isNotEmpty;

  bool get _useProxy => _proxyBaseUrl.isNotEmpty;

  @override
  Future<AiResponse> complete(AiRequest request) async {
    if (!isConfigured) {
      throw AiException(
        code: 'ai.not_configured',
        provider: kind.wire,
        details: 'OpenRouter için ne proxy adresi ne API anahtarı verildi.',
      );
    }

    final body = <String, dynamic>{
      'model': request.model ?? _model,
      // İstenen bütçe alt sınırın altındaysa yükseltiyoruz: aksi hâlde akıl
      // yürütme token'ları bütçeyi bitirip `content` boş dönüyor.
      'max_tokens': request.maxTokens < _minMaxTokens
          ? _minMaxTokens
          : request.maxTokens,
      'messages': _messages(request),
      if (request.temperature != null) 'temperature': request.temperature,
      // Şema desteklenmese de JSON kipini istemek yardımcı oluyor; model
      // desteklemiyorsa OpenRouter alanı yok sayıyor.
      if (request.jsonSchema != null)
        'response_format': {'type': 'json_object'},
    };

    final response = await ErrorMapper.guard(
      () => _dio.post<Map<String, dynamic>>(
        _useProxy ? '$_proxyBaseUrl/openrouter/chat' : _directEndpoint,
        data: body,
        options: Options(
          headers: {
            'content-type': 'application/json',
            if (!_useProxy) 'authorization': 'Bearer $_apiKey',
            if (!_useProxy) 'http-referer': _referer,
            if (!_useProxy) 'x-title': _title,
          },
        ),
      ),
    );

    final payload = response.data;
    if (payload == null) {
      throw AiException(code: 'ai.empty_response', provider: kind.wire);
    }
    return _parse(payload);
  }

  List<Map<String, dynamic>> _messages(AiRequest request) {
    final system = [
      if (request.systemPrompt != null && request.systemPrompt!.isNotEmpty)
        request.systemPrompt!,
      _languageGuard,
    ].join('\n\n');

    return <Map<String, dynamic>>[
      {'role': 'system', 'content': system},
      ...request.messages.map(
        (message) => <String, dynamic>{
          'role': message.role.wire,
          'content': message.content,
        },
      ),
    ];
  }

  AiResponse _parse(Map<String, dynamic> payload) {
    // OpenRouter hatayı 200 gövdesi içinde de döndürebiliyor (yönlendirme,
    // kota, model kaldırılmış gibi durumlar), o yüzden önce ona bakıyoruz.
    final error = payload['error'];
    if (error is Map<String, dynamic>) {
      throw AiException(
        code: 'ai.provider_error',
        provider: kind.wire,
        details: error['message']?.toString() ?? error.toString(),
      );
    }

    final choices = payload['choices'] as List<dynamic>? ?? const [];
    if (choices.isEmpty) {
      throw AiException(code: 'ai.empty_response', provider: kind.wire);
    }

    final choice = choices.first as Map<String, dynamic>;
    final message = choice['message'] as Map<String, dynamic>?;
    final usage = payload['usage'] as Map<String, dynamic>?;
    final finishReason = choice['finish_reason'] as String?;

    // `reasoning` bilinçli olarak OKUNMUYOR: akıl yürütme metni asıl cevabın
    // parçası değil, ona eklemek JSON'u bozar.
    final content = message?['content'] as String? ?? '';

    final refusal = message?['refusal'] as String?;
    if (finishReason == 'content_filter' || refusal != null) {
      return AiResponse(
        text: '',
        provider: kind,
        model: payload['model'] as String? ?? _model,
        stopReason: AiStopReason.refusal,
        refusalCategory: refusal,
        inputTokens: usage?['prompt_tokens'] as int? ?? 0,
        outputTokens: usage?['completion_tokens'] as int? ?? 0,
      );
    }

    return AiResponse(
      text: sanitise(content),
      provider: kind,
      model: payload['model'] as String? ?? _model,
      stopReason: switch (finishReason) {
        'stop' => AiStopReason.completed,
        'length' => AiStopReason.maxTokens,
        'tool_calls' || 'function_call' => AiStopReason.toolUse,
        _ => AiStopReason.unknown,
      },
      inputTokens: usage?['prompt_tokens'] as int? ?? 0,
      outputTokens: usage?['completion_tokens'] as int? ?? 0,
    );
  }

  /// Modelin çıktısını kullanılabilir hâle getirir.
  ///
  /// İki sorunu düzeltir:
  /// * Bazı modeller JSON'u ``` işaretleri arasına alıyor.
  /// * Ücretsiz modelin çıktısına yabancı yazı sistemi karakterleri sızıyor
  ///   (ölçümde `"Ek ائمة"` ve `"unit":" изд"` görüldü). Bunlar ürün adını
  ///   okunamaz yapıyor; atmak, bozuk adı listeye yazmaktan iyi.
  static String sanitise(String raw) {
    var text = raw.trim();

    // ```json ... ``` sarmalını soy.
    if (text.startsWith('```')) {
      final firstNewline = text.indexOf('\n');
      if (firstNewline != -1) {
        text = text.substring(firstNewline + 1);
      }
      if (text.endsWith('```')) {
        text = text.substring(0, text.length - 3);
      }
      text = text.trim();
    }

    // Yabancı harfleri temizle, ardından oluşan çift boşlukları topla.
    if (_foreignScripts.hasMatch(text)) {
      text = text
          .replaceAll(_foreignScripts, '')
          .replaceAll(RegExp(r'[ \t]{2,}'), ' ');
    }

    return text.trim();
  }
}
