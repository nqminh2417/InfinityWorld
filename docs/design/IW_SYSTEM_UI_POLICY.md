# InfinityWorld System UI Policy

## Default Policy

Default InfinityWorld screens must be edge-to-edge-compatible and SafeArea-aware while keeping the status bar and system navigation usable. Edge-to-edge drawing does not mean fullscreen or immersive mode: backgrounds may extend behind system bars, but important content and controls must remain visible and reachable.

Normal screens such as Home, BMI, Login, Profile, Settings, Tools, Library, AI Lab, Device Hub, and Dashboard must keep system bars usable and foreground content clear of unsafe areas.

Do not blindly hide the status bar or navigation bar to address overlap, spacing, or visual design problems.

## Fullscreen and Immersive Screens

Fullscreen or immersive mode is reserved for screens where uninterrupted content is part of the intended experience:

- reader
- media preview
- image or video viewer
- camera or scanner
- game-like screen
- another screen explicitly approved for fullscreen behavior

Reusable widgets and ordinary feature screens must not change global system UI mode on their own.

## SystemChrome Ownership and Lifecycle

- Do not call `SystemChrome.setEnabledSystemUIMode` randomly inside `build()`. Rebuilds must not repeatedly mutate global system UI state.
- The screen or route that enters a special system UI mode owns that change.
- Apply the change through an appropriate initialization or route lifecycle hook.
- Restore the InfinityWorld default app mode when leaving the owning screen, using the appropriate lifecycle cleanup such as `dispose()` or route-aware cleanup.
- Restore any related status/navigation bar configuration as part of the same cleanup.
- Do not rely on a later screen to repair system UI state left behind by the previous screen.

Use the app-level configured default when restoring system UI. Do not invent a different default for each screen.

## Overlay Style and Contrast

- Status and navigation bar icon brightness must respect the active light or dark theme.
- Bar colors, transparent overlays, and foreground backgrounds must provide sufficient contrast.
- Prefer route- or screen-owned overlay styling, such as `AnnotatedRegion<SystemUiOverlayStyle>`, when it expresses the intended scope without repeated global calls.
- Verify that content, icons, and system controls remain readable when system bars are transparent or translucent.

## Review Checklist

- Is this a normal screen that should retain usable system bars?
- If fullscreen is requested, is the screen one of the approved special cases?
- Is foreground content protected from status and navigation areas exactly once?
- Is `SystemChrome` mutation outside `build()` and owned by the route that needs it?
- Is the default app mode restored when the route exits?
- Do overlay icon brightness and colors maintain contrast in light and dark mode?
- Were edge-to-edge and system-bar behaviors actually verified, or only considered from code?
