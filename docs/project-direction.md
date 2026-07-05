# InfinityWorld — Project Direction

## 1. Product Vision

InfinityWorld is a personal, Android-first, iOS-ready Flutter super-app and portfolio project.

The app is intended to be a polished personal hub that can contain many small and medium-sized modules over time, such as tools, trackers, reader features, RSS/news, AI utilities, and device integrations.

The goal is not to add many features as quickly as possible. The goal is to build a clean, maintainable, visually polished, and extensible Flutter app that is useful for personal use and strong enough to present as a portfolio project.

## 2. Product Identity

InfinityWorld is a modular personal world.

Each feature should feel like a small “world” or module inside one consistent app shell and design system.

Examples of possible modules:

* BMI calculator
* Wheel/random picker
* Summertime Saga update tracker
* RSS/news reader
* Novel/story reader
* Saved articles and bookmarks
* AI Lab
* Bluetooth / Device Hub
* Settings and local profile

The app should feel cohesive even when features are unrelated.

## 3. Target Platforms

Primary target:

* Android

Future target:

* iOS

Secondary/non-priority targets:

* Web
* Windows
* Linux
* macOS

The app should be designed Android-first, but avoid Android-only UI assumptions where possible. The UI should be cross-platform-ready so the project can be adapted to iOS later.

Desktop and web builds are useful if they work, but they are not the main product target during early development.

## 4. Product Quality Goals

InfinityWorld should prioritize:

* Polished UI
* Maintainable architecture
* Clear feature boundaries
* Good startup flow
* Good runtime stability
* Local-first behavior
* Reasonable performance
* Controlled app size
* Portfolio-quality documentation

The app should avoid:

* Rushed feature accumulation
* Inconsistent UI styles
* Hard-coded colors and spacing
* Feature code mixed into global app code
* Network calls directly inside widget build methods
* Uncontrolled package growth
* Large refactors without a clear migration plan

## 5. App Startup Direction

The app should have a splash/startup flow.

Expected startup flow:

```text
Native Splash
→ Flutter Bootstrap / Splash
→ Check local session
→ If previously logged in: Home
→ If not logged in: Login / Local Profile
```

The Login screen is not real authentication in the first phase. It is a local profile entry point.

The app should remember the previous local login/profile state using local storage.

A future real authentication system may be added later, but the early app should remain local-first.

## 6. Authentication Direction

Initial direction:

* Fake/local login
* Local profile
* No backend authentication

The local profile may include:

* Display name
* Avatar or avatar preset
* Theme preference
* Last login/session state

Future direction:

* Real authentication may be added later
* Backend sync may be added later
* Existing local profile flow should be designed so it can evolve into real auth without rewriting the whole app

## 7. Main Navigation

The main app shell uses five bottom navigation tabs:

```text
Home | Explore | Tools | Library | Settings
```

### Home

Purpose:

* Main dashboard
* Pinned modules
* Recently used modules
* Quick actions
* Personal summary cards

Examples:

* Continue reading
* Latest tracker update
* Quick access to BMI/Wheel/AI
* Recently opened tools

### Explore

Purpose:

* External content and discovery
* RSS/news
* Game updates
* Trackers
* Watched sources

Examples:

* RSS feed
* Summertime Saga update tracker
* Game tracker cards
* News/source discovery

### Tools

Purpose:

* Utility modules
* Interactive tools
* Device-related tools
* AI utilities

Examples:

* BMI calculator
* Wheel/random picker
* Device Hub
* Bluetooth tools
* Speaker/audio tools
* AI Lab
* Converters

### Library

Purpose:

* Personal saved content
* Reader features
* Bookmarks
* Reading progress

Examples:

* Novel/story reader
* Saved articles
* Bookmarks
* Local reading history
* Downloaded/imported content later

### Settings

Purpose:

* Local profile
* Theme settings
* Permissions
* App configuration
* App information
* Developer/debug utilities if needed

Examples:

* Theme mode
* App style
* Profile name/avatar
* Permission status
* About InfinityWorld

## 8. Feature Grouping

Features should be grouped by product intent, not just technical type.

Initial feature groups:

```text
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

Feature names may evolve, but each module should remain isolated enough to be developed, tested, and removed independently.

## 9. Design Direction

Default design style:

```text
Midnight Violet Dashboard
```

Design identity:

* Android-first
* iOS-ready
* Portfolio-friendly
* Futuristic but controlled
* Dashboard-like
* Dark mode polished
* Light mode supported
* Subtle neon accents
* Clean and readable
* Not Cosmic as the main visual style
* Not overly iOS-like
* Not overly cyberpunk/game-like

Secondary future theme:

```text
Neon Community Dark
```

Neon Community Dark may become an optional theme or a feature-specific mood later, but it should not be the default theme in the first phase.

Possible future optional theme:

```text
Vice Heat
```

Vice Heat may be used as a future theme, event skin, or entertainment-module visual direction. It is not part of the first implementation phase.

## 10. Theme Direction

The first implementation phase should support only:

```text
Midnight Violet Light
Midnight Violet Dark
```

Theme mode direction:

```text
System
Light
Dark
```

Future theme style direction:

```text
Midnight Violet
Neon Community
Vice Heat
```

The first phase should not implement full multi-style theme switching unless specifically requested.

## 11. Typography Direction

Approved font direction:

```text
Sora + Inter
```

Usage:

* Sora: headings, hero text, important section titles
* Inter: body text, labels, inputs, navigation, general UI

Font usage should remain controlled to avoid unnecessary app size growth.

Recommended early weights:

```text
Inter: 400, 500, 600, 700
Sora: 600, 700
```

## 12. Device and Bluetooth Direction

InfinityWorld may include device integrations later.

Device-related features should live under:

```text
Tools → Device Hub
```

Possible future Device Hub features:

* Bluetooth device scan/connect
* Bluetooth speaker/audio helper
* Audio playback/session tools
* Device permission status
* Local device utilities

Bluetooth/audio packages should not be added until the Device Hub feature is actively implemented.

Device-related code should not be written directly inside screen widgets. It should use services/controllers/providers so permission handling and platform-specific behavior remain isolated.

## 13. Local-First Direction

The app should be local-first during early phases.

Early modules may call APIs directly through the app’s networking layer and display data without persistence.

Examples:

* RSS/news can be fetched and displayed before saved-article storage exists
* Summertime Saga tracker can fetch update data before tracker persistence exists
* Game trackers can start as read-only API views

Persistence can be added when needed for:

* Local profile
* Theme settings
* Bookmarks
* Saved articles
* Reading progress
* Tracker configuration
* Known devices
* Recently used modules

## 14. Performance Direction

Performance should be considered from the beginning.

Rules:

* Home should not load every feature at startup
* Features should be lazy-loaded
* API calls should not be made inside widget build methods
* Heavy parsing should be isolated if data becomes large
* Widgets should be split to reduce unnecessary rebuilds
* Use `const` widgets where practical
* Use lazy lists for long content
* Avoid excessive blur, glow, animation, and heavy shadows
* Avoid animated backgrounds unless specifically approved
* Assets should be optimized before being bundled

Midnight Violet can use glow and gradients, but they should be subtle and purposeful.

## 15. App Size Direction

The app should avoid unnecessary size growth.

Rules:

* Do not add packages before they are needed
* Do not add multiple state management packages for new code
* Do not add Firebase/Supabase/backend packages early
* Do not add Bluetooth/audio packages before Device Hub work starts
* Do not bundle large image assets unnecessarily
* Prefer SVG for simple illustrations/icons
* Prefer WebP for raster images where appropriate
* Keep font families and font weights limited

## 16. Icon Direction

App icon direction:

```text
Infinity symbol + Midnight Violet gradient
```

The app icon should be simple, recognizable, and readable at small launcher sizes.

Preferred direction:

* Infinity mark
* Dark indigo/purple background
* Violet/blue/cyan accent
* Subtle glow
* No long text in the launcher icon

In-app icon direction:

* Use one consistent icon style
* Prefer Material Symbols Rounded or another single consistent icon set
* Avoid mixing many unrelated icon packs
* Active icons use primary/accent color
* Inactive icons use muted color
* Module icons should remain visually consistent

Suggested bottom nav icon mapping:

```text
Home: home_rounded
Explore: explore_rounded / travel_explore_rounded
Tools: handyman_rounded / construction_rounded
Library: local_library_rounded / collections_bookmark_rounded
Settings: settings_rounded
```

## 17. Portfolio Direction

InfinityWorld should be suitable as a portfolio project.

The project should demonstrate:

* Modular Flutter architecture
* Riverpod-based state/dependency direction
* go_router-based navigation direction
* Custom design system
* Light/dark theme support
* Local-first app behavior
* Clean feature boundaries
* Good error/loading/empty states
* Reasonable tests
* Android-first polish
* iOS-ready thinking
* Documentation of product and technical decisions

The portfolio value should come from quality, clarity, and extensibility, not from having many incomplete features.

## 18. Early Development Priority

Recommended early direction:

```text
Phase 0: Stabilize existing project
Phase 1: Documentation baseline
Phase 2: App shell, splash, local login/session, theme foundation
Phase 3: Home and bottom navigation
Phase 4: BMI as the first clean module
Phase 5: Summertime Saga hardening through Dio/error/loading patterns
Phase 6: Settings/profile/theme preferences
Phase 7: Explore/RSS
Phase 8: Library/Reader
Phase 9: Device Hub
Phase 10: AI Lab
```

This order may change, but early development should avoid large feature expansion before the app shell, theme, startup flow, and architecture are stable.

## 19. Current Product Decisions

Current confirmed decisions:

```text
Product:
Android-first, iOS-ready personal super-app and portfolio Flutter project.

Startup:
Splash screen exists.
App opens into Login.
If a previous local session exists, redirect to Home.

Auth:
Fake/local profile first.
Real auth later.

Navigation:
Home | Explore | Tools | Library | Settings.

Design:
Main style is Midnight Violet Dashboard.
Support light/dark mode from the beginning.
Neon Community Dark is a future optional theme or feature mood.
Vice Heat may be a future optional theme.

Typography:
Sora + Inter.

Storage:
Local-first.
Use simple local session/profile storage first.
Use local database when persistent feature data is needed.

Device:
Bluetooth/audio will be handled later through Device Hub.

Development approach:
Polished and maintainable over fast feature accumulation.
```

## 20. Non-Goals for Early Phases

Do not prioritize these in the first phase unless explicitly requested:

* Real backend authentication
* Full cloud sync
* Full multi-theme style switching
* Heavy animation system
* Complete Reader implementation
* Complete AI Lab implementation
* Complete Bluetooth/audio implementation
* Firebase/Supabase integration
* Large architecture rewrite without stabilization
* Desktop-first layout
* Web-first layout

## 21. Guiding Principle

Every new feature should answer these questions:

```text
Does it fit one of the main tabs?
Does it follow the InfinityWorld Design System?
Can it be developed without breaking other modules?
Does it keep the app useful, polished, and maintainable?
Does it improve the portfolio value of the project?
```

InfinityWorld should grow as a consistent personal platform, not as a collection of unrelated screens.
