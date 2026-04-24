import 'package:deadzon/core/services/android_intent_bridge.dart';
import 'package:deadzon/features/control_center/data/control_center_storage_service.dart';
import 'package:deadzon/features/control_center/domain/control_center_config.dart';

class ControlCenterService {
  ControlCenterService({ControlCenterStorageService? storage}) : _storage = storage ?? ControlCenterStorageService();

  static const String refreshSystemUiAction = 'my.intent.action.REFRESH_SYSTEMUI';
  static const String refreshStatusbarAction = 'my.intent.action.REFRESH_STATUSBAR';

  final ControlCenterStorageService _storage;

  Future<ControlCenterConfig> loadConfig() => _storage.loadConfig();

  Future<void> saveConfig(ControlCenterConfig config) {
    return _storage.saveConfig(config.copyWith(lastUpdatedAt: DateTime.now()));
  }

  Future<bool> requestSystemUiRefresh() => AndroidIntentBridge.sendDeadzonBroadcast(refreshSystemUiAction);

  Future<bool> requestStatusbarRefresh() => AndroidIntentBridge.sendDeadzonBroadcast(refreshStatusbarAction);
}
