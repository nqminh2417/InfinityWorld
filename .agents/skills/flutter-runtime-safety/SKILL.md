---
name: flutter-runtime-safety
description: Use when changing Flutter/Dart async runtime behavior, lifecycle ownership, error states, networking/configuration, retries, cancellation, or request concurrency.
---

# Flutter Runtime Safety

Use for async lifecycle, network, and failure-behavior changes. Preserve existing contracts and recovery behavior unless the task explicitly changes them.

- Make ownership explicit for controllers, subscriptions, timers, requests, streams, and other feature-owned resources; dispose or cancel them.
- Do not use `BuildContext` or call `setState` after disposal. Guard async continuations and prevent stale results from superseded requests, queries, or selections.
- Prevent duplicate submits/loads and make request sequencing explicit when operations can race.
- Model idle/loading/success/empty/error explicitly. Distinguish transport, status, parsing/schema, validation, permission, configuration, storage, and unexpected failures; do not swallow failures or turn them into generic success/empty states.
- Make timeout, retry, backoff, cancellation, and offline behavior intentional. Retry only safe/idempotent work or require an explicit user action when duplication is possible.
- Keep base URLs, environment selection, release configuration, and platform permissions explicit. Never put secrets in source, logs, checked-in config, or `--dart-define`.
- Validate status codes, response shape, decoding, and required fields before mutating state. Use the existing HTTP/API boundary and fake network boundaries in tests; ordinary tests must not call live services.
- Preserve safe developer diagnostics without exposing secrets, stack traces, or sensitive payloads to users.

For the changed async path, consider disposal, competing requests, duplicate actions, and each in-scope success/empty/failure/timeout/retry/cancellation state. Select required commands from `docs/qa/git-workflow.md`.
