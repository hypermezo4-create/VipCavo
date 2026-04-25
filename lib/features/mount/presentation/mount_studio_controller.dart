import 'dart:async';
import 'dart:math';

import 'package:deadzon/core/theme/deadzon_theme_controller.dart';
import 'package:deadzon/features/mount/data/mount_defaults.dart';
import 'package:deadzon/features/mount/domain/mount_config.dart';
import 'package:deadzon/features/mount/domain/mount_monet_app.dart';
import 'package:deadzon/features/mount/domain/mount_palette.dart';
import 'package:deadzon/features/mount/domain/mount_profile.dart';
import 'package:deadzon/features/mount/services/mount_monet_engine.dart';
import 'package:deadzon/features/mount/services/mount_service.dart';
import 'package:flutter/material.dart';

MountStudioController createMountStudioController(DeadzonThemeController themeController) {
  final controller = MountStudioController(service: MountService(), themeController: themeController);
  controller.initialize();
  return controller;
}

class MountStudioController extends ChangeNotifier {
  MountStudioController({required MountService service, required DeadzonThemeController themeController})
    : _service = service,
      _themeController = themeController;

  final MountService _service;
  DeadzonThemeController _themeController;
  final MountMonetEngine _engine = MountMonetEngine();
  final List<MountProfile> profiles = MountDefaults.profiles();
  final List<MountPalette> paletteLibrary = MountDefaults.paletteLibrary;
  final Random _random = Random();

  MountConfig config = MountDefaults.baseConfig();
  List<WallpaperColorSet> wallpaperSets = const <WallpaperColorSet>[];
  List<MountMonetApp> controlApps = MountDefaults.controlApps;
  List<MountSelectableApp> selectableApps = MountDefaults.mockSelectableApps;

  int currentTab = 0;
  bool loading = true;
  String controlAppsSearch = '';
  String selectedControlCategory = 'All';
  String applyStatusMessage = 'Awaiting apply. DeadZone app theme and bridge payload are local only.';
  bool appThemeApplied = false;
  bool romConfigSaved = false;
  Timer? _persistTimer;

  static const List<String> controlCategories = <String>[
    'All',
    'Core System',
    'Xiaomi / HyperOS',
    'User Selected',
    'Missing',
  ];

  void updateThemeController(DeadzonThemeController controller) {
    _themeController = controller;
  }

  Future<void> initialize() async {
    loading = true;
    notifyListeners();

    config = await _service.loadConfig();
    final persistedTab = await _service.loadActiveTab();
    currentTab = persistedTab.clamp(0, 5).toInt();
    final loadedApps = await _service.loadSelectableApps();
    selectableApps = _hydrateSelectableApps(loadedApps, config.selectedPackageNames);
    wallpaperSets = await _service.getWallpaperColors();
    _hydrateGeneratedPalettes();

    final installedPackages = selectableApps.where((app) => app.installed).map((app) => app.packageName).toSet();
    controlApps = MountDefaults.controlApps.map((app) {
      final enabled = config.controlAppToggles[app.key] ?? app.defaultEnabled;
      final detectedInstalled = app.packageNameCandidates.any(installedPackages.contains);
      return app.copyWith(enabled: enabled, isInstalled: detectedInstalled || app.isInstalled);
    }).toList();

    await _themeController.applyMountConfig(config, persist: false);
    loading = false;
    notifyListeners();
  }

  List<MountSelectableApp> _hydrateSelectableApps(List<MountSelectableApp> apps, List<String> selectedPackages) {
    final selectedSet = selectedPackages.toSet();
    return apps
        .map(
          (app) => app.copyWith(
            category: _normalizeCategory(app.category, installed: app.installed),
            selected: app.installed && selectedSet.contains(app.packageName),
          ),
        )
        .toList()
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  }

  String _normalizeCategory(String raw, {required bool installed}) {
    if (!installed) return 'Missing';
    if (raw == 'Core System' || raw == 'Xiaomi / HyperOS' || raw == 'Launcher' || raw == 'User Apps') {
      return raw;
    }
    return 'User Apps';
  }

  void _hydrateGeneratedPalettes() {
    if (config.generatedPalettes.isEmpty) {
      config = config.copyWith(generatedPalettes: _engine.generate(config.selectedSeedColor));
    }
  }

  Future<void> _persist() async {
    final selectedPackages = selectableApps.where((app) => app.selected && app.installed).map((app) => app.packageName).toList();
    config = config.copyWith(selectedPackageNames: selectedPackages, scopeSelectedApps: selectedPackages.isNotEmpty);
    await _service.saveConfig(
      config.copyWith(
        controlAppToggles: Map<String, bool>.fromEntries(controlApps.map((e) => MapEntry(e.key, e.enabled))),
        scopeToggles: <String, bool>{
          'statusbar': config.scopeStatusbar,
          'controlCenter': config.scopeControlCenter,
          'notifications': config.scopeNotifications,
          'lockscreen': config.scopeLockscreen,
          'settings': config.scopeSettings,
          'launcher': config.scopeLauncher,
          'selectedApps': config.scopeSelectedApps,
        },
      ),
    );
  }

  void _persistDebounced() {
    _persistTimer?.cancel();
    _persistTimer = Timer(const Duration(milliseconds: 220), _persist);
  }

  Future<void> _applyToGlobalIfLive() async {
    if (config.liveApplyEnabled) {
      await _themeController.applyMountConfig(config, persist: false);
    }
  }

  Future<void> setTab(int index) async {
    currentTab = index;
    notifyListeners();
    await _service.saveActiveTab(index);
  }

  Future<void> setSeedColor(Color color, {String? name, String? paletteId}) async {
    final hex = '#${color.toARGB32().toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
    final recent = <int>[color.toARGB32(), ...config.recentColors.where((item) => item != color.toARGB32())].take(12).toList();
    final generated = _engine.generate(color);
    config = config.copyWith(
      selectedColor: color,
      selectedColorName: name ?? 'Custom',
      selectedSeedColor: color,
      selectedColorHex: hex,
      selectedPaletteId: paletteId ?? 'custom',
      recentColors: recent,
      generatedPalettes: generated,
      seekbarColor: color,
      switchOnColor: color,
      checkboxOnColor: color,
      iconAccentColor: Color(generated['primary']!['80']!),
      textAccentColor: Color(generated['neutral']!['95']!),
      activeProfileId: 'custom',
      componentColors: <String, int>{
        ...config.componentColors,
        'seekbarColor': color.toARGB32(),
        'switchOnColor': color.toARGB32(),
        'checkboxOnColor': color.toARGB32(),
      },
    );
    await _applyToGlobalIfLive();
    notifyListeners();
    _persistDebounced();
  }

  Future<void> selectPalette(MountPalette palette) async {
    await setSeedColor(palette.primary, name: palette.name, paletteId: palette.id);
    config = config.copyWith(
      cardBackgroundTint: palette.backgroundTint,
      iconAccentColor: palette.accent,
      textAccentColor: palette.secondary.withValues(alpha: 0.95),
      themeStyle: palette.id,
      componentColors: <String, int>{
        ...config.componentColors,
        'cardBackgroundTint': palette.backgroundTint.toARGB32(),
        'iconAccentColor': palette.accent.toARGB32(),
        'textAccentColor': palette.secondary.toARGB32(),
      },
    );
    await _applyToGlobalIfLive();
    notifyListeners();
    _persistDebounced();
  }

  Future<void> setLiveApplyEnabled(bool enabled) async {
    config = config.copyWith(liveApplyEnabled: enabled);
    if (enabled) {
      await _themeController.applyMountConfig(config, persist: false);
    }
    notifyListeners();
    await _persist();
  }

  Future<void> randomizeColor() async {
    await setSeedColor(Color.fromARGB(255, _random.nextInt(255), _random.nextInt(255), _random.nextInt(255)));
  }

  Future<void> resetSeedColor() async {
    await selectPalette(paletteLibrary.first);
  }

  Future<void> toggleFavorite(Color color) async {
    final value = color.toARGB32();
    final favorites = List<int>.from(config.favoriteColors);
    if (favorites.contains(value)) {
      favorites.remove(value);
    } else {
      favorites.insert(0, value);
    }
    config = config.copyWith(favoriteColors: favorites.take(20).toList());
    notifyListeners();
    await _persist();
  }

  Future<void> setSlider({double? glassOpacity, double? blurStrength, double? accentIntensity, double? glowAmount, double? cornerRadius, double? shadowDepth, double? borderVisibility}) async {
    config = config.copyWith(glassOpacity: glassOpacity, blurStrength: blurStrength, accentIntensity: accentIntensity, glowAmount: glowAmount, cornerRadius: cornerRadius, shadowDepth: shadowDepth, borderVisibility: borderVisibility, activeProfileId: 'custom');
    await _applyToGlobalIfLive();
    notifyListeners();
    _persistDebounced();
  }

  Future<void> setComponentColor(String key, Color color) async {
    config = config.copyWith(
      seekbarColor: key == 'seekbarColor' ? color : null,
      switchOnColor: key == 'switchOnColor' ? color : null,
      switchOffColor: key == 'switchOffColor' ? color : null,
      checkboxOnColor: key == 'checkboxOnColor' ? color : null,
      checkboxOffColor: key == 'checkboxOffColor' ? color : null,
      cardBackgroundTint: key == 'cardBackgroundTint' ? color : null,
      iconAccentColor: key == 'iconAccentColor' ? color : null,
      textAccentColor: key == 'textAccentColor' ? color : null,
      componentColors: <String, int>{...config.componentColors, key: color.toARGB32()},
      activeProfileId: 'custom',
    );
    await _applyToGlobalIfLive();
    notifyListeners();
    await _persist();
  }

  Future<void> pullWallpaperColors() async {
    wallpaperSets = await _service.getWallpaperColors();
    final serializable = <String, Map<String, int>>{};
    for (final set in wallpaperSets.where((entry) => entry.available)) {
      serializable[set.source] = <String, int>{
        if (set.primary != null) 'primary': set.primary!.toARGB32(),
        if (set.secondary != null) 'secondary': set.secondary!.toARGB32(),
        if (set.tertiary != null) 'tertiary': set.tertiary!.toARGB32(),
      };
    }
    config = config.copyWith(wallpaperColors: serializable);
    notifyListeners();
    await _persist();
  }

  Future<void> setScope({bool? statusbar, bool? controlCenter, bool? notifications, bool? lockscreen, bool? settings, bool? launcher, bool? selectedApps}) async {
    config = config.copyWith(scopeStatusbar: statusbar, scopeControlCenter: controlCenter, scopeNotifications: notifications, scopeLockscreen: lockscreen, scopeSettings: settings, scopeLauncher: launcher, scopeSelectedApps: selectedApps, activeProfileId: 'custom');
    notifyListeners();
    await _persist();
  }

  Future<void> setSelectedPackages(List<String> packages) async {
    final selectedSet = packages.toSet();
    selectableApps = selectableApps.map((app) => app.copyWith(selected: app.installed && selectedSet.contains(app.packageName))).toList();
    config = config.copyWith(selectedPackageNames: packages, scopeSelectedApps: packages.isNotEmpty);
    notifyListeners();
    await _persist();
  }

  Future<void> setMonetEnabled(bool enabled) async {
    config = config.copyWith(monetEnabled: enabled);
    notifyListeners();
    await _persist();
  }

  int get selectedAppsCount => selectableApps.where((app) => app.selected && app.installed).length;

  int get installedTargetsCount => selectableApps.where((app) => app.installed).length;

  int get enabledRomTargetsCount {
    final targets = <bool>[
      config.scopeStatusbar,
      config.scopeControlCenter,
      config.scopeNotifications,
      config.scopeLockscreen,
      config.scopeSettings,
      config.scopeLauncher,
      config.scopeSelectedApps,
    ];
    return targets.where((value) => value).length;
  }

  Future<void> toggleControlApp(String key, bool enabled) async {
    controlApps = controlApps.map((app) => app.key == key ? app.copyWith(enabled: enabled) : app).toList();
    notifyListeners();
    await _persist();
  }

  Future<void> toggleSelectableApp(String packageName, bool selected) async {
    selectableApps = selectableApps
        .map((app) => app.packageName == packageName && app.installed ? app.copyWith(selected: selected) : app)
        .toList();
    await _syncSelectedPackages();
  }

  Future<void> selectAllControlApps(bool enabled) async {
    final visiblePackages = filteredSelectableApps.where((app) => app.installed).map((app) => app.packageName).toSet();
    selectableApps = selectableApps
        .map((app) => visiblePackages.contains(app.packageName) ? app.copyWith(selected: enabled) : app)
        .toList();
    await _syncSelectedPackages();
  }

  Future<void> _syncSelectedPackages() async {
    final selectedPackages = selectableApps.where((app) => app.selected && app.installed).map((app) => app.packageName).toList();
    config = config.copyWith(selectedPackageNames: selectedPackages, scopeSelectedApps: selectedPackages.isNotEmpty);
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

  List<MountSelectableApp> get filteredSelectableApps {
    return selectableApps.where((app) {
      final query = controlAppsSearch.toLowerCase();
      final matchesSearch = app.name.toLowerCase().contains(query) || app.packageName.toLowerCase().contains(query);
      final matchesCategory = switch (selectedControlCategory) {
        'All' => app.installed,
        'Core System' => app.installed && app.category == 'Core System',
        'Xiaomi / HyperOS' => app.installed && app.category == 'Xiaomi / HyperOS',
        'User Selected' => app.installed && app.selected,
        'Missing' => !app.installed,
        _ => app.installed,
      };
      return matchesSearch && matchesCategory;
    }).toList();
  }

  List<MountMonetApp> get filteredControlApps => controlApps;

  Map<String, dynamic> exportBridgePayload() {
    return _service.exportBridgePayload(
      config: config,
      controlApps: controlApps,
      appThemeApplied: appThemeApplied,
      romConfigSaved: romConfigSaved,
    );
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

    final selectedSet = profile.config.selectedPackageNames.toSet();
    selectableApps = selectableApps
        .map((app) => app.copyWith(selected: app.installed && selectedSet.contains(app.packageName)))
        .toList();

    config = profile.config.copyWith(
      activeProfileId: profile.id,
      selectedPackageNames: selectableApps.where((app) => app.selected).map((app) => app.packageName).toList(),
      controlAppToggles: config.controlAppToggles,
      liveApplyEnabled: config.liveApplyEnabled,
    );
    await _applyToGlobalIfLive();
    notifyListeners();
    await _persist();
  }

  Future<bool> launchMonetPicker() => _service.launchMonetPicker();

  Future<void> apply() async {
    final configToPersist = config.copyWith(
      selectedPackageNames: selectableApps.where((app) => app.selected && app.installed).map((app) => app.packageName).toList(),
      controlAppToggles: Map<String, bool>.fromEntries(controlApps.map((e) => MapEntry(e.key, e.enabled))),
      scopeToggles: <String, bool>{
        'statusbar': config.scopeStatusbar,
        'controlCenter': config.scopeControlCenter,
        'notifications': config.scopeNotifications,
        'lockscreen': config.scopeLockscreen,
        'settings': config.scopeSettings,
        'launcher': config.scopeLauncher,
        'selectedApps': config.scopeSelectedApps,
      },
    );
    config = configToPersist;
    await _service.saveConfig(configToPersist);
    await _themeController.applyMountConfig(configToPersist, persist: false);
    appThemeApplied = true;
    romConfigSaved = true;
    await _service.saveBridgeConfig(
      configToPersist,
      controlApps,
      appThemeApplied: appThemeApplied,
      romConfigSaved: romConfigSaved,
    );
    applyStatusMessage = 'Mount V2 saved. App theme applied. Bridge payload ready.';
    notifyListeners();
  }

  Future<void> resetCurrentProfileToDefault() async {
    final profileId = config.activeProfileId;
    MountProfile? profile;
    for (final item in profiles) {
      if (item.id == profileId) {
        profile = item;
        break;
      }
    }
    final fallback = (profile?.config ?? MountDefaults.baseConfig()).copyWith(activeProfileId: profile?.id ?? 'custom');

    final selectedSet = fallback.selectedPackageNames.toSet();
    selectableApps = selectableApps
        .map((app) => app.copyWith(selected: app.installed && selectedSet.contains(app.packageName)))
        .toList();

    config = fallback.copyWith(controlAppToggles: config.controlAppToggles, liveApplyEnabled: config.liveApplyEnabled);
    await _applyToGlobalIfLive();
    notifyListeners();
    await _persist();
  }

  Future<void> reset() async {
    await _service.reset();
    config = MountDefaults.baseConfig();
    controlApps = MountDefaults.controlApps;
    selectableApps = _hydrateSelectableApps(MountDefaults.mockSelectableApps, const <String>[]);
    appThemeApplied = false;
    romConfigSaved = false;
    await _themeController.resetToDefaults();
    notifyListeners();
    await _persist();
  }
}
