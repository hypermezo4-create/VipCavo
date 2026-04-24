import 'dart:math';

import 'package:deadzon/core/theme/app_theme.dart';
import 'package:deadzon/features/mount/data/mount_defaults.dart';
import 'package:deadzon/features/mount/domain/mount_config.dart';
import 'package:deadzon/features/mount/domain/mount_monet_app.dart';
import 'package:deadzon/features/mount/domain/mount_palette.dart';
import 'package:deadzon/features/mount/domain/mount_profile.dart';
import 'package:deadzon/features/mount/services/mount_monet_engine.dart';
import 'package:deadzon/features/mount/services/mount_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

final mountStudioControllerProvider = ChangeNotifierProvider<MountStudioController>((ref) {
  final controller = MountStudioController(
    service: MountService(),
    onGlobalAccentChanged: (color) => ref.read(globalAccentProvider.notifier).setAccent(color),
  );
  controller.initialize();
  return controller;
});

class MountStudioController extends ChangeNotifier {
  MountStudioController({required MountService service, required this.onGlobalAccentChanged}) : _service = service;

  final MountService _service;
  final void Function(Color) onGlobalAccentChanged;
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

  static const List<String> controlCategories = <String>['All', 'Core System', 'Xiaomi / HyperOS', 'Media', 'Phone & Messages', 'Tools', 'Security', 'Launcher & UI', 'Connectivity', 'Other'];

  Future<void> initialize() async {
    loading = true;
    notifyListeners();

    config = await _service.loadConfig();
    currentTab = await _service.loadActiveTab();
    selectableApps = await _service.loadSelectableApps();
    wallpaperSets = await _service.getWallpaperColors();
    _hydrateGeneratedPalettes();
    controlApps = MountDefaults.controlApps.map((app) {
      final enabled = config.controlAppToggles[app.key] ?? app.defaultEnabled;
      return app.copyWith(enabled: enabled);
    }).toList();

    onGlobalAccentChanged(config.selectedColor);
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
    onGlobalAccentChanged(color);
    notifyListeners();
    await _persist();
  }

  Future<void> selectPalette(MountPalette palette) async {
    await setSeedColor(palette.primary, name: palette.name, paletteId: palette.id);
    config = config.copyWith(
      cardBackgroundTint: palette.backgroundTint,
      iconAccentColor: palette.accent,
      textAccentColor: palette.secondary.withValues(alpha: 0.95),
      componentColors: <String, int>{
        ...config.componentColors,
        'cardBackgroundTint': palette.backgroundTint.toARGB32(),
        'iconAccentColor': palette.accent.toARGB32(),
        'textAccentColor': palette.secondary.toARGB32(),
      },
    );
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
    notifyListeners();
    await _persist();
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
    config = profile.config.copyWith(activeProfileId: profile.id, selectedPackageNames: config.selectedPackageNames, controlAppToggles: config.controlAppToggles, monetEnabled: config.monetEnabled);
    onGlobalAccentChanged(config.selectedColor);
    notifyListeners();
    await _persist();
  }

  Future<bool> launchMonetPicker() => _service.launchMonetPicker();

  Future<void> apply() => _service.applyConfig(config);

  Future<void> resetCurrentProfileToDefault() async {
    final profileId = config.activeProfileId;
    MountProfile? profile;
    for (final item in profiles) {
      if (item.id == profileId) {
        profile = item;
        break;
      }
    }
    final fallback =
        (profile?.config ?? MountDefaults.baseConfig()).copyWith(
          activeProfileId: profile?.id ?? 'custom',
        );

    config = fallback.copyWith(selectedPackageNames: config.selectedPackageNames, controlAppToggles: config.controlAppToggles, monetEnabled: config.monetEnabled);
    onGlobalAccentChanged(config.selectedColor);
    notifyListeners();
    await _persist();
  }

  Future<void> reset() async {
    await _service.reset();
    config = MountDefaults.baseConfig();
    controlApps = MountDefaults.controlApps;
    onGlobalAccentChanged(config.selectedColor);
    notifyListeners();
    await _persist();
  }
}
