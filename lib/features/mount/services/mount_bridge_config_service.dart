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
    required bool appThemeApplied,
    required bool romConfigSaved,
  }) {
    return <String, dynamic>{
      'schemaVersion': 2,
      'mountPluginEnabled': config.monetEnabled,
      'appThemeApplied': appThemeApplied,
      'romConfigSaved': romConfigSaved,
      'realRomBridgeInstalled': false,
      'activeProfile': config.activeProfileId,
      'targets': <String, bool>{
        'statusbar': config.scopeStatusbar,
        'controlCenter': config.scopeControlCenter,
        'notifications': config.scopeNotifications,
        'lockscreen': config.scopeLockscreen,
        'settings': config.scopeSettings,
        'launcher': config.scopeLauncher,
        'selectedApps': config.scopeSelectedApps,
      },
      'selectedPackages': config.selectedPackageNames,
      'appEffects': <String, dynamic>{
        'glassOpacity': config.glassOpacity,
        'blurStrength': config.blurStrength,
        'accentIntensity': config.accentIntensity,
        'glowAmount': config.glowAmount,
        'cornerRadius': config.cornerRadius,
        'shadowDepth': config.shadowDepth,
        'borderVisibility': config.borderVisibility,
      },
      'colors': <String, dynamic>{
        'selectedPaletteId': config.selectedPaletteId,
        'selectedSeedColor': config.selectedSeedColor.toARGB32(),
        'selectedColorHex': config.selectedColorHex,
        'cardBackgroundTint': config.cardBackgroundTint.toARGB32(),
        'iconAccentColor': config.iconAccentColor.toARGB32(),
        'textAccentColor': config.textAccentColor.toARGB32(),
      },
      'components': <String, dynamic>{
        'seekbarColor': config.seekbarColor.toARGB32(),
        'switchOnColor': config.switchOnColor.toARGB32(),
        'switchOffColor': config.switchOffColor.toARGB32(),
        'checkboxOnColor': config.checkboxOnColor.toARGB32(),
        'checkboxOffColor': config.checkboxOffColor.toARGB32(),
      },
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
    };
  }

  Future<bool> saveBridgeConfig({
    required MountConfig config,
    required List<MountMonetApp> controlApps,
    required bool appThemeApplied,
    required bool romConfigSaved,
  }) async {
    final bridgeMap = buildBridgeMap(
      config: config,
      controlApps: controlApps,
      appThemeApplied: appThemeApplied,
      romConfigSaved: romConfigSaved,
    );
    await _storage.saveBridgeConfig(bridgeMap);
    await _nativeBridge.writeMountBridgeConfig(bridgeMap);
    return true;
  }
}
