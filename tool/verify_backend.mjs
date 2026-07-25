// Supabase arka ucunu ucdan uca dogrular.
//
// Kullanim:
//   node tool/verify_backend.mjs <benzersiz-etiket>
//
// Ornek:
//   node tool/verify_backend.mjs t1
//
// Etiket, olusturulan test kullanicilarinin e-postasina giriyor; her kosuda
// farkli bir deger verin, aksi halde "kullanici zaten var" hatasi alinir.
//
// ON KOSUL: Dashboard > Authentication > Sign In / Providers > Email altinda
// "Confirm email" KAPALI olmali. Acik oldugunda her kayit bir dogrulama
// e-postasi tetikliyor ve ucretsiz katmanin SMTP siniri (saatte ~2-3) hemen
// dolarak HTTP 429 veriyor. Bu ayni zamanda gercek kullanicilar icin de
// engel; ayrinti icin docs/SUPABASE_AYARLARI.md.
//
// Amac: yazilan trigger'lar, RLS politikalari ve RPC'ler GERCEKTEN calisiyor mu?
// Postgres ayristiricisi PL/pgSQL govdelerini denetlemiyor, yani buraya kadar
// hicbiri kosmadi.
//
// Senaryo kullanicinin anlattigi durum: iki kisilik aile, biri liste aciyor,
// digeri QR ile katiliyor, ikisi de ekleyip "alindi" isaretliyor.

import fs from 'node:fs';

// Adres ve anahtar supabase/.env.local dosyasindan okunuyor. Publishable
// anahtarin istemciye gomulmesi guvenli olsa da depoya yazmiyoruz: anahtar tek
// bir projeye ait ve depoyu klonlayan herkesin ayni projeye yazmasi istenmez.
function readEnv() {
  const file = 'supabase/.env.local';
  if (!fs.existsSync(file)) {
    console.error(
      [
        'HATA: supabase/.env.local bulunamadi.',
        '  Copy-Item supabase/.env.local.example supabase/.env.local',
        '  ardindan SUPABASE_URL ve SUPABASE_ANON_KEY degerlerini doldurun.',
      ].join(String.fromCharCode(10)),
    );
    process.exit(1);
  }
  const out = {};
  // Satir sonu Windows'ta CRLF olabiliyor; ikisini de kabul ediyoruz.
  for (const line of fs.readFileSync(file, 'utf8').split(/\r?\n/)) {
    const t = line.trim();
    if (!t || t.startsWith('#')) continue;
    const i = t.indexOf('=');
    if (i < 1) continue;
    out[t.slice(0, i).trim()] = t.slice(i + 1).trim();
  }
  return out;
}

const env = readEnv();
const BASE = env.SUPABASE_URL;
const KEY = env.SUPABASE_ANON_KEY;

if (!BASE || !KEY) {
  console.error('HATA: SUPABASE_URL veya SUPABASE_ANON_KEY bos.');
  process.exit(1);
}

const stamp = process.argv[2] ?? 'x';
const pass = 'SmartList1234';

let passed = 0;
let failed = 0;

function check(label, condition, detail = '') {
  if (condition) {
    passed++;
    console.log(`  OK   ${label}`);
  } else {
    failed++;
    console.log(`  FAIL ${label}${detail ? `\n       ${detail}` : ''}`);
  }
}

async function api(path, { token, method = 'GET', body, prefer } = {}) {
  const res = await fetch(BASE + path, {
    method,
    headers: {
      apikey: KEY,
      Authorization: `Bearer ${token ?? KEY}`,
      'Content-Type': 'application/json',
      ...(prefer ? { Prefer: prefer } : {}),
    },
    body: body === undefined ? undefined : JSON.stringify(body),
  });
  const text = await res.text();
  let json;
  try { json = text ? JSON.parse(text) : null; } catch { json = text; }
  return { status: res.status, body: json };
}

async function signUp(email) {
  const r = await api('/auth/v1/signup', {
    method: 'POST',
    body: { email, password: pass, data: { display_name: email.split('@')[0] } },
  });
  return r;
}

async function signIn(email) {
  const r = await api('/auth/v1/token?grant_type=password', {
    method: 'POST',
    body: { email, password: pass },
  });
  return r;
}

console.log('=== 1. Kayit ve profil trigger ===');

const anneEmail = `anne.${stamp}@example.com`;
const babaEmail = `baba.${stamp}@example.com`;

const anneSignUp = await signUp(anneEmail);
check('anne kaydi olustu', anneSignUp.status === 200, `HTTP ${anneSignUp.status} ${JSON.stringify(anneSignUp.body).slice(0, 200)}`);

const babaSignUp = await signUp(babaEmail);
check('baba kaydi olustu', babaSignUp.status === 200, `HTTP ${babaSignUp.status} ${JSON.stringify(babaSignUp.body).slice(0, 200)}`);

let anne = anneSignUp.body?.access_token
  ? { token: anneSignUp.body.access_token, id: anneSignUp.body.user.id }
  : null;
let baba = babaSignUp.body?.access_token
  ? { token: babaSignUp.body.access_token, id: babaSignUp.body.user.id }
  : null;

if (!anne) {
  const r = await signIn(anneEmail);
  if (r.body?.access_token) anne = { token: r.body.access_token, id: r.body.user.id };
  else console.log(`  NOT: anne oturumu acilamadi (e-posta dogrulamasi acik olabilir): ${JSON.stringify(r.body).slice(0,160)}`);
}
if (!baba) {
  const r = await signIn(babaEmail);
  if (r.body?.access_token) baba = { token: r.body.access_token, id: r.body.user.id };
}

if (!anne || !baba) {
  console.log('\nOTURUM ACILAMADI - kalan testler atlanıyor.');
  console.log(`SONUC: ${passed} gecti, ${failed} basarisiz`);
  process.exit(1);
}

// handle_new_auth_user trigger'i profil ve ayar satirlarini acmis olmali.
const profile = await api(`/rest/v1/users?id=eq.${anne.id}&select=id,email,display_name,locale`, { token: anne.token });
check('profil satiri trigger ile olustu', Array.isArray(profile.body) && profile.body.length === 1,
  `HTTP ${profile.status} ${JSON.stringify(profile.body).slice(0, 200)}`);
check('display_name kayittan alindi', profile.body?.[0]?.display_name === anneEmail.split('@')[0],
  `beklenen "${anneEmail.split('@')[0]}", gelen "${profile.body?.[0]?.display_name}"`);

const settings = await api(`/rest/v1/user_settings?user_id=eq.${anne.id}&select=user_id,theme_mode,currency`, { token: anne.token });
check('ayar satiri trigger ile olustu', Array.isArray(settings.body) && settings.body.length === 1,
  JSON.stringify(settings.body).slice(0, 160));
check('para birimi ontanimli TRY', settings.body?.[0]?.currency === 'TRY');

// Baskasinin profilini gormemeli (henuz ortak liste yok).
const foreign = await api(`/rest/v1/users?id=eq.${baba.id}&select=id`, { token: anne.token });
check('ortak listesi olmayan kullanicinin profili gizli',
  Array.isArray(foreign.body) && foreign.body.length === 0,
  JSON.stringify(foreign.body).slice(0, 160));

console.log('\n=== 2. Baslangic verisi ===');
const cats = await api('/rest/v1/categories?is_global=eq.true&select=id,name', { token: anne.token });
check('15 kuresel kategori var', Array.isArray(cats.body) && cats.body.length === 15,
  `gelen ${Array.isArray(cats.body) ? cats.body.length : JSON.stringify(cats.body).slice(0,120)}`);
const feats = await api('/rest/v1/premium_features?select=id', { token: anne.token });
check('10 premium ozellik var', Array.isArray(feats.body) && feats.body.length === 10,
  `gelen ${Array.isArray(feats.body) ? feats.body.length : JSON.stringify(feats.body).slice(0,120)}`);

console.log('\n=== 3. Liste olusturma ve sahiplik trigger ===');
const created = await api('/rest/v1/shopping_lists', {
  token: anne.token,
  method: 'POST',
  prefer: 'return=representation',
  body: { title: 'Ev İhtiyaç Listesi', owner_id: anne.id, emoji: '🏠' },
});
check('liste olusturuldu', created.status === 201, `HTTP ${created.status} ${JSON.stringify(created.body).slice(0, 240)}`);
const list = Array.isArray(created.body) ? created.body[0] : null;

if (!list) {
  console.log(`\nLISTE OLUSTURULAMADI - kalan testler atlaniyor.`);
  console.log(`SONUC: ${passed} gecti, ${failed} basarisiz`);
  process.exit(1);
}

check('created_by trigger ile dolduruldu', list.created_by === anne.id, `gelen ${list.created_by}`);
check('version 1 olarak baslatildi', list.version === 1, `gelen ${list.version}`);

const members = await api(`/rest/v1/list_members?list_id=eq.${list.id}&select=user_id,role`, { token: anne.token });
check('olusturan kisi owner uyesi yapildi',
  members.body?.length === 1 && members.body[0].role === 'owner' && members.body[0].user_id === anne.id,
  JSON.stringify(members.body).slice(0, 200));

const room = await api(`/rest/v1/chat_rooms?list_id=eq.${list.id}&select=id`, { token: anne.token });
check('sohbet odasi otomatik acildi', room.body?.length === 1, JSON.stringify(room.body).slice(0, 160));

console.log('\n=== 4. RLS: uye olmayan listeyi goremez ===');
const babaSees = await api(`/rest/v1/shopping_lists?id=eq.${list.id}&select=id`, { token: baba.token });
check('baba listeyi goremiyor', Array.isArray(babaSees.body) && babaSees.body.length === 0,
  JSON.stringify(babaSees.body).slice(0, 160));

const babaWrites = await api('/rest/v1/items', {
  token: baba.token,
  method: 'POST',
  body: { list_id: list.id, name: 'İzinsiz ürün' },
});
check('baba listeye urun ekleyemiyor', babaWrites.status === 401 || babaWrites.status === 403,
  `HTTP ${babaWrites.status} ${JSON.stringify(babaWrites.body).slice(0, 160)}`);

console.log('\n=== 5. Urun ekleme ve sayac trigger ===');
const item1 = await api('/rest/v1/items', {
  token: anne.token, method: 'POST', prefer: 'return=representation',
  body: { list_id: list.id, name: 'Süt', quantity: 2, unit: 'l', price: 45 },
});
check('urun eklendi', item1.status === 201, `HTTP ${item1.status} ${JSON.stringify(item1.body).slice(0, 240)}`);

await api('/rest/v1/items', {
  token: anne.token, method: 'POST',
  body: { list_id: list.id, name: 'Ekmek', quantity: 2, unit: 'piece', price: 20 },
});

const afterItems = await api(`/rest/v1/shopping_lists?id=eq.${list.id}&select=item_count,completed_item_count,is_completed,total_spent,last_activity_at`, { token: anne.token });
check('item_count trigger ile 2 oldu', afterItems.body?.[0]?.item_count === 2,
  JSON.stringify(afterItems.body).slice(0, 200));
check('bos liste tamamlanmis sayilmiyor', afterItems.body?.[0]?.is_completed === false);

console.log('\n=== 6. QR ile katilma (join_list_by_slug RPC) ===');
const link = await api('/rest/v1/shared_links', {
  token: anne.token, method: 'POST', prefer: 'return=representation',
  body: { list_id: list.id, slug: `TEST${stamp.toUpperCase()}`, role: 'editor', list_title: 'Ev İhtiyaç Listesi' },
});
check('paylasim baglantisi olusturuldu', link.status === 201, `HTTP ${link.status} ${JSON.stringify(link.body).slice(0, 240)}`);
const slug = Array.isArray(link.body) ? link.body[0]?.slug : null;

if (slug) {
  // Baba baglantiyi DOGRUDAN okuyamamali (kod taranamasin).
  const babaReadsLink = await api(`/rest/v1/shared_links?slug=eq.${slug}&select=id`, { token: baba.token });
  check('davet kodlari taranamiyor', Array.isArray(babaReadsLink.body) && babaReadsLink.body.length === 0,
    JSON.stringify(babaReadsLink.body).slice(0, 160));

  const joined = await api('/rest/v1/rpc/join_list_by_slug', {
    token: baba.token, method: 'POST', body: { p_slug: slug },
  });
  check('baba QR ile listeye katildi', joined.status === 200 && joined.body === list.id,
    `HTTP ${joined.status} ${JSON.stringify(joined.body).slice(0, 200)}`);

  const babaNowSees = await api(`/rest/v1/shopping_lists?id=eq.${list.id}&select=id,member_count`, { token: baba.token });
  check('baba artik listeyi goruyor', babaNowSees.body?.length === 1, JSON.stringify(babaNowSees.body).slice(0, 160));
  check('member_count trigger ile 2 oldu', babaNowSees.body?.[0]?.member_count === 2,
    JSON.stringify(babaNowSees.body).slice(0, 160));

  const babaAdds = await api('/rest/v1/items', {
    token: baba.token, method: 'POST', prefer: 'return=representation',
    body: { list_id: list.id, name: 'Yumurta', quantity: 15, unit: 'piece' },
  });
  check('baba (editor) urun ekleyebiliyor', babaAdds.status === 201,
    `HTTP ${babaAdds.status} ${JSON.stringify(babaAdds.body).slice(0, 200)}`);

  const babaSeesProfile = await api(`/rest/v1/users?id=eq.${anne.id}&select=display_name`, { token: baba.token });
  check('ortak liste uyesinin profili artik gorunuyor', babaSeesProfile.body?.length === 1,
    JSON.stringify(babaSeesProfile.body).slice(0, 160));

  const gecersiz = await api('/rest/v1/rpc/join_list_by_slug', {
    token: baba.token, method: 'POST', body: { p_slug: 'YOKBOYLE' },
  });
  check('gecersiz kod reddediliyor', gecersiz.status >= 400,
    `HTTP ${gecersiz.status} ${JSON.stringify(gecersiz.body).slice(0, 160)}`);
}

console.log('\n=== 7. Alindi isaretleme ve tamamlanma ===');
const allItems = await api(`/rest/v1/items?list_id=eq.${list.id}&select=id,name&order=created_at`, { token: baba.token });
const ids = (allItems.body ?? []).map((i) => i.id);
check('ucu de gorunuyor', ids.length === 3, `gelen ${ids.length}`);

for (const id of ids) {
  const r = await api(`/rest/v1/items?id=eq.${id}`, {
    token: baba.token, method: 'PATCH',
    body: { is_completed: true, completed_at: new Date().toISOString(), purchased_by: baba.id },
  });
  if (r.status >= 400) check(`urun isaretlendi (${id.slice(0,8)})`, false, `HTTP ${r.status} ${JSON.stringify(r.body).slice(0,160)}`);
}

const done = await api(`/rest/v1/shopping_lists?id=eq.${list.id}&select=item_count,completed_item_count,is_completed,completed_at,total_spent`, { token: anne.token });
check('completed_item_count 3 oldu', done.body?.[0]?.completed_item_count === 3, JSON.stringify(done.body).slice(0, 220));
check('liste tamamlandi olarak isaretlendi', done.body?.[0]?.is_completed === true, JSON.stringify(done.body).slice(0, 220));
check('total_spent hesaplandi', Number(done.body?.[0]?.total_spent) > 0, JSON.stringify(done.body).slice(0, 220));

console.log('\n=== 8. Viewer alan kisiti (trigger) ===');
// Babayi viewer yapip iceriği değiştirmeyi denetiyoruz.
const demote = await api(`/rest/v1/list_members?list_id=eq.${list.id}&user_id=eq.${baba.id}`, {
  token: anne.token, method: 'PATCH', body: { role: 'viewer' },
});
check('owner rolu degistirebiliyor', demote.status < 300, `HTTP ${demote.status} ${JSON.stringify(demote.body).slice(0,160)}`);

if (ids.length) {
  const renameAttempt = await api(`/rest/v1/items?id=eq.${ids[0]}`, {
    token: baba.token, method: 'PATCH', body: { name: 'Viewer degistirdi' },
  });
  check('viewer urun adini DEGISTIREMIYOR', renameAttempt.status >= 400,
    `HTTP ${renameAttempt.status} ${JSON.stringify(renameAttempt.body).slice(0, 200)}`);

  const toggleAttempt = await api(`/rest/v1/items?id=eq.${ids[0]}`, {
    token: baba.token, method: 'PATCH', body: { is_completed: false, completed_at: null },
  });
  check('viewer tamamlandi isaretini DEGISTIREBILIYOR', toggleAttempt.status < 300,
    `HTTP ${toggleAttempt.status} ${JSON.stringify(toggleAttempt.body).slice(0, 200)}`);

  const deleteAttempt = await api(`/rest/v1/items?id=eq.${ids[0]}`, {
    token: baba.token, method: 'DELETE',
  });
  check('viewer urun SILEMIYOR', deleteAttempt.status >= 400,
    `HTTP ${deleteAttempt.status} ${JSON.stringify(deleteAttempt.body).slice(0, 160)}`);
}

console.log('\n=== 9. Etkinlik kaydi degistirilemez ===');
const logs = await api(`/rest/v1/activity_logs?list_id=eq.${list.id}&select=id,action`, { token: anne.token });
check('katilma etkinligi kaydedildi',
  Array.isArray(logs.body) && logs.body.some((l) => l.action === 'member_joined'),
  JSON.stringify(logs.body).slice(0, 200));
if (logs.body?.[0]) {
  const tamper = await api(`/rest/v1/activity_logs?id=eq.${logs.body[0].id}`, {
    token: anne.token, method: 'PATCH', body: { action: 'list_deleted' },
  });
  check('etkinlik kaydi guncellenemiyor', tamper.status >= 400,
    `HTTP ${tamper.status} ${JSON.stringify(tamper.body).slice(0, 160)}`);
}

console.log('\n=== 10. Premium kendine verilemiyor ===');
const selfPremium = await api(`/rest/v1/users?id=eq.${anne.id}`, {
  token: anne.token, method: 'PATCH', prefer: 'return=representation',
  body: { is_premium: true, subscription_tier: 'family' },
});
const stillFree = await api(`/rest/v1/users?id=eq.${anne.id}&select=is_premium,subscription_tier`, { token: anne.token });
check('is_premium istemciden degistirilemiyor', stillFree.body?.[0]?.is_premium === false,
  `HTTP ${selfPremium.status} sonuc ${JSON.stringify(stillFree.body).slice(0, 160)}`);
check('subscription_tier free kaldi', stillFree.body?.[0]?.subscription_tier === 'free');

console.log('\n=== 11. Son sahip ayrilamaz ===');
const leave = await api(`/rest/v1/list_members?list_id=eq.${list.id}&user_id=eq.${anne.id}`, {
  token: anne.token, method: 'DELETE',
});
check('tek sahip listeden ayrilamiyor', leave.status >= 400,
  `HTTP ${leave.status} ${JSON.stringify(leave.body).slice(0, 200)}`);

console.log('\n=== 12. Iyimser esszamanlilik (version) ===');
const cur = await api(`/rest/v1/shopping_lists?id=eq.${list.id}&select=version`, { token: anne.token });
const v = cur.body?.[0]?.version;
const staleWrite = await api(`/rest/v1/shopping_lists?id=eq.${list.id}&version=eq.${v - 1}`, {
  token: anne.token, method: 'PATCH', prefer: 'return=representation',
  body: { title: 'Eski surumle yazma' },
});
check('eski surumle yazma 0 satir etkiliyor',
  Array.isArray(staleWrite.body) && staleWrite.body.length === 0,
  `HTTP ${staleWrite.status} ${JSON.stringify(staleWrite.body).slice(0, 160)}`);

const freshWrite = await api(`/rest/v1/shopping_lists?id=eq.${list.id}&version=eq.${v}`, {
  token: anne.token, method: 'PATCH', prefer: 'return=representation',
  body: { title: 'Ev İhtiyaç Listesi (guncel)' },
});
check('dogru surumle yazma calisiyor',
  Array.isArray(freshWrite.body) && freshWrite.body.length === 1 && freshWrite.body[0].version === v + 1,
  `HTTP ${freshWrite.status} ${JSON.stringify(freshWrite.body).slice(0, 200)}`);

console.log(`\n${'='.repeat(60)}`);
console.log(`SONUC: ${passed} gecti, ${failed} basarisiz`);
console.log(`Liste kimligi: ${list.id}`);
process.exit(failed === 0 ? 0 : 1);
