import 'package:deadzon/features/mount/data/mount_defaults.dart';
import 'package:deadzon/features/mount/data/mount_storage_service.dart';
import 'package:deadzon/features/mount/domain/mount_config.dart';
import 'package:deadzon/features/mount/domain/mount_monet_app.dart';
import 'package:deadzon/features/mount/domain/mount_palette.dart';
import 'package:deadzon/features/mount/services/mount_bridge_config_service.dart';
import 'package:deadzon/features/mount/services/monet_picker_launcher.dart';
import 'package:deadzon/features/mount/services/mount_native_bridge_service.dart';

class MountService {
  MountService({
    MountStorageService? storage,
    MonetPickerLauncher? monetPickerLauncher,
    MountNativeBridgeService? nativeBridgeService,
    MountBridgeConfigService? bridgeConfigService,
  })  : _storage = storage ?? MountStorageService(),
        _monetPickerLauncher = monetPickerLauncher ?? const MonetPickerLauncher(),
        _nativeBridgeService = nativeBridgeService ?? const MountNativeBridgeService(),
        _bridgeConfigService = bridgeConfigService ?? MountBridgeConfigService(storage: storage, nativeBridge: nativeBridgeService);

  final MountStorageService _storage;
  final MonetPickerLauncher _monetPickerLauncher;
  final MountNativeBridgeService _nativeBridgeService;
  final MountBridgeConfigService _bridgeConfigService;

  Future<MountConfig> loadConfig() => _storage.loadConfig();

  Future<void> saveConfig(MountConfig config) => _storage.saveConfig(config);

  Future<int> loadActiveTab() => _storage.loadActiveTab();

  Future<void> saveActiveTab(int index) => _storage.saveActiveTab(index);

  Future<void> reset() => _storage.clearConfig();

  Future<bool> launchMonetPicker() => _monetPickerLauncher.launchMonetPicker();

  Future<List<WallpaperColorSet>> getWallpaperColors() => _monetPickerLauncher.getWallpaperColors();

  Future<List<MountSelectableApp>> loadSelectableApps() async {
    final nativeApps = await _nativeBridgeService.getInstalledPackages();
    if (nativeApps != null && nativeApps.isNotEmpty) {
      return nativeApps;
    }
    return MountDefaults.mockSelectableApps;
  }

  Map<String, dynamic> exportBridgePayload({
    required MountConfig config,
    required List<MountMonetApp> controlApps,
    required bool appThemeApplied,
    required bool romConfigSaved,
  }) {
    return _bridgeConfigService.buildBridgeMap(
      config: config,
      controlApps: controlApps,
      appThemeApplied: appThemeApplied,
      romConfigSaved: romConfigSaved,
    );
  }

  Future<void> saveBridgeConfig(MountConfig config, List<MountMonetApp> controlApps, {required bool appThemeApplied, required bool romConfigSaved}) async {
    await _bridgeConfigService.saveBridgeConfig(
      config: config,
      controlApps: controlApps,
      appThemeApplied: appThemeApplied,
      romConfigSaved: romConfigSaved,
    );
  }
}
