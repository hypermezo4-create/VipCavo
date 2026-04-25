# Mezo Statusbar Source Port Map

Primary references parsed for this Flutter port:

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
- `reference/mezo/mezo/res/layout/ed_seekbar_layout.smali`

## Reusable primitive mapping

- `EdSeekBarPreference` -> `MezoStepSlider` (`- / +` + slider + value)
- `XMiuiDropDownPreference` -> Bottom-sheet picker row
- `XMiuiColorPickerPreference` -> color chip + bottom-sheet palette
- `MiuiFontStylePreference` -> select/font pickers in section rows

## Background module scope (source backed)

Each item mirrors one `elem_bg_*.smali` file with:

- 3 color controls: first/start, second/end, stroke/border
- Margins: left, right, top, bottom
- Padding/frame offsets: left, right
- Border width
- Corner radius: LT, RT, LB, RB

Targets:

- Clock, Battery, SIM 1, SIM 2, WiFi, Network Speed,
  Notification icon, Status icon, Weather, Date, Prompt icon.
