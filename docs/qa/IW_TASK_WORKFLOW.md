# Infinity World Task Workflow

## Purpose

This workflow explains how Codex should use the living planning docs when the user assigns work.

`docs/TASKS.md` is the active backlog and can recommend the next task, but it is guidance, not a hard lock.

## User Task Takes Priority

If the user assigns a task different from the Recommended next task in `docs/TASKS.md`, follow the user's assigned task.

Do not ignore the user's task just because `docs/TASKS.md` recommends another next step.

## Planning Impact Check

Before implementing a task that differs from the current Recommended next task, decide whether the task changes any of these:

- current priority
- current phase
- active backlog
- blocked or deferred tasks
- durable architecture, product, workflow, or safety decisions

If it does, update the relevant planning docs in the same commit:

- `docs/TASKS.md`
- `docs/ROADMAP.md`
- `docs/DECISIONS.md`

If the task is an independent small task that does not affect priority, phase, backlog, or durable decisions, no roadmap or backlog update is required.

## Avoid Over-updating

Do not update planning docs for trivial implementation details, narrow bug fixes, formatting-only changes, or small follow-up fixes unless they materially change project direction or task order.

Examples that usually do not need planning doc updates:

- a local bug fix inside one screen
- adding a narrow regression test
- formatting or lint cleanup
- a small UI safety fix that was already listed in the backlog

Examples that usually need planning doc updates:

- changing the recommended next task
- starting a new phase
- moving a task from deferred to active
- adding or removing a migration step
- approving a new dependency or architecture direction
- changing Git, QA, UI safety, or release workflow rules

## Standard Task Result Report

At the end of every completed or blocked task, return a concise report using this format.

```markdown
## Task Result

Status: `DONE_COMMITTED` | `DONE_NOT_COMMITTED` | `BLOCKED`

Summary:
- One to three bullets describing what changed or why the task is blocked.

Files changed:
- List task-related files changed.
- If no files changed, say so.

Verification:
- List commands run and result.
- Use `passed`, `failed`, `skipped`, or `not run`.
- If a command was skipped, explain why briefly.

Commit / Push:
- Commit: `<hash>` or `none`
- Message: `<commit message>` or `none`
- Pushed branch: `<remote/branch>` or `none`

Planning docs:
- Updated: `yes` / `no`
- Files: list docs updated, or `none`
- Reason: explain if docs were updated or why no update was needed.

Unverified areas:
- List anything not verified, such as emulator/device visual review, release build, manual login flow, etc.
- If none, say `none`.

Recommended next task:
- Task: one concrete next task.
- Why: one sentence.
- Suggested scope: one to three bullets.
- Note: advisory; user may assign a different task.
```

Keep the report short. Do not paste full command logs unless a failure needs diagnosis.

## Planning Docs Reporting

The `Planning docs` section must say whether planning docs were updated.

If planning docs were not updated, briefly state why they were not needed.

If the task changes priority, phase, backlog, or durable decisions, update the relevant docs in the same commit:

- `docs/TASKS.md`
- `docs/ROADMAP.md`
- `docs/DECISIONS.md`

Do not over-update planning docs for trivial changes.

## Recommended Next Task

Every task result must include one advisory recommended next task.

Use `docs/TASKS.md` as the first source for a concrete next task. If the user later assigns a different task, follow the user task and apply the planning impact check above.

If there is no clear actionable next task in `docs/TASKS.md`, do not invent implementation work. Recommend planning, audit, grooming, or review work instead.

Preferred fallback recommendations, in order:

1. Roadmap/backlog grooming.
2. Break down the next roadmap phase.
3. Codebase health audit.
4. Test coverage expansion.
5. Emulator/device UI smoke review.
6. Dependency/toolchain audit.
7. Release readiness check.

The recommendation is advisory only and must not start implementation until the user assigns it.

## Verification

Use the verification gate for the actual change type from:

- `docs/qa/IW_GIT_WORKFLOW.md`

Docs-only workflow updates require:

```powershell
git diff --check
```
