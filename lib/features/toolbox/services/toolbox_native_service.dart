import 'package:flutter/services.dart';

class ToolboxNativeService {
  static const MethodChannel _channel = MethodChannel('deadzon/mezo_settings');

  static Future<Map<String, dynamic>> getDeviceSummary() async {
    try {
      final data = await _channel.invokeMethod<Map<Object?, Object?>>('getDeviceSummary');
      if (data == null) return <String, dynamic>{};
      return data.map((key, value) => MapEntry('$key', value));
    } catch (_) {
      return <String, dynamic>{};
    }
  }
}
