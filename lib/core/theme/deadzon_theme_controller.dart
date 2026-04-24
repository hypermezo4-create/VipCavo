import 'package:deadzon/features/mount/data/mount_defaults.dart';
import 'package:deadzon/features/mount/domain/mount_config.dart';
import 'package:deadzon/features/mount/services/mount_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

DeadzonThemeController createDeadzonThemeController() {
  final controller = DeadzonThemeController(service: MountService());
  controller.initialize();
  return controller;
}

class DeadzonThemeController extends ChangeNotifier {
  DeadzonThemeController({required MountService service}) : _service = service;

  final MountService _service;

  Color accentColor = MountDefaults.baseConfig().selectedColor;
  Color secondaryAccentColor = MountDefaults.baseConfig().selectedSeedColor;
  Color backgroundTint = const Color(0xFF102029);
  Color cardTint = MountDefaults.baseConfig().cardBackgroundTint;
  Color borderColor = Colors.white.withValues(alpha: 0.22);
  Color iconAccentColor = MountDefaults.baseConfig().iconAccentColor;
  Color textAccentColor = MountDefaults.baseConfig().textAccentColor;
  Color switchOnColor = MountDefaults.baseConfig().switchOnColor;
  Color sliderColor = MountDefaults.baseConfig().seekbarColor;
  Color checkboxColor = MountDefaults.baseConfig().checkboxOnColor;
  String activeMountProfileId = 'default';
  bool liveApplyEnabled = true;
  ThemeMode themeMode = ThemeMode.dark;

  MountConfig _appliedConfig = MountDefaults.baseConfig();

  MountConfig get appliedConfig => _appliedConfig;

  Future<void> initialize() async {
    final loaded = await _service.loadConfig();
    _setFromConfig(loaded, notify: false);
    notifyListeners();
  }

  Future<void> applyMountConfig(MountConfig config, {bool persist = true}) async {
    _setFromConfig(config);
    if (persist) {
      await _service.saveConfig(config);
    }
  }

  Future<void> setLiveApply(bool enabled) async {
    liveApplyEnabled = enabled;
    _appliedConfig = _appliedConfig.copyWith(liveApplyEnabled: enabled);
    notifyListeners();
    await _service.saveConfig(_appliedConfig);
  }

  Future<void> resetToDefaults() async {
    final defaults = MountDefaults.baseConfig();
    _setFromConfig(defaults);
    await _service.saveConfig(defaults);
  }

  void setThemeMode(ThemeMode mode) {
    themeMode = mode;
    notifyListeners();
  }

  void _setFromConfig(MountConfig config, {bool notify = true}) {
    _appliedConfig = config;
    accentColor = config.selectedColor;
    secondaryAccentColor = config.selectedSeedColor;
    backgroundTint = Color.lerp(const Color(0xFF0B1418), config.cardBackgroundTint, 0.25) ?? const Color(0xFF0B1418);
    cardTint = config.cardBackgroundTint;
    borderColor = Colors.white.withValues(alpha: config.borderVisibility.clamp(0.15, 0.82));
    iconAccentColor = config.iconAccentColor;
    textAccentColor = config.textAccentColor;
    switchOnColor = config.switchOnColor;
    sliderColor = config.seekbarColor;
    checkboxColor = config.checkboxOnColor;
    activeMountProfileId = config.activeProfileId;
    liveApplyEnabled = config.liveApplyEnabled;
    if (notify) {
      notifyListeners();
    }
  }
}

class DeadzonThemeTokens {
  const DeadzonThemeTokens._();

  static DeadzonThemeController of(BuildContext context) => context.read<DeadzonThemeController>();

  static Color accent(BuildContext context) => of(context).accentColor;

  static Color cardTint(BuildContext context) => of(context).cardTint;

  static Color border(BuildContext context) => of(context).borderColor;

  static Color textAccent(BuildContext context) => of(context).textAccentColor;

  static Color iconAccent(BuildContext context) => of(context).iconAccentColor;

  static Color navBackground(BuildContext context) =>
      Color.lerp(const Color(0xFF0D1B2B), of(context).backgroundTint, 0.45)?.withValues(alpha: 0.88) ?? const Color(0xDD0D1B2B);
}
