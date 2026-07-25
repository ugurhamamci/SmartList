import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:smartlist/core/theme/design_tokens.dart';
import 'package:smartlist/core/theme/spacing_theme.dart';
import 'package:smartlist/core/widgets/completion_bar.dart';
import 'package:smartlist/core/widgets/press_scale.dart';
import 'package:smartlist/features/shopping_lists/presentation/widgets/shopping_item_tile.dart';

/// Liste detay ekranı.
///
/// Üstte başlık ve ince tamamlanma çubuğu, altta "Alınacaklar" ve
/// "Tamamlananlar" bölümleri. Öğeler sırayla kayarak belirir — tasarımdaki
/// `@keyframes slideIn` (10px öteleme + solma, 0.4s) karşılığı.
class ListDetailView extends StatelessWidget {
  const ListDetailView({
    required this.title,
    required this.items,
    this.onBack,
    this.onSearch,
    this.onMore,
    this.onToggleItem,
    this.onDeleteItem,
    this.onEditItem,
    this.onClearCompleted,
    super.key,
  });

  final String title;
  final List<ItemRowData> items;

  final VoidCallback? onBack;
  final VoidCallback? onSearch;
  final VoidCallback? onMore;

  /// Adlandırılmış parametreler kullanılıyor: iki değerin sırası çağrı
  /// yerinde okunamaz hâle gelmesin.
  final void Function({required String id, required bool completed})?
  onToggleItem;
  final ValueChanged<String>? onDeleteItem;

  /// Ürüne dokunulduğunda düzenleme akışı. Tamamlanma kutusu ayrı çalışıyor;
  /// satırın geri kalanına dokunmak düzenleme demek.
  final ValueChanged<String>? onEditItem;
  final VoidCallback? onClearCompleted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final spacing = context.spacing;

    final active = items.where((item) => !item.isCompleted).toList();
    final completed = items.where((item) => item.isCompleted).toList();
    final progress = items.isEmpty ? 0.0 : completed.length / items.length;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          backgroundColor: scheme.surface,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 1,
          leading: PressScale(
            onTap: onBack,
            semanticLabel: 'Geri',
            child: Icon(Icons.arrow_back, color: scheme.onSurface),
          ),
          titleSpacing: 0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: theme.textTheme.headlineSmall),
              const SizedBox(height: 2),
              Row(
                children: [
                  CompletionBar.thin(progress: progress),
                  const SizedBox(width: DesignTokens.space2),
                  Text(
                    '${completed.length}/${items.length}',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            PressScale(
              onTap: onSearch,
              semanticLabel: 'Ara',
              child: Icon(Icons.search, color: scheme.primary),
            ),
            PressScale(
              onTap: onMore,
              semanticLabel: 'Daha fazla',
              child: Icon(Icons.more_vert, color: scheme.onSurfaceVariant),
            ),
            SizedBox(width: spacing.small),
          ],
        ),

        // --- Alınacaklar ---
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            spacing.containerMargin,
            spacing.gutter,
            spacing.containerMargin,
            DesignTokens.space2,
          ),
          sliver: SliverToBoxAdapter(
            child: Text(
              'ALINACAKLAR',
              style: theme.textTheme.labelMedium?.copyWith(
                color: scheme.primary,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),

        if (active.isEmpty)
          const SliverToBoxAdapter(
            child: _EmptyState(
              icon: Icons.check_circle_outline,
              title: 'Her şey tamam',
              message: 'Bu listede alınacak ürün kalmadı.',
            ),
          )
        else
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: spacing.containerMargin,
            ),
            sliver: SliverList.separated(
              itemCount: active.length,
              separatorBuilder: (_, _) => SizedBox(height: spacing.stackGap),
              itemBuilder: (context, index) {
                final item = active[index];
                return ShoppingItemTile(
                      item: item,
                      onToggle: (value) =>
                          onToggleItem?.call(id: item.id, completed: value),
                      onDelete: () => onDeleteItem?.call(item.id),
                      onTap: onEditItem == null
                          ? null
                          : () => onEditItem!(item.id),
                    )
                    // Sırayla belirme: her öğe 60ms gecikmeli.
                    .animate(delay: (index * 60).ms)
                    .fadeIn(duration: DesignTokens.durationSlow)
                    .slideY(
                      begin: 0.25,
                      end: 0,
                      curve: DesignTokens.curveSwipe,
                    );
              },
            ),
          ),

        // --- Tamamlananlar ---
        if (completed.isNotEmpty) ...[
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              spacing.containerMargin,
              spacing.sectionGap,
              spacing.containerMargin,
              DesignTokens.space2,
            ),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TAMAMLANANLAR (${completed.length})',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: scheme.outline,
                      letterSpacing: 1.5,
                    ),
                  ),
                  TextButton(
                    onPressed: onClearCompleted,
                    child: const Text('Temizle'),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: spacing.containerMargin,
            ),
            sliver: SliverList.separated(
              itemCount: completed.length,
              separatorBuilder: (_, _) => SizedBox(height: spacing.stackGap),
              itemBuilder: (context, index) {
                final item = completed[index];
                return ShoppingItemTile(
                  item: item,
                  onToggle: (value) =>
                      onToggleItem?.call(id: item.id, completed: value),
                  onDelete: () => onDeleteItem?.call(item.id),
                  onTap: onEditItem == null ? null : () => onEditItem!(item.id),
                );
              },
            ),
          ),
        ],

        const SliverToBoxAdapter(
          child: SizedBox(height: DesignTokens.space10 * 3),
        ),
      ],
    );
  }
}

/// Boş durum kartı.
class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DesignTokens.containerMargin,
            vertical: DesignTokens.space10,
          ),
          child: Column(
            children: [
              Icon(icon, size: 56, color: scheme.secondary),
              const SizedBox(height: DesignTokens.space4),
              Text(title, style: theme.textTheme.headlineSmall),
              const SizedBox(height: DesignTokens.space1),
              Text(
                message,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: DesignTokens.durationSlow)
        .scale(
          begin: const Offset(0.9, 0.9),
          end: const Offset(1, 1),
          curve: Curves.easeOutBack,
        );
  }
}
