# Build and Test Checklist

## Before build
- Confirm package name unchanged.
- Confirm applicationId unchanged.
- Confirm signing configs unchanged.
- Confirm google-services.json unchanged.
- Confirm GitHub Actions unchanged.
- Confirm old preference keys unchanged.
- Confirm old XML android:key values unchanged.
- Confirm old Smali method signatures unchanged.

## UI tests
- Open Statusbar tab.
- Main screen shows Statusbar Studio.
- Layout Studio card appears.
- Live Preview appears.
- Quick Sections appear.
- No Root/ROM/key/raw preference wording appears.

## Arrange Layout
- Tap Arrange layout.
- Bottom sheet opens.
- Single Row selected by default.
- Drag starts immediately without long press.
- Reorder updates preview instantly.
- Save closes/saves and shows friendly message.
- Switch to Two Rows.
- Two-row preview appears.
- Drag between row groups works.
- Restore Default returns to Single Row.

## Sections
Check:
- Battery screen opens and old battery options still work.
- Clock screen opens and old clock options still work.
- Network screen opens and old network options still work.
- Date & Weather screen opens and old options still work.
- Icons screen opens and old visibility/style options still work.
- Prompt & Background screen opens and old options still work.
- Background advanced options still work.

## Non-root behavior
- App must not crash without root/permission.
- Preview and local save must work.
- No technical permission errors shown.

## Root/apply behavior if available
- Existing apply engine should run silently.
- Failure should not expose raw errors.

## Final build
- Build APK successfully.
- Launch app.
- Navigate Home / Mount / Statusbar / Settings.
- Confirm no unrelated screens broke.
