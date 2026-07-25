-- SmartList — Row Level Security politikaları
--
-- Firestore kurallarının Postgres karşılığı. Rol tablosu aynı:
--
--   Yetenek                        | Owner | Editor | Viewer
--   -------------------------------|-------|--------|-------
--   Liste ve ürünleri oku          |  ✅   |   ✅   |  ✅
--   Ürün ekle / düzenle / sil      |  ✅   |   ✅   |  —
--   Ürünü tamamlandı işaretle      |  ✅   |   ✅   |  ✅
--   Sohbete mesaj yaz              |  ✅   |   ✅   |  ✅
--   Üye davet et                   |  ✅   |   ✅   |  —
--   Üye ve rol yönet               |  ✅   |   —    |  —
--   Listeyi sil / devret           |  ✅   |   —    |  —
--
-- Viewer'ın "yalnızca tamamlandı alanını değiştirebilmesi" RLS ile değil,
-- 0002'deki `enforce_viewer_item_columns` trigger'ı ile sağlanıyor: RLS satır
-- düzeyinde çalışır, hangi sütunun değiştiğini göremez.
--
-- ÖNEMLİ: politikalar yumuşak silmeyi (`deleted_at`) FİLTRELEMEZ. Yetkilendirme
-- ile görünürlük ayrı konular; sorgular `deleted_at is null` koşulunu kendisi
-- koyar. Böylece bir owner silinmiş kaydı geri getirebiliyor.
--
-- Her politika `(select auth.uid())` biçiminde yazıldı. Düz `auth.uid()` her
-- satır için yeniden çağrılır; alt sorgu hâlinde planlayıcı bir kez hesaplayıp
-- önbelleğe alıyor — büyük tablolarda ölçülebilir fark yapıyor.

alter table public.users enable row level security;
alter table public.user_settings enable row level security;
alter table public.categories enable row level security;
alter table public.shopping_lists enable row level security;
alter table public.list_members enable row level security;
alter table public.items enable row level security;
alter table public.activity_logs enable row level security;
alter table public.invitations enable row level security;
alter table public.list_presence enable row level security;
alter table public.chat_rooms enable row level security;
alter table public.chat_messages enable row level security;
alter table public.shared_links enable row level security;
alter table public.shopping_templates enable row level security;
alter table public.favorites enable row level security;
alter table public.recent_searches enable row level security;
alter table public.barcode_scans enable row level security;
alter table public.voice_commands enable row level security;
alter table public.device_tokens enable row level security;
alter table public.notifications enable row level security;
alter table public.user_statistics enable row level security;
alter table public.subscriptions enable row level security;
alter table public.premium_features enable row level security;
alter table public.feedback enable row level security;
alter table public.bug_reports enable row level security;

-- ================================================================ kullanıcılar

-- Kendi profilini her zaman okur. Ek olarak birlikte liste paylaştığı
-- kişilerin profilini okur — üye listesini ve "kim aldı" bilgisini çizebilmek
-- için gerekli. Tanımadığı kullanıcıların profili görünmez.
create policy users_select_self_or_co_member
  on public.users for select
  to authenticated
  using (
    id = (select auth.uid())
    or exists (
      select 1
      from public.list_members as mine
      join public.list_members as theirs on theirs.list_id = mine.list_id
      where mine.user_id = (select auth.uid())
        and mine.deleted_at is null
        and theirs.user_id = public.users.id
        and theirs.deleted_at is null
    )
  );

-- Profil satırı `handle_new_auth_user` trigger'ı tarafından açılıyor, istemci
-- insert yapmıyor. Yine de tekrar giriş gibi durumlar için kendi satırını
-- ekleyebilmesi zararsız.
create policy users_insert_self
  on public.users for insert
  to authenticated
  with check (id = (select auth.uid()));

create policy users_update_self
  on public.users for update
  to authenticated
  using (id = (select auth.uid()))
  with check (id = (select auth.uid()));

-- Abonelik alanları istemciden korunuyor: kullanıcı kendine premium veremez.
-- RLS sütun bazlı çalışmadığı için bu da trigger ile.
create or replace function public.protect_user_entitlements()
returns trigger
language plpgsql
security invoker
set search_path = ''
as $$
begin
  -- `service_role` (Edge Function) bu kontrolün dışında: mağaza doğrulaması
  -- premium'u oradan yazıyor. Kontrolü JWT talebi yerine veritabanı rolüne
  -- bakarak yapıyoruz — PostgREST anahtara göre rolü değiştirdiği için bu
  -- Supabase sürümlerinden bağımsız olarak doğru çalışıyor.
  if current_user in ('service_role', 'postgres', 'supabase_admin') then
    return new;
  end if;

  new.is_premium := old.is_premium;
  new.subscription_tier := old.subscription_tier;
  -- Sayaçlar da sunucu tarafından tutulur.
  new.list_count := old.list_count;
  new.completed_item_count := old.completed_item_count;
  new.ai_generations_this_month := old.ai_generations_this_month;
  new.ai_quota_reset_at := old.ai_quota_reset_at;
  return new;
end;
$$;

drop trigger if exists users_protect_entitlements on public.users;
create trigger users_protect_entitlements
  before update on public.users
  for each row execute function public.protect_user_entitlements();

create policy user_settings_own
  on public.user_settings for all
  to authenticated
  using (user_id = (select auth.uid()))
  with check (user_id = (select auth.uid()));

-- ================================================================= kategoriler

-- Küresel kategoriler herkese açık; kullanıcı kategorileri sahibine.
create policy categories_select_global_or_own
  on public.categories for select
  to authenticated
  using (is_global or owner_id = (select auth.uid()));

create policy categories_insert_own
  on public.categories for insert
  to authenticated
  with check (not is_global and owner_id = (select auth.uid()));

create policy categories_update_own
  on public.categories for update
  to authenticated
  using (owner_id = (select auth.uid()))
  with check (owner_id = (select auth.uid()));

create policy categories_delete_own
  on public.categories for delete
  to authenticated
  using (owner_id = (select auth.uid()));

-- =================================================================== listeler

create policy shopping_lists_select_member
  on public.shopping_lists for select
  to authenticated
  using (public.is_list_member(id));

-- Liste oluşturan kişi kendini sahip yazmak zorunda. `add_owner_as_member`
-- trigger'ı üyeliği hemen ardından ekliyor.
create policy shopping_lists_insert_own
  on public.shopping_lists for insert
  to authenticated
  with check (owner_id = (select auth.uid()));

-- Editor liste başlığını, emojisini, sıralama tercihini değiştirebilir.
-- Sahipliği devretmek yalnızca owner'ın işi — bu kontrol de trigger'da,
-- çünkü RLS `owner_id` sütununun değiştiğini göremez.
create policy shopping_lists_update_editor
  on public.shopping_lists for update
  to authenticated
  using (public.can_edit_list(id))
  with check (public.can_edit_list(id));

create or replace function public.protect_list_ownership()
returns trigger
language plpgsql
security invoker
set search_path = ''
as $$
begin
  if new.owner_id is distinct from old.owner_id
     and not public.is_list_owner(old.id) then
    raise exception 'Listeyi yalnızca sahibi devredebilir.'
      using errcode = 'insufficient_privilege';
  end if;
  return new;
end;
$$;

drop trigger if exists shopping_lists_protect_ownership on public.shopping_lists;
create trigger shopping_lists_protect_ownership
  before update on public.shopping_lists
  for each row execute function public.protect_list_ownership();

-- Kalıcı silme yalnızca sahibinde. Uygulama normalde `deleted_at` damgalıyor
-- (o bir UPDATE), bu politika gerçek `delete` içindir.
create policy shopping_lists_delete_owner
  on public.shopping_lists for delete
  to authenticated
  using (public.is_list_owner(id));

-- ------------------------------------------------------------------- üyelik

create policy list_members_select_member
  on public.list_members for select
  to authenticated
  using (public.is_list_member(list_id));

-- Davet etme: owner ve editor. Kişiyi doğrudan eklemek yerine davet akışı
-- kullanılır; bu politika owner'ın elle üye eklemesi için.
create policy list_members_insert_owner
  on public.list_members for insert
  to authenticated
  with check (public.is_list_owner(list_id));

-- Rol değiştirme yalnızca owner'da.
create policy list_members_update_owner
  on public.list_members for update
  to authenticated
  using (public.is_list_owner(list_id))
  with check (public.is_list_owner(list_id));

-- Owner üyeyi çıkarabilir; herkes kendi üyeliğini bırakabilir.
create policy list_members_delete_owner_or_self
  on public.list_members for delete
  to authenticated
  using (public.is_list_owner(list_id) or user_id = (select auth.uid()));

-- Son sahibin listeden çıkması listeyi sahipsiz bırakır; buna izin verilmiyor.
create or replace function public.prevent_last_owner_removal()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  if old.role = 'owner' and (
    select count(*)
    from public.list_members
    where list_id = old.list_id
      and role = 'owner'
      and deleted_at is null
  ) <= 1 then
    raise exception 'Listenin tek sahibi ayrılamaz: önce başka bir üyeye sahiplik verin.'
      using errcode = 'insufficient_privilege';
  end if;
  return old;
end;
$$;

drop trigger if exists list_members_prevent_last_owner on public.list_members;
create trigger list_members_prevent_last_owner
  before delete on public.list_members
  for each row execute function public.prevent_last_owner_removal();

-- -------------------------------------------------------------------- ürünler

create policy items_select_member
  on public.items for select
  to authenticated
  using (public.is_list_member(list_id));

create policy items_insert_editor
  on public.items for insert
  to authenticated
  with check (public.can_edit_list(list_id));

-- Viewer da güncelleyebilir — ama yalnızca tamamlama alanlarını. Hangi
-- sütunların değişebileceğini `enforce_viewer_item_columns` denetliyor.
create policy items_update_member
  on public.items for update
  to authenticated
  using (public.is_list_member(list_id))
  with check (public.is_list_member(list_id));

create policy items_delete_editor
  on public.items for delete
  to authenticated
  using (public.can_edit_list(list_id));

-- ================================================================== işbirliği

-- Etkinlik kaydı yalnızca eklenir. `update` ve `delete` için politika
-- TANIMLANMADI; RLS açık olduğu için politikası olmayan işlem reddedilir.
-- İz kaydının kurcalanamaz olması istatistik toplamasının doğruluğu için şart.
create policy activity_logs_select_member
  on public.activity_logs for select
  to authenticated
  using (public.is_list_member(list_id));

create policy activity_logs_insert_member
  on public.activity_logs for insert
  to authenticated
  with check (
    public.is_list_member(list_id)
    and actor_id = (select auth.uid())
  );

-- --------------------------------------------------------------------- davet

-- Daveti listenin üyeleri ve davet edilen kişinin kendisi görür. İkincisi
-- şart: davet edilen kişi henüz üye değil, ama daveti görmesi gerekiyor.
create policy invitations_select_member_or_invitee
  on public.invitations for select
  to authenticated
  using (
    public.is_list_member(list_id)
    or invitee_id = (select auth.uid())
    or invitee_email = lower((select auth.jwt() ->> 'email'))
  );

create policy invitations_insert_editor
  on public.invitations for insert
  to authenticated
  with check (
    public.can_edit_list(list_id)
    and invited_by = (select auth.uid())
  );

-- Daveti geri çekmek listenin editor/owner'ında. Kabul etme `accept_invitation`
-- RPC'sinden geçer, bu politikadan değil.
create policy invitations_update_editor
  on public.invitations for update
  to authenticated
  using (public.can_edit_list(list_id))
  with check (public.can_edit_list(list_id));

create policy invitations_delete_owner
  on public.invitations for delete
  to authenticated
  using (public.is_list_owner(list_id));

-- ------------------------------------------------------------------- varlık

create policy list_presence_select_member
  on public.list_presence for select
  to authenticated
  using (public.is_list_member(list_id));

-- Herkes yalnızca kendi varlık kaydını yazar; başkasını "çevrimiçi"
-- gösteremez.
create policy list_presence_write_self
  on public.list_presence for all
  to authenticated
  using (user_id = (select auth.uid()) and public.is_list_member(list_id))
  with check (user_id = (select auth.uid()) and public.is_list_member(list_id));

-- -------------------------------------------------------------------- sohbet

-- Oda listeyle bire bir; yetki listenin rol tablosundan geliyor.
create policy chat_rooms_select_member
  on public.chat_rooms for select
  to authenticated
  using (public.is_list_member(list_id));

-- Oda `add_owner_as_member` trigger'ıyla oluşuyor; istemcinin oda açmasına
-- gerek yok, o yüzden insert/update/delete politikası tanımlanmadı.

create policy chat_messages_select_member
  on public.chat_messages for select
  to authenticated
  using (
    exists (
      select 1
      from public.chat_rooms as room
      where room.id = public.chat_messages.room_id
        and public.is_list_member(room.list_id)
    )
  );

-- Viewer da mesaj yazabilir (rol tablosundaki "Sohbete mesaj yaz" satırı).
create policy chat_messages_insert_member
  on public.chat_messages for insert
  to authenticated
  with check (
    sender_id = (select auth.uid())
    and exists (
      select 1
      from public.chat_rooms as room
      where room.id = public.chat_messages.room_id
        and public.is_list_member(room.list_id)
    )
  );

-- Kendi mesajını düzenler ve siler. Okundu bilgisi ve tepkiler `read_by` /
-- `reactions` haritalarına yazılır; bunlar başkasının mesajında da
-- güncellenebilmeli, o yüzden ayrı bir politika var.
create policy chat_messages_update_own
  on public.chat_messages for update
  to authenticated
  using (sender_id = (select auth.uid()))
  with check (sender_id = (select auth.uid()));

create policy chat_messages_delete_own
  on public.chat_messages for delete
  to authenticated
  using (sender_id = (select auth.uid()));

-- Okundu / tepki yazmak için RPC: başkasının mesajını güncellemek gerekiyor
-- ama yalnızca kendi anahtarını değiştirmesine izin veriyoruz.
create or replace function public.mark_message_read(p_message_id uuid)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  caller uuid := auth.uid();
  room_list uuid;
begin
  select room.list_id
  into room_list
  from public.chat_messages as message
  join public.chat_rooms as room on room.id = message.room_id
  where message.id = p_message_id;

  if room_list is null or not public.is_list_member(room_list) then
    raise exception 'Bu mesaja erişiminiz yok.' using errcode = 'insufficient_privilege';
  end if;

  -- Yalnızca çağıranın kendi anahtarı yazılıyor; harita birleşiyor, üzerine
  -- yazılmıyor. Eşzamanlı okundu bildirimleri birbirini ezmez.
  update public.chat_messages
  set read_by = read_by || jsonb_build_object(caller::text, to_jsonb(now()))
  where id = p_message_id;
end;
$$;

create or replace function public.set_message_reaction(
  p_message_id uuid,
  p_emoji text
)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  caller uuid := auth.uid();
  room_list uuid;
begin
  select room.list_id
  into room_list
  from public.chat_messages as message
  join public.chat_rooms as room on room.id = message.room_id
  where message.id = p_message_id;

  if room_list is null or not public.is_list_member(room_list) then
    raise exception 'Bu mesaja erişiminiz yok.' using errcode = 'insufficient_privilege';
  end if;

  update public.chat_messages
  set reactions = case
    -- Boş emoji tepkiyi kaldırmak demek.
    when p_emoji is null or p_emoji = '' then reactions - caller::text
    else reactions || jsonb_build_object(caller::text, p_emoji)
  end
  where id = p_message_id;
end;
$$;

-- ============================================================ paylaşım / şablon

-- Bağlantıyı listenin üyeleri yönetir. Bağlantıyı ÇÖZMEK (üye olmayan biri
-- QR okuduğunda) `join_list_by_slug` RPC'sinden geçiyor; bu tablo doğrudan
-- okunamıyor, yani bağlantı kodları taranamıyor.
create policy shared_links_select_member
  on public.shared_links for select
  to authenticated
  using (public.is_list_member(list_id));

create policy shared_links_insert_editor
  on public.shared_links for insert
  to authenticated
  with check (public.can_edit_list(list_id));

create policy shared_links_update_editor
  on public.shared_links for update
  to authenticated
  using (public.can_edit_list(list_id))
  with check (public.can_edit_list(list_id));

create policy shared_links_delete_owner
  on public.shared_links for delete
  to authenticated
  using (public.is_list_owner(list_id));

create policy templates_select_public_or_own
  on public.shopping_templates for select
  to authenticated
  using (is_public or owner_id = (select auth.uid()));

create policy templates_insert_own
  on public.shopping_templates for insert
  to authenticated
  with check (owner_id = (select auth.uid()));

create policy templates_update_own
  on public.shopping_templates for update
  to authenticated
  using (owner_id = (select auth.uid()))
  with check (owner_id = (select auth.uid()));

create policy templates_delete_own
  on public.shopping_templates for delete
  to authenticated
  using (owner_id = (select auth.uid()));

-- ========================================================== kullanıcı verisi

-- Hepsi aynı desende: yalnızca sahibine, tüm işlemler.
create policy favorites_own on public.favorites for all
  to authenticated
  using (user_id = (select auth.uid()))
  with check (user_id = (select auth.uid()));

create policy recent_searches_own on public.recent_searches for all
  to authenticated
  using (user_id = (select auth.uid()))
  with check (user_id = (select auth.uid()));

create policy barcode_scans_own on public.barcode_scans for all
  to authenticated
  using (user_id = (select auth.uid()))
  with check (user_id = (select auth.uid()));

create policy voice_commands_own on public.voice_commands for all
  to authenticated
  using (user_id = (select auth.uid()))
  with check (user_id = (select auth.uid()));

create policy device_tokens_own on public.device_tokens for all
  to authenticated
  using (user_id = (select auth.uid()))
  with check (user_id = (select auth.uid()));

-- Bildirimler sunucu tarafından üretilir; istemci okur ve okundu işaretler.
create policy notifications_select_own
  on public.notifications for select
  to authenticated
  using (user_id = (select auth.uid()));

create policy notifications_update_own
  on public.notifications for update
  to authenticated
  using (user_id = (select auth.uid()))
  with check (user_id = (select auth.uid()));

create policy notifications_delete_own
  on public.notifications for delete
  to authenticated
  using (user_id = (select auth.uid()));

-- İstatistik salt okunur: toplamayı Edge Function yapıyor. `insert`/`update`
-- politikası yok, yani istemci sayıları uyduramıyor.
create policy user_statistics_select_own
  on public.user_statistics for select
  to authenticated
  using (user_id = (select auth.uid()));

-- Abonelik de salt okunur; yazma mağaza webhook'unda (service_role).
create policy subscriptions_select_own
  on public.subscriptions for select
  to authenticated
  using (user_id = (select auth.uid()));

-- Premium özellik tanımları herkese okunur.
create policy premium_features_select_all
  on public.premium_features for select
  to authenticated
  using (true);

-- ===================================================== geri bildirim / hata

-- Gönderilir ama geri okunmaz: kullanıcı kendi gönderdiğini görür.
create policy feedback_insert_self
  on public.feedback for insert
  to authenticated
  with check (user_id = (select auth.uid()));

create policy feedback_select_own
  on public.feedback for select
  to authenticated
  using (user_id = (select auth.uid()));

create policy bug_reports_insert_self
  on public.bug_reports for insert
  to authenticated
  with check (user_id = (select auth.uid()));

create policy bug_reports_select_own
  on public.bug_reports for select
  to authenticated
  using (user_id = (select auth.uid()));

-- ================================================================ yetkiler

-- `authenticated` rolüne tablo düzeyinde izin açıkça veriliyor. Supabase bunu
-- öntanımlı ayrıcalıklarla da yapıyor, ama buna güvenmek istemiyoruz: izinler
-- açıkça yazılı olmalı. Satır düzeyindeki asıl karar yukarıdaki politikalarda.
grant usage on schema public to authenticated;
grant select, insert, update, delete on all tables in schema public to authenticated;

-- `anon` rolüne hiçbir tablo açılmıyor: uygulamanın tamamı giriş gerektiriyor.
-- Davet bağlantısı çözümü de `security definer` RPC'den geçiyor, tablo
-- erişiminden değil — yani bağlantı kodları taranamıyor.
revoke all on all tables in schema public from anon;

-- Bundan sonra oluşturulacak tablolar da aynı kurala uysun. Yalnızca mevcut
-- tabloları düzeltmek, ileride eklenen bir tabloyu anon'a açık bırakırdı.
alter default privileges in schema public
  grant select, insert, update, delete on tables to authenticated;
alter default privileges in schema public
  revoke all on tables from anon;

-- RPC'ler yalnızca giriş yapmış kullanıcıya açık.
revoke all on function public.join_list_by_slug(text) from public, anon;
revoke all on function public.accept_invitation(uuid) from public, anon;
revoke all on function public.touch_presence(uuid, uuid, text) from public, anon;
revoke all on function public.mark_message_read(uuid) from public, anon;
revoke all on function public.set_message_reaction(uuid, text) from public, anon;

grant execute on function public.join_list_by_slug(text) to authenticated;
grant execute on function public.accept_invitation(uuid) to authenticated;
grant execute on function public.touch_presence(uuid, uuid, text) to authenticated;
grant execute on function public.mark_message_read(uuid) to authenticated;
grant execute on function public.set_message_reaction(uuid, text) to authenticated;
grant execute on function public.next_item_sort_order(uuid) to authenticated;
