# InfinityWorld

InfinityWorld is an Android-first, iOS-ready personal super-app built with Flutter.

The project is designed as a polished modular personal hub that can grow over time with tools, trackers, reader features, RSS/news, AI utilities, and device integrations.

The goal is not to add many features quickly. The goal is to build a clean, maintainable, visually consistent, and portfolio-quality Flutter application.

## Product Direction

InfinityWorld is a personal app made of multiple small and medium-sized modules.

Planned module areas include:

* Tools
* Trackers
* RSS/news
* Reader/library
* AI utilities
* Device/Bluetooth/audio utilities
* Local profile and settings

The app is Android-first, but the architecture and UI direction should remain iOS-ready for future support.

## Current Status

This project is being restructured and modernized.

Current direction:

```text
Android-first
iOS-ready
Local-first
Portfolio-ready
Modular feature-first architecture
Custom design system
Light/dark mode support
```

Existing legacy code may still exist during migration. New code should follow the documented architecture and design direction.

## Main Navigation

The planned main app shell uses five bottom navigation tabs:

```text
Home | Explore | Tools | Library | Settings
```

### Home

Dashboard, pinned modules, recently used modules, quick actions, and personal summary cards.

### Explore

RSS/news, game updates, trackers, and discovered content.

### Tools

BMI, wheel/random picker, Device Hub, AI Lab, converters, and other utilities.

### Library

Reader, saved articles, bookmarks, and reading progress.

### Settings

Local profile, theme, permissions, app configuration, and app information.

## Design Direction

Default design system:

```text
Midnight Violet Dashboard
```

Design goals:

* Android-first
* iOS-ready
* Modern dashboard feel
* Futuristic but controlled
* Light and dark mode support
* Subtle neon accents
* Clean typography
* Portfolio-friendly polish

The first design implementation should support:

```text
Midnight Violet Light
Midnight Violet Dark
```

Future optional theme directions may include:

```text
Neon Community Dark
Vice Heat
```

## Typography

Approved typography direction:

```text
Sora + Inter
```

Usage:

* Sora: headings, hero text, important section titles
* Inter: body text, labels, inputs, navigation, buttons, and dense UI

## Tech Stack Direction

Planned stack for new code:

```text
Flutter
Riverpod
go_router
Dio
Drift
shared_preferences
Freezed
json_serializable
```

UI/design:

```text
Material 3
Custom InfinityWorld Design System
Inter + Sora
SVG/vector-friendly assets
```

Future device/audio features may use packages such as:

```text
permission_handler
flutter_blue_plus
bluetooth_low_energy
flutter_blue_classic
just_audio
audio_session
audio_service
```

These should only be added when the related feature is actively implemented.

## Architecture Direction

InfinityWorld uses a feature-first modular architecture.

Target structure:

```text
lib/
  app/
    app.dart
    router/
    theme/
    bootstrap/
    shell/

  core/
    config/
    network/
    database/
    permissions/
    errors/
    logging/
    utils/

  design_system/
    tokens/
    components/
    layout/
    effects/

  features/
    auth/
    home/
    explore/
    tools/
    library/
    settings/
    bmi/
    wheel/
    summertime_saga/
    news/
    reader/
    ai_lab/
    device_hub/
```

Small features may stay simple. Larger features can use deeper layering:

```text
features/example/
  data/
  domain/
  application/
  presentation/
```

## State Management

New code should use:

```text
Riverpod
```

Riverpod is used for:

* App-level dependencies
* Feature controllers
* Async state
* Theme state
* Local session/profile state
* Repository/service injection

Legacy GetX code may still exist during migration, but new code should not expand GetX usage.

## Routing

New routing direction:

```text
go_router
```

Expected startup flow:

```text
Native Splash
→ Flutter Bootstrap / Splash
→ Check local session
→ If previously logged in: Home
→ If not logged in: Login / Local Profile
```

The initial login is a local/fake profile flow, not real backend authentication.

## Local-First Direction

The early app is local-first.

Initial local state may include:

* Local profile
* Session flag
* Theme preference
* Recently used modules

Structured persistence may be added later for:

* Bookmarks
* Saved articles
* Reading progress
* Tracker configuration
* Known devices

## Performance and App Size Direction

The app should remain performance-aware and size-conscious.

Rules:

* Lazy-load features
* Do not load all modules on Home startup
* Do not call APIs from widget `build()` methods
* Avoid unnecessary packages
* Avoid heavy blur/glass effects
* Use subtle glow only where useful
* Keep font weights limited
* Prefer SVG for simple vector assets
* Prefer WebP for large raster assets where appropriate

## Documentation

Project decisions are documented in:

```text
AGENTS.md
docs/PROJECT_DIRECTION.md
docs/ARCHITECTURE.md
docs/DESIGN_SYSTEM.md
docs/ROADMAP.md
```

Before making significant changes, read the relevant documentation.

## Roadmap Summary

Recommended development order:

```text
Phase 0: Documentation baseline
Phase 1: Stabilize existing app
Phase 2: App bootstrap, splash, and local session
Phase 3: Theme foundation and design tokens
Phase 4: App shell and bottom navigation
Phase 5: Routing migration to go_router
Phase 6: Riverpod foundation
Phase 7: Home dashboard
Phase 8: BMI as first clean module
Phase 9: Summertime Saga hardening
Phase 10: Settings, profile, and appearance
Phase 11: Explore and RSS/news foundation
Phase 12: Library and Reader foundation
Phase 13: Device Hub foundation
Phase 14: AI Lab foundation
Phase 15: App icon, branding, and splash polish
Phase 16: Portfolio readiness
```

## Known Current Risks

Initial review found several risks to address during stabilization:

```text
High:
- Login screen may call setState() from build()
- Android release manifest may be missing INTERNET permission
- Summertime Saga flow may spin forever or crash on null/error states

Medium:
- Dev/Prod config is not fully meaningful yet
- No test/ directory exists
- pubspec.lock / Dart version mismatch may exist
- Some controller/focus lifecycle leaks may exist
- Android release signing is not production-ready

Low:
- Some routes/screens may be dead or incomplete
- Settings screen may be unreachable
- Some dependencies may be placed incorrectly
```

These should be fixed in small, focused tasks.

## Development Notes

Preferred verification commands:

```bash
flutter pub get
flutter analyze
flutter test
flutter build apk --debug
```

Do not claim a command passed unless it was actually run.

## Project Philosophy

InfinityWorld should grow as a consistent personal platform, not as a collection of unrelated screens.

Every new feature should answer:

```text
Does it fit one of the main tabs?
Does it follow the InfinityWorld Design System?
Can it be developed without breaking other modules?
Does it keep the app useful, polished, and maintainable?
Does it improve the portfolio value of the project?
```

Quality and consistency are more important than feature count.
