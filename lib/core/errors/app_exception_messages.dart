import 'package:smartlist/core/errors/app_exception.dart';

/// Hata kodlarını kullanıcıya gösterilecek Türkçe cümlelere çevirir.
///
/// [AppException.code] bilinçli olarak yerelleştirilmemiş, kararlı bir
/// tanımlayıcı; günlüğe ve Crashlytics'e o yazılıyor. Kullanıcıya gösterilen
/// metin tek yerden — burada — üretiliyor, böylece aynı hata her ekranda aynı
/// cümleyle görünüyor ve arayüz sağlayıcıya özgü kodları hiç görmüyor.
extension AppExceptionL10n on AppException {
  /// Kullanıcıya gösterilebilecek açıklama.
  ///
  /// Bilinen kodlar özel cümle alır; bilinmeyenler hata türüne göre genel bir
  /// cümleye düşer. Genel cümle bile kullanıcının ne yapacağını söylüyor,
  /// çünkü "bir hata oluştu" kimseye yardım etmiyor.
  String get userMessage => switch (code) {
    // --- kimlik doğrulama ---
    'auth.invalid_credentials' => 'E-posta veya şifre hatalı.',
    'auth.email_not_confirmed' =>
      'E-posta adresinizi doğrulamanız gerekiyor. Gelen kutunuza bakın.',
    'auth.email_exists' => 'Bu e-posta adresiyle bir hesap zaten var.',
    'auth.weak_password' =>
      'Şifre çok zayıf. En az 8 karakter olmalı ve büyük harf, küçük harf ile '
          'rakam içermeli.',
    'auth.same_password' => 'Yeni şifre eskisiyle aynı olamaz.',
    'auth.user_not_found' => 'Bu e-posta adresine ait bir hesap bulunamadı.',
    'auth.rate_limited' =>
      'Çok fazla deneme yapıldı. Birkaç dakika sonra tekrar deneyin.',
    'auth.validation_failed' => 'Girilen bilgiler geçersiz.',
    'auth.signed_out' => 'Oturumunuz sona erdi. Tekrar giriş yapın.',

    // --- barkod ---
    'barcode.invalid' =>
      'Barkod okunamadı. Kodu elle yazabilir veya tekrar deneyebilirsiniz.',

    // --- davet / paylaşım ---
    'invite.invalid' => 'Bu davet bağlantısı geçerli değil.',
    'invite.expired' => 'Bu davet bağlantısının süresi dolmuş.',
    'invite.exhausted' => 'Bu davet bağlantısı kullanım sınırına ulaştı.',

    // --- yapay zekâ ---
    'ai.not_configured' =>
      'Yapay zekâ özelliği bu kurulumda yapılandırılmamış.',
    'ai.empty_response' => 'Yapay zekâ yanıt vermedi. Tekrar deneyin.',
    'ai.provider_error' =>
      'Yapay zekâ servisi şu anda yanıt veremiyor. Biraz sonra deneyin.',

    // --- yapılandırma ---
    'config.missing_supabase' =>
      'Sunucu bağlantısı yapılandırılmamış. Kurulum adımlarını tamamlayın.',

    // Kod tanınmıyorsa hata TÜRÜNE göre genel cümle.
    _ => _byKind,
  };

  String get _byKind => switch (this) {
    NetworkException() =>
      'İnternet bağlantısı kurulamadı. Bağlantınızı kontrol edip tekrar deneyin.',
    ServerException() =>
      'Sunucuya ulaşılamadı. Kısa süre sonra tekrar deneyin.',
    AuthException() => 'Giriş sırasında bir sorun oluştu. Tekrar deneyin.',
    PermissionDeniedException() => 'Bu işlem için yetkiniz yok.',
    NotFoundException() => 'Aradığınız kayıt bulunamadı.',
    ConflictException() =>
      'Bu kayıt başka bir cihazdan değiştirilmiş. Yenileyip tekrar deneyin.',
    ValidationException() => 'Girilen bilgiler geçersiz.',
    RateLimitException() =>
      'Çok fazla istek gönderildi. Biraz bekleyip tekrar deneyin.',
    PremiumRequiredException() => 'Bu özellik Premium üyelik gerektiriyor.',
    CacheException() => 'Yerel veri okunamadı.',
    PlatformCapabilityException() =>
      'Bu cihaz özelliği desteklemiyor. Elle devam edebilirsiniz.',
    AiException() => 'Yapay zekâ servisi yanıt veremedi. Tekrar deneyin.',
    UnknownException() => 'Beklenmeyen bir sorun oluştu. Tekrar deneyin.',
  };
}
