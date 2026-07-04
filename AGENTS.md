# AGENTS.md — InfinityWorld

## 1. Project Context

InfinityWorld is an Android-first, iOS-ready personal super-app and portfolio Flutter project.

The app is intended to become a polished modular personal hub containing tools, trackers, reader features, RSS/news, AI utilities, and device integrations.

Primary platform:

```text
Android
```

Future platform:

```text
iOS
```

Do not optimize early work for desktop or web unless the task explicitly asks for it.

## 2. Required Project Documents

Before making architecture, routing, theme, or feature-structure decisions, read these documents:

```text
docs/PROJECT_DIRECTION.md
docs/ARCHITECTURE.md
docs/DESIGN_SYSTEM.md
docs/ROADMAP.md
```

If one of these files does not exist yet, do not invent conflicting decisions. Follow the decisions already documented in the existing files and ask/report what is missing.

## 3. Current Product Decisions

Confirmed product direction:

```text
Product:
Android-first, iOS-ready personal super-app and portfolio Flutter project.

Startup:
Splash screen exists.
App opens into Login.
If a previous local session exists, redirect to Home.

Auth:
Fake/local profile first.
Real auth later.

Navigation:
Home | Explore | Tools | Library | Settings.

Design:
Main style is Midnight Violet Dashboard.
Support light/dark mode from the beginning.
Neon Community Dark is a future optional theme or feature mood.
Vice Heat may be a future optional theme.

Typography:
Sora + Inter.

Development approach:
Polished and maintainable over fast feature accumulation.
```

## 4. Architecture Direction

Use a feature-first modular architecture.

Preferred structure:

```text
lib/
  app/
    app.dart
    router/
    theme/
    bootstrap/
    shell/

  core/
    config/
    network/
    database/
    permissions/
    errors/
    logging/
    utils/

  design_system/
    tokens/
    components/
    layout/
    effects/

  features/
    auth/
    home/
    explore/
    tools/
    library/
    settings/
    bmi/
    wheel/
    summertime_saga/
    reader/
    news/
    ai_lab/
    device_hub/
```

Do not force every small feature into heavy clean architecture.

Use deeper layering only when the feature needs it.

Acceptable feature structure for small modules:

```text
features/bmi/
  bmi_screen.dart
  bmi_calculator.dart
  bmi_controller.dart
```

Acceptable feature structure for larger modules:

```text
features/news/
  data/
  domain/
  application/
  presentation/
```

## 5. State Management

Use Riverpod for new state management and dependency injection code.

Rules:

```text
Use Riverpod for new code.
Use Riverpod providers for dependencies.
Use AsyncValue/Notifier/AsyncNotifier where appropriate.
Use autoDispose for temporary screen state when appropriate.
Do not introduce Provider for new code.
Do not introduce BLoC/Cubit unless the task explicitly justifies it.
Do not expand GetX usage for new code.
```

GetX is legacy in this project.

Existing GetX code may remain temporarily while the app is migrated. Do not rewrite the entire app just to remove GetX unless the task explicitly asks for a migration.

## 6. Routing

Use go_router for new routing work.

Routing direction:

```text
go_router = new routing direction
GetX routing = legacy only
```

Data passing rules:

```text
Route params should pass IDs or small keys.
Shared/session state should live in Riverpod.
Persistent state should live in local storage/database.
Do not pass large objects through routes.
```

Expected bottom navigation:

```text
Home | Explore | Tools | Library | Settings
```

## 7. Startup and Session Flow

The intended startup flow is:

```text
Native Splash
→ Flutter Bootstrap / Splash
→ Check local session
→ If previously logged in: Home
→ If not logged in: Login / Local Profile
```

The first authentication implementation is local/fake profile login.

Do not implement real backend authentication unless the task explicitly asks for it.

Local session/profile may be stored using shared_preferences during early phases.

## 8. Design System

The project should use a custom InfinityWorld Design System.

Default style:

```text
Midnight Violet Dashboard
```

First implementation target:

```text
Midnight Violet Light
Midnight Violet Dark
```

Future optional style:

```text
Neon Community Dark
```

Do not implement full multi-style theme switching unless the task explicitly asks for it.

Typography:

```text
Sora: headings, hero text, important section titles
Inter: body text, labels, inputs, navigation, general UI
```

Component naming should use the `Iw` prefix where practical:

```text
IwButton
IwCard
IwAppScaffold
IwTextField
IwEmptyState
IwErrorView
IwLoadingView
IwSectionHeader
IwBottomNav
IwModuleCard
```

Avoid hard-coded colors and spacing in feature screens. Prefer theme tokens, design-system components, and reusable layout primitives.

## 9. Visual Rules

The UI should be:

```text
Android-first
iOS-ready
Portfolio-friendly
Futuristic but controlled
Dashboard-like
Readable
Consistent
```

Avoid:

```text
Cosmic UI as the main visual style
Full glassmorphism
Heavy cyberpunk visuals
Excessive glow
Excessive gradient usage
Excessively rounded iOS-like shapes
Hard-coded one-off UI styling
```

Use neon accents sparingly.

Dark mode should be polished, but light mode must also be supported.

## 10. Networking

Use Dio for new networking code.

Do not add new direct `http` calls in feature widgets.

Networking direction:

```text
UI
→ Riverpod controller/provider
→ repository/service
→ Dio client
```

Network work should include:

```text
timeout handling
error handling
loading state
empty state where appropriate
retry where appropriate
safe nullable parsing
```

Do not call APIs directly from widget `build()` methods.

## 11. Local Storage

Use shared_preferences for simple settings/session values.

Use Drift when persistent relational/local feature data is needed.

Do not add a database schema before the feature needs persistence.

Expected local-first data examples:

```text
local profile
theme settings
session flag
bookmarks
saved articles
reading progress
tracker configuration
known devices
recently used modules
```

## 12. Device Hub / Bluetooth / Audio

Bluetooth and audio features belong under:

```text
Tools → Device Hub
```

Do not add Bluetooth/audio packages before Device Hub work starts.

Potential future packages may include:

```text
permission_handler
flutter_blue_plus
bluetooth_low_energy
flutter_blue_classic
just_audio
audio_session
audio_service
```

Device logic should be isolated behind services/controllers/providers.

Do not place permission handling, scanning, or audio session logic directly inside UI widgets.

## 13. Performance Rules

Follow these rules:

```text
Lazy-load features.
Do not load every module on Home startup.
Do not call APIs in build().
Use lazy lists for long content.
Use const widgets where practical.
Split widgets to reduce unnecessary rebuilds.
Avoid heavy blur/glass effects.
Avoid continuous animated gradients/backgrounds.
Avoid excessive glow/shadow.
Optimize images before bundling.
```

Home should show summaries, pinned modules, and quick actions. It should not initialize all feature services.

## 14. App Size Rules

Avoid unnecessary size growth.

Rules:

```text
Do not add packages before they are needed.
Do not add Firebase/Supabase/backend packages early.
Do not add Bluetooth/audio packages before Device Hub work starts.
Do not add multiple icon packs without justification.
Do not bundle large images unnecessarily.
Prefer SVG for simple illustrations/icons.
Prefer WebP for raster images where appropriate.
Limit font families and font weights.
```

Use only required font weights.

Preferred early font weights:

```text
Inter: 400, 500, 600, 700
Sora: 600, 700
```

## 15. Icon Direction

App icon direction:

```text
Infinity symbol + Midnight Violet gradient
```

In-app icons should use one consistent icon style.

Preferred direction:

```text
Material Symbols Rounded
```

Suggested bottom navigation icon mapping:

```text
Home: home_rounded
Explore: explore_rounded / travel_explore_rounded
Tools: handyman_rounded / construction_rounded
Library: local_library_rounded / collections_bookmark_rounded
Settings: settings_rounded
```

Do not mix unrelated icon styles across the app.

## 16. Testing and Verification

When editing code, run the most relevant checks possible.

Preferred commands:

```powershell
flutter pub get
flutter analyze
flutter test
flutter build apk --debug
```

Use `--no-pub` when appropriate for quick checks:

```powershell
flutter analyze --no-pub
```

If a command cannot be run, report why.

Do not claim a command passed unless it was actually run.

## 17. Existing Known Risks

Known issues from the initial review:

```text
High:
- Android release manifest may be missing INTERNET permission
- Summertime Saga flow can spin forever or crash on null/error states

Medium:
- Dev/Prod config is not fully meaningful yet
- Test coverage is still minimal
- pubspec.lock / Dart version mismatch may exist
- Some controller/focus lifecycle leaks may exist
- Android release signing is not production-ready
- Some platform identifiers may still contain example defaults

Low:
- Some routes/screens are dead or incomplete
- Settings route registration was fixed, but broader navigation remains legacy
- Some dependencies may be placed incorrectly
```

Do not fix all of these at once unless the task explicitly asks for a stabilization batch.

Prefer small, reviewable changes.

## 18. Change Scope Rules

For each task:

```text
Keep changes small and focused.
Do not perform broad refactors unless requested.
Do not change feature behavior outside the task scope.
Do not rewrite architecture opportunistically.
Do not introduce new packages without justification.
Do not remove legacy code unless the replacement is complete and verified.
```

When making changes, report:

```text
Files changed
Reason for each change
Commands run
Any commands not run
Remaining risks
```

## 19. Documentation Rules

When a task changes architecture, routing, theme, or project direction, update the relevant docs:

```text
docs/PROJECT_DIRECTION.md
docs/ARCHITECTURE.md
docs/DESIGN_SYSTEM.md
docs/ROADMAP.md
```

Do not let implementation drift away from documented decisions.

## 20. Portfolio Quality Bar

InfinityWorld should demonstrate:

```text
Clean modular Flutter architecture
Riverpod-based dependency/state direction
go_router navigation direction
Custom design system
Light/dark theme support
Local-first app behavior
Good error/loading/empty states
Performance-aware UI
Controlled app size
Android-first polish
iOS-ready thinking
Useful documentation
```

Quality and consistency are more important than feature count.

## 21. Flutter UI Layout Safety

Flutter UI tasks in InfinityWorld must apply the global `flutter-ui-layout-safety` skill and follow:

- `docs/design/IW_LAYOUT_SAFETY.md`
- `docs/design/IW_SYSTEM_UI_POLICY.md`

Project rules:

- Default screens must be SafeArea-aware, edge-to-edge-compatible, scroll-safe, and keyboard-safe when forms are involved.
- Normal app screens must not use fullscreen or immersive mode. This includes Home, BMI, Settings, Tools, Library, AI Lab, Device Hub, Profile, Login, and Dashboard.
- Fullscreen or immersive mode is allowed only for reader, media preview, image/video viewer, camera/scanner, game-like, or explicitly approved screens.
- A screen that changes `SystemChrome` system UI mode must restore the default app mode when leaving.
- Apply `SafeArea` once at the shell or screen boundary. Do not double-wrap a screen when the shell already handles insets.
- Use existing project widgets, tokens, and components before hard-coding spacing, radius, colors, typography, or shadows.
- Treat card, menu, and navigation collections as expandable and keep them scroll-safe.
- Forms must remain usable while the keyboard is open.
- Do not claim UI is visually safe only because `flutter analyze` passes.
- For UI changes, report which layout-safety checks were considered and what was not verified.

## 21.1 Error Handling and UI Feedback

Flutter error handling and feedback UI tasks in InfinityWorld must apply `flutter-error-handling`, `flutter-ui-feedback`, and the layout-safety rules above when relevant.

Project rules:

- Screens must distinguish loading, success, empty, and error states.
- Do not use `null` alone to represent loading, error, or empty.
- Do not catch unknown errors and return `null`, `[]`, `false`, or silent success.
- API-driven screens such as Summertime Saga, Fox API, News, Library, AI Lab, and Device Hub should show a visible error state with Retry when recovery is reasonable.
- Forms such as Login, BMI, Profile, and Settings should use inline validation and action loading where relevant.
- Use `lib/design_system` tokens/components for feedback UI when available.
- Keep feedback variants consistent: success, info, warning, error, empty, and loading.
- Use text plus icon/color; do not rely on color alone.
- SnackBars are for short action feedback.
- Dialogs are only for destructive confirmation, required user decisions, permission/settings flows, or blocking account/session issues.
- Do not trigger SnackBars, dialogs, bottom sheets, or navigation side effects directly from `build()`.
- Feedback UI must also follow `flutter-ui-layout-safety`.

## 22. Git Workflow

Follow the repo-specific workflow in:

- `docs/qa/IW_GIT_WORKFLOW.md`

Codex may auto commit and auto push completed scoped tasks only on branch `home/devbyMinh-current` after the required verification gates pass.

Before starting each task, run:

```powershell
git branch --show-current
git status --short
```

Do not continue on another branch, work on unrelated dirty changes, push protected branches, force-push, merge branches, or make Android toolchain/build-system changes on this branch unless explicitly approved.

## 23. Living Planning Docs

Keep the planning docs aligned when scope, phase, architecture direction, workflow, or durable product decisions change:

- `docs/ROADMAP.md`
- `docs/TASKS.md`
- `docs/DECISIONS.md`
- `docs/qa/IW_TASK_WORKFLOW.md`

Treat `docs/ARCHITECTURE.md` as the target direction, not a claim that the current `lib/` structure is already migrated. Use `docs/TASKS.md` as the active backlog when deciding the next small task.

`docs/TASKS.md` is guidance, not a hard lock. If the user assigns a different task, follow the user's task and apply `docs/qa/IW_TASK_WORKFLOW.md`: update planning docs only when the task changes priority, phase, backlog, or durable decisions, and report whether planning docs were updated.

## 24. Standard Task Result Reporting

After every completed or blocked task, return the compact `Task Result` format defined in:

- `docs/qa/IW_TASK_WORKFLOW.md`

Always include the current phase. Keep detailed planning state in `docs/TASKS.md`, not in final chat output. Final output should include one primary next task, the phase that next task belongs to, and a pointer to `docs/TASKS.md` for alternatives, deferred work, and the phase guard.
