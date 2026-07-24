# SmartList — Yapılan İşler Özeti

Bu doküman, projede fiilen ne yapıldığını ve neyin yapılmadığını olduğu gibi
anlatır. 24 Temmuz 2026 tarihinde Flutter 3.44.8 ile doğrulanmıştır.

## Doğrulama sonuçları

| Kontrol | Sonuç |
|---|---|
| `flutter analyze` | **Hiç uyarı/hata yok** (`lib/` + `test/`) |
| `flutter test` | **25 test geçti** |
| `dart format` | Tüm dosyalar biçimlendirildi |
| `dart run build_runner build` | 40 dosya sorunsuz üretildi |
| `flutter gen-l10n` | Yerelleştirme sınıfları üretildi |

Rakamlarla: elle yazılmış **52 Dart dosyası / ~5.100 satır**, ek olarak
kod üreticilerinin ürettiği **40 dosya**, **20 dosyada 28 Freezed sınıfı**,
**29 enum**, **50 paket** (40 çalışma zamanı + 10 geliştirme).

---

## ⚠️ Engelleyici: `tasarim.html` boş

**Arayüz (UI) yazılmadı.** Görev tanımında `tasarim.html` arayüzün tek doğru
kaynağı olarak belirtilmiş; renk, boşluk, tipografi, ölçü, padding, margin,
köşe yarıçapı, gölge ve yerleşimin **hiçbirinin değiştirilmemesi** istenmişti.

Ancak bu dosya **0 bayt**. Üç ayrı yöntemle doğrulandı:

- Dosya boyutu: 0
- Satır sayısı: 0
- Tek NTFS veri akışı (`:$DATA`) da 0 bayt — yani alternatif akışta da içerik yok

Masaüstü, İndirilenler ve Belgeler klasörleri de tarandı; bulunan diğer HTML
dosyaları (`mudoarch-presentation.html`, `Mudoarch-Tanitim.html`) SmartList ile
ilgisiz.

**Neden bir tasarım uydurmadım:** Boş bir kaynaktan üretilecek her renk ve her
boşluk değeri benim icadım olurdu — yani tam olarak yapılmaması istenen şey. Ve
gerçek dosya geldiğinde tamamı çöpe giderdi.

**Bunun yerine görsel sistemi tek noktadan değiştirilebilir hâle getirdim:**

- [`lib/core/theme/design_tokens.dart`](../lib/core/theme/design_tokens.dart) —
  bütün renk, yarıçap, boşluk, gölge, süre ve ölçü sabitleri burada. Şu anki
  değerler **Material 3 varsayılanları** ve dosyanın içinde bunun SmartList
  tasarımı *olmadığı* açıkça yazılı.
- [`lib/core/theme/spacing_theme.dart`](../lib/core/theme/spacing_theme.dart) —
  bu değerleri `ThemeExtension` üzerinden `context.spacing` olarak sunar.
- **Hiçbir widget içine görsel değer gömülmedi.** Bu iki dosyadaki sabitleri
  değiştirmek tüm uygulamanın görünümünü değiştirir.

`tasarim.html` dosyasını VSCode'da açıksanız muhtemelen **kaydedilmemiş**
durumdadır — o sekmede `Ctrl+S` yapmanız yeterli olabilir.

---

## Yapılanlar

### 1. Ortam kurulumu

- Flutter SDK **3.44.8** (Dart 3.12.2) indirildi ve `C:\src\flutter` altına
  kuruldu; kullanıcı `PATH`'ine kalıcı olarak eklendi.
- `flutter doctor` ile doğrulandı.
- Proje `flutter create` ile iskeletlendi (paket adı `smartlist`, organizasyon
  `com.mudo`).

Kurulum sırasında iki gerçek bağımlılık çakışması çıktı ve çözüldü:

- **`hive_generator`** terk edilmiş durumda (analyzer 6 ve freezed_annotation 2'ye
  sabitlenmiş), freezed 3 ile çakışıyor. Kaldırıldı — modeller zaten
  `json_serializable` ile serileşiyor, önbellek JSON map olarak tutuluyor, yani
  adapter üretimine hiç gerek yok.
- **`riverpod_lint` + `custom_lint`** şu anda riverpod 3.3.2 ile çözülemeyen bir
  analyzer sürüm çakışması yaşıyor. İkisi de istenen teknoloji listesinde
  değildi; katı lint zaten `very_good_analysis` ile sağlanıyor.
- `freezed` önce bir ön-yayın (`3.2.6-dev.1`) sürümüne düşmüştü; kararlı
  **3.2.5**'e sabitlendi.

### 2. Firebase arka ucu

| Dosya | İçerik |
|---|---|
| [`firestore.rules`](../firestore.rules) | Rol tabanlı güvenlik kuralları |
| [`storage.rules`](../storage.rules) | Depolama kuralları (tip + boyut doğrulaması) |
| [`firestore.indexes.json`](../firestore.indexes.json) | Bileşik indeksler + alan muafiyetleri |
| [`firebase.json`](../firebase.json) | Kurallar, indeksler, functions, emülatörler |
| [`docs/FIRESTORE_SCHEMA.md`](FIRESTORE_SCHEMA.md) | Şemanın tamamı ve tasarım gerekçeleri |

İstenen **28 koleksiyonun tamamı** tasarlandı. Öne çıkan kararlar:

- **Üyelik liste dokümanına denormalize edildi.** `memberIds` (dizi) +
  `memberRoles` (uid→rol haritası). Böylece "üye olduğum listeler" tek bir
  `array-contains` sorgusu; güvenlik kuralları da alt koleksiyonları **tek bir
  `get()`** ile yetkilendiriyor. Kurallar bu iki alanın ve `memberCount`'un
  tutarlı kalmasını zorunlu kılıyor.
- **Rol yetkileri alan bazında.** Bir *viewer* bir üründe yalnızca
  `isCompleted`, `completedAt`, `purchasedBy`, `purchasedAt` ve denetim
  alanlarını değiştirebilir — doküman bazlı değil, alan bazlı kısıtlama.
- **Okundu bilgisi ve tepkiler dizi değil harita.** `readBy` ve `reactions`
  uid ile anahtarlanıyor; her yazan yalnızca kendi anahtarına dokunduğu için eş
  zamanlı yazmalar birbirini ezmiyor.
- **Sıralama seyrek `double`.** `sortOrder` aralıklı verildiği için sürükle-bırak
  ile yeniden sıralama **tek doküman** yazıyor, koleksiyonun tamamını yeniden
  numaralamıyor.
- **Presence liste bazlı ve kendini onarıyor.** Zaman aşımına uğramış nabız
  kaydı çevrimdışı sayılıyor; çöken istemci kalıcı "çevrimiçi" izi bırakmıyor.
- **Yetkiler (premium) yalnızca sunucudan yazılabilir.** `isPremium` ve
  `subscriptionTier` istemci yazmalarında reddediliyor.
- **Denetim kayıtları yalnızca ekleme.** `activity_logs` üzerinde update/delete
  yasak; iz kurcalanamaz.
- Her mutable doküman aynı denetim bloğunu taşıyor: `createdAt`, `createdBy`,
  `updatedAt`, `updatedBy`, `deletedAt` (yumuşak silme), `version` (iyimser
  eşzamanlılık).

### 3. Çekirdek (core) katman

| Dosya | Görev |
|---|---|
| [`core/config/app_config.dart`](../lib/core/config/app_config.dart) | Derleme zamanı yapılandırma |
| [`core/config/app_flavor.dart`](../lib/core/config/app_flavor.dart) | development / staging / production |
| [`core/config/feature_flags.dart`](../lib/core/config/feature_flags.dart) | Abonelik kademeleri ve özellik bayrakları |
| [`core/config/firebase_options.dart`](../lib/core/config/firebase_options.dart) | Firebase ayarları `--dart-define` ile |
| [`core/errors/app_exception.dart`](../lib/core/errors/app_exception.dart) | 13 tipli sealed hata hiyerarşisi |
| [`core/errors/error_mapper.dart`](../lib/core/errors/error_mapper.dart) | Tedarikçi hatalarını tek sınırda çeviren eşleyici |
| [`core/bootstrap.dart`](../lib/core/bootstrap.dart) | Başlatma, global hata yakalama, kalıcılık |
| [`core/database/local_cache.dart`](../lib/core/database/local_cache.dart) | Hive tabanlı çevrimdışı önbellek |
| [`core/constants/firestore_paths.dart`](../lib/core/constants/firestore_paths.dart) | Tüm yol ve alan adları tek yerde |
| [`core/utils/json_converters.dart`](../lib/core/utils/json_converters.dart) | Timestamp / Duration / sayı dönüştürücüleri |
| [`core/utils/app_logger.dart`](../lib/core/utils/app_logger.dart) | Sürüm derlemesinde içerik sızdırmayan kayıt |

Dikkat çeken iki nokta:

- **Hata yönetimi tek sınırda.** `FirebaseException`, `DioException` ve
  `PlatformException` yalnızca `error_mapper.dart` içinde yorumlanıyor. Sunum
  katmanı hiçbir tedarikçi hata kodunu bilmiyor; her istisna yerelleştirilmiş
  metne çözülen sabit bir `code` taşıyor.
- **Firebase kimlikleri kaynak koda girmiyor.** Hepsi `--dart-define` ile
  geliyor. Eksik bir değişken varsa uygulama, hangi değişkenin eksik olduğunu
  söyleyen bir ekranla **hemen** duruyor — sessiz çalışma zamanı hatası yok.

### 4. Veri modeli

- **20 dosyada 28 Freezed sınıfı** (`AppUser`, `ShoppingList`, `ShoppingItem`,
  `ChatMessage`, `ChatRoom`, `ListMember`, `Invitation`, `UserPresence`,
  `AppNotification`, `ActivityLog`, `UserSettings`, `UserStatistics`,
  `DeviceToken`, `SharedLink`, `ShoppingTemplate`, `BarcodeScan`,
  `VoiceCommand`, `Favorite`, `RecentSearch`, `ProductCategory` ve AI modelleri).
- **29 enum**, hepsi kalıcı `wire` değerleriyle — `firestore.rules` ile
  eşleşiyor, yani bir enum adını değiştirmek kural değişikliği gerektirdiği
  belgeleniyor.
- İş kuralları modellerde uzantı olarak yaşıyor: `progress` sıfıra bölmüyor,
  `remainingItemCount` negatif dönmüyor, `roleOf` üye olmayan için `guest`
  veriyor, `UserPresence.isActive` bayrağa değil nabız yaşına bakıyor.

### 5. AI katmanı — eksiksiz ve çalışır

İstenen "tedarikçiye bağımlı olmayan AI servis katmanı" tamamlandı.

| Dosya | Görev |
|---|---|
| [`ai/domain/ai_provider.dart`](../lib/features/ai/domain/ai_provider.dart) | Soyut arayüz + tedarikçi kayıt/geri çekilme mekanizması |
| [`ai/domain/ai_service.dart`](../lib/features/ai/domain/ai_service.dart) | Uygulamanın tek giriş noktası |
| [`ai/domain/prompt_builder.dart`](../lib/features/ai/domain/prompt_builder.dart) | İstem kurucu + JSON şeması |
| [`ai/data/claude_ai_provider.dart`](../lib/features/ai/data/claude_ai_provider.dart) | Anthropic |
| [`ai/data/openai_ai_provider.dart`](../lib/features/ai/data/openai_ai_provider.dart) | OpenAI |
| [`ai/data/gemini_ai_provider.dart`](../lib/features/ai/data/gemini_ai_provider.dart) | Google Gemini |

- Uygulama kodu **yalnızca `AiService`'i** tanır. Tedarikçi ayarlardan
  seçiliyor; seçilen tedarikçinin anahtarı yoksa kayıt listesi sıradaki
  yapılandırılmış tedarikçiye geçiyor — yani eksik anahtar çökme değil, zarif
  bir geri çekilme.
- Yeni bir tedarikçi eklemek **tek dosya** yazmak demek.
- Anthropic entegrasyonunu ezberden yazmak yerine güncel API referansını
  yükleyip yazdım. Bu nedenle: model `claude-opus-5`; `temperature`/`top_p`/
  `top_k` **gönderilmiyor** (bu model ailesinde HTTP 400 döner); `content`
  okunmadan **önce** `stop_reason` reddedilme için kontrol ediliyor.
- Üç tedarikçinin de reddetme, kesilme (truncation) ve token kullanımı tek bir
  `AiResponse` şekline normalize ediliyor.
- Üretilen liste ayrıştırması savunmalı: metne veya ``` bloğuna sarılmış JSON
  kurtarılıyor, adı olmayan satır tüm üretimi düşürmek yerine atlanıyor.
- Desteklenen üretim türleri: haftalık alışveriş, yemek planı, parti, bebek,
  diyet ve serbest istek.

### 6. Kalite, yerelleştirme, CI/CD

- [`analysis_options.yaml`](../analysis_options.yaml) — `very_good_analysis` +
  katı tip kontrolleri (`strict-casts`, `strict-inference`, `strict-raw-types`);
  ölü kod, kullanılmayan içe aktarma ve kapatılmayan `Sink`'ler **hata** sayılıyor.
- Yerelleştirme altyapısı + **40 İngilizce metin**
  ([`lib/l10n/app_en.arb`](../lib/l10n/app_en.arb)). Yeni dil eklemek yeni bir
  ARB dosyası demek.
- **25 test** ([`test/`](../test)): model iş kuralları, AI ayrıştırma ve
  geri çekilme davranışı, tema/erişilebilirlik (48dp dokunma hedefi).
- [`.github/workflows/ci.yml`](../.github/workflows/ci.yml) — biçim kontrolü,
  **üretilen kodun bayatlamadığının doğrulanması**, analiz, test, Firestore
  kurallarının emülatörde doğrulanması, `staging` + `production` için imzalı
  Android (AAB) ve iOS (IPA) derlemeleri.

### 7. Dokümantasyon

- [`README.md`](../README.md) — kurulum, tüm `--dart-define` değişkenleri,
  komutlar, mimari notlar
- [`docs/FIRESTORE_SCHEMA.md`](FIRESTORE_SCHEMA.md) — şema ve gerekçeler
- [`docs/BUILD_STATUS.md`](BUILD_STATUS.md) — ne var / ne yok (İngilizce)
- Bu dosya — Türkçe özet

---

## Yapılmayanlar

### Tasarım dosyasına bağlı olanlar

Her ekran ve widget: kimlik doğrulama ekranları, ana sayfa, liste ve ürün
ekranları, sohbet arayüzü, bildirim merkezi, profil, ayarlar, istatistik
ekranları ve grafikler, barkod tarayıcı arayüzü, sesli giriş arayüzü, AI üretim
ve onay sayfaları, karşılama akışı, boş/yükleniyor durumları, Lottie
animasyonları, sayfa geçişleri, sürükle-bırak ve kaydırma etkileşimleri.

### Tasarımdan bağımsız olup hâlâ eksik olanlar

Bunların hiçbiri engelli değil; dayandıkları modeller, yollar, kurallar ve hata
yönetimi hazır. Tek pasta içinde bitiremediğim için kaldılar.

- AI dışındaki her varlık için repository'ler ve özellik provider'ları
- Kimlik doğrulama servisi: e-posta/şifre, Google, Apple, doğrulama, sıfırlama,
  oturum kalıcılığı
- Gerçek zamanlı işbirliği: presence nabzı, yazıyor göstergesi, okundu bilgisi,
  çakışma çözümü (veri modeli ve zaman aşımı sabitleri mevcut)
- Sohbet repository'si
- FCM kaydı/işleyicileri ve Cloud Functions (bildirim dağıtımı, denormalize
  sayaçların bakımı, istatistik toplama, davet işleme) — kurallar bu
  fonksiyonların bu yazmaların sahibi olduğunu **zaten** varsayıyor
- Barkod tarama servisi ve sesli giriş (speech-to-text) servisi — modelleri
  (`BarcodeScan`, `VoiceCommand`, `ParsedVoiceItem`) ve geçmiş koleksiyonları hazır
- Çevrimdışı mutasyon kuyruğu ve senkronizasyon motoru — `LocalCache`,
  `pending_mutations` kutusu, `SyncState` ve `MutationKind` hazır; kuyruk
  işleyicisi yok
- Go Router yapılandırması ve rota koruyucuları
- Veri dışa aktarma ve hesap silme akışları
- Ek diller (altyapı ve İngilizce ARB hazır)
- Entegrasyon testleri (`integration_test` paketi bağlı)

---

## Ortam kısıtları

Flutter SDK bu çalışma sırasında kuruldu. Bu makinede iki eksik kaldı:

- **Android SDK yok.** `flutter analyze` ve `flutter test` çalışıyor, ancak
  yerelde APK/AAB üretilemiyor. CI bunu karşılıyor.
- **Visual Studio C++ iş yükü yok**, dolayısıyla Windows masaüstü hedefi
  derlenemiyor. Chrome ve Edge mevcut.

iOS derlemesi macOS gerektirir; CI'daki `ios` işi bunu yapıyor.

---

## Komutlar

```sh
flutter pub get
dart run build_runner build      # Freezed + json_serializable
flutter gen-l10n                 # yerelleştirme

flutter analyze                  # hiç uyarı vermemeli
flutter test                     # 25 test

flutter run \
  --dart-define=FLAVOR=development \
  --dart-define=FIREBASE_PROJECT_ID=... \
  --dart-define=FIREBASE_MESSAGING_SENDER_ID=... \
  --dart-define=FIREBASE_API_KEY_ANDROID=... \
  --dart-define=FIREBASE_APP_ID_ANDROID=...
```

Model değiştirdikten sonra `build_runner`, ARB değiştirdikten sonra `gen-l10n`
yeniden çalıştırılmalı. Geliştirme sırasında `dart run build_runner watch` daha
hızlı.

Firebase:

```sh
firebase emulators:start --only firestore,storage,auth
firebase deploy --only firestore:rules,firestore:indexes,storage
```

> **Üretim notu:** Üretim derlemelerinde `AI_PROXY_BASE_URL` verin ve tedarikçi
> API anahtarı **vermeyin**. İkili dosyaya gömülen anahtar çıkarılabilir; proxy
> anahtarı sunucu tarafında tutar. Doğrudan anahtar yolu yalnızca yerel
> geliştirme için var.

---

## Nasıl devam edilir

1. **Boş olmayan `tasarim.html` dosyasını sağlayın** (VSCode'da `Ctrl+S`).
2. Dosyadaki renk, tipografi, boşluk, yarıçap ve gölgeleri
   `design_tokens.dart` ile `spacing_theme.dart` içine aktarın.
3. Ekranları bu token'lar üzerinden kurun ve geçici
   [`build_status_screen.dart`](../lib/features/shared/presentation/screens/build_status_screen.dart)
   dosyasını silin.
4. Yukarıdaki "tasarımdan bağımsız eksikler" listesini tamamlayın.
