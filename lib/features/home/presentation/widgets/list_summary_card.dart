import 'package:flutter/material.dart';

import 'package:smartlist/core/theme/design_tokens.dart';
import 'package:smartlist/core/widgets/avatar_stack.dart';
import 'package:smartlist/core/widgets/completion_bar.dart';
import 'package:smartlist/core/widgets/smart_card.dart';

/// Ana ekrandaki aktif liste kartı.
///
/// Başlık, "12 Ürün • Son güncelleme 1 saat önce" biçimindeki alt satır, sağ
/// üstte üye avatarları ve altta tamamlanma çubuğu.
class ListSummaryCard extends StatelessWidget {
  const ListSummaryCard({
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.members,
    this.onTap,
    super.key,
  });

  final String title;

  /// Ürün sayısı ve son güncelleme bilgisini içeren hazır metin.
  final String subtitle;

  /// `0..1` aralığında tamamlanma oranı.
  final double progress;

  final List<AvatarData> members;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return SmartCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: theme.textTheme.titleLarge),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: DesignTokens.space3),
              AvatarStack(members: members),
            ],
          ),
          const SizedBox(height: DesignTokens.space4),
          CompletionRow(progress: progress),
        ],
      ),
    );
  }
}

/// AI'ın önerdiği liste kartı.
///
/// Sağ üst köşede "AI ÖNERİSİ" rozeti, altta tek satırlık aksiyon bağlantısı
/// var. Rozet köşeye taştığı için kart içeriği kırpılarak çiziliyor.
class AiSuggestionCard extends StatelessWidget {
  const AiSuggestionCard({
    required this.title,
    required this.subtitle,
    required this.actionLabel,
    this.onTap,
    this.onAction,
    super.key,
  });

  final String title;
  final String subtitle;
  final String actionLabel;
  final VoidCallback? onTap;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Stack(
      children: [
        SmartCard(
          onTap: onTap,
          clipContent: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Rozetin başlıkla çakışmaması için sağda yer bırakılır.
              Padding(
                padding: const EdgeInsets.only(right: DesignTokens.space10 * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: theme.textTheme.titleLarge),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: DesignTokens.space4),
              GestureDetector(
                onTap: onAction,
                child: Row(
                  children: [
                    Icon(
                      Icons.shopping_basket_outlined,
                      size: 20,
                      color: scheme.primary,
                    ),
                    const SizedBox(width: DesignTokens.space1),
                    Icon(
                      Icons.restaurant_menu,
                      size: 20,
                      color: scheme.primary,
                    ),
                    const SizedBox(width: DesignTokens.space2),
                    Expanded(
                      child: Text(
                        actionLabel,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: scheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Rozet: sağ üst köşede, sol alt köşesi yuvarlatılmış.
        Positioned(
          top: 0,
          right: 0,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(DesignTokens.radiusXl),
                topRight: Radius.circular(DesignTokens.radius2xl),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.space2,
                vertical: 2,
              ),
              child: Text(
                'AI ÖNERİSİ',
                style: theme.textTheme.labelSmall?.copyWith(
                  fontSize: 10,
                  color: scheme.primary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
