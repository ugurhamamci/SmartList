# SmartList — tasarim onizlemesini calistirir
#
# lib/main_preview.dart giris noktasini kullanir. Firebase'e HIC dokunmaz, bu
# yuzden --dart-define vermeye ve Firebase projesi kurmaya gerek yoktur.
# Telefonda arayuzu gormek icin en hizli yol budur.
#
# Kullanim:
#   .\scripts\run_preview.ps1                  # bagli cihazda (telefon/emulator)
#   .\scripts\run_preview.ps1 -Device chrome   # tarayicida
#   .\scripts\run_preview.ps1 -Web             # tarayici acmadan, adres verir
#   .\scripts\run_preview.ps1 -Build apk       # kurulabilir APK uretir
#
# Gercek uygulama icin run_dev.ps1 kullanin; o Firebase degerlerini ister.

#Requires -Version 5.1
[CmdletBinding()]
param(
    [string]$Device,

    [ValidateSet('run', 'apk', 'appbundle')]
    [string]$Build = 'run',

    # Tarayici acmadan yerel bir adreste servis eder (sunucu/uzak makine icin).
    [switch]$Web,

    [int]$Port = 8080,

    [switch]$Release
)

$ErrorActionPreference = 'Stop'
Set-Location (Split-Path -Parent $PSScriptRoot)

$entry = 'lib/main_preview.dart'

if (-not (Test-Path $entry)) {
    Write-Host "HATA: $entry bulunamadi." -ForegroundColor Red
    exit 1
}

$flutter = Get-Command flutter -ErrorAction SilentlyContinue
if (-not $flutter) {
    Write-Host 'HATA: Flutter bulunamadi. docs/KURULUM.md 3. bolume bakin.' -ForegroundColor Red
    exit 1
}

$args = @()

if ($Build -ne 'run') {
    $args += @('build', $Build, '--release', '-t', $entry)
    Write-Host "APK/AAB uretiliyor: $Build" -ForegroundColor Cyan
} else {
    $args += @('run', '-t', $entry)

    if ($Web) {
        $args += @('-d', 'web-server', '--web-hostname', '0.0.0.0', '--web-port', "$Port")
        Write-Host "Onizleme http://localhost:$Port adresinde servis edilecek." -ForegroundColor Cyan
    } elseif ($Device) {
        $args += @('-d', $Device)
    }

    if ($Release) { $args += '--release' }
}

Write-Host 'Firebase yapilandirmasi gerekmiyor - onizleme giris noktasi kullaniliyor.' -ForegroundColor DarkGray
Write-Host ''

& flutter @args
exit $LASTEXITCODE
