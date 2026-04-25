# Statusbar Layout Studio Flutter Hotfix

## Scope
This hotfix updates only the Flutter Statusbar screen to ship a polished **Statusbar Studio / Layout Studio** experience while keeping the existing app navigation and section routes intact.

## What was implemented
- Replaced the old board-heavy Statusbar entry UI with a modern glassmorphism screen:
  - Title: **Statusbar Studio**
  - Subtitle: **Arrange your layout with live preview**
  - Main card: **Layout Studio**
  - Actions: **Arrange layout**, **Preview**, **Restore default**
- Added a live preview strip that supports:
  - **Single Row** mode (default)
  - **Two Rows** mode (optional)
- Added an Arrange Layout bottom sheet with:
  - reset / save header actions
  - segmented control (Single Row / Two Rows)
  - direct drag-and-drop swapping (no long press)
  - instant visual updates while arranging
- Added six quick sections matching requested UX labels:
  - Battery
  - Clock
  - Network
  - Date & Weather
  - Icons
  - Prompt & Background

## Persistence
Layout mode and icon arrangement are stored in local preferences:
- `statusbar_studio_layout_mode`
- `statusbar_studio_single_order`
- `statusbar_studio_two_row_order`

## Friendly UX copy
User feedback messages now use friendly wording only:
- Layout saved
- Default layout restored
- Preview updated

## Notes
- Bottom navigation and route wiring are unchanged.
- Existing detail screens for each Statusbar section remain intact and are still reachable from quick sections.
