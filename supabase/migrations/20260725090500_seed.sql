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
