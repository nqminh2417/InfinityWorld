# Infinity World Task Workflow

## Purpose

This workflow explains how Codex should use the living planning docs when the user assigns work.

`docs/tasks.md` is the active backlog and can recommend the next task, but it is guidance, not a hard lock.

## User Task Takes Priority

If the user assigns a task different from the Recommended next task in `docs/tasks.md`, follow the user's assigned task.

Do not ignore the user's task just because `docs/tasks.md` recommends another next step.

## Canonical Task Lifecycle

Use this minimal flow: **Receive task → resolve scope → inspect relevant code/docs → implement minimally → run required gates → review status/diff → update warranted docs → commit/push if authorized → return concise summary.**

| Stage | Requirement and evidence | Exception or failure behavior |
| --- | --- | --- |
| Resolve scope | Required. Classify the task as product (`T`), Harness (`H`), or user-directed unnumbered work; identify allowed files and change risk. | Analysis/planning and docs-only work skip implementation, not scope resolution. User scope overrides an advisory backlog item. |
| Inspect before editing | Required. Check branch/status and read relevant instructions plus live affected code/docs. | Docs-only tasks need not inspect unrelated application code; unresolved same-file user changes block that file. |
| Implement minimally | Required only for a change task. Preserve unrelated work and avoid opportunistic refactors or global configuration changes. | Analysis-only tasks record findings without edits. |
| Verify and review | Required for the actual risk under `docs/qa/git-workflow.md`, followed by focused diff/status review. | A required new failure blocks completion; a skipped required gate leaves the task partially completed or blocked. |
| Update durable docs | Required only when the change affects the ownership map below. | Do not update planning/docs for trivial local implementation detail. |
| Commit and push | Optional and governed solely by `docs/qa/git-workflow.md`. | Do not commit merely because a repository rule normally permits it. |
| Report | Required. Use the standard result below with observed evidence and one advisory next task. | State `Blocked` or `Partially completed` rather than implying completion. |

## Planning Impact Check

Before implementing a task that differs from the current Recommended next task, decide whether the task changes any of these:

- current priority
- current phase
- active backlog
- blocked or deferred tasks
- durable architecture, product, workflow, or safety decisions

If it does, update the relevant planning docs in the same coherent task or approved commit boundary:

- `docs/tasks.md`
- `docs/roadmap.md`
- `docs/decisions.md`

If the task is an independent small task that does not affect priority, phase, backlog, or durable decisions, no roadmap or backlog update is required.

## Avoid Over-updating

Do not update planning docs for trivial implementation details, narrow bug fixes, formatting-only changes, or small follow-up fixes unless they materially change project direction, phase, or task order.

Keep detailed planning state in `docs/tasks.md`. Do not expand final chat output with alternative task lists, deferred work, or phase rationale.

## Documentation Ownership and Task Logging

- `docs/tasks.md` owns the active product backlog, product task status, and advisory product recommendation.
- `docs/harness/` owns Harness task evidence and planning; it does not silently alter product backlog entries.
- `docs/roadmap.md` records phase-level history/status and major direction changes.
- `docs/decisions.md` records durable decisions, not routine task events.
- Git commits provide implementation history; `docs/ai/task-log.md` is reserved for exceptional reusable handoff notes only.

Do not create a redundant per-task log. Update the appropriate owner only when a task changes architecture/durable behavior, workflow/verification, product direction, roadmap/backlog/task status, a reusable decision/constraint, or migration state.

## Task Numbering

- `T...` IDs identify product/application tasks in `docs/tasks.md`.
- `H...` IDs identify Harness Engineering work in `docs/harness/`.
- Do not renumber completed or deferred work, and do not let Harness work replace product backlog entries without an explicit planning decision.
- The current state is: product work is paused after `T120` and `T121` remains deferred. Refer to the active planning documents for transient Harness phase/task status rather than duplicating it in this lifecycle policy.
- A recommended next task must identify its track and is advisory only.

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

At the end of every completed, partially completed, or blocked task, return a compact report using this format.

```markdown
## Task Result

Task: `<ID or assigned title>`

Status: `Completed` | `Completed with documented pre-existing limitation` | `Partially completed` | `Blocked`

Current phase:
- Phase N — <phase name>

What changed:
- <short bullet>
- <short bullet>
- <short bullet>

Files changed:
- `<repo-relative-path>`
- `<repo-relative-path>`

Docs updated: `<paths>` | `none`

Verification:
- Git branch/status gates: passed
- `<command>`: passed | failed | skipped | not run

Commit / Push:
- Commit: `<short-sha and message>` or `not created`
- Push: `<remote/branch and result>` or `not performed`

Risks / deferred:
- <item>
- <item>

Recommended next task:
- Primary: <Task ID> — <task title>
- Phase: Phase N — <phase name>
- Track: Product | Harness
- Planning details: see `docs/tasks.md` or `docs/harness/` for the active track.
```

Keep the report short. Harness tasks normally need about 8-12 short bullets. Do not paste full command logs, internal tool markers, staging directives, or implementation scratch notes into the user-facing report unless a failure needs diagnosis.

## Recommended Next Work

Every task result must include exactly one advisory primary next task and the phase/track that task belongs to.

Use the active track's source of truth: `docs/tasks.md` for product work and `docs/harness/` for Harness work. If the user later assigns a different task, follow the user task and apply the planning impact check above.

When product work is active, `docs/tasks.md` must keep this structure:

- Current phase
- Primary recommendation with exactly one next task
- Alternatives with 2-3 optional tasks maximum, each with a short "choose this if..." explanation
- Do not start yet
- Phase guard

Do not duplicate the alternatives, deferred work, or phase guard in final chat output. Link to `docs/tasks.md` instead.

If there is no clear actionable next task in the active track, do not invent implementation work. Recommend in this order:

1. Validate the current phase is complete.
2. Groom or split the backlog.
3. Review deferred work.
4. Propose a discovery or audit task.
5. Clearly state that no implementation task is currently approved.

The recommendation is advisory only and must not start implementation until the user assigns it.

## Verification

Use the verification gate for the actual change type from:

- `docs/qa/git-workflow.md`

Report each required command and outcome, focused Git diff/status review, and any manual evidence. For manual UI/runtime checks, name the device/emulator or viewport, route/flow, theme when relevant, and observed result. A skipped required gate or unavailable runtime check must remain in `Risks / deferred`; only a proven unchanged, unrelated baseline failure may be labelled pre-existing. A task is not `Completed` when a required gate was skipped or failed.

Mention a Skill, plugin, MCP helper, or hook only when it materially affected the work or its confidence (for example, `CodeGraph unavailable; verified imports with repository search and tests`). Do not include internal traces, configuration dumps, or helper output as completion proof.
