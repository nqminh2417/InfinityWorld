# Infinity World Roadmap

Last updated: 2026-06-30

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

- `lib/main.dart` still owns root app composition, now uses `MaterialApp.router`, and consumes the Riverpod app theme-mode provider.
- `lib/app/bootstrap/startup_route_resolver.dart` now resolves the startup route from the local session flag before `runApp`.
- `lib/app/router/app_router.dart` maps the current route table with go_router.
- `lib/routes/app_routes.dart` still defines shared path constants.
- `lib/app/theme/app_theme.dart` now provides the first Midnight Violet light/dark app theme.
- `lib/app/theme/app_theme_mode_provider.dart` exposes the persisted app-level theme mode provider/controller with a fallback default of `ThemeMode.system`.
- `lib/design_system/` now contains the first tokens and `IwCard` component slice.
- Selected feature screens have been moved under `lib/features/`.
- `lib/app/shell/main_screen.dart` now contains the local five-tab bottom shell skeleton.
- Shared legacy UI remains under `lib/widgets/`.
- `lib/core/config/constants.dart` contains early runtime constants.
- `lib/features/auth/data/local_session_repository.dart` stores the first local session flag and display name with `shared_preferences`.
- `lib/features/auth/application/session_providers.dart` exposes the local session repository and current display-name providers.
- `lib/features/profile/presentation/profile_screen.dart` now consumes the persisted local display name through Riverpod.
- `lib/features/settings/presentation/settings_screen.dart` now consumes the persisted local display name and app theme mode through Riverpod and exposes theme-mode controls.
- `lib/features/dashboard/presentation/dashboard_screen.dart` now consumes the persisted local display name through Riverpod.
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
  - `test/routes/app_router_test.dart`, including deterministic route smoke coverage for live-network Fox and Summertime Saga paths

Current dependencies:

- Flutter SDK constraint: `^3.7.0`
- Runtime packages: `go_router`, `flutter_riverpod`, `dio`, `change_app_package_name`, `shared_preferences`
- Dev packages: `flutter_test`, `flutter_lints`, `shared_preferences_platform_interface`

go_router is active for the root route table. Riverpod foundation is complete for current local session/profile/theme preferences. Dio is active for Fox and Summertime Saga, and `http` has been removed.

## Current Known Risks

- Login build-time `setState()` risk has been fixed; emulator/device visual review remains a later QA activity.
- go_router is the active root router and Phase 5 is closed.
- `lib/routes/app_routes.dart` remains the shared path contract for go_router.
- Broader networking policy for retry/cache/offline behavior remains deferred until a concrete feature need exists.
- Feature placement does not mean rich tab content has migrated; `MainScreen` now lives in `lib/app/shell/` with a local five-tab shell skeleton and placeholder tab bodies where roots are not implemented yet.
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

- GetX has been removed from active dependencies after root go_router parity.
- Do not reintroduce GetX for new routing or state work.
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

Status: complete as of 2026-06-29.

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
- At kickoff, existing route tests covered deterministic routes, while Fox and Summertime Saga direct route smoke tests stayed deferred because their default route constructors started live HTTP work in `initState()`.
- A source check against the official `go_router` package docs confirmed the expected root pattern is `GoRouter` with `MaterialApp.router`, URL-based navigation such as `context.go()`, redirects, and shell-route support for nested navigation.

First implementation slice:

- Completed: added `go_router` and introduced `lib/app/router/app_router.dart`.
- Completed: kept existing `AppRoutes` path constants as the route contract.
- Completed: swapped root app composition from `GetMaterialApp` to `MaterialApp.router`.
- Completed: mapped the existing route table to go_router, preserving the same startup/Login/Main behavior.
- Completed: replaced the current production GetX navigation calls in Login and Dashboard.
- Completed: kept `MainScreen` unchanged; no shell redesign or `ShellRoute` was introduced.
- Completed later: legacy GetX route files/dependency were removed after parity passed.

First-slice parity gates:

- Logged-out startup opens Login.
- Logged-in local session opens Main.
- Login saves a local profile and navigates to Main.
- Logout clears the local session/profile and returns to Login.
- Deterministic route smoke tests continue to cover Login, Main, Dashboard, BMI, Test, Settings, Profile, and Chat.
- Fox and Summertime Saga remain mapped routes. During the root parity slice, direct route smoke tests stayed deferred and relied on existing fake-network feature tests for those screens.
- Full screen-move/routing gate passes: `flutter pub get`, `dart format`, `flutter analyze`, `flutter test`, `flutter build apk --debug`, and `git diff --check`.

Shell ownership audit findings:

- `MainScreen` is a thin stateful wrapper around three tab children: Dashboard, Chat, and Profile.
- `/main` is the only startup/session shell entry point; direct `/dashboard`, `/chat`, and `/profile` routes still exist for route parity and tests.
- Dashboard and Profile currently own their own `Scaffold` and SafeArea handling, so a shell move should not also refactor child-screen layout.
- The next low-risk slice is an ownership move to `lib/app/shell/`; five target tabs and `ShellRoute` should wait for a dedicated shell-routing/design task.

Shell ownership move:

- Completed: moved `MainScreen` from `lib/screens/main/main_screen.dart` to `lib/app/shell/main_screen.dart`.
- Completed: kept the `MainScreen` class name, `/main` route behavior, and Dashboard / Chat / Profile tabs unchanged.
- Completed: updated the active go_router table and route/session smoke tests to import the shell from `lib/app/shell/`; the inactive legacy GetX route table was removed later in T41.

Legacy GetX cleanup audit findings before T41:

- Before T41, Dart GetX usage was limited to `lib/routes/app_pages.dart`.
- Before T41, `lib/routes/app_pages.dart` was inactive; active routing was owned by `lib/app/router/app_router.dart` and `MaterialApp.router`.
- Before T41, `get` remained a direct dependency only to compile the inactive GetX route table.
- `lib/routes/app_routes.dart` should stay because it is still the shared path contract used by active go_router routes and startup/session code.

Legacy GetX cleanup:

- Completed: removed inactive `lib/routes/app_pages.dart`.
- Completed: removed the `get` dependency and lockfile entry.
- Completed: renamed route smoke coverage to `test/routes/app_router_test.dart`.

Live-network route smoke strategy:

- Completed: audited `app_router.dart`, Fox, Summertime Saga, and existing fake-network tests.
- Decision: add a small router factory override seam for tests, then use `FoxRandomScreen(service: ...)` and `SmtsHomeScreen(loadProgress: ..., logoUrl: '')` for deterministic route smoke coverage.
- Do not wait for Dio, Riverpod, or networking migration for this coverage.

Live-network route smoke implementation:

- Completed: added optional Fox and Summertime Saga builder overrides to `createAppRouter`.
- Completed: added deterministic `/fox` and `/smts_home` route smoke tests using fake services/loaders.
- Production route constructors remain unchanged when no override is supplied.

Five-tab shell implementation audit:

- Completed: audited `MainScreen`, `app_router.dart`, existing feature roots, route tests, and layout/system UI policy.
- Findings: `MainScreen` is still a local-state shell using Dashboard / Chat / Profile; Home, Explore, Tools, and Library feature roots do not exist yet; Settings exists but is still a placeholder.
- Decision: implement the first five-tab slice inside `MainScreen` without `ShellRoute`, keeping `/main` as the startup shell route and keeping direct routes for existing feature parity.
- Do not use Fox or Summertime Saga as tab roots because their default screens start network work in `initState()`.

Local five-tab shell skeleton:

- Completed: `MainScreen` now exposes Home / Explore / Tools / Library / Settings in a fixed bottom navigation bar.
- Completed: Home preserves existing Dashboard access, including module links and logout.
- Completed: Explore, Tools, and Library use local safe placeholder tab bodies; Settings uses the existing settings screen.
- `ShellRoute`, tab-specific route paths, richer tab content, Riverpod, Dio, and live-network tab roots remain deferred.

ShellRoute/deep-link audit:

- Completed: audited current `MainScreen`, `app_router.dart`, `AppRoutes`, startup/session tests, route smoke tests, and current go_router shell-route guidance.
- Findings: `/main` is still the only startup/session shell entry point, direct feature routes remain covered, and no tab currently owns a nested route stack.
- Decision: do not add `ShellRoute`, `StatefulShellRoute`, `/home`, `/explore`, `/tools`, or `/library` yet.
- Future shell routing should prefer `StatefulShellRoute` over plain `ShellRoute` if the app needs separate tab navigation stacks or preserved tab branch state.

Phase 5 checkpoint:

- Completed: re-audited active router composition, route constants, startup/session flow, direct route smoke tests, shell widget coverage, dependency state, and planning docs.
- Decision: close Phase 5 with `ShellRoute`, tab-specific route paths, richer tab content, and feature root expansion deferred.
- Remaining router work should be driven by concrete future feature needs, not by Phase 5 migration cleanup.

Later phase focus:

- Phase 6 Riverpod foundation is now closed.
- Phase 7 starts with a networking foundation kickoff audit before adding Dio.

## Phase 6: Riverpod Foundation

Status: complete as of 2026-06-30.

Goal:

- Introduce Riverpod for new state and dependency injection.

Rules:

- Start only with an explicit Riverpod foundation task.
- Use a small pilot area first.
- Do not rewrite all StatefulWidgets at once.
- Do not add Provider or BLoC as alternate default state systems.

Kickoff audit findings:

- Before T49, Riverpod was not installed or active; runtime state dependencies were `go_router`, `http`, and `shared_preferences`.
- Root app composition is still in `lib/main.dart`, with `MainApp` creating a `GoRouter` and using `MaterialApp.router`.
- Startup route selection is resolved before `runApp` by `lib/app/bootstrap/startup_route_resolver.dart`.
- Local session/profile state is centralized in `lib/features/auth/data/local_session_repository.dart`.
- Login and Dashboard directly construct `LocalSessionRepository` for save/clear actions.
- Theme mode is fixed at `ThemeMode.system`; there is no persisted theme preference or theme controller yet.
- Settings is still a placeholder screen, so it should not become the first Riverpod/theme-preference migration unless that feature is explicitly scoped.
- Current mutable UI state remains local to screens such as Login, Main shell tab index, BMI, Fox, and Summertime Saga.
- Existing tests already cover startup/session routing, login/logout session behavior, route parity, shell tab switching, and local session repository persistence.
- Current Riverpod docs for `flutter_riverpod` 3.3.x confirm the root app needs `ProviderScope`, providers can expose dependencies/state, and tests can override providers through `ProviderScope(overrides: ...)`.

First implementation slice:

- Completed: added `flutter_riverpod`.
- Completed: wrapped the runtime app with root `ProviderScope`.
- Completed: added the smallest provider seam for `LocalSessionRepository`.
- Completed: updated Login, Dashboard, and startup/session tests to consume or override that repository seam where needed.
- Preserved `/main`, direct route parity, local session behavior, and the local five-tab shell.
- BMI, Fox, Summertime Saga, theme preferences, Settings, Dio, real auth, `ShellRoute`, and feature roots remain unmigrated by design.

Next-consumer audit findings:

- Profile is the smallest useful second Riverpod consumer because it already displays a hard-coded local profile label while `LocalSessionRepository.getDisplayName()` exposes the persisted display name.
- The second slice can reuse the existing `localSessionRepositoryProvider`; no new dependency, persistence layer, route, or feature root is needed.
- Current Riverpod docs for `flutter_riverpod` 3.3.x support this shape with `FutureProvider` for asynchronous read-only state, `ConsumerWidget`/`ref.watch` for UI consumption, `AsyncValue` loading/error/data handling, and `ProviderScope` overrides in widget tests.
- Settings/theme preferences are more useful later, but they touch root `ThemeMode`, persistence semantics, and app-level rebuild behavior.
- Main shell tab index, BMI form inputs, and Login form state remain local UI state for now; moving them to Riverpod would add ownership complexity without shared-state value.
- Fox and Summertime Saga async state should wait for Phase 7 networking/Dio work because they involve API/retry/error behavior, not just local Riverpod foundation.

Second implementation slice:

- Completed: added a read-only current display-name provider under the auth application layer.
- Completed: converted Profile to consume the provider and show the saved local display name instead of the hard-coded `InfinityWorld` fallback when available.
- Completed: kept Profile's existing layout, SafeArea/scroll behavior, route path, and design-system card structure.
- Completed: updated focused Profile widget coverage with in-memory local session data.
- Profile editing, avatar selection, theme preferences, Settings redesign, root theme mode changes, Dio, network state migration, and shell tab-state migration remain out of scope.

Next-consumer audit after Profile findings:

- Settings is the smallest useful third Riverpod consumer because it is still a placeholder normal app screen, belongs to local profile/app configuration, and can show the existing persisted display name read-only.
- The next slice can reuse `currentDisplayNameProvider`; it does not need a new repository, persistence key, route, feature root, theme controller, or network layer.
- The Settings slice should add a focused widget test with in-memory local session data because Settings currently only has route smoke coverage.
- Keep Settings theme preferences, root `ThemeMode`, profile editing, avatar selection, Main shell tab state, BMI/Login form state, Dashboard/Home greeting, Fox/Summertime Saga async state, Dio, real auth, `ShellRoute`, and visual redesign out of the third Riverpod slice.
- Fox and Summertime Saga remain better Phase 7 candidates because their Riverpod migration should be tied to networking/error/retry ownership, not the Phase 6 local-state foundation.

Third implementation slice:

- Completed: converted Settings to consume `currentDisplayNameProvider`.
- Completed: showed the saved local display name in a small read-only Settings profile summary.
- Completed: kept the existing Settings route, normal-screen SafeArea/system UI expectations, and shell behavior.
- Completed: added focused Settings widget coverage with in-memory local session data.
- Theme preferences, root `ThemeMode`, profile editing, avatar selection, Settings redesign, shell tab state, network migration, Dio, `ShellRoute`, and real auth remain out of scope.

Next-consumer audit after Settings findings:

- Dashboard is the smallest useful fourth Riverpod consumer because it already acts as the current Home tab body, already uses Riverpod for logout, and can show the existing persisted display name as a read-only greeting.
- The next slice can reuse `currentDisplayNameProvider`; it does not need a new repository, persistence key, route, feature root, theme controller, or network layer.
- The Dashboard slice should update focused Dashboard widget coverage with in-memory local session data and preserve the existing navigation list, logout behavior, `/main`, and direct route parity.
- Theme preferences remain useful later, but they touch root `ThemeMode`, persistence semantics, and app-level rebuild behavior, so they should wait for a dedicated theme-mode provider slice.
- Main shell tab index, BMI/Login form state, and Test form state remain local UI state for now; moving them to Riverpod would add ownership complexity without shared-state value.
- Fox and Summertime Saga async state should continue to wait for Phase 7 networking/Dio work because they involve API/retry/error ownership, not just local Riverpod foundation.

Fourth implementation slice:

- Completed: converted Dashboard/Home to consume `currentDisplayNameProvider` for a read-only greeting.
- Completed: showed the saved local display name without changing the existing module navigation list, logout behavior, route paths, or shell behavior.
- Completed: preserved the existing ListView/SafeArea structure for normal-screen layout safety.
- Completed: updated focused Dashboard widget coverage with in-memory local session data.
- Theme preferences, root `ThemeMode`, profile editing, shell tab state, network migration, Dio, `ShellRoute`, and visual redesign remain out of scope.

Next-consumer audit after Dashboard findings:

- Root theme mode is the next useful Riverpod consumer because `MainApp` still hardcodes `ThemeMode.system` while light/dark themes and Riverpod root wiring already exist.
- The fifth slice should introduce a small app-level theme-mode provider seam consumed by `MainApp`, preserving the runtime default of `ThemeMode.system`.
- Keep Settings theme controls, persisted theme preference semantics, theme style switching, Neon/Vice themes, visual redesign, shell tab state, form-state migration, Dio, network state, real auth, and `ShellRoute` out of scope for this foundation slice.
- Main shell tab index, BMI/Login/Test form state, and simple screen-local state should stay local for now because they do not need shared app-level ownership.
- Fox and Summertime Saga async state should wait for Phase 7 networking/Dio work because their Riverpod migration should own API/error/retry behavior together.

Fifth implementation slice:

- Completed: added `appThemeModeProvider` under `lib/app/theme/` with the current default of `ThemeMode.system`.
- Completed: converted `MainApp` to consume the provider while keeping `MaterialApp.router`, `/main`, startup/session behavior, direct route parity, and the five-tab shell unchanged.
- Completed: added focused coverage for the provider default and `MainApp` provider override behavior.
- Settings theme controls, persisted theme preference semantics, theme style switching, Neon/Vice themes, visual redesign, shell tab state, form-state migration, Dio, network state, real auth, and `ShellRoute` remain out of scope.

Next-consumer audit after theme mode provider findings:

- Settings Appearance is the smallest useful sixth Riverpod consumer because Settings is the app configuration surface, is already a `ConsumerWidget`, and can read the existing `appThemeModeProvider`.
- The sixth slice should add a read-only Appearance summary that shows the current theme mode label while preserving the current default of `ThemeMode.system`.
- The slice should reuse the existing provider and focused Settings widget coverage; it should not add persistence, controls, theme style switching, Settings redesign, or root app behavior changes.
- Theme mode persistence and interactive Settings controls are useful later, but they should wait for a dedicated task because they touch local storage, app-level rebuild behavior, and user-facing settings semantics.
- Main shell tab state, BMI/Login/Test form state, and simple screen-local state should stay local for now; Fox and Summertime Saga async state should wait for Phase 7 networking/Dio work.

Sixth implementation slice:

- Completed: added a read-only Appearance summary to Settings that consumes `appThemeModeProvider`.
- Completed: displays the current theme mode label while preserving the runtime default of `ThemeMode.system`.
- Completed: updated focused Settings widget coverage for the default System label; persisted mode coverage is added by the seventh slice.
- Settings theme controls, persisted theme preference semantics, theme style switching, Settings redesign, shell tab state, form-state migration, Dio, network state, real auth, and `ShellRoute` remain out of scope.

Next-consumer audit after Settings Appearance findings:

- At the T60 audit, `MainApp` and Settings both consumed `appThemeModeProvider`, but the provider still returned the hardcoded default `ThemeMode.system`.
- Theme mode persistence foundation is the smallest useful seventh Riverpod slice because theme preference is documented local-first Settings/profile data and `shared_preferences` is already active.
- The seventh slice should introduce the smallest app-theme preference boundary backed by local storage, preserve `ThemeMode.system` when no valid stored value exists, and keep existing root/Settings read-only consumption working.
- Interactive Settings theme controls should wait until the persisted provider/controller foundation exists.
- Shell tab state, BMI/Login/Test form state, and simple widget-local state should stay local; Fox and Summertime Saga async state should continue to wait for Phase 7 networking/Dio ownership.
- Theme style switching, Neon/Vice themes, visual redesign, Dio, network state, real auth, `ShellRoute`, and new feature roots remain out of scope.

Seventh implementation slice:

- Completed: added a small app theme-mode repository/controller backed by `shared_preferences`.
- Completed: `appThemeModeProvider` now loads persisted `ThemeMode.system`, `ThemeMode.light`, or `ThemeMode.dark`, and falls back to System for missing or invalid stored values.
- Completed: `MainApp` and Settings keep using the provider with a System fallback while persisted state resolves.
- Completed: focused tests cover default, persisted, invalid, update, root-app, and Settings summary behavior.
- Interactive Settings theme controls, theme style switching, Neon/Vice themes, visual redesign, shell tab state, form-state migration, Dio, network state, real auth, `ShellRoute`, and new feature roots remain out of scope.

Eighth implementation slice:

- Completed: added compact Settings Appearance controls for choosing System, Light, or Dark through `appThemeModeProvider`.
- Completed: selections persist through the existing shared_preferences-backed theme-mode controller and update Settings consumption.
- Completed: focused Settings widget coverage verifies selected state and persistence behavior.
- Theme style switching, Neon/Vice themes, visual redesign, shell tab state, form-state migration, Dio, network state, real auth, `ShellRoute`, and new feature roots remain out of scope.

Next-consumer audit after Settings theme controls findings:

- Main shell tab index is still temporary shell UI state and should stay local until tab-specific routes or branch stacks exist.
- Login, BMI, and Test form state should stay local because controllers, validation text, and calculated output are screen-owned.
- Fox and Summertime Saga async state should wait for Phase 7 networking/Dio ownership instead of becoming a Phase 6 Riverpod-only migration.
- This led to the Phase 6 checkpoint audit.

Phase 6 checkpoint:

- Completed: re-audited root `ProviderScope`, local session repository provider, display-name provider consumers, persisted theme-mode provider/controller, Settings controls, and focused coverage.
- Confirmed: Phase 6 is complete enough for current local session/profile/theme preferences.
- Deferred: shell tab index and form state stay local; Fox and Summertime Saga async ownership moves to Phase 7 networking work.
- Decision: close Phase 6 and start Phase 7 with a networking foundation kickoff audit before adding Dio.

## Phase 7: Networking Foundation

Status: complete as of 2026-06-30.

Goal:

- Introduce Dio and consistent API error/loading behavior when a networking feature is actively migrated.

Kickoff audit findings:

- Before T66, direct `http` usage was limited to `lib/features/fox/data/fox_api_service.dart` and `lib/features/summertime_saga/data/smts_service.dart`.
- Dio was not installed before T66.
- Fox and Summertime Saga both already have fake-network service seams and deterministic route smoke coverage through router builder overrides.
- Current Dio guidance supports `Dio(BaseOptions(...))`, `Duration` timeout options, and interceptors, which is enough for a small shared client/provider foundation without inventing a larger network framework. Source checked: `https://github.com/cfug/dio/blob/main/dio/README.md`.
- Fox is the smallest first pilot because its service contract is narrower than Summertime Saga and its existing tests already cover success, non-200 status, malformed JSON, missing required data, and timeout behavior.
- Summertime Saga remains the larger follow-up because it has more API model and screen-state surface area.

First implementation slice:

- Completed: added `dio` for a used pilot, not as unused scaffolding.
- Completed: added the smallest shared Dio client/provider boundary needed by the pilot.
- Completed: migrated `FoxApiService` to the Dio-backed boundary while preserving behavior and fake-test coverage.
- Completed: kept Summertime Saga on `http` until the pilot passed.

Next implementation slice:

- Completed: migrated `SmtsService` to the Dio-backed service path while preserving its configured URL, timeout/status/schema error handling, deterministic screen states, and fake-network tests.
- Completed: removed the unused `http` dependency after no Dart imports remained.

Checkpoint:

- Completed: re-audited the Dio provider/factory, Fox service path, Summertime Saga service path, route seams, fake-network tests, dependency state, and Android internet permission.
- Confirmed: both current API-backed features use Dio-backed service paths, no direct `http` dependency or Dart imports remain, and route/screen tests avoid live networking through existing seams.
- Decision: close Phase 7 and defer retry/cache/offline/global error policy until a concrete feature needs it.

Rules:

- Do not add Dio before a scoped networking task.
- Do not call APIs from widget `build()`.
- Keep network logic behind service/repository boundaries.

## Phase 8: Feature Expansion

Status: current / kickoff audit next.

Kickoff:

- Start with a feature expansion audit before implementing a new feature slice.
- Inventory the existing five-tab shell placeholders, direct feature routes, product direction, and test coverage.
- Select one small vertical slice that improves a real tab or feature surface without broad routing, state, network, or visual redesign work.

Kickoff audit findings:

- Current `/main` still uses a local `BottomNavigationBar`; `ShellRoute` remains unnecessary until real tab-owned route stacks exist.
- Home is the existing `DashboardScreen`, Settings is the existing `SettingsScreen`, and Explore / Tools / Library are icon-only placeholder tabs.
- No `features/home`, `features/explore`, `features/tools`, or `features/library` root exists yet.
- Existing feature and dev routes are still direct: BMI, Fox, Summertime Saga, Profile, Settings, Dashboard, Chat, and Test.
- Tools is the smallest useful first tab-root slice because BMI is already a clean local utility module and can be linked without new packages, persistence, networking, or route architecture.
- Explore can follow with existing Fox / Summertime Saga cards, but it is slightly broader because it surfaces API-backed modules.

First implementation slice:

- Completed: added a small Tools tab body that lists the existing BMI module and navigates to the existing BMI route.
- Completed: preserved the current direct `/bmi` route, Dashboard access, `/main` startup behavior, and local bottom navigation.
- Completed: kept Wheel, Device Hub, AI Lab, `ShellRoute`, new packages, `IwModuleCard`, and broad Home redesign out of scope.

Next implementation slice:

- Completed: added a small Explore tab body that lists existing Fox and Summertime Saga modules and navigates to their existing direct routes.
- Completed: kept API loading out of the Explore tab body; network calls remain inside the existing feature screens after navigation.

Next audit:

- Audit Library before adding Reader, bookmarks, saved articles, local database, imports/downloads, or persistence.

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
