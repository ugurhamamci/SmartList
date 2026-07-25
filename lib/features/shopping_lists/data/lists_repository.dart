import 'dart:async';

import 'package:smartlist/core/errors/error_mapper.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthException;
import 'package:uuid/uuid.dart';

/// Ana ekranda bir liste kartını çizmek için gereken alanlar.
///
/// Tam `ShoppingList` modeli yerine dar bir görünüm okunuyor: liste kartı 8
/// alan gösteriyor, tablo 25 sütun taşıyor. Mobil bağlantıda okunmayan sütunu
/// çekmek anlamsız.
class ListSummary {
  const ListSummary({
    required this.id,
    required this.title,
    required this.emoji,
    required this.itemCount,
    required this.completedItemCount,
    required this.memberCount,
    required this.isCompleted,
    this.lastActivityAt,
  });

  factory ListSummary.fromRow(Map<String, dynamic> row) {
    return ListSummary(
      id: row['id'] as String,
      title: (row['title'] as String?) ?? '',
      emoji: (row['emoji'] as String?) ?? '🛒',
      itemCount: (row['item_count'] as int?) ?? 0,
      completedItemCount: (row['completed_item_count'] as int?) ?? 0,
      memberCount: (row['member_count'] as int?) ?? 1,
      isCompleted: (row['is_completed'] as bool?) ?? false,
      lastActivityAt: DateTime.tryParse(
        (row['last_activity_at'] as String?) ?? '',
      ),
    );
  }

  final String id;
  final String title;
  final String emoji;
  final int itemCount;
  final int completedItemCount;
  final int memberCount;
  final bool isCompleted;
  final DateTime? lastActivityAt;

  /// Sayaçlar veritabanı trigger'ları tarafından tutuluyor, bu yüzden burada
  /// yeniden hesaplanmıyor — yalnızca orana çevriliyor.
  double get progress =>
      itemCount == 0 ? 0 : (completedItemCount / itemCount).clamp(0.0, 1.0);
}

/// Liste detayında bir ürün satırı.
class ItemRow {
  const ItemRow({
    required this.id,
    required this.listId,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.isCompleted,
    required this.sortOrder,
    this.price,
    this.notes = '',
    this.categoryId,
  });

  factory ItemRow.fromRow(Map<String, dynamic> row) {
    return ItemRow(
      id: row['id'] as String,
      listId: row['list_id'] as String,
      name: (row['name'] as String?) ?? '',
      // `numeric` sütunlar JSON'da sayı ya da metin olarak gelebiliyor.
      quantity: toDouble(row['quantity']) ?? 1,
      unit: (row['unit'] as String?) ?? 'piece',
      isCompleted: (row['is_completed'] as bool?) ?? false,
      sortOrder: toDouble(row['sort_order']) ?? 0,
      price: toDouble(row['price']),
      notes: (row['notes'] as String?) ?? '',
      categoryId: row['category_id'] as String?,
    );
  }

  static double? toDouble(Object? value) => switch (value) {
    null => null,
    final num n => n.toDouble(),
    final String s => double.tryParse(s),
    _ => null,
  };

  final String id;
  final String listId;
  final String name;
  final double quantity;
  final String unit;
  final bool isCompleted;
  final double sortOrder;
  final double? price;
  final String notes;
  final String? categoryId;

  /// "2 l", "1.5 kg" gibi okunabilir miktar.
  String get quantityLabel {
    final amount = quantity == quantity.roundToDouble()
        ? quantity.round().toString()
        : quantity.toString();
    return '$amount $unit';
  }

  String? get priceLabel =>
      price == null ? null : '${price!.toStringAsFixed(0)} TL';
}

/// Liste ve ürün verisini Supabase üzerinden okur ve yazar.
///
/// Yetkilendirme burada **denetlenmiyor**: hangi satırı kimin görebileceğine ve
/// değiştirebileceğine RLS politikaları karar veriyor. İstemcide ikinci bir
/// kontrol katmanı kurmak yanlış güven yaratır — gerçek kontrol sunucuda ve
/// istemci atlatılabilir.
class ListsRepository {
  ListsRepository(this._client);

  final SupabaseClient _client;

  static const _uuid = Uuid();

  /// Liste kartı için okunan sütunlar.
  static const _listColumns =
      'id,title,emoji,item_count,completed_item_count,member_count,'
      'is_completed,last_activity_at';

  static const _itemColumns =
      'id,list_id,name,quantity,unit,is_completed,sort_order,price,notes,'
      'category_id';

  String get _uid {
    final id = _client.auth.currentUser?.id;
    if (id == null) {
      throw StateError('Oturum yok: depo katmanı giriş yapılmadan çağrıldı.');
    }
    return id;
  }

  // ------------------------------------------------------------------ okuma

  /// Kullanıcının üyesi olduğu listeler, son hareket edene göre.
  ///
  /// RLS zaten yalnızca üye olunan listeleri döndürüyor, o yüzden sorguda
  /// üyelik filtresi yok. `deleted_at` filtresi burada: yetkilendirme ile
  /// görünürlük ayrı konular, politikalar yumuşak silmeye bakmıyor.
  Future<List<ListSummary>> fetchLists() {
    return ErrorMapper.guard(() async {
      final rows = await _client
          .from('shopping_lists')
          .select(_listColumns)
          .isFilter('deleted_at', null)
          .order('last_activity_at', ascending: false, nullsFirst: false)
          .order('created_at', ascending: false);

      return rows.map(ListSummary.fromRow).toList();
    });
  }

  Future<ListSummary?> fetchList(String listId) {
    return ErrorMapper.guard(() async {
      final row = await _client
          .from('shopping_lists')
          .select(_listColumns)
          .eq('id', listId)
          .maybeSingle();
      return row == null ? null : ListSummary.fromRow(row);
    });
  }

  Future<List<ItemRow>> fetchItems(String listId) {
    return ErrorMapper.guard(() async {
      final rows = await _client
          .from('items')
          .select(_itemColumns)
          .eq('list_id', listId)
          .isFilter('deleted_at', null)
          .order('sort_order');
      return rows.map(ItemRow.fromRow).toList();
    });
  }

  // -------------------------------------------------------------- canlı akış

  /// Bir listenin ürünleri, satır düzeyinde canlı.
  ///
  /// `stream` tek tablo ve basit filtre ile çalışıyor; ürünler tam olarak bu
  /// şekle uyuyor, bu yüzden gerçek anlamda anlık güncelleme alıyoruz.
  ///
  /// Silinen satırlar akışta da geliyor; `deleted_at` filtresini burada elle
  /// uyguluyoruz çünkü `stream` sunucu tarafı filtrede yalnızca eşitliği
  /// destekliyor.
  Stream<List<ItemRow>> watchItems(String listId) {
    return _client
        .from('items')
        .stream(primaryKey: ['id'])
        .eq('list_id', listId)
        .order('sort_order')
        .map(
          (rows) => rows
              .where((row) => row['deleted_at'] == null)
              .map(ItemRow.fromRow)
              .toList(),
        );
  }

  /// Liste listesindeki değişiklikleri bildirir.
  ///
  /// `stream` burada kullanılamıyor: "üyesi olduğum listeler" sorusu
  /// `list_members` üzerinden bir birleştirme (join) gerektiriyor ve `stream`
  /// birleştirme yapamıyor. Bunun yerine ilgili tabloları dinleyip her
  /// değişiklikte yeniden okuma yapıyoruz — RLS ve sıralama korunuyor.
  ///
  /// Dinlenen tablolar: listelerin kendisi (başlık, sayaç), üyelik (birinin
  /// katılması) ve ürünler (sayaçları trigger güncelliyor, ama olay ürün
  /// tablosundan geliyor).
  Stream<void> watchListChanges() {
    final controller = StreamController<void>.broadcast();

    final channel = _client.channel('lists-${_uuid.v4()}')
      ..onPostgresChanges(
        event: PostgresChangeEvent.all,
        schema: 'public',
        table: 'shopping_lists',
        callback: (_) => controller.add(null),
      )
      ..onPostgresChanges(
        event: PostgresChangeEvent.all,
        schema: 'public',
        table: 'list_members',
        callback: (_) => controller.add(null),
      )
      ..subscribe();

    controller.onCancel = () async {
      await _client.removeChannel(channel);
    };

    return controller.stream;
  }

  // ------------------------------------------------------------------ yazma

  /// Yeni liste oluşturur ve kimliğini döndürür.
  ///
  /// Kimlik **istemcide** üretiliyor ve `insert` dönüş istemiyor. Sebebi somut:
  /// `returning` kullanıldığında Postgres SELECT politikasını da uyguluyor ve o
  /// kontrol, üyeliği ekleyen AFTER INSERT trigger'ından önce çalıştığı için
  /// liste sahibi kendi satırını okuyamıyor (403). Kimliği önceden bilmek bu
  /// sıra problemini tamamen ortadan kaldırıyor.
  ///
  /// Owner üyeliği ve sohbet odası veritabanı trigger'ı tarafından açılıyor.
  Future<String> createList({
    required String title,
    required String emoji,
    required String colorHex,
  }) {
    return ErrorMapper.guard(() async {
      final id = _uuid.v4();
      await _client.from('shopping_lists').insert({
        'id': id,
        'title': title.trim(),
        'emoji': emoji,
        'color_hex': colorHex,
        'owner_id': _uid,
      });
      return id;
    });
  }

  Future<void> renameList(String listId, String title) {
    return ErrorMapper.guard(
      () => _client
          .from('shopping_lists')
          .update({'title': title.trim()})
          .eq('id', listId),
    );
  }

  /// Listeyi yumuşak siler. Kalıcı silme yalnızca sahibinde ve RLS bunu
  /// zorluyor; damgalamak geri alınabilir olduğu için öntanımlı davranış.
  Future<void> deleteList(String listId) {
    return ErrorMapper.guard(
      () => _client
          .from('shopping_lists')
          .update({'deleted_at': DateTime.now().toUtc().toIso8601String()})
          .eq('id', listId),
    );
  }

  /// Listeye ürün ekler.
  ///
  /// Sıra değeri sunucudan alınıyor (`next_item_sort_order`): iki kişi aynı
  /// anda ürün eklediğinde ikisi de listenin sonuna gitsin, biri diğerinin
  /// üstüne yazmasın.
  Future<void> addItem({
    required String listId,
    required String name,
    double quantity = 1,
    String unit = 'piece',
    double? price,
    String notes = '',
    String? categoryId,
    String source = 'manual',
    String? barcode,
  }) {
    return ErrorMapper.guard(() async {
      final sortOrder = await _client.rpc<dynamic>(
        'next_item_sort_order',
        params: {'p_list_id': listId},
      );

      await _client.from('items').insert({
        'list_id': listId,
        'name': name.trim(),
        'quantity': quantity,
        'unit': unit,
        'price': ?price,
        if (notes.trim().isNotEmpty) 'notes': notes.trim(),
        'category_id': ?categoryId,
        'source': source,
        'barcode': ?barcode,
        'sort_order': ItemRow.toDouble(sortOrder) ?? 0,
      });
    });
  }

  /// Ürünü alındı / alınmadı olarak işaretler.
  ///
  /// Viewer rolündeki bir üye de bunu yapabiliyor; hangi sütunlara
  /// dokunabildiğini veritabanındaki trigger denetliyor.
  Future<void> setItemCompleted({
    required String itemId,
    required bool completed,
  }) {
    return ErrorMapper.guard(
      () => _client
          .from('items')
          .update({
            'is_completed': completed,
            'completed_at': completed
                ? DateTime.now().toUtc().toIso8601String()
                : null,
            'purchased_by': completed ? _uid : null,
            'purchased_at': completed
                ? DateTime.now().toUtc().toIso8601String()
                : null,
          })
          .eq('id', itemId),
    );
  }

  Future<void> deleteItem(String itemId) {
    return ErrorMapper.guard(
      () => _client
          .from('items')
          .update({'deleted_at': DateTime.now().toUtc().toIso8601String()})
          .eq('id', itemId),
    );
  }

  /// Tamamlanan ürünleri listeden kaldırır.
  Future<void> clearCompleted(String listId) {
    return ErrorMapper.guard(
      () => _client
          .from('items')
          .update({'deleted_at': DateTime.now().toUtc().toIso8601String()})
          .eq('list_id', listId)
          .eq('is_completed', true)
          .isFilter('deleted_at', null),
    );
  }

  // ---------------------------------------------------------------- paylaşım

  /// Listeye davet bağlantısı üretir ve kodunu döndürür.
  ///
  /// Var olan etkin bağlantı varsa onu kullanıyoruz: her paylaşımda yeni kod
  /// üretmek, daha önce paylaşılmış QR kodlarını sessizce geçersiz kılardı.
  Future<String> ensureShareCode(String listId, {String role = 'editor'}) {
    return ErrorMapper.guard(() async {
      final existing = await _client
          .from('shared_links')
          .select('slug')
          .eq('list_id', listId)
          .eq('is_active', true)
          .isFilter('deleted_at', null)
          .limit(1)
          .maybeSingle();

      if (existing != null) {
        return existing['slug'] as String;
      }

      // Karışan karakterler (0/O, 1/I) alfabede yok: kullanıcı kodu elle de
      // yazabilsin.
      const alphabet = 'ABCDEFGHJKMNPQRSTUVWXYZ23456789';
      final random = _uuid.v4().replaceAll('-', '');
      final slug = List.generate(
        8,
        (i) => alphabet[int.parse(random[i], radix: 16) % alphabet.length],
      ).join();

      await _client.from('shared_links').insert({
        'list_id': listId,
        'slug': slug,
        'role': role,
      });
      return slug;
    });
  }

  /// QR koduyla listeye katılır ve listenin kimliğini döndürür.
  ///
  /// RPC olması zorunlu: katılan kişi henüz üye değil, hiçbir RLS politikası
  /// ona kendi üyeliğini eklemesine izin veremez. Fonksiyon bağlantının
  /// geçerliliğini kendisi doğruluyor.
  Future<String> joinByCode(String code) {
    return ErrorMapper.guard(() async {
      final listId = await _client.rpc<dynamic>(
        'join_list_by_slug',
        params: {'p_slug': code.trim().toUpperCase()},
      );
      return listId as String;
    });
  }

  /// Listenin üyeleri; avatar yığınını çizmek için.
  Future<List<({String userId, String name, String role, String? photoUrl})>>
  fetchMembers(String listId) {
    return ErrorMapper.guard(() async {
      final rows = await _client
          .from('list_members')
          .select('user_id,display_name,role,photo_url')
          .eq('list_id', listId)
          .isFilter('deleted_at', null)
          .order('role', ascending: false);

      return rows
          .map(
            (row) => (
              userId: row['user_id'] as String,
              name: (row['display_name'] as String?) ?? '',
              role: (row['role'] as String?) ?? 'viewer',
              photoUrl: row['photo_url'] as String?,
            ),
          )
          .toList();
    });
  }
}
