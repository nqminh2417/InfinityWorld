# AGENTS.md — InfinityWorld

## Project rules

InfinityWorld is an Android-first, iOS-ready Flutter app. Keep changes scoped, preserve existing behavior and compatibility, avoid speculative architecture or dependencies, and follow repository conventions. Explicit user task scope takes priority over advisory backlog recommendations.

Use these sources of truth; read only what is relevant to the assigned task:

- Product direction and current boundaries: `docs/project-direction.md`
- Target architecture, state, routing, networking, storage, and feature boundaries: `docs/architecture.md`
- Visual direction, themes, typography, and components: `docs/design-system.md`
- Current phase and product backlog: `docs/roadmap.md` and `docs/tasks.md`
- Durable decisions and deferrals: `docs/decisions.md`
- Task-specific minimum reading sets and document ownership: `docs/harness/DOCUMENTATION_GOVERNANCE_PLAN.md`

For architecture, routing, theme, or feature-structure decisions, consult the product direction, architecture, design-system, and roadmap docs above. If an expected source is missing, follow extant decisions and report the gap rather than inventing conflicting policy.

Treat architecture documentation as target direction, not a claim that every migration is complete. `docs/tasks.md` owns product `T...` tasks; `docs/harness/` owns Harness `H...` tasks.

## Scope and implementation

- Change only what the assigned task requires. Do not broaden scope, rewrite architecture, or perform unrelated cleanup.
- Use existing components, tokens, state, routing, and service patterns before adding new ones. Do not add packages or persistent schemas without a concrete requirement.
- Keep Android primary and iOS compatibility in view; do not optimize for web or desktop unless assigned.
- Preserve local-first startup/profile behavior and existing route, storage, and network contracts. The canonical product and architecture docs define their details.
- For current risks and deferred work, consult `docs/tasks.md` and `docs/architecture.md`; do not turn a narrow task into a general stabilization pass.

## Project-local skills

Apply the matching tracked skill by its task trigger. These skills add InfinityWorld-specific constraints; they do not replace the canonical design or QA documents.

| Skill | Use for |
| --- | --- |
| `.agents/skills/flutter-app-size/SKILL.md` | Measuring or reducing Flutter artifact and packaging size. |
| `.agents/skills/flutter-performance/SKILL.md` | Measuring startup, frame, rendering, scrolling, memory, or async performance. |
| `.agents/skills/flutter-runtime-safety/SKILL.md` | Async lifecycle, failure states, network/configuration, retries, cancellation, or concurrency. |
| `.agents/skills/flutter-testing/SKILL.md` | Adding, fixing, reviewing, or selecting Flutter/Dart regression tests. |
| `.agents/skills/flutter-ui-safety/SKILL.md` | Forms, feedback, screens, navigation, accessibility, insets, overflow, or responsive layout. |

For UI changes also follow `docs/design/layout-safety.md` and `docs/design/system-ui-policy.md`. Do not claim visual safety from analysis alone; report runtime checks and unverified cases under the QA workflow.

## Tools and verification

Repository files and native Git/Flutter/Dart results are authoritative. Skills, plugins, MCP tools, hooks, and Repomix are optional aids; they do not override scope, source, tests, or required gates. Do not copy, install, edit, or reconfigure global Codex capabilities from this repository task.

- Use CodeGraph for dependency/call-path questions when the repository index is available; otherwise use `rg`, direct inspection, analyzer output, and tests.
- Use version-sensitive documentation helpers only when needed; otherwise consult official docs and the checked-in project version.
- Use plugins only when their capability matches the task. Retry an optional helper once only for a safe transient failure; otherwise use repository inspection and native commands. Report uncertainty only when the fallback cannot establish the needed fact.
- Repomix may provide broad repository context, but its output is supporting evidence; do not regenerate it for a small task.
- Hooks are not relied on for verification, formatting, staging, commits, pushes, or documentation updates. Future hooks require separate approval and must not format the whole repository or change/stage files, commit, push, or rewrite planning docs automatically.

Follow `docs/qa/git-workflow.md` for branch/status preflight, risk-based gates, diff review, and commit/push authority. Native Flutter, Dart, and Git commands are the completion authority. Commit or push only with task-specific authorization and after required gates, scoped review, and branch/upstream checks pass. Do not stage unrelated work or use destructive Git operations.

## Documentation and reporting

Follow `docs/qa/task-workflow.md` for planning impact, task logging, the final report, and the advisory next task. Update planning documents only when priority, phase, backlog, or a durable decision changes. Use the task workflow’s ownership map; do not duplicate task state across product and Harness tracks.
