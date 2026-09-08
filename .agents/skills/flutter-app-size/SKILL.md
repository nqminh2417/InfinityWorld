---
name: flutter-app-size
description: Use when diagnosing or reducing Flutter APK, AAB, IPA, web, or desktop artifact size, dependency/native-library impact, assets, fonts, icons, or packaging choices.
---

# Flutter App Size

Use this skill for measured build-artifact and packaging-size work. Keep the scope to app/build size; do not turn size cleanup into unrelated Flutter refactoring.

## Policy

- Identify the target artifact and mode first: debug/profile/release, APK/AAB/IPA/web/desktop, compressed/download/install/repository size.
- Measure before changing anything. Prefer the relevant Flutter size analysis and record before/after artifact paths or sizes.
- Separate repository size (`build/`, `.dart_tool/`, generated files, logs, samples) from shipped artifact size.
- Trace confirmed contributors before removing or changing them: Dart/transitive dependencies, native libraries and plugins, ABI packaging, assets, images, audio/video/JSON, fonts, icons, web bundles, or desktop binaries.
- Check imports, generated usage, platform requirements, and distribution channel before dependency or asset cleanup.
- Keep build-time tools in `dev_dependencies` only when the project’s code-generation/build usage supports that move.
- Prefer AAB for store distribution and ABI-specific APKs only when device/distribution compatibility permits. Do not silently drop ABIs or platforms.
- Keep icon/font tree-shaking and image-quality decisions compatible with existing UI; do not remove referenced fonts/assets or aggressively recompress without a reason.
- Apply web/desktop checks independently; do not transfer Android ABI advice to other targets.

## Verification

Run only the smallest relevant project commands, such as `flutter build <target> --release --analyze-size`, `flutter analyze`, and a release build. Report what was actually measured and whether behavior/build compatibility was preserved.

The official dart-flutter plugin supplies generic Flutter/Dart build mechanics; this skill supplies size-specific diagnosis, tradeoffs, and verification policy.
