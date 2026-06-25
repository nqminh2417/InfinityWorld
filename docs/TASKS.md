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
- Riverpod, go_router, and Dio are not active yet.

Current tests:

- App startup smoke test exists.
- BMI domain unit tests exist.
- Settings route smoke test exists.

Current phase:

- Phase 1: Transitional Stabilization.

Android toolchain status:

- Gradle wrapper, Android Gradle Plugin, Kotlin Gradle Plugin, and Java/Kotlin target were upgraded for Flutter 3.44.2 compatibility on `home/devbyMinh-current` with explicit approval.
- Built-in Kotlin migration remains deferred.

Completed stabilization tasks:

- Login build-time `setState()` risk was fixed in the legacy `LoginScreen`; the form is now SafeArea-aware, scroll-safe, and covered by a small keyboard-inset widget test.
- BMI UI layout-safety pass was completed; the BMI form is now scroll-safe, keyboard-dismiss-aware, and covered by a small keyboard-inset widget test.
- Settings route alignment was fixed; `AppRoutes.settings` is now registered in the legacy GetX route table and covered by a route smoke test.

## Next Recommended Tasks

### T4: Continue BMI pilot with a small feature-quality pass

Scope:

- Use BMI as the reference small local feature.
- Add only narrow improvements that preserve behavior.
- Consider a widget smoke test only if it compiles reliably without broad app setup.

Non-goals:

- No persistence.
- No Riverpod.
- No design-system rewrite.

Verification:

- Match the actual change type using `docs/qa/IW_GIT_WORKFLOW.md`.

### T5: Pick the next simple screen for feature placement

Scope:

- Choose one low-risk screen after BMI is stable.
- Prefer Profile or Settings over API-backed features.
- Move only the selected screen into `lib/features/<feature>/presentation/`.
- Update only the minimal legacy GetX import/reference.

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

If the user asks "what is the next task?", recommend T4 unless it has already been completed or the user explicitly chooses another task.

If the user asks to continue BMI migration, recommend T4 unless the user explicitly chooses another BMI task.
