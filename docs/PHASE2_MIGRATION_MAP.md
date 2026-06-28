# Infinity World Phase 2 Migration Map

Last updated: 2026-06-29

## Purpose

Phase 2 moves low-risk legacy screens toward `lib/features/<feature>/presentation/` while keeping the current app runnable.

This map is intentionally narrow. It does not start Riverpod, go_router, Dio, `lib/main.dart` composition refactors, or UI redesign.

Checkpoint outcome on 2026-06-26:

- Phase 2 selected feature placement work is complete.
- Remaining tracked legacy screen ownership is the main shell, not a simple feature-screen move.
- GetX routes remain active and should be handled in a later explicit routing phase.

Post-Phase-2 update on 2026-06-28:

- T39 moved the legacy main shell ownership to `lib/app/shell/main_screen.dart`.
- No tracked Dart files remain under `lib/screens/`.

Post-router-cleanup update on 2026-06-29:

- T41 removed the inactive GetX route table and `get` dependency.
- Active routing is now go_router-only.

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
- `summertime_saga`
  - `lib/features/summertime_saga/data/smts_service.dart`
  - `lib/features/summertime_saga/domain/smts_progress_model.dart`
  - `lib/features/summertime_saga/presentation/smts_home_screen.dart`
- `test`
  - `lib/features/test/presentation/test_screen.dart`

Still transitional after Phase 2:

- `lib/main.dart` still owns root app composition.
- `lib/routes/app_routes.dart` still owns shared route path constants.
- The legacy three-tab shell behavior now lives under `lib/app/shell/main_screen.dart`.
- No selected feature-screen Dart files remain under tracked `lib/screens/` paths.

## Remaining legacy screen map

| Legacy path | Current role | Phase 2 action | Risk | Notes |
|---|---|---:|---:|---|
| `lib/screens/main/main_screen.dart` | Legacy bottom-tab shell | Moved after Phase 2 in T39 | Done | Current owner: `lib/app/shell/main_screen.dart`. |

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
11. Completed: fix Test screen lifecycle and keyboard-safety risks before any move or removal decision.
12. Completed: move Test screen only if it remains useful after stabilization.
13. Completed: run a Dashboard UI layout-safety pass.
14. Completed: create a Summertime Saga hardening plan before implementation or feature move.
15. Completed: harden Summertime Saga network foundation.
16. Completed: stabilize Summertime Saga screen states and layout.
17. Completed: move Summertime Saga only after deterministic tests exist.
18. Completed: run a Phase 2 checkpoint audit before deciding the next placement or phase transition.

Conclusion:

- Do not continue moving random screens in Phase 2.
- Move to Phase 3 planning for the design-system foundation.
- Keep shell, router, state, networking, and startup migrations separate.

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
- Summertime Saga, because the go_router route still uses the default live loader.

## Placement rules

- Move one screen or feature folder at a time.
- Keep route path constants in `lib/routes/app_routes.dart`.
- Update only imports and narrow tests needed for the move.
- Do not redesign UI during placement-only tasks.
- Do not introduce Riverpod, go_router, Dio, or new dependencies.
- If a screen has lifecycle, network, or layout risks, report them and split fixes into follow-up tasks.

## Verification by task type

- Simple screen move: `dart format`, `flutter analyze`, `flutter test`, `flutter build apk --debug`, `git diff --check`.
- Docs-only map update: `git diff --check`.
- API-backed feature move: use screen move gates, and add focused tests before broad refactors.
