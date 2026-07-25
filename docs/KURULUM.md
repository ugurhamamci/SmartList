# SmartList — Sıfırdan Kurulum Kılavuzu

Bu kılavuz **hiçbir şeyin kurulu olmadığı yeni bir bilgisayarda** projeyi
çalıştırmak için yazıldı. Adımları sırayla uygulayın; her adımın sonunda "doğru
gitti mi?" kontrolü var.

Toplam süre: **35–60 dakika** (indirme hızınıza göre). Bunun büyük kısmı Android
Studio ve Flutter indirmesi.

**İçindekiler**

1. [Neye ihtiyacınız var](#1-neye-ihtiyacınız-var)
2. [Git kurulumu](#2-git-kurulumu)
3. [Flutter kurulumu](#3-flutter-kurulumu)
4. [Android Studio ve Android SDK](#4-android-studio-ve-android-sdk)
5. [Kod editörü](#5-kod-editörü)
6. [Projeyi indirme](#6-projeyi-indirme)
7. [Projeyi hazırlama](#7-projeyi-hazırlama)
   · **[7.5 Telefonda hemen görmek (Firebase gerekmez)](#75-telefonda-hemen-görmek-firebase-gerekmez)**
8. [Firebase projesi oluşturma](#8-firebase-projesi-oluşturma)
9. [Firebase değerlerini tanımlama](#9-firebase-değerlerini-tanımlama)
10. [Uygulamayı çalıştırma](#10-uygulamayı-çalıştırma)
11. [Firebase kurallarını yükleme](#11-firebase-kurallarını-yükleme)
12. [Günlük kullanılan komutlar](#12-günlük-kullanılan-komutlar)
13. [Sık karşılaşılan hatalar](#13-sık-karşılaşılan-hatalar)
14. [iOS için ek adımlar](#14-ios-için-ek-adımlar-sadece-mac)

---

## 1. Neye ihtiyacınız var

| Araç | Sürüm | Ne için | Zorunlu? |
|---|---|---|---|
| Git | güncel | Kodu indirmek | **Evet** |
| Flutter | **3.44.8** | Uygulamayı derlemek | **Evet** |
| Android Studio | güncel | Android SDK + emülatör | Android için **evet** |
| JDK | 17 | Android derlemesi | Android Studio ile gelir |
| VS Code | güncel | Kod yazmak | Önerilir |
| Node.js | 20+ | Firebase CLI | Kural yüklerken |
| Xcode | güncel | iOS derlemesi | Sadece Mac |

**Disk alanı:** en az **15 GB** boş yer (Flutter ~3 GB, Android SDK ~8 GB,
proje ve önbellekler ~2 GB).

> ⚠️ Proje **Flutter 3.44.8** ile doğrulandı. Farklı bir sürümde beklenmeyen
> analiz veya derleme hataları görebilirsiniz. Sorun yaşarsanız bu sürüme geçin.

---

## 2. Git kurulumu

1. https://git-scm.com/download/win adresinden indirin.
2. Kurulumda hiçbir şeyi değiştirmeyin, hep **Next** deyin.

**Kontrol** — yeni bir PowerShell penceresi açıp:

```powershell
git --version
```

`git version 2.xx.x` benzeri bir çıktı görmelisiniz.

---

## 3. Flutter kurulumu

### 3.1 İndirme ve açma

```powershell
# Klasörü oluştur
New-Item -ItemType Directory -Force -Path C:\src

# Flutter 3.44.8'i indir (yaklasik 1.8 GB, birkac dakika surer)
$url = 'https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.44.8-stable.zip'
Invoke-WebRequest -Uri $url -OutFile "$env:TEMP\flutter.zip"

# Aç
Expand-Archive -Path "$env:TEMP\flutter.zip" -DestinationPath C:\src -Force
```

Sonuçta `C:\src\flutter\bin\flutter.bat` dosyası olmalı.

> **Neden `C:\src`?** Yol içinde **boşluk veya Türkçe karakter olmamalı**.
> `C:\Program Files` veya `C:\Kullanıcılar\...` gibi yerlere kurmayın, Flutter
> araçları bu yollarda hata verir.

### 3.2 PATH'e ekleme

```powershell
$mevcut = [Environment]::GetEnvironmentVariable('Path', 'User')
if ($mevcut -notlike '*C:\src\flutter\bin*') {
    [Environment]::SetEnvironmentVariable('Path', "C:\src\flutter\bin;$mevcut", 'User')
    Write-Host 'PATH guncellendi.'
}
```

> 🔴 **Bu adımdan sonra terminali kapatıp yeni bir tane açın.** PATH değişikliği
> yalnızca yeni terminallerde geçerli olur. Bu, en sık atlanan adım.

### 3.3 Kontrol

Yeni terminalde:

```powershell
flutter --version
```

Beklenen çıktı:

```
Flutter 3.44.8 • channel stable
Tools • Dart 3.12.2
```

Ardından:

```powershell
flutter doctor
```

Şu an Android bölümünün kırmızı (`[X] Android toolchain`) olması **normal** —
sonraki adımda çözeceğiz.

---

## 4. Android Studio ve Android SDK

Android uygulaması derlemek için gerekli. Sadece web/masaüstünde
çalışacaksanız atlayabilirsiniz.

### 4.1 Kurulum

1. https://developer.android.com/studio adresinden indirin.
2. Kurun ve **açın**.
3. İlk açılışta sihirbaz çıkar: **Standard** kurulumu seçin, **Next → Finish**.
   Bu, Android SDK'yı, komut satırı araçlarını ve emülatör görüntüsünü indirir
   (~8 GB, uzun sürer).

### 4.2 Komut satırı araçları

Android Studio içinde:

**Settings** (`Ctrl+Alt+S`) → **Languages & Frameworks** → **Android SDK** →
**SDK Tools** sekmesi → şunları işaretleyin:

- ✅ Android SDK Command-line Tools
- ✅ Android SDK Build-Tools
- ✅ Android SDK Platform-Tools

**Apply** → indirmesini bekleyin.

### 4.3 Lisansları onaylama

```powershell
flutter doctor --android-licenses
```

Çıkan tüm sorulara `y` yazıp Enter'a basın.

### 4.4 Kontrol

```powershell
flutter doctor
```

Artık şunu görmelisiniz:

```
[√] Flutter (Channel stable, 3.44.8)
[√] Android toolchain - develop for Android devices
[√] Android Studio
```

`[!]` işaretli satırlar (Visual Studio, Xcode gibi) sorun değil — bunlar Windows
masaüstü ve iOS derlemesi için, bu proje onları kullanmıyor.

---

## 5. Kod editörü

**VS Code** (önerilen): https://code.visualstudio.com

Kurduktan sonra şu eklentileri yükleyin (`Ctrl+Shift+X`):

- **Flutter** (Dart-Code.flutter) — Dart eklentisini otomatik getirir
- **Even Better TOML** (opsiyonel)

Android Studio'yu editör olarak da kullanabilirsiniz; Flutter eklentisini
**Settings → Plugins** üzerinden kurmanız gerekir.

---

## 6. Projeyi indirme

```powershell
# Projeyi koyacaginiz klasore gidin, orn:
Set-Location C:\projeler   # yoksa: New-Item -ItemType Directory C:\projeler

git clone https://github.com/ugurhamamci/SmartList.git
Set-Location SmartList
```

Depo **private** olduğu için GitHub kimlik doğrulaması isteyecek. Bir tarayıcı
penceresi açılır, `ugurhamamci` hesabıyla onaylarsınız.

Pencere açılmazsa GitHub CLI ile giriş yapın:

```powershell
winget install --id GitHub.cli     # kurulu degilse
gh auth login                       # GitHub.com > HTTPS > web browser
```

**Kontrol:**

```powershell
git log --oneline -1
```

`71900ac Scaffold SmartList: ...` benzeri bir satır görmelisiniz.

---

## 7. Projeyi hazırlama

Depoda bu işi yapan bir script var:

```powershell
.\scripts\setup.ps1
```

Script sırayla şunları yapar:

1. Flutter sürümünü doğrular
2. `flutter pub get` — paketleri indirir
3. `dart run build_runner build` — **üretilen kodu oluşturur**
4. `flutter gen-l10n` — yerelleştirme sınıflarını oluşturur
5. `flutter analyze` ve `flutter test` — her şeyin doğru olduğunu kanıtlar

Script çalışmazsa (PowerShell politikası engellerse):

```powershell
powershell -ExecutionPolicy Bypass -File scripts\setup.ps1
```

Ya da adımları elle yapın:

```powershell
flutter pub get
dart run build_runner build
flutter gen-l10n
flutter analyze
flutter test
```

### Başarılı sonuç şu şekilde görünür

```
flutter analyze  ->  No issues found!
flutter test     ->  All tests passed!   (25 test)
```

> **3. adım neden gerekli?** Projedeki modeller `Freezed` ve
> `json_serializable` ile üretilen kod kullanıyor. Bu dosyalar depoda mevcut,
> ama paket sürümleri makinenize göre çözüldüğü için yeniden üretmek en
> güvenlisi. Model dosyalarını her değiştirdiğinizde bu komutu tekrar
> çalıştırmalısınız.

---

## 7.5 Telefonda hemen görmek (Firebase gerekmez)

Firebase projesi kurmadan, arayüzü telefonunda çalıştırabilirsin. Ayrı bir giriş
noktası var: `lib/main_preview.dart`. Firebase'e hiç dokunmaz, veriyi bellekte
tutar, tüm ekranlar ve etkileşimler çalışır.

### Telefonu bağla

1. Telefonda **Ayarlar → Telefon hakkında → Yapı numarası**'na 7 kez dokun →
   Geliştirici seçenekleri açılır.
2. **Ayarlar → Geliştirici seçenekleri → USB ile hata ayıklama**'yı aç.
3. USB kablosuyla bağla. Telefonda çıkan **"USB hata ayıklamaya izin ver?"**
   uyarısını onayla.

Kontrol:

```powershell
flutter devices
```

Telefonun listede görünmeli. Görünmüyorsa: kabloyu değiştir (bazı kablolar
yalnızca şarj eder), USB modunu **Dosya aktarımı (MTP)** yap, `adb kill-server`
sonra tekrar dene.

### Çalıştır

```powershell
.\scripts\run_preview.ps1
```

İlk Android derlemesi Gradle bağımlılıklarını indirdiği için **10 dakikayı
aşabilir**. Sonraki çalıştırmalar saniyeler sürer.

Kurulabilir dosya üretmek istersen:

```powershell
.\scripts\run_preview.ps1 -Build apk
# çıktı: build\app\outputs\flutter-apk\app-release.apk
```

Bu APK'yı telefona kopyalayıp kurabilirsin — kablo bağlı olmasa da çalışır.

> ⚠️ **Düz `flutter run` çalıştırmayın.** O `main.dart`'ı kullanır ve Firebase
> değerlerini ister; hangi `--dart-define`'ın eksik olduğunu söyleyen bir hata
> ekranı görürsünüz. Bu bir hata değil, kasıtlı davranış. Gerçek uygulamayı
> çalıştırmak için önce 8. ve 9. bölümleri tamamlayın, sonra `run_dev.ps1`
> kullanın.

### Önizlemede ne çalışıyor

| İşlem | Sonuç |
|---|---|
| Açılış | Logo animasyonu, ardından ana ekran |
| Liste kartına dokun | Liste detayı açılır |
| Checkbox | Tik yaylanarak gelir, ürün Tamamlananlar'a geçer |
| Sağa kaydır | Ürün tamamlanır |
| Sola kaydır | Ürün silinir |
| FAB (+) | Ürün ekleme sayfası; eklenen ürün listenin başına gelir |
| Alt sekmeler | Lists, Activity, Shared, Profile |

Servisi henüz bağlanmamış butonlar (barkod, sesle ekleme, arama) sessiz kalmaz,
"yakında" bildirimi gösterir.

---

## 8. Firebase projesi oluşturma

Uygulama Firebase olmadan **açılmaz** — başlangıçta hangi değerin eksik
olduğunu söyleyen bir hata ekranı gösterir.

### 8.1 Proje oluşturma

1. https://console.firebase.google.com adresine gidin.
2. **Proje ekle** → ad: `smartlist-dev` → **Devam**.
3. Google Analytics'i şimdilik kapatabilirsiniz → **Proje oluştur**.

### 8.2 Android uygulaması ekleme

1. Proje ana sayfasında **Android** ikonuna tıklayın.
2. **Android paket adı:** `com.fuurstudio.smartlist`
   > Bu değer tam olarak böyle olmalı, aksi halde Firebase uygulamayı tanımaz.
3. **Uygulamayı kaydet**.
4. `google-services.json` indirmenizi ister — **indirmenize gerek yok.** Bu
   proje tüm değerleri `--dart-define` ile alıyor, dosyayı kullanmıyor.
   **Sonraki → Sonraki → Konsola devam et** deyin.

### 8.3 Gerekli servisleri açma

Sol menüden sırayla:

| Servis | Yapılacak |
|---|---|
| **Authentication** | Başlayın → **Sign-in method** → **E-posta/Şifre**'yi etkinleştir |
| **Firestore Database** | Veritabanı oluştur → **Production mode** → bölge: `eur3` veya `europe-west` |
| **Storage** | Başlayın → varsayılan ayarlar |

> Firestore'u **Production mode** seçin. Test mode 30 gün sonra tüm erişimi
> kapatır. Bu projenin kendi güvenlik kuralları var; 11. bölümde yükleyeceğiz.

### 8.4 Değerleri toplama

**Proje ayarları** (sol üstteki ⚙️ dişli) → **Genel** sekmesi:

| Nerede | Hangi değer |
|---|---|
| Proje kimliği | `FIREBASE_PROJECT_ID` |
| Uygulamalarınız → Android → Uygulama kimliği | `FIREBASE_APP_ID_ANDROID` |
| Uygulamalarınız → Android → API anahtarı | `FIREBASE_API_KEY_ANDROID` |
| **Cloud Messaging** sekmesi → Gönderen kimliği | `FIREBASE_MESSAGING_SENDER_ID` |
| **Genel** → Varsayılan GCS paketi | `FIREBASE_STORAGE_BUCKET` |

Bu beş değeri bir kenara not edin.

---

## 9. Firebase değerlerini tanımlama

Şablonu kopyalayın:

```powershell
Copy-Item scripts\defines.example.ps1 scripts\defines.local.ps1
```

`scripts\defines.local.ps1` dosyasını açıp `BURAYA-...` yazan yerleri
8.4'te not ettiğiniz değerlerle değiştirin:

```powershell
@{
    FLAVOR                       = 'development'
    FIREBASE_PROJECT_ID          = 'smartlist-dev'
    FIREBASE_MESSAGING_SENDER_ID = '123456789012'
    FIREBASE_API_KEY_ANDROID     = 'AIzaSy...'
    FIREBASE_APP_ID_ANDROID      = '1:123456789012:android:abc123'
    FIREBASE_STORAGE_BUCKET      = 'smartlist-dev.appspot.com'
}
```

> 🔒 `defines.local.ps1` `.gitignore` içinde — **asla depoya gitmez**. Gerçek
> değerleri `defines.example.ps1` dosyasına yazmayın, o dosya depoda izleniyor.

---

## 10. Uygulamayı çalıştırma

### 10.1 Bir cihaz hazırlayın

**Emülatör:** Android Studio → sağ üstteki **Device Manager** →
**Create Device** → herhangi bir telefon → sistem görüntüsünü indir → ▶ ile
başlat.

**Gerçek telefon:** USB ile bağlayın, telefonda **Geliştirici seçenekleri** ve
**USB ile hata ayıklama**yı açın.

Kontrol:

```powershell
flutter devices
```

Cihazınız listede görünmeli.

### 10.2 Çalıştırın

```powershell
.\scripts\run_dev.ps1
```

Script `defines.local.ps1` değerlerini okuyup `flutter run` komutunu tüm
`--dart-define` parametreleriyle çalıştırır.

Belirli bir cihaz seçmek için:

```powershell
.\scripts\run_dev.ps1 -Device emulator-5554
.\scripts\run_dev.ps1 -Device chrome        # tarayicida
```

### 10.3 Ne göreceksiniz

**Yapılandırma durum ekranı.** Flavor, crash reporting, AI sağlayıcıları ve
bağlantı durumunu listeleyen sade bir liste, altında "Interface pending"
uyarısı.

**Bu bir hata değil.** Uygulamanın arayüzü henüz yazılmadı, çünkü tasarımın tek
doğru kaynağı olan `tasarim.html` dosyası boş (0 bayt) geldi. Ayrıntı için
[BUILD_STATUS.md](BUILD_STATUS.md).

Bu ekranı görüyorsanız **kurulum başarılı**: Flutter, Android SDK, Firebase
bağlantısı ve tüm servis katmanı çalışıyor demektir.

Hata ekranı görüyorsanız → [13. bölüm](#13-sık-karşılaşılan-hatalar).

---

## 11. Firebase kurallarını yükleme

Güvenlik kuralları depoda hazır; Firebase projenize yüklemeniz gerekiyor.

```powershell
# Firebase CLI (Node.js gerektirir)
npm install -g firebase-tools

firebase login
firebase use --add          # projenizi secin, takma ad: default

# Kurallari ve indeksleri yukle
firebase deploy --only firestore:rules,firestore:indexes,storage
```

> ⚠️ **Bu adımı atlarsanız** uygulama Firestore'a erişemez ve her okuma
> `permission-denied` hatası verir. Production mode varsayılan olarak her şeyi
> reddeder.

Yerel emülatörle çalışmak isterseniz (gerçek veriye dokunmadan):

```powershell
firebase emulators:start --only firestore,storage,auth
```

---

## 12. Günlük kullanılan komutlar

| Komut | Ne yapar |
|---|---|
| `.\scripts\run_dev.ps1` | Uygulamayı çalıştırır |
| `flutter analyze` | Statik analiz — **hiç uyarı vermemeli** |
| `flutter test` | Testleri koşar (25 test) |
| `dart run build_runner build` | Model değiştirdikten sonra kodu üretir |
| `dart run build_runner watch` | Değişiklikleri izleyip otomatik üretir |
| `flutter gen-l10n` | ARB (metin) dosyası değiştirdikten sonra |
| `dart format lib test` | Kod biçimlendirme |
| `flutter clean` | Derleme önbelleğini temizler |

### Ne zaman hangi komut

- **Model dosyası değiştirdim** (`lib/models/...`) → `dart run build_runner build`
- **Metin ekledim** (`lib/l10n/app_en.arb`) → `flutter gen-l10n`
- **Paket ekledim** (`pubspec.yaml`) → `flutter pub get`
- **Tuhaf derleme hatası** → `flutter clean` sonra `flutter pub get`

### Commit atmadan önce

```powershell
dart format lib test
flutter analyze          # temiz olmali
flutter test             # gecmeli
```

CI aynı kontrolleri yapıyor; yerelde geçmezse GitHub'da da geçmez.

---

## 13. Sık karşılaşılan hatalar

### `flutter: command not found` / `flutter tanınmıyor`

PATH ayarlandıktan sonra **yeni terminal açmadınız**. Terminali kapatıp
yeniden açın. Hâlâ olmuyorsa:

```powershell
[Environment]::GetEnvironmentVariable('Path', 'User') -split ';' | Select-String flutter
```

Çıktı boşsa 3.2 adımını tekrar yapın.

---

### `SmartList could not start` — Firebase hata ekranı

Uygulama açıldı ama "Firebase could not be initialised" yazıyor.

**Sebep:** Bir veya birkaç `--dart-define` değeri eksik.

**Çözüm:** `scripts\defines.local.ps1` dosyasını kontrol edin — `BURAYA-` ile
başlayan değer kalmamalı. Uygulamayı `run_dev.ps1` ile başlattığınızdan emin
olun; düz `flutter run` komutu değerleri iletmez.

---

### `permission-denied` — Firestore erişim hatası

Güvenlik kuralları Firebase projenize yüklenmemiş. [11. bölümü](#11-firebase-kurallarını-yükleme)
uygulayın.

---

### `build_runner` hata veriyor / çakışma bildiriyor

Önbellekte kalmış eski çıktı en sık sebeptir. Önbelleği silip sıfırdan üretin:

```powershell
dart run build_runner clean
dart run build_runner build
```

`setup.ps1` bunu zaten kendisi dener; elle çalıştırıyorsanız bu iki komut.

Sürmesi hâlinde:

```powershell
flutter clean
flutter pub get
dart run build_runner build
```

> ⚠️ **`--delete-conflicting-outputs` bayrağını kullanmayın.** İnternetteki
> eski anlatımlarda geçer ama bu projedeki build_runner sürümünde **kaldırıldı**.
> Yazarsanız `These options have been removed and were ignored` uyarısı alırsınız;
> bir harf hatası olursa da komut tümden hata verir. Karşılığı
> `build_runner clean` komutudur.

---

### `Target of URI hasn't been generated` — üretilmemiş dosya hatası

`app_localizations.dart` veya `*.freezed.dart` bulunamıyor.

```powershell
dart run build_runner build
flutter gen-l10n
```

VS Code'da hata devam ederse `Ctrl+Shift+P` → **Dart: Restart Analysis Server**.

---

### `Android license status unknown`

```powershell
flutter doctor --android-licenses
```

Tüm sorulara `y`.

---

### `cmdline-tools component is missing`

Android Studio → Settings → Android SDK → **SDK Tools** →
**Android SDK Command-line Tools** işaretleyin → Apply.

---

### `Gradle task assembleDebug failed` — ilk derleme hatası

İlk Android derlemesi Gradle bağımlılıklarını indirir ve **çok uzun sürebilir**
(10+ dakika). İnternet bağlantınızı kontrol edin ve bekleyin. Gerçekten
başarısız olursa:

```powershell
flutter clean
flutter pub get
.\scripts\run_dev.ps1
```

---

### PowerShell script çalıştırmıyor

```
bu sistemde betik çalıştırma devre dışı bırakıldığından yüklenemiyor
```

Tek seferlik çözüm:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\setup.ps1
```

Kalıcı çözüm (kendi kullanıcınız için):

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

---

### Depo klonlanmıyor / kimlik doğrulama döngüsü

```powershell
gh auth login          # GitHub.com > HTTPS > web browser
git clone https://github.com/ugurhamamci/SmartList.git
```

---

## 14. iOS için ek adımlar (sadece Mac)

Windows'ta iOS derlemesi **mümkün değil**. Mac'te:

```bash
# Xcode'u App Store'dan kurun, sonra:
sudo xcode-select --install
sudo xcodebuild -license accept

# CocoaPods
sudo gem install cocoapods
cd ios && pod install && cd ..
```

Firebase Console'da bir **iOS uygulaması** ekleyin (bundle id:
`com.fuurstudio.smartlist`), `FIREBASE_API_KEY_IOS` ve `FIREBASE_APP_ID_IOS`
değerlerini `defines.local.ps1` karşılığınıza ekleyin.

Mac'te PowerShell yoksa komutu elle yazın:

```bash
flutter run \
  --dart-define=FLAVOR=development \
  --dart-define=FIREBASE_PROJECT_ID=... \
  --dart-define=FIREBASE_MESSAGING_SENDER_ID=... \
  --dart-define=FIREBASE_API_KEY_IOS=... \
  --dart-define=FIREBASE_APP_ID_IOS=...
```

---

## Kurulum tamamlandı — sırada ne var?

Projenin mevcut durumu ve eksikler:

- **[OZET.md](OZET.md)** — ne yapıldı, ne yapılmadı (Türkçe)
- **[BUILD_STATUS.md](BUILD_STATUS.md)** — detaylı envanter (İngilizce)
- **[FIRESTORE_SCHEMA.md](FIRESTORE_SCHEMA.md)** — veritabanı şeması ve gerekçeleri

En önemli eksik: **arayüz yazılmadı**, çünkü `tasarim.html` boş geldi. Dosyayı
sağladığınızda renkleri ve boşlukları
[`lib/core/theme/design_tokens.dart`](../lib/core/theme/design_tokens.dart)
içine aktarmak yeterli — hiçbir widget içine görsel değer gömülmedi.
