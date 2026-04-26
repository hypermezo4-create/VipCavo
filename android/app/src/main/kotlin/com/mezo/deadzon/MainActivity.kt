package com.mezo.deadzon

import android.app.WallpaperManager
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject

class MainActivity : FlutterActivity() {
    private val channelName = "deadzon/mezo_settings"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
            .setMethodCallHandler { call, result ->
                val args = call.arguments as? Map<*, *>

                when (call.method) {
                    "readInt" -> {
                        val key = args.stringArg("key")
                        if (key.isNullOrBlank()) {
                            result.error("invalid_args", "Missing key", null)
                            return@setMethodCallHandler
                        }
                        result.success(
                            readInt(
                                args.storeTypeArg(),
                                key,
                                args.intArg("defaultValue", 0)
                            )
                        )
                    }

                    "writeInt" -> {
                        val key = args.stringArg("key")
                        if (key.isNullOrBlank()) {
                            result.error("invalid_args", "Missing key", null)
                            return@setMethodCallHandler
                        }
                        result.success(
                            writeInt(
                                args.storeTypeArg(),
                                key,
                                args.intArg("value", 0)
                            )
                        )
                    }

                    "readBool" -> {
                        val key = args.stringArg("key")
                        if (key.isNullOrBlank()) {
                            result.error("invalid_args", "Missing key", null)
                            return@setMethodCallHandler
                        }
                        val fallback = args.boolArg("defaultValue", false)
                        result.success(
                            readInt(
                                args.storeTypeArg(),
                                key,
                                if (fallback) 1 else 0
                            ) == 1
                        )
                    }

                    "writeBool" -> {
                        val key = args.stringArg("key")
                        if (key.isNullOrBlank()) {
                            result.error("invalid_args", "Missing key", null)
                            return@setMethodCallHandler
                        }
                        result.success(
                            writeInt(
                                args.storeTypeArg(),
                                key,
                                if (args.boolArg("value", false)) 1 else 0
                            )
                        )
                    }

                    "readString" -> {
                        val key = args.stringArg("key")
                        if (key.isNullOrBlank()) {
                            result.error("invalid_args", "Missing key", null)
                            return@setMethodCallHandler
                        }
                        result.success(
                            readString(
                                args.storeTypeArg(),
                                key,
                                args.stringArg("defaultValue") ?: ""
                            )
                        )
                    }

                    "writeString" -> {
                        val key = args.stringArg("key")
                        if (key.isNullOrBlank()) {
                            result.error("invalid_args", "Missing key", null)
                            return@setMethodCallHandler
                        }
                        result.success(
                            writeString(
                                args.storeTypeArg(),
                                key,
                                args.stringArg("value") ?: ""
                            )
                        )
                    }

                    "sendBroadcast" -> {
                        result.success(sendSafeBroadcast(args.stringArg("action")))
                    }

                    "openExternalApp" -> {
                        result.success(openExternalApp(args.stringArg("packageName")))
                    }

                    "launchMonetPicker" -> result.success(launchMonetPicker())
                    "getWallpaperColors" -> result.success(getWallpaperColors())
                    "getInstalledPackages" -> result.success(getInstalledPackages())
                    "getKnownPackageInstallStates" -> {
                        val packageNames = (args?.get("packageNames") as? List<*>)
                            ?.mapNotNull { it?.toString() }
                            ?: emptyList()
                        result.success(getKnownPackageInstallStates(packageNames))
                    }

                    "getCurrentPackageName" -> result.success(applicationContext.packageName)

                    "isPackageInstalled" -> {
                        result.success(isPackageInstalled(args.stringArg("packageName")))
                    }

                    "writeMountBridgeConfig" -> {
                        result.success(writeMountBridgeConfig(args?.get("config")))
                    }

                    else -> result.notImplemented()
                }
            }
    }

    private fun Map<*, *>?.storeTypeArg(): Int {
        return intArg("storeType", 0)
    }

    private fun Map<*, *>?.stringArg(name: String): String? {
        return this?.get(name)?.toString()
    }

    private fun Map<*, *>?.intArg(name: String, fallback: Int): Int {
        val raw = this?.get(name) ?: return fallback
        return when (raw) {
            is Int -> raw
            is Number -> raw.toInt()
            is String -> raw.toIntOrNull() ?: fallback
            is Boolean -> if (raw) 1 else 0
            else -> fallback
        }
    }

    private fun Map<*, *>?.boolArg(name: String, fallback: Boolean): Boolean {
        val raw = this?.get(name) ?: return fallback
        return when (raw) {
            is Boolean -> raw
            is Int -> raw == 1
            is Number -> raw.toInt() == 1
            is String -> raw.equals("true", ignoreCase = true) || raw == "1"
            else -> fallback
        }
    }

    private fun readString(storeType: Int, key: String, fallback: String): String {
        val resolver = applicationContext.contentResolver
        return try {
            when (storeType) {
                2 -> Settings.Global.getString(resolver, key) ?: fallback
                1 -> Settings.Secure.getString(resolver, key) ?: fallback
                else -> Settings.System.getString(resolver, key) ?: fallback
            }
        } catch (_: Exception) {
            fallback
        }
    }

    private fun writeString(storeType: Int, key: String, value: String): Boolean {
        val resolver = applicationContext.contentResolver
        return try {
            when (storeType) {
                2 -> Settings.Global.putString(resolver, key, value)
                1 -> Settings.Secure.putString(resolver, key, value)
                else -> Settings.System.putString(resolver, key, value)
            }
        } catch (_: Exception) {
            false
        }
    }

    private fun readInt(storeType: Int, key: String, fallback: Int): Int {
        val resolver = applicationContext.contentResolver
        return try {
            when (storeType) {
                2 -> Settings.Global.getInt(resolver, key, fallback)
                1 -> Settings.Secure.getInt(resolver, key, fallback)
                else -> Settings.System.getInt(resolver, key, fallback)
            }
        } catch (_: Exception) {
            fallback
        }
    }

    private fun writeInt(storeType: Int, key: String, value: Int): Boolean {
        val resolver = applicationContext.contentResolver
        return try {
            when (storeType) {
                2 -> Settings.Global.putInt(resolver, key, value)
                1 -> Settings.Secure.putInt(resolver, key, value)
                else -> Settings.System.putInt(resolver, key, value)
            }
        } catch (_: Exception) {
            false
        }
    }

    private fun sendSafeBroadcast(action: String?): Boolean {
        return try {
            if (action.isNullOrBlank()) {
                false
            } else {
                sendBroadcast(Intent(action))
                true
            }
        } catch (_: Exception) {
            false
        }
    }

    private fun openExternalApp(packageName: String?): Boolean {
        if (packageName.isNullOrBlank()) {
            return false
        }

        return try {
            val launchIntent = packageManager.getLaunchIntentForPackage(packageName)
            if (launchIntent == null) {
                false
            } else {
                launchIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                startActivity(launchIntent)
                true
            }
        } catch (_: Exception) {
            false
        }
    }

    private fun launchMonetPicker(): Boolean {
        val intents = listOf(
            Intent("android.settings.WALLPAPER_SETTINGS"),
            Intent("android.settings.DISPLAY_SETTINGS"),
            Intent().setClassName(
                "com.android.wallpaper",
                "com.android.wallpaper.picker.CustomizationPickerActivity"
            ),
            Intent().setClassName(
                "com.miui.home",
                "com.miui.home.launcher.settings.MiuiHomeSettings"
            ),
            Intent().setClassName(
                "com.miui.thememanager",
                "com.miui.thememanager.activity.ThemeTabActivity"
            ),
            Intent().setClassName(
                "com.miui.personalassistant",
                "com.miui.personalassistant.settings.WallpaperSettingsActivity"
            ),
        )

        for (intent in intents) {
            try {
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                if (intent.resolveActivity(packageManager) != null) {
                    startActivity(intent)
                    return true
                }
            } catch (_: Exception) {
                // Try next intent.
            }
        }
        return false
    }

    private fun getInstalledPackages(): List<Map<String, Any>> {
        return try {
            val applications = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                packageManager.getInstalledApplications(
                    PackageManager.ApplicationInfoFlags.of(0)
                )
            } else {
                @Suppress("DEPRECATION")
                packageManager.getInstalledApplications(0)
            }

            applications.map { appInfo ->
                mapOf(
                    "name" to (packageManager.getApplicationLabel(appInfo)?.toString()
                        ?: appInfo.packageName),
                    "packageName" to appInfo.packageName,
                    "installed" to true,
                )
            }.sortedBy { it["name"]?.toString()?.lowercase() ?: "" }
        } catch (_: Exception) {
            emptyList()
        }
    }

    private fun isPackageInstalled(packageName: String?): Boolean {
        if (packageName.isNullOrBlank()) {
            return false
        }
        return try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                packageManager.getPackageInfo(
                    packageName,
                    PackageManager.PackageInfoFlags.of(0)
                )
            } else {
                @Suppress("DEPRECATION")
                packageManager.getPackageInfo(packageName, 0)
            }
            true
        } catch (_: Exception) {
            false
        }
    }

    private fun getKnownPackageInstallStates(packageNames: List<String>): Map<String, Boolean> {
        if (packageNames.isEmpty()) {
            return emptyMap()
        }

        return packageNames
            .distinct()
            .associateWith { packageName -> isPackageInstalled(packageName) }
    }

    private fun writeMountBridgeConfig(config: Any?): Boolean {
        return try {
            val raw = when (config) {
                null -> "{}"
                is String -> config
                is Map<*, *> -> JSONObject(config).toString()
                else -> JSONObject.wrap(config)?.toString() ?: "{}"
            }
            val prefs = applicationContext.getSharedPreferences(
                "deadzon_bridge",
                Context.MODE_PRIVATE
            )
            prefs.edit().putString("mount_bridge_config", raw).apply()
            true
        } catch (_: Exception) {
            false
        }
    }

    private fun getWallpaperColors(): Map<String, Any?> {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O_MR1) {
            return mapOf(
                "available" to false,
                "message" to "Wallpaper colors are not available on this ROM."
            )
        }

        return try {
            val manager = WallpaperManager.getInstance(applicationContext)

            fun asMap(which: Int): Map<String, Int>? {
                val colors = manager.getWallpaperColors(which) ?: return null
                val primary = colors.primaryColor?.toArgb() ?: return null
                val secondary = colors.secondaryColor?.toArgb() ?: primary
                val tertiary = colors.tertiaryColor?.toArgb() ?: secondary
                return mapOf(
                    "primary" to primary,
                    "secondary" to secondary,
                    "tertiary" to tertiary,
                )
            }

            val system = asMap(WallpaperManager.FLAG_SYSTEM)
            val lock = asMap(WallpaperManager.FLAG_LOCK)
            if (system == null && lock == null) {
                mapOf(
                    "available" to false,
                    "message" to "Wallpaper colors are not available on this ROM."
                )
            } else {
                mapOf(
                    "available" to true,
                    "system" to (system ?: emptyMap<String, Int>()),
                    "lock" to (lock ?: emptyMap<String, Int>()),
                )
            }
        } catch (_: Exception) {
            mapOf(
                "available" to false,
                "message" to "Wallpaper colors are not available on this ROM."
            )
        }
    }
}
