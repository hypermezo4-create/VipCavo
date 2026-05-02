import 'package:deadzon/features/control_center/domain/control_center_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControlCenterStorageService {
  ControlCenterStorageService({SharedPreferences? prefs}) : _prefs = prefs;

  static const String _configKey = 'control_center_plugin_config_v1';
  final SharedPreferences? _prefs;

  Future<SharedPreferences> _resolvePrefs() async => _prefs ?? SharedPreferences.getInstance();

  Future<ControlCenterConfig> loadConfig() async {
    final prefs = await _resolvePrefs();
    final raw = prefs.getString(_configKey);
    if (raw == null || raw.isEmpty) {
      final defaults = ControlCenterConfig.defaults();
      await saveConfig(defaults);
      return defaults;
    }
    return ControlCenterConfig.decode(raw);
  }

  Future<void> saveConfig(ControlCenterConfig config) async {
    final prefs = await _resolvePrefs();
    await prefs.setString(_configKey, config.encode());
  }
}
