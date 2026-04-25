import 'package:deadzon/features/statusbar/data/resize_statusbar_service.dart';
import 'package:deadzon/features/statusbar/statusbar_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatusbarSettingsRepository {
  StatusbarSettingsRepository._();

  static const String _localPrefix = 'statusbar_legacy_';

  static Future<Object?> read(StatusBarSettingItem setting) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _storageKey(setting.legacyKey);
    final fallback = setting.defaultValue;

    if (fallback is bool) {
      return prefs.getBool(key) ?? fallback;
    }
    if (fallback is num) {
      return (prefs.getDouble(key) ?? fallback.toDouble());
    }
    if (fallback is String) {
      return prefs.getString(key) ?? fallback;
    }
    return prefs.get(key) ?? fallback;
  }

  static Future<Map<String, Object?>> readAll(List<StatusBarSettingItem> settings) async {
    final prefs = await SharedPreferences.getInstance();
    final values = <String, Object?>{};
    for (final setting in settings) {
      final key = _storageKey(setting.legacyKey);
      final fallback = setting.defaultValue;
      if (fallback is bool) {
        values[setting.legacyKey] = prefs.getBool(key) ?? fallback;
      } else if (fallback is num) {
        values[setting.legacyKey] = prefs.getDouble(key) ?? fallback.toDouble();
      } else if (fallback is String) {
        values[setting.legacyKey] = prefs.getString(key) ?? fallback;
      } else {
        values[setting.legacyKey] = prefs.get(key) ?? fallback;
      }
    }
    return values;
  }

  static Future<void> write(StatusBarSettingItem setting, Object? value) async {
    if (value == null) {
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    final key = _storageKey(setting.legacyKey);

    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is num) {
      await prefs.setDouble(key, value.toDouble());
    } else if (value is String) {
      await prefs.setString(key, value);
    }

    if (setting.intentAction != null) {
      try {
        await ResizeStatusbarService.sendBroadcastIntent(setting.intentAction!);
      } catch (_) {
        // Local persistence is still preserved when native bridge is unavailable.
      }
    }
  }

  static String _storageKey(String legacyKey) => '$_localPrefix$legacyKey';
}
