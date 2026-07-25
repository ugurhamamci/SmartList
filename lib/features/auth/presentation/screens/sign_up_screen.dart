import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:smartlist/core/errors/app_exception.dart';
import 'package:smartlist/core/errors/app_exception_messages.dart';
import 'package:smartlist/core/theme/spacing_theme.dart';
import 'package:smartlist/features/auth/auth_providers.dart';
import 'package:smartlist/features/auth/presentation/widgets/auth_form_fields.dart';

/// Kayıt ekranı.
///
/// Profil ve ayar satırlarını istemci yazmıyor: veritabanındaki
/// `handle_new_auth_user` trigger'ı açıyor. Buradan yalnızca ad `data` alanıyla
/// iletiliyor, trigger onu okuyor.
class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _passwordAgain = TextEditingController();

  bool _busy = false;
  bool _acceptedTerms = false;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _passwordAgain.dispose();
    super.dispose();
  }

  String? _validateConfirmation(String? value) {
    if ((value ?? '').isEmpty) {
      return 'Şifreyi tekrar yazın';
    }
    if (value != _password.text) {
      return 'Şifreler aynı değil';
    }
    return null;
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    if (!_acceptedTerms) {
      setState(() => _error = 'Devam etmek için koşulları kabul etmelisiniz.');
      return;
    }

    setState(() {
      _busy = true;
      _error = null;
    });

    try {
      await ref
          .read(authServiceProvider)
          .signUp(
            email: _email.text,
            password: _password.text,
            displayName: _name.text,
          );

      if (!mounted) {
        return;
      }

      // E-posta doğrulaması kapalıysa oturum hemen açılır ve `AuthGate`
      // uygulamayı gösterir; açıksa kullanıcı gelen kutusunu kontrol etmeli.
      // İki durumu ayırt etmek için oturuma bakıyoruz.
      final signedIn = ref.read(authServiceProvider).isSignedIn;
      Navigator.of(context).pop();

      if (!signedIn) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Hesabınız oluşturuldu. E-postanızdaki doğrulama bağlantısına '
              'dokunup giriş yapın.',
            ),
            duration: Duration(seconds: 6),
          ),
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
    final scheme = theme.colorScheme;
    final spacing = context.spacing;

    return Scaffold(
      appBar: AppBar(title: const Text('Hesap oluştur')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spacing.containerMargin),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: AutofillGroup(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Listelerinizi ailenizle paylaşmaya başlayın.',
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
                        controller: _name,
                        label: 'Adınız',
                        hint: 'Listelerde bu adla görünürsünüz',
                        icon: Icons.person_outline,
                        autofillHints: const [AutofillHints.name],
                        validator: AuthValidators.displayName,
                        enabled: !_busy,
                      ),
                      SizedBox(height: spacing.gutter),

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
                        validator: AuthValidators.password,
                        autofillHints: const [AutofillHints.newPassword],
                        enabled: !_busy,
                      ),
                      SizedBox(height: spacing.small),
                      Text(
                        'En az 8 karakter, bir büyük harf, bir küçük harf ve '
                        'bir rakam.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: spacing.gutter),

                      AuthPasswordField(
                        controller: _passwordAgain,
                        label: 'Şifre tekrar',
                        validator: _validateConfirmation,
                        textInputAction: TextInputAction.done,
                        enabled: !_busy,
                        onSubmitted: (_) => _submit(),
                      ),
                      SizedBox(height: spacing.gutter),

                      CheckboxListTile(
                        value: _acceptedTerms,
                        onChanged: _busy
                            ? null
                            : (value) => setState(
                                () => _acceptedTerms = value ?? false,
                              ),
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          'Kullanım koşullarını ve gizlilik politikasını '
                          'kabul ediyorum.',
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                      SizedBox(height: spacing.small),

                      AuthPrimaryButton(
                        label: 'Hesap oluştur',
                        busy: _busy,
                        onPressed: _submit,
                      ),
                      SizedBox(height: spacing.gutter),

                      Center(
                        child: TextButton(
                          onPressed: _busy
                              ? null
                              : () => Navigator.of(context).pop(),
                          child: const Text('Zaten hesabım var'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
