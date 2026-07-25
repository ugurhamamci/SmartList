import 'package:flutter_riverpod/flutter_riverpod.dart';

// Riverpod'un `family` saglayicilari cok parametreli jenerik tipler uretiyor
// (`AutoDisposeStreamProviderFamily<List<ItemRow>, String>` gibi). Bu tipleri
// elle yazmak okunurlugu dusuruyor ve degeri yok: saglayicinin tipi zaten
// olusturucudaki jeneriklerden okunuyor.
// ignore_for_file: specify_nonobvious_property_types

import 'package:smartlist/features/auth/auth_providers.dart';
import 'package:smartlist/features/shopping_lists/data/lists_repository.dart';

final listsRepositoryProvider = Provider<ListsRepository>((ref) {
  return ListsRepository(ref.watch(supabaseClientProvider));
});

/// Kullanıcının listeleri.
///
/// Bu bir `Stream` yerine yeniden okunabilir bir `Future`: "üyesi olduğum
/// listeler" sorusu `list_members` üzerinden birleştirme gerektiriyor ve
/// Supabase'in satır akışı birleştirme yapamıyor. Bunun yerine ilgili
/// tablolardaki değişiklikler dinlenip sağlayıcı geçersiz kılınıyor — sonuç
/// kullanıcı için aynı, RLS ve sıralama korunuyor.
final listsProvider = FutureProvider<List<ListSummary>>((ref) {
  final repository = ref.watch(listsRepositoryProvider);

  // Değişiklik akışına abone olup her olayda kendimizi geçersiz kılıyoruz.
  // Abonelik sağlayıcı atıldığında kapanıyor, yani ekran kapanınca kanal da
  // kapanıyor.
  final subscription = repository.watchListChanges().listen((_) {
    ref.invalidateSelf();
  });
  ref.onDispose(subscription.cancel);

  return repository.fetchLists();
});

/// Bir listenin ürünleri, satır düzeyinde canlı.
///
/// Burada gerçek akış kullanılabiliyor: tek tablo, tek eşitlik filtresi. Bir
/// telefonda eklenen ürün diğerinde anında görünüyor.
final itemsProvider = StreamProvider.family<List<ItemRow>, String>((
  ref,
  listId,
) {
  return ref.watch(listsRepositoryProvider).watchItems(listId);
});

/// Tek bir listenin özeti (başlık, sayaçlar). Ürün eklendiğinde sayaçları
/// trigger güncelliyor, bu yüzden ürün akışı her değiştiğinde yeniden okunuyor.
final listSummaryProvider = FutureProvider.family<ListSummary?, String>((
  ref,
  listId,
) {
  // Ürün akışını izlemek, sayaçların tazelenmesini ürün değişikliğine bağlıyor.
  ref.watch(itemsProvider(listId));
  return ref.watch(listsRepositoryProvider).fetchList(listId);
});

/// Listenin üyeleri; avatar yığını için.
final listMembersProvider =
    FutureProvider.family<
      List<({String userId, String name, String role, String? photoUrl})>,
      String
    >((ref, listId) {
      return ref.watch(listsRepositoryProvider).fetchMembers(listId);
    });

/// Bir listenin davet kodu.
///
/// Var olan etkin bağlantı varsa yeniden kullanılıyor; her paylaşımda yeni kod
/// üretmek daha önce paylaşılmış QR kodlarını sessizce geçersiz kılardı.
///
/// `keepAlive` yok: kod ilk paylaşımda üretiliyor ve tabloda kalıyor, ekran
/// kapanınca sağlayıcının atılması bir şey kaybettirmiyor.
final listShareCodeProvider = FutureProvider.family<String, String>((
  ref,
  listId,
) {
  return ref.watch(listsRepositoryProvider).ensureShareCode(listId);
});
