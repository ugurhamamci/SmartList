import 'package:flutter/material.dart';

import 'package:smartlist/core/theme/app_theme.dart';
import 'package:smartlist/core/theme/design_tokens.dart';
import 'package:smartlist/core/widgets/avatar_stack.dart';
import 'package:smartlist/features/home/presentation/screens/dashboard_view.dart';
import 'package:smartlist/features/shared/presentation/widgets/app_bottom_nav.dart';

/// Tasarım önizlemesi — Firebase'e ihtiyaç duymaz.
///
/// Amaç, ekranları gerçek tema ve gerçek widget'larla ama örnek veriyle
/// göstermek. Android SDK, emülatör veya Firebase projesi olmadan tarayıcıda
/// çalışır:
///
/// ```sh
/// flutter run -d chrome -t lib/main_preview.dart
/// ```
///
/// Sunucuda tarayıcı açılmıyorsa adresi kendiniz açmak için:
///
/// ```sh
/// flutter run -d web-server --web-port 8080 -t lib/main_preview.dart
/// ```
///
/// Bu dosya yalnızca geliştirme aracıdır; uygulamanın giriş noktaları
/// `main.dart` ve `main_<flavor>.dart` dosyalarıdır. Örnek veri de burada
/// durur, üretim kodunda yer almaz.
void main() => runApp(const PreviewApp());

class PreviewApp extends StatelessWidget {
  const PreviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartList — Tasarım Önizlemesi',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      home: const PreviewShell(),
    );
  }
}

/// Önizleme kabuğu: telefon genişliğinde bir çerçeve ve alt navigasyon.
///
/// Tasarım mobil için yapıldığı için geniş bir tarayıcı penceresinde içerik
/// 420px'e sabitlenir; böylece tarayıcıda telefon oranıyla görülür.
class PreviewShell extends StatefulWidget {
  const PreviewShell({super.key});

  @override
  State<PreviewShell> createState() => _PreviewShellState();
}

class _PreviewShellState extends State<PreviewShell> {
  AppTab _tab = AppTab.home;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return ColoredBox(
      color: scheme.surfaceDim,
      child: Center(
        child: ConstrainedBox(
          // Tasarımın referans genişliği; mobilde tam ekran olur.
          constraints: const BoxConstraints(maxWidth: 420),
          child: ClipRect(
            child: Scaffold(
              body: switch (_tab) {
                AppTab.home => _demoDashboard(),
                _ => _PlaceholderTab(tab: _tab),
              },
              floatingActionButton: _tab == AppTab.home
                  ? FloatingActionButton(
                      onPressed: () {},
                      child: const Icon(
                        Icons.add,
                        size: DesignTokens.iconLarge,
                      ),
                    )
                  : null,
              bottomNavigationBar: AppBottomNav(
                current: _tab,
                onSelect: (tab) => setState(() => _tab = tab),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _demoDashboard() {
    return const DashboardView(
      userName: 'Uğur',
      userAvatar: AvatarData(initials: 'UH', label: 'Uğur Hamamcı'),
      lists: [
        DashboardListItem(
          id: '1',
          title: 'Haftalık Market',
          subtitle: '12 Ürün • Son güncelleme 1 saat önce',
          progress: 0.65,
          members: [
            AvatarData(initials: 'AY', label: 'Ayşe'),
            AvatarData(initials: 'ME', label: 'Mehmet'),
            AvatarData(initials: 'CA', label: 'Can'),
            AvatarData(initials: 'EM', label: 'Emre'),
          ],
        ),
        DashboardListItem(
          id: '2',
          title: 'Piknik Hazırlığı 🧺',
          subtitle: '8 Ürün • Dün güncellendi',
          progress: 1,
          members: [AvatarData(initials: 'ZE', label: 'Zeynep')],
        ),
      ],
      suggestion: DashboardSuggestion(
        title: 'Akşam Yemeği: Lazanya',
        subtitle: '5 eksik ürün • Tarif bazlı liste',
        actionLabel: 'Tümünü listeye ekle →',
      ),
    );
  }
}

/// Henüz yazılmamış sekmeler için bilgilendirme.
class _PlaceholderTab extends StatelessWidget {
  const _PlaceholderTab({required this.tab});

  final AppTab tab;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(DesignTokens.containerMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              tab.icon,
              size: DesignTokens.space10,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: DesignTokens.space4),
            Text(tab.label, style: theme.textTheme.headlineSmall),
            const SizedBox(height: DesignTokens.space2),
            Text(
              'Bu ekran henüz yazılmadı.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
