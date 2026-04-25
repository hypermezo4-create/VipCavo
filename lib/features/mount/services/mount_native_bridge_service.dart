import 'package:deadzon/features/mount/domain/mount_monet_app.dart';
import 'package:flutter/services.dart';

class MountNativeBridgeService {
  const MountNativeBridgeService();

  static const MethodChannel _channel = MethodChannel('deadzon/mezo_settings');

  Future<List<MountSelectableApp>?> getInstalledPackages() async {
    try {
      final payload = await _channel.invokeMethod<List<Object?>>('getInstalledPackages');
      if (payload == null) {
        return null;
      }

      final apps = <MountSelectableApp>[];
      for (final item in payload) {
        if (item is! Map<Object?, Object?>) {
          continue;
        }
        final name = '${item['name'] ?? ''}'.trim();
        final packageName = '${item['packageName'] ?? ''}'.trim();
        if (name.isEmpty || packageName.isEmpty) {
          continue;
        }
        final installedValue = item['installed'];
        final installed = installedValue is bool ? installedValue : true;
        apps.add(
          MountSelectableApp(
            name: name,
            packageName: packageName,
            category: _inferCategory(packageName),
            installed: installed,
          ),
        );
      }
      return apps;
    } on PlatformException {
      return null;
    } on MissingPluginException {
      return null;
    }
  }

  Future<Map<String, bool>?> getKnownPackageInstallStates(Set<String> packageNames) async {
    try {
      if (packageNames.isEmpty) {
        return const <String, bool>{};
      }
      final payload = await _channel.invokeMethod<Map<Object?, Object?>>(
        'getKnownPackageInstallStates',
        <String, dynamic>{'packageNames': packageNames.toList()},
      );
      if (payload == null) {
        return null;
      }
      final result = <String, bool>{};
      payload.forEach((rawKey, rawValue) {
        final key = '$rawKey'.trim();
        if (key.isEmpty) return;
        result[key] = rawValue == true;
      });
      return result;
    } on PlatformException {
      return null;
    } on MissingPluginException {
      return null;
    }
  }

  Future<String?> getCurrentPackageName() async {
    try {
      final value = await _channel.invokeMethod<String>('getCurrentPackageName');
      final cleaned = value?.trim();
      return (cleaned == null || cleaned.isEmpty) ? null : cleaned;
    } on PlatformException {
      return null;
    } on MissingPluginException {
      return null;
    }
  }

  Future<bool> writeMountBridgeConfig(Map<String, dynamic> config) async {
    try {
      final saved = await _channel.invokeMethod<bool>(
        'writeMountBridgeConfig',
        <String, dynamic>{'config': config},
      );
      return saved ?? false;
    } on PlatformException {
      return false;
    } on MissingPluginException {
      return false;
    }
  }

  Future<bool> isPackageInstalled(String packageName) async {
    try {
      final installed = await _channel.invokeMethod<bool>(
        'isPackageInstalled',
        <String, dynamic>{'packageName': packageName},
      );
      return installed == true;
    } on PlatformException {
      return false;
    } on MissingPluginException {
      return false;
    }
  }

  String _inferCategory(String packageName) {
    if (packageName.startsWith('com.android.systemui') ||
        packageName == 'com.android.settings' ||
        packageName.startsWith('com.android.permission')) {
      return 'Core System';
    }
    if (packageName.startsWith('com.miui.') || packageName.startsWith('com.xiaomi.') || packageName.startsWith('miui.')) {
      return 'Xiaomi / HyperOS';
    }
    if (packageName.contains('launcher') || packageName == 'com.miui.home') {
      return 'Launcher';
    }
    return 'User Apps';
  }
}
