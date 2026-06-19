# InfinityWorld — Architecture

## 1. Architecture Goal

InfinityWorld should use a feature-first modular Flutter architecture that is easy to grow, test, and maintain.

The architecture should support:

* Android-first development
* iOS-ready future support
* Local-first behavior
* Light/dark theme support
* Modular feature expansion
* Clean routing
* Predictable state management
* Safe networking
* Controlled app size
* Portfolio-quality structure

The architecture should not over-engineer small modules, but it should provide a clear structure for larger modules.

## 2. High-Level Architecture

Preferred high-level structure:

```text
UI / Presentation
→ Application / State
→ Domain / Models / Contracts where needed
→ Data / Repository / Service
→ Core infrastructure
```

For small features, not every layer is required.

For larger features, split responsibilities clearly.

Example:

```text
Small feature:
BMI screen → BMI controller/calculator

Large feature:
News screen → News controller → News repository → Dio/RSS parser
```

The project should avoid placing networking, persistence, permission handling, or business logic directly inside UI widgets.

## 3. Preferred Folder Structure

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

## 4. Folder Responsibilities

### `app/`

Application composition layer.

Responsible for:

* Root app widget
* Router setup
* Theme setup
* Startup/bootstrap flow
* App shell
* Global providers that compose app-level dependencies

Example:

```text
app/
  app.dart
  bootstrap/
    app_bootstrap.dart
    startup_controller.dart
  router/
    app_router.dart
    route_names.dart
  shell/
    app_shell.dart
    bottom_nav_items.dart
  theme/
    app_theme.dart
    app_theme_controller.dart
```

### `core/`

Shared infrastructure and cross-cutting concerns.

Responsible for:

* Runtime config
* Network client
* Database
* Permissions
* Error models
* Logging
* Common utilities

Example:

```text
core/
  config/
    app_config.dart
    environment.dart

  network/
    dio_provider.dart
    api_result.dart
    network_exception.dart

  database/
    app_database.dart

  permissions/
    permission_service.dart
    permission_state.dart

  errors/
    app_exception.dart
    failure.dart

  logging/
    app_logger.dart

  utils/
    date_time_utils.dart
```

### `design_system/`

Reusable UI design system.

Responsible for:

* Design tokens
* Reusable components
* Layout primitives
* Visual effects
* Theme-aware UI wrappers

Example:

```text
design_system/
  tokens/
    iw_colors.dart
    iw_spacing.dart
    iw_radius.dart
    iw_typography.dart
    iw_shadows.dart

  components/
    iw_button.dart
    iw_card.dart
    iw_text_field.dart
    iw_empty_state.dart
    iw_error_view.dart
    iw_loading_view.dart
    iw_module_card.dart

  layout/
    iw_app_scaffold.dart
    iw_section.dart
    iw_responsive_padding.dart

  effects/
    iw_glow.dart
    iw_gradient.dart
```

### `features/`

Feature modules.

Each feature owns its UI and feature-specific logic.

Small features may stay simple.

Large features should use subfolders:

```text
features/example/
  data/
  domain/
  application/
  presentation/
```

## 5. Feature Structure Rules

### Small Feature Structure

Use this for simple modules such as BMI or Wheel if the logic is small:

```text
features/bmi/
  bmi_screen.dart
  bmi_calculator.dart
  bmi_controller.dart
```

Acceptable when:

* No remote API
* Minimal state
* Minimal persistence
* Logic is isolated
* Testing is simple

### Large Feature Structure

Use this for larger modules such as News, Reader, AI Lab, Device Hub, or Summertime Saga after hardening:

```text
features/news/
  data/
    news_api.dart
    news_repository_impl.dart
    rss_parser.dart

  domain/
    news_article.dart
    news_repository.dart

  application/
    news_controller.dart
    news_providers.dart

  presentation/
    news_screen.dart
    widgets/
```

Use deeper layering when the feature has:

* API integration
* Local persistence
* Multiple screens
* Complex state
* Error/loading/empty states
* Unit-testable business logic
* Replaceable data sources

## 6. State Management

Primary state management:

```text
Riverpod
```

Riverpod is used for:

* App-level dependencies
* Feature controllers
* Async loading state
* Local session state
* Theme state
* Repository/service injection
* Temporary feature state where useful

Preferred Riverpod patterns:

```text
Provider
FutureProvider
StreamProvider
Notifier
AsyncNotifier
StateProvider only for very small/simple state
autoDispose for temporary screen-level state
```

Avoid:

```text
Global mutable singletons
Direct service construction inside widgets
Network calls in build()
Large StatefulWidgets containing business logic
Mixing several state libraries for new code
```

## 7. Legacy GetX Strategy

GetX exists in the current project and is considered legacy.

Rules:

```text
Do not expand GetX usage for new code.
Do not introduce new GetX controllers.
Do not add new GetX routes.
Do not rewrite the whole app only to remove GetX unless explicitly requested.
Migrate away from GetX gradually and safely.
```

Migration direction:

```text
GetX routing → go_router
GetX navigation calls → context.go / context.push
GetX state if any → Riverpod
```

Existing GetX code can remain temporarily until the equivalent new app shell and routing foundation are stable.

## 8. BLoC and Provider Policy

Provider:

```text
Do not add Provider for new app state.
Use Riverpod instead.
```

BLoC/Cubit:

```text
Do not add BLoC/Cubit by default.
Only consider it for a very complex state-machine module if explicitly justified.
```

Examples where BLoC/Cubit may be considered later:

* Bluetooth connection state machine
* Audio playback queue
* Download manager
* AI streaming workflow
* Complex reader sync conflict resolution

Default answer should still be Riverpod unless there is a strong reason otherwise.

## 9. Routing Architecture

Preferred routing:

```text
go_router
```

Routing should support:

* Splash/bootstrap route
* Login/local profile route
* Main app shell
* Bottom navigation shell
* Feature routes
* Future deep links where practical

Expected top-level flow:

```text
Native Splash
→ Flutter Bootstrap / Splash
→ Local session check
→ Login if not logged in
→ Home shell if logged in
```

Example route groups:

```text
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

## 10. Data Passing Rules

Use the correct mechanism based on data lifetime.

### Route Parameters

Use route parameters for small identifiers:

```text
bookId
articleId
gameId
deviceId
sourceId
```

Example:

```text
/library/book/:bookId
/explore/news/article/:articleId
```

### Riverpod State

Use Riverpod for shared state:

```text
current profile
theme mode
theme style
selected source
selected device
audio session state
currently loaded feature state
```

### Local Persistence

Use shared_preferences or Drift for persisted state:

```text
session flag
profile settings
theme settings
bookmarks
saved articles
reading progress
tracker configuration
known devices
recent modules
```

### Temporary UI State

Use local widget state or Riverpod `autoDispose` for temporary state:

```text
form input
search keyword
selected filter
temporary BMI input
wheel edit state
```

## 11. Startup and Session Architecture

Startup should be handled by a bootstrap layer, not by random navigation logic inside screens.

Expected components:

```text
app/bootstrap/
  app_bootstrap.dart
  startup_controller.dart

features/auth/
  local_session_repository.dart
  local_profile.dart
  login_screen.dart
```

Expected session behavior:

```text
On app startup:
1. Show splash/bootstrap UI.
2. Read local session/profile.
3. If valid local session exists, route to Home.
4. Otherwise route to Login.
```

Early persistence can use shared_preferences.

Suggested stored values:

```text
isLoggedIn
displayName
avatarId or avatarPath
lastLoginAt
themeMode
```

Do not implement real backend authentication during the initial architecture phase.

## 12. Theme Architecture

Theme must support light and dark mode from the beginning.

First implementation target:

```text
Midnight Violet Light
Midnight Violet Dark
```

Future theme style support:

```text
Midnight Violet
Neon Community
Vice Heat
```

Separate these concepts:

```text
ThemeMode:
- system
- light
- dark

ThemeStyle:
- midnightViolet
- neonCommunity
- viceHeat
```

The first phase should implement only Midnight Violet light/dark. Full multi-style theme switching can be added later.

Expected files:

```text
app/theme/
  app_theme.dart
  app_theme_controller.dart
  app_theme_mode.dart
  app_theme_style.dart

design_system/tokens/
  iw_colors.dart
  iw_spacing.dart
  iw_radius.dart
  iw_typography.dart
```

Theme preferences should be managed by Riverpod and persisted with shared_preferences.

## 13. Design System Architecture

Feature screens should use reusable design-system components where practical.

Component prefix:

```text
Iw
```

Examples:

```text
IwButton
IwCard
IwAppScaffold
IwTextField
IwEmptyState
IwErrorView
IwLoadingView
IwSectionHeader
IwBottomNav
IwModuleCard
```

Design-system code should avoid depending on specific feature code.

Feature code may depend on design-system components.

Dependency direction:

```text
features/* → design_system
design_system → app theme/tokens only
design_system must not depend on features/*
```

## 14. Networking Architecture

Use Dio for new network code.

Expected structure:

```text
core/network/
  dio_provider.dart
  api_result.dart
  network_exception.dart
```

Feature networking example:

```text
features/summertime_saga/
  data/
    smts_api.dart
    smts_repository_impl.dart
  domain/
    smts_progress.dart
    smts_repository.dart
  application/
    smts_controller.dart
  presentation/
    smts_screen.dart
```

Recommended flow:

```text
Screen
→ Riverpod controller
→ Repository
→ API/service
→ Dio client
```

Rules:

```text
Do not call Dio directly from widgets.
Do not call APIs from build().
Always define timeout behavior.
Represent loading/error/data states explicitly.
Avoid returning null to represent all errors.
Use typed failures or result wrappers where appropriate.
```

## 15. Error Handling Architecture

Use consistent error handling.

Preferred concepts:

```text
AppException
Failure
ApiResult<T>
```

Possible result type:

```text
success(data)
failure(error)
```

or use `AsyncValue<T>` at the Riverpod presentation boundary.

Rules:

```text
Do not swallow errors silently.
Do not convert all errors to null.
Do not leave loading states spinning forever.
Show user-friendly error views.
Expose retry where appropriate.
Log useful technical details during development.
```

## 16. Local Storage Architecture

Use shared_preferences for simple key-value state:

```text
session flag
display name
theme mode
theme style
simple settings
```

Use Drift for structured local data when needed:

```text
bookmarks
saved articles
reader progress
RSS source list
tracker configuration
known devices
recently used modules
```

Do not add Drift schema for a feature before persistence is actually needed.

Database access should be behind repository/service abstractions.

Feature UI should not directly issue database queries.

## 17. Permission Architecture

Android permissions should be centralized.

Expected structure:

```text
core/permissions/
  permission_service.dart
  permission_state.dart
```

Feature-specific permission needs should be requested through a common service or wrapper.

Examples:

```text
Internet
Bluetooth scan/connect
Location if required by Bluetooth behavior
Notifications
Storage/media access
Foreground service for future audio/background features
```

Do not put complex permission handling directly inside screen widgets.

## 18. Device Hub Architecture

Device Hub is the future home for Bluetooth/audio/device features.

Target location:

```text
features/device_hub/
  bluetooth/
  audio/
  presentation/
```

Do not add Bluetooth/audio packages before Device Hub work starts.

Potential future packages:

```text
permission_handler
flutter_blue_plus
bluetooth_low_energy
flutter_blue_classic
just_audio
audio_session
audio_service
```

Rules:

```text
Keep platform-specific behavior isolated.
Use service/controller/provider boundaries.
Do not directly scan/connect from UI widgets.
Do not assume Bluetooth Classic and BLE are the same.
Do not assume Bluetooth speakers require direct Bluetooth control for audio playback.
```

## 19. Performance Architecture

Performance rules:

```text
Lazy-load features.
Do not initialize every feature service on startup.
Home should show summaries, not load full modules.
Do not call network/database work in build().
Use lazy lists for long content.
Use const widgets where practical.
Split large widgets to reduce rebuild scope.
Use Riverpod selectors/consumer boundaries where useful.
Avoid continuous heavy animation.
Avoid excessive blur, glow, and large shadows.
Optimize image assets before bundling.
```

For expensive parsing or processing, consider isolating work if data becomes large.

Do not introduce optimization complexity before there is a real performance problem, but avoid known anti-patterns from the start.

## 20. App Size Architecture

App size should be controlled by package and asset discipline.

Rules:

```text
Do not add packages before needed.
Do not add multiple state libraries for new code.
Do not add Firebase/Supabase/backend SDKs early.
Do not add Bluetooth/audio packages before Device Hub implementation.
Do not add multiple icon packs without justification.
Do not bundle large images unnecessarily.
Limit font weights.
Prefer SVG for simple vector assets.
Prefer WebP for raster images where appropriate.
```

Approved early font direction:

```text
Inter: 400, 500, 600, 700
Sora: 600, 700
```

## 21. Assets Architecture

Suggested asset structure:

```text
assets/
  branding/
  icons/
  images/
  illustrations/
  animations/
```

Guidelines:

```text
Use SVG for simple icons and illustrations.
Use WebP for large raster images where possible.
Avoid large PNGs unless necessary.
Keep source branding assets under assets/branding.
Do not add unused assets.
```

App icon direction:

```text
Infinity symbol + Midnight Violet gradient
```

## 22. Testing Architecture

Testing should be added gradually.

Early test priorities:

```text
App shell smoke test
Startup/session routing test
Bottom navigation widget test
BMI calculator unit test
Theme controller test
Summertime Saga repository/controller tests after hardening
```

Testing direction:

```text
Unit tests for pure logic
Widget tests for UI smoke and navigation behavior
Mocked service/repository tests for API features
Golden tests later for design-system stability if desired
```

Do not block early stabilization on a large test suite, but do not continue adding features without basic tests forever.

## 23. Build and Verification

Preferred checks after code changes:

```powershell
flutter pub get
flutter analyze
flutter test
flutter build apk --debug
```

For quick local checks:

```powershell
flutter analyze --no-pub
```

If using RTK wrapper:

```powershell
rtk flutter analyze
rtk flutter test
rtk flutter build apk --debug
```

If a command cannot be run, report the reason.

Do not claim a command passed unless it was actually executed.

## 24. Migration Strategy

The project currently has legacy structure and GetX usage.

Migration should be incremental.

Preferred migration order:

```text
1. Document direction and architecture.
2. Stabilize current app issues.
3. Add app bootstrap/session flow.
4. Add theme foundation.
5. Add new app shell and bottom navigation.
6. Introduce go_router for new routing.
7. Introduce Riverpod for new state/dependencies.
8. Migrate feature by feature.
9. Remove GetX only after replacement is stable.
```

Avoid a large rewrite unless explicitly requested.

## 25. Known Current Risks

Known risks from initial review:

```text
High:
- login_screen calls setState() from build()
- Android release manifest may be missing INTERNET permission
- Summertime Saga flow can spin forever or crash on null/error states

Medium:
- Dev/Prod config is not fully meaningful yet
- No test/ directory exists
- pubspec.lock / Dart version mismatch may exist
- Some controller/focus lifecycle leaks may exist
- Android release signing is not production-ready
- Some platform identifiers may still contain example defaults

Low:
- Some routes/screens are dead or incomplete
- Settings screen may be unreachable
- Some dependencies may be placed incorrectly
```

These should be fixed in small, focused tasks.

## 26. Architecture Non-Goals

Do not prioritize these early unless explicitly requested:

```text
Full clean architecture for every tiny feature
Real backend authentication
Cloud sync
Firebase/Supabase integration
Full multi-theme style switching
Complete Bluetooth/audio implementation
Complete AI Lab implementation
Complete Reader implementation
Heavy animation system
Desktop-first layout
Web-first layout
```

## 27. Decision Principles

When adding or changing architecture, prefer decisions that are:

```text
Simple enough for a personal project
Clean enough for portfolio review
Modular enough for future features
Android-first but not Android-locked
Local-first but backend-ready later
Performance-aware
App-size-aware
Easy for Codex/agents to modify safely
```

Every architecture change should make future feature work clearer, not more confusing.
