-- SmartList — fonksiyonlar ve trigger'lar
--
-- Üç grup var:
--   1. Denetim alanlarını yazan trigger'lar (istemci bunlara güvenmek zorunda
--      değil, sunucu damgalıyor).
--   2. Yetki yardımcıları. RLS politikaları bunları çağırır. `security definer`
--      olmaları ZORUNLU: `shopping_lists` politikası `list_members`'a,
--      `list_members` politikası `shopping_lists`'e bakarsa RLS sonsuz
--      özyinelemeye girer. Bu fonksiyonlar RLS'i atlayarak o döngüyü kırıyor.
--   3. Sayaç trigger'ları — liste kartının tek satır okumasıyla çizilebilmesi
--      için `item_count` gibi alanları güncel tutuyor.
--
-- `security definer` fonksiyonlarda `search_path = ''` ayarlanıyor ve her ad
-- tam nitelikli yazılıyor. Aksi hâlde saldırgan kendi şemasına aynı adla bir
-- nesne koyup fonksiyonu kendi lehine çalıştırabilir.

-- ============================================================== denetim alanları

create or replace function public.set_created_audit()
returns trigger
language plpgsql
security invoker
set search_path = ''
as $$
begin
  new.created_at := now();
  new.updated_at := now();
  -- İstemci açıkça bir değer vermediyse oturumdaki kullanıcı yazılır.
  new.created_by := coalesce(new.created_by, auth.uid());
  new.updated_by := new.created_by;
  new.version := 1;
  return new;
end;
$$;

create or replace function public.touch_audit()
returns trigger
language plpgsql
security invoker
set search_path = ''
as $$
begin
  -- Oluşturma bilgisi değiştirilemez: kim ne zaman oluşturdu sorusunun cevabı
  -- sonradan yeniden yazılabilir olmamalı.
  new.created_at := old.created_at;
  new.created_by := old.created_by;

  new.updated_at := now();
  new.updated_by := coalesce(auth.uid(), old.updated_by);

  -- İyimser eşzamanlılık: sürüm her yazmada artar. Çakışmayı yakalamak isteyen
  -- istemci güncellemeye `.eq('version', okuduğuSürüm)` ekler; sürüm değiştiyse
  -- sorgu 0 satır etkiler ve istemci yeniden okur.
  new.version := old.version + 1;

  return new;
end;
$$;

-- Denetim bloğu taşıyan her tabloya aynı iki trigger bağlanır.
--
-- `drop ... if exists` önce çağrılıyor: migration'ı geliştirme sırasında
-- yeniden çalıştırmak "trigger already exists" ile düşmesin.
do $$
declare
  audited_table text;
begin
  foreach audited_table in array array[
    'users', 'categories', 'shopping_lists', 'list_members', 'items',
    'invitations', 'chat_rooms', 'chat_messages', 'shared_links',
    'shopping_templates', 'notifications'
  ]
  loop
    execute format(
      'drop trigger if exists %I on public.%I',
      audited_table || '_set_created_audit', audited_table
    );
    execute format(
      'create trigger %I before insert on public.%I
         for each row execute function public.set_created_audit()',
      audited_table || '_set_created_audit', audited_table
    );

    execute format(
      'drop trigger if exists %I on public.%I',
      audited_table || '_touch_audit', audited_table
    );
    execute format(
      'create trigger %I before update on public.%I
         for each row execute function public.touch_audit()',
      audited_table || '_touch_audit', audited_table
    );
  end loop;
end;
$$;

-- `updated_at` taşıyan ama tam denetim bloğu olmayan tablolar.
create or replace function public.touch_updated_at()
returns trigger
language plpgsql
security invoker
set search_path = ''
as $$
begin
  new.updated_at := now();
  return new;
end;
$$;

do $$
declare
  touched_table text;
begin
  foreach touched_table in array array[
    'user_settings', 'favorites', 'recent_searches', 'barcode_scans',
    'voice_commands', 'device_tokens', 'user_statistics', 'subscriptions',
    'premium_features', 'bug_reports'
  ]
  loop
    execute format(
      'drop trigger if exists %I on public.%I',
      touched_table || '_touch_updated_at', touched_table
    );
    execute format(
      'create trigger %I before update on public.%I
         for each row execute function public.touch_updated_at()',
      touched_table || '_touch_updated_at', touched_table
    );
  end loop;
end;
$$;

-- ============================================================ yetki yardımcıları

-- Oturumdaki kullanıcının listedeki rolü. Üye değilse null döner.
create or replace function public.role_on_list(p_list_id uuid)
returns public.member_role
language sql
security definer
stable
set search_path = ''
as $$
  select member.role
  from public.list_members as member
  where member.list_id = p_list_id
    and member.user_id = auth.uid()
    and member.deleted_at is null
  limit 1;
$$;

comment on function public.role_on_list(uuid) is
  'RLS politikalarının kullandığı rol çözümleyici. security definer olmasi RLS özyinelemesini kırar.';

create or replace function public.is_list_member(p_list_id uuid)
returns boolean
language sql
security definer
stable
set search_path = ''
as $$
  select public.role_on_list(p_list_id) is not null;
$$;

-- Ürün ekleyip düzenleyebilenler.
create or replace function public.can_edit_list(p_list_id uuid)
returns boolean
language sql
security definer
stable
set search_path = ''
as $$
  select public.role_on_list(p_list_id) in ('editor', 'owner');
$$;

create or replace function public.is_list_owner(p_list_id uuid)
returns boolean
language sql
security definer
stable
set search_path = ''
as $$
  select public.role_on_list(p_list_id) = 'owner';
$$;

-- Viewer ürünü işaretleyebilir ama içeriğini değiştiremez. Postgres'te RLS
-- hangi SÜTUNUN değiştiğini denetleyemez, o yüzden bu kontrol trigger'da.
-- Sütun bazlı GRANT de yetmez: kısıt role göre değil LİSTEYE göre değişiyor.
create or replace function public.enforce_viewer_item_columns()
returns trigger
language plpgsql
security invoker
set search_path = ''
as $$
begin
  if public.role_on_list(new.list_id) <> 'viewer' then
    return new;
  end if;

  -- Viewer'a izin verilen alanlar: tamamlama ve satın alma durumu.
  -- Bunların dışında bir şey değiştiyse yazma reddedilir.
  if new.list_id is distinct from old.list_id
     or new.name is distinct from old.name
     or new.quantity is distinct from old.quantity
     or new.unit is distinct from old.unit
     or new.category_id is distinct from old.category_id
     or new.notes is distinct from old.notes
     or new.price is distinct from old.price
     or new.currency is distinct from old.currency
     or new.priority is distinct from old.priority
     or new.image_url is distinct from old.image_url
     or new.barcode is distinct from old.barcode
     or new.barcode_format is distinct from old.barcode_format
     or new.brand is distinct from old.brand
     or new.sort_order is distinct from old.sort_order
     or new.source is distinct from old.source
     or new.deleted_at is distinct from old.deleted_at
  then
    raise exception
      'Bu listede yalnızca izleyicisiniz: ürünü tamamlandı olarak işaretleyebilirsiniz, içeriğini değiştiremezsiniz.'
      using errcode = 'insufficient_privilege';
  end if;

  return new;
end;
$$;

drop trigger if exists items_enforce_viewer_columns on public.items;
create trigger items_enforce_viewer_columns
  before update on public.items
  for each row execute function public.enforce_viewer_item_columns();

-- ============================================================ hesap açılışı

-- Yeni kimlik kaydı geldiğinde profil ve ayar satırları da oluşur. Bunu
-- istemciye bırakmak, kayıt sırasında ağ kesilirse profilsiz hesap bırakır.
create or replace function public.handle_new_auth_user()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  insert into public.users (id, email, display_name, photo_url, is_email_verified)
  values (
    new.id,
    new.email,
    -- Kayıt formundan gelen ad; yoksa e-postanın kullanıcı adı kısmı.
    coalesce(
      nullif(trim(new.raw_user_meta_data ->> 'display_name'), ''),
      nullif(trim(new.raw_user_meta_data ->> 'full_name'), ''),
      split_part(new.email, '@', 1)
    ),
    nullif(trim(new.raw_user_meta_data ->> 'avatar_url'), ''),
    new.email_confirmed_at is not null
  )
  on conflict (id) do nothing;

  insert into public.user_settings (user_id)
  values (new.id)
  on conflict (user_id) do nothing;

  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_auth_user();

-- ============================================================== liste sahipliği

-- Liste oluşturan kişi otomatik olarak owner üyesi olur. Olmazsa oluşturduğu
-- listeyi RLS yüzünden okuyamaz.
create or replace function public.add_owner_as_member()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  owner_profile record;
begin
  select display_name, email, photo_url
  into owner_profile
  from public.users
  where id = new.owner_id;

  insert into public.list_members (
    list_id, user_id, role, display_name, email, photo_url,
    joined_at, created_by, updated_by
  )
  values (
    new.id, new.owner_id, 'owner',
    coalesce(owner_profile.display_name, ''),
    coalesce(owner_profile.email, ''),
    owner_profile.photo_url,
    now(), new.owner_id, new.owner_id
  )
  on conflict (list_id, user_id) do nothing;

  -- Her liste bir sohbet odasıyla birlikte gelir; oda listeyle bire bir.
  insert into public.chat_rooms (list_id, created_by, updated_by)
  values (new.id, new.owner_id, new.owner_id)
  on conflict (list_id) do nothing;

  return new;
end;
$$;

drop trigger if exists shopping_lists_add_owner_member on public.shopping_lists;
create trigger shopping_lists_add_owner_member
  after insert on public.shopping_lists
  for each row execute function public.add_owner_as_member();

-- ================================================================ sayaçlar

create or replace function public.refresh_list_item_counters()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  target_list uuid := coalesce(new.list_id, old.list_id);
  live_count integer;
  done_count integer;
  spent numeric(12, 2);
begin
  select
    count(*),
    count(*) filter (where is_completed),
    coalesce(sum(price * quantity) filter (where is_completed), 0)
  into live_count, done_count, spent
  from public.items
  where list_id = target_list
    and deleted_at is null;

  update public.shopping_lists
  set item_count = live_count,
      completed_item_count = done_count,
      total_spent = spent,
      -- Boş liste "tamamlandı" sayılmaz; kullanıcı hiçbir şey almadı.
      is_completed = (live_count > 0 and done_count = live_count),
      completed_at = case
        when live_count > 0 and done_count = live_count then coalesce(completed_at, now())
        else null
      end,
      last_activity_at = now()
  where id = target_list;

  return null;
end;
$$;

drop trigger if exists items_refresh_counters on public.items;
create trigger items_refresh_counters
  after insert or update or delete on public.items
  for each row execute function public.refresh_list_item_counters();

create or replace function public.refresh_list_member_counter()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  target_list uuid := coalesce(new.list_id, old.list_id);
begin
  update public.shopping_lists
  set member_count = (
    select count(*)
    from public.list_members
    where list_id = target_list
      and deleted_at is null
  )
  where id = target_list;

  return null;
end;
$$;

drop trigger if exists list_members_refresh_counter on public.list_members;
create trigger list_members_refresh_counter
  after insert or update or delete on public.list_members
  for each row execute function public.refresh_list_member_counter();

create or replace function public.refresh_room_message_summary()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  target_room uuid := coalesce(new.room_id, old.room_id);
  total integer;
  newest record;
begin
  select count(*)
  into total
  from public.chat_messages
  where room_id = target_room
    and deleted_at is null;

  -- Son mesaj ayrı okunuyor: `update ... from (subquery)` biçimi oda
  -- boşaldığında hiçbir satır etkilemez ve özet eski mesajda takılı kalırdı.
  select body, sender_id, sender_name, type, created_at
  into newest
  from public.chat_messages
  where room_id = target_room
    and deleted_at is null
  order by created_at desc
  limit 1;

  update public.chat_rooms
  set message_count = total,
      last_message_preview = coalesce(newest.body, ''),
      last_message_sender_id = newest.sender_id,
      last_message_sender_name = coalesce(newest.sender_name, ''),
      last_message_type = newest.type,
      last_message_at = newest.created_at
  where id = target_room;

  return null;
end;
$$;

drop trigger if exists chat_messages_refresh_summary on public.chat_messages;
create trigger chat_messages_refresh_summary
  after insert or update or delete on public.chat_messages
  for each row execute function public.refresh_room_message_summary();

-- ============================================================ küçük yardımcılar

-- Davet e-postası büyük/küçük harfe duyarsız eşleşsin diye normalleştirilir.
create or replace function public.normalise_invitation_email()
returns trigger
language plpgsql
security invoker
set search_path = ''
as $$
begin
  new.invitee_email := lower(trim(new.invitee_email));
  return new;
end;
$$;

drop trigger if exists invitations_normalise_email on public.invitations;
create trigger invitations_normalise_email
  before insert or update on public.invitations
  for each row execute function public.normalise_invitation_email();

-- Paylaşım bağlantısı için okunabilir, tahmin edilmesi zor kod.
-- Karışan karakterler (0/O, 1/I/l) alfabeden çıkarıldı: kullanıcı kodu elle
-- yazabilsin diye.
create or replace function public.generate_link_slug(p_length integer default 8)
returns text
language plpgsql
security invoker
set search_path = ''
as $$
declare
  alphabet constant text := 'ABCDEFGHJKMNPQRSTUVWXYZ23456789';
  result text := '';
begin
  for _ in 1..p_length loop
    result := result || substr(
      alphabet,
      1 + floor(random() * length(alphabet))::integer,
      1
    );
  end loop;
  return result;
end;
$$;

-- Sürükle-bırak sıralaması için yeni ürünün alacağı değer.
create or replace function public.next_item_sort_order(p_list_id uuid)
returns double precision
language sql
security definer
stable
set search_path = ''
as $$
  select coalesce(max(sort_order), 0) + 1000
  from public.items
  where list_id = p_list_id
    and deleted_at is null;
$$;

-- ====================================================== katılma akışları (RPC)

-- QR kodu / paylaşım bağlantısıyla listeye katılma.
--
-- Bunun bir RPC olması zorunlu: katılmak isteyen kişi HENÜZ üye değil, yani
-- RLS ona `list_members`'a satır ekleme izni vermiyor. `security definer`
-- fonksiyon bu kapıyı kontrollü biçimde açıyor — bağlantının geçerliliğini
-- kendisi doğruluyor.
create or replace function public.join_list_by_slug(p_slug text)
returns uuid
language plpgsql
security definer
set search_path = ''
as $$
declare
  link record;
  caller uuid := auth.uid();
  caller_profile record;
begin
  if caller is null then
    raise exception 'Listeye katılmak için giriş yapmalısınız.'
      using errcode = 'insufficient_privilege';
  end if;

  select *
  into link
  from public.shared_links
  where slug = p_slug
    and deleted_at is null
  for update;

  if not found or not link.is_active then
    raise exception 'Bu davet bağlantısı geçerli değil.' using errcode = 'no_data_found';
  end if;

  if link.expires_at is not null and link.expires_at < now() then
    raise exception 'Bu davet bağlantısının süresi dolmuş.' using errcode = 'no_data_found';
  end if;

  if link.max_uses is not null and link.use_count >= link.max_uses then
    raise exception 'Bu davet bağlantısı kullanım sınırına ulaştı.' using errcode = 'no_data_found';
  end if;

  select display_name, email, photo_url
  into caller_profile
  from public.users
  where id = caller;

  insert into public.list_members (
    list_id, user_id, role, display_name, email, photo_url,
    joined_at, created_by, updated_by
  )
  values (
    link.list_id, caller, link.role,
    coalesce(caller_profile.display_name, ''),
    coalesce(caller_profile.email, ''),
    caller_profile.photo_url,
    now(), caller, caller
  )
  -- Zaten üyeyse rolü düşürmüyoruz: bağlantı viewer verse bile editor olan
  -- kişi editor kalır.
  on conflict (list_id, user_id) do nothing;

  update public.shared_links
  set use_count = use_count + 1
  where id = link.id;

  insert into public.activity_logs (list_id, actor_id, action, actor_name, target_name)
  values (
    link.list_id, caller, 'member_joined',
    coalesce(caller_profile.display_name, ''), link.list_title
  );

  return link.list_id;
end;
$$;

-- E-posta davetini kabul etme. Aynı gerekçeyle RPC: davet edilen kişi üye
-- olmadığı için doğrudan ekleme yapamaz.
create or replace function public.accept_invitation(p_invitation_id uuid)
returns uuid
language plpgsql
security definer
set search_path = ''
as $$
declare
  invite record;
  caller uuid := auth.uid();
  caller_email text;
  caller_profile record;
begin
  if caller is null then
    raise exception 'Daveti kabul etmek için giriş yapmalısınız.'
      using errcode = 'insufficient_privilege';
  end if;

  select display_name, email, photo_url
  into caller_profile
  from public.users
  where id = caller;

  caller_email := lower(trim(coalesce(caller_profile.email, '')));

  select *
  into invite
  from public.invitations
  where id = p_invitation_id
    and deleted_at is null
  for update;

  if not found or invite.status <> 'pending' then
    raise exception 'Davet bulunamadı veya yanıtlanmış.' using errcode = 'no_data_found';
  end if;

  -- Davet e-postası oturumdaki hesaba ait olmalı; başkasının davetini
  -- kabul etmek mümkün değil.
  if invite.invitee_email <> caller_email then
    raise exception 'Bu davet başka bir e-posta adresine gönderilmiş.'
      using errcode = 'insufficient_privilege';
  end if;

  if invite.expires_at is not null and invite.expires_at < now() then
    update public.invitations set status = 'expired' where id = invite.id;
    raise exception 'Bu davetin süresi dolmuş.' using errcode = 'no_data_found';
  end if;

  insert into public.list_members (
    list_id, user_id, role, display_name, email, photo_url,
    joined_at, invited_by, created_by, updated_by
  )
  values (
    invite.list_id, caller, invite.role,
    coalesce(caller_profile.display_name, ''), caller_email,
    caller_profile.photo_url,
    now(), invite.invited_by, caller, caller
  )
  -- Zaten üyeyse rolü DÜŞÜRMÜYORUZ: davet viewer verse bile editor olan kişi
  -- editor kalır. Enum sırası guest < viewer < editor < owner olarak
  -- tanımlandığı için `greatest` doğru olanı seçiyor.
  on conflict (list_id, user_id) do update
    set role = greatest(list_members.role, excluded.role);

  update public.invitations
  set status = 'accepted',
      invitee_id = caller,
      responded_at = now()
  where id = invite.id;

  insert into public.activity_logs (list_id, actor_id, action, actor_name, target_name)
  values (
    invite.list_id, caller, 'member_joined',
    coalesce(caller_profile.display_name, ''), invite.list_title
  );

  return invite.list_id;
end;
$$;

-- Varlık kalp atışı. Kendi satırını yazar; RLS ile de korunuyor ama tek
-- çağrıyla upsert yapmak istemci tarafını basitleştiriyor.
create or replace function public.touch_presence(
  p_list_id uuid,
  p_editing_item_id uuid default null,
  p_device_id text default ''
)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  caller uuid := auth.uid();
  caller_profile record;
begin
  if caller is null or not public.is_list_member(p_list_id) then
    raise exception 'Bu listeye erişiminiz yok.' using errcode = 'insufficient_privilege';
  end if;

  select display_name, photo_url into caller_profile
  from public.users where id = caller;

  insert into public.list_presence (
    list_id, user_id, last_seen_at, is_online, display_name, photo_url,
    editing_item_id, device_id
  )
  values (
    p_list_id, caller, now(), true,
    coalesce(caller_profile.display_name, ''), caller_profile.photo_url,
    p_editing_item_id, p_device_id
  )
  on conflict (list_id, user_id) do update
    set last_seen_at = now(),
        is_online = true,
        display_name = excluded.display_name,
        photo_url = excluded.photo_url,
        editing_item_id = excluded.editing_item_id,
        device_id = excluded.device_id;
end;
$$;
