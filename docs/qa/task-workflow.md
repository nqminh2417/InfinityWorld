# Infinity World Task Workflow

## Purpose

This workflow explains how Codex should use the living planning docs when the user assigns work.

`docs/tasks.md` is the active backlog and can recommend the next task, but it is guidance, not a hard lock.

## User Task Takes Priority

If the user assigns a task different from the Recommended next task in `docs/tasks.md`, follow the user's assigned task.

Do not ignore the user's task just because `docs/tasks.md` recommends another next step.

## Planning Impact Check

Before implementing a task that differs from the current Recommended next task, decide whether the task changes any of these:

- current priority
- current phase
- active backlog
- blocked or deferred tasks
- durable architecture, product, workflow, or safety decisions

If it does, update the relevant planning docs in the same commit:

- `docs/tasks.md`
- `docs/roadmap.md`
- `docs/decisions.md`

If the task is an independent small task that does not affect priority, phase, backlog, or durable decisions, no roadmap or backlog update is required.

## Avoid Over-updating

Do not update planning docs for trivial implementation details, narrow bug fixes, formatting-only changes, or small follow-up fixes unless they materially change project direction, phase, or task order.

Keep detailed planning state in `docs/tasks.md`. Do not expand final chat output with alternative task lists, deferred work, or phase rationale.

## Roadmap Update Policy

Do not update `docs/roadmap.md` for every small task.

Update `docs/roadmap.md` only when:

- a phase starts
- a phase completes
- phase scope changes
- architecture direction changes
- a checkpoint materially changes the roadmap

For normal feature placement, small UI fixes, narrow tests, and local bug fixes, update `docs/tasks.md` only when the active backlog or primary recommendation changes.

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

## Task Granularity Policy

Apply project safety skills and checklists by default, but do not split every checklist item into a separate task.

Bundle related changes into one task when they share:

- one goal
- one feature or screen
- one risk profile
- one verification path

Split work into separate tasks only when the work has meaningfully different risk, such as:

- API or network behavior
- model parsing or data validation
- route ownership
- UI layout safety
- dependency or toolchain changes
- architecture migration
- state management migration

Default sizing:

- Simple/static screen: one placement task is usually enough.
- Medium screen: one task is preferred; split only if layout, state, or routing risk is concrete.
- API/live-network screen: two to three tasks may be justified.
- Four or more tasks for one screen require an explicit reason in `docs/tasks.md`.

UI layout-safety:

- Treat UI layout-safety as a checklist inside the current task unless there is concrete layout risk.
- Make a UI layout-safety pass the Primary next task only when concrete risk is observed or the user explicitly asks for it.
- Concrete layout risks include overflow risk, unsafe keyboard/inset handling, fixed-height layout, unsafe `Column`/`Expanded` composition, or user-facing visual risk.
- Do not redesign UI during a layout-safety task unless the user explicitly approves redesign scope.

Follow-up tasks:

- Do not create follow-up tasks automatically after every move.
- Create follow-up tasks only when there is a concrete risk, failed gate, blocker, missing test seam, or user-approved remaining scope.
- Safety skills/checklists still apply; they just do not automatically become separate tasks.
- Do not use one multi-step feature sequence as the default template for every screen.

## Standard Task Result Report

At the end of every completed or blocked task, return a compact report using this format.

```markdown
## Task Result

Status: `DONE_COMMITTED` | `DONE_NOT_COMMITTED` | `BLOCKED`

Current phase:
- Phase N — <phase name>

Summary:
- <short bullet>
- <short bullet>
- <short bullet>

Files changed:
- `<repo-relative-path>`
- `<repo-relative-path>`

Verification:
- Git branch/status gates: passed
- `<command>`: passed | failed | skipped | not run

Commit / Push:
- Commit: `<short-sha>` or `none`
- Branch: `<remote/branch>` or `none`

Unverified:
- <item>
- <item>

Recommended next work:
- Primary: <Task ID> — <task title>
- Phase: Phase N — <phase name>
- Planning details: see `docs/tasks.md` for alternatives, deferred work, and phase guard.

Skipped:
- <optional skipped work, if any>
```

Keep the report short. Do not paste full command logs unless a failure needs diagnosis.

## Recommended Next Work

Every task result must include exactly one advisory primary next task and the phase that task belongs to.

Use the `Recommended Next Work` section in `docs/tasks.md` as the source of truth. If the user later assigns a different task, follow the user task and apply the planning impact check above.

`docs/tasks.md` must keep this structure:

- Current phase
- Primary recommendation with exactly one next task
- Alternatives with 2-3 optional tasks maximum, each with a short "choose this if..." explanation
- Do not start yet
- Phase guard

Do not duplicate the alternatives, deferred work, or phase guard in final chat output. Link to `docs/tasks.md` instead.

If there is no clear actionable next task in `docs/tasks.md`, do not invent implementation work. Recommend planning, audit, grooming, or review work instead.

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

- `docs/qa/git-workflow.md`

Docs-only workflow updates require:

```powershell
git diff --check
```
