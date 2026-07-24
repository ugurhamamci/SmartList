# Build status

An honest account of what exists in this repository and what does not.

Verified on 2026-07-24 with Flutter 3.44.8: `flutter analyze` reports
**no issues** across `lib/` and `test/`, and `flutter test` passes **25 tests**.

## Blocked

**The user interface has not been built.** `tasarim.html` was named as the source
of truth for the interface, with an explicit instruction not to redesign,
simplify, or change any colour, spacing, typography, sizing, padding, margin,
radius, shadow or layout. That file is **0 bytes** — verified by byte length,
line count, and by checking that its only NTFS data stream (`:$DATA`) is also
empty. No screen, widget, colour or spacing value could be derived from it.

Rather than invent a design and present it as the specified one, the UI layer was
left unbuilt and the visual system was structured so it can be applied in one
place:

- `lib/core/theme/design_tokens.dart` holds every colour, radius, spacing,
  elevation, duration and size constant. The current values are Material 3
  baseline defaults and are marked as such — they are **not** the SmartList
  design.
- `lib/core/theme/spacing_theme.dart` exposes those values through a
  `ThemeExtension`, reachable as `context.spacing`.
- No widget hard-codes a visual value. Replacing the constants in those two
  files restyles the entire application.

`lib/features/shared/presentation/screens/build_status_screen.dart` is
scaffolding that reports the build's configuration. It is not a designed screen
and is meant to be deleted once the real navigation shell exists.

## Implemented and verified

| Area | Files |
|---|---|
| Firestore schema, all 28 collections | `docs/FIRESTORE_SCHEMA.md` |
| Security rules, role-based | `firestore.rules`, `storage.rules` |
| Composite indexes and field exemptions | `firestore.indexes.json` |
| Flavors and compile-time config | `lib/core/config/` |
| Firebase options via `--dart-define` | `lib/core/config/firebase_options.dart` |
| Error taxonomy and vendor error mapping | `lib/core/errors/` |
| Startup, global error handlers, persistence | `lib/core/bootstrap.dart` |
| Hive offline cache | `lib/core/database/local_cache.dart` |
| Theme system and design-token indirection | `lib/core/theme/` |
| 18 Freezed entities with codegen | `lib/models/`, `lib/features/ai/domain/` |
| Domain enums with stable wire values | `lib/models/enums.dart` |
| Riverpod infrastructure providers | `lib/providers/core_providers.dart` |
| Vendor-agnostic AI layer (Claude / OpenAI / Gemini) | `lib/features/ai/` |
| Prompt builder and response schema | `lib/features/ai/domain/prompt_builder.dart` |
| Localization scaffold, 40 strings | `lib/l10n/`, `l10n.yaml` |
| Strict lint configuration | `analysis_options.yaml` |
| CI: format, codegen-freshness, analyze, test, Android + iOS release | `.github/workflows/ci.yml` |
| Tests | `test/` — 25 passing |

The AI layer is worth calling out because it is complete and independently
useful: `AiService` is the only entry point feature code needs, three vendors
implement `AiProvider`, and `AiProviderRegistry` resolves the user's preference
with fallback. The Anthropic integration targets `claude-opus-5` and correctly
omits `temperature`/`top_p`/`top_k` (rejected with HTTP 400 on that model family)
and checks `stop_reason` for a refusal before reading `content`. All three
vendors normalise refusals, truncation and token usage into one shape.

## Not implemented

These were in scope and are not present. None is blocked by the missing design
except where noted.

**Depends on the design file** (every screen and widget):
authentication screens, home, list and item screens, chat UI, notification
centre, profile, settings, statistics screens and charts, barcode scanner UI,
voice capture UI, AI generation and review sheets, onboarding, empty and loading
states, Lottie animations, page transitions, drag-and-drop and swipe
interactions.

**Design-independent, still outstanding:**

- Repositories and feature providers for every entity except AI. The models,
  paths and error mapping they build on are in place.
- Authentication service: email/password, Google, Apple, verification, reset,
  session persistence.
- Realtime collaboration: presence heartbeat, typing indicator, read receipts,
  conflict resolution. The data model and timeout constants exist.
- Chat repository.
- FCM registration, handlers, and the Cloud Functions that fan out
  notifications, maintain denormalised counters, aggregate statistics, and
  process invitations. The rules already assume these functions own those
  writes.
- Barcode scanning service and voice/speech-to-text service. Their models
  (`BarcodeScan`, `VoiceCommand`, `ParsedVoiceItem`) and history collections
  exist.
- Offline mutation queue and sync engine. `LocalCache`, the `pending_mutations`
  box, `SyncState` and `MutationKind` exist; the queue processor does not.
- Go Router configuration and route guards.
- Data export and account deletion flows.
- Additional locales (the scaffold and English ARB are in place).
- Integration tests (`integration_test` is wired into `pubspec.yaml`).

## Environment limitations

The Flutter SDK was installed during this work (3.44.8 at `C:\src\flutter`, added
to the user PATH). Two gaps remain on this machine:

- **No Android SDK.** `flutter analyze` and `flutter test` run, but no Android
  APK or app bundle can be produced locally. CI covers this.
- **No Visual Studio C++ workload**, so the Windows desktop target cannot build.
  Chrome and Edge are available if a web target is ever wanted.

iOS builds require macOS and are handled by the `ios` job in CI.

## To resume

1. Supply a non-empty `tasarim.html`.
2. Extract its colours, typography, spacing, radii and shadows into
   `design_tokens.dart` and `spacing_theme.dart`.
3. Build the navigation shell and screens against those tokens, deleting
   `build_status_screen.dart`.
4. Fill in the design-independent gaps listed above; the models, paths, rules and
   error handling they need are already in place.
