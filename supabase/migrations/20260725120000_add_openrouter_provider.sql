-- Yapay zeka saglayici listesine OpenRouter eklenir.
--
-- Dart tarafindaki `AiProviderKind` enum'u ile ayni "wire" degeri kullanilmali;
-- `user_settings.ai_provider` sutunu bu tipte.
--
-- `alter type ... add value` bir islem icinde calisamadigi Postgres surumleri
-- vardi; 12'den beri calisiyor ve Supabase 17 uzerinde. Yine de deger zaten
-- varsa hata vermemesi icin `if not exists` kullaniliyor.
alter type public.ai_provider_kind add value if not exists 'openrouter';
