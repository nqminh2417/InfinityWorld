# InfinityWorld

InfinityWorld is an Android-first, iOS-ready personal super-app and portfolio Flutter project. It is being built as a polished local-first hub for small tools, trackers, saved content, settings, and future device or AI modules.

The project favors small, verified slices over broad rewrites. Current work is in Phase 10: App Content and Surface Depth.

## Current App State

The app currently supports:

- Local profile login with persisted display name.
- Startup routing that opens Login when no local session exists and Main when a local session exists.
- Five-tab main shell: Home, Explore, Tools, Library, Settings.
- Home/Dashboard with local greeting and direct module links.
- Explore catalog entries for Random Fox and Summertime Saga.
- Tools catalog entries for BMI Calculator, Clock, Random Picker, Unit Converter, and Decision Wheel.
- Library Reader with a built-in local sample catalog, saved/finished states, continue reading, and one paragraph bookmark per sample.
- Settings profile summary and persisted theme mode controls: System, Light, Dark.
- Direct go_router routes for current legacy and feature screens.

Android emulator smoke has been run on `Pixel_6_API_33`. The first runtime pass covered login, keyboard-open login, Home/Dashboard, a Dashboard BMI link, Explore, Tools, Library, Settings, and theme mode controls. The Local profile status-bar contrast follow-up from that pass has been fixed.

## Tech Stack

Current installed stack:

- Flutter 3.44.2 / Dart 3.12.2 in the current local environment.
- Material 3.
- Riverpod for app state, dependency wiring, theme mode, and local profile/session providers.
- go_router for active routing.
- Dio for feature networking.
- shared_preferences for local profile/session and theme mode persistence.
- Local Inter and Sora font assets.

Not currently installed or active:

- GetX.
- Provider/BLoC for new app state.
- direct `http` package calls.
- Drift, Freezed, json_serializable.
- Firebase, Supabase, or backend auth SDKs.
- Bluetooth/audio packages.

## Quick Start

Use PowerShell from the repository root:

```powershell
flutter pub get
flutter devices
```

For Android emulator work:

```powershell
flutter emulators
flutter emulators --launch Pixel_6_API_33
flutter devices
flutter run -d emulator-5554
```

If your emulator id differs, use the id shown by `flutter devices`.

For a quick host smoke when no Android target is running:

```powershell
flutter run -d windows
```

## Verification Commands

Common checks:

```powershell
flutter analyze
flutter test
flutter build apk --debug
git diff --check
```

Docs-only tasks normally require:

```powershell
git diff --check
```

See `docs/qa/git-workflow.md` for the authoritative risk-based verification matrix and required manual/runtime evidence.

Do not claim a command passed unless it was actually run.

## Project Structure

The app is moving toward the documented feature-first structure:

```text
lib/
  app/
    bootstrap/
    router/
    shell/
    theme/
  core/
    config/
    network/
  design_system/
    components/
    tokens/
  features/
    auth/
    bmi/
    dashboard/
    explore/
    fox/
    library/
    settings/
    summertime_saga/
    tools/
```

Small modules stay simple. Larger modules can grow `data`, `domain`, `application`, and `presentation` layers only when the feature needs that structure.

## Architecture Direction

Current direction:

- Android-first, iOS-ready.
- Local-first profile/session and theme behavior.
- Riverpod for new dependency and state boundaries.
- go_router for routing.
- Dio for new networking.
- Feature-first modules.
- Custom InfinityWorld design system with Midnight Violet light/dark themes.
- Tests added around startup, routing, shell tabs, feature screens, services, and UI safety.

Networking flow should stay:

```text
Widget -> Riverpod provider/controller -> service/repository -> Dio
```

Do not call APIs from widget `build()` methods.

## Design Direction

Default style:

```text
Midnight Violet Dashboard
```

Typography:

```text
Sora for headings and important titles.
Inter for body text, labels, inputs, buttons, and navigation.
```

Visual rules:

- Support light and dark mode.
- Keep neon accents subtle.
- Avoid full cosmic, heavy glassmorphism, or heavy cyberpunk styling as the default.
- Use design-system tokens/components before hard-coded styling.
- Keep screens SafeArea-aware, scroll-safe, keyboard-safe where forms exist, and normal screens out of immersive/fullscreen mode.

## Active Routes and Surfaces

Current route constants include:

```text
/login
/main
/dashboard
/chat
/profile
/settings
/smts_home
/testscreen
/fox
/bmi
```

The main shell currently owns these tabs:

```text
Home | Explore | Tools | Library | Settings
```

`ShellRoute` or `StatefulShellRoute` is deferred until the tabs own real nested route stacks.

## Known Deferrals

These are separate follow-up tasks:

- Real backend authentication.
- Screenshot capture and broader portfolio copywriting.
- Release signing hardening.
- Built-in Kotlin migration.
- Android build/toolchain changes.
- Device Hub, Bluetooth, audio, AI Lab, RSS/news, Reader import/sync, generic saved articles, reading-progress offsets, and persisted reader settings.
- Full multi-style theme switching such as Neon Community or Vice Heat.
- Broad shell-route migration.

The debug APK currently builds, but Flutter still reports the known future Built-in Kotlin migration warning. Android release signing still uses debug signing and is not production-ready.

## Documentation

See [docs/README.md](docs/README.md) for the documentation map and role labels. Core sources are:

- `AGENTS.md`
- `docs/project-direction.md`
- `docs/architecture.md`
- `docs/design-system.md`
- `docs/roadmap.md`
- `docs/tasks.md`
- `docs/decisions.md`
- `docs/qa/git-workflow.md`
- `docs/qa/task-workflow.md`

Before changing architecture, routing, theme, feature structure, or task priority, read the relevant docs and keep them aligned.
