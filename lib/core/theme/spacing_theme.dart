import 'package:flutter/material.dart';

import 'package:smartlist/core/theme/design_tokens.dart';

/// Tasarımın boşluk, yarıçap ve hareket değerlerini tema üzerinden sunar.
///
/// Adlandırma `tasarim.html` içindeki Tailwind anahtarlarını izler
/// (`container-margin`, `stack-gap`, `section-gap`, `gutter`), böylece bir
/// widget'a bakan kişi hangi tasarım değerinin kullanıldığını doğrudan görür.
///
/// Bunu [ThemeExtension] olarak okumak, bir ekranı farklı bir ölçekle
/// (kompakt yerleşim, golden test) render etmeyi widget'ları değiştirmeden
/// mümkün kılar.
@immutable
class SpacingTheme extends ThemeExtension<SpacingTheme> {
  const SpacingTheme({
    required this.containerMargin,
    required this.stackGap,
    required this.gutter,
    required this.sectionGap,
    required this.tiny,
    required this.small,
    required this.medium,
    required this.large,
    required this.radiusSmall,
    required this.radiusItem,
    required this.radiusCard,
    required this.radiusSheet,
    required this.durationFast,
    required this.durationMedium,
    required this.durationSlow,
  });

  /// [DesignTokens] içindeki değerler.
  static const SpacingTheme standard = SpacingTheme(
    containerMargin: DesignTokens.containerMargin,
    stackGap: DesignTokens.stackGap,
    gutter: DesignTokens.gutter,
    sectionGap: DesignTokens.sectionGap,
    tiny: DesignTokens.space1,
    small: DesignTokens.space2,
    medium: DesignTokens.space4,
    large: DesignTokens.space6,
    radiusSmall: DesignTokens.radiusLg,
    radiusItem: DesignTokens.radiusXl,
    radiusCard: DesignTokens.radius2xl,
    radiusSheet: DesignTokens.radius3xl,
    durationFast: DesignTokens.durationFast,
    durationMedium: DesignTokens.durationMedium,
    durationSlow: DesignTokens.durationSlow,
  );

  /// Ekran kenar boşluğu — `px-container-margin` (20px).
  final double containerMargin;

  /// Dikey liste aralığı — `space-y-stack-gap` (12px).
  final double stackGap;

  /// Izgara ve satır içi aralık — `gap-gutter` (16px).
  final double gutter;

  /// Bölümler arası boşluk — `mb-section-gap` (32px).
  final double sectionGap;

  final double tiny;
  final double small;
  final double medium;
  final double large;

  /// Checkbox köşesi — `rounded-lg` (8px).
  final double radiusSmall;

  /// Liste öğesi kartı — `rounded-xl` (12px).
  final double radiusItem;

  /// Kart, buton ve arama alanı — `rounded-2xl` (24px).
  final double radiusCard;

  /// Bottom sheet ve alt navigasyon — `rounded-t-[32px]`.
  final double radiusSheet;

  final Duration durationFast;
  final Duration durationMedium;
  final Duration durationSlow;

  /// Ekran kenarlarına uygulanan yatay dolgu.
  EdgeInsets get horizontalPadding =>
      EdgeInsets.symmetric(horizontal: containerMargin);

  /// Kart iç dolgusu — tasarımda `p-5` (20px).
  EdgeInsets get cardPadding => const EdgeInsets.all(DesignTokens.space5);

  /// Liste öğesi iç dolgusu — tasarımda `p-4` (16px).
  EdgeInsets get itemPadding => const EdgeInsets.all(DesignTokens.space4);

  @override
  SpacingTheme copyWith({
    double? containerMargin,
    double? stackGap,
    double? gutter,
    double? sectionGap,
    double? tiny,
    double? small,
    double? medium,
    double? large,
    double? radiusSmall,
    double? radiusItem,
    double? radiusCard,
    double? radiusSheet,
    Duration? durationFast,
    Duration? durationMedium,
    Duration? durationSlow,
  }) {
    return SpacingTheme(
      containerMargin: containerMargin ?? this.containerMargin,
      stackGap: stackGap ?? this.stackGap,
      gutter: gutter ?? this.gutter,
      sectionGap: sectionGap ?? this.sectionGap,
      tiny: tiny ?? this.tiny,
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
      radiusSmall: radiusSmall ?? this.radiusSmall,
      radiusItem: radiusItem ?? this.radiusItem,
      radiusCard: radiusCard ?? this.radiusCard,
      radiusSheet: radiusSheet ?? this.radiusSheet,
      durationFast: durationFast ?? this.durationFast,
      durationMedium: durationMedium ?? this.durationMedium,
      durationSlow: durationSlow ?? this.durationSlow,
    );
  }

  @override
  SpacingTheme lerp(ThemeExtension<SpacingTheme>? other, double t) {
    if (other is! SpacingTheme) {
      return this;
    }
    return SpacingTheme(
      containerMargin: _lerp(containerMargin, other.containerMargin, t),
      stackGap: _lerp(stackGap, other.stackGap, t),
      gutter: _lerp(gutter, other.gutter, t),
      sectionGap: _lerp(sectionGap, other.sectionGap, t),
      tiny: _lerp(tiny, other.tiny, t),
      small: _lerp(small, other.small, t),
      medium: _lerp(medium, other.medium, t),
      large: _lerp(large, other.large, t),
      radiusSmall: _lerp(radiusSmall, other.radiusSmall, t),
      radiusItem: _lerp(radiusItem, other.radiusItem, t),
      radiusCard: _lerp(radiusCard, other.radiusCard, t),
      radiusSheet: _lerp(radiusSheet, other.radiusSheet, t),
      // Süreler ara değerlenmez; kesirli bir animasyon süresinin anlamı yok.
      durationFast: t < 0.5 ? durationFast : other.durationFast,
      durationMedium: t < 0.5 ? durationMedium : other.durationMedium,
      durationSlow: t < 0.5 ? durationSlow : other.durationSlow,
    );
  }

  static double _lerp(double a, double b, double t) => a + (b - a) * t;
}

/// [SpacingTheme] değerlerine [BuildContext] üzerinden erişim.
extension SpacingThemeX on BuildContext {
  SpacingTheme get spacing =>
      Theme.of(this).extension<SpacingTheme>() ?? SpacingTheme.standard;
}
