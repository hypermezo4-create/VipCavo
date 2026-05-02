import 'package:deadzon/core/services/android_intent_bridge.dart';
import 'package:deadzon/features/control_center/data/control_center_storage_service.dart';
import 'package:deadzon/features/control_center/domain/control_center_config.dart';

class ControlCenterService {
  ControlCenterService({ControlCenterStorageService? storage}) : _storage = storage ?? ControlCenterStorageService();

  static const int mezoSettingsStoreType = 0;
  final ControlCenterStorageService _storage;

  Future<ControlCenterConfig> loadConfig() => _storage.loadConfig();

  Future<void> saveConfig(ControlCenterConfig config) => _storage.saveConfig(config.copyWith(lastUpdatedAt: DateTime.now()));

  Future<bool> saveAndApplyConfig(ControlCenterConfig config) async {
    final saved = config.copyWith(lastUpdatedAt: DateTime.now());
    await _storage.saveConfig(saved);
    final writes = await Future.wait<bool>(
      saved.values.entries.map(
        (entry) => AndroidIntentBridge.writeBool(entry.key, entry.value, storeType: mezoSettingsStoreType),
      ),
    );
    return writes.any((value) => value);
  }
}
