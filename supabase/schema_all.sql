-- SmartList — TAM SEMA (tek dosya)
--
-- Bu dosya supabase/migrations/ altindaki 7 dosyanin sirali
-- birlesimidir. Uretilen bir dosyadir; ELLE DUZENLEMEYIN. Kaynak dosyalari
-- degistirip yeniden uretin:
--
--   node -e "..."  ya da  .scriptssupabase_push.ps1
--
-- ============================ NASIL UYGULANIR ============================
--
-- YOL 1 — Dashboard (veritabani sifresi GEREKMEZ):
--   1. Supabase Dashboard > sol menu > SQL Editor > New query
--   2. Bu dosyanin TAMAMINI kopyalayip yapistirin
--   3. Run (Ctrl+Enter)
--
-- YOL 2 — CLI (Session pooler baglanti dizgesi gerekir):
--   .scriptssupabase_push.ps1
--
-- Iki yol da yeniden calistirilabilir: trigger'lar, yayin ve baslangic
-- verisi "varsa atla" bicimde yazildi. Tablolar icin ise ilk calistirmadan
-- sonra "already exists" hatasi normaldir.
--
-- Uygulandiktan sonra dogrulama:
--   .scriptssupabase_push.ps1 -Verify
--
-- =========================================================================


-- ======================================================================
-- DOSYA: 20260725090000_types.sql
-- ======================================================================

-- SmartList — enum türleri ve eklentiler
--
-- Enum'lar Dart tarafındaki `lib/models/enums.dart` ile birebir aynı "wire"
-- değerlerini kullanır. Metin sütun yerine gerçek enum tipi seçildi: veritabanı
-- geçersiz değeri reddediyor ve tablo içeriği elle okunduğunda anlaşılır kalıyor.
-- Yeni değer eklemek `alter type ... add value` gerektirir; bu bilinçli bir
-- takas, çünkü asıl risk uygulamanın veritabanına tanımsız bir durum yazması.

-- Trigram indeksleri ürün ve liste adı aramasında kullanılıyor. Supabase
-- eklentileri `extensions` şemasında tutar; buraya kurmak `public` şemasını
-- temiz bırakıyor.
create extension if not exists pg_trgm with schema extensions;

-- ---------------------------------------------------------------- yetkilendirme

-- Sıralama önemli: `order by role desc` en yetkiliden en yetkisize sıralasın
-- diye en düşük yetki başta tanımlanıyor.
create type public.member_role as enum ('guest', 'viewer', 'editor', 'owner');

create type public.subscription_tier as enum ('free', 'plus', 'family');

-- ------------------------------------------------------------------ listeler

create type public.item_priority as enum ('low', 'normal', 'high', 'urgent');

create type public.measurement_unit as enum (
  'piece', 'g', 'kg', 'ml', 'l', 'pack', 'box', 'bottle', 'can', 'bag',
  'bunch', 'dozen', 'oz', 'lb', 'fl_oz', 'gal'
);

create type public.measurement_system as enum ('metric', 'imperial');

create type public.item_source as enum (
  'manual', 'voice', 'barcode', 'ai', 'template', 'duplicate'
);

create type public.list_sort_option as enum (
  'recently_updated', 'created_newest', 'created_oldest', 'alphabetical',
  'completion', 'member_count'
);

create type public.item_sort_option as enum (
  'manual', 'alphabetical', 'category', 'priority', 'completion',
  'recently_added'
);

-- -------------------------------------------------------------- işbirliği

create type public.invitation_status as enum (
  'pending', 'accepted', 'declined', 'revoked', 'expired'
);

create type public.message_type as enum ('text', 'image', 'voice', 'system');

create type public.activity_action as enum (
  'list_created', 'list_updated', 'list_archived', 'list_unarchived',
  'list_deleted', 'list_duplicated', 'list_completed',
  'item_added', 'item_updated', 'item_completed', 'item_uncompleted',
  'item_deleted', 'item_reordered',
  'member_invited', 'member_joined', 'member_removed', 'member_left',
  'member_role_changed',
  'message_sent', 'ai_generated'
);

create type public.notification_type as enum (
  'invitation_received', 'invitation_accepted', 'item_added', 'item_deleted',
  'item_completed', 'list_completed', 'list_shared', 'member_joined',
  'member_left', 'message_received', 'mention', 'reminder', 'system'
);

-- ------------------------------------------------------------ giriş yöntemleri

create type public.barcode_symbology as enum (
  'ean13', 'ean8', 'upc_a', 'upc_e', 'qr', 'isbn', 'code128', 'code39',
  'itf', 'data_matrix', 'unknown'
);

create type public.voice_command_status as enum (
  'listening', 'transcribed', 'parsed', 'applied', 'failed'
);

-- ----------------------------------------------------------------- kullanıcı

create type public.app_theme_mode as enum ('light', 'dark', 'system');

create type public.device_platform as enum ('android', 'ios', 'web', 'other');

create type public.favorite_target_type as enum ('list', 'item', 'template');

create type public.statistics_period as enum (
  'daily', 'weekly', 'monthly', 'yearly', 'all_time'
);

create type public.ai_list_kind as enum (
  'weekly_shopping', 'meal_plan', 'party', 'baby', 'diet', 'custom'
);

create type public.ai_provider_kind as enum ('openai', 'gemini', 'claude');

-- ------------------------------------------------------------------ destek

create type public.bug_severity as enum ('low', 'medium', 'high', 'critical');

create type public.report_status as enum (
  'open', 'triaged', 'in_progress', 'resolved', 'closed'
);

-- ======================================================================
-- DOSYA: 20260725090100_tables.sql
-- ======================================================================

-- SmartList — tablolar
--
-- Firestore'daki 28 koleksiyonun ilişkisel karşılığı. İki yapısal değişiklik
-- var, ikisi de Postgres'in Firestore'da elle yapmak zorunda kaldığım şeyleri
-- kendisi yapmasından kaynaklanıyor:
--
--   1. Üyelik artık listenin üstünde denormalize DEĞİL. Firestore'da
--      `memberIds` dizisi + `memberRoles` haritası tutuyordum, çünkü güvenlik
--      kuralları ek okuma yapmadan yetki kontrolü yapabilsin diye gerekiyordu.
--      Postgres'te `list_members` tablosu ve foreign key yeterli; RLS
--      politikaları bu tabloyu sorguluyor.
--
--   2. Sayaçlar (`item_count`, `completed_item_count`, `member_count`) yine
--      listede duruyor ama artık trigger güncelliyor, uygulama değil. Ana
--      ekranda liste kartı için tek satır okuması yeterli olsun diye
--      korunuyorlar.
--
-- Denetim (audit) bloğu her değişebilir tabloda aynı:
--   created_at / created_by / updated_at / updated_by / deleted_at / version
-- `updated_at`, `updated_by` ve `version` değerlerini 0003 dosyasındaki
-- `touch_audit()` trigger'ı yazıyor; istemci bu alanlara güvenmek zorunda değil.
--
-- Yumuşak silme (soft delete): `deleted_at` damgalanır, satır durur. RLS
-- politikaları bu alanı FİLTRELEMEZ — yetkilendirme ile görünürlük ayrı
-- konular. Sorgular `deleted_at is null` koşulunu kendisi koyar; kısmi
-- indeksler (0005) bu koşulu destekler.

-- ================================================================ kullanıcılar

-- `auth.users` Supabase'in kendi tablosu ve doğrudan yazılamaz. `public.users`
-- uygulamanın profil tablosu; birincil anahtarı auth kaydına bağlı, yani bir
-- hesap silinince profili de gider.
create table public.users (
  id uuid primary key references auth.users (id) on delete cascade,

  email text not null,
  display_name text not null default '',
  photo_url text,
  phone_number text,

  is_email_verified boolean not null default false,

  -- Abonelik alanları YALNIZCA sunucu tarafından yazılır (bkz. 0004 RLS).
  -- İstemci kendine premium veremez.
  is_premium boolean not null default false,
  subscription_tier public.subscription_tier not null default 'free',

  is_online boolean not null default false,
  last_seen_at timestamptz,

  locale text not null default 'tr',
  timezone text,
  provider_ids text[] not null default '{}',

  list_count integer not null default 0,
  completed_item_count integer not null default 0,

  -- Yapay zekâ kotası: aylık üretim sayısı ve sıfırlanma anı.
  ai_generations_this_month integer not null default 0,
  ai_quota_reset_at timestamptz,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by uuid,
  updated_by uuid,
  deleted_at timestamptz,
  version integer not null default 1,

  constraint users_email_not_blank check (length(trim(email)) > 0)
);

comment on table public.users is
  'Uygulama profili. auth.users kimlik doğrulamayı, bu tablo uygulama verisini tutar.';

-- Ayarlar ayrı tabloda: profil her liste kartında okunuyor, ayarlar yalnızca
-- ayarlar ekranında. Aynı satırda tutmak her okumaya 30 sütun bindirirdi.
create table public.user_settings (
  user_id uuid primary key references public.users (id) on delete cascade,

  theme_mode public.app_theme_mode not null default 'system',
  locale text not null default 'tr',
  currency text not null default 'TRY',
  measurement_system public.measurement_system not null default 'metric',

  push_enabled boolean not null default true,
  notify_on_item_added boolean not null default true,
  notify_on_item_completed boolean not null default true,
  notify_on_item_deleted boolean not null default true,
  notify_on_list_completed boolean not null default true,
  notify_on_new_message boolean not null default true,
  notify_on_mention boolean not null default true,
  notify_on_invitation boolean not null default true,

  -- Gün içindeki dakika olarak sessiz saatler (0..1439). Eşitse kapalı sayılır.
  quiet_hours_start_minute integer not null default 0,
  quiet_hours_end_minute integer not null default 0,

  show_online_status boolean not null default true,
  show_read_receipts boolean not null default true,
  show_typing_indicator boolean not null default true,
  allow_analytics boolean not null default true,
  allow_crash_reporting boolean not null default true,

  default_list_sort public.list_sort_option not null default 'recently_updated',
  default_item_sort public.item_sort_option not null default 'manual',
  move_completed_to_bottom boolean not null default true,
  hide_completed_items boolean not null default false,
  confirm_before_delete boolean not null default true,
  haptic_feedback boolean not null default true,

  ai_provider public.ai_provider_kind not null default 'claude',

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  version integer not null default 1,

  constraint quiet_hours_start_in_day
    check (quiet_hours_start_minute between 0 and 1439),
  constraint quiet_hours_end_in_day
    check (quiet_hours_end_minute between 0 and 1439)
);

-- ================================================================= kategoriler

-- Küresel (uygulamanın hazır kategorileri) veya kullanıcıya ait olabilir.
-- `is_global` ile `owner_id` birbirini dışlar; kısıt bunu garanti ediyor.
create table public.categories (
  id uuid primary key default gen_random_uuid(),

  name text not null,
  owner_id uuid references public.users (id) on delete cascade,
  is_global boolean not null default false,

  emoji text not null default '📦',
  color_hex text not null default 'FF3525CD',

  -- Küresel kategorilerin çeviri anahtarı; kullanıcı kategorisinde boş kalır.
  localization_key text not null default '',
  sort_order integer not null default 0,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by uuid,
  updated_by uuid,
  deleted_at timestamptz,
  version integer not null default 1,

  constraint categories_global_xor_owned
    check ((is_global and owner_id is null) or (not is_global and owner_id is not null)),
  constraint categories_color_hex_format check (color_hex ~ '^[0-9A-Fa-f]{8}$')
);

-- =================================================================== listeler

create table public.shopping_lists (
  id uuid primary key default gen_random_uuid(),

  title text not null,
  owner_id uuid not null references public.users (id) on delete cascade,

  description text not null default '',
  emoji text not null default '🛒',
  color_hex text not null default 'FF3525CD',
  category_id uuid references public.categories (id) on delete set null,

  -- Trigger tarafından tutulan sayaçlar; okuma tarafında JOIN'den kaçınmak için.
  member_count integer not null default 1,
  item_count integer not null default 0,
  completed_item_count integer not null default 0,

  is_archived boolean not null default false,
  is_pinned boolean not null default false,
  is_favorite boolean not null default false,
  is_completed boolean not null default false,
  completed_at timestamptz,

  -- Ana ekran sıralaması bunu kullanır; ürün eklendiğinde trigger tazeler.
  last_activity_at timestamptz,

  item_sort_option public.item_sort_option not null default 'manual',

  budget numeric(12, 2),
  currency text not null default 'TRY',
  total_spent numeric(12, 2) not null default 0,

  tags text[] not null default '{}',
  generated_from public.ai_list_kind,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by uuid,
  updated_by uuid,
  deleted_at timestamptz,
  version integer not null default 1,

  constraint shopping_lists_title_not_blank check (length(trim(title)) > 0),
  constraint shopping_lists_color_hex_format check (color_hex ~ '^[0-9A-Fa-f]{8}$'),
  constraint shopping_lists_budget_non_negative check (budget is null or budget >= 0),
  constraint shopping_lists_counters_non_negative
    check (member_count >= 0 and item_count >= 0 and completed_item_count >= 0)
);

-- Üyelik ve rol. Firestore'daki `memberRoles` haritasının yerini alıyor.
create table public.list_members (
  id uuid primary key default gen_random_uuid(),

  list_id uuid not null references public.shopping_lists (id) on delete cascade,
  user_id uuid not null references public.users (id) on delete cascade,
  role public.member_role not null default 'viewer',

  -- Üye listesini çizmek için kopyalanan alanlar; her üye için profil
  -- okumasından kaçınmak adına burada duruyor.
  display_name text not null default '',
  email text not null default '',
  photo_url text,

  joined_at timestamptz,
  invited_by uuid references public.users (id) on delete set null,

  items_added integer not null default 0,
  items_completed integer not null default 0,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by uuid,
  updated_by uuid,
  deleted_at timestamptz,
  version integer not null default 1,

  -- Bir kullanıcı bir listede yalnızca bir kez üye olabilir. Firestore'da
  -- belge kimliğini uid yaparak sağlıyordum; burada kısıt açıkça duruyor.
  constraint list_members_unique_per_list unique (list_id, user_id)
);

create table public.items (
  id uuid primary key default gen_random_uuid(),

  list_id uuid not null references public.shopping_lists (id) on delete cascade,
  name text not null,

  quantity numeric(10, 3) not null default 1,
  unit public.measurement_unit not null default 'piece',
  category_id uuid references public.categories (id) on delete set null,

  notes text not null default '',
  price numeric(12, 2),
  currency text not null default 'TRY',
  priority public.item_priority not null default 'normal',

  is_completed boolean not null default false,
  completed_at timestamptz,
  purchased_by uuid references public.users (id) on delete set null,
  purchased_at timestamptz,

  image_url text,
  barcode text,
  barcode_format public.barcode_symbology,
  brand text,

  -- Seyrek sıralama anahtarı: sürükle-bırak sonrası ürün iki komşusunun
  -- ortasını alır, böylece tek satır güncellenir.
  sort_order double precision not null default 0,

  source public.item_source not null default 'manual',

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by uuid,
  updated_by uuid,
  deleted_at timestamptz,
  version integer not null default 1,

  constraint items_name_not_blank check (length(trim(name)) > 0),
  constraint items_quantity_positive check (quantity > 0),
  constraint items_price_non_negative check (price is null or price >= 0)
);

-- ================================================================== işbirliği

-- Yalnızca ekleme yapılır: güncelleme ve silme RLS ile yasak. İz kaydının
-- kurcalanamaz olması, istatistik toplamasının girdisi olduğu için önemli.
create table public.activity_logs (
  id uuid primary key default gen_random_uuid(),

  list_id uuid not null references public.shopping_lists (id) on delete cascade,
  actor_id uuid references public.users (id) on delete set null,
  action public.activity_action not null,

  actor_name text not null default '',
  actor_photo_url text,
  target_id uuid,
  target_name text not null default '',

  -- Eyleme özgü serbest alanlar (eski/yeni değer, adet vb.).
  metadata jsonb not null default '{}'::jsonb,

  created_at timestamptz not null default now()
);

create table public.invitations (
  id uuid primary key default gen_random_uuid(),

  list_id uuid not null references public.shopping_lists (id) on delete cascade,
  -- Davet e-postası küçük harfe indirgenir; eşleşme büyük/küçük harfe
  -- duyarsız olsun diye trigger normalize ediyor (0003).
  invitee_email text not null,
  invitee_id uuid references public.users (id) on delete set null,
  invited_by uuid not null references public.users (id) on delete cascade,

  role public.member_role not null default 'editor',
  status public.invitation_status not null default 'pending',

  list_title text not null default '',
  list_emoji text not null default '🛒',
  inviter_name text not null default '',
  inviter_photo_url text,

  responded_at timestamptz,
  revoked_at timestamptz,
  expires_at timestamptz,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by uuid,
  updated_by uuid,
  deleted_at timestamptz,
  version integer not null default 1,

  constraint invitations_email_shape check (invitee_email ~ '^[^@[:space:]]+@[^@[:space:]]+$')
);

-- Kalıcı varlık kaydı. Anlık "çevrimiçi" göstergesi Supabase Realtime
-- Presence kanalıyla çalışacak (bağlantı kopunca kendiliğinden düşer); bu
-- tablo "en son ne zaman göründü" ve "hangi ürünü düzenliyor" bilgisini
-- kalıcı tutmak için var.
create table public.list_presence (
  list_id uuid not null references public.shopping_lists (id) on delete cascade,
  user_id uuid not null references public.users (id) on delete cascade,

  last_seen_at timestamptz not null default now(),
  is_online boolean not null default false,
  display_name text not null default '',
  photo_url text,
  editing_item_id uuid references public.items (id) on delete set null,
  device_id text not null default '',

  primary key (list_id, user_id)
);

-- Sohbet odası listeyle bire bir. Firestore'da oda kimliğini liste kimliği
-- yapıyordum; burada tekillik kısıtı aynı garantiyi veriyor.
create table public.chat_rooms (
  id uuid primary key default gen_random_uuid(),

  list_id uuid not null unique references public.shopping_lists (id) on delete cascade,

  message_count integer not null default 0,
  last_message_preview text not null default '',
  last_message_sender_id uuid references public.users (id) on delete set null,
  last_message_sender_name text not null default '',
  last_message_type public.message_type,
  last_message_at timestamptz,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by uuid,
  updated_by uuid,
  deleted_at timestamptz,
  version integer not null default 1
);

create table public.chat_messages (
  id uuid primary key default gen_random_uuid(),

  room_id uuid not null references public.chat_rooms (id) on delete cascade,
  sender_id uuid references public.users (id) on delete set null,

  type public.message_type not null default 'text',
  body text not null default '',

  sender_name text not null default '',
  sender_photo_url text,

  attachment_url text,
  attachment_path text,
  attachment_size_bytes bigint not null default 0,

  -- Ses mesajı süresi milisaniye olarak; Dart tarafındaki Duration ile eşleşir.
  voice_duration_ms integer,
  waveform double precision[] not null default '{}',
  image_width integer,
  image_height integer,

  -- uid anahtarlı haritalar. Her katılımcı yalnızca kendi anahtarını yazar,
  -- böylece eşzamanlı yazmalar birbirini ezmez — dizi eklemenin veremediği
  -- garanti bu.
  read_by jsonb not null default '{}'::jsonb,
  reactions jsonb not null default '{}'::jsonb,

  mentions uuid[] not null default '{}',
  reply_to_message_id uuid references public.chat_messages (id) on delete set null,
  reply_to_preview text not null default '',

  is_edited boolean not null default false,
  edited_at timestamptz,

  -- Sistem mesajları (liste olaylarını sohbette anlatan satırlar).
  system_action public.activity_action,
  system_params jsonb not null default '{}'::jsonb,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by uuid,
  updated_by uuid,
  deleted_at timestamptz,
  version integer not null default 1,

  constraint chat_messages_voice_duration_positive
    check (voice_duration_ms is null or voice_duration_ms > 0)
);

-- ============================================================ paylaşım / şablon

-- Kimlik doğrulaması olmadan çözülebilen davet bağlantısı. `slug` QR koduna
-- ve bağlantıya giren kısımdır.
create table public.shared_links (
  id uuid primary key default gen_random_uuid(),

  list_id uuid not null references public.shopping_lists (id) on delete cascade,
  slug text not null unique,
  role public.member_role not null default 'viewer',

  is_active boolean not null default true,
  list_title text not null default '',
  list_emoji text not null default '🛒',

  use_count integer not null default 0,
  max_uses integer,
  expires_at timestamptz,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by uuid,
  updated_by uuid,
  deleted_at timestamptz,
  version integer not null default 1,

  constraint shared_links_slug_shape check (slug ~ '^[A-Za-z0-9_-]{6,32}$'),
  constraint shared_links_max_uses_positive check (max_uses is null or max_uses > 0)
);

create table public.shopping_templates (
  id uuid primary key default gen_random_uuid(),

  name text not null,
  owner_id uuid references public.users (id) on delete cascade,
  is_public boolean not null default false,

  description text not null default '',
  emoji text not null default '🛒',
  color_hex text not null default 'FF3525CD',
  category text not null default '',

  -- Şablon satırları ayrı tablo değil: bir bütün olarak okunup yazılıyor,
  -- tek tek sorgulanmıyor. jsonb burada doğru araç.
  items jsonb not null default '[]'::jsonb,

  usage_count integer not null default 0,
  generated_from public.ai_list_kind,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by uuid,
  updated_by uuid,
  deleted_at timestamptz,
  version integer not null default 1,

  constraint templates_public_xor_owned
    check ((is_public and owner_id is null) or owner_id is not null),
  constraint templates_items_is_array check (jsonb_typeof(items) = 'array')
);

-- ========================================================== kullanıcı verisi

create table public.favorites (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users (id) on delete cascade,
  target_id uuid not null,
  target_type public.favorite_target_type not null,

  label text not null default '',
  emoji text not null default '⭐',
  list_id uuid references public.shopping_lists (id) on delete cascade,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),

  constraint favorites_unique_target unique (user_id, target_type, target_id)
);

create table public.recent_searches (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users (id) on delete cascade,
  query text not null,

  searched_at timestamptz not null default now(),
  search_count integer not null default 1,
  result_count integer not null default 0,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),

  -- Aynı sorgu tekrar yazıldığında yeni satır değil sayaç artar (upsert).
  constraint recent_searches_unique_query unique (user_id, query)
);

create table public.barcode_scans (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users (id) on delete cascade,
  code text not null,
  format public.barcode_symbology not null default 'unknown',

  scanned_at timestamptz not null default now(),

  product_name text not null default '',
  brand text not null default '',
  category_id uuid references public.categories (id) on delete set null,
  image_url text,

  last_price numeric(12, 2),
  currency text not null default 'TRY',
  scan_count integer not null default 1,

  list_id uuid references public.shopping_lists (id) on delete set null,
  item_id uuid references public.items (id) on delete set null,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),

  -- Aynı barkod ikinci kez okunduğunda sayaç artar; geçmiş şişmez.
  constraint barcode_scans_unique_code unique (user_id, code),
  constraint barcode_scans_code_shape check (code ~ '^[0-9]{8,14}$')
);

create table public.voice_commands (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users (id) on delete cascade,
  status public.voice_command_status not null default 'listening',

  transcript text not null default '',
  locale_id text not null default 'tr_TR',
  confidence numeric(4, 3) not null default 1,

  -- Bir cümleden çıkarılan ürünler; uygulanana kadar burada bekler.
  parsed_items jsonb not null default '[]'::jsonb,

  list_id uuid references public.shopping_lists (id) on delete set null,
  created_item_ids uuid[] not null default '{}',
  error_code text,
  capture_duration_ms integer,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),

  constraint voice_confidence_range check (confidence between 0 and 1),
  constraint voice_parsed_items_is_array check (jsonb_typeof(parsed_items) = 'array')
);

create table public.device_tokens (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users (id) on delete cascade,
  token text not null unique,
  platform public.device_platform not null default 'other',

  is_active boolean not null default true,
  device_model text not null default '',
  os_version text not null default '',
  app_version text not null default '',
  locale text not null default 'tr',
  timezone text not null default '',
  last_used_at timestamptz,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.notifications (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users (id) on delete cascade,
  type public.notification_type not null,

  -- Başlık ve gövde istemcide çevrilir; burada yalnızca parametreler durur,
  -- böylece bildirim kullanıcının diline göre gösterilebiliyor.
  params jsonb not null default '{}'::jsonb,

  is_read boolean not null default false,
  read_at timestamptz,

  list_id uuid references public.shopping_lists (id) on delete cascade,
  item_id uuid references public.items (id) on delete set null,
  message_id uuid references public.chat_messages (id) on delete set null,
  invitation_id uuid references public.invitations (id) on delete set null,

  actor_id uuid references public.users (id) on delete set null,
  actor_name text not null default '',
  actor_photo_url text,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  created_by uuid,
  updated_by uuid,
  deleted_at timestamptz,
  version integer not null default 1
);

-- Önceden toplanmış istatistik. İstatistik ekranı dönem başına tek satır
-- okur; satın alma geçmişini taramaz.
create table public.user_statistics (
  id uuid primary key default gen_random_uuid(),

  user_id uuid not null references public.users (id) on delete cascade,
  period public.statistics_period not null,
  period_start timestamptz not null,
  period_end timestamptz not null,

  lists_created integer not null default 0,
  lists_completed integer not null default 0,
  items_added integer not null default 0,
  items_completed integer not null default 0,

  total_spent numeric(12, 2) not null default 0,
  currency text not null default 'TRY',

  spend_by_category jsonb not null default '{}'::jsonb,
  items_by_category jsonb not null default '{}'::jsonb,
  item_frequency jsonb not null default '{}'::jsonb,
  spend_by_day jsonb not null default '{}'::jsonb,

  updated_at timestamptz not null default now(),

  constraint user_statistics_unique_period unique (user_id, period, period_start),
  constraint user_statistics_period_ordered check (period_end > period_start)
);

-- ==================================================== abonelik ve premium

-- Yalnızca sunucu yazar (mağaza webhook'u / Edge Function). İstemci okuyabilir,
-- yazamaz — bir kullanıcı kendine premium veremesin diye.
create table public.subscriptions (
  user_id uuid primary key references public.users (id) on delete cascade,

  tier public.subscription_tier not null default 'free',
  is_active boolean not null default false,

  -- Mağaza tarafındaki karşılıklar; doğrulama bunlarla yapılır.
  store text not null default '',
  product_id text not null default '',
  original_transaction_id text,
  latest_receipt text,

  started_at timestamptz,
  current_period_end timestamptz,
  cancelled_at timestamptz,
  in_trial boolean not null default false,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  version integer not null default 1
);

-- Hangi özelliğin hangi katmana açık olduğu. Kod içindeki bayrakların
-- veritabanı karşılığı; sunucudan güncellenebilsin diye tablo olarak duruyor.
create table public.premium_features (
  id text primary key,

  name text not null,
  description text not null default '',
  min_tier public.subscription_tier not null default 'plus',
  is_enabled boolean not null default true,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- ===================================================== geri bildirim / hata

create table public.feedback (
  id uuid primary key default gen_random_uuid(),

  user_id uuid references public.users (id) on delete set null,
  body text not null,
  rating smallint,
  app_version text not null default '',
  platform public.device_platform not null default 'other',

  created_at timestamptz not null default now(),

  constraint feedback_body_not_blank check (length(trim(body)) > 0),
  constraint feedback_rating_range check (rating is null or rating between 1 and 5)
);

create table public.bug_reports (
  id uuid primary key default gen_random_uuid(),

  user_id uuid references public.users (id) on delete set null,
  title text not null,
  body text not null default '',
  severity public.bug_severity not null default 'medium',
  status public.report_status not null default 'open',

  app_version text not null default '',
  platform public.device_platform not null default 'other',
  device_model text not null default '',
  os_version text not null default '',

  -- Yığın izi ve ekran görüntüsü yolu gibi ekler.
  diagnostics jsonb not null default '{}'::jsonb,

  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),

  constraint bug_reports_title_not_blank check (length(trim(title)) > 0)
);

-- ======================================================================
-- DOSYA: 20260725090200_functions.sql
-- ======================================================================

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

-- ======================================================================
-- DOSYA: 20260725090300_rls.sql
-- ======================================================================

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

-- ======================================================================
-- DOSYA: 20260725090400_indexes_realtime.sql
-- ======================================================================

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

-- ======================================================================
-- DOSYA: 20260725090500_seed.sql
-- ======================================================================

-- SmartList — başlangıç verisi
--
-- Küresel kategoriler ve premium özellik tanımları. Bunlar uygulamanın
-- çalışması için gereken referans veri; kullanıcı verisi değil, o yüzden
-- `seed.sql` yerine migration olarak duruyorlar — her ortamda (canlı, önizleme
-- branch'i, yeni geliştirici) kendiliğinden var olsunlar.
--
-- `on conflict do nothing`: migration yeniden çalıştırılırsa satırlar
-- ikizlenmesin.

-- ================================================================= kategoriler

-- Kimlikler sabit UUID: uygulama bir kategoriye kod içinden atıfta bulunmak
-- isterse (öntanımlı kategori gibi) değer ortamlar arasında aynı kalıyor.
insert into public.categories (id, name, emoji, color_hex, localization_key, sort_order, is_global)
values
  ('a0000000-0000-4000-8000-000000000001', 'Market',      '🛒', 'FF3525CD', 'category.grocery',    10, true),
  ('a0000000-0000-4000-8000-000000000002', 'Manav',       '🥬', 'FF00A2F3', 'category.produce',    20, true),
  ('a0000000-0000-4000-8000-000000000003', 'Kasap',       '🥩', 'FFE11D48', 'category.butcher',    30, true),
  ('a0000000-0000-4000-8000-000000000004', 'Fırın',       '🍞', 'FFF59E0B', 'category.bakery',     40, true),
  ('a0000000-0000-4000-8000-000000000005', 'Süt Ürünleri','🧈', 'FFFACC15', 'category.dairy',      50, true),
  ('a0000000-0000-4000-8000-000000000006', 'İçecek',      '🥤', 'FF06B6D4', 'category.beverages',  60, true),
  ('a0000000-0000-4000-8000-000000000007', 'Dondurulmuş', '🧊', 'FF38BDF8', 'category.frozen',     70, true),
  ('a0000000-0000-4000-8000-000000000008', 'Temizlik',    '🧼', 'FF22C55E', 'category.cleaning',   80, true),
  ('a0000000-0000-4000-8000-000000000009', 'Kişisel Bakım','🧴','FFA855F7', 'category.personal',   90, true),
  ('a0000000-0000-4000-8000-00000000000a', 'Bebek',       '🍼', 'FFF472B6', 'category.baby',      100, true),
  ('a0000000-0000-4000-8000-00000000000b', 'Evcil Hayvan','🐾', 'FF92400E', 'category.pet',       110, true),
  ('a0000000-0000-4000-8000-00000000000c', 'Ev & Yaşam',  '🏠', 'FF64748B', 'category.home',      120, true),
  ('a0000000-0000-4000-8000-00000000000d', 'Kırtasiye',   '✏️', 'FF7C3AED', 'category.stationery',130, true),
  ('a0000000-0000-4000-8000-00000000000e', 'Eczane',      '💊', 'FF16A34A', 'category.pharmacy',  140, true),
  ('a0000000-0000-4000-8000-00000000000f', 'Diğer',       '📦', 'FF94A3B8', 'category.other',     999, true)
on conflict (id) do nothing;

-- ============================================================ premium özellikler

-- Kimlikler `lib/core/config/feature_flags.dart` içindeki bayrak adlarıyla
-- aynı; uygulama bir özelliği sorgularken aynı anahtarı kullanıyor.
insert into public.premium_features (id, name, description, min_tier)
values
  ('unlimited_lists',      'Sınırsız liste',
   'Ücretsiz planda aynı anda 3 aktif liste tutulabilir.',            'plus'),
  ('unlimited_members',    'Sınırsız üye',
   'Ücretsiz planda liste başına 3 kişi paylaşılabilir.',             'plus'),
  ('unlimited_ai',         'Sınırsız yapay zekâ listesi',
   'Ücretsiz planda ayda 5 üretim hakkı var.',                        'plus'),
  ('advanced_statistics',  'Gelişmiş istatistik',
   'Aylık harcama, kategori ve kişi kırılımı.',                       'plus'),
  ('unlimited_history',    'Sınırsız geçmiş',
   'Ücretsiz planda son 30 günün hareketleri saklanır.',              'plus'),
  ('no_ads',               'Reklamsız',
   'Hiçbir ekranda reklam gösterilmez.',                              'plus'),
  ('custom_categories',    'Kendi kategorilerim',
   'Kullanıcıya özel kategori oluşturma.',                            'plus'),
  ('voice_input',          'Sesle ürün ekleme',
   'Tek cümleyle birden fazla ürün ekleme.',                          'plus'),
  ('family_sharing',       'Aile paylaşımı',
   'Bir abonelik en fazla 6 hesapta geçerli olur.',                   'family'),
  ('priority_support',     'Öncelikli destek',
   'Destek taleplerine öncelikli yanıt.',                             'family')
on conflict (id) do nothing;

-- ======================================================================
-- DOSYA: 20260725120000_add_openrouter_provider.sql
-- ======================================================================

-- Yapay zeka saglayici listesine OpenRouter eklenir.
--
-- Dart tarafindaki `AiProviderKind` enum'u ile ayni "wire" degeri kullanilmali;
-- `user_settings.ai_provider` sutunu bu tipte.
--
-- `alter type ... add value` bir islem icinde calisamadigi Postgres surumleri
-- vardi; 12'den beri calisiyor ve Supabase 17 uzerinde. Yine de deger zaten
-- varsa hata vermemesi icin `if not exists` kullaniliyor.
alter type public.ai_provider_kind add value if not exists 'openrouter';
