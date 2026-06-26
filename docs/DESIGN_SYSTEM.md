# InfinityWorld — Design System

## 1. Design System Goal

InfinityWorld should use a custom design system that makes the app feel cohesive, polished, and portfolio-ready across all modules.

The design system should support:

* Android-first UI
* Future iOS readiness
* Light and dark mode
* Consistent spacing, colors, typography, and components
* Reusable UI patterns
* Good readability
* Performance-aware visuals
* Controlled use of futuristic/neon styling

The design system should make unrelated modules feel like they belong to the same app.

## 2. Visual Direction

Default visual style:

```text
Midnight Violet Dashboard
```

The style should feel:

* Premium
* Modern
* Dashboard-like
* Slightly futuristic
* Dark-mode polished
* Clean enough for daily use
* Professional enough for portfolio review
* Cross-platform-ready

The app should not look like:

* A full cosmic/galaxy UI
* A heavy cyberpunk game UI
* A full glassmorphism demo
* An iOS clone
* A default Material app with no identity

## 3. Theme Direction

The first implementation phase supports only:

```text
Midnight Violet Light
Midnight Violet Dark
```

Future optional theme styles:

```text
Neon Community Dark
Vice Heat
```

Do not implement full multi-style theme switching in the first phase unless explicitly requested.

Separate these concepts:

```text
Theme Mode:
- System
- Light
- Dark

Theme Style:
- Midnight Violet
- Neon Community
- Vice Heat
```

Initial implementation:

```text
Theme Mode: System / Light / Dark
Theme Style: Midnight Violet only
```

## 4. Color Philosophy

The design should use dark indigo/violet surfaces, violet-blue primary accents, cyan highlights, and limited pink accent usage.

Neon colors should be used as accents, not as primary reading colors.

Rules:

* Use neutral surfaces for most UI.
* Use primary/accent colors for interaction and hierarchy.
* Use glow sparingly.
* Use gradients for hero, selected states, and special cards only.
* Do not use neon text for body copy.
* Keep contrast high in dark mode.
* Keep light mode clean and professional.

## 5. Midnight Violet Palette

### Dark Mode

```text
Background:       #0B0E1A
Surface 1:        #14162B
Surface 2:        #1B1E35
Surface 3:        #232642
Elevated:         #2A2E4F
Overlay:          #34385C
Border:           #3F4470

Primary:          #6B5BFF
Primary Bright:   #A855F7
Secondary:        #4CC2FF
Cyan Accent:      #00E5FF
Pink Accent:      #FF5EC8

Success:          #22D39A
Warning:          #F59E0B
Error:            #EF4444
Info:             #4CC2FF

Text Primary:     #FFFFFF
Text Secondary:   #AEB3D6
Text Tertiary:    #9096B8
Text Disabled:    #6E7498
```

### Light Mode

```text
Background:       #F6F7FB
Surface 1:        #FFFFFF
Surface 2:        #F1F3F9
Surface 3:        #E7EBF5
Elevated:         #FFFFFF
Border:           #E2E6F0
Divider:          #EDF2F7

Primary:          #6B5BFF
Primary Strong:   #5145CD
Secondary:        #2563EB
Cyan Accent:      #0891B2
Violet Accent:    #7C3AED
Pink Accent:      #DB2777

Success:          #16A34A
Warning:          #D97706
Error:            #DC2626
Info:             #2563EB

Text Primary:     #0F172A
Text Secondary:   #475569
Text Tertiary:    #64748B
Text Disabled:    #94A3B8
```

## 6. Gradients

Gradients should be used carefully.

Recommended gradients:

```text
Primary Gradient:
#6B5BFF → #A855F7

Blue Violet Gradient:
#4CC2FF → #6B5BFF

Neon Accent Gradient:
#4CC2FF → #A855F7 → #FF5EC8

Dark Surface Gradient:
#14162B → #1B1E35

Hero Background Gradient:
#0B0E1A → #14162B → #1B1E35
```

Rules:

* Use gradients on hero cards, primary CTA, selected module cards, and decorative accents.
* Do not use gradients on every card.
* Do not use animated gradients by default.
* Do not put long body text on highly saturated gradients.

## 7. Typography

Approved font direction:

```text
Sora + Inter
```

Usage:

```text
Sora:
- Display text
- Page titles
- Section titles
- Hero headings
- Important dashboard numbers

Inter:
- Body text
- Labels
- Inputs
- Navigation
- Buttons
- Captions
- Lists
```

Recommended early font weights:

```text
Inter: 400, 500, 600, 700
Sora: 600, 700
```

Avoid loading unnecessary font weights.

Implementation note:

* Local static font assets are registered for Inter 18pt and Sora at weights 400, 500, 600, and 700.
* Inter is the default app font for body/UI text.
* Sora is applied through the app theme for display, headline, and title emphasis.
* The app does not use the `google_fonts` package.

## 8. Typography Scale

Recommended mobile typography scale:

```text
Display:
Font: Sora
Size: 32
Weight: 700
Line height: 40

H1:
Font: Sora
Size: 28
Weight: 700
Line height: 36

H2:
Font: Sora
Size: 24
Weight: 700
Line height: 32

H3:
Font: Sora
Size: 20
Weight: 600
Line height: 28

Title:
Font: Inter
Size: 18
Weight: 600
Line height: 26

Body Large:
Font: Inter
Size: 16
Weight: 400
Line height: 24

Body:
Font: Inter
Size: 14
Weight: 400
Line height: 20

Label:
Font: Inter
Size: 13
Weight: 600
Line height: 18

Caption:
Font: Inter
Size: 12
Weight: 400
Line height: 16

Overline:
Font: Inter
Size: 11
Weight: 600
Line height: 14
Letter spacing: 0.6
```

Rules:

* Body text should generally not go below 14 unless it is metadata.
* Important information should not rely on caption-sized text.
* Use Sora sparingly so the UI does not feel heavy.
* Use Inter for dense content and reading surfaces.

## 9. Spacing Tokens

Use a consistent spacing scale.

Recommended tokens:

```text
space_0: 0
space_2: 2
space_4: 4
space_6: 6
space_8: 8
space_10: 10
space_12: 12
space_16: 16
space_20: 20
space_24: 24
space_32: 32
space_40: 40
space_48: 48
space_64: 64
```

Common usage:

```text
Screen horizontal padding: 16 or 20
Section gap: 24
Card internal padding: 16
Compact card padding: 12
Button horizontal padding: 16
Button vertical padding: 12
List item gap: 12
```

Rules:

* Do not hard-code random spacing values in feature screens.
* Prefer design tokens.
* Use slightly more spacing for dashboard/home surfaces.
* Keep dense lists readable and scannable.

## 10. Radius Tokens

Recommended radius:

```text
radius_4: 4
radius_8: 8
radius_12: 12
radius_16: 16
radius_20: 20
radius_24: 24
radius_full: 999
```

Common usage:

```text
Button: 12
Input: 12
Card: 16
Module card: 16
Dialog: 20
Bottom sheet: 20 top radius
Bottom nav container: 20 or 24
Small chip: full
Avatar: full
```

Rules:

* Avoid excessive iOS-like rounding everywhere.
* Do not use radius 28–32 globally unless a component specifically needs it.
* Keep shapes friendly but not overly soft.

## 11. Elevation and Shadows

The design should use subtle depth.

Dark mode:

* Prefer borders and surface layering over heavy shadows.
* Use glow sparingly.
* Use elevated surfaces for important containers.

Light mode:

* Use soft shadows for cards and sheets.
* Keep shadows subtle and clean.

Recommended dark elevation approach:

```text
Base surface: no shadow
Elevated card: subtle border + slightly lighter surface
Selected card: subtle glow or accent border
Modal/sheet: elevated surface + stronger border
```

Recommended light elevation approach:

```text
Base card: subtle border
Elevated card: soft shadow
Modal/sheet: shadow + surface
```

## 12. Glow Rules

Glow is part of the Midnight Violet identity, but it must be controlled.

Allowed uses:

* Active bottom nav item
* Primary CTA hover/pressed/selected states
* Selected module card border
* Hero card accent
* Small status indicator
* Special visual highlight

Avoid:

* Glowing every card
* Glowing body text
* Large background glow behind every screen
* Continuous glow animation
* Heavy blur layers on low-end devices

Glow should make the UI feel premium, not noisy.

## 13. Component Naming

Reusable design-system components should use the `Iw` prefix.

Core components:

```text
IwAppScaffold
IwButton
IwIconButton
IwCard
IwModuleCard
IwTextField
IwSearchField
IwSectionHeader
IwEmptyState
IwErrorView
IwLoadingView
IwRetryView
IwBottomNav
IwBadge
IwChip
IwAvatar
IwListTile
IwDivider
IwSurface
```

Design-system components should be theme-aware and reusable across features.

## 14. Component Rules

### Buttons

Button types:

```text
Primary
Secondary
Ghost
Text
Icon
FAB
```

Primary button:

* Uses primary color or primary gradient
* Strong visual hierarchy
* Used for main actions only

Secondary button:

* Outline or subtle filled surface
* Used for alternative actions

Ghost/text button:

* Minimal style
* Used for low-priority actions

Rules:

* Do not use multiple primary buttons in the same small area.
* Disabled state must be visually clear.
* Loading state should be supported for async actions.
* Buttons should have accessible tap targets.

### Cards

Card types:

```text
Standard card
Module card
Dashboard metric card
Feature card
Action card
Status card
```

Rules:

* Cards should use consistent padding and radius.
* Module cards should have icon, title, short description, and optional status.
* Dashboard cards may use subtle gradients or accent borders.
* Avoid making every card visually loud.

### Text Fields

Text fields should support:

* Label
* Hint
* Helper text
* Error text
* Leading/trailing icons
* Disabled state
* Focus state

Rules:

* Focus state should use primary/accent color.
* Error state should use error color and clear text.
* Text fields should work in both light and dark mode.

### Empty/Error/Loading States

Every feature that loads data should have consistent states:

```text
Loading
Empty
Error
Success/data
Retry where appropriate
```

Use:

```text
IwLoadingView
IwEmptyState
IwErrorView
IwRetryView
```

Do not leave screens spinning forever.

## 15. Bottom Navigation

Confirmed bottom navigation tabs:

```text
Home | Explore | Tools | Library | Settings
```

Suggested icon mapping:

```text
Home: home_rounded
Explore: explore_rounded / travel_explore_rounded
Tools: handyman_rounded / construction_rounded
Library: local_library_rounded / collections_bookmark_rounded
Settings: settings_rounded
```

Rules:

* Active item uses primary/accent color.
* Inactive items use muted text/icon color.
* Bottom nav should work in both light and dark mode.
* Labels should remain visible unless a future redesign explicitly changes this.
* The active state may use subtle glow in dark mode.
* Avoid overly tall or bulky bottom navigation.

## 16. App Shell

The app shell should provide:

* Consistent safe area handling
* Bottom navigation
* Shared background/surface treatment
* Optional app bar/section title behavior
* Scroll behavior that works across Android and future iOS

Main shell tabs:

```text
Home
Explore
Tools
Library
Settings
```

The shell should not load all feature modules on startup.

## 17. Splash Screen

InfinityWorld should have a splash screen.

Startup flow:

```text
Native Splash
→ Flutter Bootstrap / Splash
→ Check local session
→ If logged in: Home
→ If not logged in: Login / Local Profile
```

Splash visual direction:

* Midnight Violet background
* Infinity mark
* Subtle primary gradient
* Minimal animation if any
* No heavy animation in the first phase

Splash should feel premium but fast.

## 18. Login / Local Profile Screen

Initial login is local/fake profile, not real backend authentication.

Recommended direction:

* Friendly welcome
* Display name input
* Optional avatar/preset later
* Primary button to enter app
* Clear indication that it is local profile setup if needed

Avoid:

* Fake email/password form that implies real backend auth
* Complex onboarding in the first phase
* Network dependency during local login

The app should remember previous local login/session and redirect to Home on future startup.

## 19. Home Design Direction

Home is the main dashboard.

Recommended Home content:

* Greeting/local profile
* Pinned modules
* Recently used modules
* Quick actions
* Summary cards
* Continue section if Library/Reader exists later

Visual direction:

* Bento/dashboard cards
* Clean hierarchy
* Subtle Midnight Violet accents
* No full feature loading on startup

Home should communicate the “personal hub” concept clearly.

## 20. Explore Design Direction

Explore contains external content and discovery.

Examples:

* RSS/news
* Summertime Saga tracker
* Game updates
* Watched sources

Design direction:

* Feed/list/card hybrid
* Clear source labels
* Loading/error/empty states
* Filter/search support later

Explore may use slightly stronger visual accents than Home, but should still follow the design system.

## 21. Tools Design Direction

Tools contains utility modules.

Examples:

* BMI
* Wheel
* AI Lab
* Device Hub
* Converters

Design direction:

* Grid/list of module cards
* Each tool has a clear icon and short description
* Frequently used tools can appear on Home
* Device Hub appears here first

## 22. Library Design Direction

Library contains personal saved content.

Examples:

* Reader
* Saved articles
* Bookmarks
* Reading progress

Design direction:

* Calm reading-friendly surfaces
* Less glow than Home/Explore
* Strong typography readability
* Good empty states

Library should be optimized for content readability.

## 23. Settings Design Direction

Settings contains profile, theme, permissions, app info, and configuration.

Expected sections:

```text
Profile
Appearance
Permissions
Data & Storage
About
Developer / Debug if needed
```

Settings should be simple, clear, and not overly decorative.

## 24. Icon Strategy

App icon direction:

```text
Infinity symbol + Midnight Violet gradient
```

In-app icon direction:

* Use one consistent icon family
* Prefer Material Symbols Rounded or a single equivalent icon set
* Do not mix unrelated icon packs
* Use consistent stroke/fill behavior
* Module icons should use the same style language

Icon color rules:

* Active: primary/accent
* Inactive: muted
* Warning/error/success: semantic colors
* Decorative icons: subtle gradient only when appropriate

## 25. Illustration Strategy

Illustrations should be optional and lightweight.

Preferred:

* SVG illustrations
* Simple geometric/abstract elements
* Infinity/portal/grid motifs used sparingly
* Small decorative accents

Avoid:

* Large raster illustrations in many screens
* Heavy cosmic/galaxy art as the main identity
* Overly detailed game-like artwork
* Unused illustration assets

## 26. Motion and Animation

Motion should be subtle.

Allowed early motion:

* Button press feedback
* Bottom nav transition
* Page transition
* Loading shimmer/skeleton if lightweight
* Theme transition crossfade later
* Module card hover/press on supported platforms

Avoid early:

* Particle effects
* Animated neon backgrounds
* Heavy Lottie usage
* Continuous glow animation
* Complex custom animations without product value

Animation should improve clarity and delight without hurting performance.

## 27. Accessibility Rules

Accessibility matters even for a personal/portfolio app.

Rules:

* Maintain good text contrast.
* Do not use neon colors for body text.
* Minimum body text should generally be 14.
* Touch targets should be comfortable.
* Use semantic labels where needed.
* Error messages should be textual, not color-only.
* Light and dark modes must both remain readable.
* Avoid relying only on color to communicate state.

## 28. Responsive and Cross-Platform Readiness

The app is Android-first but should not be Android-locked.

Rules:

* Respect safe areas.
* Avoid hard-coded screen sizes.
* Use adaptive padding where needed.
* Keep layouts usable on common Android phone sizes.
* Avoid iOS-only or Android-only visual assumptions where possible.
* Desktop/web are not priorities, but layouts should not break unnecessarily.

iOS readiness means the app should feel acceptable on iOS later without becoming an iOS clone.

## 29. Performance Rules for UI

UI performance rules:

* Avoid heavy blur and BackdropFilter unless necessary.
* Avoid large animated gradient backgrounds.
* Avoid too many shadows/glows on one screen.
* Use optimized images.
* Prefer SVG for simple vector visuals.
* Use lazy builders for long lists.
* Split widgets to reduce rebuild scope.
* Use const constructors where practical.
* Do not load all feature content on Home startup.

Visual polish should not come at the cost of sluggish interaction.

## 30. App Size Rules for UI Assets

Rules:

* Keep font families limited.
* Keep font weights limited.
* Avoid unused image assets.
* Prefer SVG for simple icons/illustrations.
* Prefer WebP for raster images where appropriate.
* Avoid bundling large mock/demo images.
* Avoid multiple icon packs unless justified.
* Avoid heavy animation files unless necessary.

## 31. Initial Implementation Scope

The first design-system implementation should include:

```text
Midnight Violet light/dark tokens
Inter + Sora setup
Basic app theme
Core spacing/radius tokens
IwAppScaffold
IwButton
IwCard
IwTextField
IwEmptyState
IwErrorView
IwLoadingView
IwModuleCard
Bottom nav style
Splash visual direction
Login/local profile visual direction
```

Do not implement the full future theme system immediately.

## 32. Future Theme: Neon Community Dark

Neon Community Dark may be added later.

Direction:

* Dark-first
* More cyber-neon
* Purple, magenta, cyan, mint accents
* Good for Explore, AI Lab, community-like screens, or optional theme mode

It should not replace Midnight Violet as the default theme unless explicitly decided later.

## 33. Future Theme: Vice Heat

Vice Heat may be added later.

Direction:

* Tropical neon
* Sunset pink/orange
* Cyan/ocean blue
* Retro-futuristic
* Energetic but app-usable

Good for:

* Optional theme
* Seasonal/event skin
* Entertainment tools
* Wheel/game-like modules

It should not be part of the first theme implementation.

## 34. Design System Non-Goals for Early Phase

Do not prioritize early:

* Full multi-theme style switching
* Complex animation system
* Heavy illustration library
* Full glassmorphism component set
* Pixel-perfect iOS adaptation
* Desktop-first layouts
* Large custom charting system
* Full branding/logo package

## 35. Guiding Principle

The design system should make InfinityWorld feel like one consistent, polished personal platform.

Every new screen should answer:

```text
Does it follow Midnight Violet?
Does it work in light and dark mode?
Does it use shared tokens/components?
Is the text readable?
Is the interaction clear?
Is the visual effect purposeful?
Will this still look good as a portfolio screenshot?
```

If the answer is no, the screen should be simplified or brought back into the design system.
