# Kaorios Toolbox APK Recovery Report

Source: `KaoriosToolbox.apk`
Package: `com.kousei.kaorios`
Version string found in manifest: `2.0.3.9`
SDK indicators: min/target compile strings include `16` and Android SDK-related metadata.

## Main recovered manifest components

- `com.kousei.kaorios.MainActivity`
- `com.kousei.kaorios.data.UpdateReceiver`
- `com.kousei.kaorios.data.ToolboxUpdateWorker`
- `com.kousei.kaorios.fps.FpsMonitorService`
- `com.kousei.kaorios.fps.FpsOverlayTileService`
- `com.kousei.kaorios.payload.PayloadDumperForegroundService`
- `com.kousei.kaorios.payload.PayloadDumperCancelReceiver`
- `com.kousei.kaorios.payloaddump.fileprovider`
- `com.kousei.framework.KaoriosFramework`

## Framework / dependency signals recovered

- Kotlin + Jetpack Compose
- Material 3
- Navigation Compose
- DataStore Preferences
- Room Runtime / Room KTX
- WorkManager Runtime / WorkManager KTX
- OkHttp
- AndroidX Startup
- Profile Installer
- FileProvider
- Quick Settings TileService
- Foreground services

## Major app modules recovered

### Home / Device overview
- Hero card with device name and subtitle `Mod by Kousei`
- Device name edit/reset/gallery hero references
- RAM card
- Storage card
- Battery card
- Chipset card
- Weather card
- More hardware card
- About this device section
- Hardware details dialog
- Software/build information section

### Tools Center
- System Tools grid
- Integrity Fix
- Features
- Spoofing App
- Payload Dumper
- FPS & CPU overlay
- Hidden features
- Notifications / data version card

### Payload Dumper
Recovered UI/resource keys:
- `payload_dumper`, `payload_dumper_desc`
- `payload_from_local`, `payload_from_url`
- `payload_search`, `payload_parse`, `payload_clear`
- `payload_ota_info`, `payload_ota_url`
- `payload_image_list`, `payload_image_name`, `payload_image_size`, `payload_image_sha256`
- `payload_dump`, `payload_done`, `payload_dump_success_message`
- `payload_open_folder_failed`, `payload_share_failed`
- `payload_custom_ua`, `payload_tools_settings`
- `payload_notification_parsing`, `payload_notification_dumping`, `payload_notification_idle`
- `payload_about_title`, `payload_developer`, `payload_source_code`, `payload_author_rcmiku`

### FPS & CPU overlay
Recovered UI/resource keys:
- `fps_title`
- `fps_overlay_enabled`
- `fps_position`
- `fps_position_top_left`, `fps_position_top_center`, `fps_position_top_right`, `fps_position_bottom_left`
- `fps_show_fps`, `fps_show_fps_text_label`
- `fps_reverse_fps_text`
- `fps_show_app_label`, `fps_show_package_name`
- `fps_show_cpu_info`, `fps_show_cpu_temp`, `fps_show_cpu_freq`, `fps_show_cpu_gov`
- `fps_show_background`, `fps_bg_color`, `fps_bg_alpha`
- `fps_text_color`, `fps_text_alpha`, `fps_text_size_sp`
- `fps_corner_radius`, `fps_padding_dp`, `fps_offset_x`, `fps_offset_y`
- `fps_text_alignment_start`, `fps_text_alignment_center`, `fps_text_alignment_end`
- `fps_tile_active`, `fps_tile_inactive`, `fps_tile_need_permission`, `fps_tile_need_root`

### Features / Integrity / Spoof configuration
Recovered UI/config keys:
- `kaorios_spoof_gms`
- `kaorios_spoof_vending`
- `kaorios_keybox_enabled`
- `kaorios_keybox_apply_all`
- `kaorios_keybox_apply_all_mode`
- `kaorios_spoof_photos`
- `kaorios_spoof_gameprops`
- `kaorios_spoof_tft`
- `kaorios_pif_json`
- `kaorios_target_txt`
- `kaorios_keybox_xml`
- `kaorios_gameprops_json`
- `kaorios_attestation_key`
- `auto_pif`, `auto_keybox`
- Modes: `auto`, `leaf`, `gen`

### Hidden settings/features
Recovered system settings shortcuts include:
- Accessibility
- Notification listener
- App details / app permissions
- Autofill
- Battery saver
- Bluetooth
- Date/time
- Developer options
- Display
- Input method
- Internal storage
- Language/locale
- Location
- Manage all apps
- Manage default apps
- NFC
- Privacy
- Security
- Sound
- VPN
- Wi-Fi
- Overlay permission
- Write settings permission

### Settings / Appearance / Data
Recovered settings keys:
- `settings_group_about`
- `settings_group_appearance`
- `settings_group_data`
- `settings_group_system`
- `settings_row_avatar`
- `settings_row_debug`
- `settings_row_fallback`
- `settings_row_gradient_cards`
- `settings_row_haptic`
- `settings_row_wallpaper`
- `settings_suggest_enable_fallback`
- `settings_row_gradient_cards_desc`

## Important endpoints / links recovered

- `https://github.com/Wuang26/Kaorios-Toolbox`
- `https://github.com/Wuang26/Kaorios-Toolbox/releases`
- `https://raw.githubusercontent.com/Wuang26/Kaorios-Toolbox/main/Toolbox-data/`
- `https://cdn.jsdelivr.net/gh/Wuang26/Kaorios-Toolbox@main/Toolbox-data/`
- `https://wuang26.github.io/Kaorios-Toolbox/Toolbox-data/`
- `https://t.me/KaoriosToolbox`
- `https://github.com/rcmiku/Payload-Dumper-Compose`

## Recovered asset/resource files

Raw APK extraction contains:
- `AndroidManifest.xml` binary manifest
- `classes.dex`
- `resources.arsc`
- `res/*.xml`
- `res/*.png`, `res/*.jpg`, `res/*.webp`, `res/*.9.png`
- `assets/dexopt/baseline.prof`
- native libraries for `arm64-v8a`, `armeabi-v7a`, `x86`, `x86_64`

Large visual assets found:
- `res/sL.png` - 1376x768 PNG
- `res/5d.png` - 1376x768 PNG
- `res/BP.png` - 2000x446 PNG
- `res/wI.jpg` - 722x976 JPEG
- `res/Xd.jpg` - 668x813 JPEG
- `res/pu.png` - 860x860 PNG

## Recommended rebuild direction

Do not rely on decompiled Compose output as final source. Best recovery path:
1. Use raw assets/resources from the APK.
2. Use manifest components and resource keys as the feature map.
3. Rebuild clean Kotlin/Compose modules manually inside DeadZone.
4. Reuse feature behavior where recoverable, but keep DeadZone package/signing/keys unchanged.
5. Port modules one by one: Home -> Tools Grid -> Device Info -> Payload Dumper -> FPS Overlay -> Settings.
