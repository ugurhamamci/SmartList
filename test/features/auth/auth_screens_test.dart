import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartlist/core/theme/app_theme.dart';
import 'package:smartlist/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:smartlist/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:smartlist/features/auth/presentation/widgets/auth_form_fields.dart';
import 'package:smartlist/features/auth/presentation/widgets/social_sign_in_buttons.dart';

/// Ekranı gerçek tema ve Riverpod kapsamıyla sarar.
///
/// Supabase istemcisi kurulmuyor: bu testler yalnızca form doğrulamasını ve
/// çizimi sınıyor, gönderme yolunu değil. Gönderme yolu ağ ve gerçek bir
/// Supabase projesi gerektiriyor.
Widget _host(Widget child) {
  return ProviderScope(
    child: MaterialApp(theme: AppTheme.light(), home: child),
  );
}

void main() {
  group('AuthValidators', () {
    test('e-posta biçimi', () {
      expect(AuthValidators.email(''), isNotNull);
      expect(AuthValidators.email('ugur'), isNotNull);
      expect(AuthValidators.email('ugur@'), isNotNull);
      expect(AuthValidators.email('ugur@eposta'), isNotNull);
      expect(AuthValidators.email('ugur@eposta.com'), isNull);
      // Baştaki ve sondaki boşluk kabul edilir, kırpılıyor.
      expect(AuthValidators.email('  ugur@eposta.com '), isNull);
    });

    test('şifre kuralı sunucudaki kuralla aynı', () {
      expect(AuthValidators.password(''), 'Şifre gerekli');
      expect(AuthValidators.password('Kisa1'), contains('8 karakter'));
      expect(AuthValidators.password('hepsikucuk1'), contains('büyük harf'));
      expect(AuthValidators.password('HEPSIBUYUK1'), contains('küçük harf'));
      expect(AuthValidators.password('SifreSifre'), contains('rakam'));
      expect(AuthValidators.password('Sifre1234'), isNull);
    });

    test('girişte şifre kuralı uygulanmaz, yalnızca boş olamaz', () {
      // Eski hesabın şifresi zayıf olabilir; "şifreniz zayıf" diyip girişi
      // engellemek yanlış olur.
      expect(AuthValidators.passwordNotEmpty(''), isNotNull);
      expect(AuthValidators.passwordNotEmpty('abc'), isNull);
    });

    test('ad en az iki karakter', () {
      expect(AuthValidators.displayName(''), isNotNull);
      expect(AuthValidators.displayName('U'), isNotNull);
      expect(AuthValidators.displayName('Uğur'), isNull);
    });
  });

  group('SignInScreen', () {
    testWidgets('alanları ve bağlantıları çizer', (tester) async {
      await tester.pumpWidget(_host(const SignInScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Tekrar hoş geldiniz'), findsOneWidget);
      expect(find.text('E-posta'), findsOneWidget);
      expect(find.text('Şifre'), findsOneWidget);
      expect(find.text('Şifremi unuttum'), findsOneWidget);
      expect(find.widgetWithText(FilledButton, 'Giriş yap'), findsOneWidget);
      expect(find.text('Kayıt olun'), findsOneWidget);
    });

    testWidgets('Google düğmesi gösterilir', (tester) async {
      await tester.pumpWidget(_host(const SignInScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Google ile devam et'), findsOneWidget);
      expect(find.text('veya'), findsOneWidget);
    });

    testWidgets('Apple düğmesi yalnızca Apple platformlarında görünür', (
      tester,
    ) async {
      await tester.pumpWidget(_host(const SignInScreen()));
      await tester.pumpAndSettle();

      // Testler masaüstünde koşuyor, yani Apple düğmesi gizli olmalı.
      // Apple'ın kuralı düğmenin kendi platformlarında görünmesini bekliyor.
      expect(SocialSignInButtons.showApple, isFalse);
      expect(find.text('Apple ile devam et'), findsNothing);
    });

    testWidgets('boş formda doğrulama hatası gösterir ve ağa gitmez', (
      tester,
    ) async {
      await tester.pumpWidget(_host(const SignInScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilledButton, 'Giriş yap'));
      await tester.pumpAndSettle();

      expect(find.text('E-posta adresi gerekli'), findsOneWidget);
      expect(find.text('Şifre gerekli'), findsOneWidget);
    });

    testWidgets('geçersiz e-posta yakalanır', (tester) async {
      await tester.pumpWidget(_host(const SignInScreen()));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).first, 'ugur');
      await tester.tap(find.widgetWithText(FilledButton, 'Giriş yap'));
      await tester.pumpAndSettle();

      expect(find.text('Geçerli bir e-posta adresi girin'), findsOneWidget);
    });

    testWidgets('şifre görünürlük düğmesi çalışır', (tester) async {
      await tester.pumpWidget(_host(const SignInScreen()));
      await tester.pumpAndSettle();

      expect(find.byTooltip('Şifreyi göster'), findsOneWidget);
      await tester.tap(find.byTooltip('Şifreyi göster'));
      await tester.pumpAndSettle();
      expect(find.byTooltip('Şifreyi gizle'), findsOneWidget);
    });

    testWidgets('kayıt ekranına geçilir', (tester) async {
      await tester.pumpWidget(_host(const SignInScreen()));
      await tester.pumpAndSettle();

      // Sosyal giriş düğmeleri eklendikten sonra bu bağlantı görünür alanın
      // altına indi; dokunmadan önce kaydırmak gerekiyor.
      await tester.ensureVisible(find.text('Kayıt olun'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Kayıt olun'));
      await tester.pumpAndSettle();

      expect(find.text('Hesap oluştur'), findsWidgets);
      expect(find.text('Adınız'), findsOneWidget);
    });

    testWidgets('şifre sıfırlama sayfası açılır', (tester) async {
      await tester.pumpWidget(_host(const SignInScreen()));
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Şifremi unuttum'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Şifremi unuttum'));
      await tester.pumpAndSettle();

      expect(find.text('Şifre sıfırlama'), findsOneWidget);
      expect(
        find.widgetWithText(FilledButton, 'Bağlantı gönder'),
        findsOneWidget,
      );
    });
  });

  group('SignUpScreen', () {
    testWidgets('boş formda tüm alanlar için hata gösterir', (tester) async {
      await tester.pumpWidget(_host(const SignUpScreen()));
      await tester.pumpAndSettle();

      // Kayıt formu test görüntü alanından uzun; düğmeye dokunmadan önce
      // görünür alana kaydırmak gerekiyor.
      await tester.ensureVisible(
        find.widgetWithText(FilledButton, 'Hesap oluştur'),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Hesap oluştur'));
      await tester.pumpAndSettle();

      expect(find.text('Adınızı yazın'), findsOneWidget);
      expect(find.text('E-posta adresi gerekli'), findsOneWidget);
      expect(find.text('Şifre gerekli'), findsOneWidget);
      expect(find.text('Şifreyi tekrar yazın'), findsOneWidget);
    });

    testWidgets('şifreler uyuşmazsa uyarır', (tester) async {
      await tester.pumpWidget(_host(const SignUpScreen()));
      await tester.pumpAndSettle();

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), 'Uğur');
      await tester.enterText(fields.at(1), 'ugur@eposta.com');
      await tester.enterText(fields.at(2), 'Sifre1234');
      await tester.enterText(fields.at(3), 'Sifre9999');

      // Kayıt formu test görüntü alanından uzun; düğmeye dokunmadan önce
      // görünür alana kaydırmak gerekiyor.
      await tester.ensureVisible(
        find.widgetWithText(FilledButton, 'Hesap oluştur'),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Hesap oluştur'));
      await tester.pumpAndSettle();

      expect(find.text('Şifreler aynı değil'), findsOneWidget);
    });

    testWidgets('koşullar kabul edilmeden kayıt olunamaz', (tester) async {
      await tester.pumpWidget(_host(const SignUpScreen()));
      await tester.pumpAndSettle();

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), 'Uğur');
      await tester.enterText(fields.at(1), 'ugur@eposta.com');
      await tester.enterText(fields.at(2), 'Sifre1234');
      await tester.enterText(fields.at(3), 'Sifre1234');

      // Kayıt formu test görüntü alanından uzun; düğmeye dokunmadan önce
      // görünür alana kaydırmak gerekiyor.
      await tester.ensureVisible(
        find.widgetWithText(FilledButton, 'Hesap oluştur'),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Hesap oluştur'));
      await tester.pumpAndSettle();

      expect(
        find.text('Devam etmek için koşulları kabul etmelisiniz.'),
        findsOneWidget,
      );
    });
  });
}
