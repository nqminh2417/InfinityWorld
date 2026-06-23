# Infinity World Active Tasks

Last updated: 2026-06-23

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

Current phase:

- Phase 1: Transitional Stabilization.

## Next Recommended Tasks

### T1: Fix Login build-time setState and keyboard safety

Scope:

- Keep `LoginScreen` in its current legacy location.
- Remove the `setState()` call triggered from `build()`.
- Preserve current login behavior and GetX navigation.
- Make the form keyboard-safe without redesigning the screen.

Likely files:

- `lib/screens/auth/login_screen.dart`
- `test/app_smoke_test.dart` if a narrow regression test is practical

Verification:

- `dart format <changed Dart files>`
- `flutter analyze`
- `flutter test`
- `flutter build apk --debug` if startup behavior or route behavior is affected
- `git diff --check`

### T2: BMI UI layout-safety pass

Scope:

- Keep BMI under `lib/features/bmi/`.
- Preserve BMI calculation behavior and Vietnamese labels.
- Make the BMI screen scroll-safe and keyboard-safe.
- Do not move routing or introduce new state management.

Likely files:

- `lib/features/bmi/presentation/bmi_screen.dart`
- Existing BMI tests only if behavior changes

Verification:

- `dart format <changed Dart files>`
- `flutter analyze`
- `flutter test`
- `git diff --check`

### T3: Settings route alignment audit/fix

Scope:

- Confirm whether Settings is intended to be reachable now.
- If approved, register the existing Settings screen in the legacy GetX route table.
- Do not migrate the router.
- Do not move unrelated screens.

Likely files:

- `lib/routes/app_pages.dart`
- `lib/routes/app_routes.dart`
- `lib/screens/settings/settings_screen.dart` only if a minimal startup-safe fix is required

Verification:

- `dart format <changed Dart files>`
- `flutter analyze`
- `flutter test`
- `flutter build apk --debug`
- `git diff --check`

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
- Android Gradle/AGP/Kotlin upgrades: separate branch/task unless explicitly approved.
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

If the user asks "what is the next task?", recommend T1 unless it has already been completed or the user explicitly chooses another task.

If the user asks to continue BMI migration, recommend T2 or T4 depending on whether UI layout safety has been completed.
