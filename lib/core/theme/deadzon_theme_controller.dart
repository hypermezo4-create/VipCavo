import 'package:deadzon/features/mount/data/mount_defaults.dart';
import 'package:deadzon/features/mount/domain/mount_config.dart';
import 'package:deadzon/features/mount/services/mount_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

DeadzonThemeController createDeadzonThemeController() {
  final controller = DeadzonThemeController(service: MountService());
  controller.initialize();
  return controller;
}

class DeadzoneColorOption {
  const DeadzoneColorOption({required this.id, required this.label, required this.color});

  final String id;
  final String label;
  final Color color;
}

class DeadzonThemeController extends ChangeNotifier {
  DeadzonThemeController({required MountService service}) : _service = service;

  final MountService _service;

  static const String _themeModeKey = 'deadzon_theme_mode_v1';
  static const String _accentColorKey = 'deadzone_accent_color_v1';
  static const String _lightPaletteKey = 'deadzone_light_ui_palette_v1';
  static const String _darkPaletteKey = 'deadzone_dark_ui_palette_v1';
  static const String _lightBackgroundKey = 'deadzone_light_background_v1';
  static const String _darkBackgroundKey = 'deadzone_dark_background_v1';

  static const String defaultAccentId = 'deadzone_mint';
  static const String defaultLightPaletteId = 'slate';
  static const String defaultDarkPaletteId = 'carbon';
  static const String defaultLightBackgroundId = 'fog';
  static const String defaultDarkBackgroundId = 'carbon';

  static const List<DeadzoneColorOption> accentOptions = <DeadzoneColorOption>[
    DeadzoneColorOption(id: 'deadzone_mint', label: 'DeadZone Mint', color: Color(0xFF2ED9A6)),
    DeadzoneColorOption(id: 'cyan', label: 'Cyan', color: Color(0xFF39D2FF)),
    DeadzoneColorOption(id: 'purple', label: 'Purple', color: Color(0xFF9C6DFF)),
    DeadzoneColorOption(id: 'blue', label: 'Blue', color: Color(0xFF4B7CFF)),
    DeadzoneColorOption(id: 'green', label: 'Green', color: Color(0xFF45D26C)),
    DeadzoneColorOption(id: 'amber', label: 'Amber', color: Color(0xFFFFB347)),
    DeadzoneColorOption(id: 'red', label: 'Red', color: Color(0xFFFF5F65)),
    DeadzoneColorOption(id: 'rose', label: 'Rose', color: Color(0xFFFF6FAE)),
    DeadzoneColorOption(id: 'white', label: 'White', color: Color(0xFFF4F8FF)),
  ];

  static const List<DeadzoneColorOption> lightPaletteOptions = <DeadzoneColorOption>[
    DeadzoneColorOption(id: 'slate', label: 'Slate', color: Color(0xFF587084)),
    DeadzoneColorOption(id: 'mint', label: 'Mint', color: Color(0xFF54CDB2)),
    DeadzoneColorOption(id: 'blue', label: 'Blue', color: Color(0xFF5E86FF)),
    DeadzoneColorOption(id: 'purple', label: 'Purple', color: Color(0xFFA88BFF)),
    DeadzoneColorOption(id: 'neutral', label: 'Neutral', color: Color(0xFF8D959F)),
    DeadzoneColorOption(id: 'soft_green', label: 'Soft Green', color: Color(0xFF68B88E)),
  ];

  static const List<DeadzoneColorOption> darkPaletteOptions = <DeadzoneColorOption>[
    DeadzoneColorOption(id: 'carbon', label: 'Carbon', color: Color(0xFF101418)),
    DeadzoneColorOption(id: 'slate', label: 'Slate', color: Color(0xFF233643)),
    DeadzoneColorOption(id: 'midnight', label: 'Midnight', color: Color(0xFF1A1B3D)),
    DeadzoneColorOption(id: 'deep_ocean', label: 'Deep Ocean', color: Color(0xFF0D2C57)),
    DeadzoneColorOption(id: 'dark_violet', label: 'Dark Violet', color: Color(0xFF4C1A7A)),
    DeadzoneColorOption(id: 'abyss', label: 'Abyss', color: Color(0xFF06171D)),
  ];

  static const List<DeadzoneColorOption> lightBackgroundOptions = <DeadzoneColorOption>[
    DeadzoneColorOption(id: 'fog', label: 'Fog', color: Color(0xFFF2F7F8)),
    DeadzoneColorOption(id: 'snow', label: 'Snow', color: Color(0xFFF9FBFF)),
    DeadzoneColorOption(id: 'pearl', label: 'Pearl', color: Color(0xFFF7F4EF)),
    DeadzoneColorOption(id: 'cloud', label: 'Cloud', color: Color(0xFFEFF3F8)),
    DeadzoneColorOption(id: 'mist', label: 'Mist', color: Color(0xFFE8F0F3)),
    DeadzoneColorOption(id: 'porcelain', label: 'Porcelain', color: Color(0xFFF8F5F2)),
    DeadzoneColorOption(id: 'sand', label: 'Sand', color: Color(0xFFF3EBDC)),
    DeadzoneColorOption(id: 'cream', label: 'Cream', color: Color(0xFFFFF7E8)),
    DeadzoneColorOption(id: 'soft_mint', label: 'Soft Mint', color: Color(0xFFE9FAF4)),
    DeadzoneColorOption(id: 'pale_blue', label: 'Pale Blue', color: Color(0xFFEAF3FF)),
    DeadzoneColorOption(id: 'lavender', label: 'Lavender', color: Color(0xFFF1ECFF)),
    DeadzoneColorOption(id: 'rose_white', label: 'Rose White', color: Color(0xFFFFF2F5)),
  ];

  static const List<DeadzoneColorOption> darkBackgroundOptions = <DeadzoneColorOption>[
    DeadzoneColorOption(id: 'carbon', label: 'Carbon', color: Color(0xFF0D1117)),
    DeadzoneColorOption(id: 'charcoal', label: 'Charcoal', color: Color(0xFF1A1B1E)),
    DeadzoneColorOption(id: 'graphite', label: 'Graphite', color: Color(0xFF2F3136)),
    DeadzoneColorOption(id: 'slate', label: 'Slate', color: Color(0xFF2B3D4B)),
    DeadzoneColorOption(id: 'abyss', label: 'Abyss', color: Color(0xFF001014)),
    DeadzoneColorOption(id: 'warm_dark', label: 'Warm Dark', color: Color(0xFF1E1007)),
    DeadzoneColorOption(id: 'navy', label: 'Navy', color: Color(0xFF252B8A)),
    DeadzoneColorOption(id: 'deep_blue', label: 'Deep Blue', color: Color(0xFF132A8A)),
    DeadzoneColorOption(id: 'midnight', label: 'Midnight', color: Color(0xFF1B1F43)),
    DeadzoneColorOption(id: 'deep_purple', label: 'Deep Purple', color: Color(0xFF3A249D)),
    DeadzoneColorOption(id: 'dark_violet', label: 'Dark Violet', color: Color(0xFF5A1BA8)),
    DeadzoneColorOption(id: 'dark_teal', label: 'Dark Teal', color: Color(0xFF045B52)),
    DeadzoneColorOption(id: 'dark_green', label: 'Dark Green', color: Color(0xFF1F6A25)),
    DeadzoneColorOption(id: 'dark_olive', label: 'Dark Olive', color: Color(0xFF3C7721)),
    DeadzoneColorOption(id: 'dark_red', label: 'Dark Red', color: Color(0xFF7F1214)),
    DeadzoneColorOption(id: 'dark_rose', label: 'Dark Rose', color: Color(0xFF701043)),
    DeadzoneColorOption(id: 'dark_amber', label: 'Dark Amber', color: Color(0xFF7D4D00)),
    DeadzoneColorOption(id: 'dark_brown', label: 'Dark Brown', color: Color(0xFF5B3327)),
    DeadzoneColorOption(id: 'obsidian', label: 'Obsidian', color: Color(0xFF1C2858)),
    DeadzoneColorOption(id: 'deep_ocean', label: 'Deep Ocean', color: Color(0xFF0A3266)),
    DeadzoneColorOption(id: 'dark_forest', label: 'Dark Forest', color: Color(0xFF005113)),
    DeadzoneColorOption(id: 'copper', label: 'Copper', color: Color(0xFF875100)),
    DeadzoneColorOption(id: 'crimson', label: 'Crimson', color: Color(0xFF9B0808)),
    DeadzoneColorOption(id: 'ink', label: 'Ink', color: Color(0xFF20203D)),
  ];

  Color accentColor = MountDefaults.baseConfig().selectedColor;
  Color secondaryAccentColor = MountDefaults.baseConfig().selectedSeedColor;
  Color backgroundTint = const Color(0xFF102029);
  Color cardTint = MountDefaults.baseConfig().cardBackgroundTint;
  Color borderColor = Colors.white.withValues(alpha: 0.22);
  Color iconAccentColor = MountDefaults.baseConfig().iconAccentColor;
  Color textAccentColor = MountDefaults.baseConfig().textAccentColor;
  Color switchOnColor = MountDefaults.baseConfig().switchOnColor;
  Color switchOffColor = MountDefaults.baseConfig().switchOffColor;
  Color sliderColor = MountDefaults.baseConfig().seekbarColor;
  Color checkboxColor = MountDefaults.baseConfig().checkboxOnColor;
  Color checkboxOffColor = MountDefaults.baseConfig().checkboxOffColor;
  String activeMountProfileId = 'default';
  bool liveApplyEnabled = true;
  ThemeMode themeMode = ThemeMode.system;

  String selectedAccentId = defaultAccentId;
  String selectedLightPaletteId = defaultLightPaletteId;
  String selectedDarkPaletteId = defaultDarkPaletteId;
  String selectedLightBackgroundId = defaultLightBackgroundId;
  String selectedDarkBackgroundId = defaultDarkBackgroundId;

  MountConfig _appliedConfig = MountDefaults.baseConfig();

  MountConfig get appliedConfig => _appliedConfig;
  DeadzoneColorOption get selectedAccent => _optionById(accentOptions, selectedAccentId, defaultAccentId);
  DeadzoneColorOption get selectedLightPalette => _optionById(lightPaletteOptions, selectedLightPaletteId, defaultLightPaletteId);
  DeadzoneColorOption get selectedDarkPalette => _optionById(darkPaletteOptions, selectedDarkPaletteId, defaultDarkPaletteId);
  DeadzoneColorOption get selectedLightBackground => _optionById(lightBackgroundOptions, selectedLightBackgroundId, defaultLightBackgroundId);
  DeadzoneColorOption get selectedDarkBackground => _optionById(darkBackgroundOptions, selectedDarkBackgroundId, defaultDarkBackgroundId);

  Future<void> initialize() async {
    final loaded = await _service.loadConfig();
    _setFromConfig(loaded, notify: false);
    final prefs = await SharedPreferences.getInstance();
    final storedMode = prefs.getString(_themeModeKey);
    themeMode = switch (storedMode) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
    selectedAccentId = prefs.getString(_accentColorKey) ?? defaultAccentId;
    selectedLightPaletteId = prefs.getString(_lightPaletteKey) ?? defaultLightPaletteId;
    selectedDarkPaletteId = prefs.getString(_darkPaletteKey) ?? defaultDarkPaletteId;
    selectedLightBackgroundId = prefs.getString(_lightBackgroundKey) ?? defaultLightBackgroundId;
    selectedDarkBackgroundId = prefs.getString(_darkBackgroundKey) ?? defaultDarkBackgroundId;
    _applyAppearanceToThemeFields(notify: false);
    notifyListeners();
  }

  Future<void> applyMountConfig(MountConfig config, {bool persist = true}) async {
    _setFromConfig(config);
    _applyAppearanceToThemeFields(fromMount: true);
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
    _applyAppearanceToThemeFields();
    await _service.saveConfig(defaults);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    themeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final value = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    await prefs.setString(_themeModeKey, value);
  }

  Future<void> setAccentColor(String id) async {
    selectedAccentId = id;
    _applyAppearanceToThemeFields();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accentColorKey, selectedAccentId);
  }

  Future<void> setLightPalette(String id) async {
    selectedLightPaletteId = id;
    _applyAppearanceToThemeFields();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lightPaletteKey, selectedLightPaletteId);
  }

  Future<void> setDarkPalette(String id) async {
    selectedDarkPaletteId = id;
    _applyAppearanceToThemeFields();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_darkPaletteKey, selectedDarkPaletteId);
  }

  Future<void> setLightBackground(String id) async {
    selectedLightBackgroundId = id;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lightBackgroundKey, selectedLightBackgroundId);
  }

  Future<void> setDarkBackground(String id) async {
    selectedDarkBackgroundId = id;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_darkBackgroundKey, selectedDarkBackgroundId);
  }

  Future<void> resetAppPreferences() async {
    themeMode = ThemeMode.system;
    selectedAccentId = defaultAccentId;
    selectedLightPaletteId = defaultLightPaletteId;
    selectedDarkPaletteId = defaultDarkPaletteId;
    selectedLightBackgroundId = defaultLightBackgroundId;
    selectedDarkBackgroundId = defaultDarkBackgroundId;
    _applyAppearanceToThemeFields();
    final prefs = await SharedPreferences.getInstance();
    prefs
      ..setString(_themeModeKey, 'system')
      ..setString(_accentColorKey, defaultAccentId)
      ..setString(_lightPaletteKey, defaultLightPaletteId)
      ..setString(_darkPaletteKey, defaultDarkPaletteId)
      ..setString(_lightBackgroundKey, defaultLightBackgroundId)
      ..setString(_darkBackgroundKey, defaultDarkBackgroundId);
  }

  void _setFromConfig(MountConfig config, {bool notify = true}) {
    _appliedConfig = config;
    accentColor = config.selectedColor;
    secondaryAccentColor = config.selectedSeedColor;
    backgroundTint = Color.lerp(const Color(0xFF0B1418), config.cardBackgroundTint, 0.28) ?? const Color(0xFF0B1418);
    cardTint = config.cardBackgroundTint;
    borderColor = Colors.white.withValues(alpha: config.borderVisibility.clamp(0.15, 0.82));
    iconAccentColor = config.iconAccentColor;
    textAccentColor = config.textAccentColor;
    switchOnColor = config.switchOnColor;
    switchOffColor = config.switchOffColor;
    sliderColor = config.seekbarColor;
    checkboxColor = config.checkboxOnColor;
    checkboxOffColor = config.checkboxOffColor;
    activeMountProfileId = config.activeProfileId;
    liveApplyEnabled = config.liveApplyEnabled;
    if (notify) {
      notifyListeners();
    }
  }

  void _applyAppearanceToThemeFields({bool notify = true, bool fromMount = false}) {
    if (!fromMount) {
      accentColor = selectedAccent.color;
      switchOnColor = selectedAccent.color;
      sliderColor = selectedAccent.color;
      checkboxColor = selectedAccent.color;
    }
    backgroundTint = Color.lerp(const Color(0xFF0B1418), selectedDarkBackground.color, 0.56) ?? const Color(0xFF0B1418);
    if (!fromMount) {
      iconAccentColor = Color.lerp(selectedAccent.color, selectedDarkPalette.color, 0.24) ?? selectedAccent.color;
      textAccentColor = Color.lerp(selectedAccent.color, Colors.white, 0.25) ?? selectedAccent.color;
    }
    if (notify) {
      notifyListeners();
    }
  }

  static DeadzoneColorOption _optionById(List<DeadzoneColorOption> options, String id, String fallbackId) {
    return options.firstWhere(
      (DeadzoneColorOption option) => option.id == id,
      orElse: () => options.firstWhere((DeadzoneColorOption option) => option.id == fallbackId),
    );
  }
}

class DeadzonThemeTokens {
  const DeadzonThemeTokens._();

  static DeadzonThemeController of(BuildContext context) => context.read<DeadzonThemeController>();

  static Color accent(BuildContext context) => of(context).accentColor;
  static Color appBackground(BuildContext context) => palette(context).appBackground;
  static Color pageBackground(BuildContext context) => palette(context).pageBackground;
  static Color cardBackground(BuildContext context) => palette(context).cardBackground;
  static Color cardBackgroundStrong(BuildContext context) => palette(context).cardBackgroundStrong;
  static Color cardBorder(BuildContext context) => palette(context).cardBorder;
  static Color divider(BuildContext context) => palette(context).divider;
  static Color textPrimary(BuildContext context) => palette(context).textPrimary;
  static Color textSecondary(BuildContext context) => palette(context).textSecondary;
  static Color textMuted(BuildContext context) => palette(context).textMuted;
  static Color accentSoft(BuildContext context) => palette(context).accentSoft;
  static Color iconChipBackground(BuildContext context) => palette(context).iconChipBackground;
  static Color iconChipBorder(BuildContext context) => palette(context).iconChipBorder;
  static Color bottomNavBackground(BuildContext context) => palette(context).bottomNavBackground;
  static Color bottomNavBorder(BuildContext context) => palette(context).bottomNavBorder;
  static Color bottomNavSelectedBackground(BuildContext context) => palette(context).bottomNavSelectedBackground;
  static Color bottomNavText(BuildContext context) => palette(context).bottomNavText;
  static Color bottomNavSelectedText(BuildContext context) => palette(context).bottomNavSelectedText;
  static Color switchActive(BuildContext context) => palette(context).switchActive;
  static Color switchInactive(BuildContext context) => palette(context).switchInactive;
  static Color checkboxActive(BuildContext context) => palette(context).checkboxActive;
  static Color checkboxInactive(BuildContext context) => palette(context).checkboxInactive;
  static Color sliderActive(BuildContext context) => palette(context).sliderActive;
  static Color sliderInactive(BuildContext context) => palette(context).sliderInactive;
  static Color sliderThumb(BuildContext context) => palette(context).sliderThumb;
  static Color sliderOverlay(BuildContext context) => palette(context).sliderOverlay;
  static Color progressActive(BuildContext context) => palette(context).progressActive;
  static Color progressInactive(BuildContext context) => palette(context).progressInactive;
  static Color backgroundDark(BuildContext context) => of(context).selectedDarkBackground.color;
  static Color backgroundLight(BuildContext context) => of(context).selectedLightBackground.color;
  static Color navSurface(BuildContext context) => palette(context).bottomNavBackground;
  static Color navSelectedPill(BuildContext context) => palette(context).bottomNavSelectedBackground;
  static Color navSelectedIcon(BuildContext context) => palette(context).bottomNavSelectedText;
  static Color navSelectedLabel(BuildContext context) => palette(context).bottomNavSelectedText;
  static Color sheetBackground(BuildContext context) => palette(context).sheetBackground;
  static Color buttonBackground(BuildContext context) => palette(context).buttonBackground;
  static Color buttonText(BuildContext context) => palette(context).buttonText;
  static Color shadow(BuildContext context) => palette(context).shadow;

  static Color cardTint(BuildContext context) => of(context).cardTint;

  static Color border(BuildContext context) => of(context).borderColor;

  static Color textAccent(BuildContext context) => of(context).textAccentColor;

  static Color iconAccent(BuildContext context) => of(context).iconAccentColor;

  static Color navBackground(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    if (isLight) {
      return Color.lerp(of(context).selectedLightBackground.color, of(context).accentColor, 0.08)?.withValues(alpha: 0.94) ?? const Color(0xEBF3F8FA);
    }
    return Color.lerp(of(context).selectedDarkBackground.color, of(context).backgroundTint, 0.45)?.withValues(alpha: 0.9) ?? const Color(0xDD0D1B2B);
  }

  static DeadzonThemePalette palette(BuildContext context) {
    final controller = of(context);
    final isLight = Theme.of(context).brightness == Brightness.light;
    final accent = controller.accentColor;
    if (isLight) {
      final pageBg = Color.lerp(controller.selectedLightBackground.color, const Color(0xFFEAF3FF), 0.36) ?? const Color(0xFFEAF3FF);
      return DeadzonThemePalette(
        appBackground: pageBg,
        pageBackground: Color.lerp(pageBg, Colors.white, 0.2) ?? pageBg,
        cardBackground: Color.lerp(pageBg, Colors.white, 0.62)!.withValues(alpha: 0.86),
        cardBackgroundStrong: Color.lerp(pageBg, Colors.white, 0.78)!.withValues(alpha: 0.92),
        cardBorder: Color(0xFFB7CBDB).withValues(alpha: 0.6),
        divider: const Color(0xFF8FA4B5).withValues(alpha: 0.24),
        textPrimary: const Color(0xFF142433),
        textSecondary: const Color(0xFF2D4253),
        textMuted: const Color(0xFF5E7486),
        accent: accent,
        accentSoft: accent.withValues(alpha: 0.14),
        iconChipBackground: accent.withValues(alpha: 0.15),
        iconChipBorder: accent.withValues(alpha: 0.22),
        bottomNavBackground: Color.lerp(pageBg, Colors.white, 0.46)!.withValues(alpha: 0.92),
        bottomNavBorder: const Color(0xFF95AABD).withValues(alpha: 0.35),
        bottomNavSelectedBackground: accent.withValues(alpha: 0.2),
        bottomNavText: const Color(0xFF3A4D5E),
        bottomNavSelectedText: const Color(0xFF0F2532),
        switchActive: accent,
        switchInactive: controller.switchOffColor.withValues(alpha: 0.92),
        checkboxActive: controller.checkboxColor,
        checkboxInactive: controller.checkboxOffColor.withValues(alpha: 0.92),
        sliderActive: accent,
        sliderInactive: const Color(0xFFAAC0D1),
        sliderThumb: controller.seekbarColor,
        sliderOverlay: controller.seekbarColor.withValues(alpha: 0.22),
        progressActive: controller.seekbarColor,
        progressInactive: const Color(0xFFAAC0D1),
        sheetBackground: Color.lerp(pageBg, Colors.white, 0.65)!.withValues(alpha: 0.98),
        buttonBackground: accent,
        buttonText: const Color(0xFF08211A),
        shadow: const Color(0xFF1E2A38).withValues(alpha: 0.16),
      );
    }
    final pageBg = Color.lerp(controller.selectedDarkBackground.color, const Color(0xFF050C19), 0.44) ?? const Color(0xFF050C19);
    return DeadzonThemePalette(
      appBackground: pageBg,
      pageBackground: Color.lerp(pageBg, const Color(0xFF030811), 0.35) ?? pageBg,
      cardBackground: Colors.white.withValues(alpha: 0.08),
      cardBackgroundStrong: Colors.white.withValues(alpha: 0.11),
      cardBorder: Colors.white.withValues(alpha: 0.18),
      divider: Colors.white.withValues(alpha: 0.12),
      textPrimary: const Color(0xFFF3FBFF),
      textSecondary: const Color(0xFFCCE0EB),
      textMuted: const Color(0xFF94ADBE),
      accent: accent,
      accentSoft: accent.withValues(alpha: 0.16),
      iconChipBackground: accent.withValues(alpha: 0.16),
      iconChipBorder: accent.withValues(alpha: 0.24),
      bottomNavBackground: Color.lerp(pageBg, const Color(0xFF0D1B2B), 0.5)!.withValues(alpha: 0.92),
      bottomNavBorder: Colors.white.withValues(alpha: 0.18),
      bottomNavSelectedBackground: accent.withValues(alpha: 0.24),
      bottomNavText: const Color(0xFFC6DAE6),
      bottomNavSelectedText: const Color(0xFFF2FFFF),
      switchActive: accent,
      switchInactive: controller.switchOffColor.withValues(alpha: 0.82),
      checkboxActive: controller.checkboxColor,
      checkboxInactive: controller.checkboxOffColor.withValues(alpha: 0.82),
      sliderActive: accent,
      sliderInactive: const Color(0xFF355164),
      sliderThumb: controller.seekbarColor,
      sliderOverlay: controller.seekbarColor.withValues(alpha: 0.22),
      progressActive: controller.seekbarColor,
      progressInactive: const Color(0xFF355164),
      sheetBackground: const Color(0xEE0A1626),
      buttonBackground: accent.withValues(alpha: 0.9),
      buttonText: const Color(0xFF02110D),
      shadow: const Color(0xFF000000).withValues(alpha: 0.34),
    );
  }
}

class DeadzonThemePalette {
  const DeadzonThemePalette({
    required this.appBackground,
    required this.pageBackground,
    required this.cardBackground,
    required this.cardBackgroundStrong,
    required this.cardBorder,
    required this.divider,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.accent,
    required this.accentSoft,
    required this.iconChipBackground,
    required this.iconChipBorder,
    required this.bottomNavBackground,
    required this.bottomNavBorder,
    required this.bottomNavSelectedBackground,
    required this.bottomNavText,
    required this.bottomNavSelectedText,
    required this.switchActive,
    required this.switchInactive,
    required this.checkboxActive,
    required this.checkboxInactive,
    required this.sliderActive,
    required this.sliderInactive,
    required this.sliderThumb,
    required this.sliderOverlay,
    required this.progressActive,
    required this.progressInactive,
    required this.sheetBackground,
    required this.buttonBackground,
    required this.buttonText,
    required this.shadow,
  });
  final Color appBackground;
  final Color pageBackground;
  final Color cardBackground;
  final Color cardBackgroundStrong;
  final Color cardBorder;
  final Color divider;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color accent;
  final Color accentSoft;
  final Color iconChipBackground;
  final Color iconChipBorder;
  final Color bottomNavBackground;
  final Color bottomNavBorder;
  final Color bottomNavSelectedBackground;
  final Color bottomNavText;
  final Color bottomNavSelectedText;
  final Color switchActive;
  final Color switchInactive;
  final Color checkboxActive;
  final Color checkboxInactive;
  final Color sliderActive;
  final Color sliderInactive;
  final Color sliderThumb;
  final Color sliderOverlay;
  final Color progressActive;
  final Color progressInactive;
  final Color sheetBackground;
  final Color buttonBackground;
  final Color buttonText;
  final Color shadow;
}
