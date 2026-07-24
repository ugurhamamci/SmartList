import 'package:flutter/material.dart';

import 'package:smartlist/core/theme/design_tokens.dart';
import 'package:smartlist/core/widgets/press_scale.dart';

/// Alt navigasyon sekmeleri.
enum AppTab {
  home('Home', Icons.home_outlined, Icons.home),
  lists('Lists', Icons.format_list_bulleted, Icons.format_list_bulleted),
  activity('Activity', Icons.notifications_none, Icons.notifications),
  shared('Shared', Icons.group_outlined, Icons.group),
  profile('Profile', Icons.person_outline, Icons.person);

  const AppTab(this.label, this.icon, this.selectedIcon);

  final String label;
  final IconData icon;

  /// Tasarım seçili sekmede `FILL 1` kullanıyor; karşılığı dolu ikondur.
  final IconData selectedIcon;
}

/// Uygulamanın alt navigasyon çubuğu.
///
/// Material'ın [NavigationBar] widget'ı yerine elle yazıldı: tasarımda seçili
/// sekme, ikon ve etiketi birlikte saran hap biçiminde bir kapsayıcı içinde
/// duruyor; [NavigationBar] ise göstergeyi yalnızca ikonun arkasına koyar.
///
/// Çubuk üst köşeleri 32px yuvarlatılmış, `nav-shadow` taşıyor ve alt güvenli
/// alan kadar ek dolgu alıyor.
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    required this.current,
    required this.onSelect,
    super.key,
  });

  final AppTab current;
  final ValueChanged<AppTab> onSelect;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(DesignTokens.radius3xl),
        ),
        boxShadow: DesignTokens.navShadow,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: DesignTokens.space4,
          right: DesignTokens.space4,
          top: DesignTokens.space2,
          // Tasarımdaki `pb-6`; cihazın güvenli alanı varsa onun kadar.
          bottom: bottomInset > 0 ? bottomInset : DesignTokens.space6,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (final tab in AppTab.values)
              _NavItem(
                tab: tab,
                selected: tab == current,
                onTap: () => onSelect(tab),
              ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.tab,
    required this.selected,
    required this.onTap,
  });

  final AppTab tab;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final content = AnimatedContainer(
      duration: DesignTokens.durationFast,
      curve: DesignTokens.curveStandard,
      padding: selected
          ? const EdgeInsets.symmetric(
              horizontal: DesignTokens.space4,
              vertical: DesignTokens.space1,
            )
          : const EdgeInsets.all(DesignTokens.space2),
      decoration: BoxDecoration(
        color: selected ? scheme.primaryContainer : Colors.transparent,
        borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            selected ? tab.selectedIcon : tab.icon,
            size: DesignTokens.iconMedium,
            color: selected
                ? scheme.onPrimaryContainer
                : scheme.onSurfaceVariant,
          ),
          Text(
            tab.label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: selected
                  ? scheme.onPrimaryContainer
                  : scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );

    return Semantics(
      selected: selected,
      button: true,
      label: tab.label,
      child: PressScale.strong(
        onTap: onTap,
        enforceMinTouchTarget: false,
        child: content,
      ),
    );
  }
}
