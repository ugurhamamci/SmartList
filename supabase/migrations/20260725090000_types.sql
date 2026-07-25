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
