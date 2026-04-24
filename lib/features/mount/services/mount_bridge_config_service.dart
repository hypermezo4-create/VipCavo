import 'package:deadzon/features/mount/data/mount_storage_service.dart';
import 'package:deadzon/features/mount/domain/mount_config.dart';
import 'package:deadzon/features/mount/domain/mount_monet_app.dart';
import 'package:deadzon/features/mount/services/mount_native_bridge_service.dart';

class MountBridgeConfigService {
  MountBridgeConfigService({
    MountStorageService? storage,
    MountNativeBridgeService? nativeBridge,
  })  : _storage = storage ?? MountStorageService(),
        _nativeBridge = nativeBridge ?? const MountNativeBridgeService();

  final MountStorageService _storage;
  final MountNativeBridgeService _nativeBridge;

  Map<String, dynamic> buildBridgeMap({
    required MountConfig config,
    required List<MountMonetApp> controlApps,
  }) {
    return <String, dynamic>{
      'schemaVersion': 1,
      'mountPluginEnabled': config.monetEnabled,
      'romTargets': <String, bool>{
        'statusbar': config.scopeStatusbar,
        'controlCenter': config.scopeControlCenter,
        'notifications': config.scopeNotifications,
        'lockscreen': config.scopeLockscreen,
        'settings': config.scopeSettings,
        'launcher': config.scopeLauncher,
        'selectedApps': config.scopeSelectedApps,
      },
      'selectedPackageNames': config.selectedPackageNames,
      'controlApps': <Map<String, dynamic>>[
        for (final app in controlApps)
          <String, dynamic>{
            'key': app.key,
            'title': app.title,
            'enabled': app.enabled,
            'installed': app.isInstalled,
            'category': app.category,
            'packageNameCandidates': app.packageNameCandidates,
          },
      ],
      'theme': <String, dynamic>{
        'selectedPaletteId': config.selectedPaletteId,
        'selectedSeedColor': config.selectedSeedColor.toARGB32(),
        'selectedColorHex': config.selectedColorHex,
        'glassOpacity': config.glassOpacity,
        'blurStrength': config.blurStrength,
        'accentIntensity': config.accentIntensity,
      },
    };
  }

  Future<bool> saveBridgeConfig({
    required MountConfig config,
    required List<MountMonetApp> controlApps,
  }) async {
    final bridgeMap = buildBridgeMap(config: config, controlApps: controlApps);
    await _storage.saveBridgeConfig(bridgeMap);
    await _nativeBridge.writeMountBridgeConfig(bridgeMap);
    return true;
  }
}
