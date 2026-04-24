import 'package:deadzon/features/mount/data/mount_defaults.dart';
import 'package:deadzon/features/mount/domain/mount_config.dart';
import 'package:deadzon/features/mount/domain/mount_monet_app.dart';
import 'package:deadzon/features/mount/domain/mount_profile.dart';
import 'package:deadzon/features/mount/services/mount_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mountStudioControllerProvider = ChangeNotifierProvider<MountStudioController>((ref) {
  final controller = MountStudioController(service: MountService());
  controller.initialize();
  return controller;
});

class MountStudioController extends ChangeNotifier {
  MountStudioController({required MountService service}) : _service = service;

  final MountService _service;
  final List<MountProfile> profiles = MountDefaults.profiles();

  MountConfig config = MountDefaults.baseConfig();
  List<MountMonetApp> controlApps = MountDefaults.controlApps;
  List<MountSelectableApp> selectableApps = MountDefaults.mockSelectableApps;

  int currentTab = 0;
  bool loading = true;
  String controlAppsSearch = '';
  String selectedControlCategory = 'All';

  static const List<String> controlCategories = <String>[
    'All',
    'Core System',
    'Xiaomi / HyperOS',
    'Media',
    'Phone & Messages',
    'Tools',
    'Security',
    'Launcher & UI',
    'Connectivity',
    'Other',
  ];

  Future<void> initialize() async {
    loading = true;
    notifyListeners();

    final loaded = await _service.loadConfig();
    final savedTab = await _service.loadActiveTab();
    final apps = await _service.loadSelectableApps();
    config = loaded;
    currentTab = savedTab;
    selectableApps = apps;
    controlApps = MountDefaults.controlApps.map((app) {
      final enabled = loaded.controlAppToggles[app.key] ?? app.defaultEnabled;
      return app.copyWith(enabled: enabled);
    }).toList();

    loading = false;
    notifyListeners();
  }

  Future<void> _persist() async {
    await _service.saveConfig(
      config.copyWith(
        controlAppToggles: Map<String, bool>.fromEntries(controlApps.map((e) => MapEntry(e.key, e.enabled))),
      ),
    );
  }

  Future<void> setTab(int index) async {
    currentTab = index;
    notifyListeners();
    await _service.saveActiveTab(index);
  }

  Future<void> setMonetColor(Color color, String name) async {
    config = config.copyWith(
      selectedColor: color,
      selectedColorName: name,
      seekbarColor: color,
      switchOnColor: color,
      checkboxOnColor: color,
      iconAccentColor: color.withValues(alpha: 0.96),
      textAccentColor: color.withValues(alpha: 0.94),
      activeProfileId: 'custom',
    );
    notifyListeners();
    await _persist();
  }

  Future<void> setSlider({
    double? glassOpacity,
    double? blurStrength,
    double? accentIntensity,
    double? glowAmount,
    double? cornerRadius,
    double? shadowDepth,
    double? borderVisibility,
  }) async {
    config = config.copyWith(
      glassOpacity: glassOpacity,
      blurStrength: blurStrength,
      accentIntensity: accentIntensity,
      glowAmount: glowAmount,
      cornerRadius: cornerRadius,
      shadowDepth: shadowDepth,
      borderVisibility: borderVisibility,
      activeProfileId: 'custom',
    );
    notifyListeners();
    await _persist();
  }

  Future<void> setComponentColor({
    Color? seekbarColor,
    Color? switchOnColor,
    Color? switchOffColor,
    Color? checkboxOnColor,
    Color? checkboxOffColor,
    Color? cardBackgroundTint,
    Color? iconAccentColor,
    Color? textAccentColor,
  }) async {
    config = config.copyWith(
      seekbarColor: seekbarColor,
      switchOnColor: switchOnColor,
      switchOffColor: switchOffColor,
      checkboxOnColor: checkboxOnColor,
      checkboxOffColor: checkboxOffColor,
      cardBackgroundTint: cardBackgroundTint,
      iconAccentColor: iconAccentColor,
      textAccentColor: textAccentColor,
      activeProfileId: 'custom',
    );
    notifyListeners();
    await _persist();
  }

  Future<void> setScope({
    bool? statusbar,
    bool? controlCenter,
    bool? notifications,
    bool? lockscreen,
    bool? settings,
    bool? launcher,
    bool? selectedApps,
  }) async {
    config = config.copyWith(
      scopeStatusbar: statusbar,
      scopeControlCenter: controlCenter,
      scopeNotifications: notifications,
      scopeLockscreen: lockscreen,
      scopeSettings: settings,
      scopeLauncher: launcher,
      scopeSelectedApps: selectedApps,
      activeProfileId: 'custom',
    );
    notifyListeners();
    await _persist();
  }

  Future<void> setSelectedPackages(List<String> packages) async {
    config = config.copyWith(selectedPackageNames: packages, scopeSelectedApps: packages.isNotEmpty);
    notifyListeners();
    await _persist();
  }

  Future<void> setMonetEnabled(bool enabled) async {
    config = config.copyWith(monetEnabled: enabled);
    notifyListeners();
    await _persist();
  }

  Future<void> toggleControlApp(String key, bool enabled) async {
    controlApps = controlApps.map((app) => app.key == key ? app.copyWith(enabled: enabled) : app).toList();
    notifyListeners();
    await _persist();
  }

  Future<void> selectAllControlApps(bool enabled) async {
    final visibleKeys = filteredControlApps.map((app) => app.key).toSet();
    controlApps = controlApps
        .map((app) => visibleKeys.contains(app.key) ? app.copyWith(enabled: enabled) : app)
        .toList();
    notifyListeners();
    await _persist();
  }

  void setControlAppsSearch(String value) {
    controlAppsSearch = value;
    notifyListeners();
  }

  void setControlCategory(String value) {
    selectedControlCategory = value;
    notifyListeners();
  }

  List<MountMonetApp> get filteredControlApps {
    return controlApps.where((app) {
      final matchesSearch = app.title.toLowerCase().contains(controlAppsSearch.toLowerCase()) || app.key.toLowerCase().contains(controlAppsSearch.toLowerCase());
      final matchesCategory = selectedControlCategory == 'All' || app.category == selectedControlCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  Future<void> applyProfile(String id) async {
    MountProfile? profile;
    for (final item in profiles) {
      if (item.id == id) {
        profile = item;
        break;
      }
    }
    if (profile == null) return;
    config = profile.config.copyWith(
      activeProfileId: profile.id,
      selectedPackageNames: config.selectedPackageNames,
      controlAppToggles: config.controlAppToggles,
      monetEnabled: config.monetEnabled,
    );
    notifyListeners();
    await _persist();
  }

  Future<bool> launchMonetPicker() => _service.launchMonetPicker();

  Future<void> apply() => _service.applyConfig(config);

  Future<void> resetCurrentProfileToDefault() async {
    final profileId = config.activeProfileId;
    MountConfig fallback = MountDefaults.baseConfig();
    if (profileId != 'custom') {
      for (final profile in profiles) {
        if (profile.id == profileId) {
          fallback = profile.config.copyWith(activeProfileId: profile.id);
          break;
        }
      }
    } else {
      fallback = fallback.copyWith(activeProfileId: 'custom');
    }

    config = fallback.copyWith(
      selectedPackageNames: config.selectedPackageNames,
      controlAppToggles: config.controlAppToggles,
      monetEnabled: config.monetEnabled,
    );
    notifyListeners();
    await _persist();
  }

  Future<void> reset() async {
    await _service.reset();
    config = MountDefaults.baseConfig();
    controlApps = MountDefaults.controlApps;
    notifyListeners();
    await _persist();
  }
}
