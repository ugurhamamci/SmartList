import 'package:flutter/material.dart';

import 'package:smartlist/core/theme/design_tokens.dart';
import 'package:smartlist/core/theme/spacing_theme.dart';
import 'package:smartlist/core/widgets/press_scale.dart';

/// Hızlı aksiyon karosunun görsel varyantları.
///
/// Tasarımda 2x2 ızgarada üç farklı görünüm var: dolu (birincil), yüzey
/// (ikincil) ve AI vurgusu (üçüncül ikon rengi).
enum QuickActionStyle {
  /// `bg-primary` + beyaz metin — "Yeni Liste".
  filled,

  /// Beyaz kart + `primary` ikon — "QR Katıl", "Davet Et".
  surface,

  /// Beyaz kart + `tertiary` ikon — "AI Liste Oluştur".
  accent,
}

/// Ana ekrandaki hızlı aksiyon karosu.
class QuickActionTile extends StatelessWidget {
  const QuickActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.style = QuickActionStyle.surface,
    this.filledIcon = false,
    super.key,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final QuickActionStyle style;

  /// Tasarım bazı ikonlarda `FILL 1` kullanıyor; Flutter'da bunun karşılığı
  /// dolu ikon varyantıdır.
  final bool filledIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final spacing = context.spacing;
    final isFilled = style == QuickActionStyle.filled;

    // Dolu karo, tasarımdaki #4f46e5 değerini taşıyan primaryContainer'ı
    // kullanır; ikon kutusu bunun üzerinde %20 beyazdır.
    final background = isFilled
        ? scheme.primaryContainer
        : scheme.surfaceContainerLowest;
    final foreground = isFilled ? scheme.onPrimary : scheme.onSurface;

    final iconBoxColor = switch (style) {
      QuickActionStyle.filled => Colors.white.withValues(alpha: 0.2),
      QuickActionStyle.surface => scheme.surfaceContainer,
      // `bg-tertiary-container/10`
      QuickActionStyle.accent => scheme.tertiaryContainer.withValues(
        alpha: 0.1,
      ),
    };

    final iconColor = switch (style) {
      QuickActionStyle.filled => scheme.onPrimary,
      QuickActionStyle.surface => scheme.primary,
      QuickActionStyle.accent => scheme.tertiary,
    };

    return PressScale(
      onTap: onTap,
      semanticLabel: label,
      enforceMinTouchTarget: false,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(spacing.radiusCard),
          border: isFilled ? null : Border.all(color: scheme.outlineVariant),
          boxShadow: isFilled ? null : DesignTokens.cardShadow,
        ),
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.space5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: iconBoxColor,
                  borderRadius: BorderRadius.circular(
                    DesignTokens.radiusXl,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(DesignTokens.space2),
                  child: Icon(
                    icon,
                    size: DesignTokens.iconMedium,
                    color: iconColor,
                  ),
                ),
              ),
              const SizedBox(height: DesignTokens.space3),
              Text(
                label,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: foreground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
