---
name: flutter-testing
description: Use when adding, fixing, reviewing, or running Flutter/Dart tests and deciding safe regression coverage for changed behavior.
---

# Flutter Testing Policy

This is project-level testing policy, not a replacement for the official dart-flutter test mechanics.

## Policy

- Test the changed behavior and its important failure/regression paths with the smallest focused scope first.
- Prefer deterministic tests: isolate time, randomness, filesystem, platform state, and network dependencies. Use fakes/stubs or project-approved seams; never call live APIs in ordinary tests.
- Preserve the project’s existing test architecture, naming, fixtures, helper conventions, and framework choices. Do not introduce a new testing framework or mock generator for convenience.
- Keep tests readable and independent. Avoid brittle implementation-detail assertions, unnecessary golden coverage, and broad unrelated rewrites.
- Include loading/success/empty/error/retry or lifecycle cases when they are part of the changed contract, especially for async/network/UI behavior.
- Run the narrowest relevant test command, then the project’s normal analysis/test gate when risk warrants it. Report skipped checks and environment limits honestly.
- The official dart-flutter plugin supplies unit/widget/integration test, mock, coverage, and framework mechanics. Use those skills rather than duplicating generic tutorials here.

## Completion check

A change is not verified merely because the app analyzes: demonstrate the relevant behavior with focused tests or explain the exact manual/runtime check used.
