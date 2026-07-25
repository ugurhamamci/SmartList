import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartlist/core/errors/app_exception.dart';
import 'package:smartlist/features/auth/data/auth_service.dart';
import 'package:smartlist/providers/core_providers.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthException;

/// Supabase istemcisi.
///
/// `Supabase.initialize` uygulama açılışında bir kez çağrılıyor (bkz.
/// `SupabaseBootstrap`); burada yalnızca hazır örneğe erişiliyor. Provider
/// olarak açılmasının sebebi testte yerine sahte bir istemci konabilmesi.
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  final config = ref.watch(appConfigProvider);
  if (!config.hasSupabase) {
    // Yapılandırma eksikse burada patlamak doğru: sessizce devam etmek
    // her sorguyu anlaşılmaz bir ağ hatasına çevirirdi.
    throw const UnknownException(
      code: 'config.missing_supabase',
      details:
          'SUPABASE_URL veya SUPABASE_ANON_KEY --dart-define ile verilmedi.',
    );
  }
  return Supabase.instance.client;
});

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref.watch(supabaseClientProvider));
});

/// Oturum akışı.
///
/// İlk değer olarak mevcut oturum veriliyor: `onAuthStateChange` yalnızca
/// *değişiklikte* yayın yapıyor, uygulama açılışında elde zaten bir oturum
/// varsa akış boş kalırdı ve kullanıcı bir an giriş ekranını görürdü.
final authStateProvider = StreamProvider<Session?>((ref) {
  final service = ref.watch(authServiceProvider);
  final client = ref.watch(supabaseClientProvider);

  return service.authStateChanges
      .map((state) => state.session)
      .startWithCurrent(client.auth.currentSession);
});

/// Oturumdaki kullanıcının kimliği; giriş yapılmamışsa `null`.
final currentUserIdProvider = Provider<String?>((ref) {
  // Riverpod 3'te `AsyncValue.value` doğrudan `T?` döner; yükleniyor veya
  // hata durumunda null olur, yani giriş yapılmamış gibi davranılır.
  return ref.watch(authStateProvider).value?.user.id;
});

/// Kullanıcı giriş yapmış mı. Kabuk ekranı bunu izleyip giriş ekranıyla
/// uygulama arasında geçiş yapıyor.
final isSignedInProvider = Provider<bool>((ref) {
  return ref.watch(currentUserIdProvider) != null;
});

extension _StartWith<T> on Stream<T> {
  /// Akışın başına şimdiki değeri ekler.
  Stream<T> startWithCurrent(T initial) async* {
    yield initial;
    yield* this;
  }
}
