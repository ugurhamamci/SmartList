# SmartList — ortam degiskenleri sablonu
#
# KULLANIM
#   1. Bu dosyayi ayni klasore "defines.local.ps1" adiyla kopyalayin.
#   2. Asagidaki degerleri doldurun.
#   3. run_dev.ps1 bu dosyayi otomatik okur.
#
# defines.local.ps1 .gitignore'da oldugu icin asla depoya gitmez. Gercek
# degerleri BU dosyaya yazmayin - bu dosya depoda izleniyor.

@{
    # --- Zorunlu -----------------------------------------------------------
    FLAVOR = 'development'

    # Supabase Dashboard > Project Settings > API
    #
    # SUPABASE_URL      : https://<proje-ref>.supabase.co
    # SUPABASE_ANON_KEY : "publishable" (eski adiyla "anon") anahtar.
    #
    # Bu anahtarin uygulamaya gomulmesi TASARIM GEREGI guvenlidir: kimin neyi
    # gorebilecegine RLS politikalari karar veriyor, anahtar degil.
    #
    # "secret" (sb_secret_...) anahtari BURAYA YAZMAYIN. O anahtar butun RLS
    # politikalarini atlar; uygulamaya konursa APK'dan cikarilip herkesin
    # verisi okunabilir. Yalnizca sunucu tarafinda (Edge Function) kullanilir.
    SUPABASE_URL      = 'BURAYA-SUPABASE-URL'
    SUPABASE_ANON_KEY = 'BURAYA-PUBLISHABLE-ANAHTAR'

    # --- Yapay zeka (opsiyonel) -------------------------------------------
    # Bir saglayici anahtari yeterli; hicbiri yoksa yapay zeka ozelligi kapali
    # kalir, uygulamanin geri kalani calisir.
    #
    # URETIMDE PROXY KULLANIN, ANAHTAR GOMMEYIN: AI_PROXY_BASE_URL verildiginde
    # anahtar cihazda hic bulunmaz.
    # AI_PROXY_BASE_URL  = 'https://<proje-ref>.supabase.co/functions/v1/ai'

    # AI_PROVIDER        = 'openrouter'   # openrouter | claude | openai | gemini
    # OPENROUTER_API_KEY = ''
    # OPENROUTER_MODEL   = 'openai/gpt-oss-20b:free'
    # ANTHROPIC_API_KEY  = ''
    # OPENAI_API_KEY     = ''
    # GEMINI_API_KEY     = ''

    # --- Gelistirme --------------------------------------------------------
    VERBOSE_LOGGING = 'true'
}
