# Fox Feature Hardening Plan

Last updated: 2026-06-29

## Scope

This plan prepares the legacy Fox feature for a safe feature-structure move.

Do not use this plan to start Riverpod, Dio, or a UI redesign. Routing moved to go_router later in Phase 5.

## Current flow

```text
DashboardScreen
-> context.go(AppRoutes.fox)
-> GoRoute in lib/app/router/app_router.dart
-> FoxRandomScreen
-> FoxApiService.getRandomFox()
-> https://randomfox.ca/floof/
-> FoxModel
-> Image.network(fox.image)
```

Current files:

- `lib/features/fox/presentation/fox_random_screen.dart`
- `lib/features/fox/data/fox_api_service.dart`
- `lib/features/fox/domain/fox_model.dart`
- `lib/app/router/app_router.dart`
- `lib/routes/app_routes.dart`

Historical notes below may mention GetX route registration because they describe completed pre-router tasks. Current routing is go_router-only.

## Findings before T14

- The screen starts live HTTP work in `initState()`, so route smoke tests are not deterministic yet.
- Resolved in T14: `FoxApiService` used direct `http.get` with no timeout and no injectable test seam.
- Resolved in T14: JSON parsing accepted missing fields as empty strings, which could later produce invalid image URLs.
- Resolved in T14: Service failures used generic `Exception` values.
- `FoxRandomScreen` assumes non-null `snapshot.data`.
- Android release `main` manifest does not declare `INTERNET`; debug/profile manifests do.
- The current UI uses a fixed `Column` with `Expanded` sections. Layout safety should be reviewed separately before visual polish.

## Hardening goals before moving Fox

- Keep the existing user behavior: open Fox screen, load a random fox image, retry on failure.
- Make the API/service path testable without real network.
- Add timeout and response/body validation.
- Treat missing or invalid `image` as an error, not as an empty URL.
- Keep user-facing error and retry behavior.
- Add deterministic tests before route coverage is expanded.
- Confirm Android release network permission before relying on API-backed features in release builds.

## Suggested task sequence

### Completed: T14 - Harden Fox API service and model parsing

Result:

- Kept `http`; Dio remains deferred.
- Added a small fake-network seam for tests.
- Added timeout behavior.
- Validated HTTP status, JSON shape, and non-empty `image` URL.
- Added focused service/model tests with fake responses.

Verified with:

- `dart format`
- `flutter test test/features/fox/data/fox_api_service_test.dart`
- `flutter analyze`
- `flutter test`
- `git diff --check`

### Completed: T15 - Add deterministic Fox screen coverage

Result:

- Avoid real network in widget tests.
- Added the smallest test seam needed for `FoxRandomScreen`.
- Verified deterministic loading, error, and retry states.
- Kept GetX route registration unchanged.

Verified with:

- `dart format`
- `flutter test test/features/fox/presentation/fox_random_screen_test.dart`
- `flutter analyze`
- `flutter test`
- `git diff --check`

### Completed: T16 - Move Fox to feature structure

Result:

- Moved legacy Fox files to `lib/features/fox/`.
- Used a small `data/`, `domain/`, and `presentation/` structure.
- Updated legacy GetX route imports only.
- Did not introduce Riverpod, go_router, or Dio.

Verified with:

- `dart format`
- `flutter analyze`
- `flutter test`
- `flutter build apk --debug`
- `git diff --check`

### Completed: T17 - Fox UI layout-safety pass

Result:

- Replaced the fixed `Column`/`Expanded` body with a SafeArea-aware, scroll-safe layout.
- Kept the current route, service behavior, retry behavior, and visual direction unchanged.
- Did not add fullscreen image viewer behavior or migrate Fox to Dio, Riverpod, or go_router.
- Added small-screen widget coverage for loading, error, and retry states.

Verified with:

- `dart format`
- `flutter analyze`
- `flutter test`
- `git diff --check`

Phase 2 status:

- Fox is complete for Phase 2 unless a new concrete risk, failed verification, blocker, or user-approved remaining scope appears.
- `/fox` route smoke coverage was completed later in T43 through a router-level builder override and fake service.

## Deferred

- Dio/network layer migration.
- Riverpod controller/provider migration.
- Offline cache or favorites.
- Gallery/history of fox images.
- Fullscreen image viewer.
- Visual redesign.
