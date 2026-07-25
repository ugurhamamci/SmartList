# Supabase Dashboard ayarları

Bu üç ayar **kodla yapılamıyor**: proje yapılandırması, veri değil. Uygulamanın
elindeki `publishable` anahtar veri okuyup yazıyor, proje ayarını değiştiremiyor
— o iş için ayrı bir yönetim erişim jetonu gerekiyor.

Durum, ayar uçlarından okunarak doğrulandı:

```
GET /auth/v1/settings
  mailer_autoconfirm : false      <- düzeltilmesi gereken
  disable_signup     : false      ✅
  external           : email      <- Google/Apple kapalı
```

---

## 1. "Confirm email" kapatılmalı — ZORUNLU

**Authentication → Sign In / Providers → Email → Confirm email → kapat**

### Neden zorunlu

Doğrulama açıkken **her kayıt bir e-posta gönderiyor** ve Supabase'in dahili
SMTP'si ücretsiz katmanda **saatte ~2–3 e-posta** ile sınırlı. Sınır dolduğunda
kayıt uçları şunu döndürüyor:

```
HTTP 429  {"error_code":"over_email_send_rate_limit","msg":"email rate limit exceeded"}
```

Yani bu ayar açıkken uygulama yayına çıkarsa **üçüncü kullanıcıdan sonra kimse
kayıt olamaz**. Bu bir kod sorunu değil, proje ayarı.

### Doğrulamayı geri açmak istediğinizde

Kapatmak kalıcı bir karar değil. Kendi SMTP sağlayıcınızı bağladığınızda
(**Project Settings → Auth → SMTP Settings**; Resend, SendGrid, Amazon SES gibi)
sınır kalkıyor ve doğrulamayı güvenle açabilirsiniz. Sıralama önemli: önce SMTP,
sonra doğrulama.

---

## 2. Yönlendirme adresleri eklenmeli — Google/Apple için zorunlu

**Authentication → URL Configuration → Redirect URLs**

```
smartlist://login-callback
smartlist://reset-password
```

Bunlar olmadan sağlayıcı düğmeleri tarayıcıyı açar ama Supabase dönüşü
reddeder — kullanıcı boş bir tarayıcı sekmesinde kalır. Adresler
`AuthService` içindeki değerlerle birebir aynı olmalı.

`smartlist://` şeması iki platformda da tanımlı:
`android/app/src/main/AndroidManifest.xml` (intent-filter) ve
`ios/Runner/Info.plist` (`CFBundleURLTypes`).

---

## 3. Google ve Apple sağlayıcıları açılmalı — isteğe bağlı

Düğmeler yazıldı ve çalışıyor, ama sağlayıcılar kapalı olduğu için şu anda hata
dönüyorlar.

### Google

1. **Authentication → Sign In / Providers → Google → aç**
2. Google Cloud Console → **APIs & Services → Credentials → Create OAuth client ID
   → Web application**
3. Yetkili yönlendirme adresi:
   `https://gjhuyouzbbcavrgejujs.supabase.co/auth/v1/callback`
4. Client ID ve Client Secret'ı Supabase'deki alanlara yapıştır

### Apple

Apple Developer üyeliği gerekiyor (yıllık ücretli). **Authentication → Providers
→ Apple** altında Services ID, Team ID, Key ID ve özel anahtar isteniyor.

> App Store kuralı: başka bir üçüncü taraf girişi sunan uygulama iOS'ta Apple
> ile girişi de sunmak zorunda. Yani Google'ı açıp Apple'ı açmazsanız iOS
> yayını reddedilir. Android bundan etkilenmiyor; Apple düğmesi zaten yalnızca
> Apple platformlarında görünüyor.

---

## Ayarlar tamamlandıktan sonra doğrulama

Depoda uçtan uca doğrulama betiği var. `Confirm email` kapatıldıktan sonra:

```powershell
node tool/verify_backend.mjs t1
```

Betik iki test kullanıcısı oluşturup gerçek senaryoyu sınıyor — bu, hiç
çalıştırılmamış 18 PL/pgSQL fonksiyonunun ve 45 RLS politikasının tek
kanıtı:

| # | Ne sınanıyor |
|---|---|
| 1 | Kayıt → `handle_new_auth_user` profil ve ayar satırlarını açtı mı, `display_name` taşındı mı |
| 2 | 15 küresel kategori ve 10 premium özellik yüklendi mi |
| 3 | Liste oluşturma → owner üyeliği ve sohbet odası otomatik açıldı mı, `created_by` damgalandı mı |
| 4 | Üye olmayan listeyi göremiyor ve yazamıyor mu (RLS) |
| 5 | Ürün ekleme → `item_count` / `total_spent` trigger'ları doğru mu |
| 6 | **QR ile katılma** → `join_list_by_slug` çalışıyor mu, davet kodları taranabiliyor mu, `member_count` arttı mı |
| 7 | "Alındı" işaretleme → liste tamamlandı sayıldı mı |
| 8 | **Viewer kısıtı** → ürün adını değiştiremiyor ama alındı işaretleyebiliyor, silemiyor |
| 9 | Etkinlik kaydı değiştirilemiyor mu (kurcalanamazlık) |
| 10 | Kullanıcı kendine premium veremiyor mu |
| 11 | Son sahip listeden ayrılamıyor mu |
| 12 | Sürüm çakışması yakalanıyor mu (iyimser eşzamanlılık) |

Betik, `supabase/.env.local` dosyasından adres ve anahtarı okuyor; anahtar
depoda tutulmuyor.

Her koşuda farklı bir etiket verin (`t1`, `t2`, …): etiket test kullanıcılarının
e-posta adresine giriyor, aynı etiketle ikinci koşu "kullanıcı zaten var"
hatası verir.
