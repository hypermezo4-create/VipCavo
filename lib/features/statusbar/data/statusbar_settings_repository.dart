import 'package:deadzon/features/statusbar/data/resize_statusbar_service.dart';
import 'package:deadzon/features/statusbar/statusbar_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatusbarSettingsRepository {
  StatusbarSettingsRepository._();

  static const String _localPrefix = 'statusbar_legacy_';

  static Future<Object?> read(StatusBarSettingItem setting) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _storageKey(setting.legacyKey);
    final rawKey = setting.legacyKey;
    final fallback = setting.defaultValue;

    if (fallback is bool) {
      return prefs.getBool(rawKey) ?? prefs.getBool(key) ?? fallback;
    }
    if (fallback is num) {
      return _readNumber(prefs, rawKey) ?? _readNumber(prefs, key) ?? fallback.toDouble();
    }
    if (fallback is String) {
      return prefs.getString(rawKey) ?? prefs.getString(key) ?? fallback;
    }
    return prefs.get(rawKey) ?? prefs.get(key) ?? fallback;
  }

  static Future<Map<String, Object?>> readAll(List<StatusBarSettingItem> settings) async {
    final prefs = await SharedPreferences.getInstance();
    final values = <String, Object?>{};
    for (final setting in settings) {
      final key = _storageKey(setting.legacyKey);
      final rawKey = setting.legacyKey;
      final fallback = setting.defaultValue;
      if (fallback is bool) {
        values[setting.legacyKey] = prefs.getBool(rawKey) ?? prefs.getBool(key) ?? fallback;
      } else if (fallback is num) {
        values[setting.legacyKey] = _readNumber(prefs, rawKey) ?? _readNumber(prefs, key) ?? fallback.toDouble();
      } else if (fallback is String) {
        values[setting.legacyKey] = prefs.getString(rawKey) ?? prefs.getString(key) ?? fallback;
      } else {
        values[setting.legacyKey] = prefs.get(rawKey) ?? prefs.get(key) ?? fallback;
      }
    }
    return values;
  }

  static Future<void> write(StatusBarSettingItem setting, Object? value) async {
    if (value == null) {
      return;
    }
    await writeRaw(setting.legacyKey, value);
    await _writeNativeBestEffort(setting.legacyKey, value);

    if (setting.intentAction != null) {
      try {
        await ResizeStatusbarService.sendBroadcastIntent(setting.intentAction!);
      } catch (_) {
        // Local persistence is still preserved when native bridge is unavailable.
      }
    }
  }

  static Future<void> writeRaw(String legacyKey, Object? value) async {
    if (value == null) {
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    final prefixedKey = _storageKey(legacyKey);

    if (value is bool) {
      await prefs.setBool(legacyKey, value);
      await prefs.setBool(prefixedKey, value);
    } else if (value is int) {
      await prefs.setInt(legacyKey, value);
      await prefs.setInt(prefixedKey, value);
    } else if (value is num) {
      await prefs.setDouble(legacyKey, value.toDouble());
      await prefs.setDouble(prefixedKey, value.toDouble());
    } else if (value is String) {
      await prefs.setString(legacyKey, value);
      await prefs.setString(prefixedKey, value);
    }
  }

  static Future<void> _writeNativeBestEffort(String key, Object value) async {
    try {
      if (value is bool) {
        await ResizeStatusbarService.writeBool(key: key, value: value);
      } else if (value is int) {
        await ResizeStatusbarService.writeInt(key: key, value: value);
      } else if (value is num) {
        await ResizeStatusbarService.writeInt(key: key, value: value.round());
      } else if (value is String) {
        await ResizeStatusbarService.writeString(key: key, value: value);
      }
    } catch (_) {
      // UI stays fully usable without system-write/native permission.
    }
  }

  static double? _readNumber(SharedPreferences prefs, String key) {
    final raw = prefs.get(key);
    if (raw is num) {
      return raw.toDouble();
    }
    return null;
  }

  static String _storageKey(String legacyKey) => '$_localPrefix$legacyKey';
}
