import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:smartlist/core/theme/design_tokens.dart';
import 'package:smartlist/core/theme/spacing_theme.dart';
import 'package:smartlist/core/widgets/avatar_stack.dart';
import 'package:smartlist/core/widgets/smart_card.dart';

/// Profil ekranındaki tek sayaç.
class ProfileStat {
  const ProfileStat({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  final String value;
  final String label;
  final IconData icon;
  final Color color;
}

/// Profil sekmesi: kullanıcı kartı, sayaçlar ve ayar girişleri.
///
/// Ekran veri tutmaz; sayaçlar ve sürüm bilgisi dışarıdan verilir, her satır
/// bir geri çağrıya bağlıdır. Böylece aynı ekran hem önizlemede hem gerçek
/// oturumla çalışır.
class ProfileView extends StatelessWidget {
  const ProfileView({
    required this.user,
    required this.name,
    required this.email,
    required this.stats,
    required this.isPremium,
    required this.onEditProfile,
    required this.onOpenStatistics,
    required this.onOpenSettings,
    required this.onOpenPremium,
    required this.onSignOut,
    this.versionLabel = '',
    super.key,
  });

  final AvatarData user;
  final String name;
  final String email;
  final List<ProfileStat> stats;
  final bool isPremium;

  final VoidCallback onEditProfile;
  final VoidCallback onOpenStatistics;
  final VoidCallback onOpenSettings;
  final VoidCallback onOpenPremium;
  final VoidCallback onSignOut;

  final String versionLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final spacing = context.spacing;

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: EdgeInsets.fromLTRB(
          spacing.containerMargin,
          DesignTokens.space6,
          spacing.containerMargin,
          DesignTokens.space10 * 3,
        ),
        children: [
          Text('Profil', style: theme.textTheme.headlineMedium),
          SizedBox(height: spacing.gutter),

          // --- Kullanıcı kartı ---
          SmartCard(
                onTap: onEditProfile,
                child: Row(
                  children: [
                    MemberAvatar(
                      data: user,
                      size: DesignTokens.avatarExtraLarge,
                    ),
                    SizedBox(width: spacing.gutter),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name, style: theme.textTheme.headlineSmall),
                          SizedBox(height: spacing.small),
                          Text(
                            email,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                          SizedBox(height: spacing.small),
                          // Ücretsiz / Premium durumu tek bakışta görünür.
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: DesignTokens.space3,
                              vertical: DesignTokens.space1,
                            ),
                            decoration: BoxDecoration(
                              color: isPremium
                                  ? scheme.tertiaryContainer
                                  : scheme.surfaceContainer,
                              borderRadius: BorderRadius.circular(
                                DesignTokens.radiusFull,
                              ),
                            ),
                            child: Text(
                              isPremium ? 'Premium üye' : 'Ücretsiz plan',
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: isPremium
                                    ? scheme.onTertiaryContainer
                                    : scheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.edit_outlined, color: scheme.onSurfaceVariant),
                  ],
                ),
              )
              .animate()
              .fadeIn(duration: DesignTokens.durationMedium)
              .slideY(
                begin: 0.08,
                curve: DesignTokens.curveStandard,
              ),

          SizedBox(height: spacing.gutter),

          // --- Sayaçlar ---
          Row(
            children: [
              for (var i = 0; i < stats.length; i++) ...[
                if (i > 0) SizedBox(width: spacing.stackGap),
                Expanded(
                  child: _StatCard(stat: stats[i])
                      .animate()
                      .fadeIn(
                        delay: Duration(milliseconds: 60 * i),
                        duration: DesignTokens.durationMedium,
                      )
                      .slideY(begin: 0.15, curve: DesignTokens.curveStandard),
                ),
              ],
            ],
          ),

          SizedBox(height: spacing.sectionGap),

          Text(
            'AYARLAR',
            style: theme.textTheme.labelMedium?.copyWith(
              color: scheme.onSurfaceVariant,
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: spacing.stackGap),

          _ProfileTile(
            icon: Icons.bar_chart,
            label: 'İstatistikler',
            hint: 'Harcama ve tamamlama grafikleri',
            onTap: onOpenStatistics,
          ),
          _ProfileTile(
            icon: Icons.tune,
            label: 'Uygulama ayarları',
            hint: 'Tema, bildirim, dil',
            onTap: onOpenSettings,
          ),
          _ProfileTile(
            icon: Icons.workspace_premium_outlined,
            label: isPremium ? 'Aboneliğim' : "Premium'a geç",
            hint: isPremium
                ? 'Plan ve fatura bilgileri'
                : 'Sınırsız liste, yapay zekâ ve istatistik',
            highlighted: !isPremium,
            onTap: onOpenPremium,
          ),
          _ProfileTile(
            icon: Icons.logout,
            label: 'Çıkış yap',
            destructive: true,
            onTap: onSignOut,
          ),

          if (versionLabel.isNotEmpty) ...[
            SizedBox(height: spacing.sectionGap),
            Center(
              child: Text(
                versionLabel,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.stat});

  final ProfileStat stat;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return SmartCard(
      padding: const EdgeInsets.all(DesignTokens.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(stat.icon, color: stat.color, size: DesignTokens.iconMedium),
          const SizedBox(height: DesignTokens.space2),
          Text(stat.value, style: theme.textTheme.headlineSmall),
          Text(
            stat.label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.hint,
    this.highlighted = false,
    this.destructive = false,
  });

  final IconData icon;
  final String label;
  final String? hint;
  final VoidCallback onTap;

  /// Premium gibi dikkat çekmesi gereken satırlar için vurgulu renk.
  final bool highlighted;

  /// Çıkış gibi geri alınamayan işlemler hata rengiyle gösterilir.
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final spacing = context.spacing;

    final tint = destructive
        ? scheme.error
        : highlighted
        ? scheme.tertiary
        : scheme.primary;

    return Padding(
      padding: EdgeInsets.only(bottom: spacing.stackGap),
      child: SmartCard(
        onTap: onTap,
        padding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.space4,
          vertical: DesignTokens.space3,
        ),
        child: Row(
          children: [
            Container(
              width: DesignTokens.avatarMedium,
              height: DesignTokens.avatarMedium,
              decoration: BoxDecoration(
                // Simge kutusu, satırın rengini düşük opaklıkla tekrarlar.
                color: tint.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(spacing.radiusItem),
              ),
              child: Icon(icon, color: tint, size: DesignTokens.iconSmall),
            ),
            SizedBox(width: spacing.stackGap),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: destructive ? scheme.error : scheme.onSurface,
                    ),
                  ),
                  if (hint != null)
                    Text(
                      hint!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ),
            if (!destructive)
              Icon(Icons.chevron_right, color: scheme.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}
