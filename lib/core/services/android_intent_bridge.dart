import 'package:flutter/services.dart';

class AndroidIntentBridge {
  AndroidIntentBridge._();

  static const MethodChannel _channel = MethodChannel('deadzon/mezo_settings');

  /// Store types are mirrored from MainActivity.kt:
  /// 0 = Settings.System, 1 = Settings.Secure, 2 = Settings.Global.
  static const int systemStore = 0;
  static const int secureStore = 1;
  static const int globalStore = 2;

  static Future<bool> sendDeadzonBroadcast(String action) async {
    if (action.isEmpty) return false;
    try {
      final result = await _channel.invokeMethod<bool>('sendBroadcast', <String, Object>{'action': action});
      return result ?? true;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> writeBool(String key, bool value, {int storeType = systemStore}) async {
    if (key.isEmpty) return false;
    try {
      await _channel.invokeMethod<void>('writeBool', <String, Object>{
        'key': key,
        'value': value,
        'storeType': storeType,
      });
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> writeInt(String key, int value, {int storeType = systemStore}) async {
    if (key.isEmpty) return false;
    try {
      await _channel.invokeMethod<void>('writeInt', <String, Object>{
        'key': key,
        'value': value,
        'storeType': storeType,
      });
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> writeString(String key, String value, {int storeType = systemStore}) async {
    if (key.isEmpty) return false;
    try {
      await _channel.invokeMethod<void>('writeString', <String, Object>{
        'key': key,
        'value': value,
        'storeType': storeType,
      });
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> readBool(String key, bool defaultValue, {int storeType = systemStore}) async {
    if (key.isEmpty) return defaultValue;
    try {
      final result = await _channel.invokeMethod<bool>('readBool', <String, Object>{
        'key': key,
        'defaultValue': defaultValue,
        'storeType': storeType,
      });
      return result ?? defaultValue;
    } catch (_) {
      return defaultValue;
    }
  }

  static Future<int> readInt(String key, int defaultValue, {int storeType = systemStore}) async {
    if (key.isEmpty) return defaultValue;
    try {
      final result = await _channel.invokeMethod<int>('readInt', <String, Object>{
        'key': key,
        'defaultValue': defaultValue,
        'storeType': storeType,
      });
      return result ?? defaultValue;
    } catch (_) {
      return defaultValue;
    }
  }

  static Future<String> readString(String key, String defaultValue, {int storeType = systemStore}) async {
    if (key.isEmpty) return defaultValue;
    try {
      final result = await _channel.invokeMethod<String>('readString', <String, Object>{
        'key': key,
        'defaultValue': defaultValue,
        'storeType': storeType,
      });
      return result ?? defaultValue;
    } catch (_) {
      return defaultValue;
    }
  }

  static Future<bool> openExternalApp(String packageName) async {
    if (packageName.isEmpty) return false;
    try {
      final result = await _channel.invokeMethod<bool>('openExternalApp', <String, Object>{'packageName': packageName});
      return result ?? false;
    } catch (_) {
      return false;
    }
  }
}
