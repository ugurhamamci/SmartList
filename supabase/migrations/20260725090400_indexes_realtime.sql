-- SmartList — indeksler ve gerçek zamanlı yayın
--
-- İki grup indeks var:
--
--   1. Foreign key indeksleri. Postgres bunları KENDİLİĞİNDEN OLUŞTURMAZ
--      (birincil anahtar ve tekillik kısıtları için oluşturur, FK için hayır).
--      İndekssiz FK, üst satır silindiğinde alt tabloyu baştan sona tarar.
--
--   2. Ekranların gerçekten attığı sorgular. Her biri hangi ekran için
--      olduğu yazılarak eklendi; "olur da gerekir" indeksi yok, çünkü her
--      indeks yazma maliyeti demek.
--
-- Çoğu indeks KISMİ (`where deleted_at is null`): sorgular hep canlı satırı
-- istiyor, silinmişler indekste yer kaplamasın.

-- ================================================== foreign key indeksleri

create index categories_owner_id_idx on public.categories (owner_id);

create index shopping_lists_owner_id_idx on public.shopping_lists (owner_id);
create index shopping_lists_category_id_idx on public.shopping_lists (category_id);

create index list_members_user_id_idx on public.list_members (user_id);
create index list_members_invited_by_idx on public.list_members (invited_by);

create index items_category_id_idx on public.items (category_id);
create index items_purchased_by_idx on public.items (purchased_by);

create index activity_logs_actor_id_idx on public.activity_logs (actor_id);

create index invitations_invited_by_idx on public.invitations (invited_by);
create index invitations_invitee_id_idx on public.invitations (invitee_id);

create index list_presence_user_id_idx on public.list_presence (user_id);
create index list_presence_editing_item_id_idx on public.list_presence (editing_item_id);

create index chat_rooms_last_message_sender_id_idx
  on public.chat_rooms (last_message_sender_id);

create index chat_messages_sender_id_idx on public.chat_messages (sender_id);
create index chat_messages_reply_to_message_id_idx
  on public.chat_messages (reply_to_message_id);

create index shared_links_list_id_idx on public.shared_links (list_id);
create index shopping_templates_owner_id_idx on public.shopping_templates (owner_id);

create index favorites_list_id_idx on public.favorites (list_id);
create index barcode_scans_category_id_idx on public.barcode_scans (category_id);
create index barcode_scans_list_id_idx on public.barcode_scans (list_id);
create index barcode_scans_item_id_idx on public.barcode_scans (item_id);
create index voice_commands_list_id_idx on public.voice_commands (list_id);

create index notifications_list_id_idx on public.notifications (list_id);
create index notifications_item_id_idx on public.notifications (item_id);
create index notifications_message_id_idx on public.notifications (message_id);
create index notifications_invitation_id_idx on public.notifications (invitation_id);
create index notifications_actor_id_idx on public.notifications (actor_id);

create index feedback_user_id_idx on public.feedback (user_id);
create index bug_reports_user_id_idx on public.bug_reports (user_id);

-- ==================================================== ekran sorguları

-- Ana ekran: "üye olduğum listeler, son hareket edene göre".
-- RLS `is_list_member()` üzerinden `list_members`'a bakıyor, o yüzden asıl
-- kritik indeks bu tablodaki (user_id, list_id) çifti.
create index list_members_user_live_idx
  on public.list_members (user_id, list_id)
  where deleted_at is null;

create index shopping_lists_activity_idx
  on public.shopping_lists (last_activity_at desc nulls last)
  where deleted_at is null;

-- Listeler sekmesindeki filtre çipleri.
create index shopping_lists_pinned_idx
  on public.shopping_lists (is_pinned, last_activity_at desc)
  where deleted_at is null and is_pinned;

create index shopping_lists_archived_idx
  on public.shopping_lists (is_archived, last_activity_at desc)
  where deleted_at is null and is_archived;

create index shopping_lists_favorite_idx
  on public.shopping_lists (is_favorite, last_activity_at desc)
  where deleted_at is null and is_favorite;

-- Liste detayı: elle sıralama (öntanımlı görünüm).
create index items_list_sort_idx
  on public.items (list_id, sort_order)
  where deleted_at is null;

-- Liste detayı: tamamlananları alta atan görünüm.
create index items_list_completion_idx
  on public.items (list_id, is_completed, sort_order)
  where deleted_at is null;

-- Liste detayı: kategoriye ve önceliğe göre sıralama seçenekleri.
create index items_list_category_idx
  on public.items (list_id, category_id, sort_order)
  where deleted_at is null;

create index items_list_priority_idx
  on public.items (list_id, priority desc, sort_order)
  where deleted_at is null;

-- İstatistik ekranı: "kim ne zaman ne aldı".
create index items_purchase_history_idx
  on public.items (purchased_by, purchased_at desc)
  where deleted_at is null and is_completed;

-- Activity sekmesi: listenin son hareketleri.
create index activity_logs_list_recent_idx
  on public.activity_logs (list_id, created_at desc);

-- Bekleyen davetler: giriş yapan adrese gelen davetler, tüm listeler boyunca.
create index invitations_pending_for_email_idx
  on public.invitations (invitee_email, status, created_at desc)
  where deleted_at is null;

create index invitations_list_status_idx
  on public.invitations (list_id, status)
  where deleted_at is null;

-- Sohbet: sayfalanan geçmiş.
create index chat_messages_room_recent_idx
  on public.chat_messages (room_id, created_at desc)
  where deleted_at is null;

-- Bildirim çanı: okunmamış sayısı ve liste.
create index notifications_user_unread_idx
  on public.notifications (user_id, created_at desc)
  where deleted_at is null and not is_read;

create index notifications_user_recent_idx
  on public.notifications (user_id, created_at desc)
  where deleted_at is null;

-- Varlık: eskimiş kayıtları ayıklamak (çevrimdışı sayma).
create index list_presence_stale_idx on public.list_presence (last_seen_at desc);

-- İstatistik okuması: kullanıcı + dönem.
create index user_statistics_lookup_idx
  on public.user_statistics (user_id, period, period_start desc);

-- Barkod geçmişi: en son okunanlar.
create index barcode_scans_recent_idx
  on public.barcode_scans (user_id, scanned_at desc);

-- Son aramalar önerisi.
create index recent_searches_recent_idx
  on public.recent_searches (user_id, searched_at desc);

-- Etkin cihaz jetonları (bildirim gönderimi).
create index device_tokens_active_idx
  on public.device_tokens (user_id)
  where is_active;

-- ==================================================== arama (trigram)

-- Arama ekranı kısmi kelimeyle arıyor ("dom" → "Domates"). B-tree indeksi
-- `like '%dom%'` sorgusunu kullanamaz; trigram indeksi kullanabiliyor.
-- Firestore'da bu mümkün değildi, istemci tarafında filtrelemek gerekiyordu.
create index items_name_trgm_idx
  on public.items using gin (name extensions.gin_trgm_ops)
  where deleted_at is null;

create index shopping_lists_title_trgm_idx
  on public.shopping_lists using gin (title extensions.gin_trgm_ops)
  where deleted_at is null;

create index categories_name_trgm_idx
  on public.categories using gin (name extensions.gin_trgm_ops)
  where deleted_at is null;

-- E-posta eşleşmesi büyük/küçük harfe duyarsız olsun.
create unique index users_email_lower_idx on public.users (lower(email));

-- ================================================== gerçek zamanlı yayın

-- Hangi tabloların değişikliği istemciye anlık akacak. Listeye eklenen her
-- tablo her yazmada ek iş demek, o yüzden yalnızca ekranın canlı görmesi
-- gereken tablolar var: liste kartı, ürünler, üyeler, hareketler, sohbet,
-- varlık ve bildirimler.
--
-- Yayın Supabase'de hazır gelir; `add table` ile genişletiyoruz.
--
-- `alter publication ... add table` zaten ekli bir tabloda hata verir, o yüzden
-- önce yayında olup olmadığına bakıyoruz — migration yeniden çalıştırılabilir
-- kalsın.
do $$
declare
  realtime_table text;
begin
  foreach realtime_table in array array[
    'shopping_lists', 'items', 'list_members', 'activity_logs',
    'chat_messages', 'chat_rooms', 'list_presence', 'notifications'
  ]
  loop
    if not exists (
      select 1
      from pg_publication_tables
      where pubname = 'supabase_realtime'
        and schemaname = 'public'
        and tablename = realtime_table
    ) then
      execute format(
        'alter publication supabase_realtime add table public.%I',
        realtime_table
      );
    end if;
  end loop;
end;
$$;

-- Gerçek zamanlı akış, silinen satırın hangi listeye ait olduğunu ancak
-- eski satırın tamamı yayınlanırsa söyleyebilir. `replica identity full`
-- olmadan `delete` olayı yalnızca birincil anahtarı taşır ve istemci o
-- silmenin kendi açık listesine ait olup olmadığını anlayamaz.
alter table public.items replica identity full;
alter table public.list_members replica identity full;
alter table public.chat_messages replica identity full;
