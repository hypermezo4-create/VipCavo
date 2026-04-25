import 'package:flutter/material.dart';

enum StatusbarVisibilityType { boolFlag, intAsVisible }

class StatusbarBoardModule {
  const StatusbarBoardModule({
    required this.id,
    required this.legacyIndex,
    required this.title,
    required this.previewLabel,
    required this.icon,
    required this.iconAsset,
    required this.color,
    required this.sourceSmaliClass,
    required this.category,
    required this.visibilityKey,
    required this.offsetKey,
    this.defaultVisible = true,
    this.defaultEnabled = true,
    this.defaultOffset = 0,
    this.defaultSize = 1.0,
    this.defaultOffsetY = 0,
    this.sizeKey,
    this.enabledKey,
    this.offsetYKey,
    this.visibilityType = StatusbarVisibilityType.boolFlag,
  });

  final String id;
  final int legacyIndex;
  final String title;
  final String previewLabel;
  final IconData icon;
  final String iconAsset;
  final Color color;
  final String sourceSmaliClass;
  final String category;
  final String visibilityKey;
  final String offsetKey;
  final String? enabledKey;
  final String? sizeKey;
  final String? offsetYKey;
  final bool defaultVisible;
  final bool defaultEnabled;
  final double defaultOffset;
  final double defaultSize;
  final double defaultOffsetY;
  final StatusbarVisibilityType visibilityType;
}

const String statusbarBoardSerializedKey = 'status_bar_elem_position';
const String statusbarBoardSourceDefaultLayout =
    'elem_status.33;elem_clock.21;elem_bat.31;elem_net1.1;elem_net2.11;elem_wifi.2;elem_notif.22;elem_speed.3;elem_weather.32;elem_date.12;';

const List<StatusbarBoardModule> statusbarBoardModules = <StatusbarBoardModule>[
  StatusbarBoardModule(id: 'elem_status', legacyIndex: 1, title: 'Status icons', previewLabel: 'BT • Alarm', icon: Icons.widgets_rounded, iconAsset: 'reference/mezo/mezo/res/drawable-xxxhdpi/elem_status.png', color: Color(0xFFA9F4E0), sourceSmaliClass: 'StatusBarElementStatus', category: 'Status icons', visibilityKey: 'elem_status_element_visible', offsetKey: 'status_icon_division'),
  StatusbarBoardModule(id: 'elem_clock', legacyIndex: 2, title: 'Clock', previewLabel: '09:41', icon: Icons.access_time_rounded, iconAsset: 'reference/mezo/mezo/res/drawable-xxxhdpi/elem_clock.png', color: Color(0xFF89F3A0), sourceSmaliClass: 'StatusBarElementClock', category: 'Clock', visibilityKey: 'elem_clock_element_visible', offsetKey: 'status_clock_division'),
  StatusbarBoardModule(id: 'elem_bat', legacyIndex: 3, title: 'Battery', previewLabel: '84%', icon: Icons.battery_5_bar_rounded, iconAsset: 'reference/mezo/mezo/res/drawable-xxxhdpi/elem_bat.png', color: Color(0xFF90FFAC), sourceSmaliClass: 'StatusBarElementBat', category: 'Battery', visibilityKey: 'elem_bat_element_visible', offsetKey: 'batteryview_division'),
  StatusbarBoardModule(id: 'elem_net1', legacyIndex: 4, title: 'Network left', previewLabel: '5G', icon: Icons.network_cell_rounded, iconAsset: 'reference/mezo/mezo/res/drawable-xxxhdpi/elem_net1.png', color: Color(0xFF9AB2FF), sourceSmaliClass: 'StatusBarElementNetOne', category: 'Network', visibilityKey: 'elem_net1_element_visible', offsetKey: 'network_one_division'),
  StatusbarBoardModule(id: 'elem_net2', legacyIndex: 5, title: 'Network right', previewLabel: 'LTE', icon: Icons.network_cell_rounded, iconAsset: 'reference/mezo/mezo/res/drawable-xxxhdpi/elem_net2.png', color: Color(0xFF9AB2FF), sourceSmaliClass: 'StatusBarElementNetTwo', category: 'Network', visibilityKey: 'elem_net2_element_visible', offsetKey: 'network_two_division'),
  StatusbarBoardModule(id: 'elem_wifi', legacyIndex: 6, title: 'Wifi', previewLabel: 'Wi-Fi', icon: Icons.wifi_rounded, iconAsset: 'reference/mezo/mezo/res/drawable-xxxhdpi/elem_wifi.png', color: Color(0xFF9AB2FF), sourceSmaliClass: 'StatusBarElementWifi', category: 'Wifi', visibilityKey: 'elem_wifi_element_visible', offsetKey: 'status_bar_element_wifi_offset'),
  StatusbarBoardModule(id: 'elem_notif', legacyIndex: 7, title: 'Notification icons', previewLabel: 'Alerts', icon: Icons.notifications_rounded, iconAsset: 'reference/mezo/mezo/res/drawable-xxxhdpi/elem_notif.png', color: Color(0xFFFFBE87), sourceSmaliClass: 'StatusBarElementNotif', category: 'Notification icons', visibilityKey: 'status_bar_show_notification_icon', offsetKey: 'notif_icon_division', visibilityType: StatusbarVisibilityType.intAsVisible),
  StatusbarBoardModule(id: 'elem_speed', legacyIndex: 8, title: 'Netspeed', previewLabel: '1.3MB/s', icon: Icons.speed_rounded, iconAsset: 'reference/mezo/mezo/res/drawable-xxxhdpi/elem_speed.png', color: Color(0xFF8DE8FF), sourceSmaliClass: 'StatusBarElementSpeed', category: 'Netspeed', visibilityKey: 'status_bar_show_network_speed', offsetKey: 'net_speed_division', visibilityType: StatusbarVisibilityType.intAsVisible),
  StatusbarBoardModule(id: 'elem_weather', legacyIndex: 9, title: 'Weather', previewLabel: '28°', icon: Icons.wb_sunny_rounded, iconAsset: 'reference/mezo/mezo/res/drawable-xxxhdpi/elem_weather.png', color: Color(0xFF8DE8FF), sourceSmaliClass: 'StatusBarElementWeather', category: 'Weather', visibilityKey: 'elem_weather_element_visible', offsetKey: 'status_weather_division'),
  StatusbarBoardModule(id: 'elem_date', legacyIndex: 10, title: 'Date', previewLabel: 'Thu 23', icon: Icons.calendar_month_rounded, iconAsset: 'reference/mezo/mezo/res/drawable-xxxhdpi/elem_date.png', color: Color(0xFFB7C6FF), sourceSmaliClass: 'StatusBarElementDate', category: 'Date', visibilityKey: 'elem_date_element_visible', offsetKey: 'status_date_division'),
];

const Map<String, int> statusbarBoardDefaultCodeById = <String, int>{
  'elem_status': 33,
  'elem_clock': 21,
  'elem_bat': 31,
  'elem_net1': 1,
  'elem_net2': 11,
  'elem_wifi': 2,
  'elem_notif': 22,
  'elem_speed': 3,
  'elem_weather': 32,
  'elem_date': 12,
};

final Map<String, StatusbarBoardModule> statusbarBoardModulesById = {
  for (final module in statusbarBoardModules) module.id: module,
};
