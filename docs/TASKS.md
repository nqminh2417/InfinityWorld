# Infinity World Active Tasks

Last updated: 2026-06-29

## Current Status

Current branch workflow:

- Active branch: `home/devbyMinh-current`
- Codex may auto commit and push scoped tasks after gates pass.
- Git workflow source: `docs/qa/IW_GIT_WORKFLOW.md`

Current architecture status:

- Transitional architecture.
- `lib/main.dart` still owns app composition and now uses `MaterialApp.router`.
- `lib/app/router/app_router.dart` owns the active go_router route table.
- `lib/routes/app_routes.dart` remains the shared path contract.
- Inactive legacy `lib/routes/app_pages.dart` has been removed.
- The current main shell lives under `lib/app/shell/main_screen.dart` and exposes a local Home / Explore / Tools / Library / Settings skeleton.
- `lib/app/bootstrap/startup_route_resolver.dart` now chooses Login or Main from the local session flag before `runApp`.
- `lib/main.dart` now wraps the runtime app with Riverpod `ProviderScope`.
- `lib/app/theme/app_theme.dart` now provides the first Midnight Violet light/dark app theme.
- `lib/design_system/tokens/` and `lib/design_system/components/iw_card.dart` now provide the first design-system token/card slice.
- Auth/Login presentation now lives under `lib/features/auth/presentation/`.
- Auth session dependency injection now starts at `lib/features/auth/application/session_providers.dart`.
- Local session/profile persistence now lives under `lib/features/auth/data/local_session_repository.dart` and uses `shared_preferences`.
- Profile now consumes the persisted local display name through Riverpod.
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
- Riverpod is active for the first local session repository provider seam.
- Dio is not active yet.

Current tests:

- App startup smoke tests cover logged-out Login startup and logged-in Main startup.
- Local session repository and startup route resolver unit coverage exists.
- Login/logout session navigation widget coverage exists and overrides the local session repository provider.
- Local display-name validation and persistence coverage exists.
- App theme unit coverage exists.
- `IwCard` widget coverage exists.
- BMI domain unit tests exist.
- BMI presentation widget tests exist.
- Chat route smoke test exists.
- Dashboard presentation widget test exists for small-screen scroll safety.
- Deterministic route smoke tests exist for Login, Main, Dashboard, Chat, Profile, Settings, BMI, Test, Fox, and Summertime Saga.
- Test screen widget coverage exists for small-screen keyboard/scroll safety.
- Fox API service and model parsing tests exist.
- Fox screen loading/error/retry widget tests exist, avoid real network, and include small-screen scroll-safety coverage.
- Summertime Saga service/model tests exist with fake-network coverage for success, non-2xx, malformed JSON, missing schema, and timeout handling.
- Summertime Saga screen widget tests exist for deterministic loading, success, error/retry, incomplete data, dispose safety, and small-screen scroll safety.
- Profile presentation widget test exists and covers persisted local display-name rendering.
- Profile route smoke test exists.
- Settings route smoke test exists.
- Fox and Summertime Saga route smoke tests use router-level builder overrides with their existing fake-network screen seams.
- Main shell widget coverage exists for the five target tab labels and local tab switching.

Current phase:

- Phase 6: Riverpod Foundation.
- Phase 5 router migration is closed.
- go_router remains the active root router.
- Active routing is go_router-only; GetX routing is removed.
- `/main` remains the local session shell entry point.
- `ShellRoute`/`StatefulShellRoute` should wait for real tab root screens and tab-owned child route stacks.
- Riverpod is installed and active for root `ProviderScope`, the local session repository provider seam, and Profile display-name consumption.
- T52 selected Settings read-only profile summary as the third Riverpod implementation slice.

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

## Recommended Next Work

Current phase:

- Phase 6 — Riverpod Foundation

Task sizing note:

- Continue applying safety skills, but bundle work by scope when possible.
- Do not use the Fox multi-step sequence as the default template for every screen.
- Simple screens should usually be handled in one task.
- API/live-network screens may justify extra hardening tasks.

### Primary

T53 - Riverpod Settings profile summary slice

Reason:

- T52 selected Settings as the smallest useful third Riverpod consumer.
- Settings currently has only route smoke coverage and placeholder content, while the product direction says Settings owns local profile/app configuration.
- A read-only profile summary can reuse `currentDisplayNameProvider` without adding persistence, routes, feature roots, theme controls, or networking.

Scope:

- Convert Settings to consume `currentDisplayNameProvider` and show the persisted local display name when available.
- Preserve the existing Settings route, shell behavior, and normal-screen SafeArea/system UI expectations.
- Add focused Settings widget coverage with in-memory local session data.
- Preserve `/main`, direct route parity, local session behavior, and the five-tab shell.
- Do not add profile editing, avatar selection, theme preferences, root `ThemeMode`, Settings redesign, Dio, real auth, `ShellRoute`, new feature roots, network state migration, shell tab-state migration, Dashboard/Home greeting, or visual redesign.

Verification:

- Dart logic/test gates from `docs/qa/IW_GIT_WORKFLOW.md`.

### Alternatives

T30 — Dependency/toolchain audit

Choose this if package/build risk should be reviewed after adding Riverpod.

T54 - Riverpod next-consumer audit after Settings

Choose this only after T53 passes and another Riverpod consumer should be selected.

### Do not start yet

- Riverpod feature rewrites beyond the scoped T53 Settings profile summary slice.
- `ShellRoute`/`StatefulShellRoute` implementation before real tab root screens and tab-owned child route stacks exist.
- Dio/network layer.
- Broad `lib/main.dart` app composition refactor beyond root router parity.
- Removing `AppRoutes` or active go_router routes.
- Built-in Kotlin migration.
- Real backend authentication.
- More design-system components unless explicitly assigned.
- Full UI redesign unless explicitly approved.
- Additional Fox follow-up tasks unless a concrete risk, failed verification, blocker, or user-approved remaining scope exists.
- Test screen deletion or route removal unless explicitly approved.
- Dio/Riverpod/go_router migration inside Summertime Saga follow-up tasks.

### Phase guard

Current phase:

- Phase 6 — Riverpod Foundation.

Decision:

- T52 selected Settings read-only profile summary as the third Riverpod slice. Start T53 before any broader feature-state migration.

Do not enter yet:

- Phase 7 — Networking Foundation.

Reason:

- Riverpod foundation should start with root wiring and one dependency seam because the app still uses local widget state and simple repositories.
- Phase 4 startup/session behavior must survive the first Riverpod slice.
- Riverpod work should not be mixed with Dio, real backend authentication, shell-route work, or visual redesign.

Exit criteria:

- Done: Riverpod foundation kickoff audit scoped the first implementation slice.
- Done: Added root `ProviderScope` and a `LocalSessionRepository` provider seam.
- Done: Verified startup/session/login/logout parity after the first Riverpod slice.
- Done: Chose Profile display-name consumption as the next Riverpod consumer.
- Done: Implemented and verified the Profile display-name provider slice.
- Done: Chose Settings read-only profile summary as the next Riverpod consumer.
- Remaining: Implement and verify the Settings profile summary slice.

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
