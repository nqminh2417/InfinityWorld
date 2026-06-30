# Infinity World Active Tasks

Last updated: 2026-06-30

## Current Status

Current branch workflow:

- Active branch: `home/devbyMinh-current`
- Codex may auto commit and push scoped tasks after gates pass.
- Git workflow source: `docs/qa/IW_GIT_WORKFLOW.md`

Current architecture status:

- Transitional architecture.
- `lib/main.dart` still owns app composition, now uses `MaterialApp.router`, and consumes the Riverpod app theme-mode provider.
- `lib/app/router/app_router.dart` owns the active go_router route table.
- `lib/routes/app_routes.dart` remains the shared path contract.
- Inactive legacy `lib/routes/app_pages.dart` has been removed.
- The current main shell lives under `lib/app/shell/main_screen.dart` and exposes a local Home / Explore / Tools / Library / Settings skeleton.
- `lib/app/bootstrap/startup_route_resolver.dart` now chooses Login or Main from the local session flag before `runApp`.
- `lib/main.dart` now wraps the runtime app with Riverpod `ProviderScope`.
- `lib/app/theme/app_theme.dart` now provides the first Midnight Violet light/dark app theme.
- `lib/app/theme/app_theme_mode_provider.dart` now exposes the persisted app-level theme mode provider/controller with a fallback default of `ThemeMode.system`.
- `lib/design_system/tokens/` and `lib/design_system/components/iw_card.dart` now provide the first design-system token/card slice.
- Auth/Login presentation now lives under `lib/features/auth/presentation/`.
- Auth session dependency injection now starts at `lib/features/auth/application/session_providers.dart`.
- Local session/profile persistence now lives under `lib/features/auth/data/local_session_repository.dart` and uses `shared_preferences`.
- Dashboard/Home now consumes the persisted local display name through Riverpod.
- Profile now consumes the persisted local display name through Riverpod.
- Settings now consumes the persisted local display name and app theme mode through Riverpod and exposes theme-mode controls.
- BMI was the initial migration pilot and now lives under `lib/features/bmi/`.
- Chat presentation now lives under `lib/features/chat/presentation/`.
- Dashboard presentation now lives under `lib/features/dashboard/presentation/`.
- Fox now lives under `lib/features/fox/`.
- Profile presentation now lives under `lib/features/profile/presentation/`.
- Settings presentation now lives under `lib/features/settings/presentation/`.
- Summertime Saga now lives under `lib/features/summertime_saga/`.
- Test presentation now lives under `lib/features/test/presentation/`.
- Fox hardening plan exists at `docs/features/FOX_HARDENING_PLAN.md`.
- Summertime Saga hardening plan exists at `docs/features/SUMMERTIME_SAGA_HARDENING_PLAN.md`.
- Phase 2 migration map exists at `docs/PHASE2_MIGRATION_MAP.md`.
- `shared_preferences` is active for the first local session flag and display name.
- go_router is active for root routing.
- Riverpod foundation is complete for current local session/profile/theme preferences.
- Remaining likely Riverpod candidates are either temporary screen-local state or Phase 7 networking ownership.
- `lib/core/network/dio_provider.dart` now provides the first shared Dio client/provider boundary.
- Fox now uses Dio through `FoxApiService` and `foxApiServiceProvider`.
- Summertime Saga now uses Dio through `SmtsService` and `smtsServiceProvider`.
- The direct `http` dependency has been removed.

Current tests:

- App startup smoke tests cover logged-out Login startup and logged-in Main startup.
- Local session repository and startup route resolver unit coverage exists.
- Login/logout session navigation widget coverage exists and overrides the local session repository provider.
- Local display-name validation and persistence coverage exists.
- App theme unit coverage exists.
- App theme-mode provider coverage exists for default, persisted, invalid, update, root-app persisted, and Settings summary behavior.
- `IwCard` widget coverage exists.
- BMI domain unit tests exist.
- BMI presentation widget tests exist.
- Chat route smoke test exists.
- Dashboard presentation widget test exists for small-screen scroll safety and persisted local display-name rendering.
- Deterministic route smoke tests exist for Login, Main, Dashboard, Chat, Profile, Settings, BMI, Test, Fox, and Summertime Saga.
- Test screen widget coverage exists for small-screen keyboard/scroll safety.
- Fox API service and model parsing tests exist with fake Dio responses.
- Fox screen loading/error/retry widget tests exist, avoid real network, and include small-screen scroll-safety coverage.
- Summertime Saga service/model tests exist with fake-network coverage for success, non-2xx, malformed JSON, missing schema, and timeout handling.
- Summertime Saga screen widget tests exist for deterministic loading, success, error/retry, incomplete data, dispose safety, and small-screen scroll safety.
- Profile presentation widget test exists and covers persisted local display-name rendering.
- Settings presentation widget test exists and covers persisted local display-name rendering, Appearance theme-mode summary, persisted theme-mode behavior, and theme-mode selection/persistence behavior.
- Profile route smoke test exists.
- Settings route smoke test exists.
- Fox and Summertime Saga route smoke tests use router-level builder overrides with their existing fake-network screen seams.
- Main shell widget coverage exists for the five target tab labels and local tab switching.

Current phase:

- Phase 7: Networking Foundation.
- Phase 6 Riverpod Foundation is closed.
- Phase 5 router migration is closed.
- go_router remains the active root router.
- Active routing is go_router-only; GetX routing is removed.
- `/main` remains the local session shell entry point.
- `ShellRoute`/`StatefulShellRoute` should wait for real tab root screens and tab-owned child route stacks.
- Riverpod is installed and active for root `ProviderScope`, the local session repository provider seam, Profile display-name consumption, Settings profile-summary/theme-mode consumption, Dashboard/Home greeting consumption, and persisted root theme-mode consumption.

Android toolchain status:

- Gradle wrapper, Android Gradle Plugin, Kotlin Gradle Plugin, and Java/Kotlin target were upgraded for Flutter 3.44.2 compatibility on `home/devbyMinh-current` with explicit approval.
- Built-in Kotlin migration remains deferred.

Completed stabilization tasks:

- Login build-time `setState()` risk was fixed; the form is now SafeArea-aware, scroll-safe, and covered by a small keyboard-inset widget test.
- BMI UI layout-safety pass was completed; the BMI form is now scroll-safe, keyboard-dismiss-aware, and covered by a small keyboard-inset widget test.
- Settings route alignment was fixed; `AppRoutes.settings` is now registered in the legacy GetX route table and covered by a route smoke test.
- BMI feature-quality pass was completed; BMI inputs now allow decimal numeric keyboards and the weight field's keyboard Done action calculates the result.
- Settings feature placement was completed; the existing placeholder screen moved to `lib/features/settings/presentation/` and the legacy GetX route import was updated.
- Profile feature placement was completed; the existing screen moved to `lib/features/profile/presentation/`, legacy imports were updated, and the route has a smoke test.
- Profile UI layout-safety pass was completed; the screen is now SafeArea-aware, scroll-safe on small screens, and covered by a focused widget test.
- Phase 2 migration map was created to rank remaining `lib/screens/` ownership and avoid random screen moves.
- Chat feature placement was completed; the existing placeholder screen moved to `lib/features/chat/presentation/`, legacy imports were updated, and the route has a smoke test.
- Deterministic legacy route smoke tests were added for Login, Main, Dashboard, BMI, and Test; live-network routes stayed deferred at that point.
- Dashboard feature placement was completed; the existing screen moved to `lib/features/dashboard/presentation/`, while GetX routes and main shell behavior stayed unchanged.
- Login feature placement was completed; the existing screen moved to `lib/features/auth/presentation/`, while startup, route, and UI behavior stayed unchanged.
- Fox feature hardening plan was completed; API/service risks, deterministic testing needs, and the safe pre-move task sequence are documented.
- Fox API service and model parsing were hardened with timeout handling, fake-network test seams, response validation, and focused tests.
- Fox screen coverage was added for deterministic loading, error, and retry states without live network calls.
- Fox feature placement was completed; files moved to `lib/features/fox/`, while GetX routing, `http`, behavior, and UI stayed unchanged.
- Fox UI layout-safety pass was completed; the screen is SafeArea-aware, scroll-safe on small screens, and keeps the normal app system UI.
- Test screen audit was completed; the route is still reachable from Dashboard, route coverage exists, and lifecycle/keyboard-safety issues should be fixed before any move or removal decision.
- Test screen lifecycle and keyboard-safety pass was completed; owned controller state is disposed and the form body is SafeArea-aware and scroll-safe.
- Test feature placement was completed; the screen moved to `lib/features/test/presentation/`, route/test imports were updated, and GetX route behavior stayed unchanged.
- Dashboard UI layout-safety pass was completed; navigation content is SafeArea-aware and scroll-safe without changing GetX route behavior.
- Summertime Saga hardening plan was completed; network, model, screen-state, release-permission, and feature-placement risks are documented before implementation.
- Summertime Saga network foundation was hardened; the service now uses configured progress URL, timeout/status/schema validation, deterministic exceptions, fake-network tests, and release `INTERNET` permission.
- Summertime Saga screen states and layout were stabilized; the screen now has a test seam, deterministic loading/error/retry/success states, mounted/stale-request guards, SafeArea-aware scrollable content, and focused widget tests.
- Summertime Saga feature placement was completed; the files moved to `lib/features/summertime_saga/`, while GetX route names, `http`, behavior, and UI stayed unchanged.
- Phase 2 checkpoint audit was completed; selected feature placement work is complete, and remaining legacy ownership is shell/routing rather than simple feature-screen placement.
- Phase 3 kickoff audit was completed; it found no shared `lib/app/theme/` or `lib/design_system/` layer at the time and selected Midnight Violet tokens plus a single reusable `IwCard` as the first implementation slice.
- Phase 3 token/card implementation slice was completed; the app now has Midnight Violet light/dark theme data, core color/spacing/radius tokens, `IwCard`, focused tests, and Profile as the first pilot screen.
- Phase 4 bootstrap/session kickoff audit was completed; current startup and logout/login paths were inspected, and the first implementation slice was scoped to local session bootstrap on top of the existing GetX app.
- Local session bootstrap was implemented; `shared_preferences` stores the session flag, startup resolves Login/Main before `runApp`, and existing login/logout actions save and clear the flag.
- Local profile entry was implemented; Login now captures a display name, validates blank input, persists the profile locally, and logout clears the display name with the session.
- Phase 4 checkpoint audit was completed; startup/session/profile behavior is covered, no Phase 4 blocker remains, and Phase 5 should begin with a router migration audit rather than implementation.
- Router migration kickoff audit was completed; current routes and navigation calls are inventoried, the legacy three-tab shell is deferred, and the first go_router slice is scoped to root route parity.
- go_router root parity slice was completed; `MaterialApp.router` now uses the active route table, Login/Dashboard navigation use go_router, and `MainScreen` remains unchanged.
- Main shell ownership audit was completed; `MainScreen` is only a legacy wrapper for Dashboard / Chat / Profile, child screens still own their own `Scaffold`/SafeArea where needed, and the next shell slice should move ownership before any five-tab or `ShellRoute` work.
- Main shell ownership move was completed; `MainScreen` now lives under `lib/app/shell/`, while `/main` and the existing Dashboard / Chat / Profile tabs stay unchanged.
- Legacy GetX route cleanup audit was completed; Dart GetX usage is limited to inactive `lib/routes/app_pages.dart`, while active routing and tests use go_router through `MainApp`.
- Inactive GetX route cleanup was completed; `lib/routes/app_pages.dart` and the `get` dependency were removed, while `AppRoutes` remains the shared path contract.
- Live-network route smoke strategy was completed; Fox and Summertime Saga should get deterministic route tests through router-level builder overrides, not live network calls or a networking migration.
- Deterministic live-network route smoke implementation was completed; `/fox` and `/smts_home` now render in route tests through fake services/loaders.
- Five-tab shell implementation audit was completed; the first implementation should update `MainScreen` to the five target tabs without `ShellRoute`, new dependencies, Riverpod, Dio, or live-network tab roots.
- Local five-tab shell skeleton was completed; `/main` now shows Home / Explore / Tools / Library / Settings, Home preserves Dashboard access, and network-backed Fox/Summertime routes stay direct instead of tab roots.
- ShellRoute/deep-link audit was completed; current `GoRoute` coverage is enough, tab-specific shell routes are deferred, and future nested tab navigation should prefer `StatefulShellRoute` if separate tab stacks become necessary.
- Phase 5 checkpoint audit was completed; router migration is closed with root go_router parity, direct route coverage, local five-tab shell behavior, and `ShellRoute` deferred until a real nested tab-routing need exists.
- Riverpod foundation kickoff audit was completed; at that point Riverpod was not installed, and the first implementation slice was scoped to root `ProviderScope`, a `LocalSessionRepository` provider seam, and focused startup/login/logout test overrides.
- Riverpod foundation implementation slice was completed; `flutter_riverpod` is installed, the runtime app has root `ProviderScope`, Login/Dashboard consume `localSessionRepositoryProvider`, and session-flow tests override the provider seam.
- Riverpod next-consumer audit was completed; Profile was selected as the second Riverpod consumer because it can show the persisted local display name through a read-only provider without broad state migration.
- Riverpod Profile display-name provider slice was completed; Profile now consumes `currentDisplayNameProvider` and focused widget coverage verifies the persisted display name.
- Riverpod next-consumer audit after Profile was completed; Settings read-only profile summary was selected as the third Riverpod consumer because it can reuse `currentDisplayNameProvider` without theme, shell, form, or network migration.
- Riverpod Settings profile summary slice was completed; Settings now consumes `currentDisplayNameProvider` and focused widget coverage verifies the persisted display name.
- Riverpod next-consumer audit after Settings was completed; Dashboard/Home read-only greeting was selected as the fourth Riverpod consumer because it can reuse `currentDisplayNameProvider` without theme, shell, form, or network migration.
- Riverpod Dashboard local greeting slice was completed; Dashboard now consumes `currentDisplayNameProvider` and focused widget coverage verifies the persisted display name.
- Riverpod next-consumer audit after Dashboard was completed; root theme mode provider foundation was selected as the fifth Riverpod consumer because `MainApp` still hardcodes `ThemeMode.system` while light/dark app themes and Riverpod root wiring already exist.
- Riverpod theme mode provider foundation slice was completed; `MainApp` now consumes `appThemeModeProvider`, default behavior stays `ThemeMode.system`, and focused coverage verifies provider default and override behavior.
- Riverpod next-consumer audit after theme mode provider was completed; Settings Appearance read-only theme-mode summary was selected as the sixth Riverpod consumer because it can reuse `appThemeModeProvider` without persistence, controls, or root app changes.
- Riverpod Settings appearance theme-mode summary slice was completed; Settings now consumes `appThemeModeProvider` and focused widget coverage verifies the default System label, with persisted-value behavior covered by the T61 slice.
- Riverpod next-consumer audit after Settings Appearance was completed; theme-mode persistence foundation was selected as the seventh Riverpod slice because root app and Settings already consume `appThemeModeProvider`, but it still returns a hardcoded `ThemeMode.system` value.
- Riverpod theme-mode persistence foundation slice was completed; `appThemeModeProvider` is now backed by `shared_preferences`, preserves System for missing or invalid stored values, and exposes a controller update method for a later Settings controls slice.
- Riverpod Settings theme-mode controls slice was completed; Settings Appearance now offers System / Light / Dark controls through `appThemeModeProvider`, and focused widget coverage verifies selection persistence.
- Riverpod next-consumer audit after Settings theme controls was completed; no remaining low-risk local shared-state consumer is worth migrating before a Phase 6 checkpoint.
- Riverpod foundation checkpoint audit was completed; Phase 6 is closed, and Phase 7 should start with a networking foundation kickoff audit before any Dio implementation.
- Phase 7 networking foundation kickoff audit was completed; direct `http` usage is limited to Fox and Summertime Saga feature services, both already have fake-network seams and route builder overrides, and the first implementation slice is scoped to Dio foundation plus a Fox service pilot.
- Dio foundation and Fox service pilot slice was completed; `dio` is installed, the shared Dio provider boundary exists, Fox uses the Dio-backed service path, and focused/full tests pass.
- Summertime Saga Dio migration slice was completed; `SmtsService` now uses the Dio-backed service path, fake-network service tests use a fake Dio adapter, route/screen seams stay deterministic, and the unused `http` dependency was removed.

## Recommended Next Work

Current phase:

- Phase 7 — Networking Foundation

Task sizing note:

- Continue applying safety skills, but bundle work by scope when possible.
- Do not use the Fox multi-step sequence as the default template for every screen.
- Simple screens should usually be handled in one task.
- API/live-network screens may justify extra hardening tasks.

### Primary

T68 - Phase 7 networking foundation checkpoint audit

Reason:

- T66 and T67 migrated both current API-backed features to the Dio-backed service path.
- No Dart code imports `package:http` anymore, and the dependency has been removed.
- The next useful step is a checkpoint audit before adding retry/cache/offline policy or expanding Phase 7.

Scope:

- Re-audit `dioProvider`, Fox, Summertime Saga, route seams, tests, dependency state, and planning docs.
- Decide whether Phase 7 should close or whether one small networking cleanup remains.
- Update planning docs only unless a concrete blocker is found.
- Do not add retry/cache/offline policy, global error UI, real auth, route changes, `ShellRoute`, feature root expansion, Riverpod screen-state migration, or UI redesign in this audit.

Verification:

- Docs/audit gate from `docs/qa/IW_GIT_WORKFLOW.md`.

### Alternatives

T30 — Dependency/toolchain audit

Choose this if package/build risk should be reviewed after adding Dio and removing `http`.

### Do not start yet

- Global retry/cache/offline policy before the Phase 7 checkpoint audit confirms a concrete need.
- Riverpod implementation slices unless a future feature has concrete shared-state ownership.
- Theme style switching, Neon/Vice themes, or visual redesign before a dedicated theme-style task.
- `ShellRoute`/`StatefulShellRoute` implementation before real tab root screens and tab-owned child route stacks exist.
- Broad `lib/main.dart` app composition refactor beyond root router parity.
- Removing `AppRoutes` or active go_router routes.
- Built-in Kotlin migration.
- Real backend authentication.
- More design-system components unless explicitly assigned.
- Full UI redesign unless explicitly approved.
- Additional Fox follow-up tasks unless a concrete risk, failed verification, blocker, or user-approved remaining scope exists.
- Test screen deletion or route removal unless explicitly approved.
- Riverpod/go_router migration inside Summertime Saga networking follow-up tasks unless explicitly scoped.

### Phase guard

Current phase:

- Phase 7 — Networking Foundation.

Decision:

- T67 completed the Summertime Saga Dio migration and removed the unused `http` dependency. Start T68 as a checkpoint audit before adding any broader networking policy.

Do not enter yet:

- Phase 8 — Feature Expansion.

Reason:

- Networking foundation should checkpoint now that both current API-backed features use Dio-backed service paths.
- `/main`, startup/session, local profile behavior, Riverpod theme/profile state, and the five-tab shell must remain stable during networking work.
- Dio work should not be mixed with real backend authentication, shell-route work, visual redesign, or feature expansion.

Exit criteria:

- Done: Completed the Phase 7 networking foundation kickoff audit.
- Done: Confirmed at T65 that Dio was not installed yet and direct `http` usage was limited to Fox and Summertime Saga services.
- Done: Implemented and verified the T66 Dio/Fox pilot.
- Done: Implemented and verified the T67 Summertime Saga Dio migration and removed the unused `http` dependency.
- Remaining: Complete the T68 checkpoint audit before adding broader network policies or entering Phase 8.

## Verification Gates

Use `docs/qa/IW_GIT_WORKFLOW.md` as the source of truth.

Quick reference:

- Docs-only: `git diff --check`
- Dart logic/test: `dart format`, `flutter analyze`, `flutter test`, `git diff --check`
- Screen move/routing/startup: `dart format`, `flutter analyze`, `flutter test`, `flutter build apk --debug`, `git diff --check`
- Android toolchain/build-system: separate branch unless explicitly approved

## Asking for the Next Task

If the user asks "what is the next task?", use `Recommended Next Work` above. Recommend the single Primary task unless the user explicitly chooses an alternative.

If the user assigns a different task, follow the user task and update planning docs only when it changes priority, phase, backlog, or durable decisions.
