# Infinity World Roadmap

Last updated: 2026-06-28

## Purpose

This roadmap is the living development plan for Infinity World. It follows a MediaForge-style workflow: phased work, small scoped tasks, an active backlog, durable decisions, and verification before each commit.

Related planning docs:

- `docs/ARCHITECTURE.md` describes the target direction.
- `docs/TASKS.md` tracks the active backlog and next tasks.
- `docs/DECISIONS.md` records durable project decisions.
- `docs/qa/IW_GIT_WORKFLOW.md` defines commit, push, and verification rules.

## Current Reality

The current app is transitional. The target architecture in `docs/ARCHITECTURE.md` is not fully implemented yet.

Current structure:

- `lib/main.dart` still owns root app composition and uses `GetMaterialApp`.
- `lib/app/bootstrap/startup_route_resolver.dart` now resolves the startup route from the local session flag before `runApp`.
- `lib/routes/app_pages.dart` and `lib/routes/app_routes.dart` still define legacy GetX routing.
- `lib/app/theme/app_theme.dart` now provides the first Midnight Violet light/dark app theme.
- `lib/design_system/` now contains the first tokens and `IwCard` component slice.
- Selected feature screens have been moved under `lib/features/`.
- `lib/screens/main/main_screen.dart` still owns the legacy bottom-tab shell.
- Shared legacy UI remains under `lib/widgets/`.
- `lib/core/config/constants.dart` contains early runtime constants.
- `lib/features/auth/data/local_session_repository.dart` stores the first local session flag and display name with `shared_preferences`.
- Feature placement completed for the Phase 2 selected screens/features:
  - `lib/features/bmi/domain/bmi_calculator.dart`
  - `lib/features/bmi/presentation/bmi_screen.dart`
  - `lib/features/auth/presentation/login_screen.dart`
  - `lib/features/chat/presentation/chat_screen.dart`
  - `lib/features/dashboard/presentation/dashboard_screen.dart`
  - `lib/features/fox/`
  - `lib/features/profile/presentation/profile_screen.dart`
  - `lib/features/settings/presentation/settings_screen.dart`
  - `lib/features/summertime_saga/`
  - `lib/features/test/presentation/test_screen.dart`
- Tests now exist:
  - `test/app_smoke_test.dart`
  - `test/app/theme/app_theme_test.dart`
  - `test/design_system/components/iw_card_test.dart`
  - `test/features/bmi/domain/bmi_calculator_test.dart`
  - `test/features/bmi/presentation/bmi_screen_test.dart`
  - focused feature tests under `test/features/`
  - `test/routes/app_pages_test.dart`

Current dependencies:

- Flutter SDK constraint: `^3.7.0`
- Runtime packages: `get`, `http`, `change_app_package_name`, `shared_preferences`
- Dev packages: `flutter_test`, `flutter_lints`, `shared_preferences_platform_interface`

Riverpod, go_router, and Dio are target-direction technologies but are not installed or active yet. Do not introduce them until their explicit phases/tasks begin.

## Current Known Risks

- Login build-time `setState()` risk has been fixed; emulator/device visual review remains a later QA activity.
- GetX routing remains the active router.
- `lib/screens/` and `lib/routes/` remain active legacy areas.
- Some networking still uses direct `http` services under feature folders.
- Feature placement does not mean routing architecture has migrated; the legacy GetX route table still owns screen registration.
- Theme/design-system implementation now has a first token/card slice; broader components and visual adoption remain incomplete.
- Android toolchain versions have been pulled forward on `home/devbyMinh-current` with explicit approval: Gradle 8.14.5, Android Gradle Plugin 8.11.1, Kotlin Gradle Plugin 2.2.20, Java/Kotlin target 17.
- Built-in Kotlin migration remains deferred until an AGP 9.x migration or a build requirement forces it.

## Target Direction

Use `docs/ARCHITECTURE.md` as the target direction:

- Feature-first structure under `lib/features/<feature>/`.
- App composition under `lib/app/`.
- Shared infrastructure under `lib/core/`.
- Reusable UI under `lib/design_system/`.
- Riverpod for future state/dependency work.
- go_router for future routing work.
- Dio for future networking work.
- Drift only when structured local persistence is actually needed.

The migration must be gradual. The app should stay runnable after each scoped task.

## Migration Rules

- Preserve GetX for now unless a future router migration phase is explicitly started.
- Do not convert GetX to go_router opportunistically.
- Do not introduce Riverpod before a Riverpod foundation task.
- Do not introduce Dio before a networking foundation or feature networking task.
- Do not move many screens at once.
- Do not refactor production Dart code during documentation-only tasks.
- Separate low-risk feature placement from high-risk routing, state, networking, and Android toolchain migrations.
- Use BMI as the current pilot example for gradual feature migration.
- Treat emulator/device UI review as a later QA phase, not a required gate for every current task.

## Phase 0: Living Documentation and Workflow

Status: active / being refreshed.

Goal:

- Keep roadmap, task backlog, decisions, design rules, QA rules, and agent guidance aligned with the actual repo.

Primary docs:

- `AGENTS.md`
- `docs/ROADMAP.md`
- `docs/TASKS.md`
- `docs/DECISIONS.md`
- `docs/ARCHITECTURE.md`
- `docs/DESIGN_SYSTEM.md`
- `docs/design/IW_LAYOUT_SAFETY.md`
- `docs/design/IW_SYSTEM_UI_POLICY.md`
- `docs/qa/IW_GIT_WORKFLOW.md`

Task boundary:

- Documentation/planning only.
- No Dart code changes.
- Verification gate: `git diff --check`.

## Phase 1: Transitional Stabilization

Status: mostly complete for the current baseline.

Goal:

- Make the legacy app safer to modify without migrating the whole architecture.

Recommended tasks:

1. Completed: fix the Login screen build-time `setState()` and keyboard layout risk.
2. Completed: continue the BMI pilot with a small UI layout-safety pass.
3. Completed: align the Settings route constant with the legacy GetX page registration.
4. Completed: continue the BMI pilot with a small feature-quality pass for decimal input and keyboard submit behavior.
5. Add or adjust narrow tests when a task changes behavior or startup risk.

Non-goals:

- No router migration.
- No Riverpod introduction.
- No Dio migration.
- No broad folder migration.
- No design-system rewrite.

## Phase 2: Low-risk Feature Placement

Status: complete for the selected Phase 2 scope as of 2026-06-26.

Goal:

- Move one simple screen or feature at a time toward `lib/features/<feature>/` while keeping GetX routing active.

Completed scope:

- Settings, BMI, Profile, Chat, Dashboard, Login, Fox, Test, and Summertime Saga are placed under `lib/features/`.
- API-backed Fox and Summertime Saga were hardened before placement.
- Legacy GetX route registration remains active but imports placed feature screens.

Not part of Phase 2:

- Moving `lib/screens/main/main_screen.dart`.
- Replacing GetX routing.
- Refactoring `lib/main.dart` app composition.
- Introducing Riverpod, go_router, or Dio.

Verification:

- Screen move/routing/startup gates from `docs/qa/IW_GIT_WORKFLOW.md`.

## Phase 3: Design System Foundation

Status: complete for the first foundation slice as of 2026-06-26.

Goal:

- Start implementing Midnight Violet design tokens and reusable UI components in small slices.

Likely tasks:

- Completed: added minimal `app/theme/` and `design_system/tokens/` files for Midnight Violet light/dark.
- Completed: added one shared `Iw` component, starting with `IwCard`.
- Completed: applied the first slice to Profile as the pilot screen.
- Deferred: expand to buttons, fields, and layout wrappers only after a concrete task asks for them.

Non-goals:

- No full visual redesign of every legacy screen.
- No multi-theme system.
- No heavy animation/glow system.

## Phase 4: App Bootstrap and Local Session

Status: complete as of 2026-06-28.

Goal:

- Move startup/session behavior toward the documented flow:

```text
Native Splash
-> Flutter Bootstrap / Splash
-> Local session check
-> Login or Home
```

This phase may still use existing routing until the router migration starts.

Kickoff audit findings:

- Before T33, `lib/main.dart` started `GetMaterialApp` at `AppRoutes.login`.
- Before T33, `lib/features/auth/presentation/login_screen.dart` navigated to `AppRoutes.main` without saving a local session.
- Before T33, `lib/features/dashboard/presentation/dashboard_screen.dart` navigated to `AppRoutes.login` on logout without clearing a local session.
- `lib/routes/app_pages.dart` and `lib/routes/app_routes.dart` already expose the legacy Login and Main routes needed for the first slice.
- Before T33, `shared_preferences` was not installed.

Completed first implementation slice:

- Keep GetX routing and `GetMaterialApp`.
- Added `shared_preferences` only for the local session flag.
- Added a small bootstrap resolver under `lib/app/bootstrap/` to choose Login or Main before `runApp`.
- Saved session on the existing local login action and cleared session on the existing dashboard logout action.
- Covered logged-out and logged-in startup paths with focused tests.

Completed local profile slice:

- Replaced the credential-looking Login form with a local display-name entry flow.
- Persisted and cleared the local display name through the existing auth data path.
- Kept the GetX router and T33 startup/session behavior unchanged.
- Covered blank-name validation and local profile persistence with focused tests.

Checkpoint findings:

- Audited `lib/main.dart`, `lib/app/bootstrap/`, auth session storage, Login local profile entry, Dashboard logout, legacy GetX routes, and focused startup/session tests.
- Confirmed startup resolves Login or Main before `runApp` using the local session/profile state.
- Confirmed Login saves a nonblank display name, logout clears the session/profile, and tests cover startup, login validation, login persistence, and logout.
- Confirmed Riverpod, go_router, Dio, and real backend authentication were not introduced.

Phase 4 closure:

- No Phase 4 blocker remains.
- The legacy main shell and GetX route table remain active by design and are Phase 5 concerns.

Non-goals:

- No real backend authentication.
- No cloud sync.
- No broad auth redesign.

## Phase 5: Router Migration

Status: current / kickoff audit complete; first implementation slice scoped.

Goal:

- Introduce go_router and migrate routing gradually.

Rules:

- Start with a router migration kickoff audit before adding packages or changing routes.
- Keep existing important screens reachable.
- Do not remove GetX until replacement routing is stable and verified.
- Add route tests or startup smoke tests where practical.
- Preserve Phase 4 startup/session/login/logout behavior during every router slice.
- Do not combine go_router work with Riverpod, Dio, real auth, or shell redesign.

Kickoff audit findings:

- Current GetX route table has ten paths: `/login`, `/main`, `/dashboard`, `/chat`, `/profile`, `/settings`, `/smts_home`, `/testscreen`, `/fox`, and `/bmi`.
- `lib/main.dart` still uses `GetMaterialApp` with an initial route resolved by `lib/app/bootstrap/startup_route_resolver.dart`.
- Production GetX navigation calls are limited to Login entering `/main`, Dashboard opening `/fox`, `/testscreen`, `/smts_home`, `/bmi`, and Dashboard logout returning to `/login`.
- `lib/screens/main/main_screen.dart` owns the legacy three-tab shell: Dashboard, Chat, and Profile. It does not yet match the target Home / Explore / Tools / Library / Settings shell.
- Existing route tests cover deterministic routes. Fox and Summertime Saga direct route smoke tests remain deferred because their default route constructors start live HTTP work in `initState()`.
- A source check against the official `go_router` package docs confirmed the expected root pattern is `GoRouter` with `MaterialApp.router`, URL-based navigation such as `context.go()`, redirects, and shell-route support for nested navigation.

First implementation slice:

- Add `go_router` and introduce a small `lib/app/router/` route configuration.
- Keep existing `AppRoutes` path constants as the route contract during the first slice.
- Swap root app composition from `GetMaterialApp` to `MaterialApp.router`.
- Map the existing route table to go_router, preserving the same startup/Login/Main behavior.
- Replace the current production GetX navigation calls in Login and Dashboard.
- Keep `MainScreen` unchanged; do not redesign shell tabs or introduce `ShellRoute` in the first slice.
- Keep legacy GetX route files/dependency until go_router parity is proven and cleanup is explicitly scoped.

First-slice parity gates:

- Logged-out startup opens Login.
- Logged-in local session opens Main.
- Login saves a local profile and navigates to Main.
- Logout clears the local session/profile and returns to Login.
- Deterministic route smoke tests continue to cover Login, Main, Dashboard, BMI, Test, Settings, Profile, and Chat.
- Fox and Summertime Saga remain mapped routes, but direct route smoke tests stay deferred until their default constructors no longer start live HTTP; rely on existing fake-network feature tests for those screens during the root parity slice.
- Full screen-move/routing gate passes: `flutter pub get`, `dart format`, `flutter analyze`, `flutter test`, `flutter build apk --debug`, and `git diff --check`.

## Phase 6: Riverpod Foundation

Status: deferred, high risk.

Goal:

- Introduce Riverpod for new state and dependency injection.

Rules:

- Start only with an explicit Riverpod foundation task.
- Use a small pilot area first.
- Do not rewrite all StatefulWidgets at once.
- Do not add Provider or BLoC as alternate default state systems.

## Phase 7: Networking Foundation

Status: deferred, medium/high risk.

Goal:

- Introduce Dio and consistent API error/loading behavior when a networking feature is actively migrated.

Good future candidate:

- Summertime Saga, after a focused audit, because it already has API/loading/null-state risk.

Rules:

- Do not add Dio before a scoped networking task.
- Do not call APIs from widget `build()`.
- Keep network logic behind service/repository boundaries.

## Phase 8: Feature Expansion

Status: future.

Potential areas:

- Home dashboard.
- Tools root.
- Library/Reader.
- Explore/RSS.
- Device Hub.
- AI Lab.

Rules:

- Build one vertical slice at a time.
- Prefer useful, polished modules over many incomplete placeholders.
- Keep features lazy and avoid loading every module on Home startup.

## Phase 9: QA, Device Review, and Portfolio Readiness

Status: future.

Goal:

- Add emulator/device UI review, screenshots, README polish, and portfolio documentation after the app shell and pilot features are stable.

Notes:

- Emulator/device UI review is important for UI polish, but it is not required for every current small task.
- UI tasks must still follow `docs/design/IW_LAYOUT_SAFETY.md` and `docs/design/IW_SYSTEM_UI_POLICY.md`.

## Separate Branch Work

Android toolchain/build-system changes should be handled separately unless explicitly approved.

The 2026-06-23 Android toolchain upgrade was explicitly approved on `home/devbyMinh-current`. Future Android toolchain/build-system changes should still use a separate branch/task unless explicitly approved.

Examples:

- Gradle upgrade.
- Android Gradle Plugin upgrade.
- Kotlin plugin/build integration changes.
- Release signing changes.
- Android package/application-id changes.

These tasks have broader blast radius and should not be mixed with feature migration or routine docs work.

## Roadmap Discipline

For every scoped task:

- Confirm branch and working tree state.
- Read relevant planning docs.
- Keep the change small.
- Verify with the gate matching the change type.
- Update `docs/TASKS.md`, `docs/DECISIONS.md`, or this roadmap when scope, phase, or direction changes.
- Commit and push only according to `docs/qa/IW_GIT_WORKFLOW.md`.
