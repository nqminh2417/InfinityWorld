# Infinity World Git Workflow

## Scope

This workflow applies only to the Infinity World repository.

Codex is allowed to automatically create a local commit and push it after each scoped task only when all rules below are satisfied.

## Allowed Branch

Auto commit and auto push are allowed only on:

```text
home/devbyMinh-current
```

Before starting any task, run:

```powershell
git branch --show-current
git status --short
```

Continue only if the current branch is `home/devbyMinh-current`, unless the user explicitly approves another branch.

Do not work on top of unrelated dirty changes. If unrelated changes are present, stop and report them before editing.

## Commit and Push Rules

- Stage only files related to the current scoped task.
- Use concise Conventional Commit messages.
- After completing the task, run the required verification gates for the change type.
- If the gates pass, create a local commit and push the current branch.
- Report the commit hash, commit message, pushed branch, verification commands, and unverified areas.
- Never push `main`, `master`, `dev`, `release/*`, or production branches unless explicitly requested.
- Never force-push unless explicitly requested.
- Never merge branches unless explicitly requested.
- If the user is not satisfied after a pushed commit, make a follow-up fix commit and push it. Do not rewrite history unless explicitly requested.
- Android toolchain or build-system changes should use a separate branch unless explicitly approved.

## Required Gates by Change Type

Docs-only changes:

```powershell
git diff --check
```

Dart logic or test changes:

```powershell
dart format <changed Dart files>
flutter analyze
flutter test
git diff --check
```

Screen move, routing, startup, or build-impacting changes:

```powershell
dart format <changed Dart files>
flutter analyze
flutter test
flutter build apk --debug
git diff --check
```

Android toolchain or build-system changes:

```text
Use a separate branch unless explicitly approved.
```

## Failure Handling

- If a gate fails, do not commit or push.
- Fix only issues within the approved task scope.
- If the failure requires a broad refactor, risky build-system change, or unrelated cleanup, stop and report the blocker.
- Do not hide unverified areas; report any check that was skipped or could not be run.
