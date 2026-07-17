# Infinity World Git Workflow

## Scope

This workflow applies only to the Infinity World repository. It owns Git safety, verification gates, and commit/push authority. `docs/qa/task-workflow.md` owns task lifecycle and the user-facing result format.

## Preflight and Allowed Branch

```text
home/devbyMinh-current
```

Before starting any task, run:

```powershell
git branch --show-current
git status --short
```

Continue only if the current branch is `home/devbyMinh-current`, unless the user explicitly approves another branch.

Never use destructive Git commands, change global tools/configuration, or broaden a repository task without explicit authorization. Preserve unrelated user work.

## Dirty Working Tree Policy

| Working-tree state | Required handling |
| --- | --- |
| Clean | Proceed with the scoped task. |
| Only scoped Codex changes | Proceed; stage only the approved task files after review. |
| Unrelated unstaged or untracked changes | Inspect enough to avoid overlap. Continue only when scoped files can be isolated precisely; do not stage, format, or overwrite the unrelated work. Otherwise stop the write/commit portion and report the blocker. |
| Unrelated staged changes | Do not unstage or include them. Because a commit cannot safely exclude staged user work, stop the commit portion and report the blocker. |
| Conflicting edits in the same file | Stop before overwriting or staging that file and request direction. |

## Commit and Push Authority

Commit and push are allowed only when all of the following are true:

- The user explicitly requests it, the task prompt explicitly authorizes it, or an approved multi-task plan reaches its stated coherent commit boundary.
- Required gates pass, the scope is complete, and focused diff/status review confirms only scoped files will be staged.
- The current branch is allowed and its configured upstream is confirmed before push; do not invent a remote or branch mapping when no upstream exists.

Commit and push are not allowed when the task is analysis/planning-only, a required gate has a new failure, the scope is incomplete, unrelated changes cannot be isolated safely, branch/upstream policy is unclear, or an intermediate commit would misrepresent completion. Passing gates alone does not authorize a commit or push.

- Stage only files related to the current scoped task and use concise Conventional Commit messages.
- A coherent task may commit alone; explicitly planned, tightly coupled tasks may share one documented commit boundary.
- Report the commit hash, commit message, push result, verification commands, and unverified areas.
- Never push `main`, `master`, `dev`, `release/*`, or production branches unless explicitly requested.
- Never amend, rebase, reset, force-push, merge, or switch branches unless explicitly requested.
- If a commit succeeds but push fails, keep the commit and report the failure. If a pushed commit needs adjustment, use a follow-up fix commit by default.
- Android toolchain or build-system changes should use a separate branch unless explicitly approved.

## Authoritative Verification Matrix

Every task starts with `git branch --show-current` and `git status --short`, and ends with focused `git diff`, `git diff --check`, and `git status --short` review. Commands below are the authority: `F` = `dart format --output=none --set-exit-if-changed <changed Dart scope>`, `A` = `flutter analyze`, `T` = `flutter test`, `B` = `flutter build apk --debug`, and `D` = `git diff --check`.

| Change type | Required commands | Optional / manual evidence | Build or device requirement |
| --- | --- | --- | --- |
| Documentation-only | `D` and focused Git review. | Inspect changed Markdown links/references when paths, headings, instructions, or workflow text change. | No Flutter commands unless executable configuration or instructions changed. |
| Dart logic/domain or test | `F`, `A`, `T`, `D`, and focused Git review. | Run the smallest focused test first when it speeds diagnosis. | No build/device check unless the change also meets another row. |
| Widget/UI | `F`, `A`, `T`, `D`, and focused Git review. | Apply relevant regression/UI checklist items; record route, theme, viewport/device, and observed result for any manual check. | `B` only when routing, startup, package/native, or build-impacting code also changes. Device/emulator validation is required for high-risk visual, system-bar, keyboard, accessibility, or navigation behavior; otherwise report it as unverified rather than claiming runtime proof. |
| Routing/startup | `F`, `A`, `T`, `B`, `D`, and focused Git review. | Route/startup smoke coverage and manual affected-flow check. | Device/emulator launch and affected-route check are required when the user-visible Android launch/navigation behavior changes; unavailable hardware leaves runtime verification unverified. |
| Persistence | `F`, `A`, `T`, `D`, and focused Git review. | Test existing-value, migration, and error behavior when keys/schema/compatibility change; manual restart check when practical. | `B` only for platform/plugin impact. Device validation is required if platform storage behavior is part of the acceptance criteria. |
| Network/service | `F`, `A`, `T`, `D`, and focused Git review. | Deterministic fake-client success/error/timeout coverage; live-network check only when assigned. | `B`/device only when the change includes mobile integration or user-visible runtime behavior that needs it. |
| Dependency or generated code | `flutter pub get`, applicable generation command, `F` for changed Dart, `A`, `T`, `D`, and focused Git review. | Verify generated outputs are current and review dependency impact. | `B` for Flutter/plugin/native dependency impact; device check when the dependency changes device behavior. |
| Android/platform/toolchain | Explicit approval and branch policy, applicable `flutter pub get`, `F` for changed Dart, `A`, `T`, `B`, `D`, and focused Git review. | Inspect platform diff and relevant Gradle/Xcode output. | Device/emulator check is required for changed runtime platform behavior. Separate branch unless explicitly approved. |
| Large refactor or file move | `F`, `A`, `T`, `D`, focused Git review, and repository reference search. | Run focused route/persistence/UI checks for affected contracts. | `B` and device/emulator checks when the moved/refactored surface includes startup, routing, user-visible UI, platform integration, or persistence risk. |

Use changed-scope formatting for normal work. Run `dart format --output=none --set-exit-if-changed .` only for baseline audits or explicitly assigned formatting cleanup. Semble, CodeGraph, Context7, and similar tools may aid investigation; if they fail, use native search, code inspection, analyzer, and tests instead. They are never completion proof.

## Completion and Failure Policy

- A new failure in a required gate blocks completion, commit, and push.
- A failure may be reported as pre-existing only when a baseline proves it is unchanged, unrelated to the task, and outside the approved scope; never reformat or stage unrelated files merely to make a gate green.
- A skipped required gate means the task is not fully verified. Report the command, reason, and unverified risk.
- Build success does not replace tests. Passing tests do not replace required device/visual checks for high-risk UI work.
- Manual evidence must name the device/emulator or viewport, route/flow, theme when relevant, and observed result. Do not claim device, visual, performance, or live-network validation unless it was performed.
- Final task reports must list commands and outcomes, focused diff/status review, manual evidence or unverified areas, and any pre-existing-failure basis. `docs/qa/task-workflow.md` owns the report format.
