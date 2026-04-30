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

  static Future<bool> canDrawOverlays() async =>
      (await _channel.invokeMethod<bool>('canDrawOverlays')) ?? false;

  static Future<bool> openOverlayPermissionPanel() async =>
      (await _channel.invokeMethod<bool>('openOverlayPermissionPanel')) ?? false;

  static Future<bool> startFpsOverlay() async =>
      (await _channel.invokeMethod<bool>('startFpsOverlay')) ?? false;

  static Future<bool> stopFpsOverlay() async =>
      (await _channel.invokeMethod<bool>('stopFpsOverlay')) ?? false;

  static Future<bool> isFpsOverlayRunning() async =>
      (await _channel.invokeMethod<bool>('isFpsOverlayRunning')) ?? false;

  static Future<bool> updateFpsOverlaySettings(Map<String, dynamic> settings) async =>
      (await _channel.invokeMethod<bool>('updateFpsOverlaySettings', settings)) ?? false;
}
