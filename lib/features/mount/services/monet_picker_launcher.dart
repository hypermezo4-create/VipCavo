import 'package:flutter/services.dart';

class MonetPickerLauncher {
  const MonetPickerLauncher();

  static const MethodChannel _channel = MethodChannel('deadzon/mezo_settings');

  Future<bool> launchMonetPicker() async {
    try {
      final launched = await _channel.invokeMethod<bool>('launchMonetPicker');
      return launched == true;
    } catch (_) {
      return false;
    }
  }
}
