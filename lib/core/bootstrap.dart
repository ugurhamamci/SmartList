import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartlist/core/config/app_config.dart';
import 'package:smartlist/core/database/local_cache.dart';
import 'package:smartlist/core/errors/error_mapper.dart';
import 'package:smartlist/core/utils/app_logger.dart';
import 'package:smartlist/providers/core_providers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Uygulamayı başlatır.
///
/// Başarısız olabilecek her adım kapsanıyor: bir hata boş pencere yerine
/// tanılama ekranı üretiyor, çünkü `runApp` öncesinde çöken bir uygulama
/// kullanıcıya sorunu anlama ya da bildirme şansı bırakmıyor. Başlangıcın
/// tamamı `runZonedGuarded` içinde koşuyor; böylece kurulum sırasında oluşan
/// asenkron bir hata da raporlanıyor.
Future<void> bootstrap(Widget Function() appBuilder) async {
  final config = AppConfig.fromEnvironment();
  AppLogger.configure(verbose: config.verboseLogging);

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Hanken Grotesk uygulamaya gömülü. Bu bayrak, herhangi bir kod yolunun
      // yazı tipini kazayla ağdan çekmesini engeller: fetch denemesi sessizce
      // ağa çıkmak yerine hata verir.
      GoogleFonts.config.allowRuntimeFetching = false;

      _installErrorHandlers(config);

      // Yapılandırma eksikse hangi değerin eksik olduğunu söyleyip duruyoruz.
      // Devam etmek her sorguyu anlaşılmaz bir ağ hatasına çevirirdi.
      if (!config.hasSupabase) {
        AppLogger.fatal(
          'Supabase yapılandırması eksik',
          StateError('SUPABASE_URL / SUPABASE_ANON_KEY verilmedi'),
          StackTrace.current,
        );
        runApp(
          _StartupFailureApp(
            config: config,
            title: 'Sunucu bağlantısı yapılandırılmamış',
            explanation:
                'Uygulama SUPABASE_URL ve SUPABASE_ANON_KEY değerleriyle '
                'derlenmedi. scripts/defines.local.ps1 dosyasını doldurup '
                'scripts/run_dev.ps1 ile çalıştırın; ayrıntı için '
                'docs/KURULUM.md.',
          ),
        );
        return;
      }

      try {
        // `publishableKey` yeni anahtar biçimi (`sb_publishable_...`) için
        // doğru parametre; `anonKey` kullanımdan kaldırıldı. PKCE akışı ve
        // oturumun kalıcı olması SDK'nın öntanımlısı, açıkça yazmıyoruz.
        await Supabase.initialize(
          url: config.supabaseUrl,
          publishableKey: config.supabaseAnonKey,
          debug: config.verboseLogging,
        );
      } on Object catch (error, stackTrace) {
        AppLogger.fatal('Supabase başlatılamadı', error, stackTrace);
        runApp(
          _StartupFailureApp(
            config: config,
            error: error,
            title: 'Sunucuya bağlanılamadı',
            explanation:
                'Supabase istemcisi başlatılamadı. İnternet bağlantınızı ve '
                'SUPABASE_URL değerinin doğruluğunu kontrol edin.',
          ),
        );
        return;
      }

      try {
        await LocalCache.initialize();
      } on Object catch (error, stackTrace) {
        // Yerel önbellek bir iyileştirme, zorunluluk değil: günlüğe yazıp
        // devam ediyoruz, uygulama ağ üzerinden çalışmaya devam eder.
        AppLogger.error('Yerel önbellek kullanılamıyor', error, stackTrace);
      }

      runApp(
        ProviderScope(
          overrides: [appConfigProvider.overrideWithValue(config)],
          child: appBuilder(),
        ),
      );
    },
    (error, stackTrace) {
      AppLogger.fatal('Yakalanmayan bölge hatası', error, stackTrace);
    },
  );
}

/// Framework ve platform hatalarını günlüğe yönlendirir.
void _installErrorHandlers(AppConfig config) {
  FlutterError.onError = (details) {
    AppLogger.error(
      'Flutter framework hatası',
      details.exception,
      details.stack,
    );
    // Hata raporlama servisi bağlanana kadar hata konsola da basılıyor;
    // sessizce yutmak sorunu görünmez yapardı.
    FlutterError.presentError(details);
  };

  // Flutter framework'ünün tamamen dışında kalan hatalar, örneğin bir platform
  // kanalı geri çağrısından gelenler.
  PlatformDispatcher.instance.onError = (error, stackTrace) {
    final mapped = ErrorMapper.map(error, stackTrace);
    AppLogger.fatal(
      'Ele alınmayan platform hatası: ${mapped.code}',
      error,
      stackTrace,
    );
    return true;
  };
}

/// Uygulama hiç başlayamadığında gösterilir.
///
/// Eksik yapılandırmayı açıkça söylüyor: en sık neden, gereken
/// `--dart-define` değerleri verilmeden başlatılmış bir derleme.
class _StartupFailureApp extends StatelessWidget {
  const _StartupFailureApp({
    required this.config,
    required this.title,
    required this.explanation,
    this.error,
  });

  final AppConfig config;
  final String title;
  final String explanation;
  final Object? error;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: config.appName,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.error_outline, size: 48),
                const SizedBox(height: 16),
                Text(title, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 12),
                Text(explanation),
                const SizedBox(height: 16),
                if (kDebugMode && error != null)
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        '$error',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
