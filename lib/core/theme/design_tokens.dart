import 'package:flutter/material.dart';

/// The single source of visual constants for the application.
///
/// ⚠️ **These values are Material 3 baseline defaults, not the SmartList
/// design.** `tasarim.html` — the specified source of truth for colour,
/// typography, spacing, radii and shadows — was empty (0 bytes) when this file
/// was written, so no token could be extracted from it.
///
/// Every widget reads its visual values from here and from `SpacingTheme`, so
/// replacing the constants below with the values in `tasarim.html` restyles the
/// whole application without touching any widget. Nothing outside this file and
/// `spacing_theme.dart` hard-codes a colour, radius, shadow or spacing value.
abstract final class DesignTokens {
  // ------------------------------------------------------------------ colour
  /// Seed from which both Material 3 colour schemes are derived.
  static const Color seed = Color(0xFF6C63FF);

  static const Color surfaceLight = Color(0xFFFDFDFF);
  static const Color surfaceDark = Color(0xFF121218);

  /// Semantic colours that sit outside the generated scheme.
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFED6C02);
  static const Color info = Color(0xFF0288D1);

  /// Palette offered when a user picks a colour label for a list.
  static const List<Color> listLabelPalette = [
    Color(0xFF6C63FF),
    Color(0xFF00BFA6),
    Color(0xFFFF6B6B),
    Color(0xFFFFA94D),
    Color(0xFF4DABF7),
    Color(0xFFAE3EC9),
    Color(0xFF37B24D),
    Color(0xFFF06595),
  ];

  // ----------------------------------------------------------------- spacing
  static const double spaceTiny = 4;
  static const double spaceSmall = 8;
  static const double spaceMedium = 16;
  static const double spaceLarge = 24;
  static const double spaceExtraLarge = 32;
  static const double spaceHuge = 48;

  // ------------------------------------------------------------------ radius
  static const double radiusSmall = 8;
  static const double radiusMedium = 12;
  static const double radiusLarge = 16;
  static const double radiusExtraLarge = 28;
  static const double radiusPill = 999;

  // --------------------------------------------------------------- elevation
  static const double elevationNone = 0;
  static const double elevationLow = 1;
  static const double elevationMedium = 3;
  static const double elevationHigh = 6;

  // ----------------------------------------------------------- accessibility
  /// Minimum height for any interactive control.
  static const double minTouchTarget = 48;

  /// Bounds applied to the platform text scale so layouts stay usable at the
  /// extremes of the accessibility range.
  static const double minTextScale = 0.8;
  static const double maxTextScale = 2;

  // -------------------------------------------------------------- animation
  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationMedium = Duration(milliseconds: 250);
  static const Duration durationSlow = Duration(milliseconds: 400);
  static const Curve curveStandard = Curves.easeOutCubic;
  static const Curve curveEmphasised = Curves.easeOutBack;

  // ------------------------------------------------------------------ sizing
  static const double avatarSmall = 28;
  static const double avatarMedium = 40;
  static const double avatarLarge = 64;
  static const double iconSmall = 18;
  static const double iconMedium = 24;
  static const double iconLarge = 32;
}
