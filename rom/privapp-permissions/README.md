# DeadZone privapp-permissions ROM integration

DeadZone (`com.mezo.deadzon`) is designed for privileged ROM integration **without root**.

## Install as priv-app

Install the APK as a privileged app in one of these locations:

- `/system_ext/priv-app/DeadZone/DeadZone.apk`
- `/system/priv-app/DeadZone/DeadZone.apk`

## Install the permissions XML

Install `com.mezo.deadzon.xml` in one of these permissions locations:

- `/system_ext/etc/permissions/com.mezo.deadzon.xml`
- `/system/etc/permissions/com.mezo.deadzon.xml`

## Important behavior notes

- Reboot is required after placing the APK/XML.
- APK install alone will **not** grant privileged/system permissions.
- Some permissions require platform signature and/or ROM framework support.
- Custom permissions such as `com.android.systemui.permission.PLUGIN` only work when the ROM defines and grants them.
- DeadZone never uses root.
- If system privileges are unavailable, show:
  - `System apply is unavailable in this build. Your layout is saved in DeadZone.`
