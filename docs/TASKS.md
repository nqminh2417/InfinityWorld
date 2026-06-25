# Infinity World Active Tasks

Last updated: 2026-06-25

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
- Profile presentation now lives under `lib/features/profile/presentation/`.
- Settings presentation now lives under `lib/features/settings/presentation/`.
- Phase 2 migration map exists at `docs/PHASE2_MIGRATION_MAP.md`.
- Riverpod, go_router, and Dio are not active yet.

Current tests:

- App startup smoke test exists.
- BMI domain unit tests exist.
- BMI presentation widget tests exist.
- Profile route smoke test exists.
- Settings route smoke test exists.

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
- Phase 2 migration map was created to rank remaining `lib/screens/` ownership and avoid random screen moves.

## Recommended Next Work

Current phase:

- Phase 2 — Low-risk Feature Placement

### Primary

T8 — Move Chat screen to feature presentation

Reason:

- Chat is the next lowest-risk legacy screen after Settings and Profile.
- It is a placeholder used by both the legacy route table and `MainScreen`.

Scope:

- Move only the existing Chat screen into `lib/features/chat/presentation/`.
- Update only the minimal legacy GetX and `MainScreen` import/reference.
- Add or update a route smoke test if practical.
- Do not redesign the placeholder UI.

Verification:

- Screen move/routing gates from `docs/qa/IW_GIT_WORKFLOW.md`.

### Alternatives

T9 — Add route smoke tests for remaining legacy routes

Choose this if route confidence is more urgent than moving another screen.

T10 — Profile UI layout-safety pass

Choose this if Profile visual/layout risks should be fixed before more placement.

T11 — Move Dashboard screen to feature presentation

Choose this if you want the next visible hub screen moved before more route tests.

### Do not start yet

- Riverpod activation.
- go_router migration.
- Dio/network layer.
- `lib/main.dart` app composition refactor.
- GetX routing replacement.
- Built-in Kotlin migration.
- Profile UI redesign during the move task.

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
