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
- Most screens still live under `lib/screens/`.
- Auth/Login presentation now lives under `lib/features/auth/presentation/`.
- BMI is the active migration pilot under `lib/features/bmi/`.
- Chat presentation now lives under `lib/features/chat/presentation/`.
- Dashboard presentation now lives under `lib/features/dashboard/presentation/`.
- Fox now lives under `lib/features/fox/`.
- Profile presentation now lives under `lib/features/profile/presentation/`.
- Settings presentation now lives under `lib/features/settings/presentation/`.
- Fox hardening plan exists at `docs/features/FOX_HARDENING_PLAN.md`.
- Phase 2 migration map exists at `docs/PHASE2_MIGRATION_MAP.md`.
- Riverpod, go_router, and Dio are not active yet.

Current tests:

- App startup smoke test exists.
- BMI domain unit tests exist.
- BMI presentation widget tests exist.
- Chat route smoke test exists.
- Deterministic route smoke tests exist for Login, Main, Dashboard, BMI, and Test.
- Fox API service and model parsing tests exist.
- Fox screen loading/error/retry widget tests exist, avoid real network, and include small-screen scroll-safety coverage.
- Profile presentation widget test exists.
- Profile route smoke test exists.
- Settings route smoke test exists.
- Fox and Summertime Saga route rendering tests are deferred because those screens start live HTTP work in `initState()`.

Current phase:

- Phase 2: Low-risk Feature Placement.

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

## Recommended Next Work

Current phase:

- Phase 2 — Low-risk Feature Placement

Task sizing note:

- Continue applying safety skills, but bundle work by scope when possible.
- Do not use the Fox multi-step sequence as the default template for every screen.
- Simple screens should usually be handled in one task.
- API/live-network screens may justify extra hardening tasks.

### Primary

T19 — Fix Test screen lifecycle and keyboard safety

Reason:

- T18 confirmed the Test screen is not dead because Dashboard links to `AppRoutes.test`.
- The screen creates a `TextEditingController` inside `build()`, which is a concrete lifecycle/resource risk.
- The screen is form-like but not SafeArea-aware, scroll-safe, or keyboard-safe yet.

Scope:

- Keep the screen in `lib/screens/test/` for now.
- Move owned controller state into `_TestScreenState` and dispose it.
- Make the screen SafeArea-aware, scroll-safe, and keyboard-safe without redesigning it.
- Keep GetX route behavior unchanged.

Verification:

- Dart logic/test gates from `docs/qa/IW_GIT_WORKFLOW.md`.

### Alternatives

T20 — Move Test screen to feature presentation

Choose this after T19 if the user wants to keep the Dashboard-linked Test screen.

T21 — Dashboard UI layout-safety pass

Choose this if visible hub layout safety should be checked before more placement work.

T22 — Summertime Saga hardening plan

Choose this if the known higher-risk API-backed flow should be planned before more placement.

### Do not start yet

- Riverpod activation.
- go_router migration.
- Dio/network layer.
- `lib/main.dart` app composition refactor.
- GetX routing replacement.
- Built-in Kotlin migration.
- UI redesign during placement or layout-safety tasks unless explicitly approved.
- Additional Fox follow-up tasks unless a concrete risk, failed verification, blocker, or user-approved remaining scope exists.
- Test screen deletion or route removal unless explicitly approved.

### Phase guard

Current phase:

- Phase 2 — Low-risk Feature Placement.

Decision:

- Continue Phase 2.

Do not enter yet:

- Phase 3 — Design System Foundation.

Reason:

- GetX routing is still active.
- `lib/main.dart` still owns app composition.
- Low-risk feature placement work remains.
- The migration map exists, but its recommended low-risk moves are not complete yet.
- Fox is complete for Phase 2 unless a new concrete risk, failed verification, blocker, or user-approved remaining scope appears.
- The Primary recommendation has returned to the migration map/backlog.

Exit criteria:

- Simple low-risk screens selected for Phase 2 are moved or explicitly deferred.
- Legacy route imports are updated and covered by narrow smoke tests where practical.
- Remaining high-risk work is separated into later router, state, network, or app-composition phases.

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
