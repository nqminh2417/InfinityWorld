# Summertime Saga Feature Hardening Plan

Last updated: 2026-06-26

## Scope

This plan prepares the legacy Summertime Saga tracker for safe hardening and later feature placement.

Do not use this plan to start Dio, Riverpod, go_router, or a UI redesign. Those remain later phases.

## Current flow

```text
DashboardScreen
-> Get.toNamed(AppRoutes.smtsHome)
-> AppPages.smtsHome
-> SmtsHomeScreen
-> SmtsService.getProgress()
-> https://summertimesaga.com/data/progress.json
-> SmtsProgressModel
-> ProgressBar widgets
```

Current files:

- `lib/screens/summertime_saga/smts_home_screen.dart`
- `lib/screens/summertime_saga/services/smts_service.dart`
- `lib/screens/summertime_saga/models/smts_progress_model.dart`
- `lib/screens/summertime_saga/widgets/progress_bar.dart`
- `lib/routes/app_pages.dart`
- `lib/routes/app_routes.dart`
- `lib/core/config/constants.dart`
- `android/app/src/main/AndroidManifest.xml`

## Findings before hardening

- The screen starts live HTTP work in `initState()`, so route rendering tests are not deterministic yet.
- `SmtsService` uses direct static `http.get` with no timeout and no injectable test seam.
- `SmtsService` catches failures, prints to console, and returns `null`, so the screen can show a loading spinner forever.
- `SmtsService` builds `_progressUrl` from `Cfg.smtsBaseUrl` and does not use the existing `Cfg.smtsProgressUrl` / `Cfg.smtsProgressUri`.
- `SmtsHomeScreen._fetchProgress()` calls `setState()` after `await` without checking `mounted`.
- `SmtsHomeScreen` force-unwraps many nullable API fields, for example totals, issues, departments, and nested percent values.
- `ProgressBar` force-unwraps nullable counts and percent values; missing or invalid API data can crash rendering.
- The current body uses a fixed full-height container with a non-scrollable `Column`; small screens or large content can overflow.
- Android debug/profile manifests declare `INTERNET`, but `android/app/src/main/AndroidManifest.xml` does not. Release networking can fail.
- There are no focused Summertime Saga service/model/widget tests yet.

## Hardening goals before moving files

- Keep the existing user behavior: open the tracker, load progress, show department bars.
- Keep `http` for now; do not migrate to Dio in this sequence.
- Make the API path testable without real network.
- Add timeout, status-code handling, malformed JSON handling, and schema validation.
- Treat missing required progress data as an explicit error, not as `null`.
- Keep loading, error, retry, and success states deterministic.
- Prevent `setState()` after dispose and stale loading states.
- Make the screen SafeArea-aware and scroll-safe before or during screen-state hardening.
- Confirm release network permission before relying on the feature in APK builds.

## Suggested task sequence

### T23 - Harden Summertime Saga network foundation

Scope:

- Keep the legacy file locations for this task.
- Keep `http`; do not introduce Dio.
- Use the existing `Cfg.smtsProgressUrl` / `Cfg.smtsProgressUri` instead of rebuilding the URL from `smtsBaseUrl`.
- Add a small fake-network seam for tests.
- Add request timeout, explicit non-2xx handling, malformed JSON handling, and required-field validation.
- Replace silent `null` failures with a deterministic error contract.
- Confirm or add Android release `INTERNET` permission if it is still missing.
- Add focused service/model tests with fake responses.

Verification:

- `dart format`
- `flutter test` for the new Summertime Saga service/model tests
- `flutter analyze`
- `flutter test`
- `flutter build apk --debug`
- `git diff --check`

### T24 - Stabilize Summertime Saga screen states and layout

Scope:

- Keep GetX routing and legacy file locations.
- Add a small screen test seam so widget tests avoid live HTTP.
- Add deterministic loading, error, retry, and success states.
- Add `mounted` safety after async work.
- Replace force unwraps in the screen path with safe rendering or validated data assumptions from the service layer.
- Make the screen SafeArea-aware and scroll-safe.
- Do not redesign the visual style.

Verification:

- `dart format`
- `flutter test` for Summertime Saga widget tests
- `flutter analyze`
- `flutter test`
- `git diff --check`

### T25 - Move Summertime Saga to feature structure

Scope:

- Move only Summertime Saga files after network and screen behavior are deterministic.
- Suggested target:

```text
lib/features/summertime_saga/
  data/
  domain/
  presentation/
```

- Update legacy GetX route imports only.
- Keep behavior, route names, `http`, and UI unchanged.
- Add or update route smoke coverage only if the screen no longer starts uncontrolled live HTTP work.

Verification:

- `dart format`
- `flutter analyze`
- `flutter test`
- `flutter build apk --debug`
- `git diff --check`

## Deferred

- Dio/network layer migration.
- Riverpod controller/provider migration.
- go_router route migration.
- Offline cache or local persistence.
- Feature redesign.
- Full architecture migration for `lib/main.dart` or the app shell.
