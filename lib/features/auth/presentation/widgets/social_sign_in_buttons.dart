import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'package:smartlist/core/theme/design_tokens.dart';
import 'package:smartlist/core/theme/spacing_theme.dart';

/// Üçüncü taraf giriş düğmeleri.
///
/// Apple düğmesi **yalnızca Apple platformlarında** gösteriliyor. Android'de
/// göstermek işe yaramıyor: kullanıcının Apple hesabı olsa bile Apple'ın
/// tasarım kuralları düğmenin yalnızca kendi platformlarında görünmesini
/// bekliyor, ve Android'de karşılığı olmayan bir seçenek sunmak kafa karıştırıcı.
///
/// Buna karşılık Apple'ın App Store kuralı, başka bir üçüncü taraf girişi
/// sunan uygulamanın iOS'ta Apple ile girişi de sunmasını zorunlu kılıyor —
/// yani Google düğmesi varsa iOS'ta Apple düğmesi olmak zorunda.
class SocialSignInButtons extends StatelessWidget {
  const SocialSignInButtons({
    required this.onGoogle,
    required this.onApple,
    this.busyProvider,
    this.enabled = true,
    super.key,
  });

  final Future<void> Function() onGoogle;
  final Future<void> Function() onApple;

  /// Hangi sağlayıcı için bekleniyor: `'google'`, `'apple'` veya `null`.
  final String? busyProvider;

  final bool enabled;

  /// Apple ile giriş yalnızca Apple platformlarında anlamlı.
  ///
  /// `kIsWeb` önce denetleniyor: web'de `Platform` erişimi çalışma anında
  /// hata veriyor.
  static bool get showApple => !kIsWeb && (Platform.isIOS || Platform.isMacOS);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final spacing = context.spacing;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Ayırıcı: "veya" iki yöntemi eşit ağırlıkta gösteriyor.
        Row(
          children: [
            Expanded(child: Divider(color: scheme.outlineVariant)),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.space3,
              ),
              child: Text(
                'veya',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
            Expanded(child: Divider(color: scheme.outlineVariant)),
          ],
        ),
        SizedBox(height: spacing.gutter),

        _ProviderButton(
          label: 'Google ile devam et',
          // Google'ın marka kuralları kendi logosunu istiyor; ambalajlı bir
          // logo varlığı eklenene kadar nötr bir simge kullanılıyor, böylece
          // markayı yanlış temsil etmiyoruz.
          icon: Icons.account_circle_outlined,
          onPressed: enabled ? onGoogle : null,
          busy: busyProvider == 'google',
        ),

        if (showApple) ...[
          SizedBox(height: spacing.stackGap),
          _ProviderButton(
            label: 'Apple ile devam et',
            icon: Icons.apple,
            onPressed: enabled ? onApple : null,
            busy: busyProvider == 'apple',
            // Apple'ın tasarım kuralı siyah zemin ve beyaz metin istiyor.
            background: scheme.onSurface,
            foreground: scheme.surface,
          ),
        ],
      ],
    );
  }
}

class _ProviderButton extends StatelessWidget {
  const _ProviderButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    required this.busy,
    this.background,
    this.foreground,
  });

  final String label;
  final IconData icon;
  final Future<void> Function()? onPressed;
  final bool busy;
  final Color? background;
  final Color? foreground;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: DesignTokens.primaryButtonHeight,
      child: OutlinedButton.icon(
        // Bekleniyorsa devre dışı: çift dokunma iki tarayıcı sekmesi açmasın.
        onPressed: busy || onPressed == null ? null : () => onPressed!(),
        icon: busy
            ? const SizedBox(
                width: DesignTokens.iconSmall,
                height: DesignTokens.iconSmall,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Icon(icon),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: foreground,
          side: BorderSide(
            color: background == null ? scheme.outlineVariant : background!,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
          ),
        ),
      ),
    );
  }
}
