# InfinityWorld — Roadmap

## 1. Roadmap Goal

This roadmap defines the recommended development order for InfinityWorld.

InfinityWorld should grow as a polished Android-first, iOS-ready personal super-app and portfolio Flutter project.

The priority is:

```text id="dh8mia"
Stability → Architecture → Design System → App Shell → Core Modules → Advanced Features
```

The goal is not to add many features quickly. The goal is to build a clean, maintainable, visually consistent, and extensible app.

## 2. Development Principles

Use these principles when deciding what to build next:

```text id="7r8fc6"
1. Stabilize before expanding.
2. Document before large refactors.
3. Build foundation before features.
4. Keep tasks small and reviewable.
5. Prefer polished core screens over many incomplete screens.
6. Avoid adding packages before they are needed.
7. Avoid rewriting everything at once.
8. Migrate legacy code gradually.
9. Keep Android as the main target.
10. Keep iOS readiness in mind.
```

Every roadmap phase should leave the app in a runnable state.

## 3. Current Starting Point

Initial Codex review identified that the current app is a small Flutter project using GetX routing, local widget state, direct `http` calls, and simple screens.

Known current state:

```text id="33k62l"
- Entrypoint: lib/main.dart
- Current routing: GetX
- Current startup: /login
- Current state management: StatefulWidget/setState/FutureBuilder
- Current networking: http directly inside feature services
- Current config: dart-define based constants
- No test/ directory exists
- No real authentication exists
- No repository layer exists
- No centralized error model exists
- No custom design system exists yet
```

Known risks:

```text id="0bj15j"
High:
- login_screen calls setState() from build()
- Android release manifest may be missing INTERNET permission
- Summertime Saga flow can spin forever or crash on null/error states

Medium:
- Dev/Prod config is not fully meaningful yet
- No tests
- pubspec.lock / Dart version mismatch may exist
- Some controller/focus lifecycle leaks may exist
- Android release signing is not production-ready
- Some platform identifiers may still contain example defaults

Low:
- Some routes/screens are dead or incomplete
- Settings screen may be unreachable
- Some dependencies may be placed incorrectly
```

## 4. Target Product Direction

Confirmed direction:

```text id="50as6m"
Product:
Android-first, iOS-ready personal super-app and portfolio Flutter project.

Startup:
Native Splash → Flutter Splash/Bootstrap → Local session check → Login or Home.

Auth:
Fake/local profile first.
Real auth later.

Navigation:
Home | Explore | Tools | Library | Settings.

Design:
Midnight Violet Dashboard as the default design system.
Light/dark mode from the beginning.
Neon Community Dark may be a future optional theme.

Architecture:
Riverpod for new state/dependency.
go_router for new routing.
Dio for new networking.
Drift for structured local storage when needed.
shared_preferences for session/settings.
Feature-first modular structure.
GetX legacy only.
```

## 5. Phase 0 — Documentation Baseline

### Goal

Create the baseline documentation that future Codex/agent tasks must follow.

### Scope

Create or update:

```text id="6l44km"
AGENTS.md
docs/PROJECT_DIRECTION.md
docs/ARCHITECTURE.md
docs/DESIGN_SYSTEM.md
docs/ROADMAP.md
```

### Expected Result

The repo clearly documents:

* Product direction
* Architecture direction
* Design system direction
* Development roadmap
* Agent rules

### Completion Criteria

```text id="fr7hja"
- AGENTS.md exists at repo root.
- docs/PROJECT_DIRECTION.md exists.
- docs/ARCHITECTURE.md exists.
- docs/DESIGN_SYSTEM.md exists.
- docs/ROADMAP.md exists.
- Future tasks can reference these files instead of repeating all decisions.
```

### Notes

This phase should not modify app behavior.

## 6. Phase 1 — Stabilize Existing App

### Goal

Fix high-risk issues in the current app without performing a large architecture rewrite.

### Scope

Recommended tasks:

```text id="hu86d1"
1. Review existing modified files:
   - android/gradle.properties
   - pubspec.lock

2. Fix login lifecycle bug:
   - Remove setState() calls from build().
   - Use MediaQuery.viewInsetsOf(context).bottom or a safer layout approach.
   - Keep behavior equivalent where possible.

3. Add Android release INTERNET permission:
   - Ensure release builds can use network features.

4. Add minimal test foundation:
   - Create test/ if missing.
   - Add app/login smoke test if practical.
   - Add BMI calculator test if BMI logic is isolated.

5. Run verification:
   - flutter pub get
   - flutter analyze
   - flutter test if tests exist
   - flutter build apk --debug if practical
```

### Expected Result

The existing app becomes safer to run and modify.

### Completion Criteria

```text id="olufqh"
- Login no longer calls setState() during build.
- Android release manifest has INTERNET permission.
- flutter analyze passes.
- Basic test directory exists if feasible.
- Debug APK build is verified if feasible.
```

### Non-Goals

```text id="ixv8wq"
- Do not migrate all routing yet.
- Do not rewrite all screens.
- Do not implement full theme system yet.
- Do not add new major features.
```

## 7. Phase 2 — App Bootstrap, Splash, and Local Session

### Goal

Implement the intended startup flow.

### Target Flow

```text id="ztq69d"
Native Splash
→ Flutter Bootstrap / Splash
→ Check local session
→ If logged in: Home
→ If not logged in: Login / Local Profile
```

### Scope

Recommended tasks:

```text id="ujkb4n"
1. Add bootstrap/startup layer.
2. Add local session repository using shared_preferences.
3. Convert login into local profile login if needed.
4. Store local session after login.
5. Redirect returning users to Home.
6. Add logout/reset local session from Settings later if Settings exists.
7. Add smoke tests for startup routing if practical.
```

### Expected Files

Possible structure:

```text id="tmi7et"
lib/app/bootstrap/
  app_bootstrap.dart
  startup_controller.dart

lib/features/auth/
  local_session_repository.dart
  local_profile.dart
  login_screen.dart
```

### Expected Result

The app starts predictably and remembers local login state.

### Completion Criteria

```text id="zwr2e8"
- First launch routes to Login.
- Local login stores session/profile.
- Relaunch routes to Home when session exists.
- Logout/reset path is planned or implemented.
- Startup logic is not placed inside widget build methods.
```

### Non-Goals

```text id="h6fxkc"
- Do not implement backend auth.
- Do not add cloud sync.
- Do not implement complex onboarding.
```

## 8. Phase 3 — Theme Foundation and Design Tokens

### Goal

Implement the first version of the InfinityWorld Design System foundation.

### Scope

Implement:

```text id="ic6sya"
1. Midnight Violet light/dark color tokens.
2. Inter + Sora typography setup.
3. Spacing/radius tokens.
4. Basic ThemeData for light and dark mode.
5. Theme mode state:
   - System
   - Light
   - Dark
6. Persist theme mode with shared_preferences.
7. Initial reusable UI components.
```

### Initial Components

Recommended first components:

```text id="555dd0"
IwAppScaffold
IwButton
IwCard
IwTextField
IwEmptyState
IwErrorView
IwLoadingView
IwModuleCard
IwSectionHeader
```

### Expected Result

The app has a consistent light/dark theme foundation and reusable components.

### Completion Criteria

```text id="2hdh3q"
- Midnight Violet light/dark theme exists.
- Theme mode can follow system/light/dark.
- Theme preference persists.
- Core screens use ThemeData/design tokens instead of hard-coded colors where practical.
- Initial components are reusable.
```

### Non-Goals

```text id="jagmq9"
- Do not implement Neon Community Dark yet.
- Do not implement Vice Heat yet.
- Do not create a heavy animation system.
- Do not polish every old screen in one task.
```

## 9. Phase 4 — App Shell and Bottom Navigation

### Goal

Implement the main app shell with the confirmed bottom navigation.

### Confirmed Bottom Navigation

```text id="vmslsh"
Home | Explore | Tools | Library | Settings
```

### Scope

Recommended tasks:

```text id="grdbq1"
1. Add app shell structure.
2. Add bottom navigation.
3. Create initial placeholder/root screens for:
   - Home
   - Explore
   - Tools
   - Library
   - Settings
4. Make shell visually follow Midnight Violet.
5. Ensure shell does not load all feature modules at startup.
6. Prepare route organization for go_router migration.
```

### Expected Result

The app has a stable main navigation surface and can host future features cleanly.

### Completion Criteria

```text id="v6jek3"
- Bottom nav has 5 confirmed tabs.
- Each tab has a placeholder/root screen.
- Navigation works without broken routes.
- Shell uses design system components/tokens.
- No feature loads heavy network/database work on shell startup.
```

### Non-Goals

```text id="r4n46v"
- Do not fully implement all tab contents.
- Do not move every old screen in one task.
- Do not implement all feature modules yet.
```

## 10. Phase 5 — Routing Migration to go_router

### Goal

Move new navigation direction to go_router while keeping migration safe.

### Scope

Recommended tasks:

```text id="g3q5fn"
1. Introduce go_router.
2. Define route names/paths.
3. Add startup/session redirect logic if not already done.
4. Add shell routes for bottom tabs.
5. Migrate routes feature by feature.
6. Remove GetX routing only after replacement is stable.
```

### Expected Route Groups

```text id="5vcqbl"
/splash
/login
/home
/explore
/tools
/library
/settings

/tools/bmi
/tools/wheel
/tools/device-hub

/explore/news
/explore/summertime-saga

/library/reader
/library/book/:bookId
```

### Expected Result

Routing becomes explicit, testable, and future-ready.

### Completion Criteria

```text id="9mtphd"
- go_router is used for new routes.
- Bottom nav routes work.
- Startup redirect works.
- Existing important screens remain reachable.
- GetX usage is reduced or isolated.
```

### Non-Goals

```text id="ww8ch1"
- Do not delete GetX until all dependent code is migrated.
- Do not change feature behavior unnecessarily.
```

## 11. Phase 6 — Riverpod Foundation

### Goal

Introduce Riverpod as the core state/dependency layer for new code.

### Scope

Recommended tasks:

```text id="hacaku"
1. Add Riverpod setup.
2. Add app-level providers for:
   - session/profile
   - theme
   - config if needed
3. Use providers for new dependencies.
4. Refactor only targeted legacy state when needed.
5. Add examples through one or two small features.
```

### Expected Result

New code uses Riverpod consistently.

### Completion Criteria

```text id="zljs4j"
- Riverpod is configured.
- Theme/session can be controlled through providers.
- New screens/features do not use GetX state.
- No Provider/BLoC is introduced unnecessarily.
```

### Non-Goals

```text id="xfnsoy"
- Do not migrate every screen at once.
- Do not add BLoC/Provider.
```

## 12. Phase 7 — Home Dashboard

### Goal

Build the first polished Home dashboard.

### Scope

Recommended Home content:

```text id="ct87yz"
1. Greeting/local profile card.
2. Pinned modules section.
3. Recently used modules placeholder.
4. Quick actions.
5. Summary cards.
6. Continue section placeholder for Library/Reader later.
```

### Expected Result

Home clearly communicates the personal hub concept.

### Completion Criteria

```text id="pfs8py"
- Home follows Midnight Violet design.
- Home is useful even with placeholder module data.
- Home does not load all feature services.
- Module cards are reusable.
```

### Non-Goals

```text id="ipwpzu"
- Do not implement every module.
- Do not add network calls to Home unless necessary.
```

## 13. Phase 8 — BMI as First Clean Module

### Goal

Use BMI as the first clean example module.

### Why BMI First

BMI is small, local, testable, and useful for establishing the project’s feature pattern without API complexity.

### Scope

Recommended tasks:

```text id="fw8fcr"
1. Move/create BMI feature under features/bmi.
2. Add BMI calculator logic.
3. Add BMI screen using design system components.
4. Add result state.
5. Add input validation.
6. Add unit tests for BMI calculation.
7. Add route from Tools to BMI.
```

### Expected Result

BMI becomes the reference implementation for small local modules.

### Completion Criteria

```text id="yjefot"
- BMI feature is isolated.
- BMI calculation is testable.
- BMI UI follows Midnight Violet.
- Tools can navigate to BMI.
- Tests cover key BMI cases.
```

### Non-Goals

```text id="wzkpvk"
- Do not add database persistence unless requested.
- Do not over-layer the small feature.
```

## 14. Phase 9 — Summertime Saga Hardening

### Goal

Turn Summertime Saga into the reference implementation for API/error/loading patterns.

### Scope

Recommended tasks:

```text id="1ixpz9"
1. Replace direct http usage with Dio-based service/repository.
2. Add timeout handling.
3. Add explicit loading/error/data states.
4. Avoid converting all errors to null.
5. Add safe nullable parsing.
6. Add retry support.
7. Add mounted-safe UI updates if StatefulWidget remains.
8. Add tests/mocks where practical.
9. Route from Explore to Summertime Saga.
```

### Expected Result

Summertime Saga becomes a stable API-backed feature.

### Completion Criteria

```text id="ebod0f"
- No infinite loading on error/null response.
- API errors show a user-friendly error state.
- Retry is available.
- Null API fields do not crash the app.
- Dio is used through repository/service boundaries.
```

### Non-Goals

```text id="9qmwo9"
- Do not redesign the entire Explore tab.
- Do not add persistence unless needed.
```

## 15. Phase 10 — Settings, Profile, and Appearance

### Goal

Build functional Settings for local profile, theme mode, permissions, and app info.

### Scope

Recommended sections:

```text id="5rfdto"
Profile
Appearance
Permissions
Data & Storage
About
Developer / Debug if needed
```

### Expected Features

```text id="ejpuwv"
1. View/edit local display name.
2. Logout/reset local session.
3. Change theme mode:
   - System
   - Light
   - Dark
4. Show current app version if available.
5. Permission status placeholders if needed.
```

### Expected Result

Settings becomes the control center for local profile and app preferences.

### Completion Criteria

```text id="g8rr9z"
- User can change theme mode.
- Theme mode persists.
- User can reset/logout local profile.
- Settings follows design system.
- Settings route is reachable from bottom nav.
```

### Non-Goals

```text id="nz8030"
- Do not implement full multi-theme style switching yet.
- Do not implement full permission management until Device Hub or another feature needs it.
```

## 16. Phase 11 — Explore and RSS/News Foundation

### Goal

Create the foundation for external content discovery through RSS/news.

### Scope

Recommended tasks:

```text id="zc1q0b"
1. Create Explore root layout.
2. Add RSS/news feature skeleton.
3. Add Dio/RSS parser where appropriate.
4. Add loading/error/empty states.
5. Add source list.
6. Add article list.
7. Add article detail route.
8. Add saved article/bookmark plan but not necessarily persistence.
```

### Expected Result

Explore becomes useful as a content discovery area.

### Completion Criteria

```text id="668sxb"
- Explore has RSS/news entry.
- Articles can be fetched and displayed.
- Errors do not crash or spin forever.
- UI follows design system.
```

### Non-Goals

```text id="kxedqg"
- Do not implement complex offline storage in the first RSS task.
- Do not scrape websites directly unless explicitly requested.
```

## 17. Phase 12 — Library and Reader Foundation

### Goal

Create the first version of Library/Reader.

### Scope

Recommended tasks:

```text id="fgk9ve"
1. Create Library root.
2. Add Reader feature skeleton.
3. Add local content model.
4. Add reading progress plan.
5. Add bookmarks/saved content plan.
6. Add calm, readable UI surfaces.
```

### Expected Result

Library becomes the future home for reader and saved content features.

### Completion Criteria

```text id="o97hz6"
- Library route exists and is reachable.
- Reader skeleton exists.
- Design supports reading-friendly UI.
- Persistence needs are documented before schema is added.
```

### Non-Goals

```text id="f2ksh2"
- Do not implement full novel backend.
- Do not implement full EPUB/TXT parser unless requested.
- Do not add large sample content.
```

## 18. Phase 13 — Device Hub Foundation

### Goal

Prepare the app for Bluetooth/audio/device features.

### Scope

Recommended tasks:

```text id="8uldek"
1. Create Device Hub under Tools.
2. Add permission architecture.
3. Add Bluetooth/audio feature plan.
4. Add UI for device-related modules.
5. Add package only when implementing actual behavior.
```

### Expected Result

Device Hub becomes the correct place for future Bluetooth/audio work.

### Completion Criteria

```text id="x9uou5"
- Device Hub route exists.
- Device Hub screen follows design system.
- Permission/service boundaries are planned.
- No unnecessary Bluetooth/audio packages are added prematurely.
```

### Non-Goals

```text id="ewt9bd"
- Do not implement full Bluetooth scanning until requested.
- Do not implement full audio playback/background service until requested.
```

## 19. Phase 14 — AI Lab Foundation

### Goal

Create the first structure for future AI utilities.

### Scope

Recommended tasks:

```text id="b2ckj5"
1. Create AI Lab under Tools.
2. Add placeholder utility cards.
3. Define future AI provider strategy.
4. Avoid adding cloud/local AI SDKs before needed.
```

### Expected Result

AI Lab exists as a planned area without introducing unnecessary dependencies.

### Completion Criteria

```text id="xyfbfy"
- AI Lab route exists.
- UI follows design system.
- No unnecessary AI package is added.
- Future provider strategy is documented.
```

### Non-Goals

```text id="czqj5q"
- Do not implement real AI API integration unless requested.
- Do not add API keys/secrets.
```

## 20. Phase 15 — App Icon, Branding, and Splash Polish

### Goal

Polish the branding assets after the design system and shell are stable.

### Scope

Recommended tasks:

```text id="d9h4py"
1. Create or add app icon source.
2. Generate platform launcher icons.
3. Add native splash if not already polished.
4. Add branding assets under assets/branding.
5. Ensure assets are size-conscious.
```

### App Icon Direction

```text id="b7231n"
Infinity symbol + Midnight Violet gradient
```

### Expected Result

The app has recognizable branding.

### Completion Criteria

```text id="mdgjwy"
- Launcher icon works on Android.
- Splash visually matches Midnight Violet.
- Branding assets are organized.
- No oversized unused branding assets are bundled.
```

## 21. Phase 16 — Portfolio Readiness

### Goal

Prepare the project for portfolio presentation.

### Scope

Recommended tasks:

```text id="ury30f"
1. Update README.md.
2. Add screenshots.
3. Add architecture overview.
4. Add setup/run instructions.
5. Add feature list.
6. Add roadmap summary.
7. Add known limitations.
8. Add build/test instructions.
```

### Expected Result

The project can be shown to others as a serious Flutter portfolio app.

### Completion Criteria

```text id="omg4a7"
- README explains the project clearly.
- Screenshots show polished UI.
- Tech stack is documented.
- Architecture decisions are documented.
- Known limitations are honest.
```

## 22. Future Optional Themes

### Neon Community Dark

Potential use:

```text id="4cgynx"
Optional theme
Explore/AI/community mood
Hero sections
Special feature surfaces
```

Do not implement until Midnight Violet is stable.

### Vice Heat

Potential use:

```text id="j3d2cu"
Optional theme
Entertainment modules
Seasonal/event skin
Wheel/game-like tools
```

Do not implement early.

## 23. Suggested Early Task Order

After documentation baseline, recommended first tasks:

```text id="2a0j30"
1. Review current modified files.
2. Fix login setState/build lifecycle bug.
3. Add Android release INTERNET permission.
4. Add minimal test foundation.
5. Add splash/bootstrap/session flow.
6. Add Midnight Violet theme foundation.
7. Add app shell and bottom nav.
8. Start BMI as the first clean module.
```

## 24. Phase Discipline

Each phase should follow this discipline:

```text id="q3cyto"
Before:
- Read AGENTS.md and relevant docs.
- Confirm scope.
- Avoid unrelated refactors.

During:
- Keep changes small.
- Prefer focused commits.
- Avoid adding packages unnecessarily.
- Preserve runnable state.

After:
- Report files changed.
- Report commands run.
- Report commands not run.
- Report remaining risks.
```

## 25. Completion Philosophy

A phase is complete only when it leaves the app in a better and reviewable state.

A phase is not complete if:

```text id="cm6a5t"
- It adds many placeholders without improving structure.
- It breaks existing app startup.
- It adds packages without using them.
- It introduces a new style inconsistent with Midnight Violet.
- It hides errors instead of handling them.
- It performs a broad rewrite without verification.
```

## 26. Roadmap Non-Goals

Do not prioritize these early:

```text id="d7p94g"
Real backend auth
Cloud sync
Full Reader implementation
Full AI Lab implementation
Full Bluetooth/audio implementation
Full multi-theme style switching
Desktop-first UI
Web-first UI
Heavy animation system
Large package additions
```

## 27. Guiding Roadmap Principle

InfinityWorld should grow as a consistent personal platform.

Each phase should answer:

```text id="90gz1h"
Does this improve the foundation?
Does this preserve app stability?
Does this follow the design system?
Does this support future modules?
Does this improve portfolio value?
```

If not, postpone it.
