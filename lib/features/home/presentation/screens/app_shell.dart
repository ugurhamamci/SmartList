import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import 'package:smartlist/core/errors/app_exception.dart';
import 'package:smartlist/core/errors/app_exception_messages.dart';
import 'package:smartlist/core/theme/design_tokens.dart';
import 'package:smartlist/core/theme/spacing_theme.dart';
import 'package:smartlist/core/widgets/avatar_stack.dart';
import 'package:smartlist/features/ai/presentation/widgets/ai_generate_sheet.dart';
import 'package:smartlist/features/auth/auth_providers.dart';
import 'package:smartlist/features/barcode/data/product_lookup_service.dart';
import 'package:smartlist/features/barcode/presentation/screens/scanner_screen.dart';
import 'package:smartlist/features/home/presentation/screens/dashboard_view.dart';
import 'package:smartlist/features/home/presentation/screens/search_screen.dart';
import 'package:smartlist/features/notifications/presentation/screens/activity_share_view.dart';
import 'package:smartlist/features/products/presentation/widgets/add_product_sheet.dart';
import 'package:smartlist/features/profile/presentation/screens/profile_view.dart';
import 'package:smartlist/features/settings/presentation/screens/settings_screen.dart';
import 'package:smartlist/features/shared/presentation/widgets/app_bottom_nav.dart';
import 'package:smartlist/features/shopping_lists/data/lists_repository.dart';
import 'package:smartlist/features/shopping_lists/list_providers.dart';
import 'package:smartlist/features/shopping_lists/presentation/screens/list_detail_view.dart';
import 'package:smartlist/features/shopping_lists/presentation/widgets/create_list_sheet.dart';
import 'package:smartlist/features/shopping_lists/presentation/widgets/edit_item_sheet.dart';
import 'package:smartlist/features/shopping_lists/presentation/widgets/shopping_item_tile.dart';
import 'package:smartlist/features/statistics/presentation/screens/statistics_screen.dart';
import 'package:smartlist/features/subscription/presentation/widgets/premium_sheet.dart';
import 'package:smartlist/features/voice/presentation/widgets/voice_input_sheet.dart';

/// Barkod sorgusu için HTTP istemcisi.
final _lookupDioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );
  ref.onDispose(dio.close);
  return dio;
});

final _productLookupProvider = Provider<ProductLookupService>((ref) {
  return ProductLookupService(dio: ref.watch(_lookupDioProvider));
});

/// Giriş yapıldıktan sonraki uygulama kabuğu.
///
/// Veri Supabase'den geliyor. Liste sayaçları ve üyelik veritabanı
/// trigger'ları tarafından tutulduğu için burada yeniden hesaplanmıyor;
/// ürünler ise satır düzeyinde canlı akışla geliyor, yani bir telefonda
/// eklenen ürün diğerinde anında görünüyor.
class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  AppTab _tab = AppTab.home;
  AppSettings _settings = const AppSettings();
  final List<String> _recentQueries = [];

  ListsRepository get _repository => ref.read(listsRepositoryProvider);

  void _snack(String message) {
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  /// Depo çağrılarını tek yerden sarar: hata kullanıcıya anlaşılır bir cümleyle
  /// gösteriliyor, her çağrı yerinde try/catch tekrarlanmıyor.
  Future<T?> _run<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on AppException catch (error) {
      _snack(error.userMessage);
      return null;
    }
  }

  // ------------------------------------------------------------- eylemler

  Future<void> _createList() async {
    final created = await CreateListSheet.show(context);
    if (created == null) {
      return;
    }

    final id = await _run(
      () => _repository.createList(
        title: created.title,
        emoji: created.emoji,
        colorHex: created.colorHex,
      ),
    );
    if (id == null) {
      return;
    }

    _snack('${created.title} oluşturuldu');
    await _openList(id);
  }

  Future<void> _joinByQr() async {
    final scan = await ScannerScreen.open(
      context,
      purpose: ScanPurpose.joinList,
    );
    if (scan == null) {
      return;
    }

    // QR içeriği tam bir adres olabiliyor (smartlist.app/j/KOD); koda
    // indirgiyoruz.
    final code = scan.code.split('/').last.trim();
    final listId = await _run(() => _repository.joinByCode(code));
    if (listId == null) {
      return;
    }

    _snack('Listeye katıldınız');
    await _openList(listId);
  }

  /// Yapay zekâ ile liste üretir: onaylanan ürünler yeni bir listeye yazılır.
  ///
  /// Ürünler tek tek eklenmek yerine toplu yazılıyor; 15 ürün için 15 ayrı
  /// istek atmak mobil bağlantıda gözle görülür bir gecikme demek.
  Future<void> _generateWithAi() async {
    final picked = await AiGenerateSheet.show(context);
    if (picked == null) {
      return;
    }

    final listId = await _run(
      () => _repository.createList(
        title: picked.title,
        emoji: '🛒',
        colorHex: 'FF3525CD',
      ),
    );
    if (listId == null) {
      return;
    }

    await _run(
      () => _repository.addItems(
        listId: listId,
        items: [
          for (final item in picked.items)
            (
              name: item.name,
              quantity: item.quantity,
              unit: item.unit.wire,
              price: item.estimatedPrice,
              notes: item.notes,
            ),
        ],
        source: 'ai',
      ),
    );

    _snack('${picked.items.length} ürün eklendi');
    await _openList(listId);
  }

  Future<void> _openList(String listId) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => _ListDetailPage(listId: listId)),
    );
  }

  Future<void> _openSearch() {
    final lists = ref.read(listsProvider).value ?? const <ListSummary>[];

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
            // Ürün araması sunucu tarafı bir sorgu gerektiriyor (trigram
            // indeksleri bunun için hazır); şimdilik liste adında arıyoruz.
            return [
              for (final list in lists)
                if (list.title.toLowerCase().contains(lower))
                  SearchHit(
                    listId: list.id,
                    title: list.title,
                    subtitle: '${list.itemCount} ürün',
                    isList: true,
                  ),
            ];
          },
        ),
      ),
    );
  }

  Future<void> _shareList(String listId, {required bool copyOnly}) async {
    final code = await _run(() => _repository.ensureShareCode(listId));
    if (code == null) {
      return;
    }

    final link = 'https://smartlist.app/j/$code';

    if (copyOnly) {
      await Clipboard.setData(ClipboardData(text: link));
      _snack('Davet bağlantısı kopyalandı');
      return;
    }

    try {
      await SharePlus.instance.share(
        ShareParams(subject: 'SmartList listeme katıl', text: link),
      );
    } on Exception {
      // Masaüstü tarayıcıda paylaşım sayfası olmayabiliyor.
      await Clipboard.setData(ClipboardData(text: link));
      _snack('Paylaşım açılamadı, bağlantı kopyalandı');
    }
  }

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

    if (!(confirmed ?? false)) {
      return;
    }
    // Oturum kapandığında AuthGate giriş ekranını gösteriyor.
    await ref.read(authServiceProvider).signOut();
  }

  // ---------------------------------------------------------------- çizim

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: DesignTokens.durationMedium,
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
      floatingActionButton: switch (_tab) {
        AppTab.home || AppTab.lists => FloatingActionButton(
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

  String get _displayName {
    final user = ref.watch(authStateProvider).value?.user;
    final name = (user?.userMetadata?['display_name'] as String?)?.trim();
    if (name != null && name.isNotEmpty) {
      return name;
    }
    final email = user?.email ?? '';
    return email.isEmpty ? 'SmartList' : email.split('@').first;
  }

  Widget _dashboard() {
    final lists = ref.watch(listsProvider);

    return lists.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => _ErrorState(
        message: error is AppException
            ? error.userMessage
            : 'Listeler okunamadı.',
        onRetry: () => ref.invalidate(listsProvider),
      ),
      data: (rows) => RefreshIndicator(
        onRefresh: () async => ref.invalidate(listsProvider),
        child: DashboardView(
          userName: _displayName,
          userAvatar: AvatarData(
            initials: _initialsOf(_displayName),
            label: _displayName,
          ),
          lists: [
            for (final list in rows)
              DashboardListItem(
                id: list.id,
                title: '${list.emoji} ${list.title}',
                subtitle: _subtitleFor(list),
                progress: list.progress,
                // Üye avatarları liste başına ayrı bir okuma gerektiriyor;
                // ana ekranda üye sayısı yeterli ve o zaten sayaçta. Bu yüzden
                // `members` öntanımlı boş bırakılıyor.
              ),
          ],
          onSearchTap: _openSearch,
          onProfileTap: () => setState(() => _tab = AppTab.profile),
          onNewList: _createList,
          onJoinWithQr: _joinByQr,
          onGenerateWithAi: _generateWithAi,
          onInvite: rows.isEmpty
              ? null
              : () => _shareList(rows.first.id, copyOnly: false),
          onSeeAllLists: () => setState(() => _tab = AppTab.lists),
          onListTap: _openList,
        ),
      ),
    );
  }

  String _subtitleFor(ListSummary list) {
    if (list.itemCount == 0) {
      return 'Henüz ürün yok';
    }
    if (list.isCompleted) {
      return '${list.itemCount} ürün • Tamamlandı';
    }
    final remaining = list.itemCount - list.completedItemCount;
    return '${list.itemCount} ürün • $remaining kaldı';
  }

  Widget _allLists() {
    final theme = Theme.of(context);
    final spacing = context.spacing;
    final lists = ref.watch(listsProvider);

    return lists.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => _ErrorState(
        message: error is AppException
            ? error.userMessage
            : 'Listeler okunamadı.',
        onRetry: () => ref.invalidate(listsProvider),
      ),
      data: (rows) => SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: () async => ref.invalidate(listsProvider),
          child: ListView(
            padding: EdgeInsets.fromLTRB(
              spacing.containerMargin,
              DesignTokens.space6,
              spacing.containerMargin,
              DesignTokens.space10 * 3,
            ),
            children: [
              Text('Listelerim', style: theme.textTheme.headlineMedium),
              SizedBox(height: spacing.gutter),

              if (rows.isEmpty)
                _EmptyLists(onCreate: _createList, onJoin: _joinByQr)
              else
                for (final list in rows)
                  Padding(
                    padding: EdgeInsets.only(bottom: spacing.stackGap),
                    // Sağa kaydırma düzenler, sola kaydırma siler. İkisi de
                    // `confirmDismiss` üzerinden geçip `false` dönüyor: satırı
                    // kaydırma kaldırmıyor, listeyi sunucudan gelen yeni veri
                    // tazeliyor. Aksi hâlde silme iptal edilse bile satır
                    // ekrandan kaybolurdu.
                    child: Dismissible(
                      key: ValueKey(list.id),
                      background: _SwipeAction(
                        alignment: Alignment.centerLeft,
                        icon: Icons.edit,
                        label: 'Düzenle',
                        color: theme.colorScheme.primaryContainer,
                        textColor: theme.colorScheme.onPrimaryContainer,
                      ),
                      secondaryBackground: _SwipeAction(
                        alignment: Alignment.centerRight,
                        icon: Icons.delete_outline,
                        label: 'Sil',
                        color: theme.colorScheme.errorContainer,
                        textColor: theme.colorScheme.onErrorContainer,
                      ),
                      confirmDismiss: (direction) =>
                          direction == DismissDirection.startToEnd
                          ? _renameList(list)
                          : _confirmDeleteList(list),
                      child: ListTile(
                        onTap: () => _openList(list.id),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            DesignTokens.radius2xl,
                          ),
                          side: BorderSide(
                            color: theme.colorScheme.outlineVariant,
                          ),
                        ),
                        tileColor: theme.colorScheme.surfaceContainerLowest,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: DesignTokens.space5,
                          vertical: DesignTokens.space2,
                        ),
                        leading: Text(
                          list.emoji,
                          style: const TextStyle(fontSize: 24),
                        ),
                        title: Text(
                          list.title,
                          style: theme.textTheme.titleLarge,
                        ),
                        subtitle: Text(_subtitleFor(list)),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  /// Liste adını ve emojisini düzenler.
  ///
  /// `false` dönüyor: kaydırma yalnızca eylemi açtı, satır listede kalmalı.
  Future<bool> _renameList(ListSummary list) async {
    final edited = await RenameListSheet.show(
      context,
      title: list.title,
      emoji: list.emoji,
    );
    if (edited == null) {
      return false;
    }

    await _run(
      () => _repository.updateList(
        listId: list.id,
        title: edited.title,
        emoji: edited.emoji,
      ),
    );
    return false;
  }

  /// Silme onayı ister.
  ///
  /// Liste paylaşılmışsa bunu söylüyor: kullanıcı kendi kopyasını değil,
  /// herkesin gördüğü listeyi siliyor ve bunu bilerek yapması gerekiyor.
  Future<bool> _confirmDeleteList(ListSummary list) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${list.title} silinsin mi?'),
        content: Text(
          list.memberCount > 1
              ? 'Bu liste ${list.memberCount} kişiyle paylaşılıyor; '
                    'hepsinden kaldırılacak.'
              : '${list.itemCount} ürün listeyle birlikte kaldırılacak.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Vazgeç'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Sil'),
          ),
        ],
      ),
    );

    if (!(confirmed ?? false)) {
      return false;
    }

    await _run(() => _repository.deleteList(list.id));
    if (mounted) {
      _snack('${list.title} silindi');
    }
    return false;
  }

  Widget _activity({bool shareTab = false}) {
    final rows = ref.watch(listsProvider).value ?? const <ListSummary>[];
    final first = rows.isEmpty ? null : rows.first;

    // QR'a gomulen kod listeye ozel. Kod henuz uretilmediyse yer tutucu
    // gosteriyoruz; uretildiginde widget yeniden ciziliyor ve QR taranabilir
    // hale geliyor.
    final code = first == null
        ? null
        : ref.watch(listShareCodeProvider(first.id)).value;

    return ActivityShareView(
      key: ValueKey('activity-$shareTab'),
      members: const [],
      listName: first?.title ?? 'Liste yok',
      inviteLink: code == null ? 'smartlist.app' : 'smartlist.app/j/$code',
      // Etkinlik akışı `activity_logs` tablosundan okunacak; o tablo ve
      // indeksleri hazır, ekran bağlantısı sıradaki iş.
      entries: const [],
      onMarkAllRead: () => _snack('Tümü okundu işaretlendi'),
      onCopyLink: first == null
          ? null
          : () => _shareList(first.id, copyOnly: true),
      onShareWhatsApp: first == null
          ? null
          : () => _shareList(first.id, copyOnly: false),
      onShareSms: first == null
          ? null
          : () => _shareList(first.id, copyOnly: false),
    );
  }

  Widget _profile() {
    final user = ref.watch(authStateProvider).value?.user;
    final rows = ref.watch(listsProvider).value ?? const <ListSummary>[];
    final completed = rows.fold<int>(
      0,
      (sum, list) => sum + list.completedItemCount,
    );
    final total = rows.fold<int>(0, (sum, list) => sum + list.itemCount);

    return ProfileView(
      user: AvatarData(
        initials: _initialsOf(_displayName),
        label: _displayName,
      ),
      name: _displayName,
      email: user?.email ?? '',
      isPremium: false,
      versionLabel: 'SmartList 1.0.0',
      stats: [
        ProfileStat(
          value: '${rows.length}',
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
          value: '$total',
          label: 'Toplam ürün',
          icon: Icons.shopping_basket_outlined,
          color: DesignTokens.tertiary,
        ),
      ],
      onEditProfile: () => _snack('Profil düzenleme yakında'),
      onOpenStatistics: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => StatisticsScreen(
            totalItems: total,
            completedItems: completed,
            activeLists: rows.length,
            totalSpend: 0,
            currency: _settings.currency,
            weeklySpend: const [],
            categories: const [],
          ),
        ),
      ),
      onOpenSettings: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => SettingsScreen(
            settings: _settings,
            onChanged: (value) => setState(() => _settings = value),
            versionLabel: 'SmartList 1.0.0',
          ),
        ),
      ),
      onOpenPremium: () => PremiumSheet.show(context),
      onSignOut: _confirmSignOut,
    );
  }

  /// Adın baş harfleri; tek kelimede ilk iki harf, böylece avatar boş kalmıyor.
  String _initialsOf(String name) {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();
    if (parts.isEmpty) {
      return 'SL';
    }
    if (parts.length == 1) {
      final word = parts.first;
      return (word.length == 1 ? word : word.substring(0, 2)).toUpperCase();
    }
    return (parts.first[0] + parts[1][0]).toUpperCase();
  }
}

/// Liste detayı. Ürünler canlı akıştan geliyor.
class _ListDetailPage extends ConsumerWidget {
  const _ListDetailPage({required this.listId});

  final String listId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(listsRepositoryProvider);
    final summary = ref.watch(listSummaryProvider(listId)).value;
    final items = ref.watch(itemsProvider(listId));

    void snack(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }

    Future<void> run(Future<void> Function() action) async {
      try {
        await action();
      } on AppException catch (error) {
        snack(error.userMessage);
      }
    }

    Future<void> addProduct() async {
      final product = await AddProductSheet.show(
        context,
        onScanBarcode: () => _scanAndLookupProduct(context, ref),
      );
      if (product == null) {
        return;
      }
      await run(
        () => repository.addItem(
          listId: listId,
          name: product.name,
          quantity: product.quantity.toDouble(),
          unit: product.unit,
          price: product.price,
          notes: product.note ?? '',
        ),
      );
    }

    Future<void> addByVoice() async {
      final spoken = await VoiceInputSheet.show(context);
      if (spoken == null || spoken.isEmpty) {
        return;
      }
      await run(
        () => repository.addItems(
          listId: listId,
          items: [
            for (final item in spoken)
              (
                name: item.name,
                quantity: item.quantity,
                unit: item.unit.wire,
                price: null,
                notes: '',
              ),
          ],
          source: 'voice',
        ),
      );
    }

    return Scaffold(
      body: items.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _ErrorState(
          message: error is AppException
              ? error.userMessage
              : 'Ürünler okunamadı.',
          onRetry: () => ref.invalidate(itemsProvider(listId)),
        ),
        data: (rows) => ListDetailView(
          title: summary == null
              ? 'Liste'
              : '${summary.emoji} ${summary.title}',
          items: [
            for (final item in rows)
              ItemRowData(
                id: item.id,
                name: item.name,
                category: '',
                quantityLabel: item.quantityLabel,
                priceLabel: item.priceLabel,
                noteText: item.notes.isEmpty ? null : item.notes,
                isCompleted: item.isCompleted,
              ),
          ],
          onBack: () => Navigator.of(context).pop(),
          onSearch: () => snack('Liste içinde arama yakında'),
          // Paylasim listeye ozel: kullanici hangi listeyi paylastigini
          // secmek zorunda kalmasin diye eylem listenin kendi ekraninda.
          onMore: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => _ListSharePage(listId: listId),
            ),
          ),
          onToggleItem: ({required id, required completed}) => run(
            () => repository.setItemCompleted(itemId: id, completed: completed),
          ),
          onDeleteItem: (id) => run(() => repository.deleteItem(id)),
          onClearCompleted: () => run(() => repository.clearCompleted(listId)),
          onEditItem: (id) async {
            final item = rows.firstWhere((row) => row.id == id);
            final edited = await EditItemSheet.show(
              context,
              name: item.name,
              quantity: item.quantity,
              unit: item.unit,
              notes: item.notes,
              price: item.price,
            );
            if (edited == null) {
              return;
            }
            await run(
              () => repository.updateItem(
                itemId: id,
                name: edited.name,
                quantity: edited.quantity,
                unit: edited.unit,
                price: edited.price,
                clearPrice: edited.clearPrice,
                notes: edited.notes,
              ),
            );
          },
        ),
      ),
      // İki eylem: konuşarak hızlı ekleme ve elle ayrıntılı ekleme. Mikrofon
      // küçük tutuldu, birincil eylem hâlâ elle ekleme.
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            heroTag: 'voice',
            onPressed: addByVoice,
            tooltip: 'Sesle ekle',
            child: const Icon(Icons.mic),
          ),
          const SizedBox(height: DesignTokens.space3),
          FloatingActionButton(
            heroTag: 'add',
            onPressed: addProduct,
            child: const Icon(Icons.add, size: DesignTokens.iconLarge),
          ),
        ],
      ),
    );
  }
}

class _EmptyLists extends StatelessWidget {
  const _EmptyLists({required this.onCreate, required this.onJoin});

  final VoidCallback onCreate;
  final VoidCallback onJoin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final spacing = context.spacing;

    return Padding(
      padding: EdgeInsets.only(top: spacing.sectionGap),
      child: Column(
        children: [
          Icon(
            Icons.add_shopping_cart,
            size: DesignTokens.iconExtraLarge,
            color: theme.colorScheme.outlineVariant,
          ),
          SizedBox(height: spacing.gutter),
          Text('Henüz listeniz yok', style: theme.textTheme.headlineSmall),
          SizedBox(height: spacing.small),
          Text(
            'Bir liste oluşturun ya da paylaşılan bir listeye QR ile katılın.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: spacing.sectionGap),
          FilledButton.icon(
            onPressed: onCreate,
            icon: const Icon(Icons.add),
            label: const Text('Liste oluştur'),
          ),
          SizedBox(height: spacing.stackGap),
          OutlinedButton.icon(
            onPressed: onJoin,
            icon: const Icon(Icons.qr_code_scanner),
            label: const Text('QR ile katıl'),
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final spacing = context.spacing;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(spacing.containerMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_off,
              size: DesignTokens.iconExtraLarge,
              color: theme.colorScheme.outlineVariant,
            ),
            SizedBox(height: spacing.gutter),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge,
            ),
            SizedBox(height: spacing.gutter),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Tekrar dene'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Tek bir listenin paylaşım sayfası.
///
/// QR koduna gömülen değer **bu listenin** davet kodu. Kod ilk açılışta
/// üretiliyor ve tabloda kalıyor; sonraki açılışlarda aynı kod dönüyor, yoksa
/// daha önce paylaşılmış bir QR sessizce geçersiz olurdu.
class _ListSharePage extends ConsumerWidget {
  const _ListSharePage({required this.listId});

  final String listId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(listSummaryProvider(listId)).value;
    final code = ref.watch(listShareCodeProvider(listId));
    final members = ref.watch(listMembersProvider(listId)).value ?? const [];

    Future<void> copy(String link) async {
      await Clipboard.setData(ClipboardData(text: 'https://$link'));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Davet bağlantısı kopyalandı')),
        );
      }
    }

    Future<void> share(String link) async {
      final title = summary?.title ?? 'listem';
      try {
        await SharePlus.instance.share(
          ShareParams(
            subject: '$title listesine katıl',
            text: '$title listeme SmartList üzerinden katıl:\nhttps://$link',
          ),
        );
      } on Exception {
        await copy(link);
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Listeyi paylaş')),
      body: code.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _ErrorState(
          message: error is AppException
              ? error.userMessage
              : 'Davet kodu üretilemedi.',
          onRetry: () => ref.invalidate(listShareCodeProvider(listId)),
        ),
        data: (slug) {
          final link = 'smartlist.app/j/$slug';
          return ActivityShareView(
            entries: const [],
            members: [
              for (final member in members)
                AvatarData(
                  initials: member.name.isEmpty
                      ? '?'
                      : member.name.substring(0, 1).toUpperCase(),
                  label: member.name,
                  photoUrl: member.photoUrl,
                ),
            ],
            listName: summary?.title ?? 'Liste',
            inviteLink: link,
            // Bu ekran paylaşım için açıldı; etkinlik sekmesi boş kalmasın diye
            // doğrudan Share sekmesiyle başlıyor.
            startOnShareTab: true,
            onCopyLink: () => copy(link),
            onShareWhatsApp: () => share(link),
            onShareSms: () => share(link),
          );
        },
      ),
    );
  }
}

/// Barkod okur ve ürünü çözer.
///
/// Hem kabuk hem liste detayı aynı akışı kullanıyor, o yüzden sınıf dışında.
///
/// Bulunamaması hata değil: açık veritabanında olmayan ürün normaldir ve
/// kullanıcı adı elle yazıp devam ediyor. Türk ürünlerinde kapsam daha zayıf
/// olduğu için mesaj bunu ayırt ediyor — "bulunamadı" yerine "bu ürün
/// veritabanında yok" demek kullanıcıya taramanın çalıştığını söylüyor.
Future<ScannedProduct?> _scanAndLookupProduct(
  BuildContext context,
  WidgetRef ref,
) async {
  final scan = await ScannerScreen.open(context);
  if (scan == null || !context.mounted) {
    return null;
  }

  void snack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  ProductInfo? info;
  try {
    info = await ref.read(_productLookupProvider).lookup(scan.code);
  } on AppException catch (error) {
    if (context.mounted) {
      snack(error.userMessage);
    }
    // Barkod okundu ama sorgu başarısız: kullanıcı adı yazıp devam edebilsin
    // diye kodu forma taşıyoruz.
    return ScannedProduct(barcode: scan.code, name: '');
  }

  if (!context.mounted) {
    return null;
  }

  if (info == null) {
    snack(
      ProductLookupService.isTurkishPrefix(scan.code)
          ? 'Bu ürün açık veritabanında yok. Adını yazabilirsiniz.'
          : 'Ürün bulunamadı. Adını yazabilirsiniz.',
    );
    return ScannedProduct(barcode: scan.code, name: '');
  }

  return ScannedProduct(
    name: info.displayName,
    barcode: info.barcode,
    quantity: info.quantity,
  );
}

/// Kaydırma sırasında satırın arkasında görünen eylem şeridi.
class _SwipeAction extends StatelessWidget {
  const _SwipeAction({
    required this.alignment,
    required this.icon,
    required this.label,
    required this.color,
    required this.textColor,
  });

  final Alignment alignment;
  final IconData icon;
  final String label;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: DesignTokens.space5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(DesignTokens.radius2xl),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: textColor),
          const SizedBox(width: DesignTokens.space2),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
