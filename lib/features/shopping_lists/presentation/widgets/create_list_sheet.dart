import 'package:flutter/material.dart';

import 'package:smartlist/core/theme/design_tokens.dart';
import 'package:smartlist/core/theme/spacing_theme.dart';
import 'package:smartlist/core/widgets/press_scale.dart';

/// Yeni liste formunun sonucu.
class NewList {
  const NewList({
    required this.title,
    required this.emoji,
    required this.colorHex,
  });

  final String title;
  final String emoji;

  /// `AARRGGBB` biçiminde renk etiketi — `ShoppingList.colorHex` ile aynı biçim.
  final String colorHex;
}

/// "Yeni Liste" alt sayfası.
///
/// Başlık, emoji ve renk etiketi alır. Emoji ve renk seçenekleri tasarımın
/// paletinden gelir; serbest emoji girişi yerine sabit bir küme sunulur, çünkü
/// liste kartlarında tek karakterlik ve okunur bir glif gerekiyor.
class CreateListSheet extends StatefulWidget {
  const CreateListSheet({super.key});

  static const List<String> _emojis = [
    '🛒',
    '🧺',
    '🍽️',
    '🎉',
    '🍼',
    '🥗',
    '🏠',
    '🎁',
    '💊',
    '🐾',
  ];

  static Future<NewList?> show(BuildContext context) {
    return showModalBottomSheet<NewList>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      barrierColor: DesignTokens.scrimColor,
      builder: (_) => const CreateListSheet(),
    );
  }

  @override
  State<CreateListSheet> createState() => _CreateListSheetState();
}

class _CreateListSheetState extends State<CreateListSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  String _emoji = CreateListSheet._emojis.first;
  Color _color = DesignTokens.listLabelPalette.first;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() != true) {
      return;
    }
    Navigator.of(context).pop(
      NewList(
        title: _titleController.text.trim(),
        emoji: _emoji,
        // Renk, modeldeki alanla aynı sekiz haneli biçimde saklanır.
        colorHex: _color
            .toARGB32()
            .toRadixString(16)
            .toUpperCase()
            .padLeft(
              8,
              '0',
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final spacing = context.spacing;
    final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: keyboardInset),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            spacing.containerMargin,
            0,
            spacing.containerMargin,
            DesignTokens.space10,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Yeni Liste', style: theme.textTheme.headlineMedium),
                    PressScale(
                      onTap: () => Navigator.of(context).pop(),
                      semanticLabel: 'Kapat',
                      child: Container(
                        width: DesignTokens.iconButtonSize,
                        height: DesignTokens.iconButtonSize,
                        decoration: BoxDecoration(
                          color: scheme.surfaceContainerLow,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spacing.large),

                // --- Önizleme: seçimler kart üstünde canlı görünür ---
                Container(
                  padding: const EdgeInsets.all(DesignTokens.space4),
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(spacing.radiusCard),
                    border: Border.all(color: scheme.outlineVariant),
                    boxShadow: DesignTokens.cardShadow,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: DesignTokens.avatarLarge,
                        height: DesignTokens.avatarLarge,
                        decoration: BoxDecoration(
                          color: _color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(
                            spacing.radiusItem,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            _emoji,
                            style: const TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                      const SizedBox(width: DesignTokens.space3),
                      Expanded(
                        child: Text(
                          _titleController.text.trim().isEmpty
                              ? 'Liste adı'
                              : _titleController.text.trim(),
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: _titleController.text.trim().isEmpty
                                ? scheme.outline
                                : scheme.onSurface,
                          ),
                        ),
                      ),
                      Container(
                        width: DesignTokens.space3,
                        height: DesignTokens.space10,
                        decoration: BoxDecoration(
                          color: _color,
                          borderRadius: BorderRadius.circular(
                            DesignTokens.radiusFull,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spacing.large),

                // --- Başlık ---
                Padding(
                  padding: const EdgeInsets.only(
                    left: DesignTokens.space1,
                    bottom: DesignTokens.space1,
                  ),
                  child: Text(
                    'Liste Adı',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
                TextFormField(
                  controller: _titleController,
                  autofocus: true,
                  textCapitalization: TextCapitalization.sentences,
                  maxLength: 120,
                  decoration: const InputDecoration(
                    hintText: 'Örn: Haftalık Market',
                    counterText: '',
                  ),
                  // Önizlemedeki adın yazarken güncellenmesi için.
                  onChanged: (_) => setState(() {}),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Liste adı gerekli';
                    }
                    return null;
                  },
                ),
                SizedBox(height: spacing.large),

                // --- Emoji ---
                Padding(
                  padding: const EdgeInsets.only(
                    left: DesignTokens.space1,
                    bottom: DesignTokens.space2,
                  ),
                  child: Text(
                    'Simge',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Wrap(
                  spacing: DesignTokens.space2,
                  runSpacing: DesignTokens.space2,
                  children: [
                    for (final emoji in CreateListSheet._emojis)
                      GestureDetector(
                        onTap: () => setState(() => _emoji = emoji),
                        child: AnimatedContainer(
                          duration: DesignTokens.durationFast,
                          width: DesignTokens.touchTarget,
                          height: DesignTokens.touchTarget,
                          decoration: BoxDecoration(
                            color: _emoji == emoji
                                ? scheme.primaryContainer
                                : scheme.surfaceContainerLow,
                            borderRadius: BorderRadius.circular(
                              spacing.radiusItem,
                            ),
                            border: Border.all(
                              color: _emoji == emoji
                                  ? scheme.primaryContainer
                                  : scheme.outlineVariant,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              emoji,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: spacing.large),

                // --- Renk ---
                Padding(
                  padding: const EdgeInsets.only(
                    left: DesignTokens.space1,
                    bottom: DesignTokens.space2,
                  ),
                  child: Text(
                    'Renk Etiketi',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Wrap(
                  spacing: DesignTokens.space3,
                  runSpacing: DesignTokens.space3,
                  children: [
                    for (final color in DesignTokens.listLabelPalette)
                      GestureDetector(
                        onTap: () => setState(() => _color = color),
                        child: AnimatedContainer(
                          duration: DesignTokens.durationFast,
                          width: DesignTokens.avatarMedium,
                          height: DesignTokens.avatarMedium,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _color == color
                                  ? scheme.onSurface
                                  : Colors.transparent,
                              width: 3,
                            ),
                          ),
                          child: _color == color
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: DesignTokens.iconSmall,
                                )
                              : null,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: spacing.large),

                FilledButton(
                  onPressed: _submit,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Listeyi Oluştur'),
                      SizedBox(width: DesignTokens.space2),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
