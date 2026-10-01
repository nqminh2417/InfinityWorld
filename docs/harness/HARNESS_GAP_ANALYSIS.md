# InfinityWorld Harness Gap Analysis

- **Phase / task:** Phase 1 — H5 Harness Gap Analysis
- **Status:** Completed
- **Last updated:** 2026-07-18
- **Scope:** Planning evidence only. This file does not authorize documentation moves, automation, source restructuring, or global-tool changes.

## Current Harness Baseline

- **Confirmed:** Phase 0 provides a current-state baseline in `docs/discovery/CODEBASE_DISCOVERY.md`. It found a single Flutter app, 147 passing tests, a known formatter drift in `lib/core/config/constants.dart`, and no repository CI, scripts, custom hooks, or device automation.
- **Confirmed:** Existing documentation already covers product direction, target architecture, design, roadmap, active tasks, decisions, QA gates, task workflow, and agent guidance. `docs/README.md` is the visible index. Evidence: `docs/README.md`; `docs/qa/`; `docs/ai/`.
- **Confirmed:** Current-state claims drift across docs: root `README.md` says Phase 9 and defers Reader/bookmark persistence, while `docs/tasks.md` names Phase 10 and records implemented Reader bookmark behavior. `docs/roadmap.md` still labels Phase 10 as kickoff next. Evidence: `README.md` `Current App State` / `Known Deferrals`; `docs/tasks.md` `Current Status` / `Phase guard`; `docs/roadmap.md` `Phase 10`.
- **Confirmed:** Workflow rules are useful but repeated. `docs/qa/git-workflow.md` defines gates/commit rules, `docs/qa/task-workflow.md` defines planning and final reporting, while `AGENTS.md`, `README.md`, `docs/tasks.md`, `docs/decisions.md`, and `docs/ai/` repeat selected parts.
- **Confirmed:** Repository rules allow scoped commit/push after gates on `home/devbyMinh-current`; the global `C:\Users\quang\.codex\AGENTS.md` default requires an explicit user request. The user assignment is already documented as taking priority over the backlog, but a durable precedence rule is absent. Evidence: repository `AGENTS.md` section 22; `docs/qa/git-workflow.md`; global AGENTS Git policy; `docs/qa/task-workflow.md`.
- **Confirmed:** Skills, plugins, MCP servers, and hooks are global capabilities. Their configuration/execution is not a repository asset; native Git and Flutter commands are the proven local verification authority. Evidence: Phase 0 sections 12–13; repository `AGENTS.md` tool routing.

## Target Harness Outcomes

1. One short, explicit ownership map: index, current product state, target direction, active backlog, durable decisions, workflow rules, and historical archive each have a distinct role.
2. One documented rule-precedence order that preserves user assignment authority and does not copy global configuration into the repository.
3. One canonical verification-gate source with concise references elsewhere; formatter drift is handled by a separate scoped decision/task, not hidden or waived globally.
4. One compact task lifecycle: planning impact, documentation/logging conditions, final report, and commit/push authority agree without requiring a script or hook.
5. Documentation moves are reference-safe, and any later code restructure is limited to a pilot only after the prerequisites below are met.

## Gap Matrix

| Area | Current evidence and problem | Desired outcome / minimal change | Likely files affected | References to check or synchronize | Priority | Risk | Planned task |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Documentation ownership | `docs/README.md` indexes the docs, but `README.md`, roadmap, tasks, decisions, QA, AI docs, and `AGENTS.md` overlap. Current-state claims have drifted. | Assign a single role to each existing document; make the index point to those roles rather than duplicate details. | H6: one new `docs/harness/DOCUMENTATION_SOURCE_OF_TRUTH.md`; H7: existing docs only, exact set decided by H6. | `docs/README.md`; root `README.md`; `AGENTS.md`; core docs and QA/AI links. | High | Medium | H6, H7 |
| Duplication, drift, and archive handling | Root README is stale against Phase 10/Reader code; roadmap Phase 10 is stale; `archive/phase2-migration-map.md` is explicitly historical but still indexed and named in tasks. | Label historical versus current documents; retain archives until H7 verifies inbound references. Do not delete, silently rewrite history, or create a parallel handbook. | H6 governance map; H7 index/current-doc annotations and only approved archival link updates. | Archive inbound references: `docs/README.md` and `docs/tasks.md`; feature-plan links in `docs/README.md`. | High | Medium | H6, H7 |
| Instruction precedence | User task, repository `AGENTS.md`, workflow docs, and global defaults overlap; commit authority differs between repository and global guidance. | Define a repository-local precedence and conflict/escalation rule; link to global defaults without copying them. | H6 governance map; H9 repository `AGENTS.md`, `docs/qa/task-workflow.md`, `docs/qa/git-workflow.md`, and only necessary derived references. | `AGENTS.md` sections 2, 22–24; global `C:\Users\quang\.codex\AGENTS.md`; `docs/qa/`; `docs/ai/`. | High | High | H6, H9 |
| Verification gates | Gates are documented in `docs/qa/git-workflow.md` but repeated in README, tasks, roadmap, and AGENTS; no script/CI enforces them. | Keep `docs/qa/git-workflow.md` canonical, reduce other files to links/short references, and define gate selection by change risk. | H8: `docs/qa/git-workflow.md`; dependent references selected from `AGENTS.md`, `README.md`, `docs/tasks.md`, `docs/roadmap.md`. | All gate copies, plus `docs/qa/regression-checklist.md` and `docs/qa/ui-review-checklist.md`. | High | Medium | H8 |
| Formatter baseline | Whole-repository check reports only pre-existing `lib/core/config/constants.dart` drift; change-type workflow formats changed Dart files. | Record the distinction and decide the remediation gate. Do not alter source or introduce a permanent formatter exception in policy. | H8 policy only; a later separately assigned source-format task, if approved. | Phase 0 validation record; `docs/qa/git-workflow.md`; `docs/tasks.md` verification summary; `AGENTS.md` section 16. | Medium | Low | H8 |
| Task lifecycle and final response | `docs/qa/task-workflow.md` is detailed; `docs/ai/codex-output-format.md` and `docs/ai/agent-rules.md` add overlapping report/docs lines; `AGENTS.md` repeats result requirements. | Preserve one canonical result template and one minimal docs-only addition; convert duplicates to references where appropriate. | H9: `docs/qa/task-workflow.md`, `docs/ai/codex-output-format.md`, `docs/ai/agent-rules.md`, and relevant `AGENTS.md` text. | Inbound link from `docs/ai/codex-output-format.md` to task workflow; AGENTS section 24; `docs/README.md` index. | High | Medium | H9 |
| Commit and push authority | Repository workflow says commit/push after gates; global default says only after explicit user request. Discovery tasks demonstrated task-specific exceptions. | State when user task instructions override repository defaults, when commit/push is permitted, and when intermediate work must remain uncommitted. | H9: canonical Git/task workflow plus derived decision/reference only if H6 identifies a need. | `docs/qa/git-workflow.md`; `docs/decisions.md`; `docs/tasks.md`; `AGENTS.md`; global AGENTS. | High | High | H9 |
| Task logging and roadmap updates | Tasks, roadmap, decisions, and an empty task log coexist; current rules say updates are conditional, but the event-to-document mapping remains dispersed. | Define a small event map: active work in tasks, phase/direction in roadmap, durable decisions in decisions, exceptional reusable handoff notes in task log. | H9: `docs/qa/task-workflow.md`, `docs/ai/agent-rules.md`, and relevant index/decision references. | `docs/tasks.md`; `docs/roadmap.md`; `docs/decisions.md`; `docs/ai/task-log.md`; `docs/README.md`. | Medium | Medium | H9 |
| Product versus Harness IDs | Product tasks use `T` IDs in `docs/tasks.md`; Harness H1–H5 is user-directed and is not represented in that backlog. | Keep ID namespaces separate and record their ownership; do not inject Harness tasks into the product backlog. | H6 governance map; H9 task-workflow wording if required. | `docs/tasks.md` `Recommended Next Work`; H5/H6 Harness files; `docs/qa/task-workflow.md`. | Medium | Low | H6, H9 |
| Tools, skills, MCP, and hooks | Repository AGENTS has routing guidance; global configuration owns installations; CodeGraph execution was not reliable in H2. | State repo-local use, fallback, and authority rules only: native Git/Flutter commands required where applicable; tools optional helpers. | H10: repository `AGENTS.md`; optionally one cross-reference in `docs/harness/DOCUMENTATION_SOURCE_OF_TRUTH.md` if H6 assigns it. | Global AGENTS; repository `AGENTS.md` tool-routing section; no plugin/MCP/hook config files. | Medium | Low | H10 |
| Optional automation | No local CI, scripts, custom hooks, or task-log automation exists. | Keep automation optional and deferred; do not create scripts, CI, hooks, or local copies of global capabilities before manual policy is coherent. | None in H6–H10 unless a later user-approved task selects one coherent automation unit. | Phase 0 sections 10 and 12; `docs/qa/git-workflow.md`. | Medium | Medium | H8 |
| Restructure readiness | Phase 0 concludes only scoped pilots are appropriate; live routes and SharedPreferences keys need protection. | Record pilot prerequisites, but do not select, move, or refactor a code slice during H6–H10. | H6 governance map and H8/H9 policy references only. | `docs/discovery/CODEBASE_DISCOVERY.md` sections 16–20; `AGENTS.md`; route/persistence tests when a future pilot is assigned. | High | High | H6–H10 |

### Known reference inventory for future documentation work

| Target / potential change | Known inbound references | H7 handling requirement |
| --- | --- | --- |
| Core direction and planning docs | Root `README.md`; repository `AGENTS.md`; `docs/roadmap.md`; `docs/qa/task-workflow.md` (for tasks/roadmap/decisions). | Search path, filename, and heading across the repository before any rename/move; update links and text references in the same coherent change. |
| QA workflow docs | Repository `AGENTS.md`; root `README.md`; `docs/tasks.md`; `docs/roadmap.md`; `docs/decisions.md`; `docs/ai/codex-output-format.md`. | Preserve `docs/qa/task-workflow.md` relative links and update every canonical-workflow reference, not just Markdown links. |
| AI guidance docs | `docs/README.md` indexes all three; `docs/ai/codex-output-format.md` links to `../qa/task-workflow.md`. | Keep the relative link valid; do not move a file merely because no direct path search finds every semantic use. |
| Archive and feature plans | `docs/README.md` indexes archive and feature plans; `docs/tasks.md` names the Phase 2 migration map. | Retain historical files and labels unless H7 confirms their role and updates these inbound references. |
| New Harness governance document | No inbound references before H6. | If H6 creates it, H7 must add only the necessary index/authority references; avoid a second overlapping Harness index. |

## Minimal Phase 1 Scope

- Establish documentation ownership and precedence before moving or consolidating anything.
- Use existing `docs/README.md`, QA workflows, AI guidance, planning docs, and repository `AGENTS.md` as the likely long-term homes; H6 may add one governance document because its ownership map has a unique durable responsibility.
- Keep verification manual and command-based. H8 may clarify gates and formatter handling, but must not create scripts, CI, hooks, or formatter exemptions.
- Keep product `T` IDs and Harness `H` IDs separate. The product backlog remains `docs/tasks.md`.
- Treat any code restructure as out of scope until documentation references, gate ownership, lifecycle authority, and staged-file rules are coherent. A future pilot must retain route tests, preference-key compatibility, focused diff review, and applicable device/UI checks.

## Deferred or Rejected Work

- **Rejected for Phase 1:** new repository scripts, CI workflows, pre-commit hooks, task-log automation, or MCP-dependent gates. Existing native Flutter/Git commands are enough authority for policy work.
- **Rejected for Phase 1:** repository-local copies of global skills, plugins, MCP configuration, hook definitions, or global instructions.
- **Deferred:** formatting `lib/core/config/constants.dart`; it requires a separately assigned source-only task after H8 defines the intended baseline.
- **Deferred:** application directory moves, route/shell changes, persistence migrations, Android toolchain/signing work, and deletion of legacy-named folders or direct routes.
- **Deferred:** broad rewrite of product-direction, architecture, design, roadmap, or decision history. H7 should correct proven current-state drift and link ownership, not erase historical records.

## Recommended H6–H10 Sequence

| Task | Objective | Expected files / new files | Commit and push | Dependencies |
| --- | --- | --- | --- | --- |
| **H6 — Documentation Source of Truth Plan** | Define current, target, workflow, planning, decision, archive, and Harness ownership; define instruction precedence and ID namespaces. | Create only `docs/harness/DOCUMENTATION_SOURCE_OF_TRUTH.md`; no existing-document edits. | **No commit or push.** It is an input to H7/H9 and would be incomplete alone. | H5 |
| **H7 — Documentation Restructure** | Apply the approved ownership map with the smallest needed current-state corrections, archive labels, index updates, and reference synchronization. | Existing documents selected by H6, expected to include `docs/README.md` and possibly root `README.md`, planning/current-state docs, and references. Create no additional file by default. | **Commit and push** after every affected inbound reference is checked, Markdown links resolve, and `git diff --check` passes. | H6 |
| **H8 — Verification Gates** | Make `docs/qa/git-workflow.md` the concise canonical gate matrix; synchronize only derived gate references and record the formatter baseline decision. | `docs/qa/git-workflow.md` plus only necessary references in `AGENTS.md`, `README.md`, `docs/tasks.md`, or `docs/roadmap.md`. No script/CI/hook file. | **Commit and push** only if all policy/reference edits form one coherent working unit; otherwise leave the compatible intermediate state for the user-directed follow-up. | H6; H7 if paths/roles change |
| **H9 — Task Lifecycle and Git Policy** | Resolve final-report, planning/logging, staged-file, and commit/push authority without duplicating global defaults. | `docs/qa/task-workflow.md`, `docs/qa/git-workflow.md`, `docs/ai/agent-rules.md`, `docs/ai/codex-output-format.md`, `docs/decisions.md`, and `AGENTS.md` only where H6/H8 require synchronization. No new file. | **Commit and push** if lifecycle/Git policy is internally consistent and all referenced sources agree. | H6, H7, H8 |
| **H10 — Repo-local Tool Usage Policy** | Reduce tool routing to repository-local use/fallback/authority rules; make native commands primary and global capabilities optional. | `AGENTS.md` and, only if needed, a reference in `docs/harness/DOCUMENTATION_SOURCE_OF_TRUTH.md`. No global configuration and no new repo-local tool file. | **Commit and push** after repo-local rules and references are synchronized. | H6; H9 for precedence wording |

Do not force a commit merely because a task number ends. H6 remains uncommitted by design; later tasks commit only when their documented state is coherent and complete.

## H14 — Project-local Harness Hardening Audit

- **Scope/evidence:** Audited repository-local files and references only; no global Codex path or configuration was inspected or changed. Current Harness position is post-HM1 maintenance; product work is in Phase 10 at T129. Only this gap analysis is changed by H14.

### Current project-local Harness inventory

| Path | Current state | Disposition |
| --- | --- | --- |
| `AGENTS.md` | At the H14 baseline, tracked with 24 numbered sections; repository instruction entry point and links to active workflow/design guidance. | Keep; simplify duplicated detail in H15. |
| `.agents/skills/` | Five tracked project policy skills: app size, performance, runtime safety, testing, and UI safety. | Keep all five; selectively simplify overlaps in H15. |
| `.codex/` | Directory exists but contains no files; no project `config.toml` or other local Codex settings. | Keep empty; no project config is currently needed. |
| `.gitignore`, platform `.gitignore` files, `.repomixignore`, `repomix.config.json` | Root and Android/iOS/Linux/macOS/Windows ignore rules are tracked. Repomix config is repository-local; generated XML and CodeGraph cache paths are ignored. | Keep; no missing generated-artifact rule was found. |
| `docs/harness/HARNESS_GAP_ANALYSIS.md`, `DOCUMENTATION_GOVERNANCE_PLAN.md` | H5 evidence and H6 governance plan, both indexed by `docs/README.md`. | Keep as history/planning evidence; H14 appends the current audit here. |

### Custom skills findings

Each skill has a focused `description` trigger. The current routing reference is the `Project-local skills` section in `AGENTS.md`; `docs/decisions.md` and `docs/ai/task-log.md` record the five-skill inventory and ownership. The section numbers in the following recommendations describe the pre-H15 AGENTS layout. No skill is unreferenced or empty.

| Skill | Purpose / trigger | Project-specific and overlap | Recommendation | Inbound references / risk / follow-up |
| --- | --- | --- | --- | --- |
| `.agents/skills/flutter-app-size/SKILL.md` | Measured Flutter artifact, dependency, asset, font, and packaging size work. | Project-specific size tradeoffs; generic build mechanics are explicitly delegated. Some overlap with the former AGENTS app-size rules, but the skill adds measurement and diagnosis. | **Keep.** | `AGENTS.md` `Project-local skills` section and `docs/decisions.md`; low risk. No separate task. |
| `.agents/skills/flutter-performance/SKILL.md` | Measured startup, rendering, rebuild, scrolling, memory, async, or animation performance work. | Project-specific measurement and lifecycle guardrails; overlapped former AGENTS §13 performance rules. | **Keep but simplify** repeated general UI/performance rules while preserving measurement and profiling guidance. | `AGENTS.md` `Project-local skills` section and `docs/decisions.md`; low risk if its focused measurement trigger stays explicit. H15. |
| `.agents/skills/flutter-runtime-safety/SKILL.md` | Async lifecycle, errors, networking/configuration, retries, cancellation, or concurrency changes. | Strong project safety policy; overlapped former AGENTS §§10, 21.1 and the UI skill. Its boundary/failure detail remains useful. | **Keep but simplify** only repeated generic guidance; preserve async ownership, failure distinctions, and recovery constraints. | `AGENTS.md` `Project-local skills` section and `docs/decisions.md`; medium risk if failure behavior is lost. H15. |
| `.agents/skills/flutter-testing/SKILL.md` | Adding, fixing, reviewing, or running Flutter/Dart tests and selecting regression coverage. | Project-specific deterministic-test and existing-convention rules; overlaps QA gate and task workflow for command selection/reporting. | **Keep but simplify** verification wording already owned by `docs/qa/git-workflow.md`; retain test-quality policy. | `AGENTS.md` `Project-local skills` section and `docs/decisions.md`; low risk. H15. |
| `.agents/skills/flutter-ui-safety/SKILL.md` | UI feedback, forms, screens, navigation, responsive layout, accessibility, insets, overflow, and visible failures. | Project-specific layout/feedback constraints; substantial overlap with former AGENTS §§21–21.1 and `docs/design/layout-safety.md` / `system-ui-policy.md`. Skill adds useful accessibility and runtime review prompts. | **Keep but simplify** by making the design documents the detailed policy owners and retaining the skill trigger plus concise review checklist. | `AGENTS.md` `Project-local skills` section; `docs/design/layout-safety.md`; `docs/decisions.md`; medium risk if accessibility/layout checks are removed. H15. |

No skill should be removed or merged: each has a distinct task trigger, and the local policy value is more specific than a generic Flutter mechanics tutorial. No content change is made to any skill in H14.

### `.codex/` findings

`.codex/` is empty and has no tracked files. No repository behavior, task, or documented requirement calls for project-specific Codex settings. Keep install choices, global skills/plugins/MCP/hooks, and machine/user preferences outside the repository; do not create `.codex/config.toml` speculatively. The empty directory needs no ignore rule. No `.codex` file is proposed for removal, so no reference synchronization is needed.

### `AGENTS.md` findings

`AGENTS.md` is not concise: its detailed product, architecture, design, performance, app-size, verification, UI-safety, error-feedback, documentation, and reporting rules repeat fuller owners in `docs/project-direction.md`, `docs/architecture.md`, `docs/design-system.md`, `docs/qa/git-workflow.md`, `docs/qa/task-workflow.md`, the design safety docs, and the five local skills. Its routing is useful and its referenced active files exist. Scope limits, native verification/fallback, branch and commit authority, planning ownership, and documentation routing are clear; no broken active path or completed Harness instruction was found.

| Path | Action | Reason | Inbound references | Risk | Suggested task |
| --- | --- | --- | --- | --- | --- |
| `AGENTS.md` | **Edit** | Retain concise project constraints and routing; replace repeated detailed policy with links to its canonical owner. Preserve explicit task scope, verification/Git authority, fallback, and documentation ownership. | `README.md`, `docs/roadmap.md`, `docs/decisions.md`, `docs/ai/task-log.md`, `docs/discovery/CODEBASE_DISCOVERY.md`, and both Harness docs contain path or policy references. Search exact path and heading before changing sections; keep those references valid. | Medium: over-compression could make project-specific boundaries hard to discover. | H15 |

### Ignore-file findings

Audited `.gitignore`, `.repomixignore`, and `android/.gitignore`, `ios/.gitignore`, `linux/.gitignore`, `macos/.gitignore`, `windows/.gitignore`. Root rules cover observed Flutter/Dart outputs, logs, local IDE files, CodeGraph cache, and Repomix XML; no ignored tracked file or unignored generated artifact appeared in Git status. `.agents/skills/` is intentionally tracked; `.codex/` has no files and should not be broadly ignored. `.repomixignore` repeats some `.gitignore` patterns, but serves Repomix input filtering and is not a stale Git ignore; the configured output path is intentionally excluded in both. Keep all ignore files unchanged; no follow-up task is justified.

### Repository hygiene findings

- No empty or unreferenced tracked Harness/Codex file was found. The empty `.codex/` directory is untracked filesystem state and has no cleanup value.
- `.agents/skills/` contains five non-empty, tracked skills. No duplicate/superseded instruction file or local Codex cache was found among tracked paths.
- `repomix-infinity-world.xml`, Flutter logs/build outputs, and `.codegraph/` are generated/local artifacts with ignore coverage. Repomix’s output path is referenced by `repomix.config.json` and both relevant ignore files; retain that coordinated setup.
- `docs/discovery/CODEBASE_DISCOVERY.md` records the earlier H1 state that `.agents/` and `.codex/` were empty. This is dated discovery evidence superseded by later skill migration, not a current inventory; retain it as history and do not edit it under H14’s exclusion.
- `docs/harness/DOCUMENTATION_GOVERNANCE_PLAN.md` ends its Phase 1 snapshot with “Next Harness task: H11”. Later roadmap/task evidence records H11–H13 complete. Keep that dated Phase 1 record as history; do not treat its old next-task line as current guidance or rewrite it just for this audit.

### Reference and dependency risks

- Before any future AGENTS section removal or rename, search `AGENTS.md`, headings, and referenced policy paths across the repository; its active entry-point role is also named in `README.md` and `docs/roadmap.md`.
- Skill names are referenced in `AGENTS.md`, `docs/decisions.md`, and design safety documentation. H15 should retain current names and triggers; any rename/removal would need those references and the dated task-log inventory synchronized. H14 recommends no rename or deletion.
- `.codex/` has no file references to migrate. `.repomixignore`, `repomix.config.json`, and `.gitignore` jointly refer to the Repomix output; do not remove or rename one piece without checking the other two.
- Historical discovery/Harness records contain old path and state descriptions by design. Keep them when current tracked configuration and active guidance already establish the live state.

### Minimal recommended implementation sequence

| Task | Objective | Files likely affected | Source code excluded | Commit/push after successful validation |
| --- | --- | --- | --- | --- |
| **H15 — Project-local Instruction Compaction** | Reduce duplication in `AGENTS.md` and simplify only the four skills identified above, preserving concise local triggers/policies and linking to canonical workflow/design documents. Do not add `.codex/config.toml`, change ignore rules, rename/remove skills, or rewrite historical discovery. Run full-repository reference searches, `git diff --check`, and focused Git review. | `AGENTS.md`; `.agents/skills/flutter-performance/SKILL.md`; `.agents/skills/flutter-runtime-safety/SKILL.md`; `.agents/skills/flutter-testing/SKILL.md`; `.agents/skills/flutter-ui-safety/SKILL.md`; update this file only if findings change. | Yes | **Allowed** only if the H15 assignment authorizes it, all scoped references and docs checks pass, and repository branch/upstream rules in `docs/qa/git-workflow.md` are satisfied. |

### H14/H15 Closeout

- **H14:** Completed — project-local Harness audit recorded above.
- **H15:** Completed — repository instructions and four overlapping skills were compacted; all five skill names and triggers remain unchanged.
- **Harness maintenance:** Closed. No H16+ task is justified by current evidence.
- **Product track:** Remains in Phase 10 at `T129`; no product task numbering changed.
