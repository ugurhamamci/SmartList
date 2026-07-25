import 'package:flutter/material.dart';

import 'package:smartlist/core/theme/design_tokens.dart';
import 'package:smartlist/core/theme/spacing_theme.dart';
import 'package:smartlist/core/widgets/smart_card.dart';

/// Kullanıcının değiştirebildiği uygulama ayarları.
///
/// Değiştirilemez (immutable) tutulur: her değişiklik [copyWith] ile yeni bir
/// nesne üretir ve tek bir geri çağrı üzerinden yukarıya bildirilir. Böylece
/// ayarları kim tutuyorsa (önizlemede `State`, gerçek uygulamada Riverpod)
/// tek bir yerde saklanır.
class AppSettings {
  const AppSettings({
    this.themeMode = ThemeMode.system,
    this.pushEnabled = true,
    this.activityEmails = false,
    this.soundEnabled = true,
    this.hapticsEnabled = true,
    this.autoCategorise = true,
    this.showCompletedItems = true,
    this.currency = 'TRY',
    this.language = 'Türkçe',
  });

  final ThemeMode themeMode;
  final bool pushEnabled;
  final bool activityEmails;
  final bool soundEnabled;
  final bool hapticsEnabled;

  /// Ürün eklendiğinde kategoriyi yapay zekâ tahmin etsin mi.
  final bool autoCategorise;

  final bool showCompletedItems;
  final String currency;
  final String language;

  AppSettings copyWith({
    ThemeMode? themeMode,
    bool? pushEnabled,
    bool? activityEmails,
    bool? soundEnabled,
    bool? hapticsEnabled,
    bool? autoCategorise,
    bool? showCompletedItems,
    String? currency,
    String? language,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      pushEnabled: pushEnabled ?? this.pushEnabled,
      activityEmails: activityEmails ?? this.activityEmails,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      hapticsEnabled: hapticsEnabled ?? this.hapticsEnabled,
      autoCategorise: autoCategorise ?? this.autoCategorise,
      showCompletedItems: showCompletedItems ?? this.showCompletedItems,
      currency: currency ?? this.currency,
      language: language ?? this.language,
    );
  }
}

/// Tema kipinin kullanıcıya gösterilen adı.
String themeModeLabel(ThemeMode mode) => switch (mode) {
  ThemeMode.system => 'Sistem',
  ThemeMode.light => 'Açık',
  ThemeMode.dark => 'Koyu',
};

/// Ayarlar ekranı. Her anahtar anında [onChanged] ile bildirilir; "kaydet"
/// düğmesi yok, çünkü ayarların etkisi anında görülüyor.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    required this.settings,
    required this.onChanged,
    this.versionLabel = '',
    super.key,
  });

  final AppSettings settings;
  final ValueChanged<AppSettings> onChanged;
  final String versionLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final spacing = context.spacing;

    return Scaffold(
      appBar: AppBar(title: const Text('Uygulama ayarları')),
      body: ListView(
        padding: EdgeInsets.all(spacing.containerMargin),
        children: [
          _Section(
            title: 'GÖRÜNÜM',
            children: [
              // Tema seçimi anında uygulanır; kullanıcı sonucu hemen görür.
              // Seçim durumu `RadioGroup` üzerinden yönetiliyor; tek tek
              // `groupValue` vermek Flutter 3.4x'te kullanımdan kaldırıldı.
              RadioGroup<ThemeMode>(
                groupValue: settings.themeMode,
                onChanged: (value) => value == null
                    ? null
                    : onChanged(settings.copyWith(themeMode: value)),
                child: Column(
                  children: [
                    for (final mode in ThemeMode.values)
                      RadioListTile<ThemeMode>(
                        contentPadding: EdgeInsets.zero,
                        value: mode,
                        title: Text(themeModeLabel(mode)),
                      ),
                  ],
                ),
              ),
            ],
          ),
          _Section(
            title: 'BİLDİRİMLER',
            children: [
              _SwitchRow(
                label: 'Anlık bildirimler',
                hint: 'Listeye ürün eklendiğinde haber ver',
                value: settings.pushEnabled,
                onChanged: (value) =>
                    onChanged(settings.copyWith(pushEnabled: value)),
              ),
              _SwitchRow(
                label: 'Günlük e-posta özeti',
                hint: 'Gün sonunda hareketleri e-postayla gönder',
                value: settings.activityEmails,
                onChanged: (value) =>
                    onChanged(settings.copyWith(activityEmails: value)),
              ),
              _SwitchRow(
                label: 'Ses',
                value: settings.soundEnabled,
                onChanged: (value) =>
                    onChanged(settings.copyWith(soundEnabled: value)),
              ),
              _SwitchRow(
                label: 'Titreşim',
                value: settings.hapticsEnabled,
                onChanged: (value) =>
                    onChanged(settings.copyWith(hapticsEnabled: value)),
              ),
            ],
          ),
          _Section(
            title: 'LİSTELER',
            children: [
              _SwitchRow(
                label: 'Kategorileri otomatik bul',
                hint: 'Yeni ürünün kategorisini yapay zekâ tahmin etsin',
                value: settings.autoCategorise,
                onChanged: (value) =>
                    onChanged(settings.copyWith(autoCategorise: value)),
              ),
              _SwitchRow(
                label: 'Tamamlananları göster',
                hint: 'Kapatılırsa alınan ürünler listeden gizlenir',
                value: settings.showCompletedItems,
                onChanged: (value) =>
                    onChanged(settings.copyWith(showCompletedItems: value)),
              ),
              _ChoiceRow(
                label: 'Para birimi',
                value: settings.currency,
                options: const ['TRY', 'EUR', 'USD', 'GBP'],
                onChanged: (value) =>
                    onChanged(settings.copyWith(currency: value)),
              ),
              _ChoiceRow(
                label: 'Dil',
                value: settings.language,
                options: const ['Türkçe', 'English'],
                onChanged: (value) =>
                    onChanged(settings.copyWith(language: value)),
              ),
            ],
          ),
          if (versionLabel.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: spacing.gutter),
              child: Center(
                child: Text(
                  versionLabel,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final spacing = context.spacing;

    return Padding(
      padding: EdgeInsets.only(bottom: spacing.sectionGap),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.labelMedium?.copyWith(
              color: scheme.onSurfaceVariant,
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: spacing.stackGap),
          SmartCard(
            padding: const EdgeInsets.symmetric(
              horizontal: DesignTokens.space4,
              vertical: DesignTokens.space2,
            ),
            // `ListTile` türevleri dalga efektini en yakın `Material` üstüne
            // çizer; kartın arka planı bunun üstünü kapatmasın diye satırlara
            // saydam bir `Material` veriyoruz.
            child: Material(
              type: MaterialType.transparency,
              child: Column(children: children),
            ),
          ),
        ],
      ),
    );
  }
}

class _SwitchRow extends StatelessWidget {
  const _SwitchRow({
    required this.label,
    required this.value,
    required this.onChanged,
    this.hint,
  });

  final String label;
  final String? hint;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return SwitchListTile.adaptive(
      contentPadding: EdgeInsets.zero,
      value: value,
      onChanged: onChanged,
      title: Text(label, style: theme.textTheme.titleMedium),
      subtitle: hint == null
          ? null
          : Text(
              hint!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
    );
  }
}

class _ChoiceRow extends StatelessWidget {
  const _ChoiceRow({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  final String label;
  final String value;
  final List<String> options;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label, style: theme.textTheme.titleMedium),
      trailing: DropdownButton<String>(
        value: value,
        underline: const SizedBox.shrink(),
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
        items: [
          for (final option in options)
            DropdownMenuItem(value: option, child: Text(option)),
        ],
        onChanged: (selected) => selected == null ? null : onChanged(selected),
      ),
    );
  }
}
