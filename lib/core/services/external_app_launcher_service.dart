import 'package:flutter/services.dart';

class ExternalAppLauncherService {
  ExternalAppLauncherService._();

  static const MethodChannel _channel = MethodChannel('deadzon/mezo_settings');

  static Future<bool> launchPackage(String packageName) async {
    final result = await _channel.invokeMethod<bool>(
      'launchExternalApp',
      <String, Object>{'packageName': packageName},
    );

    return result ?? false;
  }
}
