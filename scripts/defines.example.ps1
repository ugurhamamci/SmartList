# SmartList — ortam degiskenleri sablonu
#
# KULLANIM
#   1. Bu dosyayi ayni klasore "defines.local.ps1" adiyla kopyalayin.
#   2. Asagidaki degerleri Firebase Console'dan aldiginiz gercek degerlerle
#      doldurun.
#   3. run_dev.ps1 bu dosyayi otomatik okur.
#
# defines.local.ps1 .gitignore'da oldugu icin asla depoya gitmez. Gercek
# degerleri BU dosyaya yazmayin - bu dosya depoda izlenir.
#
# Degerleri nerede bulacaksiniz:
#   Firebase Console > Proje ayarlari (disli ikonu) > Genel
#   - Proje kimligi            -> FIREBASE_PROJECT_ID
#   - Uygulamalariniz > Android -> FIREBASE_APP_ID_ANDROID, API anahtari
#   - Uygulamalariniz > iOS     -> FIREBASE_APP_ID_IOS, API anahtari
#   Cloud Messaging sekmesi     -> FIREBASE_MESSAGING_SENDER_ID

@{
    # --- Zorunlu -----------------------------------------------------------
    FLAVOR                       = 'development'
    FIREBASE_PROJECT_ID          = 'BURAYA-PROJE-ID'
    FIREBASE_MESSAGING_SENDER_ID = 'BURAYA-SENDER-ID'
    FIREBASE_API_KEY_ANDROID     = 'BURAYA-ANDROID-API-KEY'
    FIREBASE_APP_ID_ANDROID      = 'BURAYA-ANDROID-APP-ID'

    # --- iOS'ta calistiracaksaniz ------------------------------------------
    # FIREBASE_API_KEY_IOS       = ''
    # FIREBASE_APP_ID_IOS        = ''
    # FIREBASE_IOS_BUNDLE_ID     = 'com.mudo.smartlist'

    # --- Opsiyonel ---------------------------------------------------------
    # Storage kullanacaksaniz zorunlu:
    # FIREBASE_STORAGE_BUCKET    = 'proje-id.appspot.com'

    # AI: URETIMDE PROXY KULLANIN, ANAHTAR GOMMEYIN.
    # Yerel gelistirmede tek bir saglayici anahtari yeterlidir.
    # AI_PROXY_BASE_URL          = 'https://<bolge>-<proje>.cloudfunctions.net/ai'
    # AI_PROVIDER                = 'claude'   # claude | openai | gemini
    # ANTHROPIC_API_KEY          = ''
    # OPENAI_API_KEY             = ''
    # GEMINI_API_KEY             = ''

    # Gelistirmede kapali olmasi normaldir:
    # ENABLE_CRASHLYTICS         = 'false'
    # ENABLE_ANALYTICS           = 'false'
    # VERBOSE_LOGGING            = 'true'
}
