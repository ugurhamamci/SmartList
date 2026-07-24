# SmartList

Çiftler, aileler, ev arkadaşları ve arkadaş grupları için **yapay zekâ destekli
ortak alışveriş listesi** uygulaması. Tek Flutter kod tabanından Android ve iOS.

![Flutter](https://img.shields.io/badge/Flutter-3.44.8-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.12.2-0175C2?logo=dart)
![Firebase](https://img.shields.io/badge/Firebase-Firestore%20%7C%20Auth%20%7C%20FCM-FFCA28?logo=firebase)
![Analiz](https://img.shields.io/badge/flutter%20analyze-0%20uyar%C4%B1-brightgreen)
![Test](https://img.shields.io/badge/test-25%20ge%C3%A7ti-brightgreen)

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
# defines.local.ps1 içindeki Firebase değerlerini doldurun

.\scripts\run_dev.ps1                                        # çalıştır
```

---

## 📌 Projenin durumu

Veri, yapılandırma ve servis katmanları **yazıldı ve doğrulandı**:

| Kontrol | Sonuç |
|---|---|
| `flutter analyze` | **0 uyarı / 0 hata** |
| `flutter test` | **25 test geçti** |
| Kod | 52 elle yazılmış dosya, ~5.100 satır |
| Model | 28 Freezed sınıfı, 29 enum |
| Firestore | 28 koleksiyon, rol tabanlı güvenlik kuralları |

### ⚠️ Arayüz henüz yazılmadı

Görev tanımında `tasarim.html` arayüzün **tek doğru kaynağı** olarak belirtilmiş
ve hiçbir görsel değerin değiştirilmemesi istenmişti. Ancak bu dosya **0 bayt**
geldi — boş. Boş bir kaynaktan üretilecek her renk ve boşluk uydurma olurdu, bu
yüzden ekranlar yazılmadı.

Bunun yerine görsel sistem **tek noktadan değiştirilebilir** kuruldu:

- Bütün renk, boşluk, yarıçap, gölge ve süre sabitleri
  [`lib/core/theme/design_tokens.dart`](lib/core/theme/design_tokens.dart) içinde
- Hiçbir widget içine görsel değer gömülmedi
- Mevcut değerler Material 3 varsayılanları ve dosyada bu açıkça yazılı

`tasarim.html` sağlandığında değerleri bu dosyaya aktarmak tüm uygulamanın
görünümünü değiştirmeye yeter.

Detaylı envanter: **[docs/OZET.md](docs/OZET.md)** (Türkçe) ·
**[docs/BUILD_STATUS.md](docs/BUILD_STATUS.md)** (İngilizce)

---

## 🧱 Teknoloji

**Flutter 3.44.8** · **Dart 3.12.2** · Material 3

| Katman | Kullanılan |
|---|---|
| Durum yönetimi | Riverpod, Flutter Hooks |
| Navigasyon | Go Router |
| Modeller | Freezed, json_serializable |
| Backend | Firebase: Firestore, Auth, Storage, FCM, Analytics, Crashlytics, Functions |
| Ağ | Dio |
| Yerel depolama | Hive, Flutter Secure Storage |
| Cihaz | Image Picker, Mobile Scanner, Speech to Text, Permission Handler, Connectivity Plus |
| Arayüz | Google Fonts, Flutter Animate, Lottie, Cached Network Image, fl_chart |
| AI | OpenAI, Gemini, Claude (soyutlanmış — tedarikçiye bağımsız) |

---

## 🔑 Yapılandırma

**Hiçbir Firebase kimliği veya API anahtarı depoda tutulmuyor.** Tüm ortama özel
değerler `--dart-define` ile geliyor; böylece aynı kod tabanı development,
staging ve production projelerini hedefler.

### Zorunlu değerler

| Değişken | Açıklama |
|---|---|
| `FLAVOR` | `development` \| `staging` \| `production` |
| `FIREBASE_PROJECT_ID` | Firebase proje kimliği |
| `FIREBASE_MESSAGING_SENDER_ID` | Platformlar arası ortak |
| `FIREBASE_API_KEY_ANDROID` / `_IOS` / `_WEB` | Platform API anahtarı |
| `FIREBASE_APP_ID_ANDROID` / `_IOS` / `_WEB` | Platform uygulama kimliği |

### Opsiyonel değerler

| Değişken | Varsayılan | Açıklama |
|---|---|---|
| `FIREBASE_STORAGE_BUCKET` | — | Storage kullanılacaksa zorunlu |
| `FIREBASE_AUTH_DOMAIN` | — | Web girişi |
| `FIREBASE_MEASUREMENT_ID` | — | Web analytics |
| `FIREBASE_IOS_BUNDLE_ID` | `com.mudo.smartlist` | iOS bundle kimliği |
| `AI_PROXY_BASE_URL` | — | Sunucu tarafı AI proxy — **üretimde bunu kullanın** |
| `AI_PROVIDER` | `claude` | `claude` \| `openai` \| `gemini` |
| `ANTHROPIC_API_KEY` | — | Yalnızca yerel geliştirme |
| `OPENAI_API_KEY` | — | Yalnızca yerel geliştirme |
| `GEMINI_API_KEY` | — | Yalnızca yerel geliştirme |
| `ENABLE_CRASHLYTICS` | development dışında açık | Çökme raporlama |
| `ENABLE_ANALYTICS` | development dışında açık | Analytics |
| `ENABLE_FIRESTORE_PERSISTENCE` | `true` | Çevrimdışı önbellek |
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
| `.\scripts\run_preview.ps1` | **Arayüzü Firebase olmadan çalıştırır** (telefon/tarayıcı) |
| `.\scripts\run_dev.ps1` | Gerçek uygulamayı çalıştırır (Firebase gerekir) |
| `flutter analyze` | Statik analiz (uyarı vermemeli) |
| `flutter test` | 25 test |
| `dart run build_runner build` | Model değişikliğinden sonra |
| `dart run build_runner watch` | Sürekli üretim (geliştirme) |
| `flutter gen-l10n` | Metin (ARB) değişikliğinden sonra |
| `dart format lib test` | Biçimlendirme |

**Firebase:**

```powershell
firebase emulators:start --only firestore,storage,auth
firebase deploy --only firestore:rules,firestore:indexes,storage
```

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
    config/                flavorlar, derleme yapılandırması, Firebase ayarları
    constants/             Firestore yolları, sabitler, depolama anahtarları
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
```

---

## 🏗️ Mimari notlar

**Hata yönetimi tek sınırda.** Repository'ler `FirebaseException`,
`DioException` ve `PlatformException`'ı tek bir yerde
([`core/errors/error_mapper.dart`](lib/core/errors/error_mapper.dart)) sealed
`AppException` hiyerarşisine çevirir. Sunum katmanı hiçbir tedarikçi hata kodunu
bilmez; her istisna yerelleştirilmiş metne çözülen sabit bir `code` taşır.

**AI tedarikçiden bağımsız.** Özellik kodu yalnızca `AiService`'i tanır.
Tedarikçiler `AiProvider` arayüzünü uygular; `AiProviderRegistry` kullanıcının
seçimini çözer ve anahtarı olmayan tedarikçiyi atlayarak sıradakine geçer. Yeni
bir tedarikçi eklemek tek dosya yazmak demektir.

**Firestore şeması tek okumada yetkilendirilir.** Üyelik liste dokümanına
`memberIds` + `memberRoles` olarak denormalize edildi; böylece "üye olduğum
listeler" tek `array-contains` sorgusu, güvenlik kuralları da alt koleksiyonları
tek bir `get()` ile yetkilendiriyor. Roller alan bazında uygulanıyor: bir
*viewer* bir üründe yalnızca tamamlanma ve satın alma alanlarını değiştirebilir.

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
- **rules** — Firestore kurallarını emülatörde doğrular
- **android** / **ios** — `main` dalında imzalı AAB ve IPA üretir

> `android` ve `ios` işleri imzalama sertifikalarını ve Firebase değerlerini
> **repository secret**'larından okur. Secret'lar tanımlanmadan bu iki iş
> başarısız görünür; bu beklenen durumdur, kodda sorun olduğu anlamına gelmez.

---

## 📚 Dokümanlar

| Dosya | İçerik |
|---|---|
| **[docs/KURULUM.md](docs/KURULUM.md)** | Sıfırdan kurulum, adım adım, sorun giderme |
| **[docs/OZET.md](docs/OZET.md)** | Ne yapıldı / ne yapılmadı (Türkçe) |
| [docs/BUILD_STATUS.md](docs/BUILD_STATUS.md) | Detaylı envanter (İngilizce) |
| [docs/FIRESTORE_SCHEMA.md](docs/FIRESTORE_SCHEMA.md) | Veritabanı şeması ve tasarım kararları |
