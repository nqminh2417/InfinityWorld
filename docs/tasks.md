# Infinity World Active Tasks

Last updated: 2026-07-20

## Current Status

Current branch workflow:

- Active branch: `home/devbyMinh-current`
- Commit/push require task-specific authority, passing required gates, scoped staging, and an allowed branch/upstream; passing gates alone is insufficient.
- Git workflow source: `docs/qa/git-workflow.md`

Current track status:

- Product track is paused after `T120`; `T121` remains deferred.
- Harness Phase 1 Foundation and Phase 2 validation are complete. Restructure Phase 3 is active; R3 is complete and the next approved task is R4 — Compatibility and Return-to-Product Audit. Harness `H...` tasks remain separate from product backlog IDs.

## Harness Phase 2 — Validation and Pilot

Status: completed. H11, H12, and H13 are complete; product work remains paused after `T120` and `T121` remains deferred.

### H11 Candidate Assessment

| Candidate | Current evidence and proposed change | H12 scope, verification, and documentation impact | Risk and decision |
| --- | --- | --- | --- |
| `FloatingLabelTextField` | H12 moved the former shared-location widget into `lib/features/test/presentation/widgets/floating_label_text_field.dart`; `TestScreen` remains its sole production importer. | The move/rename and import update reuse `test/features/test/presentation/test_screen_test.dart` and `test/routes/app_router_test.dart`. H12 searched the former path/name before and after and updated only this file and `docs/roadmap.md`. | Low-Medium. **Selected and completed:** it is a real feature-boundary move with one source importer and existing route/screen coverage. |
| Empty compatibility-named folders | `lib/blocs`, `helpers`, `models`, `providers`, `services`, `utils`, and `screens/main` are empty, have no tracked files, and have no literal repository references. | Removing empty directories would not create a tracked source change or validate import/reference synchronization; external IDE/tooling expectations remain unproven. | Medium-High. **Rejected:** no reviewable Git change and insufficient tooling proof. |
| `AppRoutes` ownership | `lib/routes/app_routes.dart` is the active route contract. It has 16 Dart importers across bootstrap, router, features, and tests. A move into `lib/app/router/` would alter all of those imports. | Would require startup/route coverage, exhaustive import search, build, and affected-route checks; historical documentation also names the current path. | High. **Rejected:** too broad for the first Harness pilot. |
| `ProgressBar` feature boundary | `lib/features/summertime_saga/presentation/widgets/progress_bar.dart` already has correct feature-local ownership and one presentation consumer. | No move is warranted; changing it would add churn without testing a boundary correction. | Low. **Rejected:** no restructuring value. |

### Selected Pilot — H12

- **Scope:** move `FloatingLabelTextField` into the Test feature and update its sole production import; retain the class API and all screen behavior.
- **Allowed files:** the moved feature widget, `lib/features/test/presentation/test_screen.dart`, `docs/tasks.md`, and `docs/roadmap.md`.
- **Excluded:** `AppRoutes`, router/bootstrap/shell code, all other features, Reader/Library, persistence, empty-folder deletion, dependencies, platform files, and global tools/configuration.
- **Behavior to preserve:** `/testscreen`, the three text fields including `Username`, controller disposal, and keyboard-inset/scroll-safe behavior.
- **References:** search the old path, new path, `FloatingLabelTextField`, and the Test route before/after the move. Preserve frozen `docs/discovery/CODEBASE_DISCOVERY.md` path evidence as historical.
- **Tests and gates:** no new test is planned; run the existing Test-screen and route tests, then H8 file-move gates: changed-scope formatter check, `flutter analyze`, `flutter test`, `flutter build apk --debug`, `git diff --check`, and focused diff/status/reference review.
- **Runtime check:** use an Android emulator/device to open `/testscreen`, confirm the fields remain visible, and confirm keyboard inset scrolling remains usable; record it as unverified only if unavailable.
- **Documentation and rollback:** update only this plan record and the Phase 2 roadmap status after H12. Keep one coherent H12 commit; if rollback is needed after push, use one revert/follow-up commit rather than history rewrite.
- **Commit/push authority:** H12 may commit and push only when its prompt authorizes it and `docs/qa/git-workflow.md` conditions are met: required gates pass, only scoped files are staged, and branch/upstream checks succeed.

The pilot validates scope resolution, reference synchronization, native fallbacks, risk-based gates, minimal documentation updates, scoped staging, authorized commit/push, and concise final reporting.

### H12 Result

- **Completed:** moved `FloatingLabelTextField` into the Test feature and updated its sole production import without changing the widget API or behavior.
- **Validation:** formatter, analyzer, full test suite, debug APK build, old-path search, and Pixel 6 Android runtime check passed.
- **Next Harness task:** H13 — Pilot Review and Harness Adjustment.

### H13 Pilot Review

| Review area | Classification | Evidence |
| --- | --- | --- |
| Scope resolution | Worked as intended | H11 defined the allowed widget/import/planning files and excluded routing, persistence, and unrelated cleanup. |
| Reference discipline | Worked as intended | H12 searched the symbol and old/new paths before and after the move; no active old Dart import remained. |
| Scope containment | Worked as intended | Commit `27ee60f` contains the 100% rename, its sole import update, and warranted planning updates only. |
| API and behavior preservation | Worked as intended | Git recorded a 100% content-preserving rename; existing Test-screen/route tests and Android runtime exercise passed. |
| Verification-gate selection | Worked as intended | H12 applied the file-move/UI gates: changed-scope and repository-wide formatting, analyzer, 147 tests, debug APK build, diff check, and reference/diff review. |
| Runtime/device evidence | Worked as intended | Pixel_6_API_33 opened `/testscreen` in light portrait and landscape; typing, keyboard insets, and scrolling behaved correctly. |
| Optional tools | Worked as intended | Native search, Flutter, Dart, Git, and emulator evidence were sufficient; no optional helper was required for completion. |
| Planning-doc updates | Worked as intended | H12 updated only `docs/tasks.md` and `docs/roadmap.md` because phase/status and next-task ownership changed. |
| Git lifecycle | Worked as intended | Scoped staging, one coherent commit, allowed upstream push, and a concise final report all completed. |
| Final Summary | Worked as intended | H12 returned the requested short summary with move, references, gates, runtime, planning, commit, push, risk, and next-task evidence. |
| Frozen Discovery handling | Worked as intended | The old widget path remains only in frozen `docs/discovery/CODEBASE_DISCOVERY.md`, as governance permits historical evidence to remain. |
| Review and rollback size | Worked as intended | The single coherent commit is small and can be reverted with a follow-up commit without history rewrite. |
| Lifecycle-policy freshness | Needs adjustment | `docs/qa/task-workflow.md` still named H11 as next after H12 moved planning to H13; the policy now points to active planning documents instead. |

**Conclusion:** Harness pilot passed with minor adjustment. Infinity World is ready for scoped codebase restructuring planning, not unrestricted repository-wide restructuring.

### H13 Result

- **Completed:** reviewed H11–H12 against the Phase 1 Harness and made the single evidence-based lifecycle-policy adjustment.
- **Next task:** R1 — Codebase Restructure Scope and Sequence.

## Restructure Phase 3 — Scoped Codebase Restructuring

Status: active. R1, R2, and R3 are complete; `T121` remains deferred until the Restructure Phase 3 exit criteria are met.

### Bounded Scope and Candidate Reassessment

| Candidate | Classification | Current evidence, impact, and direction | Expected files / dependencies | Verification, risk, and commit boundary |
| --- | --- | --- | --- | --- |
| Root compatibility-named folders | Audit only | `lib/blocs`, `helpers`, `models`, `providers`, `services`, and `utils` are empty and untracked; `screens/main` and `widgets/text_field` are empty. Removing them produces no durable Git change and static absence cannot prove external tooling does not expect them. Leave them out of implementation; recheck in R4 only. | No planned source files. Depends on a tracked-file and exact-reference search. | Low risk; no standalone commit. Do not present local empty-directory removal as a restructure result. |
| `AppRoutes` ownership | Included — R2 completed | The active go_router/startup path contract now lives in `lib/app/router/app_routes.dart`; all 16 production/test importers were updated. Its class API and every route-path string were preserved. | The old file was removed; no dependency/package change. Current-state planning references use the new location, while frozen/dated history retains its evidence. | Medium risk mitigated by exhaustive path/symbol search, route/startup tests, full gates, APK build, and Android route smoke. |
| Fox and Summertime Saga service injection | Included — R3 completed | `smtsServiceProvider` now watches `dioProvider` and constructs the feature-owned service with that shared client. The active router continues to inject `fetchProgress`; `SmtsHomeScreen` now requires the injected loader, so no static/direct production fallback remains. | Feature provider, service, screen, and one deterministic provider test. No repository framework, interceptor layer, or behavior change. | Low-Medium risk mitigated by fake-Dio provider/service tests, screen-state/retry tests, route-seam tests, full gates, APK build, and Android runtime error/retry/re-entry validation. |
| Reader/Library ownership and SharedPreferences contracts | Defer | Library’s explicit Reader imports support the current local-sample aggregation. Reader keys (`iw_reader_*`) have migration/validation tests, including the legacy saved boolean. Moving repositories from the application file or replacing storage risks data loss without a second consumer or approved product model. | No planned files. Preserve keys, `SharedPreferencesAsync`, provider names, and Library/Reader route behavior. | High persistence/product-direction risk; no Phase 3 commit. Recheck key compatibility and full Reader/Library tests in R4 only. |
| Current architecture documentation after the pilot | Include in Restructure Phase 3 — R1 and R4 | `docs/roadmap.md` still said shared legacy UI remained in `lib/widgets/`, but H12 moved its only tracked widget into Test. R1 corrects this factual current-state claim; R4 synchronizes the final route/provider locations after implementation. `docs/architecture.md` already states the target `app/router` direction and needs no rewrite. | `docs/tasks.md`, `docs/roadmap.md`, and `README.md` current-status text only. | Low risk; documentation belongs with R1/R4 coherent commits. Historical Discovery, decisions, archive, and completed feature plans retain dated path evidence. |
| Resolved Phase 0 widget-placement finding | Reject | H12 already moved `FloatingLabelTextField` with a 100% content-preserving rename, focused/full tests, APK build, and Android keyboard/scroll validation. | No planned files. | No duplicate move or cleanup task; preserve the H12 record. |

### Approved Task Sequence

#### R1 — Codebase Restructure Scope and Sequence

- **Type / boundary:** planning only; define this finite sequence and correct current planning status without changing source, tests, dependencies, or frozen Discovery.
- **Dependencies / verification:** H11–H13 evidence, current repository searches, focused documentation review, and `git diff --check`.
- **Runtime / docs / commit:** no runtime check; update only current planning/status documents. Commit and push are authorized by this task prompt when the scoped planning diff is complete.

#### R2 — Relocate AppRoutes into the App Router

- **Objective / exact boundary:** move only `AppRoutes` to `lib/app/router/app_routes.dart`; update every production/test import. Preserve the `AppRoutes` class name, all path strings, `createAppRouter`, startup/session flow, and direct-route behavior.
- **Dependencies:** R1; before editing, search the old/new paths, `AppRoutes`, package imports, route tests, Markdown references, and direct string route uses. Preserve historical/frozen records; update active current-state references in the same commit.
- **Verification class:** large file move affecting routing — changed-scope format, `flutter analyze`, focused startup/router tests then full `flutter test`, `flutter build apk --debug`, `git diff --check`, and before/after old-path/symbol searches.
- **Runtime / docs / commit:** Android emulator/device launch plus Login/Main and one direct-route smoke; record theme, route, viewport, and result. Update only warranted current docs. One scoped commit/push is allowed after all gates pass.
- **R2 result:** completed the ownership-only relocation; the new file has the same content hash as the former contract, and all 16 Dart imports now target `lib/app/router/app_routes.dart`. `T121` remains deferred.

#### R3 — Align Summertime Saga Provider Injection

- **Objective / exact boundary:** make `smtsServiceProvider` read the existing `dioProvider` when creating `SmtsService`; keep the router's explicit loader injection and remove the unused screen fallback only after every construction path is explicit. Preserve parsing/error behavior, router shape, endpoint, timeout, and UI.
- **Dependencies:** R1 and the existing shared Dio provider; audit `SmtsService`, `smtsServiceProvider`, route injection, deterministic service tests, and direct Dio construction before editing.
- **Verification class:** network/service — changed-scope format, focused provider/service and route tests, `flutter analyze`, full `flutter test`, `git diff --check`, and focused reference/diff review. This task also required and passed APK/device validation because it changes the production route's service wiring.
- **Docs / commit:** update planning only if scope/status changes. One scoped commit/push is allowed after required gates pass.
- **R3 result:** completed the single production path `dioProvider → smtsServiceProvider → router injection → SmtsHomeScreen`; the static fallback was removed and test loaders remain explicit. R4 is next; `T121` remains deferred.

#### R4 — Phase 3 Closeout and Product-Track Reassessment

- **Objective / exact boundary:** audit the completed R2/R3 state, synchronize current planning/architecture status only where code proves it, verify deferred Reader compatibility, and decide whether `T121` becomes the next approved product task or is truthfully reclassified. Do not add source cleanup under this closeout task.
- **Dependencies:** R2 and R3 complete. Recheck root compatibility folders without treating empty-directory removal as a Git deliverable; recheck Reader `iw_reader_*` keys, legacy-key migration behavior, Library/Reader routes, and old AppRoutes imports/paths.
- **Verification class:** Phase exit — repository-wide non-mutating formatting, `flutter analyze`, full `flutter test`, `flutter build apk --debug`, `git diff --check`, full reference search, and focused status/diff review.
- **Runtime / docs / commit:** Android emulator/device validates startup, Login/Main, moved route contract, and `/smts_home` loading/error/retry state without claiming live-network success unless observed. Update `docs/tasks.md`, `docs/roadmap.md`, and `docs/architecture.md` only when the final code requires it. Commit/push only when all exit criteria pass; otherwise record the blocker without claiming Phase 3 completion.

### Reference Synchronization and Phase 3 Exit

- R2 must search `lib/routes/app_routes.dart`, `app_routes.dart`, package imports, `AppRoutes`, route strings, tests, Markdown references, and documentation headings before and after the move. Active references update in the same commit; frozen Discovery and dated historical records remain historical evidence.
- R3 must search the service/provider symbols and retain deterministic fake-Dio test seams. Static-search absence never authorizes removal of fallback behavior or persistence code.
- Return to product work only when R2–R4 are complete; no stale active imports/path references remain; formatting, analysis, full tests, required APK/device checks, and clean Git status pass; Reader preference keys remain compatible; current planning/architecture docs are synchronized; and R4 has reassessed `T121` as the next approved product task or truthfully reclassified it.

### Explicit Restructure Phase 3 Exclusions

- No universal feature-layer template, Riverpod conversion of local widget state, ShellRoute conversion, generic network/repository framework, database migration, broad route redesign, Android/toolchain work, CI/hooks/tools changes, Chat implementation, product features, or repository-wide cleanup.

Current architecture status:

- Transitional architecture.
- `lib/main.dart` still owns app composition, now uses `MaterialApp.router`, and consumes the Riverpod app theme-mode provider.
- `lib/app/router/app_router.dart` owns the active go_router route table.
- `lib/app/router/app_routes.dart` is the shared path contract.
- Inactive legacy `lib/routes/app_pages.dart` has been removed.
- The current main shell lives under `lib/app/shell/main_screen.dart` and exposes a local Home / Explore / Tools / Library / Settings skeleton.
- `lib/app/bootstrap/startup_route_resolver.dart` now chooses Login or Main from the local session flag before `runApp`.
- `lib/main.dart` now wraps the runtime app with Riverpod `ProviderScope`.
- `lib/app/theme/app_theme.dart` now provides the first Midnight Violet light/dark app theme.
- `lib/app/theme/app_theme_mode_provider.dart` now exposes the persisted app-level theme mode provider/controller with a fallback default of `ThemeMode.system`.
- `lib/design_system/tokens/` and `lib/design_system/components/iw_card.dart` now provide the first design-system token/card slice.
- Auth/Login presentation now lives under `lib/features/auth/presentation/`.
- Auth session dependency injection now starts at `lib/features/auth/application/session_providers.dart`.
- Local session/profile persistence now lives under `lib/features/auth/data/local_session_repository.dart` and uses `shared_preferences`.
- Dashboard/Home now renders the existing Dashboard screen as the Home tab, consumes the persisted local display name through Riverpod, and surfaces refreshed quick actions for existing useful modules.
- Profile now consumes the persisted local display name through Riverpod.
- Settings now consumes the persisted local display name and app theme mode through Riverpod and exposes theme-mode controls.
- BMI was the initial migration pilot and now lives under `lib/features/bmi/`.
- Chat presentation now lives under `lib/features/chat/presentation/`.
- Dashboard presentation now lives under `lib/features/dashboard/presentation/`.
- Fox now lives under `lib/features/fox/`.
- Profile presentation now lives under `lib/features/profile/presentation/`.
- Settings presentation now lives under `lib/features/settings/presentation/`.
- Summertime Saga now lives under `lib/features/summertime_saga/`.
- Test presentation now lives under `lib/features/test/presentation/`.
- Fox hardening plan exists at `docs/features/fox-hardening-plan.md`.
- Summertime Saga hardening plan exists at `docs/features/summer-time-saga-hardening-plan.md`.
- Phase 2 migration map exists at `docs/archive/phase2-migration-map.md`.
- `shared_preferences` is active for the first local session flag and display name.
- go_router is active for root routing.
- Riverpod foundation is complete for current local session/profile/theme preferences.
- Remaining likely Riverpod candidates are either temporary screen-local state or Phase 7 networking ownership.
- `lib/core/network/dio_provider.dart` now provides the first shared Dio client/provider boundary.
- Fox now uses Dio through `FoxApiService` and `foxApiServiceProvider`.
- Summertime Saga now uses Dio through `SmtsService` and `smtsServiceProvider`.
- The direct `http` dependency has been removed.
- Phase 7 networking foundation checkpoint is complete; broader retry/cache/offline/global error policy is deferred until a concrete feature needs it.
- Phase 8 feature expansion checkpoint is complete; Tools, Explore, Library, and Home/Dashboard have first small tab-body cleanup/content slices.
- Tools now has a first tab body at `lib/features/tools/presentation/tools_screen.dart`.
- Explore now has a first tab body at `lib/features/explore/presentation/explore_screen.dart`.
- Library now has a first empty-state tab body at `lib/features/library/presentation/library_screen.dart`.
- Phase 9 QA/device readiness is complete; portfolio, screenshot, release presentation, and employer-showcase work are deferred until explicitly requested.
- Reader has a built-in local sample catalog with saved, finished, last-opened, and one paragraph-bookmark state through the existing `shared_preferences`/Riverpod pattern; generic saved articles, scroll offsets, multiple bookmarks, and a local database remain out of scope.
- Existing persistence remains small `shared_preferences` repositories for local session/profile, theme mode, and Reader state; no Drift/local database dependency is active.
- `features/home` root does not exist yet; Dashboard still owns direct module/dev links plus logout/session clearing.
- Phase 10 kickoff audit confirmed Tools is the smallest low-risk content-depth surface for the next slice because it can add a useful local Clock tool without public APIs, persistence, screenshots, release work, broad redesign, or app architecture migration.
- Clock now lives under `lib/features/clock/`, has a direct `/clock` route, and is linked from Tools beside BMI.
- `timezone` is a direct dependency only for Clock's `America/Los_Angeles` DST-correct time conversion.
- Clock now includes a responsive `CustomPainter` analog face with numbered hour markers and live local-time hands.
- T85 audited Home/Dashboard, Explore, Tools, Library, and direct module routes after the Clock slice; the next smallest useful local content-depth slice is a Tools random picker MVP.
- Random Picker now lives under `lib/features/random_picker/`, has a direct `/random-picker` route, and is linked from Tools beside BMI and Clock.
- T87 checkpoint confirmed Phase 10 should continue with a small Home/Dashboard quick-actions refresh before screenshots, Library/Reader foundation, or another new tool.
- Home/Dashboard now surfaces BMI, Clock, Random Picker, Random Fox, and Summertime Saga as simple quick actions while keeping Dashboard ownership and direct routes stable.
- T89 confirmed Library still has only the empty-state tab body and no Reader/bookmark/saved-content route or module; the next smallest useful Library slice is a local Reader text screen MVP.
- Reader now lives under `lib/features/reader/presentation/`, has a direct `/reader` route, and opens from Library as a built-in local text sample.
- T91 confirmed the next smallest Library persistence slice should save only the built-in Reader sample state with the existing `shared_preferences` pattern before any Drift/schema/bookmark model work.
- Reader saved-sample state now lives under `lib/features/reader/application/`, uses `shared_preferences`, stores saved built-in sample IDs, preserves the legacy The First Door boolean fallback, and is consumed by Reader and Library.
- T93 checkpoint confirmed Phase 10 should continue with a small Explore content refresh before screenshots or deeper Reader persistence because Explore remains the thinnest main tab surface after the Tools, Home/Dashboard, and Library updates.
- Explore now has richer static Fox / Summertime Saga module cards while keeping live network work inside the destination screens.
- T95 confirmed the next smallest Reader slice should add local text comfort controls inside the existing Reader screen before bookmarks, reading-progress persistence, imports, or Drift/schema work.
- Reader now has screen-local text comfort controls for local samples, without persisted reader settings, packages, Drift, bookmarks, imports, or a settings model.
- T97 expanded the Phase 10 backlog direction: active Phase 10 recommendations should focus on feature/content implementation, not screenshot, portfolio, release, or employer-showcase readiness.
- Unit Converter now lives under `lib/features/unit_converter/`, has a direct `/unit-converter` route, and is linked from Tools beside BMI, Clock, and Random Picker.
- Decision Wheel now lives under `lib/features/decision_wheel/`, has a direct `/decision-wheel` route, is linked from Tools beside the other local utilities, and has a large animated `CustomPainter` wheel with center spin, shuffle/sort entries, compact mobile layout, x1/x2/x3 multiplier mode, a modal selected-result dialog, roomier/readability-tuned screen-capped in-memory session history bottom sheet with per-item copy, remove-selected-result actions, semicolon-aware entry parsing, clearer pointer layering, and adjacent-safe repeating segment colors.
- Reader/Library now has a three-item built-in local sample catalog; Library opens selected Reader samples through a narrow route query key, and any built-in local sample can be saved or removed.
- T114 audited the current Reader/Library surface and selected a Library saved-samples shelf as the next smallest useful content-depth slice because it reuses existing saved IDs and Reader routes without new storage, progress tracking, imports, or broad redesign.
- Library now shows a compact Saved samples shelf when local Reader samples are saved, while keeping the saved count summary and full Local samples catalog.
- Reader now records the last opened built-in local sample ID and Library shows a compact Continue reading card for that sample, without reading-progress offsets or a history list.
- T117 audited Reader/Library progress and bookmark options and selected a finished-sample marker as the next smallest useful Reader progress slice before scroll offsets, bookmarks, history, or Drift.
- Reader now stores finished built-in sample IDs with the existing `shared_preferences`/Riverpod pattern and reflects finished state in Reader actions plus Library sample cards.
- T119 audited Reader bookmark options and selected a single paragraph bookmark per built-in sample because a sample-level bookmark would duplicate saved samples, while multiple bookmarks, notes, highlights, and scroll offsets are larger storage-model work.
- Reader now stores one paragraph bookmark per built-in sample with the existing `shared_preferences`/Riverpod pattern, validates persisted sample/paragraph pairs, exposes compact Reader paragraph controls, and reflects bookmark state in Library sample cards.

Current tests:

- App startup smoke tests cover logged-out Login startup and logged-in Main startup.
- Local session repository and startup route resolver unit coverage exists.
- Login/logout session navigation widget coverage exists and overrides the local session repository provider.
- Local display-name validation and persistence coverage exists.
- App theme unit coverage exists.
- App theme-mode provider coverage exists for default, persisted, invalid, update, root-app persisted, and Settings summary behavior.
- `IwCard` widget coverage exists.
- BMI domain unit tests exist.
- BMI presentation widget tests exist.
- Chat route smoke test exists.
- Dashboard presentation widget test exists for small-screen scroll safety, persisted local display-name rendering, absence of the old no-op filter action, refreshed quick-action labels, and a Home-to-Random Picker route tap.
- Deterministic route smoke tests exist for Login, Main, Dashboard, Chat, Profile, Settings, BMI, Clock, Random Picker, Unit Converter, Decision Wheel, Reader, Test, Fox, and Summertime Saga.
- Test screen widget coverage exists for small-screen keyboard/scroll safety.
- Fox API service and model parsing tests exist with fake Dio responses.
- Fox screen loading/error/retry widget tests exist, avoid real network, and include small-screen scroll-safety coverage.
- Summertime Saga service/model tests exist with fake-network coverage for success, non-2xx, malformed JSON, missing schema, and timeout handling.
- Summertime Saga screen widget tests exist for deterministic loading, success, error/retry, incomplete data, dispose safety, and small-screen scroll safety.
- Profile presentation widget test exists and covers persisted local display-name rendering.
- Settings presentation widget test exists and covers persisted local display-name rendering, Appearance theme-mode summary, persisted theme-mode behavior, and theme-mode selection/persistence behavior.
- Tools presentation widget coverage exists for small-screen scroll safety and BMI route navigation.
- Clock domain coverage exists for `HH:mm:ss` formatting and California winter/summer DST offsets.
- Clock presentation widget coverage exists for local/California digital time rows, the analog clock widget, once-per-second updates, scroll-safe layout, and ticker disposal.
- Tools presentation widget coverage exists for Clock route navigation.
- Random Picker presentation widget coverage exists for scroll-safe rendering, validation, and deterministic picking.
- Tools presentation widget coverage exists for Random Picker route navigation.
- Unit Converter domain coverage exists for length and weight conversions plus result formatting.
- Unit Converter presentation widget coverage exists for scroll-safe rendering, validation, and length conversion behavior.
- Tools presentation widget coverage exists for Unit Converter route navigation.
- Decision Wheel presentation widget coverage exists for scroll-safe rendering, compact phone-size closed-keyboard layout, x1/x2/x3 multiplier behavior, center spin, modal result dialog behavior, background interaction blocking, Cancel/Remove behavior, in-memory session history display/clear/copy behavior, content-wrapping history sheet growth with screen-based 60-62% max-height scrolling and readability-tuned roomier rows, semicolon-aware parsing, validation, animated deterministic picking, shuffle/sort actions, adjacent-safe segment colors, and the local wheel surface.
- Tools presentation widget coverage exists for Decision Wheel route navigation.
- Explore presentation widget coverage exists for small-screen scroll safety and fake-route navigation to Fox and Summertime Saga.
- Library presentation widget coverage exists for small-screen scroll safety and local sample catalog rendering.
- Reader presentation widget coverage exists for scroll-safe local sample rendering.
- Library presentation widget coverage exists for opening a selected Reader sample route.
- Reader route smoke coverage exists, including selected local sample query behavior.
- Reader saved-sample provider coverage exists for default, selected-ID save/remove, legacy boolean fallback behavior, last-opened default, last-opened persistence, and unknown last-opened ID handling.
- Reader presentation widget coverage exists for saving/removing the built-in sample, saving/removing a selected local sample, and recording the selected local sample as last opened.
- Library presentation widget coverage exists for saved, unsaved, multiple-saved Reader sample states, the Saved samples shelf, saved shelf route navigation, Continue reading card display, and Continue reading route navigation.
- Reader finished-sample provider coverage exists for default, selected-ID mark/unmark, and unknown persisted ID filtering.
- Reader presentation widget coverage verifies marking/unmarking a selected local sample as finished.
- Library presentation widget coverage verifies finished local samples in the Local samples catalog, Saved samples shelf, and Continue reading card.
- Reader paragraph bookmark provider coverage exists for default state, one-slot replacement/removal, persistence, and invalid persisted entry filtering.
- Reader presentation widget coverage verifies bookmarking, replacing, and removing a selected sample paragraph bookmark.
- Library presentation widget coverage verifies paragraph bookmark labels in Saved samples, Local samples, and Continue reading cards.
- No new app tests were added for T119 because it is a docs-only bookmark model audit.
- No new app tests were added for T93 because it was an audit/docs-only checkpoint.
- Explore presentation widget coverage now verifies the refreshed static content, small-screen scrolling, and existing Fox / Summertime Saga route taps.
- No new app tests were added for T95 because it was an audit/docs-only checkpoint.
- Reader presentation widget coverage now verifies the screen-local text-size controls while preserving the existing sample and saved-sample behavior.
- Library and route coverage now verify selected local Reader sample rendering from the built-in catalog.
- No new app tests were added for T97 because it is a docs-only backlog expansion.
- No new app tests were added for T117 because it is a docs-only Reader progress/bookmark audit.
- No Home feature-root tests exist yet because the Home tab still uses the existing Dashboard screen.
- Profile route smoke test exists.
- Settings route smoke test exists.
- Fox and Summertime Saga route smoke tests use router-level builder overrides with their existing fake-network screen seams.
- Main shell widget coverage exists for the five target tab labels and local tab switching.

Current phase:

- Phase 10: App Content and Surface Depth.
- Phase 9 QA, Device Review, and Portfolio Readiness is closed.
- Phase 8 Feature Expansion is closed for the first tab-surface pass.
- Phase 7 Networking Foundation is closed.
- Phase 6 Riverpod Foundation is closed.
- Phase 5 router migration is closed.
- go_router remains the active root router.
- Active routing is go_router-only; GetX routing is removed.
- `/main` remains the local session shell entry point.
- `ShellRoute`/`StatefulShellRoute` should wait for real tab root screens and tab-owned child route stacks.
- Riverpod is installed and active for root `ProviderScope`, the local session repository provider seam, Profile display-name consumption, Settings profile-summary/theme-mode consumption, Dashboard/Home greeting consumption, and persisted root theme-mode consumption.

Android toolchain status:

- Gradle wrapper, Android Gradle Plugin, Kotlin Gradle Plugin, and Java/Kotlin target were upgraded for Flutter 3.44.2 compatibility on `home/devbyMinh-current` with explicit approval.
- Built-in Kotlin migration remains deferred.

QA/device readiness status:

- T77 refreshed current automated gates on Flutter 3.44.2 / Dart 3.12.2: `flutter analyze`, `flutter test`, and `flutter build apk --debug` passed.
- `flutter devices` detected Windows, Chrome, and Edge during the kickoff audit before the Android emulator was launched.
- `flutter emulators` lists available Android AVDs: `Pixel_4_API_30` and `Pixel_6_API_33`.
- T78 completed a `Pixel_6_API_33` runtime visual smoke review covering startup/login, keyboard-open login, Home/Dashboard, a Dashboard BMI link, Explore, Tools, Library, Settings, and theme controls without a blocking layout failure.
- T79 completed the Local profile status-bar contrast follow-up from that smoke review.
- Android main manifest includes `INTERNET`; release signing still uses debug keys and remains non-production.
- Debug APK builds, but Flutter reports the known future Built-in Kotlin migration warning.
- T80 refreshed `README.md` against the current roadmap, dependency set, runtime findings, and known deferrals.

Completed stabilization tasks:

- Login build-time `setState()` risk was fixed; the form is now SafeArea-aware, scroll-safe, and covered by a small keyboard-inset widget test.
- BMI UI layout-safety pass was completed; the BMI form is now scroll-safe, keyboard-dismiss-aware, and covered by a small keyboard-inset widget test.
- Settings route alignment was fixed; `AppRoutes.settings` is now registered in the legacy GetX route table and covered by a route smoke test.
- BMI feature-quality pass was completed; BMI inputs now allow decimal numeric keyboards and the weight field's keyboard Done action calculates the result.
- Settings feature placement was completed; the existing placeholder screen moved to `lib/features/settings/presentation/` and the legacy GetX route import was updated.
- Profile feature placement was completed; the existing screen moved to `lib/features/profile/presentation/`, legacy imports were updated, and the route has a smoke test.
- Profile UI layout-safety pass was completed; the screen is now SafeArea-aware, scroll-safe on small screens, and covered by a focused widget test.
- Phase 2 migration map was created to rank remaining `lib/screens/` ownership and avoid random screen moves.
- Chat feature placement was completed; the existing placeholder screen moved to `lib/features/chat/presentation/`, legacy imports were updated, and the route has a smoke test.
- Deterministic legacy route smoke tests were added for Login, Main, Dashboard, BMI, and Test; live-network routes stayed deferred at that point.
- Dashboard feature placement was completed; the existing screen moved to `lib/features/dashboard/presentation/`, while GetX routes and main shell behavior stayed unchanged.
- Login feature placement was completed; the existing screen moved to `lib/features/auth/presentation/`, while startup, route, and UI behavior stayed unchanged.
- Fox feature hardening plan was completed; API/service risks, deterministic testing needs, and the safe pre-move task sequence are documented.
- Fox API service and model parsing were hardened with timeout handling, fake-network test seams, response validation, and focused tests.
- Fox screen coverage was added for deterministic loading, error, and retry states without live network calls.
- Fox feature placement was completed; files moved to `lib/features/fox/`, while GetX routing, `http`, behavior, and UI stayed unchanged.
- Fox UI layout-safety pass was completed; the screen is SafeArea-aware, scroll-safe on small screens, and keeps the normal app system UI.
- Test screen audit was completed; the route is still reachable from Dashboard, route coverage exists, and lifecycle/keyboard-safety issues should be fixed before any move or removal decision.
- Test screen lifecycle and keyboard-safety pass was completed; owned controller state is disposed and the form body is SafeArea-aware and scroll-safe.
- Test feature placement was completed; the screen moved to `lib/features/test/presentation/`, route/test imports were updated, and GetX route behavior stayed unchanged.
- Dashboard UI layout-safety pass was completed; navigation content is SafeArea-aware and scroll-safe without changing GetX route behavior.
- Summertime Saga hardening plan was completed; network, model, screen-state, release-permission, and feature-placement risks are documented before implementation.
- Summertime Saga network foundation was hardened; the service now uses configured progress URL, timeout/status/schema validation, deterministic exceptions, fake-network tests, and release `INTERNET` permission.
- Summertime Saga screen states and layout were stabilized; the screen now has a test seam, deterministic loading/error/retry/success states, mounted/stale-request guards, SafeArea-aware scrollable content, and focused widget tests.
- Summertime Saga feature placement was completed; the files moved to `lib/features/summertime_saga/`, while GetX route names, `http`, behavior, and UI stayed unchanged.
- Phase 2 checkpoint audit was completed; selected feature placement work is complete, and remaining legacy ownership is shell/routing rather than simple feature-screen placement.
- Phase 3 kickoff audit was completed; it found no shared `lib/app/theme/` or `lib/design_system/` layer at the time and selected Midnight Violet tokens plus a single reusable `IwCard` as the first implementation slice.
- Phase 3 token/card implementation slice was completed; the app now has Midnight Violet light/dark theme data, core color/spacing/radius tokens, `IwCard`, focused tests, and Profile as the first pilot screen.
- Phase 4 bootstrap/session kickoff audit was completed; current startup and logout/login paths were inspected, and the first implementation slice was scoped to local session bootstrap on top of the existing GetX app.
- Local session bootstrap was implemented; `shared_preferences` stores the session flag, startup resolves Login/Main before `runApp`, and existing login/logout actions save and clear the flag.
- Local profile entry was implemented; Login now captures a display name, validates blank input, persists the profile locally, and logout clears the display name with the session.
- Phase 4 checkpoint audit was completed; startup/session/profile behavior is covered, no Phase 4 blocker remains, and Phase 5 should begin with a router migration audit rather than implementation.
- Router migration kickoff audit was completed; current routes and navigation calls are inventoried, the legacy three-tab shell is deferred, and the first go_router slice is scoped to root route parity.
- go_router root parity slice was completed; `MaterialApp.router` now uses the active route table, Login/Dashboard navigation use go_router, and `MainScreen` remains unchanged.
- Main shell ownership audit was completed; `MainScreen` is only a legacy wrapper for Dashboard / Chat / Profile, child screens still own their own `Scaffold`/SafeArea where needed, and the next shell slice should move ownership before any five-tab or `ShellRoute` work.
- Main shell ownership move was completed; `MainScreen` now lives under `lib/app/shell/`, while `/main` and the existing Dashboard / Chat / Profile tabs stay unchanged.
- Legacy GetX route cleanup audit was completed; Dart GetX usage is limited to inactive `lib/routes/app_pages.dart`, while active routing and tests use go_router through `MainApp`.
- Inactive GetX route cleanup was completed; `lib/routes/app_pages.dart` and the `get` dependency were removed, while `AppRoutes` remains the shared path contract.
- Live-network route smoke strategy was completed; Fox and Summertime Saga should get deterministic route tests through router-level builder overrides, not live network calls or a networking migration.
- Deterministic live-network route smoke implementation was completed; `/fox` and `/smts_home` now render in route tests through fake services/loaders.
- Five-tab shell implementation audit was completed; the first implementation should update `MainScreen` to the five target tabs without `ShellRoute`, new dependencies, Riverpod, Dio, or live-network tab roots.
- Local five-tab shell skeleton was completed; `/main` now shows Home / Explore / Tools / Library / Settings, Home preserves Dashboard access, and network-backed Fox/Summertime routes stay direct instead of tab roots.
- ShellRoute/deep-link audit was completed; current `GoRoute` coverage is enough, tab-specific shell routes are deferred, and future nested tab navigation should prefer `StatefulShellRoute` if separate tab stacks become necessary.
- Phase 5 checkpoint audit was completed; router migration is closed with root go_router parity, direct route coverage, local five-tab shell behavior, and `ShellRoute` deferred until a real nested tab-routing need exists.
- Riverpod foundation kickoff audit was completed; at that point Riverpod was not installed, and the first implementation slice was scoped to root `ProviderScope`, a `LocalSessionRepository` provider seam, and focused startup/login/logout test overrides.
- Riverpod foundation implementation slice was completed; `flutter_riverpod` is installed, the runtime app has root `ProviderScope`, Login/Dashboard consume `localSessionRepositoryProvider`, and session-flow tests override the provider seam.
- Riverpod next-consumer audit was completed; Profile was selected as the second Riverpod consumer because it can show the persisted local display name through a read-only provider without broad state migration.
- Riverpod Profile display-name provider slice was completed; Profile now consumes `currentDisplayNameProvider` and focused widget coverage verifies the persisted display name.
- Riverpod next-consumer audit after Profile was completed; Settings read-only profile summary was selected as the third Riverpod consumer because it can reuse `currentDisplayNameProvider` without theme, shell, form, or network migration.
- Riverpod Settings profile summary slice was completed; Settings now consumes `currentDisplayNameProvider` and focused widget coverage verifies the persisted display name.
- Riverpod next-consumer audit after Settings was completed; Dashboard/Home read-only greeting was selected as the fourth Riverpod consumer because it can reuse `currentDisplayNameProvider` without theme, shell, form, or network migration.
- Riverpod Dashboard local greeting slice was completed; Dashboard now consumes `currentDisplayNameProvider` and focused widget coverage verifies the persisted display name.
- Riverpod next-consumer audit after Dashboard was completed; root theme mode provider foundation was selected as the fifth Riverpod consumer because `MainApp` still hardcodes `ThemeMode.system` while light/dark app themes and Riverpod root wiring already exist.
- Riverpod theme mode provider foundation slice was completed; `MainApp` now consumes `appThemeModeProvider`, default behavior stays `ThemeMode.system`, and focused coverage verifies provider default and override behavior.
- Riverpod next-consumer audit after theme mode provider was completed; Settings Appearance read-only theme-mode summary was selected as the sixth Riverpod consumer because it can reuse `appThemeModeProvider` without persistence, controls, or root app changes.
- Riverpod Settings appearance theme-mode summary slice was completed; Settings now consumes `appThemeModeProvider` and focused widget coverage verifies the default System label, with persisted-value behavior covered by the T61 slice.
- Riverpod next-consumer audit after Settings Appearance was completed; theme-mode persistence foundation was selected as the seventh Riverpod slice because root app and Settings already consume `appThemeModeProvider`, but it still returns a hardcoded `ThemeMode.system` value.
- Riverpod theme-mode persistence foundation slice was completed; `appThemeModeProvider` is now backed by `shared_preferences`, preserves System for missing or invalid stored values, and exposes a controller update method for a later Settings controls slice.
- Riverpod Settings theme-mode controls slice was completed; Settings Appearance now offers System / Light / Dark controls through `appThemeModeProvider`, and focused widget coverage verifies selection persistence.
- Riverpod next-consumer audit after Settings theme controls was completed; no remaining low-risk local shared-state consumer is worth migrating before a Phase 6 checkpoint.
- Riverpod foundation checkpoint audit was completed; Phase 6 is closed, and Phase 7 should start with a networking foundation kickoff audit before any Dio implementation.
- Phase 7 networking foundation kickoff audit was completed; direct `http` usage is limited to Fox and Summertime Saga feature services, both already have fake-network seams and route builder overrides, and the first implementation slice is scoped to Dio foundation plus a Fox service pilot.
- Dio foundation and Fox service pilot slice was completed; `dio` is installed, the shared Dio provider boundary exists, Fox uses the Dio-backed service path, and focused/full tests pass.
- Summertime Saga Dio migration slice was completed; `SmtsService` now uses the Dio-backed service path, fake-network service tests use a fake Dio adapter, route/screen seams stay deterministic, and the unused `http` dependency was removed.
- Phase 7 networking foundation checkpoint audit was completed; Dio backs both current API-backed feature services, direct `http` is gone, Android internet permission is present in the main manifest, and broader retry/cache/offline/global error policy remains deferred.
- Phase 8 feature expansion kickoff audit was completed; Home/Settings are real tab bodies, Explore/Tools/Library are placeholders, no top-level tab feature roots exist yet, and Tools/BMI was selected as the smallest useful first Phase 8 slice.
- Tools tab BMI catalog slice was completed; Tools now lists the existing BMI module, navigates to the existing `/bmi` route, and keeps `/main`, Dashboard access, direct BMI route behavior, and local bottom-navigation state stable.
- Explore existing modules catalog slice was completed; Explore now lists the existing Fox and Summertime Saga modules, navigates to existing direct routes, and does not load API data from the tab body.
- Library placeholder content audit was completed; Library has no existing local content module or persistence foundation to surface yet, so the next slice should be a static empty-state tab body rather than Reader/bookmark/database work.
- Library empty-state tab body slice was completed; Library now has a scroll-safe first tab body, focused widget coverage, and shell tab coverage without adding Reader, bookmarks, persistence, routes, or packages.
- Home dashboard cleanup audit was completed; Dashboard remains the current Home tab body, `features/home` does not exist yet, direct feature/dev links and logout remain intentionally unchanged, and the first cleanup slice should stay small before any Home feature-root or persistence work.
- Home dashboard first cleanup slice was completed; the no-op Dashboard app-bar filter action was removed while preserving Dashboard as the Home tab, direct route behavior, module links, greeting, and logout/session behavior.
- Phase 8 checkpoint audit was completed; the five-tab shell has first useful tab surfaces, direct feature routes remain covered, no tab-owned route stacks exist yet, and larger feature expansion should wait until QA/device readiness is scoped.
- Phase 9 QA/device readiness kickoff audit was completed; automated Flutter gates pass, Android AVDs exist but are not running, README/portfolio docs are stale, and the next useful slice is an Android emulator visual smoke review.
- Android emulator visual smoke review was completed on `Pixel_6_API_33`; startup/login, keyboard-open login, Home/Dashboard, a Dashboard BMI link, Explore, Tools, Library, and Settings theme controls rendered without a blocking layout failure, and one non-blocking Local profile status-bar contrast follow-up was recorded before portfolio screenshots.
- Local profile status-bar contrast polish was completed; Login now owns a route-local light system overlay, the Pixel 6 emulator shows readable light/dark login status-bar icons, keyboard-open login still fits, and local profile submission still reaches Home.
- README current-state refresh was completed; the README now reflects the current Android-first Flutter stack, active app surfaces, setup and verification commands, Phase 9 runtime findings, and known deferrals without starting screenshots, release signing, or toolchain work.
- Phase 9 completion checkpoint was completed; automated gate evidence, Android AVD baseline, Pixel 6 emulator smoke findings, Local profile polish, and README refresh are recorded, while portfolio screenshots, screenshot assets, release signing, store packaging, full device matrix testing, richer app content, and portfolio copywriting are deferred.
- Phase 10 app content depth kickoff audit was completed; Home/Dashboard, Explore, Tools, Library, and direct module routes were reviewed, and the next smallest useful implementation slice is a Tools Clock time display MVP.
- Clock time display MVP was completed; Tools now opens a simple Clock screen with device local time and DST-correct California time updating once per second, while analog/canvas drawing remains deferred until a reference image is provided.
- Clock analog/canvas face follow-up was completed; the Clock screen now draws a theme-compatible analog clock with `CustomPainter` while keeping the existing digital local and California rows.
- Next local utility/content-depth audit was completed; Tools remains the best low-risk Phase 10 surface, and a Random Picker MVP is the next smallest local utility slice.
- Random Picker MVP was completed; Tools now opens a simple local picker that accepts one option per line, validates at least two choices, and selects a deterministic-testable random result without persistence or animation.
- Phase 10 content-depth checkpoint audit was completed; Tools is now meaningfully useful with BMI, Clock, and Random Picker, while Home/Dashboard is still a bare legacy list and should receive the next small content-depth slice.
- Home dashboard quick actions refresh was completed; Dashboard remains the Home tab body and now uses simple scroll-safe sections to surface BMI, Clock, Random Picker, Random Fox, Summertime Saga, the existing Test Screen link, and logout.
- Library/Reader foundation audit was completed; no Reader, bookmark, saved-article, reading-progress, or local database code exists yet, so the next slice should add only a small local Reader text screen before persistence or import work.
- Reader text screen MVP was completed; Library now opens a simple local Reader screen with one built-in sample, without persistence, imports, parser work, reader settings, fullscreen mode, or new packages.
- Library saved-content persistence audit was completed; the smallest useful next slice is saving/removing the built-in Reader sample with the existing `shared_preferences` pattern, not adding Drift, generic bookmarks, saved articles, or reading-progress offsets yet.
- Reader saved sample MVP was completed; the built-in sample can now be saved/removed through Reader and reflected in Library using `shared_preferences`, without Drift, generic bookmarks, saved articles, imports, or progress offsets.
- T93 Phase 10 content-depth checkpoint audit was completed; Tools now has three useful local utilities, Home/Dashboard surfaces those modules as quick actions, and Library has a persisted Reader sample signal. Explore is now the best next small content-depth surface because it still has only two simple module launch cards.
- Explore content cards refresh was completed; Explore now has richer entry cards for Random Fox and Summertime Saga, without loading API data from the tab, adding routes, adding packages, changing persistence, or redesigning the shell.
- Reader next-step audit was completed; the current Reader path is still one built-in sample plus one saved boolean, so local text comfort controls are the smallest useful Reader follow-up before persistence or data-model work.
- Reader text comfort controls MVP was completed; the Reader sample now offers screen-local Small / Comfort / Large text sizing while keeping save/remove state, Library reflection, routing, persistence, and data model unchanged.
- Phase 10 feature backlog expansion was completed; portfolio, screenshot, release presentation, and employer-showcase work are deferred until explicitly requested, and the next recommended content-depth slice is the Unit Converter local tool MVP.
- Unit Converter local tool MVP was completed; Tools now opens a simple local converter for length and weight units, without packages, APIs, persistence, currency/rates, conversion history, or dashboard redesign.

## Recommended Next Work

Current phase:

- Phase 10 — App Content and Surface Depth

Task sizing note:

- Continue applying safety skills, but bundle work by scope when possible.
- Do not use the Fox multi-step sequence as the default template for every screen.
- Simple screens should usually be handled in one task.
- API/live-network screens may justify extra hardening tasks.

### Product track status

Product implementation is paused after `T120`. Do not begin `T121` or another product task unless the user assigns it or explicitly resumes the product track.

### Deferred product task

T121 - Library bookmark shelf next-step audit

Reason:

- Reader now has saved samples, Continue reading, finished state, and one paragraph bookmark per built-in sample.
- Library currently reflects bookmarks inside existing cards, but a dedicated bookmark shelf could duplicate Saved samples or make the tab too long.
- A short audit should decide whether the next implementation slice should be a compact Library bookmarked-samples shelf, Reader scroll-position persistence, or another local content-depth slice.

Scope:

- Review the current Reader bookmark persistence, Reader paragraph controls, Library Saved samples shelf, Continue reading card, Local samples catalog, and small-screen Library scroll impact.
- Identify the smallest useful next Phase 10 Reader/Library content-depth implementation slice.
- Recommend exactly one primary next implementation task.
- Prefer local Reader/Library usefulness over public APIs, screenshots, release work, or broad redesign.
- Do not implement a feature in this audit.

Out of scope:

- No public API, new packages, SQLite/Drift, import/parser work, saved-article models, multiple bookmarks per sample, bookmark shelf/list implementation, scroll-position persistence implementation, reading-progress offsets, reading percentage, reading history list, notes, highlights, persisted reader settings, broad Library redesign, dashboard redesign, screenshots, portfolio/showcase prep, release work, Android build/toolchain changes, shell route migration, or Riverpod/go_router/Dio migration.

Verification:

- Docs/audit gate from `docs/qa/git-workflow.md`: `git diff --check`.

### Alternatives

Library bookmarked samples shelf MVP

Choose this if the user wants to skip the audit and directly add a compact bookmarked-samples section using the existing one-bookmark-per-sample state.

Reader scroll-position persistence audit

Choose this if the user wants automatic position restore, percentage, or offset tracking before more bookmark-facing UI.

Explore/RSS foundation audit

Choose this if the user wants to evaluate public content/API expansion after the current local Reader/Library content-depth run.

### Portfolio / screenshot / showcase deferral policy

Portfolio screenshots, screenshot capture, README screenshot assets, CH Play release presentation, release signing/store packaging, employer/recruiter showcase prep, and portfolio copywriting are deferred while Phase 10 feature/content building is active.

Resume this work only when the user explicitly asks for release, CH Play, portfolio, screenshots, employer/recruiter showcase, or public presentation work.

### Do not start yet

- Global retry/cache/offline policy without a concrete feature need.
- Riverpod implementation slices unless a future feature has concrete shared-state ownership.
- Theme style switching, Neon/Vice themes, or visual redesign before a dedicated theme-style task.
- `ShellRoute`/`StatefulShellRoute` implementation before real tab root screens and tab-owned child route stacks exist.
- Broad `lib/main.dart` app composition refactor beyond root router parity.
- Removing `AppRoutes` or active go_router routes.
- Built-in Kotlin migration.
- Real backend authentication.
- More design-system components unless explicitly assigned.
- Full UI redesign unless explicitly approved.
- Saved picker lists, weighted choices, picker history, or advanced wheel animation/physics before a dedicated follow-up task is assigned.
- Drift/SQLite reader storage, generic bookmarks, saved-article models, multiple bookmarks per sample, reading-progress offsets, persisted reader settings, or import/parser work before a dedicated Reader persistence/model task is assigned.
- RSS/news foundation, public API expansion, or Explore live-network loading before a dedicated Explore/RSS task is assigned.
- Additional Fox follow-up tasks unless a concrete risk, failed verification, blocker, or user-approved remaining scope exists.
- Test screen deletion or route removal unless explicitly approved.
- Riverpod/go_router migration inside Summertime Saga networking follow-up tasks unless explicitly scoped.
- Portfolio screenshots, screenshot capture/assets, README screenshots, CH Play release presentation, release signing/store packaging, full device matrix testing, employer/recruiter showcase prep, or portfolio copywriting unless the user explicitly asks for release/showcase work.

### Phase guard

Current phase:

- Phase 10 — App Content and Surface Depth.

Decision:

- T120 implemented one persisted paragraph bookmark per built-in Reader sample. `T121` is deferred while Harness Phase 1 Foundation is complete; it is not an active product recommendation.

Do not enter yet:

- Screenshot capture, release-readiness work, release signing, store packaging, full device matrix testing, CH Play presentation, employer/recruiter showcase prep, or portfolio copywriting unless the user explicitly asks for release/showcase work.
- Drift/schema persistence, RSS/news/API expansion, shell routing, or broad dashboard redesign before a dedicated task is assigned.

Reason:

- Phase 9 completed the useful QA/device readiness loop: automated Flutter gates passed during the phase, Android AVDs are available, the Pixel 6 emulator visual smoke review found no blocking layout failure across the checked startup/tab/module flows, the Local profile status-bar contrast follow-up is complete, and README current-state docs are refreshed.
- The user explicitly redirected Phase 10 away from portfolio/screenshot readiness during active content building, so release/showcase work is deferred until explicitly requested.
- The current Clock tool adds a small local Tools surface beside BMI with digital time rows and a `CustomPainter` analog face, without public APIs, persistence, dashboard redesign, shell routing, image assets, or portfolio screenshot work.
- The T85 audit found Tools is still the smallest low-risk Phase 10 surface because it can add the documented Wheel/random-picker direction as a local MVP without public APIs, persistence, packages, or a broad redesign.
- The Random Picker MVP adds that local tool without animated wheel/canvas work, saved lists, history, packages, persistence, or broader routing changes.
- The T87 checkpoint found Tools is now meaningfully useful, but Home still presents a bare legacy Dashboard list and should surface existing useful modules before screenshots or a broader Home migration.
- The T88 refresh gives Home a simple scroll-safe quick-actions surface while keeping Dashboard ownership, direct routes, logout, and the five-tab shell stable.
- The T89 audit found Library still has no Reader/bookmark/saved-content route or module, so a single local Reader text screen is the smallest useful Library content-depth slice.
- The T90 Reader MVP gives Library a real local reading surface; persistence and saved-content behavior should be audited before storage code is added.
- The T91 audit found the app has no local database or multi-item Reader content yet, so one `shared_preferences`-backed saved state for the built-in sample is enough before Drift, generic bookmarks, saved articles, or reading-progress offsets.
- The T92 saved sample MVP gave Library a first persisted content signal, which made T93 the right checkpoint before adding more Reader or content-depth implementation.
- The T93 checkpoint found Tools, Home/Dashboard, and Library now have useful Phase 10 content-depth slices, while Explore still only offers two simple launch cards. A small Explore refresh is the least risky next content-depth step before screenshots, RSS/news, or deeper Reader persistence.
- The T94 Explore refresh gives the Explore tab richer static content without moving network work into the tab, so the next content-depth decision can return to Reader/Library before deeper persistence or screenshot prep.
- The T95 audit found Reader still has only one built-in sample and one saved boolean. Local text comfort controls are the smallest useful Reader follow-up because they improve the current reading surface without creating a storage model, import path, route hierarchy, or persisted settings contract.
- The T96 Reader controls make the current Reader sample more useful without new storage or routing.
- The T98 Unit Converter MVP adds another practical local Tool without public APIs, packages, persistence, currency/rates, conversion history, or dashboard redesign.
- Decision Wheel is the next smallest useful Phase 10 implementation slice because it adds a more visual local utility while staying package-free and smaller than Reader storage, RSS/API expansion, or broad dashboard work.
- The T99 Decision Wheel MVP adds a local visual picker with focused tests and no packages, persistence, screenshots, portfolio work, or broad Tools redesign.
- The T100 Decision Wheel refinement makes that local utility feel more polished with a larger animated wheel, reference-inspired segment colors, entry shuffle/sort actions, and remove-selected behavior without adding packages or persistence.
- The T101 Decision Wheel layout/result overlay refinement removes the redundant bottom Spin button, keeps center spin as the primary action, floats the selected-result card above the content, improves pointer layering, and prevents adjacent duplicate segment colors while preserving the existing route and feature structure.
- The T102 Decision Wheel result/input refinement replaces the floating result overlay with a blocking modal dialog, keeps Cancel/Remove behavior scoped to the selected entry, and supports mixed line/semicolon entry parsing without changing routes, persistence, packages, or the wheel painter style.
- The T103 Decision Wheel history slice keeps prior spin results in screen-local memory only, exposes them through a History bottom sheet, and supports clearing that session list without adding persistence or a permanent main-screen section.
- The T104 Decision Wheel history-sheet refinement keeps the modal history design but makes empty/short history wrap compactly and long history scroll within a capped sheet.
- The T105 Decision Wheel history sizing refinement keeps the current design but makes the sheet lighter: empty/short history wraps content, up to five items are visible, and longer history scrolls inside the sheet while actions stay fixed.
- The T106 Decision Wheel history row refinement restores two-line item readability and adds a per-item copy action with lightweight SnackBar feedback, without persistence, export, or sheet redesign.
- The T107 Decision Wheel history max-height refinement removes the five-item rule and lets the sheet grow naturally until the screen-based max height while keeping the header and actions fixed.
- The T108 Decision Wheel history height/spacing tune keeps screen-based max-height behavior while increasing the cap to about 61%, improving header spacing, and making rows less cramped with subtle dividers.
- The T109 Decision Wheel history row readability tune improves the two-line row spacing and selected-item prominence without changing the max-height behavior, copy action, persistence, or broader sheet design.
- The T110 Decision Wheel compact mobile layout removes extra vertical chrome, keeps the wheel as the hero element, and bounds the entries editor without adding x2/duplicate mode, persistence, packages, or new wheel logic.
- The T111 Decision Wheel multiplier mode adds x1/x2/x3 segment generation with distributed duplicates while leaving the raw entries text unchanged and removing selected items from the raw entry list.
- The T112 Reader/Library content-depth slice adds more built-in local reading content without committing to Drift, imports, generic bookmarks, or reading-progress persistence.
- The T113 Reader save selected local samples slice makes the new sample catalog saveable with the existing `shared_preferences` direction before any generic bookmark, saved-article, Drift, import, or progress model work.
- The T114 Reader/Library next-step audit found Library currently exposes saved sample state only through a count/summary and saved labels inside the full local catalog. A Library saved-samples shelf is the smallest useful next slice because it makes saved local content directly actionable while reusing existing saved IDs and Reader route behavior.
- The T115 Library saved samples shelf makes saved local samples directly actionable without adding storage models, imports, or progress offsets. A small Continue reading card is the next useful Reader/Library handoff before any full progress, bookmark, or database design.
- The T116 Reader continue-reading card adds one local handoff without creating progress offsets, bookmark models, reading history, or Drift storage. The next Reader step should be audited before adding more persistence semantics.
- The T117 Reader progress/bookmark audit found a finished-sample marker is the smallest useful progress step because it adds a real per-sample progress signal without scroll offsets, percentages, bookmarks, history, imports, or a database schema.
- The T118 finished marker adds that per-sample progress signal with `shared_preferences`/Riverpod and Library card reflection, so bookmark semantics should be audited before adding a new Reader storage behavior.
- The T119 bookmark model audit found sample-level bookmarks would duplicate saved samples, and selected one paragraph bookmark per built-in sample as the smallest useful bookmark behavior before multiple bookmarks, notes, highlights, scroll offsets, or Drift.
- The T120 paragraph bookmark MVP adds one validated `shared_preferences`/Riverpod bookmark slot per built-in sample, Reader paragraph controls, and Library card reflection. A short Library bookmark shelf audit should decide the next Reader/Library UI slice before adding another section, scroll offsets, multiple bookmarks, notes, highlights, or Drift.
- `/main`, startup/session, local profile behavior, Riverpod theme/profile state, Dio-backed services, and the five-tab shell must remain stable during Phase 10 content work.
- App content depth should not be mixed with real backend authentication, shell-route work, retry/cache/offline policy, Android toolchain changes, screenshots, or release packaging.

Exit criteria:

- Done: Completed the Phase 7 networking foundation kickoff audit.
- Done: Confirmed at T65 that Dio was not installed yet and direct `http` usage was limited to Fox and Summertime Saga services.
- Done: Implemented and verified the T66 Dio/Fox pilot.
- Done: Implemented and verified the T67 Summertime Saga Dio migration and removed the unused `http` dependency.
- Done: Completed the T68 checkpoint audit and closed Phase 7.
- Done: Completed the T69 Phase 8 kickoff audit and selected the first tab-root slice.
- Done: Implemented the T70 Tools tab BMI catalog slice.
- Done: Implemented the T71 Explore existing modules catalog slice.
- Done: Completed the T72 Library placeholder content audit.
- Done: Implemented the T73 Library empty-state tab body.
- Done: Completed the T74 Home dashboard cleanup audit.
- Done: Implemented the T75 Home dashboard first cleanup slice.
- Done: Completed the T76 Phase 8 checkpoint audit and closed the first tab-surface pass.
- Done: Completed the T77 Phase 9 QA/device readiness kickoff audit.
- Done: Completed the T78 Android emulator visual smoke review on `Pixel_6_API_33`.
- Done: Completed the T79 Local profile status-bar contrast polish slice.
- Done: Completed the T80 README current-state refresh.
- Done: Completed the T81 Phase 9 completion checkpoint and closed Phase 9.
- Done: Completed the T82 Phase 10 app content depth kickoff audit and selected T83 as the next implementation slice.
- Done: Implemented the T83 Clock time display MVP.
- Done: Implemented the T84 Clock analog/canvas face follow-up.
- Done: Completed the T85 next local utility/content-depth audit and selected T86 as the next implementation slice.
- Done: Implemented the T86 Random Picker MVP.
- Done: Completed the T87 Phase 10 content-depth checkpoint audit and selected T88 as the next implementation slice.
- Done: Implemented the T88 Home dashboard quick actions refresh.
- Done: Completed the T89 Library/Reader foundation audit and selected T90 as the next implementation slice.
- Done: Implemented the T90 Reader text screen MVP.
- Done: Completed the T91 Library saved-content persistence audit and selected T92 as the next implementation slice.
- Done: Implemented the T92 Reader saved sample MVP.
- Done: Completed the T93 Phase 10 content-depth checkpoint audit and selected T94 as the next implementation slice.
- Done: Implemented the T94 Explore content cards refresh.
- Done: Completed the T95 Reader next-step audit and selected T96 as the next implementation slice.
- Done: Implemented the T96 Reader text comfort controls MVP.
- Done: Completed the T97 Phase 10 feature backlog expansion and deferred portfolio/screenshot/showcase work until explicitly requested.
- Done: Implemented the T98 Unit Converter local tool MVP.
- Done: Implemented the T99 Decision Wheel local tool MVP.
- Done: Implemented the T100 Decision Wheel UI/UX refinement.
- Done: Implemented the T101 Decision Wheel layout/result overlay refinement.
- Done: Implemented the T102 Decision Wheel result modal and entries input refinement.
- Done: Implemented the T103 Decision Wheel in-memory session history slice.
- Done: Implemented the T104 Decision Wheel history bottom sheet height refinement.
- Done: Implemented the T105 Decision Wheel history sheet sizing refinement.
- Done: Implemented the T106 Decision Wheel history item layout and copy action refinement.
- Done: Implemented the T107 Decision Wheel history sheet max-height refinement.
- Done: Implemented the T108 Decision Wheel history sheet height and item spacing refinement.
- Done: Implemented the T109 Decision Wheel history item readability refinement.
- Done: Implemented the T110 Decision Wheel compact mobile layout refinement.
- Done: Implemented the T111 Decision Wheel multiplier mode.
- Done: Implemented the T112 Reader/Library content-depth slice.
- Done: Implemented the T113 Reader save selected local samples MVP.
- Done: Completed the T114 Reader/Library next-step audit and selected T115 as the next implementation slice.
- Done: Implemented the T115 Library saved samples shelf MVP.
- Done: Implemented the T116 Reader continue-reading card MVP.
- Done: Completed the T117 Reader progress/bookmark next-step audit and selected T118 as the next implementation slice.
- Done: Implemented the T118 Reader finished sample marker MVP.
- Done: Completed the T119 Reader bookmark model audit and selected T120 as the next implementation slice.
- Done: Implemented the T120 Reader single paragraph bookmark MVP.
- Remaining: Resume `T121` Library bookmark shelf next-step audit only after the user resumes product work, or follow another explicitly assigned product task.

## Verification Gates

Use `docs/qa/git-workflow.md` as the source of truth.

Select gates by change risk from that matrix; do not duplicate command requirements here. Task results must report required command outcomes, focused diff/status review, and manual/runtime evidence or unverified areas.

## Asking for the Next Task

If the user asks "what is the next product task?", report that product work is paused and `T121` is deferred unless the user explicitly resumes it. For Harness work, use the active approved sequence in `docs/harness/`.

If the user assigns a different task, follow the user task and update planning docs only when it changes priority, phase, backlog, or durable decisions.
