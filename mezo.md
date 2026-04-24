# Mezo Change Log

## 2026-04-24
- Added a new **Integrity** dashboard card in Deadzon Home.
- Integrity now acts as an external launcher shortcut for package `com.kousei.kaorios` only.
- Added Android package visibility query for `com.kousei.kaorios`.
- Implemented `ExternalAppLauncherService` and native bridge launch handling via `PackageManager.getLaunchIntentForPackage`.
- If Kaorios is missing, Deadzon shows: `Kaorios Toolbox is not installed.`
- No Kaorios code/resources/APK are copied or embedded.
