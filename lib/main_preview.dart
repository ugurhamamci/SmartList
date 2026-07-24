import 'package:flutter/material.dart';

import 'package:smartlist/core/theme/app_theme.dart';
import 'package:smartlist/core/theme/design_tokens.dart';
import 'package:smartlist/core/widgets/avatar_stack.dart';
import 'package:smartlist/features/home/presentation/screens/dashboard_view.dart';
import 'package:smartlist/features/notifications/presentation/screens/activity_share_view.dart';
import 'package:smartlist/features/products/presentation/widgets/add_product_sheet.dart';
import 'package:smartlist/features/shared/presentation/screens/splash_screen.dart';
import 'package:smartlist/features/shared/presentation/widgets/app_bottom_nav.dart';
import 'package:smartlist/features/shopping_lists/presentation/screens/list_detail_view.dart';
import 'package:smartlist/features/shopping_lists/presentation/widgets/shopping_item_tile.dart';

/// Tasarım önizlemesi — Firebase'e ihtiyaç duymaz.
///
/// Ekranların tamamı gerçek tema ve gerçek widget'larla, tam etkileşimli
/// çalışır: sekmeler geçer, liste açılır, ürün eklenir, kaydırma ve checkbox
/// çalışır. Veri bellekte tutulur, ağ veya Firebase kullanılmaz.
///
/// ```sh
/// flutter run -d chrome -t lib/main_preview.dart
/// flutter run -d web-server --web-port 8080 -t lib/main_preview.dart
/// ```
///
/// Bu bir geliştirme aracıdır; uygulamanın giriş noktaları `main.dart` ve
/// `main_<flavor>.dart` dosyalarıdır. Örnek veri de yalnızca burada durur.
void main() => runApp(const PreviewApp());

class PreviewApp extends StatelessWidget {
  const PreviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartList — Tasarım Önizlemesi',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      home: const PreviewRoot(),
    );
  }
}

/// Açılış ekranını gösterir, sonra uygulama kabuğuna geçer.
class PreviewRoot extends StatefulWidget {
  const PreviewRoot({super.key});

  @override
  State<PreviewRoot> createState() => _PreviewRootState();
}

class _PreviewRootState extends State<PreviewRoot> {
  bool _ready = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return ColoredBox(
      color: scheme.surfaceDim,
      child: Center(
        child: ConstrainedBox(
          // Tasarımın referans genişliği; mobilde tam ekran olur.
          constraints: const BoxConstraints(maxWidth: 420),
          child: ClipRect(
            // Açılıştan kabuğa yumuşak geçiş.
            child: AnimatedSwitcher(
              duration: DesignTokens.durationSlow,
              child: _ready
                  ? const PreviewShell(key: ValueKey('shell'))
                  : SplashScreen(
                      key: const ValueKey('splash'),
                      onFinished: () => setState(() => _ready = true),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------- örnek veri

/// Önizlemede kullanılan liste. Bellekte tutulur, gerçek kaydetme yok.
class _DemoList {
  _DemoList({required this.id, required this.title, required this.items});

  final String id;
  final String title;
  final List<ItemRowData> items;

  int get completedCount => items.where((item) => item.isCompleted).length;

  double get progress => items.isEmpty ? 0 : completedCount / items.length;

  String get subtitle =>
      '${items.length} Ürün • ${completedCount == items.length && items.isNotEmpty ? 'Tamamlandı' : 'Son güncelleme az önce'}';
}

/// Uygulama kabuğu: sekmeler, FAB ve alt navigasyon.
class PreviewShell extends StatefulWidget {
  const PreviewShell({super.key});

  @override
  State<PreviewShell> createState() => _PreviewShellState();
}

class _PreviewShellState extends State<PreviewShell> {
  AppTab _tab = AppTab.home;
  int _nextId = 100;

  late final List<_DemoList> _lists = [
    _DemoList(
      id: '1',
      title: 'Haftalık Market',
      items: [
        const ItemRowData(
          id: 'i1',
          name: 'Süt',
          category: 'Market',
          quantityLabel: '2 Litre',
          priceLabel: 'Tahmini 45 TL',
          noteAuthorInitial: 'A',
          noteText: 'Ayşe tarafından eklendi',
        ),
        const ItemRowData(
          id: 'i2',
          name: 'Yumurta',
          category: 'Market',
          quantityLabel: "15'li Paket",
          priceLabel: 'Tahmini 60 TL',
        ),
        const ItemRowData(
          id: 'i3',
          name: 'Domates',
          category: 'Manav',
          quantityLabel: '1.5 Kg',
          priceLabel: 'Tahmini 35 TL',
        ),
        const ItemRowData(
          id: 'i4',
          name: 'Tam Buğday Ekmeği',
          category: 'Fırın',
          quantityLabel: '2 Adet',
          priceLabel: 'Tahmini 20 TL',
          noteAuthorInitial: 'M',
          noteText: 'Mehmet not ekledi: "Taze olsun"',
        ),
        const ItemRowData(
          id: 'i5',
          name: 'Elma',
          category: 'Manav',
          quantityLabel: '1 Kg',
          priceLabel: '42 TL',
          isCompleted: true,
        ),
        const ItemRowData(
          id: 'i6',
          name: 'Makarna',
          category: 'Market',
          quantityLabel: '3 Paket',
          priceLabel: '54 TL',
          isCompleted: true,
        ),
      ],
    ),
    _DemoList(
      id: '2',
      title: 'Piknik Hazırlığı 🧺',
      items: [
        const ItemRowData(
          id: 'p1',
          name: 'Zeytin',
          category: 'Market',
          quantityLabel: '500 g',
          isCompleted: true,
        ),
        const ItemRowData(
          id: 'p2',
          name: 'Beyaz Peynir',
          category: 'Market',
          quantityLabel: '400 g',
          isCompleted: true,
        ),
      ],
    ),
  ];

  static const _members = [
    AvatarData(initials: 'AY', label: 'Ayşe'),
    AvatarData(initials: 'ME', label: 'Mehmet'),
    AvatarData(initials: 'CA', label: 'Can'),
    AvatarData(initials: 'EM', label: 'Emre'),
  ];

  void _snack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // ------------------------------------------------------------ etkileşimler

  void _toggleItem(String listId, String itemId, bool completed) {
    setState(() {
      final list = _lists.firstWhere((item) => item.id == listId);
      final index = list.items.indexWhere((item) => item.id == itemId);
      if (index != -1) {
        list.items[index] = list.items[index].copyWith(isCompleted: completed);
      }
    });
  }

  void _deleteItem(String listId, String itemId) {
    setState(() {
      _lists
          .firstWhere((item) => item.id == listId)
          .items
          .removeWhere((item) => item.id == itemId);
    });
    _snack('Ürün silindi');
  }

  void _clearCompleted(String listId) {
    setState(() {
      _lists
          .firstWhere((item) => item.id == listId)
          .items
          .removeWhere((item) => item.isCompleted);
    });
    _snack('Tamamlananlar temizlendi');
  }

  Future<void> _addProduct(String listId) async {
    final product = await AddProductSheet.show(context);
    if (product == null || !mounted) {
      return;
    }
    setState(() {
      _lists
          .firstWhere((item) => item.id == listId)
          .items
          .insert(
            0,
            ItemRowData(
              id: 'new${_nextId++}',
              name: product.name,
              category: product.category,
              quantityLabel: '${product.quantity} ${product.unit}',
              priceLabel: product.price == null
                  ? null
                  : 'Tahmini ${product.price!.toStringAsFixed(0)} TL',
              noteText: product.note,
              noteAuthorInitial: 'U',
            ),
          );
    });
    _snack('${product.name} eklendi');
  }

  Future<void> _openList(String listId) async {
    final list = _lists.firstWhere((item) => item.id == listId);

    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => _ListDetailPage(
          list: list,
          onToggleItem: ({required id, required completed}) =>
              _toggleItem(list.id, id, completed),
          onDeleteItem: (id) => _deleteItem(list.id, id),
          onClearCompleted: () => _clearCompleted(list.id),
          onAddProduct: () => _addProduct(list.id),
          onNotice: _snack,
        ),
      ),
    );

    // Detayda yapılan değişiklikler ana ekrandaki kartlara da yansır.
    if (mounted) {
      setState(() {});
    }
  }

  // ------------------------------------------------------------------- çizim

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: DesignTokens.durationMedium,
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.03),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ),
        child: KeyedSubtree(
          key: ValueKey(_tab),
          child: switch (_tab) {
            AppTab.home => _dashboard(),
            AppTab.lists => _allLists(),
            AppTab.activity => _activity(),
            AppTab.shared => _activity(shareTab: true),
            AppTab.profile => const _ProfilePlaceholder(),
          },
        ),
      ),
      floatingActionButton: _tab == AppTab.home || _tab == AppTab.lists
          ? FloatingActionButton(
              onPressed: () => _addProduct(_lists.first.id),
              child: const Icon(Icons.add, size: DesignTokens.iconLarge),
            )
          : null,
      bottomNavigationBar: AppBottomNav(
        current: _tab,
        onSelect: (tab) => setState(() => _tab = tab),
      ),
    );
  }

  Widget _dashboard() {
    return DashboardView(
      userName: 'Uğur',
      userAvatar: const AvatarData(initials: 'UH', label: 'Uğur Hamamcı'),
      lists: [
        for (final list in _lists)
          DashboardListItem(
            id: list.id,
            title: list.title,
            subtitle: list.subtitle,
            progress: list.progress,
            members: _members.take(list.id == '1' ? 4 : 1).toList(),
          ),
      ],
      suggestion: const DashboardSuggestion(
        title: 'Akşam Yemeği: Lazanya',
        subtitle: '5 eksik ürün • Tarif bazlı liste',
        actionLabel: 'Tümünü listeye ekle →',
      ),
      onSearchTap: () => _snack('Arama ekranı yakında'),
      onProfileTap: () => setState(() => _tab = AppTab.profile),
      onNewList: () => _snack('Yeni liste oluşturma yakında'),
      onJoinWithQr: () => setState(() => _tab = AppTab.shared),
      onGenerateWithAi: () =>
          _snack('AI liste üretimi servis katmanında hazır'),
      onInvite: () => setState(() => _tab = AppTab.shared),
      onSeeAllLists: () => setState(() => _tab = AppTab.lists),
      onListTap: _openList,
      onSuggestionAccept: () => _snack('5 ürün listeye eklenecek'),
    );
  }

  Widget _allLists() {
    final theme = Theme.of(context);

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          DesignTokens.containerMargin,
          DesignTokens.space6,
          DesignTokens.containerMargin,
          DesignTokens.space10 * 3,
        ),
        children: [
          Text('Listelerim', style: theme.textTheme.headlineMedium),
          const SizedBox(height: DesignTokens.space4),
          for (final list in _lists)
            Padding(
              padding: const EdgeInsets.only(bottom: DesignTokens.gutter),
              child: ListTile(
                onTap: () => _openList(list.id),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    DesignTokens.radius2xl,
                  ),
                  side: BorderSide(color: theme.colorScheme.outlineVariant),
                ),
                tileColor: theme.colorScheme.surfaceContainerLowest,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: DesignTokens.space5,
                  vertical: DesignTokens.space2,
                ),
                title: Text(list.title, style: theme.textTheme.titleLarge),
                subtitle: Text(list.subtitle),
                trailing: Icon(
                  Icons.chevron_right,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _activity({bool shareTab = false}) {
    return ActivityShareView(
      // Share sekmesiyle açılması gerektiğinde anahtar değişir, böylece
      // widget baştan kurulur ve doğru sekme seçili gelir.
      key: ValueKey('activity-$shareTab'),
      members: _members,
      listName: _lists.first.title,
      entries: const [
        ActivityEntry(
          actorInitials: 'AH',
          actorName: 'Ahmet',
          action: 'aldı:',
          target: 'Yulaf Sütü',
          meta: '2 dk önce • Haftalık Market',
          icon: Icons.shopping_basket,
          iconColor: DesignTokens.secondary,
        ),
        ActivityEntry(
          actorInitials: 'AY',
          actorName: 'Ayşe',
          action: 'ekledi:',
          target: 'Makarna Sosu',
          meta: '5 dk önce • Akşam Yemeği',
          icon: Icons.add_circle,
          iconColor: DesignTokens.primaryContainer,
        ),
        ActivityEntry(
          actorInitials: 'ME',
          actorName: 'Mehmet',
          action: 'yeniden adlandırdı:',
          target: 'BBQ Partisi',
          meta: '45 dk önce',
          icon: Icons.edit,
          iconColor: DesignTokens.tertiaryContainer,
        ),
      ],
      onMarkAllRead: () => _snack('Tümü okundu işaretlendi'),
      onCopyLink: () => _snack('Davet bağlantısı kopyalandı'),
      onShareWhatsApp: () => _snack('WhatsApp ile paylaşım yakında'),
      onShareSms: () => _snack('Mesajla paylaşım yakında'),
    );
  }
}

/// Liste detay sayfası.
///
/// Kendi `setState`'ini çağırır: ürün işaretlendiğinde ya da silindiğinde
/// hem paylaşılan veri güncellenir hem de bu sayfa yeniden çizilir.
class _ListDetailPage extends StatefulWidget {
  const _ListDetailPage({
    required this.list,
    required this.onToggleItem,
    required this.onDeleteItem,
    required this.onClearCompleted,
    required this.onAddProduct,
    required this.onNotice,
  });

  final _DemoList list;
  final void Function({required String id, required bool completed})
  onToggleItem;
  final ValueChanged<String> onDeleteItem;
  final VoidCallback onClearCompleted;
  final Future<void> Function() onAddProduct;
  final ValueChanged<String> onNotice;

  @override
  State<_ListDetailPage> createState() => _ListDetailPageState();
}

class _ListDetailPageState extends State<_ListDetailPage> {
  Future<void> _add() async {
    await widget.onAddProduct();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListDetailView(
        title: widget.list.title,
        items: widget.list.items,
        onBack: () => Navigator.of(context).pop(),
        onSearch: () => widget.onNotice('Liste içinde arama yakında'),
        onMore: () => widget.onNotice('Liste ayarları yakında'),
        onToggleItem: ({required id, required completed}) {
          widget.onToggleItem(id: id, completed: completed);
          setState(() {});
        },
        onDeleteItem: (id) {
          widget.onDeleteItem(id);
          setState(() {});
        },
        onClearCompleted: () {
          widget.onClearCompleted();
          setState(() {});
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        child: const Icon(Icons.add, size: DesignTokens.iconLarge),
      ),
    );
  }
}

class _ProfilePlaceholder extends StatelessWidget {
  const _ProfilePlaceholder();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(DesignTokens.containerMargin),
        children: [
          const SizedBox(height: DesignTokens.space6),
          const Center(
            child: MemberAvatar(
              data: AvatarData(initials: 'UH', label: 'Uğur Hamamcı'),
              size: 96,
            ),
          ),
          const SizedBox(height: DesignTokens.space4),
          Center(
            child: Text('Uğur Hamamcı', style: theme.textTheme.headlineSmall),
          ),
          Center(
            child: Text(
              'ugurhamamcii@gmail.com',
              style: theme.textTheme.bodySmall,
            ),
          ),
          const SizedBox(height: DesignTokens.space8),
          for (final item in const [
            ('Hesap', Icons.person_outline),
            ('Bildirimler', Icons.notifications_none),
            ('Görünüm', Icons.palette_outlined),
            ('Dil', Icons.language),
            ('Gizlilik', Icons.lock_outline),
            ('Premium', Icons.workspace_premium_outlined),
          ])
            ListTile(
              leading: Icon(item.$2, color: theme.colorScheme.primary),
              title: Text(item.$1),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${item.$1} ekranı yakında')),
              ),
            ),
        ],
      ),
    );
  }
}
