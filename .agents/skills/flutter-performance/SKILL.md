---
name: flutter-performance
description: Use when investigating or improving Flutter/Dart startup, first frame, rendering, jank, rebuilds, scrolling, images, memory, async workloads, or animation performance.
---

# Flutter Performance

Use for measured runtime performance work. Profile meaningful behavior in profile mode with DevTools or an equivalent runtime trace; identify the bottleneck before changing code.

- Keep `build()` free of I/O, heavy parsing/sorting, controller creation, and state mutation. Move one-time work to lifecycle/provider boundaries and avoid duplicate requests.
- Narrow rebuilds and listeners. Use lazy builders for large collections, and inspect nesting, `shrinkWrap`, keys, pagination, and image lifetime before changing them.
- Bound image work to displayed size and demand; preserve placeholders, errors, and the project’s approved image/cache stack.
- Move CPU/parsing work off the UI isolate only when measured or clearly necessary. Guard overlapping work from stale updates.
- Keep animations and expensive effects local; dispose owned controllers. Add `RepaintBoundary` only when it isolates a measured paint cost.
- Keep correctness and existing loading/error behavior intact while optimizing.

Follow the applicable gates in `docs/qa/git-workflow.md`. Report the measured symptom and evidence; do not claim a speedup without a measurement or clear causal explanation.
