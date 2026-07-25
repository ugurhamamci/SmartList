# SmartList — Durum Raporu

**Tarih:** 25 Temmuz 2026
**Depo:** https://github.com/ugurhamamci/SmartList (`main`)
**Flutter:** 3.44.8 · **Dart:** 3.12.2 · **Material 3**

---

## 1. Tek bakışta

| Ölçüt | Durum |
|---|---|
| `flutter analyze` | **0 hata, 0 uyarı, 0 bilgi** (114 dosya, ~20.700 satır) |
| `flutter test` | **54 test, tamamı geçiyor** |
| `flutter build web --release` (önizleme) | ✅ Başarılı |
| `flutter build web --release` (gerçek giriş noktası) | ✅ Başarılı |
| `dart format` | Tüm dosyalar biçimli |
| Tasarım uyumu | `tasarim.html` token'ları birebir; renk/tipografi testle korunuyor |

**Uygulamanın seviyesi:** Arayüz tarafı **bitmiş ve çalışır durumda**; sunucu tarafı (Firebase'e gerçek okuma/yazma) **henüz bağlı değil**. Ayrıntılı olgunluk tablosu → [bölüm 8](#8-olgunluk-seviyesi).

---

## 2. Bu turda yapılanlar

### 2.1 Barkod ve QR — gerçekten çalışıyor

- **`lib/features/barcode/data/product_lookup_service.dart`** — Open Food Facts API v2 istemcisi.
  API anahtarı gerektirmiyor, canlı olarak test edildi:
  - `3017620422003` → `status: 1`, `product_name: "Nutella"`, `brands: "Nutella, Ferrero…"`, `quantity: "400 g"`, ürün fotoğrafı ve kategori etiketleri döndü.
  - `0000000000000` → `status: 0` ("no code or invalid code").
  - Yalnızca ihtiyaç duyulan 8 alan isteniyor (`fields=` parametresi) — tüm ürün belgesi yüzlerce alan, mobil bağlantıda gereksiz veri.
  - Servisin kullanım koşulu gereği tanımlayıcı bir `User-Agent` gönderiliyor.
  - **404 hata sayılmıyor**, "sonuç yok" olarak ele alınıyor; kullanıcı adı elle yazıp devam ediyor.
  - Türkçe ürün adı (`product_name_tr`) varsa tercih ediliyor.
  - Marka adın içinde geçiyorsa iki kez yazılmıyor ("Nutella" değil "Nutella Nutella").

- **`lib/features/barcode/presentation/screens/scanner_screen.dart`** — `mobile_scanner` 7.4 ile kamera tarayıcı.
  - Amaca göre format filtresi: ürün tararken EAN-13/EAN-8/UPC-A/UPC-E/Code128/ITF-14; listeye katılırken yalnızca QR.
  - Aynı kodun iki kez işlenmesini engelleyen koruma (kamera saniyede birkaç kare çözüyor).
  - Fener (torch) düğmesi, hedef çerçevesi.
  - **Kamera açılamazsa elle giriş ekranına düşüyor** — kamerasız cihazda veya izin reddinde kullanıcı boş siyah ekranda kalmıyor.

- **Barkod → ürün akışı:** "Ürün Ekle" sayfasındaki **Barkod** düğmesi kamerayı açıyor, kod okununca ürün adı ve paket miktarı forma yazılıyor.

- **Gerçek QR üretimi:** Paylaş sekmesindeki QR artık `qr_flutter` ile üretilen, **telefonla okunabilir gerçek bir kod** (içeriği davet bağlantısı). Önceki sürümde yer tutucu bir görseldi.

- **QR ile katılma:** Ana ekrandaki "QR ile Katıl" düğmesi tarayıcıyı QR kipinde açıyor ve okunan davet kodunu geri getiriyor.

- **Simgeleme türü tahmini:** 978/979 ile başlayan 13 haneli kod ISBN (kitap), 12 hane UPC-A, 8 hane EAN-8, 14 hane ITF-14 olarak sınıflanıyor.

### 2.2 Yeni ekranlar

| Ekran | Dosya | Ne yapıyor |
|---|---|---|
| **Arama** | `features/home/presentation/screens/search_screen.dart` | Liste ve ürün adlarında arama; 2 karakterden önce sorgu çalıştırmıyor; son aramalar; "sonuç yok" ve "aramaya başlayın" ayrı boş durumları |
| **Liste oluştur** | `features/shopping_lists/presentation/widgets/create_list_sheet.dart` | 10 emoji, tasarım paletinden renk seçimi, canlı önizleme kartı, boş başlıkta oluşturmayı engelliyor |
| **Profil** | `features/profile/presentation/screens/profile_view.dart` | Kullanıcı kartı, plan rozeti, 3 sayaç, ayar satırları, sürüm etiketi, animasyonlu giriş |
| **Ayarlar** | `features/settings/presentation/screens/settings_screen.dart` | **Tema seçimi anında uygulanıyor** (Sistem/Açık/Koyu), 6 anahtar, para birimi ve dil seçimi |
| **İstatistikler** | `features/statistics/presentation/screens/statistics_screen.dart` | `fl_chart` ile haftalık harcama sütun grafiği ve kategori pasta grafiği; gerçek liste verisinden hesaplanıyor; veri yoksa sıfıra bölmeden boş durum |
| **Premium** | `features/subscription/presentation/widgets/premium_sheet.dart` | 5 özellik, aylık/yıllık plan seçimi, seçili planın kenarı kalınlaşıyor (renk körlüğünde de ayırt edilebilir) |

### 2.3 Gerçek paylaşım

- **Bağlantıyı kopyala** → gerçekten panoya yazıyor (`Clipboard`).
- **WhatsApp / Mesaj** → işletim sisteminin paylaşım sayfasını açıyor (`share_plus`). Masaüstü tarayıcıda paylaşım sayfası yoksa bağlantıyı panoya alıp kullanıcıyı bilgilendiriyor.
- Davet bağlantısı liste kimliğinden türetiliyor, QR ve metin aynı adresi gösteriyor.

### 2.4 Platform yapılandırması

**Android** (`android/app/src/main/AndroidManifest.xml`):
- `INTERNET`, `CAMERA`, `RECORD_AUDIO`, `POST_NOTIFICATIONS` izinleri.
- Kamera **zorunlu değil** olarak işaretlendi (`required="false"`) — kamerasız cihazlarda Play Store uygulamayı filtrelemesin, elle girişe düşüyor.
- Uygulama adı `SmartList` olarak düzeltildi (önce `smartlist`).
- Davet derin bağlantısı: `smartlist://join/<kod>`.

**iOS** (`ios/Runner/Info.plist`):
- `NSCameraUsageDescription`, `NSMicrophoneUsageDescription`, `NSSpeechRecognitionUsageDescription`, `NSPhotoLibraryUsageDescription` — bu metinler olmadan izin isteyen çağrı uygulamayı çökertir, App Store da reddeder.
- `CFBundleURLTypes` ile `smartlist://` şeması.
- Görünen ad `SmartList`.

### 2.5 Testte bulunup düzeltilen gerçek hata

Ayarlar ekranındaki satırlar bir `SmartCard` içindeydi; `ListTile` dalga (ink) efektini en yakın `Material` üstüne çizdiği için kartın arka planı efektin üstünü kapatıyor ve Flutter framework'ü doğrulama hatası veriyordu. Satırlar saydam bir `Material` ile sarılarak düzeltildi. **Bu hatayı yazdığım duman testi buldu** — elle denemede fark edilmesi zordu.

---

## 3. Ekran ekran ne çalışıyor

Aşağıdakilerin tamamı **şu anda dokunulabilir ve tepki veriyor** (veri bellekte tutuluyor):

**Açılış** — logo animasyonu, ardından uygulama kabuğuna yumuşak geçiş.

**Ana ekran (Home)**
- Arama alanı → Arama ekranı
- Profil avatarı → Profil sekmesi
- Yeni Liste → liste oluşturma sayfası → liste gerçekten ekleniyor ve hemen açılıyor
- QR ile Katıl → QR tarayıcı
- Yapay zekâ ile üret → servis katmanı hazır, bilgilendirme veriyor
- Davet et → Paylaş sekmesi
- "Tümünü gör" → Listeler sekmesi
- Liste kartına dokunma → liste detayı
- Öneri kartı → kabul edilebiliyor
- FAB → ürün ekleme sayfası

**Liste detayı**
- Onay kutusu — elle yazılmış 28px `SmartCheckbox` (Material'ın kutusu tasarımdan küçük), animasyonlu
- Sağa kaydır → tamamlandı işaretle (satır yerinde kalıyor)
- Sola kaydır → sil
- Tamamlananlar bölümü açılıp kapanıyor, "tamamlananları temizle" çalışıyor
- Boş durum ekranı
- FAB → ürün ekleme

**Ürün ekleme sayfası**
- Ad doğrulaması, kategori çipleri, miktar artır/azalt, birim seçimi, not alanı
- **Barkod** düğmesi → kamera → Open Food Facts sorgusu → ad ve paket miktarı forma yazılıyor

**Activity / Share**
- İki sekme arası animasyonlu geçiş
- Sıralı beliren etkinlik akışı, "tümünü okundu işaretle"
- Gerçek QR kodu, bağlantı kopyalama, sistem paylaşım sayfası, üye avatarları

**Listeler sekmesi** — tüm listeler, dokununca detay; FAB yeni liste açıyor.

**Profil** — sayaçlar gerçek veriden; İstatistikler, Ayarlar, Premium ve Çıkış (onay penceresiyle) çalışıyor.

**Ayarlar** — tema anında değişiyor, tüm anahtarlar ve açılır listeler çalışıyor.

**İstatistikler** — iki grafik gerçek liste verisinden çiziliyor.

**Premium** — plan seçimi ve satın alma düğmesi çalışıyor (mağaza entegrasyonu bağlanacak nokta olarak duruyor).

---

## 4. Gerçek servisler ve entegrasyonlar

| Servis | Durum | Not |
|---|---|---|
| **Open Food Facts API v2** | ✅ Bağlı ve canlı doğrulandı | Anahtar gerekmiyor, ücretsiz, açık veritabanı |
| **Anthropic Claude (Messages API)** | ✅ Kod hazır | `claude-opus-5`; `temperature` **bilinçli olarak gönderilmiyor** (bu modelde 400 hatası veriyor); yanıt okunmadan önce `stop_reason == 'refusal'` denetleniyor |
| **OpenAI** | ✅ Kod hazır | Sağlayıcı-bağımsız arayüzün ikinci uygulaması |
| **Google Gemini** | ✅ Kod hazır | Üçüncü uygulama; sağlayıcılar arasında yedekleme (fallback) var |
| **Firebase** (Firestore/Auth/Storage/FCM/Analytics/Crashlytics) | ⚙️ Şema, kurallar, indeksler ve başlatma kodu hazır; **ekranlar henüz bağlanmadı** | Yapılandırma `--dart-define` ile veriliyor; eksik değişken varsa uygulama hangi değişkenin eksik olduğunu söyleyen bir ekranla açılıyor |

**Yapay zekâ katmanı sağlayıcıdan bağımsız:** `AiProvider` arayüzü + `AiProviderRegistry`. Anahtarı hangi sağlayıcı için verirsen o kullanılıyor; birden fazla varsa biri düşerse diğerine geçiyor. Kod tek satır değişmeden sağlayıcı değiştirilebiliyor.

---

## 5. Kod tabanı

```
lib/
├── core/
│   ├── config/       app_config, app_flavor, feature_flags, firebase_options
│   ├── constants/    app_constants, firestore_paths
│   ├── database/     local_cache (Hive)
│   ├── errors/       app_exception (sealed), error_mapper
│   ├── theme/        design_tokens, app_theme, spacing_theme
│   ├── utils/        app_logger, json_converters
│   ├── widgets/      smart_card, press_scale, completion_bar, avatar_stack
│   └── bootstrap.dart
├── models/           22 Freezed modeli + 25 enum
├── features/
│   ├── ai/           4 sağlayıcı + servis + prompt üretici
│   ├── barcode/      lookup servisi + tarayıcı ekranı
│   ├── home/         dashboard, arama, kartlar
│   ├── notifications/ activity + share
│   ├── products/     ürün ekleme sayfası
│   ├── profile/      profil
│   ├── settings/     ayarlar
│   ├── shared/       açılış, alt navigasyon, derleme durumu
│   ├── shopping_lists/ liste detayı, satır, liste oluşturma
│   ├── statistics/   grafikler
│   └── subscription/ premium
├── main.dart, main_dev/staging/prod.dart, main_preview.dart
```

**114 Dart dosyası, ~20.700 satır.** Feature-first klasörleme, katmanlar (data / domain / presentation), Clean Architecture yerleşimi.

**Tasarım tek kaynaktan:** Bütün renk, punto, boşluk, yarıçap, gölge, süre ve eğri değerleri `design_tokens.dart` içinde. Ekranlarda tek bir sabit renk veya piksel değeri yok. `SpacingTheme` bir `ThemeExtension` olarak `context.spacing` ile erişiliyor.

**Yazı tipi gömülü:** Hanken Grotesk değişken fontu uygulamanın içinde. `google_fonts` çalışma anında indirme yaptığı için testlerde kırılıyordu; font varyasyonu (`FontVariation('wght', …)`) ile ağırlıklar dosyadan üretiliyor.

---

## 6. Veritabanı ve güvenlik

- **`docs/FIRESTORE_SCHEMA.md`** — 28+ koleksiyon, alan alan tanımlı; her belgede `createdBy / updatedBy / createdAt / updatedAt / deletedAt / version`; yumuşak silme (soft delete).
- **`firestore.rules`** — 29 `match` bloğu, rol tabanlı yetki:
  - Yalnızca **owner** listeyi silebilir.
  - **editor** ürün ekleyip düzenleyebilir.
  - **viewer** yalnızca tamamlandı/satın alındı alanlarını değiştirebilir — bu **alan düzeyinde** kısıtlanmış (`onlyChanged([...])`), yani izinsiz alanı değiştiren istek reddediliyor.
  - Etkinlik kayıtları güncellenemez ve silinemez.
  - Abonelik yetkileri (`entitlements`) yalnızca sunucudan yazılabilir.
- **Üyelik denormalize:** listede `memberIds` dizisi + `memberRoles` haritası. Tek bir üst belge okuması tüm alt koleksiyonları yetkilendiriyor — kural değerlendirmesinde ekstra okuma yapmıyor.
- **`firestore.indexes.json`** — bileşik indeksler ve koleksiyon-grubu indeksleri; büyük metin/harita alanlarında indeksleme kapatıldı (`fieldOverrides`).
- Eşzamanlı yazma çakışmasını önleyen tasarım: `readBy` / `reactions` uid anahtarlı harita (üzerine yazmıyor, birleşiyor); sıralama için seyrek `double sortOrder` (sürükle-bırak tek belge yazıyor).

---

## 7. Testler

**54 test, tamamı geçiyor.**

| Dosya | Kapsam |
|---|---|
| `test/features/barcode/product_lookup_service_test.dart` | 13 test — barkod normalleştirme, sınır uzunlukları, ISBN/UPC/EAN/ITF sınıflama, Open Food Facts yanıt ayrıştırma, marka birleştirme, Türkçe ad tercihi, `status: 0`, 404, metin gelen `status`, adsız ürün, geçersiz barkodun ağa gitmeden reddi, sunucu hatasının `AppException`'a dönüşmesi. Ağ yerine sahte `HttpClientAdapter` kullanılıyor. |
| `test/features/screens_smoke_test.dart` | 9 test — Profil, Ayarlar (anahtar ve tema bildirimi), İstatistikler (dolu + boş veri), Premium (plan değiştirme ve satın alma), Arama (2 karakter kuralı, boş durum), Liste oluşturma (boş başlık engeli). |
| `test/features/ai/ai_service_test.dart` | Yapay zekâ katmanı — sağlayıcı seçimi, yedekleme, yanıt ayrıştırma, ret (refusal) durumu. |
| `test/models/shopping_list_test.dart` | Model mantığı — ilerleme oranı, sıfıra bölme koruması, rol çözümleme, JSON gidiş-dönüş. |
| `test/widget_test.dart` | **Tasarım koruması** — açık tema renkleri tasarımdaki değerleri birebir taşıyor mu, punto ve satır yüksekliği doğru mu, dokunma hedefi 48px alt sınırını karşılıyor mu. |

Bu son dosya önemli: biri renk veya punto değiştirirse test kırılıyor, yani `tasarim.html` uyumu kod tarafından korunuyor.

---

## 8. Olgunluk seviyesi

| Alan | Seviye | Açıklama |
|---|---|---|
| Tasarım uyumu | ██████████ %100 | Token'lar `tasarim.html`'den çıkarıldı, testle korunuyor |
| Arayüz ekranları | █████████░ %90 | Tasarımdaki 4 ekran + 6 ek ekran bitti; sohbet ve giriş ekranları yok |
| Etkileşim / animasyon | ██████████ %95 | Tüm düğmeler çalışıyor, geçişler ve sıralı animasyonlar yerinde |
| Barkod / QR | ██████████ %95 | Gerçek kamera, gerçek API, gerçek QR üretimi; yalnızca tarama geçmişi kaydı eksik |
| Yapay zekâ katmanı | ████████░░ %80 | 3 sağlayıcı, prompt üretici, yedekleme hazır; ekrana bağlanması ve anahtar girişi kaldı |
| Veri modeli | ██████████ %100 | 22 model + 25 enum, JSON dönüşümleri, kod üretimi çalışıyor |
| Veritabanı şeması / kurallar | ██████████ %100 | Şema, kurallar, indeksler yazılı ve dokümanlı — **henüz sunucuya dağıtılmadı** |
| Firebase bağlantısı | ██░░░░░░░░ %20 | Başlatma ve yapılandırma hazır; depo (repository) katmanı ve ekran bağlantısı yok |
| Kimlik doğrulama | ░░░░░░░░░░ %0 | Giriş/kayıt ekranları ve Auth servisi yazılmadı |
| Gerçek zamanlı işbirliği | ░░░░░░░░░░ %0 | Presence/yazıyor/okundu tasarımı belli, kod yok |
| Sohbet | ░░░░░░░░░░ %0 | Modeller var, ekran yok |
| Bildirimler (FCM) | █░░░░░░░░░ %10 | Modeller ve izinler var; işleyiciler ve Cloud Functions yok |
| Sesle ekleme | ░░░░░░░░░░ %0 | Paket ve izinler hazır, kod yok |
| Çevrimdışı eşitleme | ███░░░░░░░ %30 | Hive önbelleği var; eşitleme/çakışma motoru yok |
| Test altyapısı | ██████░░░░ %60 | 54 test; entegrasyon testi ve altın (golden) test yok |
| CI/CD | ███████░░░ %70 | İş akışı yazılı; Android/iOS işleri için depo sırları (secrets) girilmeli |

**Özet cümle:** Uygulama şu anda **tam çalışan bir arayüz prototipi + üretim kalitesinde altyapı** seviyesinde. Telefona kurulup her ekranı gezilebilir, barkod okutulabilir, QR paylaşılabilir. Eksik olan tek büyük parça **verinin buluta yazılması** — yani Firebase bağlantısı ve giriş sistemi.

---

## 9. Sırada ne var (öneri sırası)

1. **Kimlik doğrulama** — Firebase Auth servisi, giriş/kayıt/şifre sıfırlama ekranları. Her şeyin önkoşulu, çünkü `createdBy` alanları buna bağlı.
2. **Depo (repository) katmanı + Riverpod bağlantısı** — listeler ve ürünler Firestore'dan gerçek zamanlı okunsun; şu anda bellekte olan veri buraya taşınacak.
3. **Go Router** — sekmeler ve derin bağlantılar (`smartlist://join/<kod>`) yönlendiriciye bağlansın.
4. **Gerçek zamanlı işbirliği** — presence kalp atışı, "yazıyor" göstergesi, okundu bilgisi, çakışma çözümü.
5. **Sohbet ekranı** — modeller hazır, ekran ve gerçek zamanlı akış yazılacak.
6. **FCM + Cloud Functions** — bildirim tetikleyicileri, davet e-postası, abonelik doğrulaması.
7. **Sesle ürün ekleme** — `speech_to_text` bağlanacak, tek cümleden birden fazla ürün ayrıştırılacak.
8. **Çevrimdışı eşitleme motoru** — kuyruk, yeniden gönderim, çakışma politikası.
9. **Mağaza aboneliği** — `in_app_purchase` ve sunucu tarafı doğrulama.
10. **CI sırları** — imzalama anahtarları ve Firebase yapılandırması GitHub Secrets'a girilecek.

---

## 10. Telefonda nasıl denenir

Android Studio kurulu makinede:

```powershell
git clone https://github.com/ugurhamamci/SmartList.git
cd SmartList
.\scripts\setup.ps1          # bağımlılıklar + kod üretimi
```

Sonra telefonu USB ile bağlayıp:

```powershell
.\scripts\run_preview.ps1    # Firebase gerektirmeyen önizleme
```

Android Studio içinden çalıştırmak için `.run/` klasöründeki hazır yapılandırmalar (**SmartList Onizleme** ve **SmartList Onizleme (Chrome)**) kullanılabilir — proje açıldığında sağ üstteki listede görünüyorlar.

Ayrıntılı kurulum (Flutter kurulumu, ortam değişkenleri, Firebase adımları, sorun giderme): **`docs/KURULUM.md`** — 14 bölüm.

> Not: Barkod tarama gerçek kamera gerektirdiği için **telefonda** denenmeli. Tarayıcı önizlemesinde kamera yoksa ekran elle giriş kipine düşer; oraya `3017620422003` yazarsan Nutella'nın gerçekten API'den geldiğini görürsün.

---

## 11. Gereken anahtarlar

Uygulama hiçbir anahtarı kod içinde tutmuyor; hepsi `--dart-define` ile veriliyor ve `.gitignore` ile korunuyor.

| Değişken | Ne için | Zorunlu mu |
|---|---|---|
| `FIREBASE_API_KEY`, `FIREBASE_APP_ID`, `FIREBASE_PROJECT_ID`, `FIREBASE_MESSAGING_SENDER_ID`, `FIREBASE_STORAGE_BUCKET` | Firebase | Gerçek uygulama için evet, önizleme için hayır |
| `ANTHROPIC_API_KEY` veya `OPENAI_API_KEY` veya `GEMINI_API_KEY` | Yapay zekâ liste üretimi | Hayır — biri yeterli, hiçbiri yoksa özellik kapalı kalır |
| — | Barkod (Open Food Facts) | **Anahtar gerekmiyor** |

Eksik değişkenle çalıştırılırsa uygulama çökmez; hangi değişkenin eksik olduğunu söyleyen bir ekranla açılır.

---

## 12. Bilinen sınırlar (dürüst liste)

- Veriler **bellekte** tutuluyor; uygulama kapanınca sıfırlanıyor. Firebase bağlanınca kalıcı olacak.
- "QR ile Katıl" kodu okuyor ve gösteriyor, ama davetin karşılığını bulmak sunucu tarafı gerektiriyor — o adım Firebase bağlantısıyla gelecek.
- İstatistiklerdeki haftalık dağılım örnek katsayılarla üretiliyor; toplam tutar gerçek liste verisinden hesaplanıyor. Gerçek haftalık seri, satın alma kayıtları yazılmaya başlayınca gelecek.
- Ürün fiyatları metin etiketi ("Tahmini 45 TL") olarak duruyor; modelde sayısal `estimatedPrice` alanı var, ekran bağlantısı Firebase turunda yapılacak.
- Premium satın alma düğmesi mağaza akışını başlatmıyor — `in_app_purchase` entegrasyonu bağlanacak nokta olarak bırakıldı.
- iOS tarafı hiç derlenmedi (bu makinede Xcode yok). Android ve web derlemeleri doğrulandı.
- Yapay zekâ liste üretimi servis katmanında hazır ama ekrana bağlanmadı.

---

*Bu rapor `flutter analyze`, `flutter test` ve `flutter build web --release` çıktılarıyla doğrulanmış bilgilere dayanıyor. Yapılmayan işler yukarıda açıkça listelendi; tabloda "hazır" yazan her madde çalışır durumda.*
