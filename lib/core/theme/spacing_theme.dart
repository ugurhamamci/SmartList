import 'package:flutter/material.dart';

import 'package:smartlist/core/theme/design_tokens.dart';

/// Spacing, radii and motion exposed through the theme.
///
/// Reading these from a [ThemeExtension] rather than importing
/// [DesignTokens] directly in every widget means a screen can be rendered under
/// a different scale — a compact layout, or a golden test — without editing the
/// widgets themselves.
@immutable
class SpacingTheme extends ThemeExtension<SpacingTheme> {
  const SpacingTheme({
    required this.tiny,
    required this.small,
    required this.medium,
    required this.large,
    required this.extraLarge,
    required this.huge,
    required this.radiusSmall,
    required this.radiusMedium,
    required this.radiusLarge,
    required this.radiusExtraLarge,
    required this.durationFast,
    required this.durationMedium,
    required this.durationSlow,
  });

  /// The values defined by [DesignTokens].
  static const SpacingTheme standard = SpacingTheme(
    tiny: DesignTokens.spaceTiny,
    small: DesignTokens.spaceSmall,
    medium: DesignTokens.spaceMedium,
    large: DesignTokens.spaceLarge,
    extraLarge: DesignTokens.spaceExtraLarge,
    huge: DesignTokens.spaceHuge,
    radiusSmall: DesignTokens.radiusSmall,
    radiusMedium: DesignTokens.radiusMedium,
    radiusLarge: DesignTokens.radiusLarge,
    radiusExtraLarge: DesignTokens.radiusExtraLarge,
    durationFast: DesignTokens.durationFast,
    durationMedium: DesignTokens.durationMedium,
    durationSlow: DesignTokens.durationSlow,
  );

  final double tiny;
  final double small;
  final double medium;
  final double large;
  final double extraLarge;
  final double huge;
  final double radiusSmall;
  final double radiusMedium;
  final double radiusLarge;
  final double radiusExtraLarge;
  final Duration durationFast;
  final Duration durationMedium;
  final Duration durationSlow;

  @override
  SpacingTheme copyWith({
    double? tiny,
    double? small,
    double? medium,
    double? large,
    double? extraLarge,
    double? huge,
    double? radiusSmall,
    double? radiusMedium,
    double? radiusLarge,
    double? radiusExtraLarge,
    Duration? durationFast,
    Duration? durationMedium,
    Duration? durationSlow,
  }) {
    return SpacingTheme(
      tiny: tiny ?? this.tiny,
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
      extraLarge: extraLarge ?? this.extraLarge,
      huge: huge ?? this.huge,
      radiusSmall: radiusSmall ?? this.radiusSmall,
      radiusMedium: radiusMedium ?? this.radiusMedium,
      radiusLarge: radiusLarge ?? this.radiusLarge,
      radiusExtraLarge: radiusExtraLarge ?? this.radiusExtraLarge,
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
      tiny: lerpDouble(tiny, other.tiny, t),
      small: lerpDouble(small, other.small, t),
      medium: lerpDouble(medium, other.medium, t),
      large: lerpDouble(large, other.large, t),
      extraLarge: lerpDouble(extraLarge, other.extraLarge, t),
      huge: lerpDouble(huge, other.huge, t),
      radiusSmall: lerpDouble(radiusSmall, other.radiusSmall, t),
      radiusMedium: lerpDouble(radiusMedium, other.radiusMedium, t),
      radiusLarge: lerpDouble(radiusLarge, other.radiusLarge, t),
      radiusExtraLarge: lerpDouble(
        radiusExtraLarge,
        other.radiusExtraLarge,
        t,
      ),
      // Durations are switched at the midpoint rather than interpolated;
      // a fractional animation duration has no useful meaning.
      durationFast: t < 0.5 ? durationFast : other.durationFast,
      durationMedium: t < 0.5 ? durationMedium : other.durationMedium,
      durationSlow: t < 0.5 ? durationSlow : other.durationSlow,
    );
  }

  static double lerpDouble(double a, double b, double t) => a + (b - a) * t;
}

/// Convenient access to [SpacingTheme] from a [BuildContext].
extension SpacingThemeX on BuildContext {
  SpacingTheme get spacing =>
      Theme.of(this).extension<SpacingTheme>() ?? SpacingTheme.standard;
}
