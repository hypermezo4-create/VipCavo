import 'package:deadzon/features/mount/data/mount_defaults.dart';
import 'package:deadzon/features/mount/domain/mount_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MountStorageService {
  MountStorageService({SharedPreferences? prefs}) : _prefs = prefs;

  static const String _configKey = 'mount_config_v1';
  static const String _activeTabKey = 'mount_active_tab_v1';
  final SharedPreferences? _prefs;

  Future<SharedPreferences> _resolvePrefs() async {
    return _prefs ?? SharedPreferences.getInstance();
  }

  Future<MountConfig> loadConfig() async {
    final prefs = await _resolvePrefs();
    final raw = prefs.getString(_configKey);
    if (raw == null || raw.isEmpty) {
      return MountDefaults.baseConfig();
    }
    return MountConfig.decode(raw, MountDefaults.baseConfig());
  }

  Future<void> saveConfig(MountConfig config) async {
    final prefs = await _resolvePrefs();
    await prefs.setString(_configKey, config.encode());
  }

  Future<void> clearConfig() async {
    final prefs = await _resolvePrefs();
    await prefs.remove(_configKey);
    await prefs.remove(_activeTabKey);
  }

  Future<int> loadActiveTab() async {
    final prefs = await _resolvePrefs();
    return prefs.getInt(_activeTabKey) ?? 0;
  }

  Future<void> saveActiveTab(int index) async {
    final prefs = await _resolvePrefs();
    await prefs.setInt(_activeTabKey, index);
  }
}
