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
  String applyStatusMessage = 'Applied inside DeadZon. ROM bridge config saved.';
  Timer? _persistTimer;

  static const List<String> controlCategories = <String>['All', 'Core System', 'Xiaomi / HyperOS', 'Media', 'Phone & Messages', 'Tools', 'Security', 'Launcher & UI', 'Connectivity', 'Other'];

  void updateThemeController(DeadzonThemeController controller) {
    _themeController = controller;
  }

  Future<void> initialize() async {
    loading = true;
    notifyListeners();

    config = await _service.loadConfig();
    final persistedTab = await _service.loadActiveTab();
    currentTab = persistedTab.clamp(0, 5).toInt();
    selectableApps = await _service.loadSelectableApps();
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

  void _hydrateGeneratedPalettes() {
    if (config.generatedPalettes.isEmpty) {
      config = config.copyWith(generatedPalettes: _engine.generate(config.selectedSeedColor));
    }
  }

  Future<void> _persist() async {
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
    config = config.copyWith(selectedPackageNames: packages, scopeSelectedApps: packages.isNotEmpty);
    notifyListeners();
    await _persist();
  }

  Future<void> setMonetEnabled(bool enabled) async {
    config = config.copyWith(monetEnabled: enabled);
    notifyListeners();
    await _persist();
  }

  int get selectedAppsCount => config.selectedPackageNames.length;

  int get installedTargetsCount => controlApps.where((app) => app.isInstalled).length;

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

  Future<void> selectAllControlApps(bool enabled) async {
    final visibleKeys = filteredControlApps.map((app) => app.key).toSet();
    controlApps = controlApps.map((app) => visibleKeys.contains(app.key) ? app.copyWith(enabled: enabled) : app).toList();
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

  List<MountMonetApp> get filteredControlApps => controlApps.where((app) {
    final matchesSearch = app.title.toLowerCase().contains(controlAppsSearch.toLowerCase()) || app.key.toLowerCase().contains(controlAppsSearch.toLowerCase());
    final matchesCategory = selectedControlCategory == 'All' || app.category == selectedControlCategory;
    return matchesSearch && matchesCategory;
  }).toList();

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
      liveApplyEnabled: config.liveApplyEnabled,
    );
    await _applyToGlobalIfLive();
    notifyListeners();
    await _persist();
  }

  Future<bool> launchMonetPicker() => _service.launchMonetPicker();

  Future<void> apply() async {
    final configToPersist = config.copyWith(
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
    await _themeController.applyMountConfig(configToPersist, persist: false);
    await _service.applyConfig(configToPersist, controlApps);
    applyStatusMessage = 'Applied inside DeadZon. ROM bridge config saved.';
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

    config = fallback.copyWith(selectedPackageNames: config.selectedPackageNames, controlAppToggles: config.controlAppToggles, monetEnabled: config.monetEnabled, liveApplyEnabled: config.liveApplyEnabled);
    await _applyToGlobalIfLive();
    notifyListeners();
    await _persist();
  }

  Future<void> reset() async {
    await _service.reset();
    config = MountDefaults.baseConfig();
    controlApps = MountDefaults.controlApps;
    await _themeController.resetToDefaults();
    notifyListeners();
    await _persist();
  }
}
