# Regression Checklist

Use this living checklist for confirmed regression risks and small repeatable checks.

## App Shell

- Startup opens Login when no local session exists.
- Startup opens Main when a local session exists.
- Home, Explore, Tools, Library, and Settings tabs remain reachable.

## Feature Routes

- Existing direct feature routes still open.
- Route smoke tests cover any newly added or moved route.

## UI Safety

- Changed screens stay scroll-safe on small screens.
- Forms remain usable with the keyboard open.
- Normal screens do not enter fullscreen or immersive mode.

## Data And State

- Local session/profile/theme values persist across restart where expected.
- Async screens show retryable error states instead of silent failure.

## Notes

Add concrete regression risks here only after they are observed, fixed, or selected as recurring release checks.
