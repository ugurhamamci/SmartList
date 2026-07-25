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
