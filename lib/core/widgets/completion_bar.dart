import 'package:flutter/material.dart';

import 'package:smartlist/core/theme/design_tokens.dart';

/// Tamamlanma oranı çubuğu.
///
/// Tasarımda iki boyutta geçiyor: kartlarda 8px (`h-2`), üst çubukta 4px
/// (`h-1`). Dolgu rengi orana göre değişiyor — liste bittiğinde `secondary`
/// (yeşil), aksi hâlde `primaryContainer`.
class CompletionBar extends StatelessWidget {
  const CompletionBar({
    required this.progress,
    this.height = DesignTokens.progressBarHeight,
    this.width,
    this.animate = true,
    super.key,
  });

  /// Üst çubuktaki ince varyant (`h-1 w-24`).
  const CompletionBar.thin({
    required this.progress,
    this.width = 96,
    this.animate = true,
    super.key,
  }) : height = DesignTokens.progressBarHeightThin;

  /// `0..1` aralığında tamamlanma oranı.
  final double progress;
  final double height;
  final double? width;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final clamped = progress.clamp(0.0, 1.0);
    final isComplete = clamped >= 1;
    final fill = isComplete ? scheme.secondary : scheme.primaryContainer;

    return Semantics(
      // Ekran okuyucu yüzde olarak okur; görsel çubuk tek başına anlam taşımaz.
      label: 'Tamamlanma',
      value: '${(clamped * 100).round()}%',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(height / 2),
        child: SizedBox(
          width: width,
          height: height,
          child: ColoredBox(
            color: scheme.surfaceContainer,
            child: Align(
              alignment: Alignment.centerLeft,
              child: animate
                  ? AnimatedFractionallySizedBox(
                      duration: DesignTokens.durationSlow,
                      curve: DesignTokens.curveSwipe,
                      widthFactor: clamped,
                      heightFactor: 1,
                      child: ColoredBox(color: fill),
                    )
                  : FractionallySizedBox(
                      widthFactor: clamped,
                      heightFactor: 1,
                      child: ColoredBox(color: fill),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Kartlardaki "Tamamlanma / %65" satırı ve altındaki çubuk.
class CompletionRow extends StatelessWidget {
  const CompletionRow({required this.progress, super.key});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final clamped = progress.clamp(0.0, 1.0);
    final isComplete = clamped >= 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tamamlanma',
              style: theme.textTheme.labelMedium?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
            Text(
              '${(clamped * 100).round()}%',
              style: theme.textTheme.labelMedium?.copyWith(
                color: isComplete ? scheme.secondary : scheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: DesignTokens.space2),
        CompletionBar(progress: clamped),
      ],
    );
  }
}
