# MASTER CODEX PROMPT — DeadZone / VipCavo Full Statusbar UI Redesign

You are working on the DeadZone / VipCavo project.

The old Statusbar mod/settings screens are working. Do not break functionality.
Your task is to redesign the entire Statusbar UI while preserving the same XML/Smali wiring, preference keys, IDs, and internal apply logic.

Use this package:
- `01_OLD_WORKING_MOD_FULL_REFERENCE/` shows the old working mod screens.
- `02_NEW_FULL_UI_REDESIGN_REFERENCE/` shows the new target UI design.
- `04_IMPLEMENTATION_MAPS/` explains how to map old screens to new screens.
- `05_BUILD_AND_TEST_CHECKLIST/` contains the final test checklist.

## Absolute restrictions

Do NOT change:
- package name
- applicationId
- signing configs
- release keys
- google-services.json
- Firebase config
- Gradle namespace
- GitHub Actions/workflows
- AndroidManifest app/package configuration
- existing internal preference keys
- existing XML android:key values
- existing Smali method names/signatures unless strictly required for UI binding
- existing apply/root/ROM/internal logic
- existing storage model
- existing working behavior

Do NOT rewrite the entire project.
Do a targeted Statusbar UI redesign only.

## Main goal

Replace the old raw settings-looking Statusbar screens with a premium UI:

# Statusbar Studio / Layout Studio

It must include the same working details from the old mod but displayed in a clean modern way.

## User-facing wording

Never show technical words to the user:
- Root
- ROM
- key
- package
- applicationId
- status_bar_elem_position
- preference key names
- shell command
- su command
- system write error

Friendly messages only:
- Layout saved
- Default layout restored
- Preview updated
- Changes saved
- Applied when available

## Required main screens

Implement/redesign these sections:

1. Statusbar Studio main screen
   Reference: `02_NEW_FULL_UI_REDESIGN_REFERENCE/01_STATUSBAR_STUDIO_MAIN_SCREEN.png`

2. Arrange Layout — Single Row
   Reference: `02_NEW_FULL_UI_REDESIGN_REFERENCE/02_ARRANGE_LAYOUT_SINGLE_ROW_SHEET.png`

3. Arrange Layout — Two Rows
   Reference: `02_NEW_FULL_UI_REDESIGN_REFERENCE/03_ARRANGE_LAYOUT_TWO_ROWS_SHEET.png`

4. Battery
   Reference: `02_NEW_FULL_UI_REDESIGN_REFERENCE/04_BATTERY_FULL_SETTINGS_REDESIGN.png`

5. Clock
   Reference: `02_NEW_FULL_UI_REDESIGN_REFERENCE/05_CLOCK_FULL_SETTINGS_REDESIGN.png`

6. Network
   Reference: `02_NEW_FULL_UI_REDESIGN_REFERENCE/06_NETWORK_FULL_SETTINGS_REDESIGN.png`

7. Date & Weather
   Reference: `02_NEW_FULL_UI_REDESIGN_REFERENCE/07_DATE_WEATHER_FULL_SETTINGS_REDESIGN.png`

8. Icons
   Reference: `02_NEW_FULL_UI_REDESIGN_REFERENCE/08_ICONS_FULL_SETTINGS_REDESIGN.png`

9. Prompt & Background
   Reference: `02_NEW_FULL_UI_REDESIGN_REFERENCE/09_PROMPT_BACKGROUND_FULL_SETTINGS_REDESIGN.png`

10. Background Advanced
   Reference: `02_NEW_FULL_UI_REDESIGN_REFERENCE/10_BACKGROUND_ADVANCED_FULL_SETTINGS_REDESIGN.png`

## UI style

Use:
- dark navy/black gradient background
- translucent glass cards
- cyan/blue edge glow
- large rounded corners
- subtle inner shadows
- polished section cards
- smooth iOS-like transitions
- direct touch drag
- no long press for layout dragging
- readable typography
- clear icons
- no clutter

## Main Screen Structure

Title:
`Statusbar Studio`

Subtitle:
`Arrange your layout with live preview`

Main card:
`Layout Studio`
Subtitle:
`Design and arrange your status bar`

Actions:
- Arrange layout
- Preview
- Restore default

Live Preview:
- A realistic statusbar preview strip.
- Default = Single Row.
- All icons visible.
- No hidden/dimmed icons.

Quick Sections:
- Battery
- Clock
- Network
- Date & Weather
- Icons
- Prompt & Background

Each quick section must open/use the existing old section logic with a new UI wrapper.

## Arrange Layout

Use a bottom sheet/dialog, not a full ugly settings page.

Requirements:
- 80–90% height.
- Smooth rounded top corners.
- Drag handle.
- Header:
  - Reset
  - Arrange Layout
  - Save
- Segmented control:
  - Single Row
  - Two Rows
- Live Preview at top.
- Drag tiles below.
- Drag starts immediately on touch.
- No long press.
- Preview updates instantly.

## Default layout behavior

Default layout must be Single Row.

Restore Default must restore Single Row, not Two Rows.

Two Rows is optional.

### Single Row order

1. Time / Status Time
2. Notification / Call
3. Speed
4. Clock
5. Prompt / Plug
6. Netspeed / Moon
7. Temperature
8. Date & Day
9. Bluetooth
10. SIM 1
11. SIM 2
12. Wi-Fi
13. Battery
14. Weather
15. Date 31/12
16. Alarm
17. Network Blue
18. Network Red
19. Wi-Fi Secondary
20. Charging

### Two Rows optional default

Left side:
Row 1:
- Time / Status Time
- Red Notification / Call
- Gauge / Speed

Row 2:
- Clock
- Plug / Prompt
- Moon / Netspeed

Right side:
Row 1:
- Temperature
- Date / Day 10
- Bluetooth
- SIM 1
- SIM 2
- Wi-Fi
- Battery

Row 2:
- Weather
- 31/12 Date
- Alarm
- Network Blue
- Network Red
- Wi-Fi Secondary
- Charging

## XML/Smali implementation rules

If this is an Android XML/Smali based project:
- Prefer editing layout XML and drawable XML styles first.
- Keep all `android:id` values that Smali references.
- Keep all `android:key` preference keys.
- Keep all classes/method references.
- If a view must be replaced, keep the same ID and rebind it safely.
- If using included layouts, keep old containers and restyle them.
- Do not rename XML files if Smali references their resource names.
- Do not delete old preference XML files; wrap/restyle/reuse them.
- Do not remove old Smali listeners; only adjust UI labels/containers if needed.
- If adding new layout files, connect them through existing navigation without removing old working routes.

If this is Flutter:
- Keep package/application/signing unchanged.
- Preserve existing services/controllers/apply logic.
- Replace Statusbar screen widgets only.
- Do not change unrelated screens.

## Saving/apply behavior

When user changes anything:
- update preview instantly
- save preference locally
- call existing apply method silently only if available
- if apply fails because permission is not available, do not show a technical error
- show friendly confirmation only

## Final deliverables expected from Codex

- Updated project files only.
- No unrelated rewrites.
- Build passes.
- Existing keys preserved.
- Statusbar UI matches the new reference as much as possible.
- Add or update a documentation note:
  `docs/statusbar_full_redesign_hotfix.md`
