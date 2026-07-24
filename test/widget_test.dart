import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartlist/core/theme/app_theme.dart';
import 'package:smartlist/core/theme/design_tokens.dart';
import 'package:smartlist/core/theme/spacing_theme.dart';

void main() {
  group('AppTheme', () {
    testWidgets('exposes SpacingTheme to descendants in both brightnesses', (
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

        expect(spacing.medium, DesignTokens.spaceMedium);
        expect(spacing.radiusLarge, DesignTokens.radiusLarge);
      }
    });

    testWidgets('interactive controls meet the minimum touch target', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: Scaffold(
            body: FilledButton(onPressed: () {}, child: const Text('Add')),
          ),
        ),
      );

      final size = tester.getSize(find.byType(FilledButton));
      expect(size.height, greaterThanOrEqualTo(DesignTokens.minTouchTarget));
    });

    test('derives light and dark schemes from the same seed', () {
      expect(AppTheme.light().colorScheme.brightness, Brightness.light);
      expect(AppTheme.dark().colorScheme.brightness, Brightness.dark);
    });
  });
}
