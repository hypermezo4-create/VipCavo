import 'dart:convert';

import 'package:flutter/material.dart';

class MountConfig {
  const MountConfig({
    required this.monetEnabled,
    required this.selectedColor,
    required this.selectedColorName,
    required this.glassOpacity,
    required this.blurStrength,
    required this.accentIntensity,
    required this.glowAmount,
    required this.cornerRadius,
    required this.shadowDepth,
    required this.borderVisibility,
    required this.seekbarColor,
    required this.switchOnColor,
    required this.switchOffColor,
    required this.checkboxOnColor,
    required this.checkboxOffColor,
    required this.cardBackgroundTint,
    required this.iconAccentColor,
    required this.textAccentColor,
    required this.scopeStatusbar,
    required this.scopeControlCenter,
    required this.scopeNotifications,
    required this.scopeLockscreen,
    required this.scopeSettings,
    required this.scopeLauncher,
    required this.scopeSelectedApps,
    required this.selectedPackageNames,
    required this.controlAppToggles,
    required this.activeProfileId,
  });

  final bool monetEnabled;
  final Color selectedColor;
  final String selectedColorName;
  final double glassOpacity;
  final double blurStrength;
  final double accentIntensity;
  final double glowAmount;
  final double cornerRadius;
  final double shadowDepth;
  final double borderVisibility;
  final Color seekbarColor;
  final Color switchOnColor;
  final Color switchOffColor;
  final Color checkboxOnColor;
  final Color checkboxOffColor;
  final Color cardBackgroundTint;
  final Color iconAccentColor;
  final Color textAccentColor;
  final bool scopeStatusbar;
  final bool scopeControlCenter;
  final bool scopeNotifications;
  final bool scopeLockscreen;
  final bool scopeSettings;
  final bool scopeLauncher;
  final bool scopeSelectedApps;
  final List<String> selectedPackageNames;
  final Map<String, bool> controlAppToggles;
  final String activeProfileId;

  MountConfig copyWith({
    bool? monetEnabled,
    Color? selectedColor,
    String? selectedColorName,
    double? glassOpacity,
    double? blurStrength,
    double? accentIntensity,
    double? glowAmount,
    double? cornerRadius,
    double? shadowDepth,
    double? borderVisibility,
    Color? seekbarColor,
    Color? switchOnColor,
    Color? switchOffColor,
    Color? checkboxOnColor,
    Color? checkboxOffColor,
    Color? cardBackgroundTint,
    Color? iconAccentColor,
    Color? textAccentColor,
    bool? scopeStatusbar,
    bool? scopeControlCenter,
    bool? scopeNotifications,
    bool? scopeLockscreen,
    bool? scopeSettings,
    bool? scopeLauncher,
    bool? scopeSelectedApps,
    List<String>? selectedPackageNames,
    Map<String, bool>? controlAppToggles,
    String? activeProfileId,
  }) {
    return MountConfig(
      monetEnabled: monetEnabled ?? this.monetEnabled,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedColorName: selectedColorName ?? this.selectedColorName,
      glassOpacity: glassOpacity ?? this.glassOpacity,
      blurStrength: blurStrength ?? this.blurStrength,
      accentIntensity: accentIntensity ?? this.accentIntensity,
      glowAmount: glowAmount ?? this.glowAmount,
      cornerRadius: cornerRadius ?? this.cornerRadius,
      shadowDepth: shadowDepth ?? this.shadowDepth,
      borderVisibility: borderVisibility ?? this.borderVisibility,
      seekbarColor: seekbarColor ?? this.seekbarColor,
      switchOnColor: switchOnColor ?? this.switchOnColor,
      switchOffColor: switchOffColor ?? this.switchOffColor,
      checkboxOnColor: checkboxOnColor ?? this.checkboxOnColor,
      checkboxOffColor: checkboxOffColor ?? this.checkboxOffColor,
      cardBackgroundTint: cardBackgroundTint ?? this.cardBackgroundTint,
      iconAccentColor: iconAccentColor ?? this.iconAccentColor,
      textAccentColor: textAccentColor ?? this.textAccentColor,
      scopeStatusbar: scopeStatusbar ?? this.scopeStatusbar,
      scopeControlCenter: scopeControlCenter ?? this.scopeControlCenter,
      scopeNotifications: scopeNotifications ?? this.scopeNotifications,
      scopeLockscreen: scopeLockscreen ?? this.scopeLockscreen,
      scopeSettings: scopeSettings ?? this.scopeSettings,
      scopeLauncher: scopeLauncher ?? this.scopeLauncher,
      scopeSelectedApps: scopeSelectedApps ?? this.scopeSelectedApps,
      selectedPackageNames: selectedPackageNames ?? this.selectedPackageNames,
      controlAppToggles: controlAppToggles ?? this.controlAppToggles,
      activeProfileId: activeProfileId ?? this.activeProfileId,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'monetEnabled': monetEnabled,
      'selectedColor': selectedColor.toARGB32(),
      'selectedColorName': selectedColorName,
      'glassOpacity': glassOpacity,
      'blurStrength': blurStrength,
      'accentIntensity': accentIntensity,
      'glowAmount': glowAmount,
      'cornerRadius': cornerRadius,
      'shadowDepth': shadowDepth,
      'borderVisibility': borderVisibility,
      'seekbarColor': seekbarColor.toARGB32(),
      'switchOnColor': switchOnColor.toARGB32(),
      'switchOffColor': switchOffColor.toARGB32(),
      'checkboxOnColor': checkboxOnColor.toARGB32(),
      'checkboxOffColor': checkboxOffColor.toARGB32(),
      'cardBackgroundTint': cardBackgroundTint.toARGB32(),
      'iconAccentColor': iconAccentColor.toARGB32(),
      'textAccentColor': textAccentColor.toARGB32(),
      'scopeStatusbar': scopeStatusbar,
      'scopeControlCenter': scopeControlCenter,
      'scopeNotifications': scopeNotifications,
      'scopeLockscreen': scopeLockscreen,
      'scopeSettings': scopeSettings,
      'scopeLauncher': scopeLauncher,
      'scopeSelectedApps': scopeSelectedApps,
      'selectedPackageNames': selectedPackageNames,
      'controlAppToggles': controlAppToggles,
      'activeProfileId': activeProfileId,
    };
  }

  String encode() => jsonEncode(toJson());

  static MountConfig fromJson(Map<String, dynamic> map, MountConfig fallback) {
    Color c(String key, Color current) => Color((map[key] as int?) ?? current.toARGB32());

    return fallback.copyWith(
      monetEnabled: map['monetEnabled'] as bool?,
      selectedColor: c('selectedColor', fallback.selectedColor),
      selectedColorName: map['selectedColorName'] as String?,
      glassOpacity: (map['glassOpacity'] as num?)?.toDouble(),
      blurStrength: (map['blurStrength'] as num?)?.toDouble(),
      accentIntensity: (map['accentIntensity'] as num?)?.toDouble(),
      glowAmount: (map['glowAmount'] as num?)?.toDouble(),
      cornerRadius: (map['cornerRadius'] as num?)?.toDouble(),
      shadowDepth: (map['shadowDepth'] as num?)?.toDouble(),
      borderVisibility: (map['borderVisibility'] as num?)?.toDouble(),
      seekbarColor: c('seekbarColor', fallback.seekbarColor),
      switchOnColor: c('switchOnColor', fallback.switchOnColor),
      switchOffColor: c('switchOffColor', fallback.switchOffColor),
      checkboxOnColor: c('checkboxOnColor', fallback.checkboxOnColor),
      checkboxOffColor: c('checkboxOffColor', fallback.checkboxOffColor),
      cardBackgroundTint: c('cardBackgroundTint', fallback.cardBackgroundTint),
      iconAccentColor: c('iconAccentColor', fallback.iconAccentColor),
      textAccentColor: c('textAccentColor', fallback.textAccentColor),
      scopeStatusbar: map['scopeStatusbar'] as bool?,
      scopeControlCenter: map['scopeControlCenter'] as bool?,
      scopeNotifications: map['scopeNotifications'] as bool?,
      scopeLockscreen: map['scopeLockscreen'] as bool?,
      scopeSettings: map['scopeSettings'] as bool?,
      scopeLauncher: map['scopeLauncher'] as bool?,
      scopeSelectedApps: map['scopeSelectedApps'] as bool?,
      selectedPackageNames: (map['selectedPackageNames'] as List<dynamic>?)?.map((e) => '$e').toList(),
      controlAppToggles: (map['controlAppToggles'] as Map<String, dynamic>?)?.map((key, value) => MapEntry(key, value == true)),
      activeProfileId: map['activeProfileId'] as String?,
    );
  }

  static MountConfig decode(String value, MountConfig fallback) {
    final decoded = jsonDecode(value);
    if (decoded is! Map<String, dynamic>) {
      return fallback;
    }
    return fromJson(decoded, fallback);
  }
}
