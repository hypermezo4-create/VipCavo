# Mount Studio — Deadzon

## Global DeadZon Theme Controller
A new global controller now drives app-wide visual tokens from Mount config:
- `accentColor`
- `secondaryAccentColor`
- `backgroundTint`
- `cardTint`
- `borderColor`
- `iconAccentColor`
- `textAccentColor`
- `switchOnColor`
- `sliderColor`
- `checkboxColor`
- `activeMountProfileId`
- `liveApplyEnabled`

Controller behavior:
- Loads persisted `MountConfig` at app startup.
- Pushes dynamic colors into `ThemeData` / `ColorScheme`.
- Notifies listeners for immediate UI refresh across DeadZon.
- Can reset to defaults.

## MountConfig storage contract
Mount settings are persisted and restored through `MountStorageService` using SharedPreferences.
Stored values include:
- selected seed + hex + palette
- `themeStyle`
- recent/favorite colors
- generated tonal palettes
- wallpaper extraction cache
- component colors
- scope toggles
- control-app toggles
- selected package list
- active profile id
- `liveApplyEnabled`

PaperOS keys remain preserved in the app-level control-app map (e.g. `paperos_monet_settings`, `paperos_monet_systemui`, `paperos_monet_gallery`, `paperos_monet_home`, `paperos_monet_updater`, etc.).

Future bridge references are documented only for next phase (not written to system settings yet):
- `theme_customization_overlay_packages`
- `android.theme.customization.accent_color`
- `android.theme.customization.system_palette`
- `android.theme.customization.color_source`
- `android.theme.customization.color_both`
- `android.theme.customization.color_index`
- `android.theme.customization.theme_style`

## Live apply behavior
- Default: **ON**.
- When ON: color/palette/component updates apply globally in DeadZon immediately.
- When OFF: changes remain preview-only in Mount until **Apply** is pressed.
- Apply toast message:
  - `Saved for ROM bridge. Applied inside DeadZon.`

## What Mount now applies globally inside DeadZon
When Mount accent changes, DeadZon now updates:
- app `ThemeData` seed and controls (switch/slider/checkbox)
- floating iOS-style bottom navigation selected bubble
- Home quick-access icon accents
- shared glass card tint/borders
- Settings palette/icon accents
- Mount tabs/action accents + preview state

## Internal DeadZon Monet Engine
Deadzon main flow is internal (no dependency on external APK execution):
- Hex input + copy
- RGB sliders
- HSV + HSL controls
- random + reset
- recent/favorite chips
- palette library
- tonal generation from internal HSL-based engine fallback

Supported style/palette direction includes:
- Tonal Spot
- Vibrant
- Expressive
- Spritz
- Rainbow
- Fruit Salad
- Monochrome
- DeadZon Frost
- Mint Glass
- Aqua Frost
- Soft Gold
- Graphite
- Dark Glass

## Wallpaper color extraction behavior
Android bridge attempts:
- `WallpaperManager.getWallpaperColors(FLAG_SYSTEM)`
- `WallpaperManager.getWallpaperColors(FLAG_LOCK)`

Flutter side:
- shows extracted chips
- allows tapping chips to apply as seed
- gracefully falls back with:
  - `Wallpaper colors are not available on this ROM.`

## New floating bottom navigation structure
A reusable floating pill tab bar is used for:
- Home
- Statusbar
- Mount
- Settings

Behavior:
- rounded frosted capsule
- selected animated bubble (300ms easeOutCubic)
- safe-area aware
- instant accent updates from Mount global theme

## Performance optimizations in this phase
- reduced global glass blur sigma and shadow cost
- retained lightweight single blur layer for floating nav
- kept Mount preview under `RepaintBoundary`
- avoided constant full-screen rebuild from slider persistence by debouncing save operations
- preserved lazy tab content rendering in Mount (single active tab branch)

## Android 16 compatibility note
Current phase is app-internal and robust for Android 12–16 style behavior:
- if ROM/system Monet APIs are unavailable or changed, DeadZon still works through internal color engine and persisted config.
- no root/system file writes performed in this phase.

## ROM/SystemUI bridge boundary (next phase)
Not implemented yet by design:
- no real SystemUI/system setting writes
- no root shell actions
- no claim of real Android system accent application

This phase prepares clean data/config boundaries for later ROM bridge work.

## Monet Picker reference note
Reference checked for architecture direction only:
- https://github.com/Mods-Center/Monet-Picker/releases

No direct APK/source/assets were copied into this implementation.

## Control Center module (CN 3.0.303 phase)
A dedicated Flutter Control Center module now exists with a live glass preview and persistent config.

Preserved ROM bridge keys:
- `square_mezo_tiles`
- `swap_tiles_1`
- `extra_two_mezo_tiles`
- `cc_blur_ratio`

Storage contract:
- `ControlCenterConfig` is stored as structured JSON in SharedPreferences key `control_center_config_v1`.
- Fields: `squareMezoTiles`, `controlCenterStyle`, `extraTwoMezoTiles`, `ccBlurRatio`, `lastUpdatedAt`.
- Values are restored on app restart.

Current local behavior:
- Live preview updates instantly for tile shape, style, extra tile selection, blur ratio, and global Mount accent.
- Extra tile picker enforces exactly two preferred extra tiles.
- Apply + reset actions are implemented with confirmations and snackbar feedback.

Future ROM bridge wiring (not forced yet):
- Persisted config already maps directly to ROM key names.
- Broadcast actions are best-effort placeholders until full ROM-side handlers are integrated.

## Android intent/broadcast behavior
Safe bridge methods are now exposed for:
- `sendDeadzonBroadcast(String action)`
- `openExternalApp(String packageName)`

Control Center uses:
- `my.intent.action.REFRESH_SYSTEMUI`
- `my.intent.action.REFRESH_STATUSBAR`

Behavior guarantees:
- best-effort only
- catches failures and returns `false` without crashing UI
- no root commands
- no system file edits
- no direct SystemUI force-stop/kill

## Spoof Device external launcher
Spoof Device now launches external Kaorios Toolbox only:
- package: `com.kousei.kaorios`
- Android launch path: `PackageManager.getLaunchIntentForPackage`
- App visibility query added in AndroidManifest `<queries>`.

User-facing behavior:
- opens Kaorios if installed
- shows snackbar: `Kaorios Toolbox is not installed.` when unavailable
- no embedded Kaorios resources/code copied into Deadzon

## Settings + Light Mode polish
Settings updates in this phase:
- replaced rough dropdown with an iOS-style bottom sheet theme selector (System/Light/Dark)
- theme mode applies immediately and persists after restart through `DeadzonThemeController`
- subtitle/layout spacing fixed: `Appearance, palette, build details`
- UI palette row now displays current Mount accent chip
- reset dialog now safely resets visual/theme mode only (does not reset MountConfig)

Light mode polish:
- soft frosted light background gradient
- readable text and subtle card/border contrast
- floating bottom nav now adapts to light mode while keeping accent-selected bubble

## DeadZon V1 Lite final polish package
This exported version includes the local V1 Lite fixes requested after the Codex task:

### Branding
- Android app label is now `DeadZon`.
- Launcher mipmap icons were regenerated from `assets/branding/deadzon/deadzon_app_icon_1024.png`.
- Android launch background now uses `@drawable/deadzon_splash_logo` from the DeadZon splash asset.
- Flutter runtime assets use the compressed WebP branding files only.
- The full 4096/large branding PNG files are kept as source/reference assets and are not included in `pubspec.yaml` runtime assets.

### Control Center
Control Center now follows the `elite_cc13_menu.xml` structure without the fake preview section:
- `Restart SystemUI` sends `my.intent.action.REFRESH_SYSTEMUI` after confirmation.
- `Square Tiles` preserves `square_mezo_tiles` and sends a safe statusbar refresh broadcast.
- `Control Center Style` preserves `swap_tiles_1`.
- `Extra Two Tiles` preserves `extra_two_mezo_tiles` as a comma-separated value such as `wifi,cell`.
- `Control Center Blur` preserves `cc_blur_ratio` with an official-style seekbar.

The red runtime error from Material/ListTile inside glass cards was removed by replacing the Control Center preference layout with custom rows.

### Spoof Device
The Home `Spoof device` card now launches `com.kousei.kaorios` directly on first tap. It no longer routes through an intermediate page. If Kaorios is missing, DeadZon shows `Kaorios Toolbox is not installed.`

### Release output
The GitHub Actions workflow now builds release APKs instead of a debug APK:
- Primary modern-device artifact: `app-arm64-v8a-release.apk`
- Optional universal artifact: `app-release.apk`

Use split-per-ABI release builds for smaller APK size.

### V1 / V2 / V3 roadmap
- **V1 Lite:** Mount Studio, Control Center local config, Settings, direct Kaorios shortcut, branding, release optimization.
- **V2 Full UI:** Extensions Center, App Picker, Hidden Apps, Side Panel, Search Actions, Status Icons, Safety Center UI.
- **V3 ROM Bridge:** Safe ROM/SystemUI bridge, backup/restore, actual supported config application.

Safety boundary remains unchanged: no Play Integrity bypass, no SafetyNet bypass, no banking bypass, no protected-app evasion, and no root hiding.
