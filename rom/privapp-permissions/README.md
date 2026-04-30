# DeadZone privapp-permissions

This XML is for ROM/system integration only.

- Place `com.mezo.deadzon.xml` via the ROM/build system into the correct permissions directory, such as:
  - `/system/etc/permissions/`
  - `/system_ext/etc/permissions/`
- The target directory depends on how DeadZone is packaged in your ROM image.
- Placing this file inside the APK does **not** grant privileged permissions.
- DeadZone still runs safely without these privileges, but System apply may be unavailable.
