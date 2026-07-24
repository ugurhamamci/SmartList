import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartlist/core/theme/app_theme.dart';
import 'package:smartlist/core/theme/design_tokens.dart';
import 'package:smartlist/core/theme/spacing_theme.dart';

void main() {
  group('AppTheme renkleri', () {
    test('açık tema paleti tasarımdaki değerleri birebir taşır', () {
      final scheme = AppTheme.light().colorScheme;

      expect(scheme.brightness, Brightness.light);
      // Metin ve ikon rengi: Design System dosyasındaki primary.
      expect(scheme.primary, const Color(0xFF3525CD));
      // Dolgu rengi: buton, FAB, checkbox ve odak halkası.
      expect(scheme.primaryContainer, const Color(0xFF4F46E5));
      expect(scheme.secondary, const Color(0xFF006E2F));
      expect(scheme.surface, const Color(0xFFF9F9FF));
      expect(scheme.onSurface, const Color(0xFF141B2B));
      expect(scheme.onSurfaceVariant, const Color(0xFF464555));
      expect(scheme.outlineVariant, const Color(0xFFC7C4D8));
      // Kartlar tasarımda beyaz; `surface` değerinden farklı.
      expect(scheme.surfaceContainerLowest, const Color(0xFFFFFFFF));
    });

    test('koyu tema türetilir ve parlaklığı doğrudur', () {
      // Tasarım koyu palet vermiyor; tohumdan türetildiği için renk
      // eşitliği değil yalnızca parlaklık doğrulanır.
      expect(AppTheme.dark().colorScheme.brightness, Brightness.dark);
    });
  });

  group('AppTheme tipografisi', () {
    test('metin ölçeği tasarımın punto ve satır yüksekliklerini kullanır', () {
      final text = AppTheme.light().textTheme;

      // display-lg-mobile: 28px / 36px / 700
      expect(text.displayMedium?.fontSize, 28);
      expect(text.displayMedium?.fontWeight, FontWeight.w700);
      expect(text.displayMedium?.height, closeTo(36 / 28, 0.001));

      // headline-md: 24px / 32px / -0.01em / 600
      expect(text.headlineMedium?.fontSize, 24);
      expect(text.headlineMedium?.letterSpacing, closeTo(-0.24, 0.001));

      // body-lg: 16px / 24px / 400
      expect(text.bodyLarge?.fontSize, 16);
      expect(text.bodyLarge?.height, closeTo(24 / 16, 0.001));

      // label-md: 12px / 16px / 0.05em / 600
      expect(text.labelMedium?.fontSize, 12);
      expect(text.labelMedium?.fontWeight, FontWeight.w600);
      expect(text.labelMedium?.letterSpacing, closeTo(0.6, 0.001));
    });
  });

  group('SpacingTheme', () {
    testWidgets('her iki parlaklıkta alt widgetlara aktarılır', (
      tester,
    ) async {
      for (final theme in [AppTheme.light(), AppTheme.dark()]) {
        late SpacingTheme spacing;

        await tester.pumpWidget(
          MaterialApp(
            theme: theme,
            home: Builder(
              builder: (context) {
                spacing = context.spacing;
                return const SizedBox.shrink();
              },
            ),
          ),
        );

        expect(spacing.containerMargin, DesignTokens.containerMargin);
        expect(spacing.sectionGap, DesignTokens.sectionGap);
        expect(spacing.radiusCard, DesignTokens.radius2xl);
        expect(spacing.radiusSheet, DesignTokens.radius3xl);
      }
    });
  });

  group('Erişilebilirlik', () {
    testWidgets('birincil buton dokunma hedefi alt sınırını karşılar', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: FilledButton(onPressed: () {}, child: const Text('Kaydet')),
          ),
        ),
      );

      final size = tester.getSize(find.byType(FilledButton));
      // Tasarımdaki birincil buton 64px; 48px alt sınırının üstünde.
      expect(size.height, DesignTokens.primaryButtonHeight);
      expect(size.height, greaterThanOrEqualTo(DesignTokens.touchTarget));
    });
  });
}
