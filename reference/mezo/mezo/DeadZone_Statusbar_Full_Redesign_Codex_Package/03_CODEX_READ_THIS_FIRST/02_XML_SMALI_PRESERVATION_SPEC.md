# XML / Smali Preservation Spec

This file is the most important implementation rule.

The old mod works. The redesign must not break it.

## Preserve these at all costs

### XML
Keep:
- existing XML file names if referenced by Smali
- existing `android:id`
- existing `android:key`
- existing preference keys
- existing string keys used for SharedPreferences
- existing include IDs
- existing custom view class references

Do not remove any working preference entry.
Do not rename keys to prettier names.
Pretty labels can change, keys cannot.

### Smali
Keep:
- class names
- method names
- method signatures
- field names when referenced externally
- preference listener wiring
- apply methods
- storage methods
- broadcast/service hooks
- any root/system write code internally

Do not expose these details in the UI.

## Safe changes
You may:
- change visible titles/subtitles
- add new visual wrapper layouts
- add rounded drawable backgrounds
- add glassmorphism drawable XML
- add icons/drawables
- add reusable card styles
- add a bottom sheet/dialog layout
- add a clean preview board
- add segmented controls for Single Row / Two Rows
- add local UI state wrappers
- update animations
- add documentation

## Dangerous changes to avoid
Do not:
- delete old settings screens before replacement is verified
- rename resource files used by Smali
- remove IDs used in `findViewById`
- rename preference keys
- change signing/build configs
- move app package
- replace working internal logic with mock-only logic
- show raw apply errors to users

## Best implementation approach

1. Locate the existing Statusbar Adjustment entry screen.
2. Locate all old statusbar-related XML preference files.
3. Locate Smali/classes that load those XML files.
4. Keep their keys and listeners.
5. Build new visual layouts around the existing keys.
6. Map each old preference to a new polished control.
7. Keep apply calls exactly where they are, but make error messages user-friendly.
8. Test every section.

## UI labels mapping example

Raw/internal:
- status_bar_elem_position

Visible:
- Arrange Layout

Raw/internal:
- root apply failed

Visible:
- Changes saved. Advanced apply will run when available.

Raw/internal:
- system icon key

Visible:
- Status Icons
