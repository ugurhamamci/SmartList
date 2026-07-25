import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:smartlist/core/theme/design_tokens.dart';
import 'package:smartlist/core/theme/spacing_theme.dart';
import 'package:smartlist/core/widgets/avatar_stack.dart';
import 'package:smartlist/core/widgets/press_scale.dart';
import 'package:smartlist/core/widgets/smart_card.dart';

/// Akıştaki tek etkinlik.
class ActivityEntry {
  const ActivityEntry({
    required this.actorInitials,
    required this.actorName,
    required this.action,
    required this.target,
    required this.meta,
    required this.icon,
    required this.iconColor,
  });

  final String actorInitials;
  final String actorName;

  /// "aldı", "ekledi" gibi eylem metni.
  final String action;
  final String target;

  /// "2dk önce • Haftalık Market".
  final String meta;

  final IconData icon;
  final Color iconColor;
}

/// Activity ve Share sekmelerini barındıran ekran.
class ActivityShareView extends StatefulWidget {
  const ActivityShareView({
    required this.entries,
    required this.members,
    this.listName = 'Haftalık Market',
    this.inviteLink = 'smartlist.app/j/82Xq...',
    this.onMarkAllRead,
    this.onCopyLink,
    this.onShareWhatsApp,
    this.onShareSms,
    super.key,
  });

  final List<ActivityEntry> entries;
  final List<AvatarData> members;
  final String listName;
  final String inviteLink;

  final VoidCallback? onMarkAllRead;
  final VoidCallback? onCopyLink;
  final VoidCallback? onShareWhatsApp;
  final VoidCallback? onShareSms;

  @override
  State<ActivityShareView> createState() => _ActivityShareViewState();
}

class _ActivityShareViewState extends State<ActivityShareView> {
  bool _showActivity = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final spacing = context.spacing;

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          // --- Sekme değiştirici ---
          Padding(
            padding: EdgeInsets.all(spacing.containerMargin),
            child: Container(
              padding: const EdgeInsets.all(DesignTokens.space1),
              decoration: BoxDecoration(
                color: scheme.surfaceContainer,
                borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
              ),
              child: Row(
                children: [
                  _TabButton(
                    label: 'Activity',
                    selected: _showActivity,
                    onTap: () => setState(() => _showActivity = true),
                  ),
                  _TabButton(
                    label: 'Share',
                    selected: !_showActivity,
                    onTap: () => setState(() => _showActivity = false),
                  ),
                ],
              ),
            ),
          ),

          // Sekme geçişi: yeni içerik yumuşakça belirip hafifçe yukarı kayar.
          Expanded(
            child: AnimatedSwitcher(
              duration: DesignTokens.durationMedium,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.05),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: _showActivity
                  ? _ActivityList(
                      key: const ValueKey('activity'),
                      entries: widget.entries,
                      onMarkAllRead: widget.onMarkAllRead,
                    )
                  : _SharePanel(
                      key: const ValueKey('share'),
                      listName: widget.listName,
                      inviteLink: widget.inviteLink,
                      members: widget.members,
                      onCopyLink: widget.onCopyLink,
                      onShareWhatsApp: widget.onShareWhatsApp,
                      onShareSms: widget.onShareSms,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Expanded(
      child: Semantics(
        selected: selected,
        button: true,
        child: GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: AnimatedContainer(
            duration: DesignTokens.durationMedium,
            curve: DesignTokens.curveStandard,
            padding: const EdgeInsets.symmetric(
              vertical: DesignTokens.space2,
            ),
            decoration: BoxDecoration(
              color: selected ? scheme.primaryContainer : Colors.transparent,
              borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
            ),
            child: Center(
              child: Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: selected
                      ? scheme.onPrimaryContainer
                      : scheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ActivityList extends StatelessWidget {
  const _ActivityList({
    required this.entries,
    this.onMarkAllRead,
    super.key,
  });

  final List<ActivityEntry> entries;
  final VoidCallback? onMarkAllRead;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final spacing = context.spacing;

    return ListView(
      padding: EdgeInsets.fromLTRB(
        spacing.containerMargin,
        0,
        spacing.containerMargin,
        DesignTokens.space10 * 3,
      ),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Son Hareketler', style: theme.textTheme.headlineSmall),
            TextButton(
              onPressed: onMarkAllRead,
              child: const Text('Tümünü okundu işaretle'),
            ),
          ],
        ),
        SizedBox(height: spacing.stackGap),
        for (var i = 0; i < entries.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: spacing.stackGap),
            child:
                SmartCard(
                      padding: const EdgeInsets.all(DesignTokens.space4),
                      child: Row(
                        children: [
                          // Avatar + eylem türünü gösteren küçük rozet.
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              MemberAvatar(
                                data: AvatarData(
                                  initials: entries[i].actorInitials,
                                  label: entries[i].actorName,
                                ),
                                size: DesignTokens.avatarLarge,
                              ),
                              Positioned(
                                right: -2,
                                bottom: -2,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: entries[i].iconColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: scheme.surfaceContainerLowest,
                                      width: 2,
                                    ),
                                  ),
                                  child: Icon(
                                    entries[i].icon,
                                    size: DesignTokens.iconTiny,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: DesignTokens.space4),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    style: theme.textTheme.bodyLarge,
                                    children: [
                                      TextSpan(
                                        text: entries[i].actorName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      TextSpan(text: ' ${entries[i].action} '),
                                      TextSpan(
                                        text: entries[i].target,
                                        style: TextStyle(
                                          color: scheme.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  entries[i].meta,
                                  style: theme.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                    .animate(delay: (i * 70).ms)
                    .fadeIn(duration: DesignTokens.durationSlow)
                    .slideY(begin: 0.2, end: 0, curve: DesignTokens.curveSwipe),
          ),
      ],
    );
  }
}

class _SharePanel extends StatelessWidget {
  const _SharePanel({
    required this.listName,
    required this.inviteLink,
    required this.members,
    this.onCopyLink,
    this.onShareWhatsApp,
    this.onShareSms,
    super.key,
  });

  final String listName;
  final String inviteLink;
  final List<AvatarData> members;
  final VoidCallback? onCopyLink;
  final VoidCallback? onShareWhatsApp;
  final VoidCallback? onShareSms;

  /// QR koduna gömülen tam adres. [inviteLink] ekranda kısaltılmış hâlde
  /// gösterilirken, kodun içine taranabilir tam URL yazılır.
  String get inviteUrl =>
      inviteLink.startsWith('http') ? inviteLink : 'https://$inviteLink';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final spacing = context.spacing;

    return ListView(
      padding: EdgeInsets.fromLTRB(
        spacing.containerMargin,
        0,
        spacing.containerMargin,
        DesignTokens.space10 * 3,
      ),
      children: [
        // --- QR kartı ---
        Center(
          child:
              SmartCard(
                    padding: const EdgeInsets.all(DesignTokens.space8),
                    borderRadius: DesignTokens.radius3xl,
                    child: Column(
                      children: [
                        Container(
                          width: DesignTokens.qrSize,
                          height: DesignTokens.qrSize,
                          padding: const EdgeInsets.all(DesignTokens.space4),
                          decoration: BoxDecoration(
                            color: scheme.surfaceContainerLow,
                            borderRadius: BorderRadius.circular(
                              DesignTokens.radius2xl,
                            ),
                          ),
                          // Gerçek, okunabilir QR kodu. İçeriği davet
                          // bağlantısıdır; tarayıcı bunu okuyup listeye
                          // katılma akışını başlatır.
                          child: QrImageView(
                            data: inviteUrl,
                            backgroundColor: scheme.surfaceContainerLow,
                            eyeStyle: QrEyeStyle(
                              eyeShape: QrEyeShape.square,
                              color: scheme.onSurface,
                            ),
                            dataModuleStyle: QrDataModuleStyle(
                              dataModuleShape: QrDataModuleShape.square,
                              color: scheme.onSurface,
                            ),
                            // Kod çizilemezse kullanıcı bağlantıyı
                            // kopyalayarak devam edebilir.
                            errorStateBuilder: (_, _) => Center(
                              child: Text(
                                'QR oluşturulamadı.\nBağlantıyı kopyalayın.',
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodySmall,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: DesignTokens.space6),
                        Text(listName, style: theme.textTheme.headlineSmall),
                        const SizedBox(height: DesignTokens.space1),
                        Text(
                          'Bu listeye katılmak için okutun',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  )
                  .animate()
                  .fadeIn(duration: DesignTokens.durationSlow)
                  .scale(
                    begin: const Offset(0.92, 0.92),
                    end: const Offset(1, 1),
                    curve: Curves.easeOutBack,
                  ),
        ),
        SizedBox(height: spacing.sectionGap),

        // --- Aktif üyeler ---
        Text(
          'AKTİF ÜYELER',
          textAlign: TextAlign.center,
          style: theme.textTheme.labelMedium?.copyWith(
            color: scheme.onSurfaceVariant,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: spacing.gutter),
        Center(
          child: AvatarStack(
            members: members,
            maxVisible: 3,
            size: DesignTokens.avatarExtraLarge,
          ),
        ),
        SizedBox(height: spacing.sectionGap),

        // --- Paylaşım aksiyonları ---
        PressScale.subtle(
          onTap: onCopyLink,
          child: Container(
            height: DesignTokens.actionButtonHeight,
            padding: const EdgeInsets.symmetric(
              horizontal: DesignTokens.space4,
            ),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(spacing.radiusCard),
              border: Border.all(color: scheme.outlineVariant),
            ),
            child: Row(
              children: [
                Icon(Icons.content_copy, color: scheme.onSurfaceVariant),
                const SizedBox(width: DesignTokens.space3),
                Expanded(
                  child: Text(
                    'Davet bağlantısını kopyala',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  inviteLink,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: scheme.outline,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: spacing.gutter),
        Row(
          children: [
            Expanded(
              child: _ShareButton(
                icon: Icons.chat,
                label: 'WhatsApp',
                // WhatsApp marka rengi; tasarımda da sabit verilmiş.
                color: const Color(0xFF25D366),
                foreground: const Color(0xFF075E54),
                onTap: onShareWhatsApp,
              ),
            ),
            SizedBox(width: spacing.gutter),
            Expanded(
              child: _ShareButton(
                icon: Icons.sms,
                label: 'Mesaj',
                color: scheme.primary,
                foreground: scheme.primary,
                onTap: onShareSms,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ShareButton extends StatelessWidget {
  const _ShareButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.foreground,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final Color foreground;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final spacing = context.spacing;

    return PressScale(
      onTap: onTap,
      semanticLabel: label,
      enforceMinTouchTarget: false,
      child: Container(
        height: DesignTokens.actionButtonHeight,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(spacing.radiusCard),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: foreground),
            const SizedBox(width: DesignTokens.space2),
            Text(
              label,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: foreground,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
