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

// Source of truth: reference/mezo/mezo/smali/com/android/settings/statusbarelement/
// PositionsElementsStatusbarDouble.smali
// This old Mezo double-board resets layouts containing elem_prompt, so the board
// position writer intentionally mirrors the original 10 persisted elements only.
const String statusbarBoardSourceDefaultLayout =
    // User-approved visual default order:
    // Left top: clock/time, notification/call, weather/temperature, date.
    // Right top: speed, status icons, SIM 1, SIM 2, Wi‑Fi, battery.
    // Bottom lanes start empty.
    'elem_status.15;elem_clock.1;elem_bat.11;elem_net1.14;elem_net2.13;elem_wifi.12;elem_notif.2;elem_speed.16;elem_weather.3;elem_date.4;';

const List<int> statusbarBoardAllowedPositionCodes = <int>[
  // Same position ranges used by PositionsElementsStatusbarDouble.smali.
  // 1-9 top-left, 11-19 top-right, 21-29 bottom-left, 31-39 bottom-right.
  // Position 0 is intentionally excluded because it is center/dynamic/island.
  1, 2, 3, 4, 5, 6, 7, 8, 9,
  11, 12, 13, 14, 15, 16, 17, 18, 19,
  21, 22, 23, 24, 25, 26, 27, 28, 29,
  31, 32, 33, 34, 35, 36, 37, 38, 39,
];

const List<StatusbarBoardModule> statusbarBoardModules = <StatusbarBoardModule>[
  StatusbarBoardModule(
    id: 'elem_status',
    legacyIndex: 1,
    title: 'Status icons',
    previewLabel: 'BT • Alarm',
    icon: Icons.widgets_rounded,
    iconAsset: 'reference/mezo/mezo/res/drawable-xxxhdpi/elem_status.png',
    color: Color(0xFFA9F4E0),
    sourceSmaliClass: 'StatusBarElementStatus',
    category: 'Status icons',
    visibilityKey: 'elem_status_element_visible',
    offsetKey: 'status_icon_division',
  ),
  StatusbarBoardModule(
    id: 'elem_clock',
    legacyIndex: 2,
    title: 'Clock',
    previewLabel: '09:41',
    icon: Icons.access_time_rounded,
    iconAsset: 'reference/mezo/mezo/res/drawable-xxxhdpi/elem_clock.png',
    color: Color(0xFF89F3A0),
    sourceSmaliClass: 'StatusBarElementClock',
    category: 'Clock',
    visibilityKey: 'elem_clock_element_visible',
    offsetKey: 'status_clock_division',
  ),
  StatusbarBoardModule(
    id: 'elem_bat',
    legacyIndex: 3,
    title: 'Battery',
    previewLabel: '84%',
    icon: Icons.battery_5_bar_rounded,
    iconAsset: 'reference/mezo/mezo/res/drawable-xxxhdpi/elem_bat.png',
    color: Color(0xFFFFD75A),
    sourceSmaliClass: 'StatusBarElementBat',
    category: 'Battery',
    visibilityKey: 'elem_bat_element_visible',
    offsetKey: 'batteryview_division',
  ),
  StatusbarBoardModule(
    id: 'elem_net1',
    legacyIndex: 4,
    title: 'SIM 1 / Network blue',
    previewLabel: 'SIM 1',
    icon: Icons.network_cell_rounded,
    iconAsset: 'reference/mezo/mezo/res/drawable-xxxhdpi/elem_net1.png',
    color: Color(0xFF9AB2FF),
    sourceSmaliClass: 'StatusBarElementNetOne',
    category: 'Network',
    visibilityKey: 'elem_net1_element_visible',
    offsetKey: 'network_one_division',
  ),
  StatusbarBoardModule(
    id: 'elem_net2',
    legacyIndex: 5,
    title: 'SIM 2 / Network red',
    previewLabel: 'SIM 2',
    icon: Icons.network_cell_rounded,
    iconAsset: 'reference/mezo/mezo/res/drawable-xxxhdpi/elem_net2.png',
    color: Color(0xFFFF766C),
    sourceSmaliClass: 'StatusBarElementNetTwo',
    category: 'Network',
    visibilityKey: 'elem_net2_element_visible',
    offsetKey: 'network_two_division',
  ),
  StatusbarBoardModule(
    id: 'elem_wifi',
    legacyIndex: 6,
    title: 'Wi‑Fi',
    previewLabel: 'Wi‑Fi',
    icon: Icons.wifi_rounded,
    iconAsset: 'reference/mezo/mezo/res/drawable-xxxhdpi/elem_wifi.png',
    color: Color(0xFF9AB2FF),
    sourceSmaliClass: 'StatusBarElementWifi',
    category: 'Wifi',
    visibilityKey: 'elem_wifi_element_visible',
    offsetKey: 'status_bar_element_wifi_offset',
  ),
  StatusbarBoardModule(
    id: 'elem_notif',
    legacyIndex: 7,
    title: 'Notification icons',
    previewLabel: 'Alerts',
    icon: Icons.notifications_rounded,
    iconAsset: 'reference/mezo/mezo/res/drawable-xxxhdpi/elem_notif.png',
    color: Color(0xFFFFBE87),
    sourceSmaliClass: 'StatusBarElementNotif',
    category: 'Notification icons',
    visibilityKey: 'status_bar_show_notification_icon',
    offsetKey: 'notif_icon_division',
    visibilityType: StatusbarVisibilityType.intAsVisible,
  ),
  StatusbarBoardModule(
    id: 'elem_speed',
    legacyIndex: 8,
    title: 'Netspeed',
    previewLabel: '1.3MB/s',
    icon: Icons.speed_rounded,
    iconAsset: 'reference/mezo/mezo/res/drawable-xxxhdpi/elem_speed.png',
    color: Color(0xFF8DE8FF),
    sourceSmaliClass: 'StatusBarElementSpeed',
    category: 'Netspeed',
    visibilityKey: 'status_bar_show_network_speed',
    offsetKey: 'net_speed_division',
    visibilityType: StatusbarVisibilityType.intAsVisible,
  ),
  StatusbarBoardModule(
    id: 'elem_weather',
    legacyIndex: 9,
    title: 'Weather',
    previewLabel: '28°',
    icon: Icons.wb_sunny_rounded,
    iconAsset: 'reference/mezo/mezo/res/drawable-xxxhdpi/elem_weather.png',
    color: Color(0xFF8DE8FF),
    sourceSmaliClass: 'StatusBarElementWeather',
    category: 'Weather',
    visibilityKey: 'elem_weather_element_visible',
    offsetKey: 'status_weather_division',
  ),
  StatusbarBoardModule(
    id: 'elem_date',
    legacyIndex: 10,
    title: 'Date',
    previewLabel: 'Thu 23',
    icon: Icons.calendar_month_rounded,
    iconAsset: 'reference/mezo/mezo/res/drawable-xxxhdpi/elem_date.png',
    color: Color(0xFFB7C6FF),
    sourceSmaliClass: 'StatusBarElementDate',
    category: 'Date',
    visibilityKey: 'elem_date_element_visible',
    offsetKey: 'status_date_division',
  ),
];

const Map<String, int> statusbarBoardDefaultCodeById = <String, int>{
  // Keep this map exactly aligned with statusbarBoardSourceDefaultLayout.
  // This is the approved default shown in the user's reference screenshot.
  'elem_clock': 1,
  'elem_notif': 2,
  'elem_weather': 3,
  'elem_date': 4,
  'elem_bat': 11,
  'elem_wifi': 12,
  'elem_net2': 13,
  'elem_net1': 14,
  'elem_status': 15,
  'elem_speed': 16,
};

final Map<String, StatusbarBoardModule> statusbarBoardModulesById = {
  for (final module in statusbarBoardModules) module.id: module,
};
