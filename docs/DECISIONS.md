# Infinity World Decisions

Last updated: 2026-06-29

This file records durable product, architecture, workflow, and safety decisions for Infinity World. Keep entries concise and update them when a decision changes.

## Accepted Decisions

### 2026-06-23: Work directly on `home/devbyMinh-current`

Codex should continue scoped repository work directly on branch `home/devbyMinh-current`.

### 2026-06-23: Auto commit and push after passing gates

Codex may automatically create a local commit and push after each scoped task when the required verification gates pass and the task only stages related files.

Source of truth:

- `docs/qa/IW_GIT_WORKFLOW.md`

### 2026-06-23: Do not auto merge or rewrite history

Codex must not auto merge branches, force-push, or rewrite history unless the user explicitly requests it. If a pushed commit needs adjustment, use a follow-up fix commit by default.

### 2026-06-23: New and migrated features live under `lib/features/<feature>/`

New feature work and gradually migrated legacy screens should move toward:

```text
lib/features/<feature>/
```

Small features may stay simple. Larger features may use `data/`, `domain/`, `application/`, and `presentation/` subfolders when needed.

### 2026-06-23: Do not expand GetX during the transitional migration phase

GetX was kept during early transitional work. Active routing now uses go_router, and remaining GetX code is limited to inactive cleanup scope.

Do not expand GetX for new architecture work.

### 2026-06-23: Do not introduce target libraries before their phase

Riverpod, go_router, Dio, Drift, Bluetooth/audio packages, and backend SDKs should be introduced only by scoped tasks that require them.

### 2026-06-27: First local session bootstrap slice keeps GetX

The first Phase 4 implementation should preserve the current GetX router and `GetMaterialApp`.

Use `shared_preferences` for the initial local session flag, add a small bootstrap resolver before `runApp`, and update the existing login/logout actions to save and clear that flag.

Do not introduce Riverpod, go_router, Dio, real backend auth, or a broad auth redesign in this slice.

### 2026-06-28: Close Phase 4 before router migration

Phase 4 is closed with local session/profile startup behavior implemented on the existing GetX app.

Start Phase 5 with a router migration kickoff audit before adding go_router or changing production routes. The first router implementation must preserve startup/session/login/logout behavior, keep important screens reachable, and avoid mixing in Riverpod, Dio, real backend authentication, or shell redesign.

### 2026-06-28: First go_router slice is root parity only

The first go_router implementation should add the package, introduce a small `lib/app/router/` configuration, preserve existing `AppRoutes` path strings, and replace root `GetMaterialApp` with `MaterialApp.router`.

It should map the existing route table, replace the current production GetX navigation calls, and keep `MainScreen` unchanged. Do not introduce `ShellRoute`, redesign the bottom navigation, remove GetX, add Riverpod, add Dio, or change real authentication in the first router slice.

### 2026-06-28: Shell ownership moved before shell redesign

The audited `MainScreen` is a thin legacy shell wrapper for Dashboard, Chat, and Profile. T39 moved that ownership to `lib/app/shell/main_screen.dart` while preserving current tabs and `/main` behavior.

Do not combine future shell work with unrelated Riverpod, Dio, GetX cleanup, or visual redesign work. The five target tabs and any later `ShellRoute`/deep-link work should remain scoped separately.

### 2026-06-28: GetX cleanup removed only inactive routing

The T40 audit found no active GetX navigation calls. Remaining Dart GetX usage was limited to inactive `lib/routes/app_pages.dart`, and the `get` dependency existed only for that file.

T41 deleted `lib/routes/app_pages.dart` and removed `get`, but kept `lib/routes/app_routes.dart` as the shared route path contract for go_router and startup/session code.

### 2026-06-29: Live-network route smoke tests should use router builder overrides

The T42 audit found that Fox and Summertime Saga already expose deterministic screen seams: `FoxRandomScreen(service: ...)` and `SmtsHomeScreen(loadProgress: ..., logoUrl: ...)`.

Do not wait for Dio, Riverpod, or a networking migration just to smoke-test their go_router paths. The next implementation should add the smallest test-only seam at the router factory level so route tests can override those two builders with fake loaders while production routes keep the current default constructors.

### 2026-06-29: First five-tab shell slice should stay local to `MainScreen`

The T44 audit found that `MainScreen` is still a local-state bottom-navigation shell and the target root feature folders for Home, Explore, Tools, and Library do not exist yet.

The first five-tab implementation should update `MainScreen` to the target Home / Explore / Tools / Library / Settings labels without introducing `ShellRoute`, Riverpod, Dio, new route paths, or live-network tab roots. Keep `/main` as the startup shell route, keep direct route parity for existing feature routes, and preserve current Dashboard access from the first tab until richer Home/Tools/Explore roots are scoped.

### 2026-06-29: Defer `ShellRoute` until real tab routes or tab stacks exist

The T46 audit found no current need for `ShellRoute` or tab-specific paths. The app is Android-first, `/main` remains the local session shell entry point, the five-tab shell is local state, Explore/Tools/Library are placeholders, and important feature screens already have direct go_router routes.

The official go_router docs describe URL-based navigation and deep linking through `GoRoute`, while shell APIs are for nested/multiple Navigator layouts. `StatefulShellRoute` is the better future fit if InfinityWorld needs separate tab navigation stacks or state preservation per branch.

Do not implement `ShellRoute`, `StatefulShellRoute`, `/home`, `/explore`, `/tools`, or `/library` until real tab root screens and at least one tab-owned child route/back-stack need exist. The next router task should be a Phase 5 checkpoint audit, not another routing implementation slice.

### 2026-06-29: Close Phase 5 before Riverpod foundation

The T47 checkpoint found that Phase 5 routing goals are complete enough to close: active routing is go_router-only, startup/session parity is preserved through `/main`, direct route smoke tests cover the active route table including fake-network Fox and Summertime Saga routes, `MainScreen` owns the local five-tab shell, and `ShellRoute` is intentionally deferred.

Start Phase 6 with a Riverpod foundation kickoff audit before adding Riverpod or rewriting state. Do not combine Riverpod introduction with Dio, real backend auth, shell-route work, feature expansion, or visual redesign.

### 2026-06-29: First Riverpod slice is root/session provider only

The T48 audit scoped the first Riverpod implementation to root `ProviderScope` setup and one `LocalSessionRepository` provider seam.

T49 added `flutter_riverpod`, kept `/main` and active go_router routes unchanged, updated Login/Dashboard/startup-session tests for provider overrides, and avoided migrating BMI, Fox, Summertime Saga, Settings, theme preferences, Dio, real auth, shell routes, or feature roots.

### 2026-06-23: BMI is the current migration pilot

BMI is the first small feature used to prove gradual migration:

- Domain logic lives under `lib/features/bmi/domain/`.
- Presentation lives under `lib/features/bmi/presentation/`.
- Active go_router routing opens the BMI screen. The inactive legacy GetX route table has been removed.

### 2026-06-23: Apply Flutter UI layout safety rules for UI work

Flutter UI work must apply the global `flutter-ui-layout-safety` skill and the repo policies:

- `docs/design/IW_LAYOUT_SAFETY.md`
- `docs/design/IW_SYSTEM_UI_POLICY.md`

### 2026-06-23: Fullscreen and immersive mode are restricted

Normal screens must keep system bars usable and content visible. Fullscreen or immersive mode is limited to reader, media preview, image/video viewer, camera/scanner, game-like screens, or explicitly approved screens.

### 2026-06-23: Android toolchain/build-system work is separate

Gradle, Android Gradle Plugin, Kotlin, signing, package identity, and other Android build-system changes should use a separate branch/task unless explicitly approved.

### 2026-06-23: Android toolchain upgrade pulled forward for Flutter 3.44.2

The Android toolchain upgrade was explicitly approved on `home/devbyMinh-current` to reduce Flutter 3.44.2 future compatibility warnings.

Selected versions:

- Gradle wrapper: 8.14.5
- Android Gradle Plugin: 8.11.1
- Kotlin Gradle Plugin: 2.2.20
- Java/Kotlin target: 17

AGP 9.x and Built-in Kotlin migration remain deferred follow-up work unless a future build requires them.

### 2026-06-23: Emulator/device UI review is a later QA phase

Device or emulator UI review is important for polish, but it is not required for every small current task. Code-level UI safety still applies to UI changes.

### 2026-06-23: User-assigned tasks can override the backlog recommendation

`docs/TASKS.md` is guidance, not a hard lock. If the user assigns a different scoped task, Codex should follow the user's task and update planning docs only when the task changes priority, phase, backlog, or durable decisions.

Source of truth:

- `docs/qa/IW_TASK_WORKFLOW.md`

### 2026-06-23: Task results use a standard concise report

After every completed or blocked task, Codex should return the standard `Task Result` report with status, summary, changed files, verification, commit/push details, planning-doc status, unverified areas, and one advisory recommended next task.

Source of truth:

- `docs/qa/IW_TASK_WORKFLOW.md`

## Superseded or Revisit Later

No decisions are currently superseded.
