import 'package:deadzon/features/mount/domain/mount_config.dart';
import 'package:deadzon/features/mount/domain/mount_monet_app.dart';
import 'package:deadzon/features/mount/domain/mount_profile.dart';
import 'package:flutter/material.dart';

class MountColorPreset {
  const MountColorPreset(this.name, this.color);

  final String name;
  final Color color;
}

class MountDefaults {
  const MountDefaults._();

  static const List<MountColorPreset> colorPresets = <MountColorPreset>[
    MountColorPreset('Mint Glass', Color(0xFF8CEFD2)),
    MountColorPreset('Aqua Frost', Color(0xFF7BDCF0)),
    MountColorPreset('Soft Gold', Color(0xFFEBCB87)),
    MountColorPreset('Purple Mist', Color(0xFFB8A1F8)),
    MountColorPreset('Sunset Soft', Color(0xFFFFAE9A)),
    MountColorPreset('Graphite', Color(0xFF8C95A8)),
  ];

  static MountConfig baseConfig() {
    return MountConfig(
      monetEnabled: false,
      selectedColor: colorPresets.first.color,
      selectedColorName: colorPresets.first.name,
      glassOpacity: 0.62,
      blurStrength: 18,
      accentIntensity: 0.68,
      glowAmount: 0.3,
      cornerRadius: 24,
      shadowDepth: 0.45,
      borderVisibility: 0.72,
      seekbarColor: const Color(0xFF8CEFD2),
      switchOnColor: const Color(0xFF80EBCF),
      switchOffColor: const Color(0xFF607182),
      checkboxOnColor: const Color(0xFF8CEFD2),
      checkboxOffColor: const Color(0xFF5B6B7B),
      cardBackgroundTint: const Color(0x1AFFFFFF),
      iconAccentColor: const Color(0xFFC2F7EA),
      textAccentColor: const Color(0xFFE8FAFF),
      scopeStatusbar: true,
      scopeControlCenter: true,
      scopeNotifications: true,
      scopeLockscreen: false,
      scopeSettings: true,
      scopeLauncher: false,
      scopeSelectedApps: false,
      selectedPackageNames: const <String>[],
      controlAppToggles: Map<String, bool>.fromEntries(
        controlApps.map((e) => MapEntry<String, bool>(e.key, true)),
      ),
      activeProfileId: 'default',
    );
  }

  static List<MountProfile> profiles() {
    final base = baseConfig();
    return <MountProfile>[
      MountProfile(id: 'default', name: 'Default', config: base),
      MountProfile(
        id: 'ios_frost',
        name: 'iOS Frost',
        config: base.copyWith(
          selectedColor: const Color(0xFF9DE8FF),
          selectedColorName: 'iOS Frost',
          glassOpacity: 0.58,
          blurStrength: 20,
          accentIntensity: 0.72,
          glowAmount: 0.22,
        ),
      ),
      MountProfile(
        id: 'deadzon_mint',
        name: 'Deadzon Mint',
        config: base.copyWith(
          selectedColor: const Color(0xFF8CEFD2),
          selectedColorName: 'Deadzon Mint',
          accentIntensity: 0.8,
          glowAmount: 0.34,
        ),
      ),
      MountProfile(
        id: 'dark_glass',
        name: 'Dark Glass',
        config: base.copyWith(
          selectedColor: const Color(0xFF7FA6BA),
          selectedColorName: 'Dark Glass',
          glassOpacity: 0.7,
          blurStrength: 14,
          shadowDepth: 0.7,
        ),
      ),
      MountProfile(
        id: 'soft_gold',
        name: 'Soft Gold',
        config: base.copyWith(
          selectedColor: const Color(0xFFEBCB87),
          selectedColorName: 'Soft Gold',
          accentIntensity: 0.64,
          glowAmount: 0.28,
        ),
      ),
      MountProfile(
        id: 'gaming_clean',
        name: 'Gaming Clean',
        config: base.copyWith(
          selectedColor: const Color(0xFF90D8FF),
          selectedColorName: 'Gaming Clean',
          accentIntensity: 0.78,
          blurStrength: 16,
          cornerRadius: 20,
        ),
      ),
    ];
  }

  static const List<MountSelectableApp> mockSelectableApps = <MountSelectableApp>[
    MountSelectableApp(name: 'YouTube', packageName: 'com.google.android.youtube', installed: true),
    MountSelectableApp(name: 'Telegram', packageName: 'org.telegram.messenger', installed: true),
    MountSelectableApp(name: 'Chrome', packageName: 'com.android.chrome', installed: true),
    MountSelectableApp(name: 'WhatsApp', packageName: 'com.whatsapp', installed: true),
    MountSelectableApp(name: 'Instagram', packageName: 'com.instagram.android', installed: true),
    MountSelectableApp(name: 'TikTok', packageName: 'com.zhiliaoapp.musically', installed: true),
    MountSelectableApp(name: 'Settings', packageName: 'com.android.settings', installed: true),
    MountSelectableApp(name: 'System UI', packageName: 'com.android.systemui', installed: true),
  ];

  static const List<MountMonetApp> controlApps = <MountMonetApp>[
    MountMonetApp(title: 'Settings', key: 'paperos_monet_settings', defaultEnabled: true, category: 'Core System', packageNameCandidates: <String>['com.android.settings'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'System UI', key: 'paperos_monet_systemui', defaultEnabled: true, category: 'Core System', packageNameCandidates: <String>['com.android.systemui'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'System UI Plugin', key: 'paperos_monet_systemuiplugin', defaultEnabled: true, category: 'Core System', packageNameCandidates: <String>['miui.systemui.plugin'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'Android Bluetooth', key: 'paperos_monet_androidbluetooth', defaultEnabled: true, category: 'Connectivity', packageNameCandidates: <String>['com.android.bluetooth'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'Package Installer', key: 'paperos_monet_packageinstaller', defaultEnabled: true, category: 'Core System', packageNameCandidates: <String>['com.google.android.packageinstaller'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'Permission', key: 'paperos_monet_permission', defaultEnabled: true, category: 'Core System', packageNameCandidates: <String>['com.android.permissioncontroller'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'Power Keeper', key: 'paperos_monet_powerkeeper', defaultEnabled: true, category: 'Security', packageNameCandidates: <String>['com.miui.powerkeeper'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'Freeform', key: 'paperos_monet_freeform', defaultEnabled: true, category: 'Core System', packageNameCandidates: <String>['com.miui.freeform'], isInstalled: false, enabled: true),
    MountMonetApp(title: 'Notification', key: 'paperos_monet_notification', defaultEnabled: true, category: 'Core System', packageNameCandidates: <String>['com.android.notification'], isInstalled: false, enabled: true),
    MountMonetApp(title: 'Xiaomi Account', key: 'paperos_monet_xiaomiaccount', defaultEnabled: true, category: 'Xiaomi / HyperOS', packageNameCandidates: <String>['com.xiaomi.account'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'Security Center', key: 'paperos_monet_securitycenter', defaultEnabled: true, category: 'Security', packageNameCandidates: <String>['com.miui.securitycenter'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'Security Core', key: 'paperos_monet_securitycore', defaultEnabled: true, category: 'Security', packageNameCandidates: <String>['com.miui.securitycore'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'Theme Manager', key: 'paperos_monet_thememanager', defaultEnabled: true, category: 'Xiaomi / HyperOS', packageNameCandidates: <String>['com.android.thememanager'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'MI Settings', key: 'paperos_monet_misettings', defaultEnabled: true, category: 'Xiaomi / HyperOS', packageNameCandidates: <String>['com.xiaomi.misettings'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'MI Service', key: 'paperos_monet_miservice', defaultEnabled: true, category: 'Xiaomi / HyperOS', packageNameCandidates: <String>['com.miui.service'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'MI Link Service', key: 'paperos_monet_milink_service', defaultEnabled: true, category: 'Connectivity', packageNameCandidates: <String>['com.milink.service'], isInstalled: false, enabled: true),
    MountMonetApp(title: 'MI Share', key: 'paperos_monet_mishare', defaultEnabled: true, category: 'Connectivity', packageNameCandidates: <String>['com.miui.mishare.connectivity'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'MI Sound', key: 'paperos_monet_misound', defaultEnabled: true, category: 'Xiaomi / HyperOS', packageNameCandidates: <String>['com.miui.misound'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'MI Input', key: 'paperos_monet_miinput', defaultEnabled: true, category: 'Tools', packageNameCandidates: <String>['com.miui.miinput'], isInstalled: false, enabled: true),
    MountMonetApp(title: 'Cloud Service', key: 'paperos_monet_cloudservice', defaultEnabled: true, category: 'Xiaomi / HyperOS', packageNameCandidates: <String>['com.miui.cloudservice'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'Cloud Backup', key: 'paperos_monet_cloudbackup', defaultEnabled: true, category: 'Xiaomi / HyperOS', packageNameCandidates: <String>['com.miui.cloudbackup'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'Find Device', key: 'paperos_monet_finddevice', defaultEnabled: true, category: 'Security', packageNameCandidates: <String>['com.miui.finddevice'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'Updater', key: 'paperos_monet_updater', defaultEnabled: true, category: 'Xiaomi / HyperOS', packageNameCandidates: <String>['com.android.updater'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'Gallery', key: 'paperos_monet_gallery', defaultEnabled: true, category: 'Media', packageNameCandidates: <String>['com.miui.gallery'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'Extra Photo', key: 'paperos_monet_extraphoto', defaultEnabled: true, category: 'Media', packageNameCandidates: <String>['com.miui.extraphoto'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'Media Editor', key: 'paperos_monet_mediaeditor', defaultEnabled: true, category: 'Media', packageNameCandidates: <String>['com.miui.mediaeditor'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'Camera', key: 'paperos_monet_camera', defaultEnabled: true, category: 'Media', packageNameCandidates: <String>['com.android.camera'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'Screen Recorder', key: 'paperos_monet_screenrecorder', defaultEnabled: true, category: 'Media', packageNameCandidates: <String>['com.miui.screenrecorder'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'Sound Recorder', key: 'paperos_monet_soundrecorder', defaultEnabled: true, category: 'Media', packageNameCandidates: <String>['com.android.soundrecorder'], isInstalled: false, enabled: true),
    MountMonetApp(title: 'Screenshot', key: 'paperos_monet_screenshot', defaultEnabled: true, category: 'Media', packageNameCandidates: <String>['com.miui.screenshot'], isInstalled: false, enabled: true),
    MountMonetApp(title: 'Scanner', key: 'paperos_monet_scanner', defaultEnabled: true, category: 'Tools', packageNameCandidates: <String>['com.xiaomi.scanner'], isInstalled: false, enabled: true),
    MountMonetApp(title: 'Mirror', key: 'paperos_monet_mirror', defaultEnabled: true, category: 'Other', packageNameCandidates: <String>['com.xiaomi.mirror'], isInstalled: false, enabled: true),
    MountMonetApp(title: 'Contacts', key: 'paperos_monet_contacts', defaultEnabled: true, category: 'Phone & Messages', packageNameCandidates: <String>['com.android.contacts'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'In Call UI', key: 'paperos_monet_incallui', defaultEnabled: true, category: 'Phone & Messages', packageNameCandidates: <String>['com.android.incallui'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'Phone', key: 'paperos_monet_phone', defaultEnabled: true, category: 'Phone & Messages', packageNameCandidates: <String>['com.android.dialer'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'MMS', key: 'paperos_monet_mms', defaultEnabled: true, category: 'Phone & Messages', packageNameCandidates: <String>['com.android.mms'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'Server Telecom', key: 'paperos_monet_server_telecom', defaultEnabled: true, category: 'Phone & Messages', packageNameCandidates: <String>['com.android.server.telecom'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'Home', key: 'paperos_monet_home', defaultEnabled: true, category: 'Launcher & UI', packageNameCandidates: <String>['com.miui.home'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'Personal Assistant', key: 'paperos_monet_personalassistant', defaultEnabled: true, category: 'Launcher & UI', packageNameCandidates: <String>['com.miui.personalassistant'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'Always On Display', key: 'paperos_monet_aod', defaultEnabled: true, category: 'Launcher & UI', packageNameCandidates: <String>['com.miui.aod'], isInstalled: false, enabled: true),
    MountMonetApp(title: 'Touch Assistant', key: 'paperos_monet_touchassistant', defaultEnabled: true, category: 'Launcher & UI', packageNameCandidates: <String>['com.miui.touchassistant'], isInstalled: false, enabled: true),
    MountMonetApp(title: 'File Explorer', key: 'paperos_monet_fileexplorer', defaultEnabled: true, category: 'Tools', packageNameCandidates: <String>['com.android.fileexplorer'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'Weather 2', key: 'paperos_monet_weather2', defaultEnabled: true, category: 'Tools', packageNameCandidates: <String>['com.miui.weather2'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'Backup', key: 'paperos_monet_backup', defaultEnabled: true, category: 'Tools', packageNameCandidates: <String>['com.miui.backup'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'Bluetooth', key: 'paperos_monet_bluetooth', defaultEnabled: true, category: 'Connectivity', packageNameCandidates: <String>['com.android.bluetooth'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'Bug Report', key: 'paperos_monet_bugreport', defaultEnabled: true, category: 'Tools', packageNameCandidates: <String>['com.miui.bugreport'], isInstalled: false, enabled: true),
    MountMonetApp(title: 'Calendar', key: 'paperos_monet_calendar', defaultEnabled: true, category: 'Tools', packageNameCandidates: <String>['com.android.calendar'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'Clean Master', key: 'paperos_monet_cleanmaster', defaultEnabled: true, category: 'Tools', packageNameCandidates: <String>['com.miui.cleanmaster'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'Calculator', key: 'paperos_monet_calculator', defaultEnabled: true, category: 'Tools', packageNameCandidates: <String>['com.android.calculator2'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'Desk Clock', key: 'paperos_monet_deskclock', defaultEnabled: true, category: 'Tools', packageNameCandidates: <String>['com.android.deskclock'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'Downloads', key: 'paperos_monet_downloads', defaultEnabled: true, category: 'Tools', packageNameCandidates: <String>['com.android.providers.downloads.ui'], isInstalled: true, enabled: true),
    MountMonetApp(title: 'Notes', key: 'paperos_monet_notes', defaultEnabled: true, category: 'Tools', packageNameCandidates: <String>['com.miui.notes'], isInstalled: true, enabled: true),
  ];
}
