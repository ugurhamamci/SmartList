import 'package:flutter/material.dart';

import 'package:smartlist/core/theme/design_tokens.dart';
import 'package:smartlist/core/theme/spacing_theme.dart';

/// Liste detayında gösterilecek tek ürün.
class ItemRowData {
  const ItemRowData({
    required this.id,
    required this.name,
    required this.category,
    required this.quantityLabel,
    this.priceLabel,
    this.noteAuthorInitial,
    this.noteText,
    this.isCompleted = false,
  });

  final String id;
  final String name;
  final String category;
  final String quantityLabel;
  final String? priceLabel;

  /// Not veya "ekleyen" satırındaki kişinin baş harfi.
  final String? noteAuthorInitial;
  final String? noteText;

  final bool isCompleted;

  ItemRowData copyWith({bool? isCompleted}) {
    return ItemRowData(
      id: id,
      name: name,
      category: category,
      quantityLabel: quantityLabel,
      priceLabel: priceLabel,
      noteAuthorInitial: noteAuthorInitial,
      noteText: noteText,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

/// Tasarımın 28px, 8px köşeli checkbox'ı.
///
/// Material'ın [Checkbox] widget'ı 18px sabit kutu çizdiği ve köşe yarıçapını
/// bu ölçüde vermediği için elle yazıldı. İşaretlendiğinde kutu dolarken
/// tik işareti yay eğrisiyle büyür.
class SmartCheckbox extends StatelessWidget {
  const SmartCheckbox({
    required this.checked,
    this.onChanged,
    super.key,
  });

  final bool checked;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Semantics(
      checked: checked,
      label: 'Tamamlandı',
      child: GestureDetector(
        onTap: onChanged == null ? null : () => onChanged!(!checked),
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          // Kutu 28px, dokunma alanı 48px.
          width: DesignTokens.touchTarget,
          height: DesignTokens.touchTarget,
          child: Center(
            child: AnimatedContainer(
              duration: DesignTokens.durationFast,
              curve: Curves.easeOut,
              width: DesignTokens.checkboxSize,
              height: DesignTokens.checkboxSize,
              decoration: BoxDecoration(
                color: checked ? scheme.primaryContainer : Colors.transparent,
                borderRadius: BorderRadius.circular(
                  DesignTokens.radiusCheckbox,
                ),
                border: Border.all(
                  color: checked
                      ? scheme.primaryContainer
                      : scheme.outlineVariant,
                  width: 2,
                ),
              ),
              child: AnimatedScale(
                scale: checked ? 1 : 0,
                duration: DesignTokens.durationFast,
                curve: Curves.easeOutBack,
                child: Icon(
                  Icons.check,
                  size: DesignTokens.iconSmall,
                  color: scheme.onPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Liste detayındaki ürün satırı.
///
/// Sağa kaydırma tamamlar, sola kaydırma siler — tasarımın jest davranışı.
/// [Dismissible] kullanılıyor: eşikler ve arka plan aksiyonları tasarımdaki
/// 100px eşiğine karşılık gelir.
class ShoppingItemTile extends StatelessWidget {
  const ShoppingItemTile({
    required this.item,
    this.onToggle,
    this.onDelete,
    this.onTap,
    super.key,
  });

  final ItemRowData item;
  final ValueChanged<bool>? onToggle;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final spacing = context.spacing;
    final done = item.isCompleted;

    final tile = AnimatedOpacity(
      duration: DesignTokens.durationSlower,
      // Tamamlanan öğe tasarımda %50 opaklığa düşüyor.
      opacity: done ? 0.5 : 1,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: done
              ? scheme.surfaceContainerLow
              : scheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(spacing.radiusItem),
          border: done
              ? Border.all(color: scheme.outlineVariant.withValues(alpha: 0.3))
              : null,
          boxShadow: done ? null : DesignTokens.cardShadow,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: DesignTokens.space1,
            horizontal: DesignTokens.space2,
          ),
          child: Row(
            children: [
              SmartCheckbox(checked: done, onChanged: onToggle),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: DesignTokens.space2,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              item.name,
                              style: theme.textTheme.titleMedium?.copyWith(
                                decoration: done
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                          ),
                          _CategoryChip(label: item.category, muted: done),
                        ],
                      ),
                      const SizedBox(height: DesignTokens.space1),
                      Row(
                        children: [
                          Text(
                            item.quantityLabel,
                            style: theme.textTheme.bodySmall,
                          ),
                          if (item.priceLabel != null) ...[
                            Text(
                              '  •  ',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: scheme.outlineVariant,
                              ),
                            ),
                            Text(
                              item.priceLabel!,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: done
                                    ? scheme.onSurfaceVariant
                                    : scheme.primary,
                                fontWeight: done
                                    ? FontWeight.w400
                                    : FontWeight.w600,
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (item.noteText != null && !done) ...[
                        const SizedBox(height: DesignTokens.space2),
                        Row(
                          children: [
                            Container(
                              width: DesignTokens.avatarTiny,
                              height: DesignTokens.avatarTiny,
                              decoration: BoxDecoration(
                                color: scheme.primaryContainer,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  item.noteAuthorInitial ?? '?',
                                  style: TextStyle(
                                    fontFamily: DesignTokens.fontFamily,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w700,
                                    color: scheme.onPrimary,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: DesignTokens.space1),
                            Expanded(
                              child: Text(
                                item.noteText!,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  fontSize: 10,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (onDelete == null && onToggle == null) {
      return tile;
    }

    return Dismissible(
      key: ValueKey(item.id),
      // Sağa kaydırma tamamlar, sola kaydırma siler.
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          onToggle?.call(!done);
          // Öğe listede kalır; yalnızca durumu değişir.
          return false;
        }
        return true;
      },
      onDismissed: (_) => onDelete?.call(),
      background: _SwipeBackground(
        color: scheme.secondary,
        icon: Icons.check_circle,
        label: done ? 'Geri al' : 'Tamamla',
        alignment: Alignment.centerLeft,
      ),
      secondaryBackground: const _SwipeBackground(
        color: Color(0xFFBA1A1A),
        icon: Icons.delete_outline,
        label: 'Sil',
        alignment: Alignment.centerRight,
      ),
      child: GestureDetector(onTap: onTap, child: tile),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.label, required this.muted});

  final String label;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: muted
            ? scheme.surfaceContainerHighest
            : scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(DesignTokens.radiusDefault),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.space2,
          vertical: 2,
        ),
        child: Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: scheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _SwipeBackground extends StatelessWidget {
  const _SwipeBackground({
    required this.color,
    required this.icon,
    required this.label,
    required this.alignment,
  });

  final Color color;
  final IconData icon;
  final String label;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: DesignTokens.space5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(spacing.radiusItem),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: DesignTokens.iconMedium),
          const SizedBox(width: DesignTokens.space2),
          Text(
            label,
            style: const TextStyle(
              fontFamily: DesignTokens.fontFamily,
              fontSize: DesignTokens.labelMediumSize,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
