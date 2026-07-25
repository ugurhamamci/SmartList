# SmartList

Çiftler, aileler, ev arkadaşları ve arkadaş grupları için **yapay zekâ destekli
ortak alışveriş listesi** uygulaması. Tek Flutter kod tabanından Android ve iOS.

![Flutter](https://img.shields.io/badge/Flutter-3.44.8-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.12.2-0175C2?logo=dart)
![Supabase](https://img.shields.io/badge/Supabase-Postgres%20%7C%20Auth%20%7C%20Realtime-3ECF8E?logo=supabase)
![Analiz](https://img.shields.io/badge/flutter%20analyze-0%20uyar%C4%B1-brightgreen)
![Test](https://img.shields.io/badge/test-101%20ge%C3%A7ti-brightgreen)

> 📋 **Projenin güncel durumu, neyin çalıştığı ve neyin eksik olduğu:**
> **[DURUM_RAPORU.md](DURUM_RAPORU.md)**

---

## ⚡ Hızlı başlangıç

Yeni bir bilgisayarda **hiçbir şey kurulu değilse**
👉 **[docs/KURULUM.md](docs/KURULUM.md)** dosyasını takip edin (adım adım, 35–60 dk).

Flutter'ı zaten kurulu olan bir makinede:

```powershell
git clone https://github.com/ugurhamamci/SmartList.git
cd SmartList

.\scripts\setup.ps1                                          # paketler, kod üretimi, analiz, test

Copy-Item scripts\defines.example.ps1 scripts\defines.local.ps1
# defines.local.ps1 içindeki SUPABASE_URL ve SUPABASE_ANON_KEY değerlerini doldurun

.\scripts\run_dev.ps1                                        # çalıştır
```

---

## 📌 Projenin durumu

| Kontrol | Sonuç |
|---|---|
| `flutter analyze` | **0 uyarı / 0 hata** |
| `flutter test` | **101 test geçti** |
| `flutter build web --release` | Her iki giriş noktası derleniyor |
| Kod | 130+ dosya, ~24.000 satır |
| Model | 22 Freezed sınıfı, 26 enum |
| Veritabanı | Supabase Postgres: 24 tablo, 45+ RLS politikası, 18 fonksiyon, 55 indeks |

**Çalışıyor:** tasarımın tamamı (10 ekran), giriş/kayıt/şifre sıfırlama,
Google & Apple düğmeleri, profil, ayarlar (tema anında değişiyor),
istatistikler (fl_chart), premium sayfası, **barkod okuma** (4 açık
veritabanında arama + kontrol hanesi doğrulaması), **gerçek QR üretimi**,
sesle ekleme ayrıştırıcısı, sağlayıcıdan bağımsız yapay zekâ katmanı.

**Sırada:** depo katmanı (listeler Postgres'ten okunacak), Realtime
(iki telefon aynı anda görecek), ayarların kaydedilmesi, sesle ekleme düğmesinin
bağlanması.

**Önce yapılması gereken üç Dashboard ayarı var** — kodla yapılamıyor:
**[docs/SUPABASE_AYARLARI.md](docs/SUPABASE_AYARLARI.md)**. En kritiği:
e-posta doğrulaması açık olduğu için kayıt olma şu anda saatte 2–3 denemeden
sonra HTTP 429 veriyor.

Detaylı rapor: **[DURUM_RAPORU.md](DURUM_RAPORU.md)**

---

## 🧱 Teknoloji

**Flutter 3.44.8** · **Dart 3.12.2** · Material 3

| Katman | Kullanılan |
|---|---|
| Durum yönetimi | Riverpod, Flutter Hooks |
| Navigasyon | Go Router |
| Modeller | Freezed, json_serializable |
| Backend | Supabase: Postgres + RLS, Auth, Realtime, Storage, Edge Functions |
| Ağ | Dio |
| Yerel depolama | Hive, Flutter Secure Storage |
| Cihaz | Image Picker, Mobile Scanner, Speech to Text, Permission Handler, Connectivity Plus |
| Arayüz | Google Fonts, Flutter Animate, Lottie, Cached Network Image, fl_chart |
| AI | OpenRouter, Claude, OpenAI, Gemini (soyutlanmış — tedarikçiye bağımsız) |

---

## 🔑 Yapılandırma

**Hiçbir API anahtarı veya proje kimliği depoda tutulmuyor.** Tüm ortama özel
değerler `--dart-define` ile geliyor; böylece aynı kod tabanı development,
staging ve production projelerini hedefler.

### Zorunlu değerler

| Değişken | Açıklama |
|---|---|
| `SUPABASE_URL` | `https://<proje-ref>.supabase.co` |
| `SUPABASE_ANON_KEY` | `publishable` (eski adıyla `anon`) anahtar |

`anon` anahtarının istemciye gömülmesi **tasarım gereği güvenlidir**: kimin
neyi görebileceğine RLS politikaları karar veriyor, anahtar değil. `secret`
anahtar RLS'i tamamen atlar ve uygulamaya **asla** konmaz.

### Opsiyonel değerler

| Değişken | Varsayılan | Açıklama |
|---|---|---|
| `FLAVOR` | `development` | `development` | `staging` | `production` |
| `AI_PROXY_BASE_URL` | — | Sunucu tarafı AI proxy — **üretimde bunu kullanın** |
| `AI_PROVIDER` | `claude` | `openrouter` | `claude` | `openai` | `gemini` |
| `OPENROUTER_API_KEY` | — | Yalnızca yerel geliştirme |
| `OPENROUTER_MODEL` | `openai/gpt-oss-20b:free` | OpenRouter model kimliği |
| `ANTHROPIC_API_KEY` | — | Yalnızca yerel geliştirme |
| `OPENAI_API_KEY` | — | Yalnızca yerel geliştirme |
| `GEMINI_API_KEY` | — | Yalnızca yerel geliştirme |
| `VERBOSE_LOGGING` | production dışında açık | Log seviyesi |

> 🔒 **Üretim derlemelerinde `AI_PROXY_BASE_URL` verin, sağlayıcı anahtarı
> vermeyin.** İkili dosyaya gömülen anahtar çıkarılabilir; proxy anahtarı sunucu
> tarafında tutar. Doğrudan anahtar yolu yalnızca geliştirici bir sağlayıcı
> sandbox'ına bağlanabilsin diye var.

Eksik bir zorunlu değer varsa uygulama, **hangi değişkenin eksik olduğunu
söyleyen bir ekranla** açılışta durur — sessiz çalışma zamanı hatası vermez.

---

## 🛠️ Komutlar

| Komut | Ne yapar |
|---|---|
| `.\scripts\setup.ps1` | Paketler + kod üretimi + analiz + test |
| `.\scripts\run_preview.ps1` | **Arayüzü sunucu olmadan çalıştırır** (telefon/tarayıcı) |
| `.\scripts\run_dev.ps1` | Gerçek uygulamayı çalıştırır (Supabase gerekir) |
| `flutter analyze` | Statik analiz (uyarı vermemeli) |
| `flutter test` | 101 test |
| `dart run build_runner build` | Model değişikliğinden sonra |
| `dart run build_runner watch` | Sürekli üretim (geliştirme) |
| `flutter gen-l10n` | Metin (ARB) değişikliğinden sonra |
| `dart format lib test` | Biçimlendirme |

**Supabase:**

```powershell
.scriptssupabase_push.ps1            # migration'ları uygula (bağlantı dizgesi gerekir)
.scriptssupabase_push.ps1 -Verify    # şemayı doğrula
```

Bağlantı dizgesi olmadan: `supabase/schema_all.sql` dosyasını Dashboard'un
**SQL Editor**'üne yapıştırıp çalıştırın.

**Sürüm derlemesi:**

```powershell
.\scripts\run_dev.ps1 -Build appbundle -Flavor production
.\scripts\run_dev.ps1 -Build ipa       -Flavor production
```

---

## 📂 Klasör yapısı

```
lib/
  app.dart                 uygulama kökü
  main*.dart               flavor başına giriş noktası
  core/
    bootstrap.dart         başlatma, global hata yakalama, kalıcılık
    config/                flavorlar, derleme yapılandırması, özellik bayrakları
    constants/             sabitler, depolama anahtarları
    database/              Hive çevrimdışı önbellek
    errors/                hata taksonomisi ve tedarikçi hata eşleme
    theme/                 tasarım token'ları, ThemeData, boşluk uzantısı
    utils/                 logger, JSON dönüştürücüler
  features/
    ai/                    tedarikçiden bağımsız AI katmanı
    ...                    özellik başına klasör (data / domain / presentation)
  l10n/                    ARB dosyaları ve üretilen yerelleştirmeler
  models/                  paylaşılan Freezed varlıkları
  providers/               Riverpod altyapı provider'ları
docs/                      kurulum, şema, durum dokümanları
scripts/                   kurulum ve çalıştırma script'leri
supabase/                  migration'lar, RLS politikaları, CLI yapılandırması
tool/                      arka uç doğrulama betiği
```

---

## 🏗️ Mimari notlar

**Hata yönetimi tek sınırda.** Repository'ler `PostgrestException`,
`DioException` ve `PlatformException`'ı tek bir yerde
([`core/errors/error_mapper.dart`](lib/core/errors/error_mapper.dart)) sealed
`AppException` hiyerarşisine çevirir. Sunum katmanı hiçbir tedarikçi hata kodunu
bilmez; her istisna yerelleştirilmiş metne çözülen sabit bir `code` taşır.

**AI tedarikçiden bağımsız.** Özellik kodu yalnızca `AiService`'i tanır.
Tedarikçiler `AiProvider` arayüzünü uygular; `AiProviderRegistry` kullanıcının
seçimini çözer ve anahtarı olmayan tedarikçiyi atlayarak sıradakine geçer. Yeni
bir tedarikçi eklemek tek dosya yazmak demektir.

**Yetkilendirme RLS politikalarında.** Üyelik `list_members` tablosunda ve
politikalar `security definer` yardımcı fonksiyonlarla rol çözüyor. Bu zorunlu:
`shopping_lists` politikası `list_members`'a, `list_members` politikası
`shopping_lists`'e bakarsa Postgres sonsuz özyinelemeye girer.

**Viewer kısıtı trigger'da, politikada değil.** RLS hangi *satıra*
dokunulabileceğine karar verir, hangi *sütunun değiştiğine* bakamaz; sütun bazlı
`GRANT` de rol yerine listeye göre değişen bir kuralı ifade edemez. Bu yüzden
`items` üstündeki bir `before update` trigger'ı, tamamlanma ve satın alma
alanları dışında bir şey değiştiren *viewer* yazmasını reddediyor.

**Tema token'lar üzerinden.** Her görsel değer `design_tokens.dart` veya
`SpacingTheme` uzantısından gelir. Hiçbir widget renk, yarıçap, gölge veya
boşluk değeri gömmez.

---

## 👥 Roller

| Yetki | Owner | Editor | Viewer | Guest |
|---|:---:|:---:|:---:|:---:|
| Liste ve ürünleri görme | ✅ | ✅ | ✅ | ✅ |
| Ürün ekleme / düzenleme / silme | ✅ | ✅ | — | — |
| Ürünü tamamlandı işaretleme | ✅ | ✅ | ✅ | — |
| Sohbete mesaj yazma | ✅ | ✅ | ✅ | — |
| Üye davet etme | ✅ | ✅ | — | — |
| Üye ve rol yönetimi | ✅ | — | — | — |
| Listeyi silme / devretme | ✅ | — | — | — |

---

## 🔄 CI/CD

[`.github/workflows/ci.yml`](.github/workflows/ci.yml) her push'ta çalışır:

- **verify** — biçim kontrolü, üretilen kodun tazeliği, `flutter analyze`, testler
- **schema** — migration söz dizimini Postgres ayrıştırıcısıyla doğrular
- **android** / **ios** — `main` dalında imzalı AAB ve IPA üretir

> `android` ve `ios` işleri imzalama sertifikalarını ve Supabase değerlerini
> **repository secret**'larından okur. Secret'lar tanımlanmadan bu iki iş
> başarısız görünür; bu beklenen durumdur, kodda sorun olduğu anlamına gelmez.

---

## 📚 Dokümanlar

| Dosya | İçerik |
|---|---|
| **[DURUM_RAPORU.md](DURUM_RAPORU.md)** | Güncel durum raporu: ne çalışıyor, hangi seviyede, sırada ne var |
| **[docs/KURULUM.md](docs/KURULUM.md)** | Sıfırdan kurulum, adım adım, sorun giderme |
| **[docs/SUPABASE_AYARLARI.md](docs/SUPABASE_AYARLARI.md)** | Kodla yapılamayan Dashboard ayarları ve doğrulama betiği |
| **[docs/OZET.md](docs/OZET.md)** | Ne yapıldı / ne yapılmadı (Türkçe) |
| [docs/BUILD_STATUS.md](docs/BUILD_STATUS.md) | Detaylı envanter (İngilizce) |
| [docs/FIRESTORE_SCHEMA.md](docs/FIRESTORE_SCHEMA.md) | Veritabanı şeması ve tasarım kararları |
