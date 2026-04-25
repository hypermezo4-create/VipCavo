# DeadZon App Size Report

## Observed issue
A debug APK was observed at roughly **146.61 MB**. Debug APKs are not final release artifacts and are expected to be much larger.

## Release strategy
Use split release APKs:

```bash
flutter build apk --release --split-per-abi
```

Install the arm64 artifact on modern Android devices:

```text
app-arm64-v8a-release.apk
```

A universal APK can also be built, but it is larger:

```bash
flutter build apk --release
```

## APK exclusions
Runtime Flutter assets now include only needed WebP branding plus existing statusbar drawable folders. Large source branding PNGs, README/CODEX files, reference APKs, extracted APK contents, and docs are not referenced in `pubspec.yaml` and should not be packaged into the final Flutter asset bundle.

## Build optimization
Release build enables:
- R8 minification
- resource shrinking
- release split-per-ABI artifacts in GitHub Actions

## Roadmap size targets
- V1 Lite: smallest stable app with Mount + Control Center + Settings + Kaorios shortcut.
- V2 Full UI: more local UI modules, still without raw APK/reference packaging.
- V3 ROM Bridge: real integration layer with careful safety boundaries.
