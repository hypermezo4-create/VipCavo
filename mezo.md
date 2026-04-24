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
