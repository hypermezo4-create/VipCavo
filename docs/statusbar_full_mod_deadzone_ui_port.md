# Statusbar Full Mod DeadZone UI Port

## Scope and source audit

This port uses the old Mezo source as the functional specification and keeps legacy compatibility keys unchanged.

Primary audited references:

- `reference/mezo/mezo/res/xml/settings_resize_elite.smali`
- `reference/mezo/mezo/res/xml/my_battery_settings.smali`
- `reference/mezo/mezo/res/xml/my_clock_settings.smali`
- `reference/mezo/mezo/res/xml/speed_elite.smali`
- `reference/mezo/mezo/res/xml/elem_net_elite.smali`
- `reference/mezo/mezo/res/xml/settings_notif.smali`
- `reference/mezo/mezo/res/xml/settings_status_icons.smali`
- `reference/mezo/mezo/res/xml/settings_date_elite.smali`
- `reference/mezo/mezo/res/xml/settings_weather_icon.smali`
- `reference/mezo/mezo/res/xml/statusbar_elem_prompt.smali`
- `reference/mezo/mezo/res/xml/settings_iback_elite.smali`
- `reference/mezo/mezo/res/xml/elem_bg_*.smali`
- `reference/mezo/mezo/smali/...` statusbar-related classes for intent/apply action strings.

## Old full sections found

Full section tree implemented in Flutter statusbar module:

1. Resize statusbar
2. Battery
3. Clock
4. Netspeed
5. Network
6. Notification icons
7. Status icons
8. Date
9. Weather
10. Prompt icon
11. Background of statusbar icons

## Flutter screens/components created or updated

- `StatusbarScreen` updated to expose the complete section tree as the primary navigation (not quick replacement).
- Existing `Arrange Layout` flow retained with single-row default and two-row optional behavior.
- `StatusbarDetailScreen` uses source-backed + curated controls per section.
- `StatusbarSourceInventory` added to preserve extracted legacy controls from old XML.
- `StatusbarSettingsRepository` added to persist every control using old key names in local storage fallback.

## Old keys preserved

- Legacy key names are preserved via `StatusBarSettingItem.legacyKey` for all controls.
- Source extraction file `statusbar_source_inventory.dart` includes extracted keys and defaults for:
  - resize_statusbar: 10 keys
  - battery: 32 keys
  - clock: 27 keys
  - netspeed: 7 keys
  - network: 8 keys
  - notification_icons: 5 keys
  - status_icons: 5 keys
  - date: 6 keys
  - weather: 6 keys
  - prompt_icon: 2 keys
- Background section preserves `elem_bg_*` keys via `MezoPortMap.backgroundTargets` and source references.

## How settings are saved

- Every visible setting now writes through `StatusbarSettingsRepository.write(...)`.
- Storage uses local persistence fallback under `statusbar_legacy_<old_key>` names so control state remains key-compatible.
- Resize/native-compatible keys continue writing through `ResizeStatusbarService.write(...)`.

## Preview update behavior

- Section detail views update immediately in memory (`_values`) for instant UI response.
- Live previews for resize, battery, and clock update with state changes.
- Arrange layout preview updates instantly when reordering icons.

## Apply bridge behavior

- If a setting has a known old intent action, `StatusbarSettingsRepository` tries `ResizeStatusbarService.sendBroadcastIntent(intentAction)`.
- If native bridge is unavailable, setting is still saved locally and UI stays synchronized.
- This keeps UI honest while preserving a path for native apply integration.

## What was not changed

- Legacy key naming was not renamed.
- Old source section IDs and mapping structure remain aligned to Mezo references.
- Existing statusbar board serialized key (`status_bar_elem_position`) and order model were preserved.

## Build / analyze result

Commands attempted in this environment:

- `flutter analyze` → failed because `flutter` command is not installed in the container.
- `flutter build apk --release` not executed for the same environment limitation.

