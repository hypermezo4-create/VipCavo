import 'package:flutter/services.dart';

class AndroidIntentBridge {
  AndroidIntentBridge._();

  static const MethodChannel _channel = MethodChannel('deadzon/mezo_settings');

  static Future<bool> sendDeadzonBroadcast(String action) async {
    if (action.isEmpty) return false;
    try {
      final result = await _channel.invokeMethod<bool>('sendBroadcast', <String, Object>{'action': action});
      return result ?? true;
    } catch (_) {
      return false;
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
