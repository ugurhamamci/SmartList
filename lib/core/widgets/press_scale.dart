import 'package:flutter/material.dart';

import 'package:smartlist/core/theme/design_tokens.dart';

/// Basılı tutulduğunda küçülen dokunma alanı.
///
/// Tasarım bu davranışı her etkileşimli öğede `active:scale-95`,
/// `active:scale-90` ve `active:scale-[0.98]` sınıflarıyla kullanıyor. Tek
/// widget'ta toplandığı için hem üç ölçek değeri tutarlı kalıyor hem de her
/// dokunulabilir öğe otomatik olarak 48px'lik erişilebilirlik alt sınırını
/// karşılıyor.
class PressScale extends StatefulWidget {
  const PressScale({
    required this.child,
    this.onTap,
    this.scale = DesignTokens.pressScale,
    this.semanticLabel,
    this.enforceMinTouchTarget = true,
    super.key,
  });

  /// Kart ve geniş yüzeyler için hafif küçülme (`active:scale-[0.98]`).
  const PressScale.subtle({
    required this.child,
    this.onTap,
    this.semanticLabel,
    this.enforceMinTouchTarget = false,
    super.key,
  }) : scale = DesignTokens.pressScaleSubtle;

  /// FAB ve ikon butonları için belirgin küçülme (`active:scale-90`).
  const PressScale.strong({
    required this.child,
    this.onTap,
    this.semanticLabel,
    this.enforceMinTouchTarget = true,
    super.key,
  }) : scale = DesignTokens.pressScaleStrong;

  final Widget child;
  final VoidCallback? onTap;
  final double scale;
  final String? semanticLabel;

  /// Küçük ikon butonlarının dokunma alanını 48px'e genişletir.
  final bool enforceMinTouchTarget;

  @override
  State<PressScale> createState() => _PressScaleState();
}

class _PressScaleState extends State<PressScale> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed != value) {
      setState(() => _pressed = value);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = AnimatedScale(
      scale: _pressed ? widget.scale : 1,
      duration: DesignTokens.durationFast,
      curve: DesignTokens.curveSwipe,
      child: widget.child,
    );

    if (widget.enforceMinTouchTarget) {
      content = ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: DesignTokens.touchTarget,
          minHeight: DesignTokens.touchTarget,
        ),
        child: Center(child: content),
      );
    }

    return Semantics(
      label: widget.semanticLabel,
      button: widget.onTap != null,
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => _setPressed(true),
        onTapUp: (_) => _setPressed(false),
        onTapCancel: () => _setPressed(false),
        behavior: HitTestBehavior.opaque,
        child: content,
      ),
    );
  }
}
