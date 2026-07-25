import 'package:flutter/material.dart';

import 'package:smartlist/core/theme/design_tokens.dart';
import 'package:smartlist/core/theme/spacing_theme.dart';
import 'package:smartlist/core/widgets/smart_card.dart';

/// Aramada dönen tek sonuç.
class SearchHit {
  const SearchHit({
    required this.listId,
    required this.title,
    required this.subtitle,
    required this.isList,
  });

  final String listId;
  final String title;
  final String subtitle;

  /// Sonuç bir liste mi, yoksa liste içindeki bir ürün mü.
  final bool isList;
}

/// Liste ve ürünler arasında arama.
///
/// Arama işini çağıran taraf yapar ([onSearch]); ekran yalnızca sorguyu
/// iletir ve sonucu çizer. Böylece aynı ekran hem bellekteki örnek veriyle
/// hem de Firestore sorgusuyla çalışabilir.
class SearchScreen extends StatefulWidget {
  const SearchScreen({
    required this.onSearch,
    this.onOpenList,
    this.recentQueries = const [],
    super.key,
  });

  /// Sorguya karşılık sonuçları döner. Boş sorguda boş liste beklenir.
  final List<SearchHit> Function(String query) onSearch;

  final ValueChanged<String>? onOpenList;

  /// Son aramalar; sorgu boşken öneri olarak gösterilir.
  final List<String> recentQueries;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  List<SearchHit> _results = const [];
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _run(String query) {
    setState(() {
      _query = query;
      // Tek karakterde arama yapmak neredeyse tüm listeyi döndürür; iki
      // karakterden itibaren aramak sonucu anlamlı kılıyor.
      _results = query.trim().length < 2
          ? const []
          : widget.onSearch(query.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final spacing = context.spacing;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: TextField(
          controller: _controller,
          autofocus: true,
          textInputAction: TextInputAction.search,
          onChanged: _run,
          decoration: InputDecoration(
            hintText: 'Ürün, liste veya kategori ara...',
            filled: false,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            suffixIcon: _query.isEmpty
                ? null
                : IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      _controller.clear();
                      _run('');
                    },
                  ),
          ),
        ),
      ),
      body: _query.trim().length < 2
          ? _suggestions(context)
          : _results.isEmpty
          ? _empty(context)
          : ListView.separated(
              padding: EdgeInsets.all(spacing.containerMargin),
              itemCount: _results.length,
              separatorBuilder: (_, _) => SizedBox(height: spacing.stackGap),
              itemBuilder: (context, index) {
                final hit = _results[index];
                return SmartCard(
                  padding: const EdgeInsets.all(DesignTokens.space4),
                  onTap: () {
                    Navigator.of(context).pop();
                    widget.onOpenList?.call(hit.listId);
                  },
                  child: Row(
                    children: [
                      Container(
                        width: DesignTokens.avatarLarge,
                        height: DesignTokens.avatarLarge,
                        decoration: BoxDecoration(
                          color: scheme.surfaceContainer,
                          borderRadius: BorderRadius.circular(
                            spacing.radiusItem,
                          ),
                        ),
                        child: Icon(
                          hit.isList
                              ? Icons.format_list_bulleted
                              : Icons.shopping_basket_outlined,
                          color: scheme.primary,
                        ),
                      ),
                      const SizedBox(width: DesignTokens.space3),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(hit.title, style: theme.textTheme.titleMedium),
                            Text(
                              hit.subtitle,
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: scheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget _suggestions(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final spacing = context.spacing;

    if (widget.recentQueries.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(spacing.containerMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search, size: 56, color: scheme.outlineVariant),
              SizedBox(height: spacing.gutter),
              Text(
                'Aramaya başlayın',
                style: theme.textTheme.headlineSmall,
              ),
              SizedBox(height: spacing.small),
              Text(
                'Liste adı veya ürün yazın.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView(
      padding: EdgeInsets.all(spacing.containerMargin),
      children: [
        Text(
          'SON ARAMALAR',
          style: theme.textTheme.labelMedium?.copyWith(
            color: scheme.onSurfaceVariant,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: spacing.small),
        for (final query in widget.recentQueries)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.history, color: scheme.onSurfaceVariant),
            title: Text(query),
            onTap: () {
              _controller.text = query;
              _run(query);
            },
          ),
      ],
    );
  }

  Widget _empty(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final spacing = context.spacing;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(spacing.containerMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 56,
              color: scheme.outlineVariant,
            ),
            SizedBox(height: spacing.gutter),
            Text('Sonuç bulunamadı', style: theme.textTheme.headlineSmall),
            SizedBox(height: spacing.small),
            Text(
              '"$_query" için eşleşme yok.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
