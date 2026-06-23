# Infinity World Roadmap

Last updated: 2026-06-23

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

- `lib/main.dart` still owns root app composition and uses `GetMaterialApp`.
- `lib/routes/app_pages.dart` and `lib/routes/app_routes.dart` still define legacy GetX routing.
- Most production screens still live under `lib/screens/`.
- Shared legacy UI remains under `lib/widgets/`.
- `lib/core/config/constants.dart` contains early runtime constants.
- BMI has started the feature migration pilot:
  - `lib/features/bmi/domain/bmi_calculator.dart`
  - `lib/features/bmi/presentation/bmi_screen.dart`
- Tests now exist:
  - `test/app_smoke_test.dart`
  - `test/features/bmi/domain/bmi_calculator_test.dart`

Current dependencies:

- Flutter SDK constraint: `^3.7.0`
- Runtime packages: `get`, `http`, `change_app_package_name`
- Dev packages: `flutter_test`, `flutter_lints`

Riverpod, go_router, and Dio are target-direction technologies but are not installed or active yet. Do not introduce them until their explicit phases/tasks begin.

## Current Known Risks

- Login still calls `setState()` from `build()` through keyboard-height handling.
- GetX routing remains the active router.
- `lib/screens/` and `lib/routes/` remain active legacy areas.
- Some networking still uses direct `http` services under legacy feature folders.
- `AppRoutes.settings` exists, but the current GetX page list does not register a Settings route.
- Theme/design-system implementation is still mostly target documentation rather than app code.
- Android Gradle, Android Gradle Plugin, and Kotlin upgrade warnings should be handled later as a separate branch/task.

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

- Preserve GetX for now unless a future router migration phase is explicitly started.
- Do not convert GetX to go_router opportunistically.
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

Status: current recommended implementation phase.

Goal:

- Make the legacy app safer to modify without migrating the whole architecture.

Recommended tasks:

1. Fix the Login screen build-time `setState()` and keyboard layout risk.
2. Continue the BMI pilot with a small UI layout-safety pass.
3. Align obvious route/screen mismatches, such as Settings route registration, only as scoped tasks.
4. Add or adjust narrow tests when a task changes behavior or startup risk.

Non-goals:

- No router migration.
- No Riverpod introduction.
- No Dio migration.
- No broad folder migration.
- No design-system rewrite.

## Phase 2: Low-risk Feature Placement

Status: future, after current stabilization tasks.

Goal:

- Move one simple screen or feature at a time toward `lib/features/<feature>/` while keeping GetX routing active.

Good candidates:

- BMI continuation, because it is already partly migrated.
- Profile or Settings, if the task only moves the screen and updates the existing GetX route.

Avoid early:

- Summertime Saga, because it includes network/error/loading risk.
- Router-wide changes.
- Startup/session rewrites.

Verification:

- Screen move/routing/startup gates from `docs/qa/IW_GIT_WORKFLOW.md`.

## Phase 3: Design System Foundation

Status: future.

Goal:

- Start implementing Midnight Violet design tokens and reusable UI components in small slices.

Likely tasks:

- Add minimal color/spacing/radius tokens.
- Add one or two reusable `Iw` components.
- Apply them to one pilot screen after the tokens exist.

Non-goals:

- No full visual redesign of every legacy screen.
- No multi-theme system.
- No heavy animation/glow system.

## Phase 4: App Bootstrap and Local Session

Status: future.

Goal:

- Move startup/session behavior toward the documented flow:

```text
Native Splash
-> Flutter Bootstrap / Splash
-> Local session check
-> Login or Home
```

This phase may still use existing routing until the router migration starts.

Non-goals:

- No real backend authentication.
- No cloud sync.
- No broad auth redesign.

## Phase 5: Router Migration

Status: deferred, high risk.

Goal:

- Introduce go_router and migrate routing gradually.

Rules:

- Start only with an explicit router migration task.
- Keep existing important screens reachable.
- Do not remove GetX until replacement routing is stable and verified.
- Add route tests or startup smoke tests where practical.

## Phase 6: Riverpod Foundation

Status: deferred, high risk.

Goal:

- Introduce Riverpod for new state and dependency injection.

Rules:

- Start only with an explicit Riverpod foundation task.
- Use a small pilot area first.
- Do not rewrite all StatefulWidgets at once.
- Do not add Provider or BLoC as alternate default state systems.

## Phase 7: Networking Foundation

Status: deferred, medium/high risk.

Goal:

- Introduce Dio and consistent API error/loading behavior when a networking feature is actively migrated.

Good future candidate:

- Summertime Saga, after a focused audit, because it already has API/loading/null-state risk.

Rules:

- Do not add Dio before a scoped networking task.
- Do not call APIs from widget `build()`.
- Keep network logic behind service/repository boundaries.

## Phase 8: Feature Expansion

Status: future.

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
