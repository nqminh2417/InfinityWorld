---
name: flutter-ui-safety
description: Use when changing Flutter feedback states, forms, screens, navigation surfaces, responsive layout, accessibility, insets, overflow, or user-visible failure behavior.
---

# Flutter UI Safety

Use for UI safety, feedback, accessibility, and visible failure behavior. Preserve the project shell, design system, navigation, and existing behavior unless explicitly changed.

- Represent loading, empty, success, info, warning, and error states deliberately; distinguish empty from failure and give a useful recovery action where appropriate.
- Match feedback to its scope: inline validation/status for local issues, SnackBar/banner for transient or page-level feedback, dialogs/bottom sheets for user decisions, and full-screen states only when the feature cannot continue.
- Reserve dialogs for destructive confirmations, required decisions, permission/settings flows, or blocking session issues. Keep SnackBars for short action feedback.
- Prevent duplicate or stale feedback from rebuilds, polling, repeated taps, and overlapping requests. Do not trigger SnackBars, dialogs, bottom sheets, or navigation side effects from `build()`.
- Keep user copy short, actionable, and non-sensitive. Use text plus icon/color; never rely on color alone. Reuse design-system components, tokens, semantics, focus behavior, and accessible labels.
- Preserve text scaling, localization growth, touch-target reachability, keyboard focus, and screen-reader semantics.

For layout, insets, system bars, immersive mode, and screen-size checks, follow `docs/design/layout-safety.md` and `docs/design/system-ui-policy.md`. Use `docs/qa/ui-review-checklist.md` for visual review details and select required gates from `docs/qa/git-workflow.md`.
