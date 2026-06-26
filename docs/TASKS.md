# Infinity World Active Tasks

Last updated: 2026-06-26

## Current Status

Current branch workflow:

- Active branch: `home/devbyMinh-current`
- Codex may auto commit and push scoped tasks after gates pass.
- Git workflow source: `docs/qa/IW_GIT_WORKFLOW.md`

Current architecture status:

- Transitional architecture.
- `lib/main.dart` still owns app composition.
- GetX routing is still active under `lib/routes/`.
- The legacy main shell still lives under `lib/screens/main/main_screen.dart`.
- `lib/app/theme/app_theme.dart` now provides the first Midnight Violet light/dark app theme.
- `lib/design_system/tokens/` and `lib/design_system/components/iw_card.dart` now provide the first design-system token/card slice.
- Auth/Login presentation now lives under `lib/features/auth/presentation/`.
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
- Riverpod, go_router, and Dio are not active yet.

Current tests:

- App startup smoke test exists.
- App theme unit coverage exists.
- `IwCard` widget coverage exists.
- BMI domain unit tests exist.
- BMI presentation widget tests exist.
- Chat route smoke test exists.
- Dashboard presentation widget test exists for small-screen scroll safety.
- Deterministic route smoke tests exist for Login, Main, Dashboard, BMI, and Test.
- Test screen widget coverage exists for small-screen keyboard/scroll safety.
- Fox API service and model parsing tests exist.
- Fox screen loading/error/retry widget tests exist, avoid real network, and include small-screen scroll-safety coverage.
- Summertime Saga service/model tests exist with fake-network coverage for success, non-2xx, malformed JSON, missing schema, and timeout handling.
- Summertime Saga screen widget tests exist for deterministic loading, success, error/retry, incomplete data, dispose safety, and small-screen scroll safety.
- Profile presentation widget test exists.
- Profile route smoke test exists.
- Settings route smoke test exists.
- Fox and Summertime Saga route rendering tests are deferred because their default route constructors still start live HTTP work in `initState()`.

Current phase:

- Phase 4: App Bootstrap and Local Session.

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
- Deterministic legacy route smoke tests were added for Login, Main, Dashboard, BMI, and Test; live-network routes remain deferred.
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

## Recommended Next Work

Current phase:

- Phase 4 — App Bootstrap and Local Session

Task sizing note:

- Continue applying safety skills, but bundle work by scope when possible.
- Do not use the Fox multi-step sequence as the default template for every screen.
- Simple screens should usually be handled in one task.
- API/live-network screens may justify extra hardening tasks.

### Primary

T32 — Phase 4 bootstrap/session kickoff audit

Reason:

- The Phase 3 token/card slice is complete enough to stop expanding the design system by default.
- Startup still opens Login directly without a local session/bootstrap check.
- Phase 4 should start with a small audit so session work is scoped without starting a router migration.

Scope:

- Inspect `lib/main.dart`, `lib/features/auth/presentation/login_screen.dart`, legacy GetX routes, and startup/session docs.
- Define the smallest local session/bootstrap implementation slice using the current GetX app.
- Update planning docs only; do not implement session persistence until assigned separately.

Verification:

- Docs/audit gates from `docs/qa/IW_GIT_WORKFLOW.md`.

### Alternatives

T28 — Main shell audit

Choose this if shell ownership should be clarified before starting design-system work.

T29 — Live-network route smoke strategy

Choose this if Fox and Summertime Saga route smoke coverage should be solved before design work.

T30 — Dependency/toolchain audit

Choose this if current package/build risk should be reviewed before the next phase.

### Do not start yet

- Riverpod activation.
- go_router migration.
- Dio/network layer.
- Broad `lib/main.dart` app composition refactor.
- GetX routing replacement.
- Built-in Kotlin migration.
- Real backend authentication.
- More design-system components unless explicitly assigned.
- Full UI redesign unless explicitly approved.
- Additional Fox follow-up tasks unless a concrete risk, failed verification, blocker, or user-approved remaining scope exists.
- Test screen deletion or route removal unless explicitly approved.
- Dio/Riverpod/go_router migration inside Summertime Saga follow-up tasks.

### Phase guard

Current phase:

- Phase 4 — App Bootstrap and Local Session.

Decision:

- Phase 3 token/card foundation is complete; begin Phase 4 with a bootstrap/session audit before implementation.

Do not enter yet:

- Phase 5 — Router Migration.

Reason:

- The app has enough design-system foundation to start startup/session work.
- GetX routing remains active and should be preserved during the first bootstrap/session slice.
- Phase 4 can begin without introducing Riverpod, go_router, Dio, or real backend authentication.

Exit criteria:

- Bootstrap/session scope is audited and planned.
- Local fake session/profile persistence is implemented.
- App startup redirects to Home when a previous local session exists and Login when it does not.
- Logout clears the local session and returns to Login.

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
