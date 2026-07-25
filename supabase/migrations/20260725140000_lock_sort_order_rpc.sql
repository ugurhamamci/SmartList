-- `next_item_sort_order` fonksiyonunu anonim erişime kapatır.
--
-- Sema uygulandiktan sonra REST ucundan dogrulama yapildi ve bu fonksiyon
-- anon anahtariyla cagrilabildi (HTTP 200). Digerlerinde `revoke ... from
-- public, anon` vardi, bunda atlanmis.
--
-- Sizinti kucuk ama gercek: fonksiyon `security definer`, yani RLS'i atliyor.
-- Anonim bir cagirici liste kimligi deneyerek o listede urun olup olmadigini
-- ogrenebiliyordu (bos listede 1000, dolu listede daha buyuk deger doner).
-- Uygulamanin tamami giris gerektirdigi icin anon'un bu fonksiyona erisimi
-- hicbir ise yaramiyor.
revoke all on function public.next_item_sort_order(uuid) from public, anon;

grant execute on function public.next_item_sort_order(uuid) to authenticated;
