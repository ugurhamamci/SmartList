import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:smartlist/core/errors/app_exception.dart';
import 'package:smartlist/core/errors/app_exception_messages.dart';
import 'package:smartlist/core/theme/design_tokens.dart';
import 'package:smartlist/core/theme/spacing_theme.dart';
import 'package:smartlist/features/ai/ai_providers.dart';
import 'package:smartlist/features/ai/domain/ai_models.dart';
import 'package:smartlist/models/enums.dart';

/// Kullanıcının onayladığı ürünler.
class AiPickedItems {
  const AiPickedItems({required this.title, required this.items});

  final String title;
  final List<GeneratedItem> items;
}

/// "Ne alacağını yaz, listeyi yapay zekâ çıkarsın" sayfası.
///
/// Üretilen liste **doğrudan yazılmıyor**: kullanıcı onaylayana kadar bekliyor
/// ve tek tek ürün çıkarabiliyor. Model yanılabilir; yanıldığında düzeltmenin
/// yolu listeyi silmek olmamalı.
class AiGenerateSheet extends ConsumerStatefulWidget {
  const AiGenerateSheet({super.key});

  static Future<AiPickedItems?> show(BuildContext context) {
    return showModalBottomSheet<AiPickedItems>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const AiGenerateSheet(),
    );
  }

  /// Hazır istekler. Kullanıcının boş bir metin alanına ne yazacağını
  /// düşünmesi gerekmesin.
  static const List<({String label, String prompt, AiListKind kind})> presets =
      [
        (label: '🔥 Mangal', prompt: 'Mangal partisi', kind: AiListKind.party),
        (
          label: '🛒 Haftalık market',
          prompt: 'Haftalık market alışverişi',
          kind: AiListKind.weeklyShopping,
        ),
        (
          label: '🍝 Akşam yemeği',
          prompt: 'Akşam yemeği için malzemeler',
          kind: AiListKind.mealPlan,
        ),
        (
          label: '🧼 Temizlik',
          prompt: 'Ev temizlik malzemeleri',
          kind: AiListKind.custom,
        ),
        (
          label: '🍼 Bebek',
          prompt: 'Bebek bakım ürünleri',
          kind: AiListKind.baby,
        ),
        (
          label: '🥗 Diyet',
          prompt: 'Sağlıklı beslenme alışverişi',
          kind: AiListKind.diet,
        ),
      ];

  @override
  ConsumerState<AiGenerateSheet> createState() => _AiGenerateSheetState();
}

class _AiGenerateSheetState extends ConsumerState<AiGenerateSheet> {
  final _prompt = TextEditingController();

  AiListKind _kind = AiListKind.custom;
  int _people = 4;
  bool _busy = false;
  String? _error;

  GeneratedList? _result;

  /// Onaydan çıkarılan ürünlerin indeksleri.
  final Set<int> _excluded = {};

  @override
  void dispose() {
    _prompt.dispose();
    super.dispose();
  }

  Future<void> _generate() async {
    final text = _prompt.text.trim();
    if (text.isEmpty) {
      setState(() => _error = 'Ne alacağınızı yazın, örneğin "mangal".');
      return;
    }

    setState(() {
      _busy = true;
      _error = null;
      _result = null;
      _excluded.clear();
    });

    try {
      final generated = await ref
          .read(aiServiceProvider)
          .generateList(
            GenerationBrief(
              kind: _kind,
              prompt: text,
              peopleCount: _people,
              currency: 'TRY',
              localeCode: 'tr',
            ),
          );

      if (!mounted) {
        return;
      }
      setState(() {
        _result = generated;
        _busy = false;
      });
    } on AppException catch (error) {
      if (mounted) {
        setState(() {
          _error = error.userMessage;
          _busy = false;
        });
      }
    }
  }

  void _accept() {
    final result = _result;
    if (result == null) {
      return;
    }

    final kept = [
      for (var i = 0; i < result.items.length; i++)
        if (!_excluded.contains(i)) result.items[i],
    ];

    if (kept.isEmpty) {
      setState(() => _error = 'Hiç ürün seçilmedi.');
      return;
    }

    Navigator.of(context).pop(
      AiPickedItems(title: result.title, items: kept),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final spacing = context.spacing;

    // Yapılandırılmış bir sağlayıcı yoksa özelliği kapalı göstermek, deneyip
    // hata almaktan iyi.
    final configured = ref.watch(aiProviderRegistryProvider).configured;

    return Padding(
      padding: EdgeInsets.only(
        left: spacing.containerMargin,
        right: spacing.containerMargin,
        top: spacing.containerMargin,
        bottom:
            spacing.containerMargin + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.auto_awesome, color: scheme.primary),
                SizedBox(width: spacing.small),
                Expanded(
                  child: Text(
                    'Yapay zekâ ile liste',
                    style: theme.textTheme.headlineSmall,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            SizedBox(height: spacing.small),

            if (configured.isEmpty)
              _NotConfigured(theme: theme)
            else ...[
              Text(
                'Ne alacağınızı yazın; ürünleri, miktarları ve kategorileri '
                'yapay zekâ çıkarsın.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: spacing.gutter),

              // Hazır istekler
              Wrap(
                spacing: DesignTokens.space2,
                runSpacing: DesignTokens.space2,
                children: [
                  for (final preset in AiGenerateSheet.presets)
                    ActionChip(
                      label: Text(preset.label),
                      onPressed: _busy
                          ? null
                          : () {
                              _prompt.text = preset.prompt;
                              setState(() => _kind = preset.kind);
                            },
                    ),
                ],
              ),
              SizedBox(height: spacing.gutter),

              TextField(
                controller: _prompt,
                enabled: !_busy,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _generate(),
                decoration: const InputDecoration(
                  labelText: 'İstek',
                  hintText: 'Mangal partisi, 6 kişi',
                  prefixIcon: Icon(Icons.edit_outlined),
                ),
              ),
              SizedBox(height: spacing.gutter),

              Row(
                children: [
                  Text('Kişi sayısı', style: theme.textTheme.titleMedium),
                  const Spacer(),
                  IconButton(
                    onPressed: _busy || _people <= 1
                        ? null
                        : () => setState(() => _people--),
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  Text('$_people', style: theme.textTheme.titleLarge),
                  IconButton(
                    onPressed: _busy || _people >= 20
                        ? null
                        : () => setState(() => _people++),
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),

              if (_error != null) ...[
                SizedBox(height: spacing.stackGap),
                Container(
                  padding: const EdgeInsets.all(DesignTokens.space3),
                  decoration: BoxDecoration(
                    color: scheme.errorContainer,
                    borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
                  ),
                  child: Text(
                    _error!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: scheme.onErrorContainer,
                    ),
                  ),
                ),
              ],

              SizedBox(height: spacing.gutter),
              SizedBox(
                height: DesignTokens.primaryButtonHeight,
                child: FilledButton.icon(
                  onPressed: _busy ? null : _generate,
                  icon: _busy
                      ? const SizedBox(
                          width: DesignTokens.iconSmall,
                          height: DesignTokens.iconSmall,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.auto_awesome),
                  label: Text(_busy ? 'Hazırlanıyor…' : 'Liste öner'),
                ),
              ),

              if (_result != null) _review(theme, spacing),
            ],
          ],
        ),
      ),
    );
  }

  Widget _review(ThemeData theme, SpacingTheme spacing) {
    final result = _result!;
    final scheme = theme.colorScheme;
    final keptCount = result.items.length - _excluded.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: spacing.sectionGap),
        Text(result.title, style: theme.textTheme.headlineSmall),

        // Modelin gerekçesi gösteriliyor: öneri denetlenebilir olsun, kapalı
        // bir kutu gibi durmasın.
        if (result.rationale.isNotEmpty) ...[
          SizedBox(height: spacing.small),
          Text(
            result.rationale,
            style: theme.textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],

        SizedBox(height: spacing.gutter),
        for (var i = 0; i < result.items.length; i++)
          CheckboxListTile(
            value: !_excluded.contains(i),
            onChanged: (keep) => setState(() {
              if (keep ?? false) {
                _excluded.remove(i);
              } else {
                _excluded.add(i);
              }
            }),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            dense: true,
            title: Text(result.items[i].name),
            subtitle: Text(
              '${_amount(result.items[i].quantity)} '
              '${result.items[i].unit.wire}'
              '${result.items[i].category.isEmpty ? '' : ' • ${result.items[i].category}'}',
            ),
          ),

        SizedBox(height: spacing.gutter),
        SizedBox(
          height: DesignTokens.primaryButtonHeight,
          child: FilledButton.icon(
            onPressed: keptCount == 0 ? null : _accept,
            icon: const Icon(Icons.playlist_add_check),
            label: Text('$keptCount ürünü listeye ekle'),
          ),
        ),
      ],
    );
  }

  String _amount(double value) => value == value.roundToDouble()
      ? value.round().toString()
      : value.toString();
}

class _NotConfigured extends StatelessWidget {
  const _NotConfigured({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DesignTokens.space6),
      child: Column(
        children: [
          Icon(
            Icons.key_off,
            size: DesignTokens.iconExtraLarge,
            color: theme.colorScheme.outlineVariant,
          ),
          const SizedBox(height: DesignTokens.space4),
          Text(
            'Yapay zekâ yapılandırılmamış',
            style: theme.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: DesignTokens.space2),
          Text(
            'Bu derleme bir sağlayıcı anahtarıyla başlatılmamış. '
            'scripts/defines.local.ps1 içine OPENROUTER_API_KEY ekleyip '
            'yeniden çalıştırın.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
