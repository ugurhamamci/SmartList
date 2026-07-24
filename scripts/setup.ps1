# SmartList — kurulum dogrulama ve hazirlik script'i
#
# Yeni bir makinede depoyu klonladiktan sonra bunu calistirin. Sirayla:
#   1. Flutter surumunu dogrular
#   2. Paketleri indirir
#   3. Uretilen kodu (Freezed / json_serializable) olusturur
#   4. Yerelestirme siniflarini olusturur
#   5. Statik analiz ve testleri kosar
#
# Kullanim:  pwsh -File scripts/setup.ps1
#            (veya PowerShell'de: .\scripts\setup.ps1)

#Requires -Version 5.1
$ErrorActionPreference = 'Stop'

$BeklenenFlutter = '3.44.8'
$ProjeKok = Split-Path -Parent $PSScriptRoot

function Yaz-Baslik([string]$Metin) {
    Write-Host ''
    Write-Host "==> $Metin" -ForegroundColor Cyan
}

function Yaz-Tamam([string]$Metin) {
    Write-Host "    [OK] $Metin" -ForegroundColor Green
}

function Yaz-Uyari([string]$Metin) {
    Write-Host "    [!]  $Metin" -ForegroundColor Yellow
}

Set-Location $ProjeKok
Write-Host 'SmartList kurulum kontrolu' -ForegroundColor White
Write-Host "Proje klasoru: $ProjeKok"

# --------------------------------------------------------------- 1. Flutter
Yaz-Baslik '1/5  Flutter kontrol ediliyor'

$flutter = Get-Command flutter -ErrorAction SilentlyContinue
if (-not $flutter) {
    Write-Host ''
    Write-Host 'HATA: Flutter bulunamadi.' -ForegroundColor Red
    Write-Host 'Kurulum adimlari icin docs/KURULUM.md dosyasinin 1. bolumune bakin.'
    Write-Host 'Kurduktan sonra PATH''e ekleyip yeni bir terminal acmayi unutmayin.'
    exit 1
}
Yaz-Tamam "flutter -> $($flutter.Source)"

$surumCiktisi = & flutter --version 2>&1 | Out-String
if ($surumCiktisi -match 'Flutter (\d+\.\d+\.\d+)') {
    $mevcut = $Matches[1]
    if ($mevcut -eq $BeklenenFlutter) {
        Yaz-Tamam "Flutter $mevcut (beklenen surum)"
    } else {
        Yaz-Uyari "Flutter $mevcut kurulu, proje $BeklenenFlutter ile dogrulandi."
        Yaz-Uyari 'Farkli surumde beklenmeyen analiz/derleme hatalari gorebilirsiniz.'
    }
} else {
    Yaz-Uyari 'Flutter surumu okunamadi, devam ediliyor.'
}

# -------------------------------------------------------------- 2. Paketler
Yaz-Baslik '2/5  Paketler indiriliyor (flutter pub get)'
& flutter pub get
if ($LASTEXITCODE -ne 0) { throw 'flutter pub get basarisiz oldu.' }
Yaz-Tamam 'Paketler hazir'

# ------------------------------------------------------------ 3. Kod uretimi
Yaz-Baslik '3/5  Kod uretiliyor (Freezed + json_serializable)'
Write-Host '    Bu adim ilk seferde birkac dakika surebilir.'
& dart run build_runner build
if ($LASTEXITCODE -ne 0) {
    # En sik sebep, onbellekte kalmis eski cikti. `clean` onbellegi silip
    # sonraki derlemeyi sifirdan yapmaya zorlar. (Eski surumlerdeki
    # --delete-conflicting-outputs bayragi bu build_runner surumunde yok.)
    Yaz-Uyari 'Kod uretimi basarisiz. Onbellek temizlenip tekrar denenecek.'
    & dart run build_runner clean
    & dart run build_runner build

    if ($LASTEXITCODE -ne 0) {
        Write-Host ''
        Write-Host 'Kod uretimi temizlikten sonra da basarisiz oldu.' -ForegroundColor Red
        Write-Host 'Sirayla su komutlari deneyin:' -ForegroundColor Yellow
        Write-Host '  flutter clean'
        Write-Host '  flutter pub get'
        Write-Host '  dart run build_runner build'
        Write-Host ''
        Write-Host 'Hata devam ederse yukaridaki cikti ile birlikte bildirin.'
        throw 'build_runner basarisiz oldu.'
    }
}
Yaz-Tamam 'Uretilen kod guncel'

# ------------------------------------------------------- 4. Yerelestirmeler
Yaz-Baslik '4/5  Yerelestirme siniflari olusturuluyor (flutter gen-l10n)'
& flutter gen-l10n
if ($LASTEXITCODE -ne 0) { throw 'flutter gen-l10n basarisiz oldu.' }
Yaz-Tamam 'Yerelestirmeler hazir'

# ------------------------------------------------------- 5. Analiz ve testler
Yaz-Baslik '5/5  Analiz ve testler kosuluyor'
& flutter analyze
$analizSonuc = $LASTEXITCODE
if ($analizSonuc -eq 0) {
    Yaz-Tamam 'flutter analyze: hic uyari yok'
} else {
    Yaz-Uyari 'flutter analyze uyari/hata bildirdi (yukariya bakin).'
}

& flutter test
$testSonuc = $LASTEXITCODE
if ($testSonuc -eq 0) {
    Yaz-Tamam 'Tum testler gecti'
} else {
    Yaz-Uyari 'Bazi testler basarisiz oldu (yukariya bakin).'
}

# ------------------------------------------------------------------- Sonuc
Write-Host ''
if ($analizSonuc -eq 0 -and $testSonuc -eq 0) {
    Write-Host 'KURULUM TAMAM. Proje calismaya hazir.' -ForegroundColor Green
} else {
    Write-Host 'Kurulum bitti, ancak analiz veya testlerde sorun var.' -ForegroundColor Yellow
}

Write-Host ''
Write-Host 'ARAYUZU HEMEN GORMEK ICIN (Firebase gerekmez):' -ForegroundColor White
Write-Host '  .\scripts\run_preview.ps1              # bagli telefon veya emulator'
Write-Host '  .\scripts\run_preview.ps1 -Device chrome   # tarayicida'
Write-Host ''
Write-Host 'GERCEK UYGULAMAYI CALISTIRMAK ICIN (Firebase gerekir):' -ForegroundColor White
Write-Host '  1. Copy-Item scripts\defines.example.ps1 scripts\defines.local.ps1'
Write-Host '  2. defines.local.ps1 icindeki Firebase degerlerini doldurun'
Write-Host '  3. .\scripts\run_dev.ps1'
Write-Host ''
Write-Host 'Ayrintili anlatim: docs\KURULUM.md'
