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

## Reporting

At the end of each task, report whether planning docs were updated.

If planning docs were not updated, briefly state why they were not needed.

## Verification

Use the verification gate for the actual change type from:

- `docs/qa/IW_GIT_WORKFLOW.md`

Docs-only workflow updates require:

```powershell
git diff --check
```
