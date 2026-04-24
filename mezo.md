# Mount Studio — Deadzon

## What Mount Studio is
Mount Studio is Deadzon's premium ROM accent control module focused on Monet colors, visual effect tuning, component tinting, apply scope, control-app toggles, and profile-based presets.

## Tabs and functional actions
- **Preview**
  - Bottom Preview button jumps to Preview tab.
  - Live preview updates instantly when colors/effects/components/scope/profile state changes.
- **Colors**
  - All six preset chips are interactive (`Mint Glass`, `Aqua Frost`, `Soft Gold`, `Purple Mist`, `Sunset Soft`, `Graphite`).
  - Preset tap updates selected color, color name, hex label, and preview-linked component accents.
  - `Choose Your Monet Color` tries to launch `com.android.wallpaper/com.android.wallpaper.picker.CustomizationPickerActivity` through platform channel.
  - If unavailable, Snackbar shows: `Monet picker is not available on this ROM.`
  - `Pick from wallpaper` is a placeholder Snackbar.
  - `Manual color picker` opens a bottom sheet with selectable preset colors.
- **Effects**
  - All sliders are interactive and persist.
  - Labels are formatted as percentage (`opacity/intensity/glow/shadow/border`) and px (`blur/radius`).
  - Updates propagate immediately to preview state.
- **Components**
  - Every component row opens a bottom sheet color selector.
  - Selected component color updates row dot, preview usage, and persisted config.
- **Scope**
  - All scope switches are interactive and persisted.
  - `Choose apps` opens app picker.
  - Mock app set includes: YouTube, Telegram, Chrome, WhatsApp, Instagram, TikTok, Settings, System UI.
  - Selected app count is shown and persisted.
- **Control Apps**
  - Main Monet Effect switch is functional and persisted.
  - When OFF, app-level control toggles are disabled/greyed.
  - Search and category chips filter list.
  - `Select All` / `Deselect All` now apply to currently visible (filtered) items.
  - Every app toggle persists by exact key.
- **Profiles**
  - Profile tap applies full profile config values (color/effects/components/scope).
  - Active checkmark follows active profile.
  - `Reset profile` now confirms and restores defaults for current profile.
  - `Edit profile` remains a placeholder Snackbar.
- **Bottom actions**
  - `Reset` confirms then restores default `MountConfig` and persists immediately.
  - `Apply` saves current config and shows `Mount configuration saved.`

## Preserved XML keys
The Control Apps module preserves all required keys exactly (for example `paperos_switch_monet_color`, `paperos_monet_systemui`, `paperos_monet_securitycenter`, etc.) so the future ROM bridge can consume them without migration.

## How MountConfig is stored
- Storage layer: `SharedPreferences`
- Keys:
  - `mount_config_v1` (JSON for structured `MountConfig`)
  - `mount_active_tab_v1` (int for restoring last active tab)
- Format: JSON payload generated from `MountConfig.toJson()` and restored by `MountConfig.decode()`.
- Persisted fields include monet enable state, selected color + name, effect sliders, component colors, scope toggles, selected packages, control app toggle map, and active profile id.

## What is functional now
- Real local state wiring for tabs, buttons, toggles, sliders, profiles, and app picker.
- Real persistent save/load across restart (config + active tab).
- Real live preview updates for all interactive values.
- Real profile apply + reset-to-default behavior.
- Real scope + selected apps flow.
- Real control-app filtering, bulk actions, and exact-key persistence.
- Real Monet picker launch attempt with ROM-safe fallback.

## What is placeholder now
- Wallpaper-based picker extraction (stub feedback).
- Dynamic installed-package scanning (mock app list architecture ready for replacement).
- Edit profile detail workflow.
- Direct ROM/SystemUI write/apply bridge.

## Future ROM/SystemUI bridge contract
`MountService` / `SafetyBridge` should consume `mount_config_v1` and map:
- `monetEnabled` as master enable gate.
- `selectedColor`, effect values, and component color keys to overlay/resource patch values.
- `scope*` flags plus `selectedPackageNames` for selective apply targeting.
- `controlAppToggles` map by exact keys (for example `paperos_monet_systemui`) to the ROM-side toggle writer.
- `activeProfileId` for UX/telemetry context (optional for apply logic).
