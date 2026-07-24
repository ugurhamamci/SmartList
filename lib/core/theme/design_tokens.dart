import 'package:flutter/material.dart';

/// Uygulamanın tek görsel kaynak dosyası.
///
/// Bütün değerler `tasarim.html` içindeki Tailwind yapılandırmasından birebir
/// alınmıştır. Hiçbir widget kendi içinde renk, yarıçap, gölge veya boşluk
/// tanımlamaz; hepsi buradan ve `SpacingTheme` uzantısından okunur.
///
/// **Tasarımdaki iki tutarsızlık ve verilen kararlar:**
///
/// 1. `primary` değeri Dashboard ekranında `#4f46e5`, diğer üç ekranda
///    `#3525cd`. "Design System" başlıklı dosya kanonik kabul edildi, yani
///    [primary] = `#3525cd`. Dolgu gerektiren yüzeyler (buton, FAB, checkbox,
///    odak halkası) tasarımın her yerinde `#4f46e5` kullanıyor; o değer
///    [primaryContainer] olarak duruyor. Bu, Material 3 kullanımıyla da
///    uyumlu: `primary` metin/ikon, `primaryContainer` dolgu rengi.
/// 2. `background` Dashboard'da `#f8fafc`, diğerlerinde `#f9f9ff`. Yine
///    çoğunluk ve Design System dosyası esas alındı.
///
/// **Koyu tema:** Tasarım `darkMode: "class"` tanımlıyor ancak koyu palet
/// vermiyor. Bu yüzden koyu tema, açık paletin tohum renginden Material 3
/// tarafından türetiliyor — tasarımdan gelen bir değer değildir.
abstract final class DesignTokens {
  // ==========================================================================
  // RENKLER — tasarim.html > tailwind.config > colors
  // ==========================================================================

  // --- Primary -------------------------------------------------------------
  static const Color primary = Color(0xFF3525CD);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF4F46E5);
  static const Color onPrimaryContainer = Color(0xFFDAD7FF);
  static const Color primaryFixed = Color(0xFFE2DFFF);
  static const Color primaryFixedDim = Color(0xFFC3C0FF);
  static const Color onPrimaryFixed = Color(0xFF0F0069);
  static const Color onPrimaryFixedVariant = Color(0xFF3323CC);
  static const Color inversePrimary = Color(0xFFC3C0FF);
  static const Color surfaceTint = Color(0xFF4D44E3);

  // --- Secondary (yeşil — tamamlanma durumu) -------------------------------
  static const Color secondary = Color(0xFF006E2F);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFF6BFF8F);
  static const Color onSecondaryContainer = Color(0xFF007432);
  static const Color secondaryFixed = Color(0xFF6BFF8F);
  static const Color secondaryFixedDim = Color(0xFF4AE176);
  static const Color onSecondaryFixed = Color(0xFF002109);
  static const Color onSecondaryFixedVariant = Color(0xFF005321);

  // --- Tertiary (turuncu — AI vurguları) -----------------------------------
  static const Color tertiary = Color(0xFF684000);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFF885500);
  static const Color onTertiaryContainer = Color(0xFFFFD4A4);
  static const Color tertiaryFixed = Color(0xFFFFDDB8);
  static const Color tertiaryFixedDim = Color(0xFFFFB95F);
  static const Color onTertiaryFixed = Color(0xFF2A1700);
  static const Color onTertiaryFixedVariant = Color(0xFF653E00);

  // --- Error ---------------------------------------------------------------
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  // --- Surface -------------------------------------------------------------
  static const Color background = Color(0xFFF9F9FF);
  static const Color onBackground = Color(0xFF141B2B);
  static const Color surface = Color(0xFFF9F9FF);
  static const Color onSurface = Color(0xFF141B2B);
  static const Color onSurfaceVariant = Color(0xFF464555);
  static const Color surfaceVariant = Color(0xFFDCE2F7);
  static const Color surfaceBright = Color(0xFFF9F9FF);
  static const Color surfaceDim = Color(0xFFD3DAEF);

  /// Kartların ve bottom sheet'in dolgu rengi. Tasarım bu yüzeylerde
  /// Tailwind'in `bg-white` sınıfını kullanıyor, `surface` değerini değil.
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF1F3FF);
  static const Color surfaceContainer = Color(0xFFE9EDFF);
  static const Color surfaceContainerHigh = Color(0xFFE1E8FD);
  static const Color surfaceContainerHighest = Color(0xFFDCE2F7);

  // --- Outline -------------------------------------------------------------
  static const Color outline = Color(0xFF777587);
  static const Color outlineVariant = Color(0xFFC7C4D8);

  // --- Inverse -------------------------------------------------------------
  static const Color inverseSurface = Color(0xFF293040);
  static const Color inverseOnSurface = Color(0xFFEDF0FF);

  /// Liste renk etiketleri için palet. Tasarımda bir seçici yok; ana
  /// paletteki kimlik renkleri kullanıldı.
  static const List<Color> listLabelPalette = [
    primaryContainer,
    secondary,
    tertiaryContainer,
    error,
    onPrimaryFixedVariant,
    secondaryFixedDim,
    tertiaryFixedDim,
    inverseSurface,
  ];

  // ==========================================================================
  // TİPOGRAFİ — tailwind.config > fontFamily + fontSize
  // ==========================================================================

  /// Tasarımın tek yazı tipi. Google Fonts üzerinden yükleniyor.
  static const String fontFamily = 'Hanken Grotesk';

  // display-lg: 32px / 40px / -0.02em / 700
  static const double displayLargeSize = 32;
  static const double displayLargeHeight = 40;
  static const double displayLargeLetterSpacing = -0.64; // -0.02em * 32
  static const FontWeight displayLargeWeight = FontWeight.w700;

  // display-lg-mobile: 28px / 36px / 700 — uygulama başlığı bunu kullanıyor
  static const double displayMobileSize = 28;
  static const double displayMobileHeight = 36;
  static const FontWeight displayMobileWeight = FontWeight.w700;

  // headline-md: 24px / 32px / -0.01em / 600
  static const double headlineMediumSize = 24;
  static const double headlineMediumHeight = 32;
  static const double headlineMediumLetterSpacing = -0.24; // -0.01em * 24
  static const FontWeight headlineMediumWeight = FontWeight.w600;

  // headline-sm: 20px / 28px / 600
  static const double headlineSmallSize = 20;
  static const double headlineSmallHeight = 28;
  static const FontWeight headlineSmallWeight = FontWeight.w600;

  // body-lg: 16px / 24px / 400
  static const double bodyLargeSize = 16;
  static const double bodyLargeHeight = 24;
  static const FontWeight bodyLargeWeight = FontWeight.w400;

  // body-sm: 14px / 20px / 400
  static const double bodySmallSize = 14;
  static const double bodySmallHeight = 20;
  static const FontWeight bodySmallWeight = FontWeight.w400;

  // label-md: 12px / 16px / 0.05em / 600
  static const double labelMediumSize = 12;
  static const double labelMediumHeight = 16;
  static const double labelMediumLetterSpacing = 0.6; // 0.05em * 12
  static const FontWeight labelMediumWeight = FontWeight.w600;

  /// Kart ve liste öğesi başlıkları tasarımda `font-headline-sm` sınıfını
  /// alıp punto değerini elle eziyor (`text-[16px]`, `text-[18px]`).
  static const double titleOnCardSize = 18;
  static const double titleOnListItemSize = 16;

  // ==========================================================================
  // BOŞLUK — tailwind.config > spacing
  // ==========================================================================

  /// Ekran kenar boşluğu (`px-container-margin`).
  static const double containerMargin = 20;

  /// Dokunma hedefi alt sınırı (`touch-target`).
  static const double touchTarget = 48;

  /// Dikey liste aralığı (`space-y-stack-gap`).
  static const double stackGap = 12;

  /// Bölümler arası boşluk (`mb-section-gap`).
  static const double sectionGap = 32;

  /// Izgara ve satır içi aralık (`gap-gutter`).
  static const double gutter = 16;

  /// Tailwind'in doğrudan kullanılan ölçek adımları.
  static const double space1 = 4; // gap-1
  static const double space2 = 8; // gap-2
  static const double space3 = 12; // gap-3
  static const double space4 = 16; // gap-4, p-4
  static const double space5 = 20; // p-5
  static const double space6 = 24; // mb-6
  static const double space8 = 32; // mb-8
  static const double space10 = 40; // pb-10

  // ==========================================================================
  // KÖŞE YARIÇAPI — tailwind.config > borderRadius
  // ==========================================================================

  static const double radiusDefault = 4; // 0.25rem
  static const double radiusLg = 8; // 0.5rem
  static const double radiusXl = 12; // 0.75rem  — liste öğesi kartı
  static const double radius2xl = 24; // rounded-2xl — kart, buton, input
  static const double radius3xl = 32; // rounded-t-[32px] — nav, bottom sheet
  static const double radiusFull = 9999;

  /// Checkbox köşesi (`rounded-lg`).
  static const double radiusCheckbox = radiusLg;

  // ==========================================================================
  // GÖLGELER — tasarim.html > <style> blokları
  // ==========================================================================

  /// `.card-shadow` → 0px 4px 20px rgba(0,0,0,0.04)
  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Color(0x0A000000), // %4 siyah
      offset: Offset(0, 4),
      blurRadius: 20,
    ),
  ];

  /// `.nav-shadow` → 0px -10px 40px rgba(0,0,0,0.08)
  static const List<BoxShadow> navShadow = [
    BoxShadow(
      color: Color(0x14000000), // %8 siyah
      offset: Offset(0, -10),
      blurRadius: 40,
    ),
  ];

  /// Bottom sheet gölgesi — nav ile aynı değerler.
  static const List<BoxShadow> bottomSheetShadow = navShadow;

  /// FAB gölgesi → 0px 10px 40px rgba(79,70,229,0.4)
  static const List<BoxShadow> fabShadow = [
    BoxShadow(
      color: Color(0x664F46E5), // primaryContainer %40
      offset: Offset(0, 10),
      blurRadius: 40,
    ),
  ];

  /// Modal arka planı → rgba(20,27,43,0.4) + 8px blur
  static const Color scrimColor = Color(0x66141B2B);
  static const double scrimBlur = 8;

  /// `.glass-header` → backdrop-filter: blur(12px)
  static const double glassHeaderBlur = 12;

  /// `.glass-effect` → blur(20px) + rgba(255,255,255,0.8)
  static const double glassEffectBlur = 20;
  static const Color glassEffectColor = Color(0xCCFFFFFF);

  /// Yarı saydam üst çubuk (`bg-surface/80`).
  static const double headerSurfaceOpacity = 0.8;

  // ==========================================================================
  // HAREKET — tasarim.html > transition / @keyframes
  // ==========================================================================

  /// Checkbox görsel geçişi (`duration-200`).
  static const Duration durationFast = Duration(milliseconds: 200);

  /// Kaydırma jesti (`.swipe-item`, 0.3s).
  static const Duration durationMedium = Duration(milliseconds: 300);

  /// Bottom sheet ve liste öğesi girişi (0.4s).
  static const Duration durationSlow = Duration(milliseconds: 400);

  /// Tamamlanan öğenin solma geçişi (`duration-500`).
  static const Duration durationSlower = Duration(milliseconds: 500);

  /// `.swipe-item` → cubic-bezier(0.2, 0.8, 0.2, 1)
  static const Curve curveSwipe = Cubic(0.2, 0.8, 0.2, 1);

  /// `.bottom-sheet-transition` → cubic-bezier(0.32, 0.72, 0, 1)
  static const Curve curveSheet = Cubic(0.32, 0.72, 0, 1);

  /// `@keyframes slideIn` → ease
  static const Curve curveStandard = Curves.ease;

  /// Basılı tutma küçülmesi. Tasarım `active:scale-95`, `active:scale-90` ve
  /// `active:scale-[0.98]` varyantlarını kullanıyor.
  static const double pressScaleSubtle = 0.98;
  static const double pressScale = 0.95;
  static const double pressScaleStrong = 0.90;

  /// Liste öğesi giriş animasyonunun başlangıç ötelemesi (`translateY(10px)`).
  static const double slideInOffset = 10;

  /// Kaydırarak tamamlama/silme eşiği (px).
  static const double swipeActionThreshold = 100;

  /// Bottom sheet'i kapatan aşağı kaydırma eşiği (px).
  static const double sheetDismissThreshold = 150;

  // ==========================================================================
  // BİLEŞEN ÖLÇÜLERİ — markup'tan birebir
  // ==========================================================================

  /// Arama alanı yüksekliği (`h-[52px]`).
  static const double searchFieldHeight = 52;

  /// Form alanı yüksekliği (`h-[56px]`).
  static const double inputHeight = 56;

  /// Birincil buton yüksekliği (`h-[64px]`).
  static const double primaryButtonHeight = 64;

  /// Paylaşım aksiyon butonu yüksekliği (`h-14`).
  static const double actionButtonHeight = 56;

  /// Dashboard FAB'ı (`w-16 h-16`).
  static const double fabSize = 64;

  /// Liste detay FAB'ı (`w-[64px]`).
  static const double fabSizeLarge = 64;

  /// Üst çubuk ikon butonu (`w-10 h-10`).
  static const double iconButtonSize = 40;

  /// Checkbox (`w-7 h-7`).
  static const double checkboxSize = 28;

  /// İlerleme çubuğu kalınlığı (`h-2` / `h-1`).
  static const double progressBarHeight = 8;
  static const double progressBarHeightThin = 4;

  /// Bottom sheet tutamacı (`w-10 h-1`).
  static const double dragHandleWidth = 40;
  static const double dragHandleHeight = 4;

  /// Avatar boyutları (`w-4`, `w-8`, `w-10`, `w-12`, `h-14`).
  static const double avatarTiny = 16;
  static const double avatarSmall = 32;
  static const double avatarMedium = 40;
  static const double avatarLarge = 48;
  static const double avatarExtraLarge = 56;

  /// Üst üste binen avatarların negatif aralığı (`-space-x-3`).
  static const double avatarOverlap = -12;

  /// İkon boyutları.
  static const double iconTiny = 14;
  static const double iconSmall = 18;
  static const double iconMedium = 24;
  static const double iconLarge = 28;
  static const double iconExtraLarge = 32;

  /// QR kodu alanı (`w-56 h-56`).
  static const double qrSize = 224;

  /// Alt navigasyonun içerik yüksekliği; güvenli alan bunun üstüne eklenir.
  static const double bottomNavHeight = 72;

  /// Erişilebilirlik: platform yazı ölçeğinin sınırlandığı aralık.
  static const double minTextScale = 0.8;
  static const double maxTextScale = 2;
}
