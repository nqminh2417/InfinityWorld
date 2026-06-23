# Infinity World Decisions

Last updated: 2026-06-23

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

### 2026-06-23: Keep GetX during the transitional migration phase

GetX routing remains active for now. Do not convert routing to go_router until an explicit router migration phase starts. Do not expand GetX for new architecture work.

### 2026-06-23: Do not introduce target libraries before their phase

Riverpod, go_router, Dio, Drift, Bluetooth/audio packages, and backend SDKs should be introduced only by scoped tasks that require them.

### 2026-06-23: BMI is the current migration pilot

BMI is the first small feature used to prove gradual migration:

- Domain logic lives under `lib/features/bmi/domain/`.
- Presentation lives under `lib/features/bmi/presentation/`.
- Legacy GetX routing still opens the BMI screen.

### 2026-06-23: Apply Flutter UI layout safety rules for UI work

Flutter UI work must apply the global `flutter-ui-layout-safety` skill and the repo policies:

- `docs/design/IW_LAYOUT_SAFETY.md`
- `docs/design/IW_SYSTEM_UI_POLICY.md`

### 2026-06-23: Fullscreen and immersive mode are restricted

Normal screens must keep system bars usable and content visible. Fullscreen or immersive mode is limited to reader, media preview, image/video viewer, camera/scanner, game-like screens, or explicitly approved screens.

### 2026-06-23: Android toolchain/build-system work is separate

Gradle, Android Gradle Plugin, Kotlin, signing, package identity, and other Android build-system changes should use a separate branch/task unless explicitly approved.

### 2026-06-23: Emulator/device UI review is a later QA phase

Device or emulator UI review is important for polish, but it is not required for every small current task. Code-level UI safety still applies to UI changes.

### 2026-06-23: User-assigned tasks can override the backlog recommendation

`docs/TASKS.md` is guidance, not a hard lock. If the user assigns a different scoped task, Codex should follow the user's task and update planning docs only when the task changes priority, phase, backlog, or durable decisions.

Source of truth:

- `docs/qa/IW_TASK_WORKFLOW.md`

## Superseded or Revisit Later

No decisions are currently superseded.
