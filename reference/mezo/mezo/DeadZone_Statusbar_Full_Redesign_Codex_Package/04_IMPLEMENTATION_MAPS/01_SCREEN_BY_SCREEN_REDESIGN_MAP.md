# Screen-by-Screen Redesign Map

Use this map to redesign the old working mod into the new full UI.

## 1. Old Statusbar Adjustment main page → New Statusbar Studio

New reference:
`02_NEW_FULL_UI_REDESIGN_REFERENCE/01_STATUSBAR_STUDIO_MAIN_SCREEN.png`

Keep old navigation target and internal screen route.
Replace old visual layout with:

- Statusbar Studio title
- Layout Studio card
- Arrange layout action
- Preview action
- Restore default action
- Live Preview board
- Quick Sections grid

Quick Sections:
- Battery
- Clock
- Network
- Date & Weather
- Icons
- Prompt & Background

## 2. Old statusbar icon order / position screen → Arrange Layout Sheet

New references:
- `02_ARRANGE_LAYOUT_SINGLE_ROW_SHEET.png`
- `03_ARRANGE_LAYOUT_TWO_ROWS_SHEET.png`

Keep same old position/order keys.

New behavior:
- Bottom sheet/dialog.
- Single Row default.
- Two Rows optional.
- Direct drag, no long press.
- Save writes old keys.
- Reset writes old default keys.
- Preview updates instantly.

## 3. Battery old settings → Battery redesign

New reference:
`04_BATTERY_FULL_SETTINGS_REDESIGN.png`

Preserve old battery keys and options.
New layout sections:
- Live Preview
- Battery style
- Show percentage
- Percentage style
- Charging indicator
- Low battery behavior
- Size & position
- Color & style

Do not remove any old battery option. If old has extra options not shown in mockup, place them under Advanced / More battery options.

## 4. Clock old settings → Clock redesign

New reference:
`05_CLOCK_FULL_SETTINGS_REDESIGN.png`

Preserve:
- show clock
- time format
- seconds
- AM/PM
- position
- alignment
- style
- font size
- spacing
- date beside clock if existing

If old has more clock options, keep them under Advanced / More clock options.

## 5. Network old settings → Network redesign

New reference:
`06_NETWORK_FULL_SETTINGS_REDESIGN.png`

Preserve:
- Wi-Fi visibility
- mobile data visibility
- dual SIM indicators
- preferred SIM display
- network speed
- speed unit
- traffic indicators
- network style
- VoLTE / VoWiFi / roaming icons if existing
- spacing

Keep old keys exactly.

## 6. Date & Weather old settings → Date & Weather redesign

New reference:
`07_DATE_WEATHER_FULL_SETTINGS_REDESIGN.png`

Preserve:
- show date
- show day
- date format
- show weather
- weather style
- temperature unit
- position
- alignment
- size/font
- spacing
- update behavior if existing

## 7. Icons old settings → Icons redesign

New reference:
`08_ICONS_FULL_SETTINGS_REDESIGN.png`

Preserve:
- status icons visibility
- notification icons visibility
- max visible icons
- icon size
- icon spacing
- icon style
- color theme
- icon groups

Keep status icons and notification icons separate if old logic separates them.

## 8. Prompt / Background old settings → Prompt & Background redesign

New reference:
`09_PROMPT_BACKGROUND_FULL_SETTINGS_REDESIGN.png`

Preserve:
- prompt icon visibility
- prompt style
- prompt position
- prompt color
- background panel
- blur
- opacity
- corner radius
- border
- glow
- padding
- color presets

## 9. Background advanced old settings → Background Advanced redesign

New reference:
`10_BACKGROUND_ADVANCED_FULL_SETTINGS_REDESIGN.png`

Preserve:
- background enable
- fill style
- background tint
- opacity
- blur
- corner radius
- outline
- shadow
- height
- custom height
- padding
- linked padding toggle if existing

## Unmatched old options

If an old setting exists and does not appear in the new mockups:
- Do not remove it.
- Put it in a final Advanced card.
- Keep its current key and behavior.
- Use friendly label.
