import 'package:flutter/cupertino.dart' show CupertinoPageTransitionsBuilder;
import 'package:flutter/material.dart';

import 'package:smartlist/core/theme/design_tokens.dart';
import 'package:smartlist/core/theme/spacing_theme.dart';

/// [DesignTokens] değerlerinden açık ve koyu [ThemeData] üretir.
///
/// Açık tema `tasarim.html` paletini birebir taşır. Koyu tema, tasarım koyu
/// palet vermediği için tohum renginden Material 3 tarafından türetilir —
/// tasarımdan gelen değerler değildir.
abstract final class AppTheme {
  static ThemeData light() => _build(_lightScheme);

  static ThemeData dark() => _build(_darkScheme);

  // ---------------------------------------------------------------- şemalar

  /// Tasarımın renk rollerinin tamamı. Türetme yok; her değer birebir.
  static const ColorScheme _lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: DesignTokens.primary,
    onPrimary: DesignTokens.onPrimary,
    primaryContainer: DesignTokens.primaryContainer,
    onPrimaryContainer: DesignTokens.onPrimaryContainer,
    primaryFixed: DesignTokens.primaryFixed,
    onPrimaryFixed: DesignTokens.onPrimaryFixed,
    primaryFixedDim: DesignTokens.primaryFixedDim,
    onPrimaryFixedVariant: DesignTokens.onPrimaryFixedVariant,
    secondary: DesignTokens.secondary,
    onSecondary: DesignTokens.onSecondary,
    secondaryContainer: DesignTokens.secondaryContainer,
    onSecondaryContainer: DesignTokens.onSecondaryContainer,
    secondaryFixed: DesignTokens.secondaryFixed,
    onSecondaryFixed: DesignTokens.onSecondaryFixed,
    secondaryFixedDim: DesignTokens.secondaryFixedDim,
    onSecondaryFixedVariant: DesignTokens.onSecondaryFixedVariant,
    tertiary: DesignTokens.tertiary,
    onTertiary: DesignTokens.onTertiary,
    tertiaryContainer: DesignTokens.tertiaryContainer,
    onTertiaryContainer: DesignTokens.onTertiaryContainer,
    tertiaryFixed: DesignTokens.tertiaryFixed,
    onTertiaryFixed: DesignTokens.onTertiaryFixed,
    tertiaryFixedDim: DesignTokens.tertiaryFixedDim,
    onTertiaryFixedVariant: DesignTokens.onTertiaryFixedVariant,
    error: DesignTokens.error,
    onError: DesignTokens.onError,
    errorContainer: DesignTokens.errorContainer,
    onErrorContainer: DesignTokens.onErrorContainer,
    surface: DesignTokens.surface,
    onSurface: DesignTokens.onSurface,
    onSurfaceVariant: DesignTokens.onSurfaceVariant,
    surfaceDim: DesignTokens.surfaceDim,
    surfaceBright: DesignTokens.surfaceBright,
    surfaceContainerLowest: DesignTokens.surfaceContainerLowest,
    surfaceContainerLow: DesignTokens.surfaceContainerLow,
    surfaceContainer: DesignTokens.surfaceContainer,
    surfaceContainerHigh: DesignTokens.surfaceContainerHigh,
    surfaceContainerHighest: DesignTokens.surfaceContainerHighest,
    surfaceTint: DesignTokens.surfaceTint,
    outline: DesignTokens.outline,
    outlineVariant: DesignTokens.outlineVariant,
    inverseSurface: DesignTokens.inverseSurface,
    onInverseSurface: DesignTokens.inverseOnSurface,
    inversePrimary: DesignTokens.inversePrimary,
    scrim: DesignTokens.scrimColor,
  );

  /// Tasarımda koyu palet olmadığı için tohumdan türetiliyor. Gerçek koyu
  /// değerler geldiğinde bu da `_lightScheme` gibi birebir yazılmalı.
  static final ColorScheme _darkScheme = ColorScheme.fromSeed(
    seedColor: DesignTokens.primaryContainer,
    brightness: Brightness.dark,
  );

  // -------------------------------------------------------------- tipografi

  /// Tasarımın yedi metin stilini Material yuvalarına eşler.
  static TextTheme _textTheme(ColorScheme scheme) {
    TextStyle style({
      required double size,
      required double height,
      required FontWeight weight,
      double? letterSpacing,
      Color? color,
    }) {
      return TextStyle(
        fontFamily: DesignTokens.fontFamily,
        fontSize: size,
        // Flutter'ın `height` değeri satır yüksekliği / punto oranıdır.
        height: height / size,
        fontWeight: weight,
        // Değişken fontta ağırlığı asıl belirleyen `wght` eksenidir;
        // `fontWeight` yalnızca eksen desteklenmezse yedek olarak kullanılır.
        fontVariations: [FontVariation('wght', weight.value.toDouble())],
        letterSpacing: letterSpacing,
        color: color ?? scheme.onSurface,
      );
    }

    return TextTheme(
      // display-lg
      displayLarge: style(
        size: DesignTokens.displayLargeSize,
        height: DesignTokens.displayLargeHeight,
        weight: DesignTokens.displayLargeWeight,
        letterSpacing: DesignTokens.displayLargeLetterSpacing,
      ),
      // display-lg-mobile — "SmartList" başlığı bunu kullanıyor
      displayMedium: style(
        size: DesignTokens.displayMobileSize,
        height: DesignTokens.displayMobileHeight,
        weight: DesignTokens.displayMobileWeight,
      ),
      // headline-md
      headlineMedium: style(
        size: DesignTokens.headlineMediumSize,
        height: DesignTokens.headlineMediumHeight,
        weight: DesignTokens.headlineMediumWeight,
        letterSpacing: DesignTokens.headlineMediumLetterSpacing,
      ),
      // headline-sm
      headlineSmall: style(
        size: DesignTokens.headlineSmallSize,
        height: DesignTokens.headlineSmallHeight,
        weight: DesignTokens.headlineSmallWeight,
      ),
      // Kart başlığı: headline-sm ağırlığı, 18px punto
      titleLarge: style(
        size: DesignTokens.titleOnCardSize,
        height: DesignTokens.headlineSmallHeight,
        weight: DesignTokens.headlineSmallWeight,
      ),
      // Liste öğesi başlığı: headline-sm ağırlığı, 16px punto
      titleMedium: style(
        size: DesignTokens.titleOnListItemSize,
        height: DesignTokens.bodyLargeHeight,
        weight: DesignTokens.headlineSmallWeight,
      ),
      // body-lg
      bodyLarge: style(
        size: DesignTokens.bodyLargeSize,
        height: DesignTokens.bodyLargeHeight,
        weight: DesignTokens.bodyLargeWeight,
      ),
      // body-sm
      bodyMedium: style(
        size: DesignTokens.bodySmallSize,
        height: DesignTokens.bodySmallHeight,
        weight: DesignTokens.bodySmallWeight,
      ),
      bodySmall: style(
        size: DesignTokens.bodySmallSize,
        height: DesignTokens.bodySmallHeight,
        weight: DesignTokens.bodySmallWeight,
        color: scheme.onSurfaceVariant,
      ),
      // label-md
      labelMedium: style(
        size: DesignTokens.labelMediumSize,
        height: DesignTokens.labelMediumHeight,
        weight: DesignTokens.labelMediumWeight,
        letterSpacing: DesignTokens.labelMediumLetterSpacing,
      ),
      labelSmall: style(
        size: DesignTokens.labelMediumSize,
        height: DesignTokens.labelMediumHeight,
        weight: DesignTokens.labelMediumWeight,
        letterSpacing: DesignTokens.labelMediumLetterSpacing,
        color: scheme.onSurfaceVariant,
      ),
    );
  }

  // ------------------------------------------------------------------- tema

  static ThemeData _build(ColorScheme scheme) {
    final textTheme = _textTheme(scheme);

    return ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      textTheme: textTheme,
      scaffoldBackgroundColor: scheme.surface,
      extensions: const <ThemeExtension<dynamic>>[SpacingTheme.standard],

      // Üst çubuk: yüzey rengi, gölge yok — tasarımda kaydırmayla gölge
      // beliriyor, onu `scrolledUnderElevation` sağlıyor.
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: false,
        titleTextStyle: textTheme.headlineSmall,
      ),

      // Kartlar tasarımda beyaz, 24px köşeli ve `card-shadow` taşıyor.
      // Yumuşak gölge Material'ın elevation modeliyle üretilemediği için
      // burada elevation sıfır; gölgeyi DesignTokens.cardShadow ile veren
      // ortak kart widget'ı kullanılır.
      cardTheme: CardThemeData(
        color: scheme.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: scheme.outlineVariant),
          borderRadius: BorderRadius.circular(DesignTokens.radius2xl),
        ),
      ),

      // Form alanları: beyaz dolgu, outline-variant kenar, 12px köşe.
      // Odakta kenar `primary` rengine geçiyor.
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerLowest,
        hintStyle: textTheme.bodyLarge?.copyWith(color: scheme.outline),
        labelStyle: textTheme.labelMedium?.copyWith(
          color: scheme.onSurfaceVariant,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.space4,
          vertical: DesignTokens.space4,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusXl),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusXl),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusXl),
          borderSide: BorderSide(color: scheme.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusXl),
          borderSide: BorderSide(color: scheme.error),
        ),
      ),

      // Birincil buton: primary-container dolgu, 24px köşe, 64px yükseklik.
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.primaryContainer,
          foregroundColor: scheme.onPrimaryContainer,
          minimumSize: const Size.fromHeight(DesignTokens.primaryButtonHeight),
          textStyle: textTheme.headlineSmall,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radius2xl),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.primary,
          minimumSize: const Size.fromHeight(DesignTokens.actionButtonHeight),
          side: BorderSide(color: scheme.outlineVariant),
          textStyle: textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radius2xl),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.primary,
          textStyle: textTheme.labelMedium,
        ),
      ),

      // FAB: primary-container dolgu, tam yuvarlak.
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primaryContainer,
        foregroundColor: scheme.onPrimary,
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        shape: const CircleBorder(),
      ),

      // Bottom sheet: beyaz, üst köşeler 32px, tutamaçlı.
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        showDragHandle: true,
        dragHandleColor: scheme.outlineVariant,
        dragHandleSize: const Size(
          DesignTokens.dragHandleWidth,
          DesignTokens.dragHandleHeight,
        ),
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(DesignTokens.radius3xl),
          ),
        ),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(DesignTokens.radius2xl),
          ),
        ),
      ),

      // Kategori seçici çipleri: dolu hâlde primary-container.
      chipTheme: ChipThemeData(
        backgroundColor: scheme.surfaceContainerLow,
        selectedColor: scheme.primaryContainer,
        side: BorderSide(color: scheme.outlineVariant),
        labelStyle: textTheme.labelMedium,
        padding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.space4,
          vertical: DesignTokens.space2,
        ),
        shape: const StadiumBorder(),
      ),

      // Checkbox: 28px, 8px köşe, işaretliyken primary-container.
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.selected)
              ? scheme.primaryContainer
              : Colors.transparent;
        }),
        checkColor: const WidgetStatePropertyAll(Colors.white),
        side: BorderSide(color: scheme.outlineVariant, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusCheckbox),
        ),
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.primaryContainer,
        linearTrackColor: scheme.surfaceContainer,
        linearMinHeight: DesignTokens.progressBarHeight,
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: scheme.inverseSurface,
        contentTextStyle: textTheme.bodyLarge?.copyWith(
          color: scheme.onInverseSurface,
        ),
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(DesignTokens.radiusXl),
          ),
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        indicatorColor: scheme.primaryContainer,
        indicatorShape: const StadiumBorder(),
        height: DesignTokens.bottomNavHeight,
        elevation: 0,
        labelTextStyle: WidgetStatePropertyAll(textTheme.labelMedium),
      ),

      listTileTheme: const ListTileThemeData(
        minVerticalPadding: DesignTokens.space2,
      ),

      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        space: 1,
        thickness: 1,
      ),

      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}
