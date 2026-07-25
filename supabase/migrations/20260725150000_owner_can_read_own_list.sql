-- Liste sahibi kendi listesini her zaman okuyabilir.
--
-- Canli dogrulama (tool/verify_backend.mjs) su hatayi buldu: liste olusturmak
-- `Prefer: return=representation` ile 403 veriyordu, `return=minimal` ile 201.
-- Yani INSERT politikasi dogruydu, reddedilen sey donen satirin OKUNMASIYDI.
--
-- Sebep: `insert ... returning` kullanildiginda Postgres SELECT politikasini da
-- uyguluyor ve bu kontrol, uyelik satirini ekleyen `add_owner_as_member`
-- AFTER INSERT trigger'indan ONCE degerlendiriliyor. O anda `is_list_member()`
-- henuz false donuyor, cunku uyelik daha yazilmamis.
--
-- Cozum, trigger'in sirasiyla oynamak degil (liste satiri var olmadan uyelik
-- eklenemez, foreign key buna izin vermez) ayri bir politika eklemek:
-- "sahip kendi listesini gorur". Bu zaten dogru bir degismez (invariant) ve
-- uyelik tablosundan bagimsiz: uyelik satiri herhangi bir sebeple eksik kalsa
-- bile sahibin listesini kaybetmemesi gerekiyor.
--
-- Politikalar izin verici (permissive) oldugu icin OR'lanir; mevcut
-- `shopping_lists_select_member` politikasi oldugu gibi kaliyor.
create policy shopping_lists_select_owner
  on public.shopping_lists for select
  to authenticated
  using (owner_id = (select auth.uid()));
