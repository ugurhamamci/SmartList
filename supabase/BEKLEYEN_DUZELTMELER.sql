-- SmartList — BEKLEYEN DUZELTMELER
--
-- Bu dosya supabase/migrations altindaki iki dosyanin birlesimi.
--
-- DURUM: ikisi de canli projeye UYGULANDI ve olcumle dogrulandi:
--   shopping_lists_select_owner : HTTP 201  (onceden 403)
--   touch_audit duzeltmesi      : surum 1 -> 1  (onceden 2 -> 3)
--
-- Dosya, semayi sifirdan kuran yeni bir ortam icin duruyor. schema_all.sql
-- bunlari zaten iceriyor; ayri ayri uygulamak gerekmiyor.
--
-- NASIL UYGULANIR
--   Supabase Dashboard > SQL Editor > New query > bu dosyanin tamamini
--   yapistir > Run (Ctrl+Enter)
--
-- Yeniden calistirilabilir: ilk calistirmadan sonra politika icin
-- "already exists" hatasi normaldir, fonksiyon `create or replace` ile geliyor.
--
-- Uyguladiktan sonra dogrulama:
--   node tool/verify_backend.mjs s1

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
-- Postgres'te `create policy if not exists` yok, bu yuzden onunde bir
-- `drop` var: dosya yeniden calistirilabilir kalsin. Politikayi dusurup
-- yeniden kurmak guvenli, cunku ayni islem icinde geri geliyor.
drop policy if exists shopping_lists_select_owner on public.shopping_lists;

create policy shopping_lists_select_owner
  on public.shopping_lists for select
  to authenticated
  using (owner_id = (select auth.uid()));

-- `version` yalnizca kullanici duzenlemelerini saysin.
--
-- Canli dogrulama sunu gosterdi: yeni olusturulan bir listenin surumu 1 degil
-- 2 oluyordu. Sebep sayac trigger'lari - urun eklendiginde
-- `refresh_list_item_counters` listeyi guncelliyor, bu da `touch_audit`
-- trigger'ini tetikliyor ve surumu artiriyor.
--
-- Bu davranis iyimser eszamanlilik icin gurultu uretiyor: surum, kullanicinin
-- yaptigi bir degisikligi degil sunucunun defter tutmasini yansitiyor. Sonucu
-- somut: iki kisi ayni listede calisirken biri urun eklerken digeri liste
-- adini degistirmeye kalksa, ad degisikligi "kayit baska cihazdan degisti"
-- diye reddedilirdi - halbuki catisan bir sey yok.
--
-- `pg_trigger_depth()` cagiranin derinligini soyluyor: istemciden gelen bir
-- UPDATE'te 1, baska bir trigger icinden gelen UPDATE'te 1'den buyuk. Surumu
-- yalnizca birincide artiriyoruz.
--
-- `updated_at` her iki durumda da taze kaliyor: "bu liste en son ne zaman
-- degisti" sorusunun cevabi sayac guncellemesini de kapsamali, cunku kullanici
-- icin liste gercekten degismis oluyor.
create or replace function public.touch_audit()
returns trigger
language plpgsql
security invoker
set search_path = ''
as $$
begin
  -- Olusturma bilgisi degistirilemez: kim ne zaman olusturdu sorusunun cevabi
  -- sonradan yeniden yazilabilir olmamali.
  new.created_at := old.created_at;
  new.created_by := old.created_by;

  new.updated_at := now();

  if pg_trigger_depth() <= 1 then
    -- Istemciden gelen gercek bir duzenleme.
    new.updated_by := coalesce(auth.uid(), old.updated_by);
    new.version := old.version + 1;
  else
    -- Baska bir trigger'in yazdigi defter guncellemesi (sayaclar gibi):
    -- surumu ve "kim guncelledi" bilgisini bozmuyoruz.
    new.updated_by := old.updated_by;
    new.version := old.version;
  end if;

  return new;
end;
$$;

comment on function public.touch_audit() is
  'Denetim alanlarini yazar. Surum yalnizca istemciden gelen duzenlemelerde artar; trigger kaynakli sayac guncellemeleri surumu bozmaz.';
