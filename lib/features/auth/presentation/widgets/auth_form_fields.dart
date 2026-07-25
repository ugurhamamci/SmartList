import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:smartlist/core/theme/design_tokens.dart';

/// Kimlik doğrulama ekranlarının paylaştığı doğrulama kuralları.
///
/// Kurallar tek yerde: giriş ve kayıt ekranları aynı e-posta biçimini kabul
/// etsin, şifre kuralı iki yerde farklı yazılmasın.
abstract final class AuthValidators {
  /// Kabaca "bir şey@bir şey.bir şey". Daha katı bir desen yazmak yanlış
  /// pozitif üretiyor (geçerli adresleri reddediyor); adresin gerçekten
  /// çalıştığını yalnızca doğrulama e-postası kanıtlıyor.
  static final RegExp _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static String? email(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'E-posta adresi gerekli';
    }
    if (!_email.hasMatch(text)) {
      return 'Geçerli bir e-posta adresi girin';
    }
    return null;
  }

  /// Sunucu tarafındaki kuralın aynısı (`config.toml` →
  /// `minimum_password_length = 8`, `lower_upper_letters_digits`). Aynısını
  /// istemcide de uygulamak, kullanıcının sunucudan hata almadan önce
  /// düzeltmesini sağlıyor.
  static String? password(String? value) {
    final text = value ?? '';
    if (text.isEmpty) {
      return 'Şifre gerekli';
    }
    if (text.length < 8) {
      return 'Şifre en az 8 karakter olmalı';
    }
    if (!text.contains(RegExp('[a-zçğıöşü]'))) {
      return 'Şifre en az bir küçük harf içermeli';
    }
    if (!text.contains(RegExp('[A-ZÇĞİÖŞÜ]'))) {
      return 'Şifre en az bir büyük harf içermeli';
    }
    if (!text.contains(RegExp('[0-9]'))) {
      return 'Şifre en az bir rakam içermeli';
    }
    return null;
  }

  /// Girişte şifre kuralı uygulanmıyor: mevcut hesabın şifresi eski kurallarla
  /// oluşturulmuş olabilir, "şifreniz zayıf" diyip girişi engellemek yanlış.
  static String? passwordNotEmpty(String? value) {
    return (value ?? '').isEmpty ? 'Şifre gerekli' : null;
  }

  static String? displayName(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Adınızı yazın';
    }
    if (text.length < 2) {
      return 'Ad en az 2 karakter olmalı';
    }
    return null;
  }
}

/// Kimlik ekranlarının standart metin alanı.
class AuthTextField extends StatelessWidget {
  const AuthTextField({
    required this.controller,
    required this.label,
    required this.icon,
    this.hint,
    this.validator,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.autofillHints,
    this.obscure = false,
    this.suffix,
    this.enabled = true,
    this.onSubmitted,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? hint;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final Iterable<String>? autofillHints;
  final bool obscure;
  final Widget? suffix;
  final bool enabled;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autofillHints: autofillHints,
      obscureText: obscure,
      enabled: enabled,
      onFieldSubmitted: onSubmitted,
      // E-posta alanında otomatik büyük harf kapalı olmalı; klavye ilk harfi
      // büyütürse adres yanlış giriliyor.
      textCapitalization: keyboardType == TextInputType.emailAddress
          ? TextCapitalization.none
          : TextCapitalization.words,
      inputFormatters: keyboardType == TextInputType.emailAddress
          ? [FilteringTextInputFormatter.deny(RegExp(r'\s'))]
          : null,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        suffixIcon: suffix,
      ),
    );
  }
}

/// Şifre alanı: görünürlük düğmesini kendi içinde yönetir.
class AuthPasswordField extends StatefulWidget {
  const AuthPasswordField({
    required this.controller,
    this.label = 'Şifre',
    this.validator,
    this.textInputAction = TextInputAction.next,
    this.autofillHints = const [AutofillHints.password],
    this.enabled = true,
    this.onSubmitted,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final Iterable<String>? autofillHints;
  final bool enabled;
  final ValueChanged<String>? onSubmitted;

  @override
  State<AuthPasswordField> createState() => _AuthPasswordFieldState();
}

class _AuthPasswordFieldState extends State<AuthPasswordField> {
  bool _hidden = true;

  @override
  Widget build(BuildContext context) {
    return AuthTextField(
      controller: widget.controller,
      label: widget.label,
      icon: Icons.lock_outline,
      obscure: _hidden,
      validator: widget.validator,
      textInputAction: widget.textInputAction,
      autofillHints: widget.autofillHints,
      enabled: widget.enabled,
      onSubmitted: widget.onSubmitted,
      suffix: IconButton(
        onPressed: () => setState(() => _hidden = !_hidden),
        icon: Icon(_hidden ? Icons.visibility_off : Icons.visibility),
        tooltip: _hidden ? 'Şifreyi göster' : 'Şifreyi gizle',
      ),
    );
  }
}

/// Hata kutusu. Sunucudan gelen mesajı formun üstünde gösterir.
class AuthErrorBanner extends StatelessWidget {
  const AuthErrorBanner({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(DesignTokens.space3),
      decoration: BoxDecoration(
        color: scheme.errorContainer,
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.error_outline,
            color: scheme.onErrorContainer,
            size: DesignTokens.iconSmall,
          ),
          const SizedBox(width: DesignTokens.space2),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodySmall?.copyWith(
                color: scheme.onErrorContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Kimlik ekranlarının birincil düğmesi; yüklenirken kendini kilitler.
class AuthPrimaryButton extends StatelessWidget {
  const AuthPrimaryButton({
    required this.label,
    required this.onPressed,
    this.busy = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: DesignTokens.primaryButtonHeight,
      child: FilledButton(
        // Yüklenirken devre dışı: çift dokunma iki kayıt isteği göndermesin.
        onPressed: busy ? null : onPressed,
        child: busy
            ? const SizedBox(
                width: DesignTokens.iconSmall,
                height: DesignTokens.iconSmall,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(label),
      ),
    );
  }
}
