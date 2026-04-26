import 'package:deadzon/features/statusbar/data/resize_statusbar_service.dart';
import 'package:deadzon/features/statusbar/statusbar_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatusbarSettingsRepository {
  StatusbarSettingsRepository._();

  static const String _localPrefix = 'statusbar_legacy_';
  static const String _refreshIntent = 'my.intent.action.REFRESH_STATUSBAR';

  static Future<Object?> read(StatusBarSettingItem setting) async {
    final prefs = await SharedPreferences.getInstance();
    return _readOne(prefs, setting);
  }

  static Future<Map<String, Object?>> readAll(List<StatusBarSettingItem> settings) async {
    final prefs = await SharedPreferences.getInstance();
    final values = <String, Object?>{};
    for (final setting in settings) {
      values[setting.legacyKey] = await _readOne(prefs, setting);
    }
    return values;
  }

  static Future<Object?> _readOne(SharedPreferences prefs, StatusBarSettingItem setting) async {
    final key = _storageKey(setting.legacyKey);
    final rawKey = setting.legacyKey;
    final fallback = setting.defaultValue;

    if (fallback is bool) {
      final localFallback = prefs.getBool(rawKey) ?? prefs.getBool(key) ?? fallback;
      return _readNativeBool(rawKey, localFallback);
    }
    if (fallback is num) {
      final localFallback = (_readNumber(prefs, rawKey) ?? _readNumber(prefs, key) ?? fallback.toDouble()).round();
      final native = await _readNativeInt(rawKey, localFallback);
      return native.toDouble();
    }
    if (fallback is String) {
      final localFallback = prefs.getString(rawKey) ?? prefs.getString(key) ?? fallback;
      final native = await _readNativeString(rawKey, localFallback);
      return native;
    }
    return prefs.get(rawKey) ?? prefs.get(key) ?? fallback;
  }

  static Future<void> write(StatusBarSettingItem setting, Object? value) async {
    if (value == null) return;
    await writeRaw(setting.legacyKey, value);
    await _writeNativeBestEffort(setting.legacyKey, value);

    try {
      if (setting.intentAction != null) {
        await ResizeStatusbarService.sendBroadcastIntent(setting.intentAction!);
      }
      await ResizeStatusbarService.sendBroadcastIntent(_refreshIntent);
    } catch (_) {
      // Local persistence is still preserved when the native bridge is unavailable.
    }
  }


  static Future<void> writeLoose(String legacyKey, Object? value, {String? intentAction}) async {
    if (value == null) return;
    await writeRaw(legacyKey, value);
    await _writeNativeBestEffort(legacyKey, value);
    try {
      if (intentAction != null) {
        await ResizeStatusbarService.sendBroadcastIntent(intentAction);
      }
      await ResizeStatusbarService.sendBroadcastIntent(_refreshIntent);
    } catch (_) {
      // Keep local state when native refresh is unavailable.
    }
  }

  static Future<void> writeRaw(String legacyKey, Object? value) async {
    if (value == null) return;
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

  static Future<bool> _readNativeBool(String key, bool fallback) async {
    try {
      return await ResizeStatusbarService.readBool(key: key, fallback: fallback);
    } catch (_) {
      return fallback;
    }
  }

  static Future<int> _readNativeInt(String key, int fallback) async {
    try {
      return await ResizeStatusbarService.readInt(key: key, fallback: fallback);
    } catch (_) {
      return fallback;
    }
  }

  static Future<String> _readNativeString(String key, String fallback) async {
    try {
      return await ResizeStatusbarService.readString(key: key, fallback: fallback);
    } catch (_) {
      return fallback;
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
    if (raw is num) return raw.toDouble();
    return null;
  }

  static String _storageKey(String legacyKey) => '$_localPrefix$legacyKey';
}
