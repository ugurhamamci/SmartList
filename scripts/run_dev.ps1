# SmartList — gelistirme modunda calistirma script'i
#
# scripts/defines.local.ps1 icindeki degerleri --dart-define parametrelerine
# cevirip "flutter run" komutunu calistirir. Boylece uzun komut satirini her
# seferinde elle yazmaniz gerekmez ve gizli degerler depoya girmez.
#
# Kullanim:
#   .\scripts\run_dev.ps1                 # bagli cihazda calistirir
#   .\scripts\run_dev.ps1 -Device chrome  # belirli bir cihazda
#   .\scripts\run_dev.ps1 -Flavor staging # farkli flavor ile
#   .\scripts\run_dev.ps1 -Build appbundle

#Requires -Version 5.1
[CmdletBinding()]
param(
    [string]$Device,

    [ValidateSet('development', 'staging', 'production')]
    [string]$Flavor,

    [ValidateSet('run', 'apk', 'appbundle', 'ipa', 'web')]
    [string]$Build = 'run',

    [switch]$Release
)

$ErrorActionPreference = 'Stop'
$ProjeKok = Split-Path -Parent $PSScriptRoot
Set-Location $ProjeKok

# ------------------------------------------------------- degerleri yukle
$yerelDosya = Join-Path $PSScriptRoot 'defines.local.ps1'

if (-not (Test-Path $yerelDosya)) {
    Write-Host ''
    Write-Host 'HATA: scripts\defines.local.ps1 bulunamadi.' -ForegroundColor Red
    Write-Host ''
    Write-Host 'Sablonu kopyalayip degerleri doldurun:' -ForegroundColor Yellow
    Write-Host '  Copy-Item scripts\defines.example.ps1 scripts\defines.local.ps1'
    Write-Host ''
    Write-Host 'Hangi degerin nereden alinacagi sablonun icinde yazili.'
    exit 1
}

$degerler = & $yerelDosya
if ($degerler -isnot [hashtable]) {
    Write-Host 'HATA: defines.local.ps1 bir hashtable dondurmeli.' -ForegroundColor Red
    Write-Host 'Dosyanin @{ ... } blogu ile bittiginden emin olun.'
    exit 1
}

# Komut satirindaki -Flavor, dosyadaki degeri ezer.
if ($Flavor) { $degerler['FLAVOR'] = $Flavor }

# ------------------------------------------------------- dogrulama
# Proje Supabase kullaniyor; Firebase degerleri artik gerekmiyor.
$zorunlu = @(
    'FLAVOR',
    'SUPABASE_URL',
    'SUPABASE_ANON_KEY'
)

$eksik = $zorunlu | Where-Object {
    -not $degerler.ContainsKey($_) -or
    [string]::IsNullOrWhiteSpace($degerler[$_]) -or
    $degerler[$_] -like 'BURAYA-*'
}

if ($eksik) {
    Write-Host ''
    Write-Host 'HATA: Su degerler doldurulmamis:' -ForegroundColor Red
    $eksik | ForEach-Object { Write-Host "  - $_" -ForegroundColor Red }
    Write-Host ''
    Write-Host 'Degerleri Supabase Dashboard > Project Settings > API altinda'
    Write-Host 'bulabilirsiniz. "publishable" (eski adiyla anon) anahtari kullanin;'
    Write-Host '"secret" anahtar RLS''i atlar ve uygulamaya ASLA konmaz.'
    Write-Host ''
    Write-Host 'scripts\defines.local.ps1 dosyasini duzenleyip tekrar deneyin.'
    exit 1
}

# Yanlis anahtari yapistirmak kolay bir hata ve sonucu ciddi: secret anahtar
# tum RLS politikalarini atlar. Erkenden yakaliyoruz.
if ($degerler['SUPABASE_ANON_KEY'] -like 'sb_secret_*') {
    Write-Host ''
    Write-Host 'HATA: SUPABASE_ANON_KEY bir SECRET anahtar gibi gorunuyor.' -ForegroundColor Red
    Write-Host 'Secret anahtar butun guvenlik politikalarini atlar ve uygulamaya'
    Write-Host 'konursa APK''dan cikarilabilir. "publishable" anahtari kullanin.'
    exit 1
}

if ($degerler['SUPABASE_URL'] -notlike 'https://*.supabase.co*') {
    Write-Host ''
    Write-Host 'UYARI: SUPABASE_URL beklenen bicimde degil.' -ForegroundColor Yellow
    Write-Host '       Ornek: https://abcdefgh.supabase.co'
    Write-Host ''
}

# --------------------------------------------------- dart-define listesi
$defineArgs = @()
foreach ($anahtar in ($degerler.Keys | Sort-Object)) {
    $deger = $degerler[$anahtar]
    if (-not [string]::IsNullOrWhiteSpace($deger)) {
        $defineArgs += "--dart-define=$anahtar=$deger"
    }
}

Write-Host ''
Write-Host "Flavor : $($degerler['FLAVOR'])" -ForegroundColor Cyan
Write-Host "Sunucu : $($degerler['SUPABASE_URL'])" -ForegroundColor Cyan
Write-Host "Define : $($defineArgs.Count) adet" -ForegroundColor Cyan

# Gizli degerleri ekrana basmiyoruz; yalnizca hangi anahtarlarin
# tanimlandigini gosteriyoruz.
Write-Host "Anahtar: $(($degerler.Keys | Sort-Object) -join ', ')" -ForegroundColor DarkGray
Write-Host ''

# ------------------------------------------------------------- calistir
$komutArgs = @()

switch ($Build) {
    'run' {
        $komutArgs += 'run'
        if ($Device) { $komutArgs += @('-d', $Device) }
        if ($Release) { $komutArgs += '--release' }
    }
    'web' {
        $komutArgs += @('run', '-d', 'chrome')
        if ($Release) { $komutArgs += '--release' }
    }
    default {
        $komutArgs += @('build', $Build)
        # Derlemelerde varsayilan olarak release; aksi belirtilmedikce.
        $komutArgs += '--release'
    }
}

$komutArgs += $defineArgs

Write-Host "flutter $($komutArgs[0..([Math]::Min(2, $komutArgs.Count - 1))] -join ' ') ..." -ForegroundColor DarkGray
& flutter @komutArgs
exit $LASTEXITCODE
