# Agent Rules

These rules keep agent work scoped, documented only when useful, and easy to verify.

## Documentation Update Policy

- Update docs only when the task creates reusable knowledge, a durable decision, a new constraint, or a confirmed regression risk.
- Do not update docs for trivial implementation changes.
- Living docs: `decisions.md`, `tasks.md`, `ai/task-log.md`, `design/layout-safety.md`, `design/system-ui-policy.md`, `qa/regression-checklist.md`.
- Do not modify `architecture.md`, `design-system.md`, `project-direction.md`, `roadmap.md`, workflow docs, or agent rules unless explicitly requested.
- Final output must include `Docs updated: ...` or `Docs updated: none`.

## Scope

- Follow the user task first.
- Keep changes small and focused.
- Do not modify Flutter source during docs-only tasks.
- Update references when docs are renamed or moved.

## Verification

- Run the narrowest useful gate from `qa/git-workflow.md`.
- For docs-only changes, run `git diff --check`.
- Report commands actually run and any unverified areas.
