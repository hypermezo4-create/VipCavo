
import 'package:flutter/services.dart';

class AndroidIntentBridge {
  AndroidIntentBridge._();

  static const MethodChannel _channel = MethodChannel('deadzon/mezo_settings');

  static Future<bool> sendDeadzonBroadcast(String action) async {
    if (action.isEmpty) return false;
    try {
      final result = await _channel.invokeMethod<bool>('sendBroadcast', <String, Object>{'action': action});
      return result ?? true;
    } on PlatformException {
      return false;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> writeBool(String key, bool value, {int storeType = 0}) async {
    if (key.isEmpty) return false;
    try {
      await _channel.invokeMethod<void>('writeBool', <String, Object>{
        'key': key,
        'value': value,
        'storeType': storeType,
      });
      return true;
    } on PlatformException {
      return false;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> writeInt(String key, int value, {int storeType = 0}) async {
    if (key.isEmpty) return false;
    try {
      await _channel.invokeMethod<void>('writeInt', <String, Object>{
        'key': key,
        'value': value,
        'storeType': storeType,
      });
      return true;
    } on PlatformException {
      return false;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> writeString(String key, String value, {int storeType = 0}) async {
    if (key.isEmpty) return false;
    try {
      await _channel.invokeMethod<void>('writeString', <String, Object>{
        'key': key,
        'value': value,
        'storeType': storeType,
      });
      return true;
    } on PlatformException {
      return false;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> openExternalApp(String packageName) async {
    if (packageName.isEmpty) return false;
    try {
      final result = await _channel.invokeMethod<bool>('openExternalApp', <String, Object>{'packageName': packageName});
      return result ?? false;
    } on PlatformException {
      return false;
    } catch (_) {
      return false;
    }
  }
}
