# InfinityWorld Layout Safety Policy

## Purpose

InfinityWorld screens must remain readable, reachable, and stable across supported mobile layouts. Layout work must account for system insets, edge-to-edge rendering, small screens, keyboard visibility, content growth, and bottom navigation.

Apply the global `flutter-ui-layout-safety` skill to Flutter UI tasks. Keep fixes scoped to the current source structure; this policy does not require or authorize an architecture migration.

## SafeArea-aware Layout

- Keep foreground content and interactive controls clear of status bars, display cutouts, gesture areas, and system navigation.
- Decorative backgrounds may extend edge-to-edge while content remains inside safe bounds.
- Apply `SafeArea` at the shell or screen boundary that owns inset handling.
- Check whether the shell already handles insets before wrapping a child screen. Do not introduce double padding.
- Use `MediaQuery.paddingOf`, `MediaQuery.viewPaddingOf`, or `MediaQuery.viewInsetsOf` when custom inset handling is necessary. Do not substitute hard-coded top or bottom padding.

## Scroll-safe Screen Bodies

Any body that can grow must remain scrollable. Growth can come from additional cards, API content, validation messages, localization, accessibility text scaling, or future menu items.

- Use `ListView` for vertical collections and long screen bodies.
- Use `GridView` for expandable card or tool grids.
- Use `CustomScrollView` when a screen combines multiple scrollable sections or slivers.
- Use `SingleChildScrollView` for small, bounded content such as a form or settings section that may overflow.
- When a scrollable is inside a `Column`, give it bounded height with `Expanded`, `Flexible`, or another explicit constraint.

Do not use a fixed, non-scrollable full-screen `Column` for content that can grow beyond the viewport.

## Keyboard-safe Forms

- Focused fields, validation messages, and primary actions must remain reachable while the keyboard is open.
- Prefer a scrollable form body and let `Scaffold` resize for the keyboard unless a deliberate replacement handles the insets.
- Use `MediaQuery.viewInsetsOf(context).bottom` directly when keyboard inset padding is needed.
- Never call `setState()` from `build()` to track keyboard height.
- Use `FocusScope.of(context).unfocus()` for intentional keyboard dismissal.
- Check that login and other forms remain usable with small screens, large text, and validation errors.

## Bottom Navigation and System Navigation Safety

- Let `Scaffold`, `BottomNavigationBar`, `NavigationBar`, or the app shell handle standard bottom insets where possible.
- Keep custom bottom bars, floating actions, and persistent buttons above gesture and three-button navigation areas.
- Add appropriate bottom content padding when a scrollable can pass behind persistent app navigation.
- Ensure modal sheets and bottom actions remain safe when both the keyboard and system navigation are present.
- Do not hide system bars to solve a layout overlap.

## Expandable Cards, Grids, and Menus

- Treat Home modules, Tools, Library items, Dashboard cards, navigation menus, and similar collections as expandable.
- Prefer builder-based `ListView` or `GridView` widgets for dynamic or potentially large collections.
- Use responsive grid constraints instead of fixed card widths or a fixed number of rows.
- Allow labels to wrap or ellipsize intentionally, and consider localization and larger text scales.
- Reuse existing InfinityWorld widgets, design tokens, and components before introducing one-off spacing or styling.

## Choosing Layout Widgets

### `Column`

Use for small, bounded vertical groups. A full-screen `Column` containing variable content must provide a scrollable region rather than relying on fixed heights.

### `Expanded`

Use inside a `Row` or `Column` when a child should fill remaining bounded space. It is the usual choice for a `ListView` or `GridView` placed inside a `Column`.

### `Flexible`

Use when a child may shrink within available space but does not need to fill all remaining space.

### `ListView`

Use for scrollable vertical content. Prefer builder constructors when item count is dynamic or can become large.

### `GridView`

Use for expandable card, tool, or media collections. Prefer builder constructors and responsive sizing for dynamic content.

### `CustomScrollView`

Use for mixed scrollable sections, slivers, collapsing headers, or coordinated lists and grids.

### `SingleChildScrollView`

Use for one relatively small child, commonly a form `Column`, when content may overflow. Do not wrap a large dynamic list in it when a lazy list is more appropriate, and do not place `Expanded` directly inside it.

## Small-screen Checks

For relevant UI changes, consider or visually verify at least:

- 360x640
- 360x800
- large text scale
- keyboard open for forms
- Android gesture navigation and three-button navigation where relevant

Check that primary content is visible, actions are reachable, collections can scroll, labels are not unintentionally clipped, and bottom controls remain clear of system navigation.

## Preferred Patterns

- Edge-to-edge background with foreground content protected once by the owning shell or screen.
- `Column` with an `Expanded(ListView.builder(...))` for an expandable collection.
- `SafeArea` plus a scrollable form body that responds to keyboard insets.
- Responsive `GridView.builder` for module and tool cards.
- Existing project tokens and components for spacing, radius, color, typography, and shadow.

## Avoid Patterns

- Fixed non-scrollable full-screen `Column` layouts for variable content.
- Repeated `SafeArea` wrappers at both shell and child-screen levels.
- Hard-coded inset padding or fixed heights used to hide overflow.
- Unbounded `ListView` or `GridView` directly inside a `Column`.
- Large dynamic lists inside `SingleChildScrollView` with `shrinkWrap` as a default workaround.
- Critical actions positioned behind the keyboard or system navigation.
- Declaring layout safety solely from a successful `flutter analyze` result.

## Reporting UI Verification

For UI changes, report which checks were considered or performed: SafeArea ownership, edge-to-edge behavior, scrolling, keyboard visibility, bottom navigation, content growth, and small-screen behavior. State clearly which device sizes or runtime states were not verified.
