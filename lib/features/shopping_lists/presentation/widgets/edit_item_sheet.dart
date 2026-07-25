import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:smartlist/core/theme/design_tokens.dart';
import 'package:smartlist/core/theme/spacing_theme.dart';

/// Düzenleme sonucu. Fiyat için ayrı bir "temizlendi" bilgisi taşıyor: alanı
/// boşaltmak ile dokunmamak farklı şeyler.
class EditedItem {
  const EditedItem({
    required this.name,
    required this.quantity,
    required this.unit,
    required this.notes,
    required this.clearPrice,
    this.price,
  });

  final String name;
  final double quantity;
  final String unit;
  final String notes;
  final double? price;
  final bool clearPrice;
}

/// Var olan bir ürünü düzenleme sayfası.
class EditItemSheet extends StatefulWidget {
  const EditItemSheet({
    required this.name,
    required this.quantity,
    required this.unit,
    required this.notes,
    this.price,
    super.key,
  });

  final String name;
  final double quantity;
  final String unit;
  final String notes;
  final double? price;

  static Future<EditedItem?> show(
    BuildContext context, {
    required String name,
    required double quantity,
    required String unit,
    required String notes,
    double? price,
  }) {
    return showModalBottomSheet<EditedItem>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => EditItemSheet(
        name: name,
        quantity: quantity,
        unit: unit,
        notes: notes,
        price: price,
      ),
    );
  }

  @override
  State<EditItemSheet> createState() => _EditItemSheetState();
}

class _EditItemSheetState extends State<EditItemSheet> {
  final _formKey = GlobalKey<FormState>();

  late final _name = TextEditingController(text: widget.name);
  late final _notes = TextEditingController(text: widget.notes);
  late final _price = TextEditingController(
    text: widget.price == null ? '' : _trim(widget.price!),
  );

  late double _quantity = widget.quantity;
  late String _unit = widget.unit;

  /// Ölçü birimleri; veritabanındaki enum ile aynı değerler.
  static const _units = [
    ('piece', 'adet'),
    ('kg', 'kg'),
    ('g', 'g'),
    ('l', 'litre'),
    ('ml', 'ml'),
    ('pack', 'paket'),
    ('box', 'kutu'),
    ('bottle', 'şişe'),
    ('bunch', 'demet'),
    ('dozen', 'düzine'),
  ];

  static String _trim(double value) => value == value.roundToDouble()
      ? value.round().toString()
      : value.toString();

  @override
  void dispose() {
    _name.dispose();
    _notes.dispose();
    _price.dispose();
    super.dispose();
  }

  void _save() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final priceText = _price.text.trim().replaceAll(',', '.');
    final parsed = double.tryParse(priceText);

    Navigator.of(context).pop(
      EditedItem(
        name: _name.text,
        quantity: _quantity,
        unit: _unit,
        notes: _notes.text,
        price: parsed,
        // Kullanıcı alanı boşalttıysa fiyat gerçekten silinmeli.
        clearPrice: priceText.isEmpty && widget.price != null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final spacing = context.spacing;

    return Padding(
      padding: EdgeInsets.only(
        left: spacing.containerMargin,
        right: spacing.containerMargin,
        top: spacing.containerMargin,
        bottom:
            spacing.containerMargin + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Ürünü düzenle',
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

              TextFormField(
                controller: _name,
                autofocus: true,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Ürün adı',
                  prefixIcon: Icon(Icons.shopping_basket_outlined),
                ),
                validator: (value) =>
                    (value ?? '').trim().isEmpty ? 'Ürün adı gerekli' : null,
              ),
              SizedBox(height: spacing.gutter),

              Row(
                children: [
                  Text('Miktar', style: theme.textTheme.titleMedium),
                  const Spacer(),
                  IconButton(
                    // Alt sınır 0.5: yarım kilo gibi kesirli miktarlar geçerli,
                    // sıfır ürün değil.
                    onPressed: _quantity <= 0.5
                        ? null
                        : () => setState(() => _quantity -= 0.5),
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  Text(_trim(_quantity), style: theme.textTheme.titleLarge),
                  IconButton(
                    onPressed: () => setState(() => _quantity += 0.5),
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
              SizedBox(height: spacing.stackGap),

              Wrap(
                spacing: DesignTokens.space2,
                runSpacing: DesignTokens.space2,
                children: [
                  for (final (wire, label) in _units)
                    ChoiceChip(
                      label: Text(label),
                      selected: _unit == wire,
                      onSelected: (_) => setState(() => _unit = wire),
                    ),
                ],
              ),
              SizedBox(height: spacing.gutter),

              TextFormField(
                controller: _price,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Fiyat (isteğe bağlı)',
                  suffixText: 'TL',
                  prefixIcon: Icon(Icons.payments_outlined),
                  helperText: 'Boş bırakırsanız fiyat silinir',
                ),
              ),
              SizedBox(height: spacing.gutter),

              TextFormField(
                controller: _notes,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Not (isteğe bağlı)',
                  prefixIcon: Icon(Icons.notes),
                ),
              ),
              SizedBox(height: spacing.sectionGap),

              SizedBox(
                height: DesignTokens.primaryButtonHeight,
                child: FilledButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.check),
                  label: const Text('Kaydet'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Liste adını ve emojisini düzenleme sayfası.
class RenameListSheet extends StatefulWidget {
  const RenameListSheet({
    required this.title,
    required this.emoji,
    super.key,
  });

  final String title;
  final String emoji;

  static Future<({String title, String emoji})?> show(
    BuildContext context, {
    required String title,
    required String emoji,
  }) {
    return showModalBottomSheet<({String title, String emoji})>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => RenameListSheet(title: title, emoji: emoji),
    );
  }

  @override
  State<RenameListSheet> createState() => _RenameListSheetState();
}

class _RenameListSheetState extends State<RenameListSheet> {
  final _formKey = GlobalKey<FormState>();
  late final _title = TextEditingController(text: widget.title);
  late String _emoji = widget.emoji;

  static const _emojis = [
    '🛒',
    '🏠',
    '🔥',
    '🎉',
    '🧺',
    '🍎',
    '🧼',
    '🍼',
    '🐾',
    '💊',
  ];

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final spacing = context.spacing;

    return Padding(
      padding: EdgeInsets.only(
        left: spacing.containerMargin,
        right: spacing.containerMargin,
        top: spacing.containerMargin,
        bottom:
            spacing.containerMargin + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Listeyi düzenle', style: theme.textTheme.headlineSmall),
            SizedBox(height: spacing.gutter),

            TextFormField(
              controller: _title,
              autofocus: true,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(labelText: 'Liste adı'),
              validator: (value) =>
                  (value ?? '').trim().isEmpty ? 'Liste adı gerekli' : null,
            ),
            SizedBox(height: spacing.gutter),

            Wrap(
              spacing: DesignTokens.space2,
              runSpacing: DesignTokens.space2,
              children: [
                for (final emoji in _emojis)
                  ChoiceChip(
                    label: Text(emoji, style: const TextStyle(fontSize: 20)),
                    selected: _emoji == emoji,
                    onSelected: (_) => setState(() => _emoji = emoji),
                  ),
              ],
            ),
            SizedBox(height: spacing.sectionGap),

            SizedBox(
              height: DesignTokens.primaryButtonHeight,
              child: FilledButton.icon(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    Navigator.of(context).pop((
                      title: _title.text.trim(),
                      emoji: _emoji,
                    ));
                  }
                },
                icon: const Icon(Icons.check),
                label: const Text('Kaydet'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
