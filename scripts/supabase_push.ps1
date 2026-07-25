# SmartList — Supabase migration'larini uzak veritabanina uygular
#
# supabase/.env.local dosyasindaki SUPABASE_DB_URL degerini okur ve
# supabase/migrations altindaki dosyalari sirayla uygular.
#
# Kullanim:
#   .\scripts\supabase_push.ps1              # bekleyen migration'lari uygula
#   .\scripts\supabase_push.ps1 -DryRun      # ne uygulanacagini goster, uygulama
#   .\scripts\supabase_push.ps1 -Verify      # sema dogrulamasi (tablo/politika sayilari)
#
# NOT: Docker gerekmez; migration'lar dogrudan uzak veritabaninda kosar.
# SUPABASE_DB_URL "Session pooler" dizgesi olmali - "Direct connection"
# (db.<ref>.supabase.co) yalnizca IPv6 destekliyor.

#Requires -Version 5.1
[CmdletBinding()]
param(
    [switch]$DryRun,
    [switch]$Verify
)

$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent $PSScriptRoot
Set-Location $repo

$envFile = Join-Path $repo 'supabase\.env.local'

if (-not (Test-Path $envFile)) {
    Write-Host 'HATA: supabase\.env.local bulunamadi.' -ForegroundColor Red
    Write-Host ''
    Write-Host 'Olusturmak icin:' -ForegroundColor Yellow
    Write-Host '  Copy-Item supabase\.env.local.example supabase\.env.local'
    Write-Host '  notepad supabase\.env.local'
    Write-Host ''
    Write-Host 'Baglanti dizgesi: Supabase Dashboard > Connect > Session pooler'
    exit 1
}

# Dosyayi oku. Deger icinde "=" olabilecegi icin yalnizca ilk esittende boluyoruz.
$settings = @{}
foreach ($line in Get-Content $envFile) {
    $trimmed = $line.Trim()
    if ($trimmed -eq '' -or $trimmed.StartsWith('#')) { continue }
    $split = $trimmed.IndexOf('=')
    if ($split -lt 1) { continue }
    $key = $trimmed.Substring(0, $split).Trim()
    $value = $trimmed.Substring($split + 1).Trim().Trim('"').Trim("'")
    if ($value -ne '') { $settings[$key] = $value }
}

$dbUrl = $settings['SUPABASE_DB_URL']

if (-not $dbUrl) {
    Write-Host 'HATA: SUPABASE_DB_URL bos.' -ForegroundColor Red
    exit 1
}

# Sablon degerleri doldurulmadan calistirmak anlasilmaz bir baglanti hatasi
# verirdi; burada acikca soyluyoruz.
if ($dbUrl -match 'PROJE-REF|SIFRE|BOLGE') {
    Write-Host 'HATA: SUPABASE_DB_URL hala sablon degerlerini tasiyor.' -ForegroundColor Red
    Write-Host '      Dashboard > Connect > Session pooler dizgesini yapistirin.'
    exit 1
}

# IPv6-only dogrudan baglanti en sik yapilan hata; erkenden yakaliyoruz.
if ($dbUrl -match '@db\.[a-z0-9]+\.supabase\.co') {
    Write-Host 'UYARI: "Direct connection" dizgesi kullaniliyor.' -ForegroundColor Yellow
    Write-Host '       Bu adres yalnizca IPv6 destekler; IPv4 aginda baglanti kurulamaz.'
    Write-Host '       Dashboard > Connect > Session pooler dizgesini kullanin.'
    Write-Host ''
}

if ($Verify) {
    # Uygulamadan sonra semanin gercekten olustugunu dogrular.
    $sql = @'
select 'tablo' as nesne, count(*)::text as adet
  from pg_tables where schemaname = 'public'
union all
select 'RLS acik tablo', count(*)::text
  from pg_tables where schemaname = 'public' and rowsecurity
union all
select 'politika', count(*)::text
  from pg_policies where schemaname = 'public'
union all
select 'fonksiyon', count(*)::text
  from pg_proc p join pg_namespace n on n.oid = p.pronamespace
  where n.nspname = 'public'
union all
select 'trigger', count(*)::text
  from pg_trigger where not tgisinternal
union all
select 'indeks', count(*)::text
  from pg_indexes where schemaname = 'public'
union all
select 'enum turu', count(*)::text
  from pg_type t join pg_namespace n on n.oid = t.typnamespace
  where n.nspname = 'public' and t.typtype = 'e'
union all
select 'realtime tablo', count(*)::text
  from pg_publication_tables where pubname = 'supabase_realtime'
union all
select 'kuresel kategori', count(*)::text from public.categories where is_global
union all
select 'premium ozellik', count(*)::text from public.premium_features
order by 1;
'@
    $temp = Join-Path $env:TEMP "smartlist_verify_$PID.sql"
    Set-Content -Path $temp -Value $sql -Encoding utf8
    try {
        Write-Host 'Sema dogrulaniyor...' -ForegroundColor Cyan
        & npx --yes supabase@latest db execute --db-url $dbUrl --file $temp
    } finally {
        Remove-Item $temp -ErrorAction SilentlyContinue
    }
    exit $LASTEXITCODE
}

$pushArgs = @('--yes', 'supabase@latest', 'db', 'push', '--db-url', $dbUrl)
if ($DryRun) { $pushArgs += '--dry-run' }

Write-Host 'Migration''lar uygulaniyor...' -ForegroundColor Cyan
Write-Host ''

& npx @pushArgs
$code = $LASTEXITCODE

if ($code -eq 0 -and -not $DryRun) {
    Write-Host ''
    Write-Host 'Tamamlandi. Dogrulamak icin:' -ForegroundColor Green
    Write-Host '  .\scripts\supabase_push.ps1 -Verify'
}

exit $code
