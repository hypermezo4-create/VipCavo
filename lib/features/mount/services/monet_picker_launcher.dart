import 'package:flutter/services.dart';

class MonetPickerLauncher {
  const MonetPickerLauncher();

  static const MethodChannel _channel = MethodChannel('deadzon/mezo_settings');

  Future<bool> launchMonetPicker() async {
    try {
      final launched = await _channel.invokeMethod<bool>(
        'launchMonetPicker',
        const <String, String>{
          'package': 'com.android.wallpaper',
          'class': 'com.android.wallpaper.picker.CustomizationPickerActivity',
        },
      );
      return launched == true;
    } catch (_) {
      return false;
    }
  }
}
