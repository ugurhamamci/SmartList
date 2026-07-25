import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:smartlist/core/theme/design_tokens.dart';
import 'package:smartlist/core/theme/spacing_theme.dart';
import 'package:smartlist/core/widgets/avatar_stack.dart';
import 'package:smartlist/features/auth/auth_providers.dart';
import 'package:smartlist/features/profile/presentation/screens/profile_view.dart';
import 'package:smartlist/features/settings/presentation/screens/settings_screen.dart';
import 'package:smartlist/features/shared/presentation/widgets/app_bottom_nav.dart';
import 'package:smartlist/features/statistics/presentation/screens/statistics_screen.dart';
import 'package:smartlist/features/subscription/presentation/widgets/premium_sheet.dart';

/// Giriş yapıldıktan sonraki uygulama kabuğu.
///
/// Sekmeleri, alt navigasyonu ve profil altındaki ekranları barındırıyor.
/// Liste ve ürün sekmeleri şu anda **veri katmanını bekliyor**: depo
/// (repository) katmanı bağlanana kadar boş durum gösteriyorlar, uydurma veri
/// göstermiyorlar — çalışıyormuş gibi görünen bir ekran, çalışmadığını
/// söyleyen bir ekrandan daha kötü.
///
/// Profil, Ayarlar, İstatistikler ve Premium sekmeleri veritabanı gerektirmediği
/// için şimdiden tam çalışıyor.
class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  AppTab _tab = AppTab.home;
  AppSettings _settings = const AppSettings();

  void _snack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _confirmSignOut() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Çıkış yapılsın mı?'),
        content: const Text(
          'Listeleriniz hesabınızda kalır, tekrar giriş yaptığınızda '
          'kaldığınız yerden devam edersiniz.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Vazgeç'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Çıkış yap'),
          ),
        ],
      ),
    );

    if (!(confirmed ?? false)) {
      return;
    }
    // Oturum kapandığında AuthGate giriş ekranını gösteriyor; burada
    // yönlendirme yapmıyoruz.
    await ref.read(authServiceProvider).signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: DesignTokens.durationMedium,
        child: KeyedSubtree(
          key: ValueKey(_tab),
          child: switch (_tab) {
            AppTab.home ||
            AppTab.lists ||
            AppTab.activity ||
            AppTab.shared => const _AwaitingDataLayer(),
            AppTab.profile => _profile(),
          },
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        current: _tab,
        onSelect: (tab) => setState(() => _tab = tab),
      ),
    );
  }

  Widget _profile() {
    final user = ref.watch(authStateProvider).value?.user;
    final email = user?.email ?? '';
    // Ad kayıt sırasında `display_name` olarak yazılıyor; yoksa e-postanın
    // kullanıcı adı kısmına düşüyoruz.
    final name = (user?.userMetadata?['display_name'] as String?)?.trim();
    final displayName = (name == null || name.isEmpty)
        ? (email.isEmpty ? 'SmartList kullanıcısı' : email.split('@').first)
        : name;

    return ProfileView(
      user: AvatarData(
        initials: _initialsOf(displayName),
        label: displayName,
      ),
      name: displayName,
      email: email,
      isPremium: false,
      versionLabel: 'SmartList 1.0.0',
      stats: const [
        ProfileStat(
          value: '—',
          label: 'Liste',
          icon: Icons.format_list_bulleted,
          color: DesignTokens.primary,
        ),
        ProfileStat(
          value: '—',
          label: 'Alınan ürün',
          icon: Icons.check_circle_outline,
          color: DesignTokens.secondary,
        ),
        ProfileStat(
          value: '—',
          label: 'Paylaşılan kişi',
          icon: Icons.group_outlined,
          color: DesignTokens.tertiary,
        ),
      ],
      onEditProfile: () => _snack('Profil düzenleme veri katmanıyla gelecek'),
      onOpenStatistics: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => StatisticsScreen(
            totalItems: 0,
            completedItems: 0,
            activeLists: 0,
            totalSpend: 0,
            currency: _settings.currency,
            weeklySpend: const [],
            categories: const [],
          ),
        ),
      ),
      onOpenSettings: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => SettingsScreen(
            settings: _settings,
            onChanged: (value) => setState(() => _settings = value),
            versionLabel: 'SmartList 1.0.0',
          ),
        ),
      ),
      onOpenPremium: () => PremiumSheet.show(context),
      onSignOut: _confirmSignOut,
    );
  }

  /// Adın baş harfleri. Tek kelimelik adda ilk iki harf alınıyor, böylece
  /// avatar hiç boş kalmıyor.
  String _initialsOf(String name) {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();
    if (parts.isEmpty) {
      return 'SL';
    }
    if (parts.length == 1) {
      final word = parts.first;
      return (word.length == 1 ? word : word.substring(0, 2)).toUpperCase();
    }
    return (parts.first[0] + parts[1][0]).toUpperCase();
  }
}

/// Veri katmanı bağlanana kadar liste sekmelerinde gösterilen durum.
///
/// Uydurma veri göstermek yerine ne olduğunu açıkça söylüyor; kullanıcı
/// listesinin kaybolduğunu sanmıyor.
class _AwaitingDataLayer extends StatelessWidget {
  const _AwaitingDataLayer();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final spacing = context.spacing;

    return SafeArea(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(spacing.containerMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_sync_outlined,
                size: DesignTokens.iconExtraLarge,
                color: scheme.outlineVariant,
              ),
              SizedBox(height: spacing.gutter),
              Text(
                'Listeler hazırlanıyor',
                style: theme.textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: spacing.small),
              Text(
                'Veritabanı şeması uygulandıktan sonra listeleriniz burada '
                'görünecek. Tasarımı ve tüm etkileşimleri şimdi denemek için '
                'önizleme girişini kullanabilirsiniz:\n'
                'flutter run -t lib/main_preview.dart',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
