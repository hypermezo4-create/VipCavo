# Codex Task: Full Kaorios Toolbox Recovery → DeadZone Integration

## Context
The repository is `VipCavo` / `DeadZone` Flutter project. The user lost the original Kaorios Toolbox source after formatting data, but uploaded the APK and recovery outputs into:

`reference/mezo/mezo/`

Relevant uploaded reference files/folders include:

- `KaoriosToolbox.apk`
- `Kaorios_raw_full.tar`
- `Kaorios_recovery_report.md`
- `res/`
- `resources/`
- `smali/`
- `smali.zip`

The current DeadZone project is Flutter with native Android bridge in Kotlin.

## Absolute non-negotiable locks
Do not change any of these unless the user explicitly says so later:

1. Do **not** change Android package/application identity:
   - `namespace = "com.mezo.deadzon"`
   - `applicationId = "com.mezo.deadzon"`
   - Kotlin package path: `com.mezo.deadzon`
2. Do **not** change signing/keystore behavior.
   - Do not add a new keystore.
   - Do not rename signing configs.
   - Do not replace or regenerate keys.
   - Keep the current `release` signing config behavior exactly as it is unless build fails and the fix is only mechanical.
3. Do **not** break or rename the existing MethodChannel:
   - `deadzon/mezo_settings`
4. Do **not** remove existing native bridge methods in `MainActivity.kt`.
5. Do **not** remove or rename existing Statusbar/SystemUI keys.
   Preserve these exactly:
   - `status_bar_elem_position`
   - `elem_clock`
   - `elem_notif`
   - `elem_bat`
   - `elem_net1`
   - `elem_net2`
   - `elem_wifi`
   - `elem_speed`
   - `elem_status`
   - `elem_prompt`
   - `elem_date`
   - `elem_weather`
6. Do **not** force hide/show statusbar elements. Layout order and visibility are separate.
7. Do **not** rewrite the whole app from scratch.
   Apply targeted additions and safe refactors only.
8. Do **not** delete the `reference/mezo/mezo/` files.
9. Do **not** mass-replace `mezo`, `deadzon`, or package names globally.

## Goal
Recover and port as much as possible from Kaorios Toolbox into DeadZone as a first-class module set, while preserving DeadZone identity and all existing ROM/settings keys.

The target result should feel like:

**DeadZone = Kaorios Toolbox recovery + DeadZone Studio + existing Statusbar/Control Center/Mount engine**

## Required implementation direction
Create a clean Flutter implementation using the recovered APK/resources as a reference. Do not paste broken decompiled Compose output directly into Flutter. Use the APK/recovery output to reconstruct behavior, UI structure, resources, labels, screens, and native bridge requirements.

Add new code under a clear module path such as:

- `lib/features/toolbox/`
- `lib/features/device_info/`
- `lib/features/payload_dumper/`
- `lib/features/fps_overlay/`
- `lib/features/kaorios_recovery/`

Use existing shared widgets/theme where possible:

- `DeadZonShell`
- `GlassCard`
- `deadzon_floating_tab_bar.dart`
- existing DeadZone theme controller
- existing native bridge patterns

## Visual target from Kaorios screenshots
Recreate the dark premium Kaorios/DeadZone style:

- black / deep navy / purple gradient background
- large rounded glass cards
- transparent purple-blue cards
- bright white text with soft secondary labels
- floating bottom navigation pill
- top action icons row
- smooth, lightweight motion
- no ugly technical clutter for normal users

## Screens/modules to recover and implement

### 1. Device Dashboard / Home
Rebuild the recovered Kaorios-style home:

- Top app bar with logo/title and quick action buttons
- Large hero card with device name and logo/background
- Mini cards:
  - RAM usage
  - Storage usage
  - Battery percentage
  - Chipset
  - Weather placeholder/live if available
  - More hardware
- Hardware details dialog:
  - Chipset
  - Manufacturer
  - CPU cores/max frequency
  - Board
  - Hardware
  - Supported ABIs
  - OpenGL ES
  - RAM
  - Storage
  - Resolution
  - Refresh rate if available
- About this device section:
  - Brand
  - Manufacturer
  - Product
  - Codename
  - Model
  - Android / SDK
  - Security patch
  - Kernel
  - Build ID
  - Build display
  - Build type
  - Build tags
  - Build time
  - Build host
  - Build user
  - Incremental
  - Codename version
  - Radio version
  - Java VM
  - Locale
  - Timezone
  - Fingerprint

Implement native device-info fetching safely through the existing Kotlin bridge or add new methods without renaming the existing channel.

### 2. System Tools page
Rebuild a grid/cards page matching Kaorios:

- Integrity Fix card
- Features card
- Spoofing App card
- Payload Dumper card
- FPS & CPU Overlay card
- Hidden Features card
- Notifications/Data version card

Keep UI labels recovered, but fit DeadZone style.

### 3. FPS & CPU Overlay screen
Rebuild the UI and settings shell:

- overlay permission required message
- grant overlay permission button/action
- Start / Stop buttons
- position picker:
  - top left
  - top center
  - top right
  - bottom left
- Display settings:
  - show FPS
  - show “FPS” label
  - reverse format
  - show app name
  - show package name
  - show CPU temperature
  - show CPU frequency
  - show CPU governor if recoverable
  - text size/padding/corner/background/alpha if visible in recovered resources/settings

Native implementation can be staged:

- Stage 1: UI + settings persistence + open overlay permission panel.
- Stage 2: Android foreground overlay service/quick tile port if practical from recovered APK.

If adding native overlay service, do it with new classes and manifest additions only. Do not alter package/applicationId/signing.

### 4. Payload Dumper screen
Rebuild:

- search partitions field
- From local selector
- From URL selector
- Parse button
- clear/cancel/open-folder/settings icons
- custom folder / user-agent settings if found in recovered report/resources
- progress/notification-ready UI shell

Native payload dumping can be staged:

- Stage 1: UI + file/url selection model + settings.
- Stage 2: implement foreground service logic if safely recoverable.

If adding provider/service/receiver, preserve package identity and add only required permissions/components.

### 5. Features / Integrity / Spoofing / Hidden Features pages
Recover the UI structure and existing user-owned configuration management screens:

- toggles/cards/segmented buttons
- app target list UI
- import/export/save/reload actions
- config cards
- app picker flows

Avoid adding brand-new bypass behavior. Reconstruct the user-owned app’s configuration UI and local import/export management. Keep risky/security-sensitive logic behind existing recovered code only if clearly present and do not invent new circumvention behavior.

### 6. Settings
Recover/merge:

- appearance/theme options
- haptics
- fallback mode
- data updates/status
- about dialog/info
- links buttons if present

## Native Android bridge rules
Current native bridge lives in:

`android/app/src/main/kotlin/com/mezo/deadzon/MainActivity.kt`

It already handles:

- `readInt`, `writeInt`, `readBool`, `writeBool`, `readString`, `writeString`
- `sendBroadcast`
- `openExternalApp`
- `launchMonetPicker`
- `getWallpaperColors`
- `getInstalledPackages`
- `getKnownPackageInstallStates`
- `getCurrentPackageName`
- `canWriteSystemSettings`
- `openWriteSettingsPanel`
- `isPackageInstalled`
- `writeMountBridgeConfig`

Add any new methods carefully to the same channel or create a separate clearly named channel only if necessary. Do not remove old methods.

Potential safe methods to add:

- `getDeviceSummary`
- `getHardwareDetails`
- `getBuildInfo`
- `canDrawOverlays`
- `openOverlayPermissionPanel`
- `getStorageStats`
- `getMemoryStats`
- `getBatteryInfo`

## Build requirements
After changes:

1. Run `flutter pub get`
2. Run `flutter analyze` if feasible
3. Run `flutter build apk --debug` or the repo’s current GitHub Actions compatible build
4. Fix compile errors only with targeted patches

## Expected deliverables

- Clean integrated DeadZone/Kaorios toolbox module
- No package/signing/key changes
- No broken existing Statusbar/Control Center/Mount screens
- New recovered screens accessible from DeadZone navigation/tools
- A short summary listing:
  - files changed
  - features recovered
  - features staged for later native service port
  - confirmation that app id/signing keys were not changed

