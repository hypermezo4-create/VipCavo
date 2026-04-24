import 'package:deadzon/features/mount/data/mount_defaults.dart';
import 'package:deadzon/features/mount/data/mount_storage_service.dart';
import 'package:deadzon/features/mount/domain/mount_config.dart';
import 'package:deadzon/features/mount/domain/mount_monet_app.dart';
import 'package:deadzon/features/mount/domain/mount_palette.dart';
import 'package:deadzon/features/mount/services/monet_picker_launcher.dart';

class MountService {
  MountService({
    MountStorageService? storage,
    MonetPickerLauncher? monetPickerLauncher,
  })  : _storage = storage ?? MountStorageService(),
        _monetPickerLauncher = monetPickerLauncher ?? const MonetPickerLauncher();

  final MountStorageService _storage;
  final MonetPickerLauncher _monetPickerLauncher;

  Future<MountConfig> loadConfig() => _storage.loadConfig();

  Future<void> saveConfig(MountConfig config) => _storage.saveConfig(config);

  Future<int> loadActiveTab() => _storage.loadActiveTab();

  Future<void> saveActiveTab(int index) => _storage.saveActiveTab(index);

  Future<void> reset() => _storage.clearConfig();

  Future<bool> launchMonetPicker() => _monetPickerLauncher.launchMonetPicker();

  Future<List<WallpaperColorSet>> getWallpaperColors() => _monetPickerLauncher.getWallpaperColors();

  Future<List<MountSelectableApp>> loadSelectableApps() async => MountDefaults.mockSelectableApps;

  Future<void> applyConfig(MountConfig config) async {
    await _storage.saveConfig(config);
  }
}
