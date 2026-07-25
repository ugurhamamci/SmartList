import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:smartlist/core/errors/app_exception.dart';
import 'package:smartlist/core/errors/app_exception_messages.dart';
import 'package:smartlist/core/theme/design_tokens.dart';
import 'package:smartlist/core/theme/spacing_theme.dart';
import 'package:smartlist/features/auth/auth_providers.dart';
import 'package:smartlist/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:smartlist/features/auth/presentation/widgets/auth_form_fields.dart';
import 'package:smartlist/features/auth/presentation/widgets/social_sign_in_buttons.dart';

/// Giriş ekranı.
///
/// Oturum açıldığında bu ekran kendini kapatmıyor: `AuthGate` oturumu izliyor
/// ve uygulamayı gösteriyor. Ekranın tek işi kimlik bilgisini toplamak.
class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  bool _busy = false;
  String? _error;

  /// Hangi sağlayıcı için bekleniyor; e-posta girişinde null kalır.
  String? _busyProvider;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _busy = true;
      _error = null;
    });

    try {
      await ref
          .read(authServiceProvider)
          .signIn(email: _email.text, password: _password.text);
      // Başarılıysa bir şey yapmıyoruz: oturum akışı değişince AuthGate
      // uygulamayı gösteriyor.
    } on AppException catch (error) {
      if (mounted) {
        setState(() => _error = error.userMessage);
      }
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  /// Google veya Apple ile giriş.
  ///
  /// Tarayıcı açıldıktan sonra oturum `AuthGate` üzerinden geliyor; bu yüzden
  /// başarı durumunda ekranda bir şey yapmıyoruz. Kullanıcı tarayıcıyı
  /// kapatırsa da hata gelmiyor, sadece bekleme durumu kalkıyor.
  Future<void> _socialSignIn(String provider) async {
    setState(() {
      _busyProvider = provider;
      _error = null;
    });

    try {
      final service = ref.read(authServiceProvider);
      if (provider == 'google') {
        await service.signInWithGoogle();
      } else {
        await service.signInWithApple();
      }
    } on AppException catch (error) {
      if (mounted) {
        setState(() => _error = error.userMessage);
      }
    } finally {
      if (mounted) {
        setState(() => _busyProvider = null);
      }
    }
  }

  Future<void> _forgotPassword() async {
    // Adres zaten yazılmışsa formu tekrar doldurtmuyoruz.
    final result = await PasswordResetSheet.show(context, email: _email.text);
    if (result != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final spacing = context.spacing;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(spacing.containerMargin),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: AutofillGroup(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: spacing.sectionGap),

                      Image.asset(
                        'assets/images/smartlist_brand.png',
                        height: 64,
                        // Görsel yüklenemezse ekran boş kalmasın.
                        errorBuilder: (context, error, stack) => Text(
                          'SmartList',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.displaySmall,
                        ),
                      ),
                      SizedBox(height: spacing.gutter),

                      Text(
                        'Tekrar hoş geldiniz',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineMedium,
                      ),
                      SizedBox(height: spacing.small),
                      Text(
                        'Listelerinize erişmek için giriş yapın.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: spacing.sectionGap),

                      if (_error != null) ...[
                        AuthErrorBanner(message: _error!),
                        SizedBox(height: spacing.gutter),
                      ],

                      AuthTextField(
                        controller: _email,
                        label: 'E-posta',
                        hint: 'ornek@eposta.com',
                        icon: Icons.mail_outline,
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: const [AutofillHints.email],
                        validator: AuthValidators.email,
                        enabled: !_busy,
                      ),
                      SizedBox(height: spacing.gutter),

                      AuthPasswordField(
                        controller: _password,
                        validator: AuthValidators.passwordNotEmpty,
                        textInputAction: TextInputAction.done,
                        enabled: !_busy,
                        onSubmitted: (_) => _submit(),
                      ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: _busy ? null : _forgotPassword,
                          child: const Text('Şifremi unuttum'),
                        ),
                      ),
                      SizedBox(height: spacing.small),

                      AuthPrimaryButton(
                        label: 'Giriş yap',
                        busy: _busy,
                        onPressed: _submit,
                      ),
                      SizedBox(height: spacing.sectionGap),

                      SocialSignInButtons(
                        onGoogle: () => _socialSignIn('google'),
                        onApple: () => _socialSignIn('apple'),
                        busyProvider: _busyProvider,
                        enabled: !_busy && _busyProvider == null,
                      ),
                      SizedBox(height: spacing.gutter),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Hesabınız yok mu?',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                          TextButton(
                            onPressed: _busy
                                ? null
                                : () => Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                      builder: (_) => const SignUpScreen(),
                                    ),
                                  ),
                            child: const Text('Kayıt olun'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ).animate().fadeIn(duration: DesignTokens.durationSlow),
      ),
    );
  }
}

/// Şifre sıfırlama sayfası.
///
/// Sonuç olarak kullanıcıya gösterilecek mesajı döndürür; `null` iptal demek.
class PasswordResetSheet extends ConsumerStatefulWidget {
  const PasswordResetSheet({this.initialEmail = '', super.key});

  final String initialEmail;

  static Future<String?> show(BuildContext context, {String email = ''}) {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => PasswordResetSheet(initialEmail: email),
    );
  }

  @override
  ConsumerState<PasswordResetSheet> createState() => _PasswordResetSheetState();
}

class _PasswordResetSheetState extends ConsumerState<PasswordResetSheet> {
  final _formKey = GlobalKey<FormState>();
  late final _email = TextEditingController(text: widget.initialEmail);

  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _busy = true;
      _error = null;
    });

    try {
      await ref.read(authServiceProvider).sendPasswordReset(_email.text);
      if (mounted) {
        Navigator.of(context).pop(
          'Sıfırlama bağlantısı ${_email.text.trim()} adresine gönderildi.',
        );
      }
    } on AppException catch (error) {
      if (mounted) {
        setState(() {
          _error = error.userMessage;
          _busy = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final spacing = context.spacing;

    return Padding(
      padding: EdgeInsets.only(
        left: spacing.containerMargin,
        right: spacing.containerMargin,
        top: spacing.containerMargin,
        // Klavye açıldığında alan görünür kalsın.
        bottom:
            spacing.containerMargin + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Şifre sıfırlama', style: theme.textTheme.headlineSmall),
            SizedBox(height: spacing.small),
            Text(
              'E-posta adresinizi girin, sıfırlama bağlantısı gönderelim.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: spacing.gutter),

            if (_error != null) ...[
              AuthErrorBanner(message: _error!),
              SizedBox(height: spacing.gutter),
            ],

            AuthTextField(
              controller: _email,
              label: 'E-posta',
              icon: Icons.mail_outline,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              validator: AuthValidators.email,
              enabled: !_busy,
              onSubmitted: (_) => _submit(),
            ),
            SizedBox(height: spacing.gutter),

            AuthPrimaryButton(
              label: 'Bağlantı gönder',
              busy: _busy,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
