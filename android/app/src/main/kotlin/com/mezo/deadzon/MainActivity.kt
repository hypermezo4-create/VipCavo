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
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName).setMethodCallHandler { call, result ->
            val args = call.arguments as? Map<*, *>
            val key = args?.get("key") as? String
            val storeType = (args?.get("storeType") as? Int) ?: 0

            when (call.method) {
                "readInt" -> {
                    if (key == null) {
                        result.error("invalid_args", "Missing key", null)
                        return@setMethodCallHandler
                    }
                    val fallback = (args["defaultValue"] as? Int) ?: 0
                    result.success(readInt(storeType, key, fallback))
                }

                "readBool" -> {
                    if (key == null) {
                        result.error("invalid_args", "Missing key", null)
                        return@setMethodCallHandler
                    }
                    val fallback = (args["defaultValue"] as? Boolean) ?: false
                    result.success(readInt(storeType, key, if (fallback) 1 else 0) == 1)
                }

                "writeInt" -> {
                    if (key == null) {
                        result.error("invalid_args", "Missing key", null)
                        return@setMethodCallHandler
                    }
                    val value = (args["value"] as? Int) ?: 0
                    writeInt(storeType, key, value)
                    result.success(null)
                }

                "writeBool" -> {
                    if (key == null) {
                        result.error("invalid_args", "Missing key", null)
                        return@setMethodCallHandler
                    }
                    val value = (args["value"] as? Boolean) ?: false
                    writeInt(storeType, key, if (value) 1 else 0)
                    result.success(null)
                }

                "sendBroadcast" -> {
                    val action = args?.get("action") as? String
                    result.success(sendSafeBroadcast(action))
                }

                "openExternalApp" -> {
                    val packageName = args?.get("packageName") as? String
                    result.success(openExternalApp(packageName))
                }

                "launchMonetPicker" -> result.success(launchMonetPicker())
                "getWallpaperColors" -> result.success(getWallpaperColors())
                "getInstalledPackages" -> result.success(getInstalledPackages())
                "isPackageInstalled" -> {
                    val packageName = args?.get("packageName") as? String
                    result.success(isPackageInstalled(packageName))
                }
                "writeMountBridgeConfig" -> {
                    val config = args?.get("config")
                    result.success(writeMountBridgeConfig(config))
                }
                else -> result.notImplemented()
            }
        }
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
                return mapOf(
                    "primary" to (colors.primaryColor?.toArgb() ?: return null),
                    "secondary" to (colors.secondaryColor?.toArgb() ?: colors.primaryColor?.toArgb() ?: return null),
                    "tertiary" to (colors.tertiaryColor?.toArgb() ?: colors.secondaryColor?.toArgb() ?: colors.primaryColor?.toArgb() ?: return null),
                )
            }

            val system = asMap(WallpaperManager.FLAG_SYSTEM)
            val lock = asMap(WallpaperManager.FLAG_LOCK)
            if (system == null && lock == null) {
                mapOf("available" to false, "message" to "Wallpaper colors are not available on this ROM.")
            } else {
                mapOf(
                    "available" to true,
                    "system" to (system ?: emptyMap<String, Int>()),
                    "lock" to (lock ?: emptyMap<String, Int>()),
                )
            }
        } catch (_: Exception) {
            mapOf("available" to false, "message" to "Wallpaper colors are not available on this ROM.")
        }
    }

    private fun readInt(storeType: Int, key: String, fallback: Int): Int {
        val resolver = applicationContext.contentResolver
        return when (storeType) {
            2 -> Settings.Global.getInt(resolver, key, fallback)
            1 -> Settings.Secure.getInt(resolver, key, fallback)
            else -> Settings.System.getInt(resolver, key, fallback)
        }
    }

    private fun writeInt(storeType: Int, key: String, value: Int) {
        val resolver = applicationContext.contentResolver
        when (storeType) {
            2 -> Settings.Global.putInt(resolver, key, value)
            1 -> Settings.Secure.putInt(resolver, key, value)
            else -> Settings.System.putInt(resolver, key, value)
        }
    }
}
