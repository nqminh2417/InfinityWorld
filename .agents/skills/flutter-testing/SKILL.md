---
name: flutter-testing
description: Use when adding, fixing, reviewing, or running Flutter/Dart tests and deciding safe regression coverage for changed behavior.
---

# Flutter Testing Policy

Use for Flutter/Dart test changes and regression-coverage decisions.

- Cover the changed behavior and important failure/regression paths with the smallest useful test scope.
- Keep tests deterministic: isolate time, randomness, filesystem, platform state, and network dependencies. Use fakes/stubs or existing project seams; ordinary tests must not call live APIs.
- Preserve the existing test architecture, naming, fixtures, helper conventions, and framework choices. Do not add a test framework or mock generator for convenience.
- Keep tests readable and independent. Avoid brittle implementation-detail assertions, unnecessary golden coverage, and broad unrelated rewrites.
- Cover loading/success/empty/error/retry or lifecycle behavior when it is part of the changed contract, especially for async/network/UI behavior.

Use `docs/qa/git-workflow.md` for required verification gates and `docs/qa/regression-checklist.md` for applicable reusable behavior checks.
