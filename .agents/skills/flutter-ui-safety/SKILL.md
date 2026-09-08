---
name: flutter-ui-safety
description: Use when changing Flutter feedback states, forms, screens, navigation surfaces, responsive layout, accessibility, insets, overflow, or user-visible failure behavior.
---

# Flutter UI Safety

Use this skill for UI safety and feedback policy. Preserve the project shell, design system, navigation, and behavior unless the task explicitly changes them.

## Feedback and accessibility

- Represent loading, empty, success, info, warning, and error states deliberately; make empty distinct from failure and provide a useful recovery action where appropriate.
- Match severity and scope to the surface: inline validation/status for local issues, SnackBar/banner for transient or page-level feedback, dialog/bottom sheet for decisions, and full-screen states only when the feature cannot continue.
- Prevent duplicate or stale feedback from rebuilds, polling, repeated taps, and overlapping requests. Do not trigger SnackBars/dialogs from `build()`.
- Keep user copy short, actionable, and non-sensitive. Reuse existing design-system components/tokens, icons, colors, semantics, focus behavior, and accessible labels; never rely on color alone.
- Preserve text scaling, localization growth, touch target reachability, keyboard focus, and screen-reader semantics.

## Layout safety

- Keep normal screens safe around status/navigation bars and edge-to-edge backgrounds. Use the project shell’s existing SafeArea/inset ownership; do not double-pad or hide system bars to mask overlap.
- Make growing content scroll-safe, including forms, validation text, dynamic cards/menus, and API collections. Check small screens, large text, keyboard insets, bottom navigation, and gesture/three-button navigation.
- Prevent overflow without fixed-height band-aids. Preserve usable primary actions and bottom controls when content grows; keep responsive behavior compatible with existing breakpoints and design tokens.
- Treat immersive/fullscreen as an explicit screen-owned behavior only. Restore system UI mode/style when leaving that screen.
- Use the project’s existing layout components before introducing abstractions or a responsive package. The official dart-flutter plugin covers generic RenderFlex diagnosis, Expanded/Flexible mechanics, responsive implementation, and widget preview.

## Verification

Use the smallest relevant focused test plus manual/runtime review when layout or feedback placement matters. Consider 360x640 and 360x800, large text, keyboard-open forms, scroll growth, bottom/system navigation, and user-visible success/error paths. `flutter analyze` alone does not prove UI safety.
