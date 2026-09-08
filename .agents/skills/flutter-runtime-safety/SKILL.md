---
name: flutter-runtime-safety
description: Use when changing Flutter/Dart async runtime behavior, lifecycle ownership, error states, networking/configuration, retries, cancellation, or request concurrency.
---

# Flutter Runtime Safety

Use this focused guardrail skill for runtime and network behavior. Keep existing contracts and failure semantics unless the task explicitly changes them.

## Lifecycle and ownership

- Make ownership explicit for controllers, subscriptions, timers, requests, streams, and other resources; dispose or cancel what the owning feature creates.
- Do not use `BuildContext` or call `setState` after disposal. Guard async continuations with the project’s lifecycle/mounted convention and re-check before UI updates.
- Prefer cancellation or explicit ignore/stale-result guards when a screen, request, query, or selection is superseded. Define who owns cleanup rather than relying on a global workaround.
- Prevent duplicate submits and accidental duplicate loads; make request sequencing explicit when overlapping operations can race.

## State and failure behavior

- Model explicit transitions such as idle/loading/success/empty/error instead of ambiguous nulls or silent failures. Preserve existing state contracts and user-visible recovery behavior.
- Distinguish transport, HTTP/status, parsing/schema, validation, permission, configuration, storage, and unexpected failures. Preserve safe diagnostics for developers without exposing secrets, stack traces, or sensitive payloads to users.
- Make timeout, retry, backoff, cancellation, and offline behavior intentional. Retry only safe/idempotent work or require an explicit user action when duplication is possible.
- Handle failures at the boundary that can recover or communicate them; do not swallow exceptions or convert every failure to a generic success/empty state.

## Network and configuration

- Keep base URLs, environment selection, release configuration, and platform permissions explicit and compatible with the project. Do not put secrets in `--dart-define`, source, logs, or checked-in config.
- Validate status codes, response shape, decoding, and required fields before state mutation. Use the project’s existing HTTP/API abstraction; the official dart-flutter plugin covers basic HTTP package mechanics and JSON serialization.
- Use fake/stub network boundaries in tests. Do not make tests depend on live services.

## Verification

Trace the complete async path, including disposal and competing requests. Run focused tests and the project’s normal analysis checks as appropriate. Verify success, empty, failure, timeout/retry, cancellation/stale-result, and duplicate-action behavior when those states are in scope.

The official dart-flutter plugin supplies generic Dart runtime-error/static-analysis and package mechanics; this skill supplies project safety policy and edge-case guards.
