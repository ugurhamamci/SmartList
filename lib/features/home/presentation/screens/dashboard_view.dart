import 'package:flutter/material.dart';

import 'package:smartlist/core/theme/design_tokens.dart';
import 'package:smartlist/core/theme/spacing_theme.dart';
import 'package:smartlist/core/widgets/avatar_stack.dart';
import 'package:smartlist/core/widgets/press_scale.dart';
import 'package:smartlist/features/home/presentation/widgets/list_summary_card.dart';
import 'package:smartlist/features/home/presentation/widgets/quick_action_tile.dart';

/// Ana ekranda gösterilecek tek liste satırı.
///
/// Ekran doğrudan `ShoppingList` modelini almaz: sunum katmanı, biçimlenmiş
/// alt satır metnini ve avatar verisini hazır ister. Böylece ekran hem
/// Firestore'dan gelen veriyle hem de tarayıcı önizlemesindeki örnek veriyle
/// aynı şekilde çalışır.
class DashboardListItem {
  const DashboardListItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.progress,
    this.members = const [],
  });

  final String id;
  final String title;
  final String subtitle;
  final double progress;
  final List<AvatarData> members;
}

/// AI önerisi kartının verisi.
class DashboardSuggestion {
  const DashboardSuggestion({
    required this.title,
    required this.subtitle,
    required this.actionLabel,
  });

  final String title;
  final String subtitle;
  final String actionLabel;
}

/// Ana ekranın sunum katmanı.
///
/// Veri erişimi yok: her şey parametreyle geliyor, her etkileşim geri çağrıyla
/// dışarı veriliyor. Riverpod'a bağlı sarmalayıcı bunu besler.
class DashboardView extends StatelessWidget {
  const DashboardView({
    required this.userName,
    required this.lists,
    this.suggestion,
    this.userAvatar,
    this.onSearchTap,
    this.onProfileTap,
    this.onNewList,
    this.onJoinWithQr,
    this.onGenerateWithAi,
    this.onInvite,
    this.onSeeAllLists,
    this.onListTap,
    this.onSuggestionAccept,
    super.key,
  });

  final String userName;
  final List<DashboardListItem> lists;
  final DashboardSuggestion? suggestion;
  final AvatarData? userAvatar;

  final VoidCallback? onSearchTap;
  final VoidCallback? onProfileTap;
  final VoidCallback? onNewList;
  final VoidCallback? onJoinWithQr;
  final VoidCallback? onGenerateWithAi;
  final VoidCallback? onInvite;
  final VoidCallback? onSeeAllLists;
  final ValueChanged<String>? onListTap;
  final VoidCallback? onSuggestionAccept;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final spacing = context.spacing;

    return CustomScrollView(
      slivers: [
        _DashboardAppBar(userAvatar: userAvatar, onSearchTap: onSearchTap, onProfileTap: onProfileTap),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: spacing.containerMargin),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // --- Selamlama ---
              const SizedBox(height: DesignTokens.space6),
              Text(
                'Merhaba $userName 👋',
                style: theme.textTheme.headlineMedium,
              ),
              const SizedBox(height: DesignTokens.space1),
              Text(
                'Bugünün hedefi?',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: DesignTokens.space6),

              // --- Arama ---
              _SearchField(onTap: onSearchTap),
              SizedBox(height: spacing.sectionGap),

              // --- Hızlı aksiyonlar ---
              GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: spacing.gutter,
                crossAxisSpacing: spacing.gutter,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.35,
                children: [
                  QuickActionTile(
                    icon: Icons.add_circle,
                    label: '+ Yeni Liste',
                    style: QuickActionStyle.filled,
                    onTap: onNewList ?? () {},
                  ),
                  QuickActionTile(
                    icon: Icons.qr_code_scanner,
                    label: 'QR Katıl',
                    onTap: onJoinWithQr ?? () {},
                  ),
                  QuickActionTile(
                    icon: Icons.auto_fix_high,
                    label: 'AI Liste Oluştur',
                    style: QuickActionStyle.accent,
                    onTap: onGenerateWithAi ?? () {},
                  ),
                  QuickActionTile(
                    icon: Icons.person_add,
                    label: 'Davet Et',
                    onTap: onInvite ?? () {},
                  ),
                ],
              ),
              SizedBox(height: spacing.sectionGap),

              // --- Aktif listeler ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Aktif Listeler', style: theme.textTheme.headlineSmall),
                  TextButton(
                    onPressed: onSeeAllLists,
                    child: const Text('Tümünü Gör'),
                  ),
                ],
              ),
              const SizedBox(height: DesignTokens.space2),
            ]),
          ),
        ),

        // Liste kartları, uzun listelerde de akıcı kalması için tembel çizilir.
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: spacing.containerMargin),
          sliver: SliverList.separated(
            itemCount: lists.length,
            separatorBuilder: (_, _) => SizedBox(height: spacing.gutter),
            itemBuilder: (context, index) {
              final item = lists[index];
              return ListSummaryCard(
                title: item.title,
                subtitle: item.subtitle,
                progress: item.progress,
                members: item.members,
                onTap: () => onListTap?.call(item.id),
              );
            },
          ),
        ),

        // --- AI önerisi ---
        if (suggestion != null)
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              spacing.containerMargin,
              spacing.gutter,
              spacing.containerMargin,
              0,
            ),
            sliver: SliverToBoxAdapter(
              child: AiSuggestionCard(
                title: suggestion!.title,
                subtitle: suggestion!.subtitle,
                actionLabel: suggestion!.actionLabel,
                onAction: onSuggestionAccept,
              ),
            ),
          ),

        // FAB ve alt navigasyonun içeriği kapatmaması için bırakılan boşluk.
        const SliverToBoxAdapter(
          child: SizedBox(height: DesignTokens.space10 * 3),
        ),
      ],
    );
  }
}

/// Üst çubuk: logo, uygulama adı, arama ve profil avatarı.
class _DashboardAppBar extends StatelessWidget {
  const _DashboardAppBar({
    this.userAvatar,
    this.onSearchTap,
    this.onProfileTap,
  });

  final AvatarData? userAvatar;
  final VoidCallback? onSearchTap;
  final VoidCallback? onProfileTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final spacing = context.spacing;

    return SliverAppBar(
      pinned: true,
      backgroundColor: scheme.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      // Tasarımda kaydırma başlayınca üst çubukta gölge beliriyor.
      scrolledUnderElevation: 1,
      toolbarHeight: DesignTokens.touchTarget + DesignTokens.space4,
      titleSpacing: spacing.containerMargin,
      title: Row(
        children: [
          // Logo: tasarım uzak bir görsel kullanıyor. Varlık olarak logo
          // verilmediği için marka renginde bir yer tutucu çiziliyor.
          Container(
            width: DesignTokens.avatarMedium,
            height: DesignTokens.avatarMedium,
            decoration: BoxDecoration(
              color: scheme.primaryContainer,
              borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
            ),
            child: Icon(
              Icons.shopping_basket,
              size: DesignTokens.iconSmall + 2,
              color: scheme.onPrimary,
            ),
          ),
          const SizedBox(width: DesignTokens.space3),
          Text(
            'SmartList',
            style: theme.textTheme.displayMedium?.copyWith(
              color: scheme.primary,
            ),
          ),
        ],
      ),
      actions: [
        PressScale(
          onTap: onSearchTap,
          semanticLabel: 'Ara',
          child: Icon(Icons.search, color: scheme.onSurfaceVariant),
        ),
        const SizedBox(width: DesignTokens.space2),
        PressScale(
          onTap: onProfileTap,
          semanticLabel: 'Profil',
          child: MemberAvatar(
            data: userAvatar ?? const AvatarData(initials: '?'),
            size: DesignTokens.avatarMedium,
            borderColor: scheme.primaryContainer,
          ),
        ),
        SizedBox(width: spacing.containerMargin),
      ],
    );
  }
}

/// Arama alanı. Dokunulduğunda arama ekranına gider, yerinde yazı almaz.
class _SearchField extends StatelessWidget {
  const _SearchField({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final spacing = context.spacing;

    return PressScale.subtle(
      onTap: onTap,
      child: Container(
        height: DesignTokens.searchFieldHeight,
        padding: const EdgeInsets.symmetric(horizontal: DesignTokens.space4),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(spacing.radiusCard),
          border: Border.all(color: scheme.outlineVariant),
          boxShadow: DesignTokens.cardShadow,
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: scheme.outline),
            const SizedBox(width: DesignTokens.space3),
            Expanded(
              child: Text(
                'Ürün, liste veya kategori ara...',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: scheme.outline,
                ),
              ),
            ),
            // AI destekli arama göstergesi (`auto_awesome`, %60 opaklık).
            Opacity(
              opacity: 0.6,
              child: Icon(Icons.auto_awesome, color: scheme.primary),
            ),
          ],
        ),
      ),
    );
  }
}
