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
- BMI is the active migration pilot under `lib/features/bmi/`.
- Chat presentation now lives under `lib/features/chat/presentation/`.
- Dashboard presentation now lives under `lib/features/dashboard/presentation/`.
- Profile presentation now lives under `lib/features/profile/presentation/`.
- Settings presentation now lives under `lib/features/settings/presentation/`.
- Phase 2 migration map exists at `docs/PHASE2_MIGRATION_MAP.md`.
- Riverpod, go_router, and Dio are not active yet.

Current tests:

- App startup smoke test exists.
- BMI domain unit tests exist.
- BMI presentation widget tests exist.
- Chat route smoke test exists.
- Deterministic route smoke tests exist for Login, Main, Dashboard, BMI, and Test.
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

- Login build-time `setState()` risk was fixed in the legacy `LoginScreen`; the form is now SafeArea-aware, scroll-safe, and covered by a small keyboard-inset widget test.
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

## Recommended Next Work

Current phase:

- Phase 2 — Low-risk Feature Placement

### Primary

T12 — Move Login screen to feature presentation

Reason:

- Login is the next simple visible screen still in the legacy `lib/screens/` tree.
- Existing startup and route smoke tests give a narrow safety net for an import-only placement task.

Scope:

- Move the existing Login screen to `lib/features/auth/presentation/`.
- Update only the legacy imports/references needed for startup and route tests.
- Keep GetX routing, login behavior, and UI unchanged.

Verification:

- Screen move/routing/startup gates from `docs/qa/IW_GIT_WORKFLOW.md`.

### Alternatives

T13 — Fox feature hardening plan

Choose this if API-backed features should be prepared before moving.

T14 — Dashboard UI layout-safety pass

Choose this if Dashboard layout risk should be reviewed before more feature moves.

T15 — Test screen audit

Choose this if the dev/test route should be classified before deciding whether to move or remove it later.

### Do not start yet

- Riverpod activation.
- go_router migration.
- Dio/network layer.
- `lib/main.dart` app composition refactor.
- GetX routing replacement.
- Built-in Kotlin migration.
- Login UI redesign during the move task.

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
