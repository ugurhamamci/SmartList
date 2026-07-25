import 'dart:async';

import 'package:flutter/material.dart';

import 'package:smartlist/core/theme/design_tokens.dart';
import 'package:smartlist/core/theme/spacing_theme.dart';
import 'package:smartlist/features/voice/data/speech_service.dart';
import 'package:smartlist/features/voice/domain/voice_parser.dart';

/// Sesle ürün ekleme sayfası.
///
/// Akış: mikrofon açılır → söylenenler anlık ekranda görünür → durduğunda
/// cümle ürünlere ayrılır → kullanıcı onaylar.
///
/// Ayrıştırma sonucu **onaya sunuluyor**, doğrudan yazılmıyor: konuşma tanıma
/// yanlış duyabiliyor ve yanlış duyulan bir ürünü listeden silmek, eklemeden
/// önce düzeltmekten zahmetli.
class VoiceInputSheet extends StatefulWidget {
  const VoiceInputSheet({super.key});

  static Future<List<VoiceItem>?> show(BuildContext context) {
    return showModalBottomSheet<List<VoiceItem>>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      // Dinleme sürerken yanlışlıkla kapanmasın.
      isDismissible: false,
      enableDrag: false,
      builder: (_) => const VoiceInputSheet(),
    );
  }

  @override
  State<VoiceInputSheet> createState() => _VoiceInputSheetState();
}

class _VoiceInputSheetState extends State<VoiceInputSheet> {
  static const _parser = VoiceParser();

  final _service = SpeechService();
  StreamSubscription<SpeechState>? _subscription;

  SpeechState _state = const SpeechState();
  List<VoiceItem> _items = const [];
  final Set<int> _excluded = {};

  bool _ready = false;

  @override
  void initState() {
    super.initState();
    _subscription = _service.states.listen((state) {
      if (!mounted) {
        return;
      }
      setState(() {
        _state = state;
        // Ara sonuçta da ayrıştırıyoruz: kullanıcı ne çıkarıldığını konuşurken
        // görüyor, sonunda sürpriz olmuyor.
        _items = _parser.parse(state.transcript);
        _excluded.clear();
      });
    });
    unawaited(_start());
  }

  Future<void> _start() async {
    final available = await _service.prepare();
    if (!mounted) {
      return;
    }
    setState(() => _ready = available);
    if (available) {
      await _service.listen();
    }
  }

  @override
  void dispose() {
    unawaited(_subscription?.cancel());
    unawaited(_service.dispose());
    super.dispose();
  }

  void _accept() {
    final kept = [
      for (var i = 0; i < _items.length; i++)
        if (!_excluded.contains(i)) _items[i],
    ];
    Navigator.of(context).pop(kept.isEmpty ? null : kept);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final spacing = context.spacing;

    final listening = _state.phase == SpeechPhase.listening;
    final failed =
        _state.phase == SpeechPhase.unavailable ||
        _state.phase == SpeechPhase.failed;

    return Padding(
      padding: EdgeInsets.all(spacing.containerMargin),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Sesle ürün ekle',
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          SizedBox(height: spacing.gutter),

          if (failed)
            _Message(
              icon: Icons.mic_off,
              title: 'Mikrofon kullanılamıyor',
              detail:
                  _state.errorMessage ??
                  'Cihaz konuşma tanımayı desteklemiyor. Ürünü elle '
                      'yazabilirsiniz.',
            )
          else ...[
            // Mikrofon göstergesi: ses seviyesiyle büyüyüp küçülüyor, böylece
            // kullanıcı mikrofonun gerçekten duyduğunu görüyor.
            Center(
              child: AnimatedContainer(
                duration: DesignTokens.durationFast,
                width:
                    96 + (listening ? _state.soundLevel.clamp(0, 10) * 4 : 0),
                height:
                    96 + (listening ? _state.soundLevel.clamp(0, 10) * 4 : 0),
                decoration: BoxDecoration(
                  color: listening
                      ? scheme.primary.withValues(alpha: 0.12)
                      : scheme.surfaceContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  listening ? Icons.mic : Icons.mic_none,
                  size: DesignTokens.iconExtraLarge,
                  color: listening ? scheme.primary : scheme.onSurfaceVariant,
                ),
              ),
            ),
            SizedBox(height: spacing.gutter),

            Text(
              switch (_state.phase) {
                SpeechPhase.listening => 'Dinliyorum… ürünleri söyleyin',
                SpeechPhase.done => 'Bitti',
                _ => _ready ? 'Hazırlanıyor…' : 'Mikrofon açılıyor…',
              },
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: spacing.stackGap),

            // Örnek cümle: kullanıcı nasıl söyleyeceğini bilmiyor olabilir.
            if (_state.transcript.isEmpty)
              Text(
                '"İki litre süt, üç ekmek ve yarım kilo domates"',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: scheme.outline,
                  fontStyle: FontStyle.italic,
                ),
              )
            else
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(DesignTokens.space3),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
                ),
                child: Text(
                  _state.transcript,
                  style: theme.textTheme.bodyLarge,
                ),
              ),

            if (_items.isNotEmpty) ...[
              SizedBox(height: spacing.gutter),
              Text(
                '${_items.length - _excluded.length} ürün bulundu',
                style: theme.textTheme.titleMedium,
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 220),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    for (var i = 0; i < _items.length; i++)
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
                        title: Text(_items[i].name),
                        subtitle: Text(_items[i].quantityLabel),
                      ),
                  ],
                ),
              ),
            ],

            SizedBox(height: spacing.gutter),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: DesignTokens.primaryButtonHeight,
                    child: OutlinedButton.icon(
                      onPressed: listening
                          ? () => unawaited(_service.stop())
                          : () => unawaited(_start()),
                      icon: Icon(listening ? Icons.stop : Icons.refresh),
                      label: Text(listening ? 'Bitir' : 'Tekrar dinle'),
                    ),
                  ),
                ),
                SizedBox(width: spacing.stackGap),
                Expanded(
                  child: SizedBox(
                    height: DesignTokens.primaryButtonHeight,
                    child: FilledButton.icon(
                      onPressed: _items.length == _excluded.length
                          ? null
                          : _accept,
                      icon: const Icon(Icons.playlist_add_check),
                      label: const Text('Ekle'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({
    required this.icon,
    required this.title,
    required this.detail,
  });

  final IconData icon;
  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DesignTokens.space6),
      child: Column(
        children: [
          Icon(
            icon,
            size: DesignTokens.iconExtraLarge,
            color: theme.colorScheme.outlineVariant,
          ),
          const SizedBox(height: DesignTokens.space4),
          Text(title, style: theme.textTheme.titleLarge),
          const SizedBox(height: DesignTokens.space2),
          Text(
            detail,
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
