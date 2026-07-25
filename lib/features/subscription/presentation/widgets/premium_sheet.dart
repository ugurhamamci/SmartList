import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:smartlist/core/theme/design_tokens.dart';
import 'package:smartlist/core/theme/spacing_theme.dart';
import 'package:smartlist/core/widgets/press_scale.dart';

/// Premium planın kapsadığı tek özellik.
class PremiumFeature {
  const PremiumFeature({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}

/// Premium tanıtım sayfası.
///
/// Ödeme akışı mağaza entegrasyonu (in-app purchase) gerektirdiği için burada
/// başlatılmıyor; ekran, özellik bayrakları ve fiyatlandırma hazır olacak
/// şekilde kuruldu ve satın alma düğmesi tek bir geri çağrıya bağlı.
class PremiumSheet extends StatefulWidget {
  const PremiumSheet({this.onPurchase, super.key});

  /// Seçilen planın kimliğiyle çağrılır (`monthly` / `yearly`).
  final ValueChanged<String>? onPurchase;

  static const List<PremiumFeature> features = [
    PremiumFeature(
      icon: Icons.auto_awesome,
      title: 'Sınırsız yapay zekâ listesi',
      description: 'Tarif, bütçe veya etkinlikten liste üret.',
    ),
    PremiumFeature(
      icon: Icons.group_add_outlined,
      title: 'Sınırsız üye',
      description: 'Ücretsiz planda liste başına 3 kişi.',
    ),
    PremiumFeature(
      icon: Icons.bar_chart,
      title: 'Gelişmiş istatistik',
      description: 'Aylık harcama, kategori ve kişi kırılımı.',
    ),
    PremiumFeature(
      icon: Icons.history,
      title: 'Sınırsız geçmiş',
      description: 'Ücretsiz planda son 30 gün saklanır.',
    ),
    PremiumFeature(
      icon: Icons.block,
      title: 'Reklamsız',
      description: 'Hiçbir ekranda reklam gösterilmez.',
    ),
  ];

  /// Alttan açılan sayfayı gösterir.
  static Future<void> show(
    BuildContext context, {
    ValueChanged<String>? onPurchase,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => PremiumSheet(onPurchase: onPurchase),
    );
  }

  @override
  State<PremiumSheet> createState() => _PremiumSheetState();
}

class _PremiumSheetState extends State<PremiumSheet> {
  /// Yıllık plan öntanımlı seçili: tasarımda önerilen plan bu.
  String _plan = 'yearly';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final spacing = context.spacing;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(spacing.radiusSheet),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            spacing.containerMargin,
            DesignTokens.space3,
            spacing.containerMargin,
            spacing.containerMargin,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Sürükleme tutamacı
              Center(
                child: Container(
                  width: DesignTokens.dragHandleWidth,
                  height: DesignTokens.dragHandleHeight,
                  decoration: BoxDecoration(
                    color: scheme.outlineVariant,
                    borderRadius: BorderRadius.circular(
                      DesignTokens.radiusFull,
                    ),
                  ),
                ),
              ),
              SizedBox(height: spacing.gutter),

              Center(
                child: Container(
                  padding: const EdgeInsets.all(DesignTokens.space4),
                  decoration: BoxDecoration(
                    color: scheme.tertiaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.workspace_premium,
                    size: DesignTokens.iconExtraLarge,
                    color: scheme.onTertiaryContainer,
                  ),
                ),
              ),
              SizedBox(height: spacing.gutter),
              Text(
                'SmartList Premium',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium,
              ),
              SizedBox(height: spacing.small),
              Text(
                'Ailenizle sınırsız liste paylaşın, yapay zekâ ve '
                'istatistiklerin tamamını açın.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: spacing.sectionGap),

              for (var i = 0; i < PremiumSheet.features.length; i++)
                Padding(
                  padding: EdgeInsets.only(bottom: spacing.gutter),
                  child: _FeatureRow(feature: PremiumSheet.features[i])
                      .animate()
                      .fadeIn(
                        delay: Duration(milliseconds: 50 * i),
                        duration: DesignTokens.durationMedium,
                      )
                      .slideX(
                        begin: 0.06,
                        curve: DesignTokens.curveStandard,
                      ),
                ),

              SizedBox(height: spacing.small),

              _PlanCard(
                title: 'Yıllık',
                price: '499,90 TL',
                caption: 'Ayda 41,65 TL • %30 tasarruf',
                badge: 'En avantajlı',
                selected: _plan == 'yearly',
                onTap: () => setState(() => _plan = 'yearly'),
              ),
              SizedBox(height: spacing.stackGap),
              _PlanCard(
                title: 'Aylık',
                price: '59,90 TL',
                caption: 'Her ay yenilenir, istediğinde iptal',
                selected: _plan == 'monthly',
                onTap: () => setState(() => _plan = 'monthly'),
              ),

              SizedBox(height: spacing.gutter),
              SizedBox(
                height: DesignTokens.primaryButtonHeight,
                child: FilledButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    widget.onPurchase?.call(_plan);
                  },
                  child: Text(
                    _plan == 'yearly'
                        ? 'Yıllık planla başla'
                        : 'Aylık planla başla',
                  ),
                ),
              ),
              SizedBox(height: spacing.small),
              Text(
                'Abonelik seçilen dönem sonunda otomatik yenilenir. '
                'Mağaza hesabınızdan iptal edebilirsiniz.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.feature});

  final PremiumFeature feature;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Row(
      children: [
        Container(
          width: DesignTokens.avatarMedium,
          height: DesignTokens.avatarMedium,
          decoration: BoxDecoration(
            color: scheme.primaryContainer.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(DesignTokens.radiusXl),
          ),
          child: Icon(
            feature.icon,
            color: scheme.primary,
            size: DesignTokens.iconSmall,
          ),
        ),
        const SizedBox(width: DesignTokens.space3),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(feature.title, style: theme.textTheme.titleMedium),
              Text(
                feature.description,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.title,
    required this.price,
    required this.caption,
    required this.selected,
    required this.onTap,
    this.badge,
  });

  final String title;
  final String price;
  final String caption;
  final String? badge;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final spacing = context.spacing;

    return Semantics(
      selected: selected,
      button: true,
      label: '$title plan, $price',
      child: PressScale(
        onTap: onTap,
        child: AnimatedContainer(
          duration: DesignTokens.durationMedium,
          curve: DesignTokens.curveStandard,
          padding: const EdgeInsets.all(DesignTokens.space4),
          decoration: BoxDecoration(
            color: selected
                ? scheme.primary.withValues(alpha: 0.06)
                : scheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(spacing.radiusCard),
            border: Border.all(
              // Seçili plan iki katı kalınlıkta kenarla işaretlenir; renk
              // körlüğünde de ayırt edilebilir olsun diye yalnızca renge
              // güvenmiyoruz.
              color: selected ? scheme.primary : scheme.outlineVariant,
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                selected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: selected ? scheme.primary : scheme.outline,
              ),
              const SizedBox(width: DesignTokens.space3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(title, style: theme.textTheme.titleLarge),
                        if (badge != null) ...[
                          const SizedBox(width: DesignTokens.space2),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: DesignTokens.space2,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: scheme.secondaryContainer,
                              borderRadius: BorderRadius.circular(
                                DesignTokens.radiusFull,
                              ),
                            ),
                            child: Text(
                              badge!,
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: scheme.onSecondaryContainer,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text(
                      caption,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Text(price, style: theme.textTheme.titleLarge),
            ],
          ),
        ),
      ),
    );
  }
}
