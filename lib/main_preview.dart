import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import 'package:smartlist/core/errors/app_exception.dart';
import 'package:smartlist/core/theme/app_theme.dart';
import 'package:smartlist/core/theme/design_tokens.dart';
import 'package:smartlist/core/widgets/avatar_stack.dart';
import 'package:smartlist/features/barcode/data/product_lookup_service.dart';
import 'package:smartlist/features/barcode/presentation/screens/scanner_screen.dart';
import 'package:smartlist/features/home/presentation/screens/dashboard_view.dart';
import 'package:smartlist/features/home/presentation/screens/search_screen.dart';
import 'package:smartlist/features/notifications/presentation/screens/activity_share_view.dart';
import 'package:smartlist/features/products/presentation/widgets/add_product_sheet.dart';
import 'package:smartlist/features/profile/presentation/screens/profile_view.dart';
import 'package:smartlist/features/settings/presentation/screens/settings_screen.dart';
import 'package:smartlist/features/shared/presentation/screens/splash_screen.dart';
import 'package:smartlist/features/shared/presentation/widgets/app_bottom_nav.dart';
import 'package:smartlist/features/shopping_lists/presentation/screens/list_detail_view.dart';
import 'package:smartlist/features/shopping_lists/presentation/widgets/create_list_sheet.dart';
import 'package:smartlist/features/shopping_lists/presentation/widgets/shopping_item_tile.dart';
import 'package:smartlist/features/statistics/presentation/screens/statistics_screen.dart';
import 'package:smartlist/features/subscription/presentation/widgets/premium_sheet.dart';

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

class PreviewApp extends StatefulWidget {
  const PreviewApp({super.key});

  @override
  State<PreviewApp> createState() => _PreviewAppState();
}

class _PreviewAppState extends State<PreviewApp> {
  /// Ayarlar ekranındaki tema seçimi burada tutulur; `MaterialApp` bu
  /// durumun üstünde olduğu için seçim anında tüm uygulamaya uygulanır.
  AppSettings _settings = const AppSettings();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartList — Tasarım Önizlemesi',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: _settings.themeMode,
      home: PreviewRoot(
        settings: _settings,
        onSettingsChanged: (value) => setState(() => _settings = value),
      ),
    );
  }
}

/// Açılış ekranını gösterir, sonra uygulama kabuğuna geçer.
class PreviewRoot extends StatefulWidget {
  const PreviewRoot({
    required this.settings,
    required this.onSettingsChanged,
    super.key,
  });

  final AppSettings settings;
  final ValueChanged<AppSettings> onSettingsChanged;

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
                  ? PreviewShell(
                      key: const ValueKey('shell'),
                      settings: widget.settings,
                      onSettingsChanged: widget.onSettingsChanged,
                    )
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

  /// Davet kodu. Gerçek uygulamada sunucu üretir; burada liste kimliğinden
  /// türetiliyor ki QR kodu ve bağlantı her çizimde aynı kalsın.
  String get inviteCode => id.hashCode
      .abs()
      .toRadixString(36)
      .toUpperCase()
      .padLeft(6, '0')
      .substring(0, 6);

  int get completedCount => items.where((item) => item.isCompleted).length;

  double get progress => items.isEmpty ? 0 : completedCount / items.length;

  String get subtitle =>
      '${items.length} Ürün • ${completedCount == items.length && items.isNotEmpty ? 'Tamamlandı' : 'Son güncelleme az önce'}';
}

/// Uygulama kabuğu: sekmeler, FAB ve alt navigasyon.
class PreviewShell extends StatefulWidget {
  const PreviewShell({
    required this.settings,
    required this.onSettingsChanged,
    super.key,
  });

  final AppSettings settings;
  final ValueChanged<AppSettings> onSettingsChanged;

  @override
  State<PreviewShell> createState() => _PreviewShellState();
}

class _PreviewShellState extends State<PreviewShell> {
  AppTab _tab = AppTab.home;
  int _nextId = 100;

  /// Barkod sorgusu için gerçek HTTP istemcisi. Önizlemede bile gerçek API
  /// kullanılıyor — Open Food Facts anahtar istemediği için buna gerek yok.
  late final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );
  late final ProductLookupService _lookupService = ProductLookupService(
    dio: _dio,
  );

  final List<String> _recentQueries = [];

  @override
  void dispose() {
    _dio.close();
    super.dispose();
  }

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

  /// Barkod tarar ve Open Food Facts üzerinden ürünü çözer.
  ///
  /// Bulunamazsa `null` döner ve kullanıcı adı elle yazar — veritabanında
  /// olmayan ürün normaldir, hata değildir.
  Future<ScannedProduct?> _scanAndLookup() async {
    final scan = await ScannerScreen.open(context);
    if (scan == null || !mounted) {
      return null;
    }

    _snack('Barkod okundu: ${scan.code}');

    try {
      final info = await _lookupService.lookup(scan.code);
      if (!mounted) {
        return null;
      }
      if (info == null) {
        _snack('Ürün veritabanında bulunamadı, adını yazabilirsiniz');
        return ScannedProduct(name: '', barcode: scan.code);
      }
      return ScannedProduct(
        name: info.displayName,
        quantity: info.quantity,
        barcode: info.barcode,
      );
    } on AppException catch (error) {
      if (mounted) {
        _snack('Ürün sorgulanamadı (${error.code})');
      }
      return ScannedProduct(name: '', barcode: scan.code);
    }
  }

  /// QR okutup listeye katılma akışını başlatır.
  Future<void> _joinByQr() async {
    final scan = await ScannerScreen.open(
      context,
      purpose: ScanPurpose.joinList,
    );
    if (scan == null || !mounted) {
      return;
    }
    // Davetin karşılığını bulmak sunucu tarafı gerektiriyor; kod okundu ve
    // akış buraya kadar çalışıyor.
    _snack('Davet kodu alındı: ${scan.code}');
  }

  /// Yeni liste oluşturur.
  Future<void> _createList() async {
    final created = await CreateListSheet.show(context);
    if (created == null || !mounted) {
      return;
    }
    final id = 'list${_nextId++}';
    setState(() {
      _lists.insert(
        0,
        _DemoList(
          id: id,
          title: '${created.emoji} ${created.title}',
          items: [],
        ),
      );
    });
    _snack('${created.title} oluşturuldu');
    await _openList(id);
  }

  /// Liste ve ürünler arasında arama.
  Future<void> _openSearch() {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => SearchScreen(
          recentQueries: _recentQueries,
          onOpenList: _openList,
          onSearch: (query) {
            final lower = query.toLowerCase();
            if (!_recentQueries.contains(query)) {
              _recentQueries.insert(0, query);
              if (_recentQueries.length > 5) {
                _recentQueries.removeLast();
              }
            }
            return [
              for (final list in _lists)
                if (list.title.toLowerCase().contains(lower))
                  SearchHit(
                    listId: list.id,
                    title: list.title,
                    subtitle: list.subtitle,
                    isList: true,
                  ),
              for (final list in _lists)
                for (final item in list.items)
                  if (item.name.toLowerCase().contains(lower))
                    SearchHit(
                      listId: list.id,
                      title: item.name,
                      subtitle: '${list.title} • ${item.quantityLabel}',
                      isList: false,
                    ),
            ];
          },
        ),
      ),
    );
  }

  Future<void> _addProduct(String listId) async {
    final product = await AddProductSheet.show(
      context,
      onScanBarcode: _scanAndLookup,
    );
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

  // ------------------------------------------------------------------ davet

  String get _inviteLink => 'smartlist.app/j/${_lists.first.inviteCode}';

  Future<void> _copyInviteLink() async {
    await Clipboard.setData(ClipboardData(text: 'https://$_inviteLink'));
    if (mounted) {
      _snack('Davet bağlantısı kopyalandı');
    }
  }

  /// İşletim sisteminin paylaşım sayfasını açar (WhatsApp, mesaj, e-posta…).
  Future<void> _shareInvite() async {
    final list = _lists.first;
    try {
      await SharePlus.instance.share(
        ShareParams(
          subject: '${list.title} listesine katıl',
          text:
              '${list.title} listeme SmartList üzerinden katıl:\n'
              'https://$_inviteLink',
        ),
      );
    } on Exception catch (error) {
      // Masaüstü tarayıcıda paylaşım sayfası olmayabiliyor; kullanıcıyı
      // boşta bırakmamak için bağlantıyı panoya alıyoruz.
      await Clipboard.setData(ClipboardData(text: 'https://$_inviteLink'));
      if (mounted) {
        _snack('Paylaşım açılamadı ($error), bağlantı kopyalandı');
      }
    }
  }

  // --------------------------------------------------------- profil altı akış

  Future<void> _openStatistics() {
    final allItems = _lists.expand((list) => list.items).toList();

    // Fiyat etiketleri "Tahmini 45 TL" gibi metin; sayıyı ayıklayıp
    // topluyoruz. Gerçek modelde `estimatedPrice` sayısal alandır.
    double amountOf(ItemRowData item) {
      final label = item.priceLabel;
      if (label == null) {
        return 0;
      }
      final digits = RegExp(r'\d+([.,]\d+)?').firstMatch(label)?.group(0);
      return double.tryParse(digits?.replaceAll(',', '.') ?? '') ?? 0;
    }

    final byCategory = <String, int>{};
    for (final item in allItems) {
      byCategory.update(
        item.category,
        (count) => count + 1,
        ifAbsent: () => 1,
      );
    }

    const palette = DesignTokens.listLabelPalette;
    final categories = <CategoryShare>[];
    var index = 0;
    for (final entry in byCategory.entries) {
      categories.add(
        CategoryShare(
          category: entry.key,
          itemCount: entry.value,
          color: palette[index % palette.length],
        ),
      );
      index++;
    }

    final total = allItems.fold<double>(0, (sum, item) => sum + amountOf(item));

    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => StatisticsScreen(
          totalItems: allItems.length,
          completedItems: allItems.where((item) => item.isCompleted).length,
          activeLists: _lists.length,
          totalSpend: total,
          currency: widget.settings.currency,
          categories: categories,
          // Haftalık seri örnek veridir; gerçek uygulamada satın alma
          // kayıtlarından türetilir.
          weeklySpend: [
            WeeklySpend(label: 'Pzt', amount: total * 0.12),
            WeeklySpend(label: 'Sal', amount: total * 0.08),
            WeeklySpend(label: 'Çar', amount: total * 0.22),
            WeeklySpend(label: 'Per', amount: total * 0.10),
            WeeklySpend(label: 'Cum', amount: total * 0.28),
            WeeklySpend(label: 'Cmt', amount: total * 0.15),
            WeeklySpend(label: 'Paz', amount: total * 0.05),
          ],
        ),
      ),
    );
  }

  Future<void> _openSettings() {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => SettingsScreen(
          settings: widget.settings,
          onChanged: widget.onSettingsChanged,
          versionLabel: 'SmartList 1.0.0 (önizleme)',
        ),
      ),
    );
  }

  Future<void> _openPremium() => PremiumSheet.show(context);

  Future<void> _confirmSignOut() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Çıkış yapılsın mı?'),
        content: const Text(
          'Listeleriniz hesabınızda kalır, tekrar giriş yaptığınızda '
          'kaldığınız yerden devam edersiniz.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Vazgeç'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Çıkış yap'),
          ),
        ],
      ),
    );

    if ((confirmed ?? false) && mounted) {
      _snack('Oturum kapatma Firebase Auth katmanına bağlanır');
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
            AppTab.profile => _profile(),
          },
        ),
      ),
      // Ana ekranda FAB ürün ekler, Listeler sekmesinde yeni liste açar —
      // her sekmede en olası eylemi yapıyor.
      floatingActionButton: switch (_tab) {
        AppTab.home => FloatingActionButton(
          onPressed: () => _addProduct(_lists.first.id),
          child: const Icon(Icons.add, size: DesignTokens.iconLarge),
        ),
        AppTab.lists => FloatingActionButton(
          onPressed: _createList,
          child: const Icon(Icons.add, size: DesignTokens.iconLarge),
        ),
        AppTab.activity || AppTab.shared || AppTab.profile => null,
      },
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
      onSearchTap: _openSearch,
      onProfileTap: () => setState(() => _tab = AppTab.profile),
      onNewList: _createList,
      onJoinWithQr: _joinByQr,
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
      inviteLink: _inviteLink,
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
      onCopyLink: _copyInviteLink,
      onShareWhatsApp: _shareInvite,
      onShareSms: _shareInvite,
    );
  }

  Widget _profile() {
    final allItems = _lists.expand((list) => list.items).toList();
    final completed = allItems.where((item) => item.isCompleted).length;

    return ProfileView(
      user: const AvatarData(initials: 'UH', label: 'Uğur Hamamcı'),
      name: 'Uğur Hamamcı',
      email: 'ugurhamamcii@gmail.com',
      isPremium: false,
      versionLabel: 'SmartList 1.0.0 (önizleme)',
      stats: [
        ProfileStat(
          value: '${_lists.length}',
          label: 'Liste',
          icon: Icons.format_list_bulleted,
          color: DesignTokens.primary,
        ),
        ProfileStat(
          value: '$completed',
          label: 'Alınan ürün',
          icon: Icons.check_circle_outline,
          color: DesignTokens.secondary,
        ),
        ProfileStat(
          value: '${_members.length}',
          label: 'Paylaşılan kişi',
          icon: Icons.group_outlined,
          color: DesignTokens.tertiary,
        ),
      ],
      onEditProfile: () => _snack('Profil düzenleme oturum katmanına bağlanır'),
      onOpenStatistics: _openStatistics,
      onOpenSettings: _openSettings,
      onOpenPremium: _openPremium,
      onSignOut: _confirmSignOut,
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
