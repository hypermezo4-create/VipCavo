# Mount Studio — Deadzon

## Mount Studio direction (CN 3.0.303)
Mount Studio is now a **self-contained internal DeadZon Monet Engine**.

- No dependency on external ThemePicker.apk.
- No dependency on ThemesStub.apk.
- No embedded APK execution flow.
- No copied APK resources/code flow.
- Main Mount flow is fully internal Flutter/Dart state + persistence.

## Internal engine capabilities
- Internal color picker with:
  - Hex input + copy
  - RGB sliders
  - HSV sliders
  - Preview circle
  - Reset/random
  - Recent colors
  - Favorite colors
- Internal Material You tonal generation (material_color_utilities) for:
  - Primary
  - Secondary
  - Tertiary
  - Neutral
  - Neutral Variant
  - Error fallback
- Tonal chips shown for tones:
  - 0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 95, 99, 100
- Internal palette library includes:
  - Default, Mint Glass, Aqua Frost, Soft Green, Soft Gold, Purple Mist,
    Sunset Soft, Graphite, Rose, Sky, Lime, Cyan, Orange, Red, Blue,
    Deep Purple, Fruit Salad, Monochromatic, Rainbow, Bundle 1, Bundle 2, Bundle 3

## Wallpaper color extraction
- Android bridge reads wallpaper colors with WallpaperManager:
  - FLAG_SYSTEM
  - FLAG_LOCK
- Returns primary/secondary/tertiary where available.
- Graceful fallback message:
  - "Wallpaper colors are not available on this ROM."

## Mount persistence contract
MountConfig now persists local internal engine state, including:
- selectedSeedColor
- selectedColorHex
- selectedPaletteId
- recentColors
- favoriteColors
- generatedPalettes
- wallpaperColors
- componentColors
- scope toggles
- control app toggles
- activeProfileId

## External shortcut policy
- The external launcher is now optional only:
  - "Open system Wallpaper & Style"
- It is no longer the primary Mount flow.

## Safety phase
- No root commands.
- No real system file writes.
- No bypass logic.
- This phase remains internal engine + preview + saved configuration only.
