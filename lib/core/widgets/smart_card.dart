import 'package:flutter/material.dart';

import 'package:smartlist/core/theme/design_tokens.dart';
import 'package:smartlist/core/theme/spacing_theme.dart';
import 'package:smartlist/core/widgets/press_scale.dart';

/// Tasarımın standart kart yüzeyi.
///
/// Beyaz dolgu, `outline-variant` kenar, 24px köşe ve `card-shadow`
/// (0 4px 20px rgba(0,0,0,0.04)). Bu yumuşak gölge Material'ın elevation
/// modeliyle üretilemediği için doğrudan [BoxShadow] olarak veriliyor.
class SmartCard extends StatelessWidget {
  const SmartCard({
    required this.child,
    this.onTap,
    this.padding,
    this.borderRadius,
    this.clipContent = false,
    super.key,
  });

  /// Liste öğeleri için daha küçük köşe (12px) ve daha dar dolgu.
  const SmartCard.listItem({
    required this.child,
    this.onTap,
    super.key,
  }) : padding = null,
       borderRadius = DesignTokens.radiusXl,
       clipContent = false;

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;

  /// AI etiketi gibi köşeye taşan içerik için kırpma açılır.
  final bool clipContent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final spacing = context.spacing;
    final radius = BorderRadius.circular(borderRadius ?? spacing.radiusCard);

    final card = DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLowest,
        borderRadius: radius,
        border: Border.all(color: scheme.outlineVariant),
        boxShadow: DesignTokens.cardShadow,
      ),
      child: ClipRRect(
        // Kenar çizgisinin üstüne binmemesi için içeriği yarıçapa göre kırpar.
        borderRadius: radius,
        clipBehavior: clipContent ? Clip.antiAlias : Clip.none,
        child: Padding(
          padding: padding ?? spacing.cardPadding,
          child: child,
        ),
      ),
    );

    if (onTap == null) {
      return card;
    }
    return PressScale.subtle(onTap: onTap, child: card);
  }
}
