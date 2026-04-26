import 'package:deadzon/core/services/android_intent_bridge.dart';
import 'package:deadzon/features/control_center/data/control_center_storage_service.dart';
import 'package:deadzon/features/control_center/domain/control_center_config.dart';

class ControlCenterService {
  ControlCenterService({ControlCenterStorageService? storage}) : _storage = storage ?? ControlCenterStorageService();

  static const String refreshSystemUiAction = 'my.intent.action.REFRESH_SYSTEMUI';
  static const String refreshStatusbarAction = 'my.intent.action.REFRESH_STATUSBAR';

  // Mezo/Xiaomi Settings store type used by the existing native bridge:
  // 0 = Settings.System, 1 = Settings.Secure, 2 = Settings.Global.
  // Keep as one constant so it can be changed in one place if the ROM side expects another store.
  static const int mezoSettingsStoreType = 0;

  final ControlCenterStorageService _storage;

  Future<ControlCenterConfig> loadConfig() => _storage.loadConfig();

  Future<void> saveConfig(ControlCenterConfig config) {
    return _storage.saveConfig(config.copyWith(lastUpdatedAt: DateTime.now()));
  }

  Future<bool> saveAndApplyConfig(ControlCenterConfig config) async {
    final saved = config.copyWith(lastUpdatedAt: DateTime.now());
    await _storage.saveConfig(saved);

    final writes = await Future.wait<bool>(<Future<bool>>[
      AndroidIntentBridge.writeBool(
        ControlCenterConfig.squareMezoTilesKey,
        saved.squareMezoTiles,
        storeType: mezoSettingsStoreType,
      ),
      AndroidIntentBridge.writeInt(
        ControlCenterConfig.controlCenterStyleKey,
        saved.controlCenterStyle,
        storeType: mezoSettingsStoreType,
      ),
      AndroidIntentBridge.writeString(
        ControlCenterConfig.extraTwoMezoTilesKey,
        saved.extraTwoAsBridgeString,
        storeType: mezoSettingsStoreType,
      ),
      AndroidIntentBridge.writeInt(
        ControlCenterConfig.ccBlurRatioKey,
        saved.ccBlurRatio,
        storeType: mezoSettingsStoreType,
      ),
    ]);

    final refresh = await requestStatusbarRefresh();
    return writes.any((value) => value) || refresh;
  }

  Future<bool> requestSystemUiRefresh() => AndroidIntentBridge.sendDeadzonBroadcast(refreshSystemUiAction);

  Future<bool> requestStatusbarRefresh() => AndroidIntentBridge.sendDeadzonBroadcast(refreshStatusbarAction);
}
