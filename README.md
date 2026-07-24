# SmartList

AI-powered collaborative shopping lists for couples, families, roommates and
friends. Android and iOS from one Flutter codebase.

- Flutter 3.44.8 / Dart 3.12.2
- Clean architecture, feature-first layout, Riverpod, Freezed, Go Router
- Firebase: Auth, Firestore, Storage, Messaging, Analytics, Crashlytics,
  Functions

## Status

The data, configuration and service layers are implemented and verified
(`flutter analyze` reports no issues; `flutter test` passes). **The user
interface has not been built**: `tasarim.html` is the specified source of truth
for the design and was empty (0 bytes), so no screen could be produced from it.
See `docs/BUILD_STATUS.md` for exactly what exists and what remains.

## Prerequisites

| Tool | Version | Needed for |
|---|---|---|
| Flutter | 3.44.8 (stable) | Everything |
| Android SDK + Java 17 | — | Android builds |
| Xcode | latest | iOS builds (macOS only) |
| Firebase CLI | latest | Deploying rules, indexes, functions |

## Configuration

No Firebase identifiers or API keys are committed. Every environment-specific
value arrives through `--dart-define`, so one codebase targets the development,
staging and production Firebase projects without swapping checked-in files.

### Required

| Define | Purpose |
|---|---|
| `FLAVOR` | `development` \| `staging` \| `production` |
| `FIREBASE_PROJECT_ID` | Firebase project id |
| `FIREBASE_MESSAGING_SENDER_ID` | Shared across platforms |
| `FIREBASE_API_KEY_ANDROID` / `_IOS` / `_WEB` | Per-platform API key |
| `FIREBASE_APP_ID_ANDROID` / `_IOS` / `_WEB` | Per-platform app id |

### Optional

| Define | Default | Purpose |
|---|---|---|
| `FIREBASE_STORAGE_BUCKET` | — | Required to use Storage |
| `FIREBASE_AUTH_DOMAIN` | — | Web sign-in |
| `FIREBASE_MEASUREMENT_ID` | — | Web analytics |
| `FIREBASE_IOS_BUNDLE_ID` | `com.mudo.smartlist` | iOS bundle id |
| `AI_PROXY_BASE_URL` | — | Server-side AI proxy; **use this in production** |
| `AI_PROVIDER` | `claude` | Default vendor: `claude`, `openai`, `gemini` |
| `ANTHROPIC_API_KEY` | — | Local development only |
| `OPENAI_API_KEY` | — | Local development only |
| `GEMINI_API_KEY` | — | Local development only |
| `ENABLE_CRASHLYTICS` | on outside development | Crash reporting |
| `ENABLE_ANALYTICS` | on outside development | Analytics |
| `ENABLE_FIRESTORE_PERSISTENCE` | `true` | Offline cache |
| `VERBOSE_LOGGING` | on outside production | Log level |

Ship production builds with `AI_PROXY_BASE_URL` and **no** provider key. A key
compiled into the binary is extractable; the proxy keeps it server-side. The
direct-key path exists so a developer can work against a vendor sandbox.

Missing a required define fails fast at startup with a screen naming the
variable, rather than an opaque runtime error.

## Running

```sh
flutter pub get
dart run build_runner build          # Freezed + json_serializable
flutter gen-l10n                     # localizations

flutter run \
  --dart-define=FLAVOR=development \
  --dart-define=FIREBASE_PROJECT_ID=... \
  --dart-define=FIREBASE_MESSAGING_SENDER_ID=... \
  --dart-define=FIREBASE_API_KEY_ANDROID=... \
  --dart-define=FIREBASE_APP_ID_ANDROID=...
```

Re-run `build_runner` after changing any model, and `gen-l10n` after changing an
ARB file. During active development `dart run build_runner watch` is faster.

## Verifying

```sh
flutter analyze          # must report no issues
flutter test             # unit + widget tests
flutter test --coverage
```

## Firebase

```sh
firebase emulators:start --only firestore,storage,auth
firebase deploy --only firestore:rules,firestore:indexes,storage
```

Security rules live in `firestore.rules` and `storage.rules`; composite indexes
in `firestore.indexes.json`. The role model and every schema decision are
documented in `docs/FIRESTORE_SCHEMA.md`.

## Releasing

```sh
flutter build appbundle --release --dart-define=FLAVOR=production ...
flutter build ipa --release --dart-define=FLAVOR=production ...
```

`.github/workflows/ci.yml` runs format, codegen-freshness, analyze and test on
every push, and builds signed Android and iOS artifacts for `staging` and
`production` on `main`. Firebase values and signing material come from
repository secrets.

## Layout

```
lib/
  app.dart                 application root
  main*.dart               per-flavor entry points
  core/
    bootstrap.dart         startup, error handlers, persistence
    config/                flavors, compile-time config, Firebase options
    constants/             Firestore paths, tunables, storage keys
    database/              Hive offline cache
    errors/                exception taxonomy and vendor error mapping
    theme/                 design tokens, ThemeData, spacing extension
    utils/                 logger, JSON converters
  features/
    ai/                    vendor-agnostic AI layer
    ...                    one directory per feature (data/domain/presentation)
  l10n/                    ARB files and generated localizations
  models/                  Freezed entities shared across features
  providers/               Riverpod infrastructure providers
docs/                      schema and build-status documentation
```

## Architecture notes

**Errors.** Repositories translate `FirebaseException`, `DioException` and
`PlatformException` into the sealed `AppException` hierarchy at a single
boundary (`core/errors/error_mapper.dart`). No presentation code inspects a
vendor error code, and every exception carries a stable `code` that resolves to
localized copy.

**AI.** Feature code depends only on `AiService`. Vendors implement
`AiProvider`; `AiProviderRegistry` resolves the user's preference and falls back
through the configured vendors, so a missing key degrades rather than breaks.
Adding a vendor means adding one file.

**Theme.** Every visual value comes from `core/theme/design_tokens.dart` or the
`SpacingTheme` extension. No widget hard-codes a colour, radius, shadow or
spacing value, so applying the real design is an edit to those two files.
