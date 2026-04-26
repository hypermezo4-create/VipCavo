import 'package:deadzon/core/services/android_intent_bridge.dart';
import 'package:deadzon/features/control_center/domain/control_center_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControlCenterStorageService {
  ControlCenterStorageService({SharedPreferences? prefs}) : _prefs = prefs;

  static const String _configKey = 'control_center_config_v1';
  final SharedPreferences? _prefs;

  Future<SharedPreferences> _resolvePrefs() async {
    return _prefs ?? SharedPreferences.getInstance();
  }

  Future<ControlCenterConfig> loadConfig() async {
    final prefs = await _resolvePrefs();
    final defaults = ControlCenterConfig.defaults();

    final localRaw = prefs.getString(_configKey);
    final local = localRaw == null || localRaw.isEmpty ? defaults : ControlCenterConfig.decode(localRaw);

    // Read the old Mezo keys from Settings.System when the native bridge is available.
    // If the bridge is unavailable, these calls safely return the local/default values.
    final squareTiles = await AndroidIntentBridge.readBool(
      ControlCenterConfig.squareMezoTilesKey,
      prefs.getBool(ControlCenterConfig.squareMezoTilesKey) ?? local.squareMezoTiles,
    );
    final style = await AndroidIntentBridge.readInt(
      ControlCenterConfig.controlCenterStyleKey,
      prefs.getInt(ControlCenterConfig.controlCenterStyleKey) ?? local.controlCenterStyle,
    );
    final extraTiles = await AndroidIntentBridge.readString(
      ControlCenterConfig.extraTwoMezoTilesKey,
      prefs.getString(ControlCenterConfig.extraTwoMezoTilesKey) ?? local.extraTwoAsBridgeString,
    );
    final blur = await AndroidIntentBridge.readInt(
      ControlCenterConfig.ccBlurRatioKey,
      prefs.getInt(ControlCenterConfig.ccBlurRatioKey) ?? local.ccBlurRatio,
    );

    final config = ControlCenterConfig(
      squareMezoTiles: squareTiles,
      controlCenterStyle: style,
      extraTwoMezoTiles: ControlCenterConfig.decodeExtraTiles(extraTiles),
      ccBlurRatio: (blur.clamp(0, 100)).toInt(),
      lastUpdatedAt: local.lastUpdatedAt,
    );

    await _saveLocalMirrors(prefs, config);
    return config;
  }

  Future<void> saveLocalConfig(ControlCenterConfig config) async {
    final prefs = await _resolvePrefs();
    await _saveLocalMirrors(prefs, config);
  }

  Future<void> saveConfig(ControlCenterConfig config) async {
    final prefs = await _resolvePrefs();
    await _saveLocalMirrors(prefs, config);

    // Write the real old Mezo keys so the ROM/bridge side can consume them.
    // These calls are safe: if Android denies Settings writes, the app still keeps
    // the local state and does not restart/crash.
    await AndroidIntentBridge.writeBool(ControlCenterConfig.squareMezoTilesKey, config.squareMezoTiles);
    await AndroidIntentBridge.writeInt(ControlCenterConfig.controlCenterStyleKey, config.controlCenterStyle);
    await AndroidIntentBridge.writeString(ControlCenterConfig.extraTwoMezoTilesKey, config.extraTwoAsBridgeString);
    await AndroidIntentBridge.writeInt(ControlCenterConfig.ccBlurRatioKey, (config.ccBlurRatio.clamp(0, 100)).toInt());
  }

  Future<void> _saveLocalMirrors(SharedPreferences prefs, ControlCenterConfig config) async {
    await prefs.setString(_configKey, config.encode());
    await prefs.setBool(ControlCenterConfig.squareMezoTilesKey, config.squareMezoTiles);
    await prefs.setInt(ControlCenterConfig.controlCenterStyleKey, config.controlCenterStyle);
    await prefs.setString(ControlCenterConfig.extraTwoMezoTilesKey, config.extraTwoAsBridgeString);
    await prefs.setInt(ControlCenterConfig.ccBlurRatioKey, (config.ccBlurRatio.clamp(0, 100)).toInt());
  }
}
