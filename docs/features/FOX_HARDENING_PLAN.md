# Fox Feature Hardening Plan

Last updated: 2026-06-26

## Scope

This plan prepares the legacy Fox feature for a safe feature-structure move.

Do not use this plan to start Riverpod, go_router, Dio, or a UI redesign. Those remain later phases.

## Current flow

```text
DashboardScreen
-> Get.toNamed(AppRoutes.fox)
-> AppPages.fox
-> FoxRandomScreen
-> FoxApiService.getRandomFox()
-> https://randomfox.ca/floof/
-> FoxModel
-> Image.network(fox.image)
```

Current files:

- `lib/screens/fox/fox_random_screen.dart`
- `lib/screens/fox/services/fox_api_service.dart`
- `lib/screens/fox/models/fox_model.dart`
- `lib/routes/app_pages.dart`
- `lib/routes/app_routes.dart`

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
- `flutter test test/screens/fox/services/fox_api_service_test.dart`
- `flutter analyze`
- `flutter test`
- `git diff --check`

### T15 - Add deterministic Fox screen or route smoke coverage

Scope:

- Avoid real network in widget tests.
- Add the smallest test seam needed for `FoxRandomScreen`.
- Verify loading/success/error retry behavior where practical.
- Keep GetX route registration unchanged.

Verification:

- `dart format`
- `flutter analyze`
- `flutter test`
- `git diff --check`

### T16 - Move Fox to feature structure

Scope:

- Move legacy Fox files to `lib/features/fox/`.
- Use a small structure only as needed, likely `data/`, `domain/`, and `presentation/`.
- Update legacy GetX route imports only.
- Do not introduce Riverpod, go_router, or Dio in the move task.

Verification:

- `dart format`
- `flutter analyze`
- `flutter test`
- `flutter build apk --debug`
- `git diff --check`

### T17 - Fox UI layout-safety pass

Scope:

- Apply Flutter UI layout-safety rules after service behavior is stable.
- Keep the current visual direction unless a redesign task is explicitly assigned.
- Check small screens, image loading/error states, retry button reachability, and system navigation safety.

Verification:

- `dart format`
- `flutter analyze`
- `flutter test`
- `git diff --check`

## Deferred

- Dio/network layer migration.
- Riverpod controller/provider migration.
- go_router route migration.
- Offline cache or favorites.
- Gallery/history of fox images.
- Fullscreen image viewer.
- Visual redesign.
