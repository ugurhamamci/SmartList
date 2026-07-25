import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:smartlist/core/errors/app_exception.dart';
import 'package:smartlist/core/errors/app_exception_messages.dart';
import 'package:smartlist/core/theme/design_tokens.dart';
import 'package:smartlist/core/theme/spacing_theme.dart';
import 'package:smartlist/features/auth/auth_providers.dart';
import 'package:smartlist/features/auth/presentation/screens/sign_in_screen.dart';

/// Oturum durumuna göre giriş ekranı ile uygulamayı gösterir.
///
/// Yönlendirmeyi ekranlar değil bu widget yapıyor: her ekranın "kullanıcı
/// giriş yapmış mı" diye sorması gerekmiyor, oturum düştüğünde de uygulama
/// kendiliğinden giriş ekranına dönüyor.
class AuthGate extends ConsumerWidget {
  const AuthGate({required this.child, super.key});

  /// Giriş yapıldığında gösterilecek uygulama kabuğu.
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authStateProvider);

    return AnimatedSwitcher(
      duration: DesignTokens.durationMedium,
      child: auth.when(
        // Oturum okunurken kısa bir bekleme ekranı. Giriş ekranını gösterip
        // hemen kapatmak, uygulamayı zaten açık olan kullanıcıya yanıp sönen
        // bir ekran olarak görünüyordu.
        loading: () => const _AuthLoading(key: ValueKey('loading')),
        error: (error, stackTrace) => _AuthError(
          key: const ValueKey('error'),
          message: error is AppException
              ? error.userMessage
              : 'Oturum durumu okunamadı.',
          onRetry: () => ref.invalidate(authStateProvider),
        ),
        data: (session) => session == null
            ? const SignInScreen(key: ValueKey('signIn'))
            : KeyedSubtree(key: const ValueKey('app'), child: child),
      ),
    );
  }
}

class _AuthLoading extends StatelessWidget {
  const _AuthLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

class _AuthError extends StatelessWidget {
  const _AuthError({required this.message, required this.onRetry, super.key});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final spacing = context.spacing;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(spacing.containerMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_off,
                size: DesignTokens.iconExtraLarge,
                color: theme.colorScheme.outlineVariant,
              ),
              SizedBox(height: spacing.gutter),
              Text(
                'Bağlanılamadı',
                style: theme.textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: spacing.small),
              Text(
                message,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: spacing.sectionGap),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Tekrar dene'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
