# InfinityWorld Documentation Governance Plan

- **Phase / task:** Phase 1 — H6 Documentation Source of Truth Plan
- **Status:** Completed
- **Last updated:** 2026-07-18
- **Scope:** Planning only. H7 may execute the listed documentation changes after reference synchronization; this plan does not move, rename, merge, archive, or delete files.

## Governance Principles

- Give each durable document one primary responsibility; link to the owner instead of copying rules.
- Prefer editing existing documents. This plan is the only new governance file because the source-of-truth map has no existing durable home.
- Treat current code and checked-in configuration as factual authority when descriptive documentation conflicts; preserve the conflicting text as history only when it has historical value.
- Keep product direction/target architecture separate from current state, active backlog, decisions, workflow, and archive material.
- Explicit user task scope overrides backlog recommendations. Repository-local rules supplement global defaults; they do not copy or reconfigure global skills, plugins, MCP servers, or hooks.
- Native Flutter and Git command outcomes are the verification authority. Skills and MCP tools are optional helpers.
- Every documentation move, merge, rename, archive, or deletion must update active inbound references in the same coherent H7 change. Frozen discovery/Harness records may retain historical path mentions.

## Current Documentation Inventory

| Path | Purpose / actual responsibility | State | Known inbound references | Proposed disposition |
| --- | --- | --- | --- | --- |
| `README.md` | Human-facing onboarding, quick start, current product snapshot, and documentation entry points. | Mixed; Phase 9 and Reader deferral text conflicts with current Phase 10/code. | Repository root entry point; no checked-in direct-path inbound reference found. | Retain and edit current snapshot/links in H7. |
| `AGENTS.md` | Repository operating rules, project constraints, skills routing, required reading, and task reporting. | Current but overlaps `docs/ai/agent-rules.md` and workflow summaries. | Repository instruction source; referenced by discovery/Harness records. | Retain and absorb unique agent-rule content in H7. |
| `docs/README.md` | Documentation index. | Current index, but it lists duplicate AI workflow files without role labels. | No active exact-path inbound reference found. | Retain and edit as the documentation map. |
| `docs/project-direction.md` | Long-lived product direction and early non-goals. | Current target direction. | `AGENTS.md`, root README, `docs/README.md`. | Retain unchanged. |
| `docs/architecture.md` | Target architecture and migration direction. | Current as target; not factual authority for current implementation. | `AGENTS.md`, root README, roadmap, `docs/README.md`. | Retain unchanged. |
| `docs/design-system.md` | Target visual/design-system direction. | Current target direction. | `AGENTS.md`, root README, roadmap, `docs/README.md`. | Retain unchanged. |
| `docs/roadmap.md` | Phase history, phase-level goals, and current high-level direction. | Mixed/stale: Phase 10 still says kickoff next while tasks/code have progressed. | `AGENTS.md`, root README, task workflow, `docs/README.md`. | Retain and edit the current-phase summary only in H7. |
| `docs/tasks.md` | Active product `T` backlog, current status, primary next work, and phase guard. | Current operational source, with one stale Reader no-bookmark statement. | `AGENTS.md`, root README, roadmap, task workflow, `docs/README.md`. | Retain and edit proven current-state drift in H7. |
| `docs/decisions.md` | Durable product, architecture, workflow, and safety decisions. | Current history/decision log; some entries intentionally describe completed migrations. | `AGENTS.md`, root README, roadmap, task workflow, `docs/README.md`. | Retain unchanged in H7; H9 may adjust workflow decisions if policy changes. |
| `docs/qa/git-workflow.md` | Canonical verification gates and Git/commit/push rules. | Current, but summaries are duplicated elsewhere. | `AGENTS.md`, root README, roadmap, tasks, decisions, task workflow. | Retain unchanged in H7; H8 owns gate-policy edits. |
| `docs/qa/task-workflow.md` | Canonical task lifecycle, planning impact, standard result, and next-work rules. | Current; overlaps `docs/ai/codex-output-format.md`. | `AGENTS.md`, root README, decisions, `docs/ai/codex-output-format.md`, `docs/README.md`. | Retain and receive the small merged docs-only report rule in H7. |
| `docs/qa/regression-checklist.md` | Reusable confirmed regression checks. | Current and narrowly scoped. | `docs/README.md`; referenced by task context where relevant. | Retain unchanged. |
| `docs/qa/ui-review-checklist.md` | Visual/layout review evidence checklist. | Current and narrowly scoped. | `docs/README.md`; supplements AGENTS UI rules. | Retain unchanged. |
| `docs/ai/agent-rules.md` | Documentation update/scope/verification rules. | Duplicate of repository AGENTS and QA workflow. | Active Markdown link in `docs/README.md`; historical plaintext mentions in Phase 0/H5. | Merge unique `Docs updated` rule into `AGENTS.md`, then delete in H7. |
| `docs/ai/codex-output-format.md` | Pointer to task workflow plus docs-only output line. | Duplicate of task workflow. | Active Markdown link in `docs/README.md`; historical plaintext mentions in Phase 0/H5. | Merge its unique docs-only line into task workflow, then delete in H7. |
| `docs/ai/task-log.md` | Rolling recent-work handoff context not suited to backlog/roadmap/decisions. | Current, unique role; activated by HM1 with an initial entry. | `docs/README.md`; `AGENTS.md`; `docs/qa/task-workflow.md`. | Retain and update under its ownership; do not create another log. |
| `docs/ai/review-template.md` | Optional focused-review template. | Current, unique and small. | `docs/README.md`. | Retain unchanged. |
| `docs/features/*-hardening-plan.md` | Completed feature hardening/placement history with historical route notes. | Historical but valuable; not active feature requirements. | `docs/README.md`; each path also named in `docs/tasks.md`. | Retain in place; relabel as historical in the index only. |
| `docs/archive/phase2-migration-map.md` | Completed Phase 2 migration history. | Historical and already archived. | `docs/README.md`; `docs/tasks.md`. | Retain unchanged. |
| `docs/discovery/CODEBASE_DISCOVERY.md` | Frozen Phase 0 current-state baseline and evidence record. | Historical baseline, not a live architecture document. | H5/H6 and user-directed discovery track. | Retain unchanged at its current path. |
| `docs/harness/HARNESS_GAP_ANALYSIS.md` | Frozen H5 gap source. | Historical Phase 1 input; its illustrative proposed H6 filename is superseded by this required plan filename. | No active exact-path inbound reference found. | Retain unchanged; do not rewrite planning history. |
| `docs/harness/DOCUMENTATION_GOVERNANCE_PLAN.md` | Durable ownership, precedence, reading, and H7 execution plan. | Current governance plan. | No inbound references before H7. | Retain; add one index link in H7. |

## Source-of-Truth Matrix

| Responsibility | Authoritative source | Rule |
| --- | --- | --- |
| Product direction | `docs/project-direction.md` | Target/product intent; do not use it to claim current implementation. |
| Current architecture and product behavior | Current code and checked-in configuration | `docs/architecture.md` is target-only; update summaries only after code evidence confirms a change. |
| Target architecture | `docs/architecture.md` | Governs approved future structure, not migration completion. |
| Design system | `docs/design-system.md` | Governs visual direction; layout/system UI rules remain in `docs/design/`. |
| Active roadmap | `docs/roadmap.md` | Owns phase-level status/history and major direction changes. |
| Active product backlog | `docs/tasks.md` | Owns `T` IDs, one advisory primary next task, alternatives, and phase guard. |
| Harness planning | `docs/harness/` | Owns `H` track evidence/plans; it does not alter the product backlog without an explicit product-planning decision. |
| Durable decisions | `docs/decisions.md` | Records accepted/revisit-later decisions, not routine task logs. |
| Verification and Git policy | `docs/qa/git-workflow.md` | Canonical command/gate and scoped commit/push policy. |
| Task lifecycle and final report | `docs/qa/task-workflow.md` | Canonical planning-impact, logging, result, and recommendation rules. |
| Repo-local tool/skill/MCP routing | `AGENTS.md` | Defines use, fallback, and local authority only; global installation/configuration stays global. |
| UI and regression review | `docs/qa/ui-review-checklist.md`; `docs/qa/regression-checklist.md` | Apply only when the task risk requires them. |
| Discovery baseline | `docs/discovery/CODEBASE_DISCOVERY.md` | Frozen evidence; never treated as live implementation instructions. |
| Historical material | `docs/archive/` and labelled completed feature plans | Context only; cannot control current work when code/current sources differ. |

## Instruction Precedence

Apply two simple orders:

1. **Task and policy conflicts:** system/safety constraints → explicit user task → repository `AGENTS.md` → the authoritative repository document for the subject → global `AGENTS.md` and global skills → plugin/MCP guidance → historical/archive material.
2. **Factual conflicts:** current code and checked-in configuration → current authoritative repository document → discovery/Harness evidence for its recorded date → historical/archive document.

`docs/tasks.md` recommendations are advisory. Skills and MCP tools cannot override repository scope, and their results never replace required native Flutter/Git verification. When equal-precedence repository sources disagree, stop and resolve the conflict in the source owner rather than choosing silently.

## Target Documentation Structure

```text
README.md                         # onboarding and concise current snapshot
AGENTS.md                         # repository operating rules and tool routing
docs/
  README.md                       # documentation map and role labels
  project-direction.md            # product target
  architecture.md                 # architecture target
  design-system.md                # design target
  roadmap.md / tasks.md / decisions.md
  design/                         # layout and system UI policy
  qa/                             # canonical verification, lifecycle, review checklists
  ai/                             # task log and optional review template
  features/                       # labelled completed feature history
  archive/                        # completed migration history
  discovery/                      # frozen Phase 0 baseline
  harness/                        # H5 gap analysis and this governance plan
```

No new path beyond this required plan is necessary. Removing the two duplicate `docs/ai/` files avoids duplication; retaining `ai/task-log.md` and `ai/review-template.md` avoids an unnecessary replacement folder or log.

## Move, Merge, Rename, Archive, and Retain Plan

| H7 action | Documents | Destination / preservation rule |
| --- | --- | --- |
| Retain and edit | `README.md`, `docs/README.md`, `docs/roadmap.md`, `docs/tasks.md` | Correct only proven current-state drift; make `docs/README.md` role-led and index this plan. |
| Retain and edit | `AGENTS.md`, `docs/qa/task-workflow.md` | Merge the unique agent docs-update rule into AGENTS and the unique docs-only output line into task workflow without changing unrelated policy. |
| Merge, then delete | `docs/ai/agent-rules.md` → `AGENTS.md` | Preserve documentation-update/scope/verification intent; remove duplicate sections after AGENTS contains the needed rule. |
| Merge, then delete | `docs/ai/codex-output-format.md` → `docs/qa/task-workflow.md` | Preserve only its docs-only `Docs updated: <paths> | none` requirement; task workflow remains the result-format owner. |
| Retain unchanged | `docs/project-direction.md`, `docs/architecture.md`, `docs/design-system.md`, `docs/decisions.md`, `docs/qa/git-workflow.md`, design/QA checklists, task log, review template | Their existing responsibilities are unique; H8/H9 own later policy changes where planned. |
| Retain, relabel in index only | Feature hardening plans and `docs/archive/phase2-migration-map.md` | Preserve completed work/history in place. No physical archive move or rename is justified by current evidence. |
| Retain frozen | Phase 0 discovery and H5 gap analysis | Historical evidence/planning record; do not update stale path mentions inside them. |
| Retain | This H6 plan | It is the single durable governance map and replaces H5's illustrative, uncreated source-of-truth-plan path. |

## Reference Synchronization Plan

| Planned H7 operation | Known inbound references | Required replacement / link effect | Proof |
| --- | --- | --- | --- |
| Merge/delete `docs/ai/agent-rules.md` | Active link: `docs/README.md` `Agent rules`; historical plaintext: Phase 0 discovery and H5. | Remove the index link after merging content into `AGENTS.md`. Keep historical plaintext in frozen records; no compatibility file is needed. | `rg -n -F 'docs/ai/agent-rules.md' .`; inspect `docs/README.md`; `git diff --check`. |
| Merge/delete `docs/ai/codex-output-format.md` | Active link: `docs/README.md` `Codex output format`; its own relative link to `../qa/task-workflow.md`; historical plaintext: Phase 0 discovery and H5. | Remove the index link and the file; preserve its rule in task workflow. Its relative link disappears with the merged source. Keep frozen-record mentions. | `rg -n -F 'docs/ai/codex-output-format.md' .`; search `Codex Output Format`; inspect task-workflow result section. |
| Reorganize the docs index | `docs/README.md` is the documentation entry point; feature/archive links are active there. | Update only the index headings/links and add this H6 plan. Relative links remain valid because files stay in place. | Inspect every Markdown link in `docs/README.md`; `rg -n '\\[[^\\]]+\\]\\([^)]*\\)' docs/README.md`. |
| Correct README/roadmap/tasks summaries | No file path moves; root README is repository entry, while roadmap/tasks have known planning references from AGENTS and root README. | Keep paths and headings stable; synchronize only proven Phase 10/Reader facts from code. | Search `Phase 9`, `Library empty state`, `bookmark`, and `Reader` across README/docs; review code evidence before edits. |
| Preserve archive/feature paths | `docs/README.md` indexes all; `docs/tasks.md` names the archive and feature hardening paths. | No path or relative-link change. Relabel as historical in index only. | `rg -n -F 'docs/archive/phase2-migration-map.md' .`; equivalent searches for both feature plans. |

No source comments or configuration files currently point to planned documentation moves. H7 must repeat the full-repository path, filename, heading, and Markdown-link searches immediately before staging because new references may be introduced after H6.

## Codex Reading Matrix

| Task type | Minimum reading |
| --- | --- |
| Small local code change | `AGENTS.md`; `docs/qa/git-workflow.md`; affected feature code/tests. Read tasks/workflow only when planning impact or next-task selection is involved. |
| UI/widget task | Small-change set plus `docs/design-system.md`, `docs/design/layout-safety.md`, `docs/design/system-ui-policy.md`, and `docs/qa/ui-review-checklist.md`. |
| Routing/startup change | `AGENTS.md`; `docs/project-direction.md`; `docs/architecture.md`; `docs/design-system.md`; `docs/roadmap.md`; `docs/qa/git-workflow.md`; affected bootstrap/router tests. |
| Persistence change | `AGENTS.md`; `docs/project-direction.md`; `docs/architecture.md`; `docs/tasks.md`; `docs/decisions.md`; `docs/qa/git-workflow.md`; affected repository/tests. |
| Architecture or restructure task | `AGENTS.md`; project direction, architecture, design system, roadmap, tasks, decisions, QA Git workflow; Phase 0 baseline; this governance plan. |
| Docs-only task | `AGENTS.md`; the document being changed; `docs/README.md` if links/roles are affected; `docs/qa/git-workflow.md`; task workflow when planning/lifecycle rules are touched. |
| Android/platform task | `AGENTS.md`; `docs/roadmap.md`; `docs/decisions.md`; `docs/qa/git-workflow.md`; relevant platform configuration. |
| Harness task | Phase 0 discovery; H5/H6 Harness documents; `AGENTS.md`; `docs/README.md`; and only the workflow/AI/planning sources in scope. |

## H7 Execution Scope

**Change in one coherent documentation unit:**

- Edit `README.md`, `docs/README.md`, `docs/roadmap.md`, `docs/tasks.md`, `AGENTS.md`, and `docs/qa/task-workflow.md` as described above.
- Delete only `docs/ai/agent-rules.md` and `docs/ai/codex-output-format.md` after their unique content is merged.
- Add `docs/harness/DOCUMENTATION_GOVERNANCE_PLAN.md` to the documentation index; no other file creation, physical move, rename, archive move, or source/test/platform change.
- Exclude `docs/discovery/`, `docs/harness/HARNESS_GAP_ANALYSIS.md`, feature hardening plans, archive contents, verification-gate policy details (H8), lifecycle/Git-policy redesign (H9), tool routing changes (H10), and all application files.

H7 should commit and push one docs-only change only after all listed merges/deletions, active-reference updates, Markdown-link inspection, and `git diff --check` succeed. It must stage only its documentation files and report any frozen historical references deliberately retained.

## Validation and Rollback Strategy

- Before staging, repeat repository-wide `rg` searches for each old path, filename, link label, and relevant heading; distinguish active references from frozen historical evidence.
- Inspect all Markdown links in `README.md` and `docs/README.md`; verify relative links affected by deletions are removed or redirected.
- Run `git diff --check`, review the complete scoped diff, confirm no application/test/platform/configuration file changed, and confirm historical content was preserved in its destination or retained source.
- Confirm `git status --short` contains only the approved H7 documentation paths, then stage only those paths.
- If a merge/reference error is found before commit, fix or revert the scoped documentation change. If found after the single H7 commit, create one focused corrective docs commit; do not rewrite history.

## H10 Repo-local Tool Usage Policy

`AGENTS.md` owns the concise repository routing and authority rules. Global installation/configuration remains outside this repository. Native Flutter, Dart, Git, and platform commands remain completion authority; helpers may inform investigation but never override code, tests, analyzer output, diffs, or explicit user scope.

| Need | Preferred helper | Native fallback | Completion authority | Failure behavior |
| --- | --- | --- | --- | --- |
| Semantic discovery | Semble | `rg`, file listing, import search, direct inspection | Repository evidence and applicable tests | Retry once only if safe; otherwise use fallback. |
| Dependency/impact exploration | CodeGraph when available | Import/reference search, analyzer, tests, direct inspection | Repository evidence and verification gates | Transport failure does not block work or prove dependencies complete. |
| Version-sensitive documentation | Context7 | Official documentation plus package/source inspection | Repository configuration and native verification | Report uncertainty only if fallback cannot confirm the needed version behavior. |
| Flutter build, analysis, or tests | No helper required | Native `flutter`/`dart` CLI | `docs/qa/git-workflow.md` matrix | Do not substitute MCP/plugin output. |
| Git status, diff, or history | No helper required | Native `git` commands | Native Git output | Stop only when Git evidence cannot safely establish scope. |
| Flutter UI/device validation | Native emulator/device and QA checklists | Report as unverified when unavailable | Observed runtime evidence | Browser tools do not replace native validation. |
| Browser/DOM inspection | Chrome DevTools only for web/browser tasks | Browser inspection or direct web evidence | Task-appropriate native/browser result | Do not apply to Flutter native UI by default. |
| Security review | Security plugin/skill only when security-relevant or assigned | Repository inspection and applicable native checks | Explicit security evidence and verification | Do not claim a security review merely because a helper ran. |

Global Skills are reusable capabilities, not repository files: choose the smallest relevant set and do not let generic guidance expand scope. Plugins are used only for matching capabilities. Hooks are not relied on for repository verification, staging, commit, push, logging, or documentation updates; configured-but-unobserved execution is not guaranteed. Optional helper failure uses the listed fallback and is reported only when it materially lowers confidence. Stop only when no safe fallback can establish a required fact.

## Phase 1 Completion

- **Completed:** H5 — Harness Gap Analysis.
- **Completed:** H6 — Documentation Source of Truth Plan.
- **Completed:** H7 — Documentation Restructure.
- **Completed:** H8 — Verification Gates.
- **Completed:** H9 — Task Lifecycle and Git Policy.
- **Completed:** H10 — Repo-local Tool Usage Policy.
- **Phase status:** Phase 1 — Harness Foundation completed. Global Skills, Plugins, MCP configuration, and Hooks remain unchanged.
- **Product status at Phase 1 completion:** `T121` remained deferred.
- **Next Harness task:** H11 — Scoped Restructure Pilot Selection.
