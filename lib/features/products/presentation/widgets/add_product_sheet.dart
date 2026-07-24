import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:smartlist/core/theme/design_tokens.dart';
import 'package:smartlist/core/theme/spacing_theme.dart';
import 'package:smartlist/core/widgets/press_scale.dart';

/// Kullanıcının doldurduğu ürün formunun sonucu.
class NewProduct {
  const NewProduct({
    required this.name,
    required this.category,
    required this.quantity,
    required this.unit,
    this.price,
    this.note,
  });

  final String name;
  final String category;
  final int quantity;
  final String unit;
  final double? price;
  final String? note;
}

/// "Ürün Ekle" alt sayfası.
///
/// Tasarımın bottom sheet'i: tutamaç, başlık, hızlı yakalama satırı
/// (fotoğraf / barkod / ses), ürün adı, kategori çipleri, miktar sayacı,
/// birim seçici, tahmini fiyat, not ve kaydet butonu.
///
/// [show] ile açılır ve girilen ürünü döndürür; iptal edilirse `null`.
class AddProductSheet extends StatefulWidget {
  const AddProductSheet({this.categories = _defaultCategories, super.key});

  static const List<String> _defaultCategories = [
    'Market',
    'Manav',
    'Kasap',
    'Kozmetik',
    'Eczane',
    'Fırın',
  ];

  final List<String> categories;

  /// Alt sayfayı açar. Tasarımın eğrisiyle ve 32px köşeyle gelir.
  static Future<NewProduct?> show(BuildContext context) {
    return showModalBottomSheet<NewProduct>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      barrierColor: DesignTokens.scrimColor,
      builder: (_) => const AddProductSheet(),
    );
  }

  @override
  State<AddProductSheet> createState() => _AddProductSheetState();
}

class _AddProductSheetState extends State<AddProductSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _noteController = TextEditingController();

  int _quantity = 1;
  String _unit = 'Adet';
  late String _category = widget.categories.first;

  static const _units = ['Adet', 'kg', 'Litre', 'Paket'];

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() != true) {
      return;
    }
    Navigator.of(context).pop(
      NewProduct(
        name: _nameController.text.trim(),
        category: _category,
        quantity: _quantity,
        unit: _unit,
        price: double.tryParse(_priceController.text.replaceAll(',', '.')),
        note: _noteController.text.trim().isEmpty
            ? null
            : _noteController.text.trim(),
      ),
    );
  }

  void _quickCapture(String label) {
    // Kamera, barkod ve ses servisleri henüz bağlı değil; kullanıcıya sessiz
    // kalmak yerine durumu bildiriyoruz.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$label yakında eklenecek')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final spacing = context.spacing;
    // Klavye açıldığında formun üstünü kapatmaması için ek boşluk.
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
                // --- Başlık ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Ürün Ekle', style: theme.textTheme.headlineMedium),
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

                // --- Hızlı yakalama ---
                Row(
                      children: [
                        _QuickCapture(
                          icon: Icons.photo_camera,
                          label: 'Fotoğraf',
                          onTap: () => _quickCapture('Fotoğrafla ekleme'),
                        ),
                        SizedBox(width: spacing.gutter),
                        _QuickCapture(
                          icon: Icons.qr_code_scanner,
                          label: 'Barkod',
                          onTap: () => _quickCapture('Barkod okuma'),
                        ),
                        SizedBox(width: spacing.gutter),
                        _QuickCapture(
                          icon: Icons.mic,
                          label: 'Sesle Ekle',
                          onTap: () => _quickCapture('Sesle ekleme'),
                        ),
                      ],
                    )
                    .animate()
                    .fadeIn(duration: 300.ms)
                    .slideY(begin: 0.15, end: 0),
                SizedBox(height: spacing.large),

                // --- Ürün adı ---
                const _FieldLabel('Ürün Adı'),
                TextFormField(
                  controller: _nameController,
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Örn: Süt',
                    suffixIcon: Icon(
                      Icons.auto_awesome,
                      color: scheme.primary.withValues(alpha: 0.4),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Ürün adı gerekli';
                    }
                    return null;
                  },
                ),
                SizedBox(height: spacing.large),

                // --- Kategori ---
                const _FieldLabel('Kategori'),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (final category in widget.categories)
                        Padding(
                          padding: const EdgeInsets.only(
                            right: DesignTokens.space2,
                          ),
                          child: ChoiceChip(
                            label: Text(category),
                            selected: _category == category,
                            showCheckmark: false,
                            labelStyle: theme.textTheme.labelMedium?.copyWith(
                              color: _category == category
                                  ? scheme.onPrimaryContainer
                                  : scheme.onSurfaceVariant,
                            ),
                            onSelected: (_) =>
                                setState(() => _category = category),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: spacing.large),

                // --- Miktar ve birim ---
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _FieldLabel('Miktar'),
                          _QuantityStepper(
                            value: _quantity,
                            onChanged: (value) =>
                                setState(() => _quantity = value),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spacing.gutter),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _FieldLabel('Birim'),
                          DropdownButtonFormField<String>(
                            initialValue: _unit,
                            items: [
                              for (final unit in _units)
                                DropdownMenuItem(
                                  value: unit,
                                  child: Text(unit),
                                ),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                setState(() => _unit = value);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spacing.large),

                // --- Tahmini fiyat ---
                const _FieldLabel('Tahmini Fiyat'),
                TextFormField(
                  controller: _priceController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    hintText: '0,00',
                    prefixText: '₺ ',
                  ),
                ),
                SizedBox(height: spacing.large),

                // --- Not ---
                const _FieldLabel('Not'),
                TextFormField(
                  controller: _noteController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    hintText: 'Ürün hakkında detaylar...',
                  ),
                ),
                SizedBox(height: spacing.large),

                // --- Kaydet ---
                FilledButton(
                  onPressed: _submit,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Kaydet'),
                      SizedBox(width: DesignTokens.space2),
                      Icon(Icons.check_circle),
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

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(
        left: DesignTokens.space1,
        bottom: DesignTokens.space1,
      ),
      child: Text(
        text,
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

/// Fotoğraf / barkod / ses kısayolu.
class _QuickCapture extends StatelessWidget {
  const _QuickCapture({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final spacing = context.spacing;

    return Expanded(
      child: PressScale(
        onTap: onTap,
        semanticLabel: label,
        enforceMinTouchTarget: false,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(spacing.radiusCard),
            border: Border.all(color: scheme.surfaceContainerHighest),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: DesignTokens.space4,
            ),
            child: Column(
              children: [
                Icon(icon, color: scheme.primary),
                const SizedBox(height: DesignTokens.space1),
                Text(
                  label,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: scheme.primary,
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

/// Eksi / artı butonlu miktar sayacı.
class _QuantityStepper extends StatelessWidget {
  const _QuantityStepper({required this.value, required this.onChanged});

  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final spacing = context.spacing;

    return Container(
      height: DesignTokens.inputHeight,
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(spacing.radiusItem),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        children: [
          PressScale.strong(
            // Miktar 1'in altına inemez.
            onTap: value > 1 ? () => onChanged(value - 1) : null,
            semanticLabel: 'Azalt',
            child: Icon(
              Icons.remove,
              color: value > 1 ? scheme.primary : scheme.outlineVariant,
            ),
          ),
          Expanded(
            child: Center(
              child: AnimatedSwitcher(
                duration: DesignTokens.durationFast,
                child: Text(
                  '$value',
                  key: ValueKey(value),
                  style: theme.textTheme.headlineSmall,
                ),
              ),
            ),
          ),
          PressScale.strong(
            onTap: () => onChanged(value + 1),
            semanticLabel: 'Artır',
            child: Icon(Icons.add, color: scheme.primary),
          ),
        ],
      ),
    );
  }
}
