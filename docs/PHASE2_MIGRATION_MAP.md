# Infinity World Phase 2 Migration Map

Last updated: 2026-06-26

## Purpose

Phase 2 moves low-risk legacy screens toward `lib/features/<feature>/presentation/` while keeping the current app runnable.

This map is intentionally narrow. It does not start Riverpod, go_router, Dio, `lib/main.dart` composition refactors, or UI redesign.

## Current feature placements

Already placed under `lib/features/`:

- `auth`
  - `lib/features/auth/presentation/login_screen.dart`
- `bmi`
  - `lib/features/bmi/domain/bmi_calculator.dart`
  - `lib/features/bmi/presentation/bmi_screen.dart`
- `chat`
  - `lib/features/chat/presentation/chat_screen.dart`
- `dashboard`
  - `lib/features/dashboard/presentation/dashboard_screen.dart`
- `fox`
  - `lib/features/fox/data/fox_api_service.dart`
  - `lib/features/fox/domain/fox_model.dart`
  - `lib/features/fox/presentation/fox_random_screen.dart`
- `profile`
  - `lib/features/profile/presentation/profile_screen.dart`
- `settings`
  - `lib/features/settings/presentation/settings_screen.dart`

Still transitional:

- `lib/main.dart` still owns root app composition.
- `lib/routes/` still owns legacy GetX route registration.
- `lib/screens/main/main_screen.dart` still owns the legacy bottom-tab shell.
- Most legacy screens still live under `lib/screens/`.

## Remaining legacy screen map

| Legacy path | Current role | Phase 2 action | Risk | Notes |
|---|---|---:|---:|---|
| `lib/screens/main/main_screen.dart` | Legacy bottom-tab shell | Do not move in Phase 2 unless explicitly approved | High | Belongs closer to future `app/shell`, not a feature screen. |
| `lib/screens/test/test_screen.dart` | Dashboard-linked dev/test route | Stabilize before deciding move or removal | Medium | T18 confirmed Dashboard links to it. Fix `TextEditingController` ownership and form layout safety before placement. |
| `lib/screens/summertime_saga/` | API-backed Summertime Saga feature | Defer | High | Known null/error/loading risks and direct `http`; stabilize before moving. |

## Recommended ordering

1. Completed: move Chat screen to `lib/features/chat/presentation/`.
2. Completed: add deterministic route smoke tests for simple routes.
3. Completed: move Dashboard as an import-only placement task.
4. Completed: move Login after confirming startup smoke tests cover the flow.
5. Completed: create Fox hardening plan before moving API-backed features.
6. Completed: harden Fox API service/model behavior with deterministic tests.
7. Completed: add deterministic Fox screen coverage before moving the files.
8. Completed: move Fox to feature structure as a placement-only task.
9. Completed: run a Fox UI layout-safety pass.
10. Completed: audit the Test screen before deciding whether to keep, move, or remove it later.
11. Fix Test screen lifecycle and keyboard-safety risks before any move or removal decision.
12. Move Test screen only if it remains useful after stabilization.
13. Defer Summertime Saga until explicit feature hardening tasks.

## Route smoke coverage

Covered by deterministic route smoke tests:

- Login
- Main
- Dashboard
- Chat
- Profile
- Settings
- BMI
- Test

Deferred route rendering tests:

- Fox, because the screen starts live HTTP work in `initState()`.
- Summertime Saga, because the screen starts live HTTP work in `initState()` and has known null/error risks.

## Placement rules

- Move one screen or feature folder at a time.
- Keep GetX route registration in `lib/routes/`.
- Update only imports and narrow tests needed for the move.
- Do not redesign UI during placement-only tasks.
- Do not introduce Riverpod, go_router, Dio, or new dependencies.
- If a screen has lifecycle, network, or layout risks, report them and split fixes into follow-up tasks.

## Verification by task type

- Simple screen move: `dart format`, `flutter analyze`, `flutter test`, `flutter build apk --debug`, `git diff --check`.
- Docs-only map update: `git diff --check`.
- API-backed feature move: use screen move gates, and add focused tests before broad refactors.
