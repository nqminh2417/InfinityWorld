---
name: flutter-performance
description: Use when investigating or improving Flutter/Dart startup, first frame, rendering, jank, rebuilds, scrolling, images, memory, async workloads, or animation performance.
---

# Flutter Performance

Use this skill for runtime performance work. Prefer the smallest measured fix over speculative rewrites or broad caching.

## Policy

- Establish the symptom and bottleneck first: startup/first frame, rebuild scope, build-time work, list/scroll cost, image decode/cache behavior, animation/frame jank, async/database/parsing work, isolate pressure, or memory/resource growth.
- Profile meaningful behavior in profile mode and use DevTools/runtime evidence when available. The official dart-flutter plugin and MCP provide the framework-specific profiling/runtime mechanics; do not recreate their setup here.
- Keep `build()` cheap: no network, database/file I/O, heavy parsing/sorting, controller creation, or state mutation there. Move one-time work to lifecycle/provider boundaries and guard repeated requests.
- Scope rebuilds and listeners narrowly; use stable subtrees and `const` where useful. Do not introduce a new state-management framework or global cache for a local issue.
- Use lazy builders for large/dynamic collections, avoid expensive per-item work, and understand `shrinkWrap`, nesting, keys, pagination, and image lifetime before changing them.
- Bound image work to displayed size and demand; preserve placeholders/error behavior and the project’s approved image/cache stack.
- Move genuinely frame-blocking CPU/parsing work off the UI isolate only when measured or clearly necessary. Guard overlapping async work from stale updates.
- Keep animations and expensive effects local; dispose owned controllers. Add `RepaintBoundary` only when it isolates a measured paint cost.
- Treat lifecycle/disposal, loading/error behavior, and correctness as constraints; never hide failures to make performance appear better.

## Verification

Use the narrowest relevant profile/DevTools trace, runtime measurement, focused test, or benchmark. Report the observed bottleneck, change, and evidence; do not claim a speedup without measurement or a clear causal explanation.
