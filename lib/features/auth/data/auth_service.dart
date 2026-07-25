import 'package:smartlist/core/errors/app_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthException;
import 'package:supabase_flutter/supabase_flutter.dart'
    as supabase
    show AuthApiException, AuthException;

/// Supabase Auth'u uygulamanın hata diline çevirir.
///
/// Ekranlar sağlayıcının `AuthException`'ını değil [AppException] ailesini
/// görüyor; kullanıcıya gösterilecek metni `AppExceptionL10n` üretiyor. Böylece
/// sağlayıcıya özgü kodlar arayüze sızmıyor ve sağlayıcı değişirse ekranlar
/// etkilenmiyor.
///
/// Supabase'in `AuthException` adı uygulamanın kendi [AuthException] tipiyle
/// çakıştığı için içe aktarım `hide` ile ayrıştırıldı.
class AuthService {
  AuthService(this._client);

  final SupabaseClient _client;

  GoTrueClient get _auth => _client.auth;

  /// Oturumdaki kullanıcı; yoksa `null`.
  User? get currentUser => _auth.currentUser;

  String? get currentUserId => _auth.currentUser?.id;

  bool get isSignedIn => _auth.currentUser != null;

  /// Oturum değişikliği akışı. Uygulama kabuğu bunu dinleyip giriş ekranıyla
  /// ana ekran arasında geçiş yapıyor.
  Stream<AuthState> get authStateChanges => _auth.onAuthStateChange;

  /// E-posta ve şifreyle kayıt.
  ///
  /// Profil ve ayar satırları veritabanındaki `handle_new_auth_user` trigger'ı
  /// tarafından açılıyor; istemci ayrıca bir şey yazmıyor. Bu iş bilinçli
  /// olarak sunucuda: kayıt sırasında ağ kesilirse profilsiz hesap kalmasın.
  Future<User> signUp({
    required String email,
    required String password,
    required String displayName,
  }) {
    return _guard(() async {
      final response = await _auth.signUp(
        email: email.trim(),
        password: password,
        // Trigger adı bu alandan okuyor.
        data: {'display_name': displayName.trim()},
      );

      final user = response.user;
      if (user == null) {
        throw const AuthException(code: 'auth.signup_failed');
      }
      return user;
    });
  }

  Future<User> signIn({required String email, required String password}) {
    return _guard(() async {
      final response = await _auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );

      final user = response.user;
      if (user == null) {
        throw const AuthException(code: 'auth.invalid_credentials');
      }
      return user;
    });
  }

  /// Şifre sıfırlama bağlantısı gönderir.
  ///
  /// Yönlendirme adresi uygulamanın derin bağlantısı: kullanıcı e-postadaki
  /// bağlantıya dokunduğunda tarayıcı değil uygulama açılıyor.
  Future<void> sendPasswordReset(String email) {
    return _guard(
      () => _auth.resetPasswordForEmail(
        email.trim(),
        redirectTo: 'smartlist://reset-password',
      ),
    );
  }

  Future<void> updatePassword(String newPassword) {
    return _guard(
      () => _auth.updateUser(UserAttributes(password: newPassword)),
    );
  }

  /// Google ile giriş.
  ///
  /// Akış Supabase'in barındırdığı OAuth uç noktasından geçiyor: uygulama
  /// sistem tarayıcısını açıyor, kullanıcı Google'da onaylıyor, Supabase
  /// oturumu `smartlist://login-callback` derin bağlantısıyla uygulamaya
  /// geri veriyor.
  ///
  /// Yerel (native) hesap seçicisi yerine tarayıcı akışının seçilmesi bilinçli:
  /// yerel akış her platform için ayrı OAuth istemci kimliği, Android'de imza
  /// parmak izi ve ek paketler gerektiriyor. Tarayıcı akışı tek bir Dashboard
  /// yapılandırmasıyla iki platformda da çalışıyor. Yerel seçiciye geçmek
  /// istenirse yalnızca bu metodun gövdesi değişir, çağrı yerleri değişmez.
  ///
  /// Dönen `true` yalnızca tarayıcının açıldığını söyler; oturumun gerçekten
  /// açıldığını [authStateChanges] bildiriyor.
  Future<bool> signInWithGoogle() => _signInWithProvider(OAuthProvider.google);

  /// Apple ile giriş.
  ///
  /// App Store kuralı gereği başka bir üçüncü taraf girişi sunan uygulamanın
  /// Apple ile girişi de sunması gerekiyor; bu yüzden Google'la birlikte
  /// zorunlu bir eş.
  Future<bool> signInWithApple() => _signInWithProvider(OAuthProvider.apple);

  Future<bool> _signInWithProvider(OAuthProvider provider) {
    return _guard(
      () => _auth.signInWithOAuth(
        provider,
        redirectTo: 'smartlist://login-callback',
        // Uygulama içi tarayıcı sekmesi: kullanıcı uygulamadan çıkmış gibi
        // hissetmiyor ve dönüş derin bağlantısı daha güvenilir çalışıyor.
        authScreenLaunchMode: LaunchMode.externalApplication,
      ),
    );
  }

  Future<void> signOut() => _guard(_auth.signOut);

  /// Supabase istisnalarını [AppException] ailesine çevirir.
  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on supabase.AuthApiException catch (error, stackTrace) {
      throw AuthException(
        code: _codeFor(error.code),
        details: error.message,
        cause: error,
        stackTrace: stackTrace,
      );
    } on supabase.AuthException catch (error, stackTrace) {
      throw AuthException(
        code: 'auth.error',
        details: error.message,
        cause: error,
        stackTrace: stackTrace,
      );
    } on Exception catch (error, stackTrace) {
      // Ağ katmanı hatası kimlik doğrulama hatası değil: kullanıcıya
      // "şifre yanlış" demek yerine bağlantı sorunu olduğunu söylemeliyiz.
      throw NetworkException(
        code: 'auth.transport',
        details: error.toString(),
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// Supabase hata kodunu uygulamanın kararlı koduna eşler.
  ///
  /// Eşleme burada duruyor ki kullanıcıya gösterilen metin tek yerde
  /// (`AppExceptionL10n`) kalsın; bu katman yalnızca kod çeviriyor.
  String _codeFor(String? supabaseCode) => switch (supabaseCode) {
    'invalid_credentials' => 'auth.invalid_credentials',
    'email_not_confirmed' => 'auth.email_not_confirmed',
    'user_already_exists' || 'email_exists' => 'auth.email_exists',
    'weak_password' => 'auth.weak_password',
    'same_password' => 'auth.same_password',
    'user_not_found' => 'auth.user_not_found',
    'over_email_send_rate_limit' ||
    'over_request_rate_limit' => 'auth.rate_limited',
    'validation_failed' => 'auth.validation_failed',
    'session_not_found' || 'refresh_token_not_found' => 'auth.signed_out',
    null => 'auth.error',
    _ => 'auth.$supabaseCode',
  };
}
