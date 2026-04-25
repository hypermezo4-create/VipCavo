# STATUSBAR_ELEMENT_PORT_MAP

## Source of truth
- Smali class: `reference/mezo/mezo/smali/com/android/settings/statusbarelement/PositionsElementsStatusbarDouble.smali`
- Preference key: `status_bar_elem_position`
- Exact default serialized layout:
  - `elem_status.33;elem_clock.21;elem_bat.31;elem_net1.1;elem_net2.11;elem_wifi.2;elem_notif.22;elem_speed.3;elem_weather.32;elem_date.12;`

## Legacy position code parser / encoder
- Serialized entry format: `<element_id>.<positionCode>;`
- Parser rules:
  - split by `;`
  - split each token by `.`
  - `element_id` must map to `nameElement[]`
  - `positionCode` is parsed as integer and stored directly
- Encoder rules:
  - always outputs in original `nameElement[]` order
  - each module writes exact form: `elem_name.positionCode;`
- Sector logic derived from original methods:
  - `sectorOfdX`: sectors are `0`, `10`, `20`, `30` (plus reserved lower-area sectors used in Flutter board interaction)
  - `getEmptyPozition`, `upPosition`, `downPosition`: movement resolves to nearest free slot inside current sector

## Elements and assets (all rendered, all draggable)
| Element id | Original default code | Asset used | Rendered | Draggable |
|---|---:|---|---|---|
| elem_status | 33 | `reference/mezo/mezo/res/drawable-xxxhdpi/elem_status.png` | Yes | Yes |
| elem_clock | 21 | `reference/mezo/mezo/res/drawable-xxxhdpi/elem_clock.png` | Yes | Yes |
| elem_bat | 31 | `reference/mezo/mezo/res/drawable-xxxhdpi/elem_bat.png` | Yes | Yes |
| elem_net1 | 1 | `reference/mezo/mezo/res/drawable-xxxhdpi/elem_net1.png` | Yes | Yes |
| elem_net2 | 11 | `reference/mezo/mezo/res/drawable-xxxhdpi/elem_net2.png` | Yes | Yes |
| elem_wifi | 2 | `reference/mezo/mezo/res/drawable-xxxhdpi/elem_wifi.png` | Yes | Yes |
| elem_notif | 22 | `reference/mezo/mezo/res/drawable-xxxhdpi/elem_notif.png` | Yes | Yes |
| elem_speed | 3 | `reference/mezo/mezo/res/drawable-xxxhdpi/elem_speed.png` | Yes | Yes |
| elem_weather | 32 | `reference/mezo/mezo/res/drawable-xxxhdpi/elem_weather.png` | Yes | Yes |
| elem_date | 12 | `reference/mezo/mezo/res/drawable-xxxhdpi/elem_date.png` | Yes | Yes |

## Port status
- Default layout is now source-data driven from serialized string.
- Save/restore now reads and writes `status_bar_elem_position` directly.
- Layout generation is no longer guessed from simplified side/row defaults.
