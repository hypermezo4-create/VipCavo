import 'package:flutter/services.dart';

/// Single safe bridge for Mezo / DeadZone system actions.
///
/// This class is intentionally defensive:
/// - every method catches native errors;
/// - writes return false instead of crashing;
/// - reads return the provided fallback;
/// - old Mezo keys remain controlled by callers, not renamed here.
///
/// storeType:
/// 0 = Settings.System
/// 1 = Settings.Secure
/// 2 = Settings.Global
class AndroidIntentBridge {
  AndroidIntentBridge._();

  static const MethodChannel _channel = MethodChannel('deadzon/mezo_settings');

  static Future<bool> sendDeadzonBroadcast(String action) async {
    if (action.isEmpty) return false;
    try {
      final result = await _channel.invokeMethod<bool>(
        'sendBroadcast',
        <String, Object>{'action': action},
      );
      return result ?? true;
    } on PlatformException {
      return false;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> sendStatusbarRefresh() {
    return sendDeadzonBroadcast('my.intent.action.REFRESH_STATUSBAR');
  }

  static Future<bool> sendSystemUiRefresh() {
    return sendDeadzonBroadcast('my.intent.action.REFRESH_SYSTEMUI');
  }

  static Future<bool> openExternalApp(String packageName) async {
    if (packageName.isEmpty) return false;
    try {
      final result = await _channel.invokeMethod<bool>(
        'openExternalApp',
        <String, Object>{'packageName': packageName},
      );
      return result ?? false;
    } on PlatformException {
      return false;
    } catch (_) {
      return false;
    }
  }

  static Future<int> readInt(
    String key, {
    int defaultValue = 0,
    int storeType = 0,
  }) async {
    if (key.isEmpty) return defaultValue;
    try {
      final result = await _channel.invokeMethod<int>(
        'readInt',
        <String, Object>{
          'key': key,
          'defaultValue': defaultValue,
          'storeType': storeType,
        },
      );
      return result ?? defaultValue;
    } on PlatformException {
      return defaultValue;
    } catch (_) {
      return defaultValue;
    }
  }

  static Future<bool> writeInt(
    String key,
    int value, {
    int storeType = 0,
    bool refreshStatusbar = false,
  }) async {
    if (key.isEmpty) return false;
    try {
      final result = await _channel.invokeMethod<bool>(
        'writeInt',
        <String, Object>{
          'key': key,
          'value': value,
          'storeType': storeType,
        },
      );
      final ok = result ?? false;
      if (ok && refreshStatusbar) {
        await sendStatusbarRefresh();
      }
      return ok;
    } on PlatformException {
      return false;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> readBool(
    String key, {
    bool defaultValue = false,
    int storeType = 0,
  }) async {
    if (key.isEmpty) return defaultValue;
    try {
      final result = await _channel.invokeMethod<bool>(
        'readBool',
        <String, Object>{
          'key': key,
          'defaultValue': defaultValue,
          'storeType': storeType,
        },
      );
      return result ?? defaultValue;
    } on PlatformException {
      return defaultValue;
    } catch (_) {
      return defaultValue;
    }
  }

  static Future<bool> writeBool(
    String key,
    bool value, {
    int storeType = 0,
    bool refreshStatusbar = false,
  }) async {
    if (key.isEmpty) return false;
    try {
      final result = await _channel.invokeMethod<bool>(
        'writeBool',
        <String, Object>{
          'key': key,
          'value': value,
          'storeType': storeType,
        },
      );
      final ok = result ?? false;
      if (ok && refreshStatusbar) {
        await sendStatusbarRefresh();
      }
      return ok;
    } on PlatformException {
      return false;
    } catch (_) {
      return false;
    }
  }

  static Future<String> readString(
    String key, {
    String defaultValue = '',
    int storeType = 0,
  }) async {
    if (key.isEmpty) return defaultValue;
    try {
      final result = await _channel.invokeMethod<String>(
        'readString',
        <String, Object>{
          'key': key,
          'defaultValue': defaultValue,
          'storeType': storeType,
        },
      );
      return result ?? defaultValue;
    } on PlatformException {
      return defaultValue;
    } catch (_) {
      return defaultValue;
    }
  }

  static Future<bool> writeString(
    String key,
    String value, {
    int storeType = 0,
    bool refreshStatusbar = false,
  }) async {
    if (key.isEmpty) return false;
    try {
      final result = await _channel.invokeMethod<bool>(
        'writeString',
        <String, Object>{
          'key': key,
          'value': value,
          'storeType': storeType,
        },
      );
      final ok = result ?? false;
      if (ok && refreshStatusbar) {
        await sendStatusbarRefresh();
      }
      return ok;
    } on PlatformException {
      return false;
    } catch (_) {
      return false;
    }
  }

  /// Convenience helper for Mezo preference-like values.
  ///
  /// bool -> writeBool
  /// int -> writeInt
  /// String -> writeString
  static Future<bool> writeMezoValue(
    String key,
    Object value, {
    int storeType = 0,
    bool refreshStatusbar = false,
  }) {
    if (value is bool) {
      return writeBool(
        key,
        value,
        storeType: storeType,
        refreshStatusbar: refreshStatusbar,
      );
    }
    if (value is int) {
      return writeInt(
        key,
        value,
        storeType: storeType,
        refreshStatusbar: refreshStatusbar,
      );
    }
    return writeString(
      key,
      value.toString(),
      storeType: storeType,
      refreshStatusbar: refreshStatusbar,
    );
  }
}
