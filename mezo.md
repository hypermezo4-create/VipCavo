# Mount Studio — Deadzon

## What Mount Studio is
Mount Studio is Deadzon's premium ROM accent control module focused on Monet colors, visual effect tuning, component tinting, apply scope, control-app toggles, and profile-based presets.

## Tabs and features added
- **Preview**: Real widget-based live preview (statusbar, toggles, slider, switch, checkbox, notification card).
- **Colors**: Preset chips, selected color details, placeholder pickers, and Android Monet Picker launcher button.
- **Effects**: Persistent tuning sliders (opacity, blur, accent, glow, corner radius, shadow depth, border visibility).
- **Components**: Component color rows with current indicator + placeholder tap actions.
- **Scope**: Scope toggles and app picker flow for selected packages.
- **Control Apps**: Main Monet switch + searchable category-filtered list of XML-compatible control keys and per-app toggles.
- **Profiles**: Preset profiles with active state and instant application.

## Preserved XML keys
The Control Apps module preserves all required keys exactly (for example `paperos_switch_monet_color`, `paperos_monet_systemui`, `paperos_monet_securitycenter`, etc.) so the future ROM bridge can consume them without migration.

## How MountConfig is stored
- Storage layer: `SharedPreferences`
- Key: `mount_config_v1`
- Format: JSON payload generated from `MountConfig.toJson()` and restored by `MountConfig.decode()`.
- Saved fields include monet enable state, selected color, effect sliders, component colors, scope toggles, selected package names, control app toggle map, and active profile id.

## Future ROM/SystemUI bridge contract
Future SafetyBridge / MountService integration should read persisted JSON and map:
- `paperos_switch_monet_color` to master enable behavior.
- `controlAppToggles` map entries to app-specific XML keys.
- scope flags and selected packages to selective patch application rules.
- visual values to dynamic resources / overlays where allowed.

## What is real now
- Real local state.
- Real persistent storage.
- Real live preview updates.
- Real profile apply behavior.
- Real scope/app selection flow.
- Real Control Apps data model and toggle persistence.
- Real Android intent launch attempt for Monet picker with graceful fallback.

## What is placeholder now
- Manual color picker UI (stub feedback).
- Wallpaper-based picker extraction (stub feedback).
- Dynamic installed-package scanning (mock app list architecture ready for replacement).
- Edit/reset custom profile detail workflows.
- Direct ROM/SystemUI write/apply bridge.

## Next steps for system integration
1. Replace mock app loader with real installed-package repository.
2. Wire `MountService.applyConfig` into SafetyBridge transaction layer.
3. Add validated ROM capability checks before writing runtime resources.
4. Implement full component color picker dialog.
5. Add profile create/edit/delete persistence.
