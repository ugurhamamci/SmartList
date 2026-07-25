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
