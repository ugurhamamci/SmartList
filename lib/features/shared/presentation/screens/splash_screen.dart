import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:smartlist/core/theme/design_tokens.dart';

/// Açılış ekranı.
///
/// Logo yay eğrisiyle büyüyerek belirir, ardından uygulama adı ve alt başlık
/// sırayla yumuşak geçişle gelir; en altta ince bir yükleme çizgisi akar.
/// Toplam süre [minimumDuration] kadardır — gerçek başlatma daha hızlı bitse
/// bile animasyon yarıda kesilmez, daha uzun sürerse ekran bekler.
class SplashScreen extends StatefulWidget {
  const SplashScreen({
    required this.onFinished,
    this.minimumDuration = const Duration(milliseconds: 2200),
    super.key,
  });

  /// Animasyon bittiğinde çağrılır.
  final VoidCallback onFinished;

  final Duration minimumDuration;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Bekleme initState'te başlatılır; sonucu beklenmediği için açıkça
    // "unawaited" işaretlenir.
    unawaited(_start());
  }

  Future<void> _start() async {
    await Future<void>.delayed(widget.minimumDuration);
    // Ekran bu arada ağaçtan çıkmış olabilir.
    if (mounted) {
      widget.onFinished();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      body: Stack(
        children: [
          // Arka plan parıltısı: tasarımdaki `bg-primary/5 blur-[80px]` lekesi.
          Positioned(
            left: -80,
            right: -80,
            bottom: -40,
            child: IgnorePointer(
              child: Container(
                height: 320,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      scheme.primary.withValues(alpha: 0.10),
                      scheme.primary.withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        color: scheme.primaryContainer,
                        borderRadius: BorderRadius.circular(
                          DesignTokens.radius2xl,
                        ),
                        boxShadow: DesignTokens.fabShadow,
                      ),
                      child: Icon(
                        Icons.shopping_basket,
                        size: 48,
                        color: scheme.onPrimary,
                      ),
                    )
                    .animate()
                    .scale(
                      begin: const Offset(0.6, 0.6),
                      end: const Offset(1, 1),
                      duration: 600.ms,
                      curve: Curves.easeOutBack,
                    )
                    .fadeIn(duration: 400.ms),

                const SizedBox(height: DesignTokens.space6),

                // Uygulama adı
                Text(
                      'SmartList',
                      style: theme.textTheme.displayLarge?.copyWith(
                        color: scheme.primary,
                      ),
                    )
                    .animate(delay: 350.ms)
                    .fadeIn(duration: 500.ms)
                    .slideY(begin: 0.3, end: 0, curve: Curves.easeOutCubic),

                const SizedBox(height: DesignTokens.space2),

                // Alt başlık
                Text(
                      'Birlikte alışveriş, akıllı listeler',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    )
                    .animate(delay: 650.ms)
                    .fadeIn(duration: 500.ms)
                    .slideY(begin: 0.4, end: 0, curve: Curves.easeOutCubic),
              ],
            ),
          ),

          // Yükleme çizgisi
          Positioned(
            left: 0,
            right: 0,
            bottom: DesignTokens.space10 * 2,
            child: Center(
              child: SizedBox(
                width: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    DesignTokens.radiusFull,
                  ),
                  child: LinearProgressIndicator(
                    minHeight: DesignTokens.progressBarHeightThin,
                    backgroundColor: scheme.surfaceContainer,
                    color: scheme.primaryContainer,
                  ),
                ),
              ).animate(delay: 900.ms).fadeIn(duration: 400.ms),
            ),
          ),
        ],
      ),
    );
  }
}
