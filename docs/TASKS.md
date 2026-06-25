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
- Settings presentation now lives under `lib/features/settings/presentation/`.
- Riverpod, go_router, and Dio are not active yet.

Current tests:

- App startup smoke test exists.
- BMI domain unit tests exist.
- BMI presentation widget tests exist.
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

## Next Recommended Tasks

### T6: Move Profile screen to feature presentation

Scope:

- Move only the existing Profile screen into `lib/features/profile/presentation/`.
- Update only the minimal legacy GetX import/reference.
- Do not redesign the Profile UI in the move task.
- If layout issues are found, report them or split them into a follow-up UI-safety task.

Verification:

- Screen move/routing gates from `docs/qa/IW_GIT_WORKFLOW.md`.

## Blocked or Deferred Tasks

- go_router migration: start only as an explicit router migration phase.
- Riverpod foundation: start only as an explicit state/dependency phase.
- Dio networking migration: start only as an explicit networking or feature hardening phase.
- Built-in Kotlin migration: defer until an AGP 9.x migration or build requirement.
- Future Android toolchain/build-system changes: separate branch/task unless explicitly approved.
- Device Hub Bluetooth/audio packages: defer until Device Hub implementation starts.
- Real authentication/backend sync: defer.
- Full design-system rollout across all legacy screens: defer.
- Emulator/device UI review: later QA phase, not a required gate for every current task.
- Force-push, merge, or production branch pushes: never unless explicitly requested.

## Verification Gates

Use `docs/qa/IW_GIT_WORKFLOW.md` as the source of truth.

Quick reference:

- Docs-only: `git diff --check`
- Dart logic/test: `dart format`, `flutter analyze`, `flutter test`, `git diff --check`
- Screen move/routing/startup: `dart format`, `flutter analyze`, `flutter test`, `flutter build apk --debug`, `git diff --check`
- Android toolchain/build-system: separate branch unless explicitly approved

## Asking for the Next Task

If the user asks "what is the next task?", recommend T6 unless it has already been completed or the user explicitly chooses another task.

If the user asks to continue BMI migration, recommend a small explicit BMI follow-up unless the user chooses another BMI task.
