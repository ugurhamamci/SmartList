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
$zorunlu = @(
    'FLAVOR',
    'FIREBASE_PROJECT_ID',
    'FIREBASE_MESSAGING_SENDER_ID'
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
    Write-Host 'scripts\defines.local.ps1 dosyasini duzenleyip tekrar deneyin.'
    exit 1
}

# Platforma gore en az bir API key + app id gerekli.
$androidTam = $degerler['FIREBASE_API_KEY_ANDROID'] -and $degerler['FIREBASE_APP_ID_ANDROID']
$iosTam     = $degerler['FIREBASE_API_KEY_IOS']     -and $degerler['FIREBASE_APP_ID_IOS']
$webTam     = $degerler['FIREBASE_API_KEY_WEB']     -and $degerler['FIREBASE_APP_ID_WEB']

if (-not ($androidTam -or $iosTam -or $webTam)) {
    Write-Host ''
    Write-Host 'HATA: Hicbir platform icin API key + App ID cifti tanimli degil.' -ForegroundColor Red
    Write-Host 'En az bir platformu doldurun (Android en kolayi).'
    exit 1
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
Write-Host "Proje  : $($degerler['FIREBASE_PROJECT_ID'])" -ForegroundColor Cyan
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
