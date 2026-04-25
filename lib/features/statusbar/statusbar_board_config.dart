import 'package:flutter/material.dart';

enum StatusbarBoardSide { left, center, right }

enum StatusbarVisibilityType { boolFlag, intAsVisible }

class StatusbarBoardModule {
  const StatusbarBoardModule({
    required this.id,
    required this.title,
    required this.previewLabel,
    required this.icon,
    required this.iconAsset,
    required this.color,
    required this.sourceSmaliClass,
    required this.category,
    required this.defaultSide,
    required this.defaultOrderIndex,
    required this.visibilityKey,
    required this.sideKey,
    required this.orderKey,
    required this.offsetKey,
    this.defaultRow = 1,
    this.defaultVisible = true,
    this.defaultEnabled = true,
    this.defaultOffset = 0,
    this.defaultSize = 1.0,
    this.defaultOffsetY = 0,
    this.sizeKey,
    this.rowKey,
    this.enabledKey,
    this.offsetYKey,
    this.visibilityType = StatusbarVisibilityType.boolFlag,
  });

  final String id;
  final String title;
  final String previewLabel;
  final IconData icon;
  final String iconAsset;
  final Color color;
  final String sourceSmaliClass;
  final String category;
  final StatusbarBoardSide defaultSide;
  final int defaultOrderIndex;
  final int defaultRow;
  final String visibilityKey;
  final String sideKey;
  final String orderKey;
  final String offsetKey;
  final String? rowKey;
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

const String statusbarBoardLeftClusterOffsetKey = 'status_bar_element_left_cluster_offset';
const String statusbarBoardRightClusterOffsetKey = 'status_bar_element_right_cluster_offset';
const String statusbarBoardSourceDefaultLayout =
    'elem_status.33;elem_clock.21;elem_bat.31;elem_net1.1;elem_net2.11;elem_wifi.2;elem_notif.22;elem_speed.3;elem_weather.32;elem_date.12;';

const List<StatusbarBoardModule> statusbarBoardModules = <StatusbarBoardModule>[
  StatusbarBoardModule(id: 'elem_status', title: 'Status icons', previewLabel: 'BT • Alarm', icon: Icons.widgets_rounded, iconAsset: 'reference/mezo/mezo/res/drawable-xxxhdpi/elem_status_card.png', color: Color(0xFFA9F4E0), sourceSmaliClass: 'StatusBarElementStatus', category: 'Status icons', defaultSide: StatusbarBoardSide.right, defaultOrderIndex: 0, visibilityKey: 'elem_status_element_visible', sideKey: 'status_bar_element_status_side', orderKey: 'status_bar_element_status_order', offsetKey: 'status_icon_division'),
  StatusbarBoardModule(id: 'elem_clock', title: 'Clock', previewLabel: '09:41', icon: Icons.access_time_rounded, iconAsset: 'reference/mezo/mezo/res/drawable-xxxhdpi/elem_clock_card.png', color: Color(0xFF89F3A0), sourceSmaliClass: 'StatusBarElementClock', category: 'Clock', defaultSide: StatusbarBoardSide.left, defaultOrderIndex: 0, visibilityKey: 'elem_clock_element_visible', sideKey: 'status_bar_element_clock_side', orderKey: 'status_bar_element_clock_order', offsetKey: 'status_clock_division'),
  StatusbarBoardModule(id: 'elem_bat', title: 'Battery', previewLabel: '84%', icon: Icons.battery_5_bar_rounded, iconAsset: 'reference/mezo/mezo/res/drawable-xxxhdpi/elem_bat_card.png', color: Color(0xFF90FFAC), sourceSmaliClass: 'StatusBarElementBat', category: 'Battery', defaultSide: StatusbarBoardSide.right, defaultOrderIndex: 1, visibilityKey: 'elem_bat_element_visible', sideKey: 'status_bar_element_bat_side', orderKey: 'status_bar_element_bat_order', offsetKey: 'batteryview_division'),
  StatusbarBoardModule(id: 'elem_net1', title: 'Network left', previewLabel: '5G', icon: Icons.network_cell_rounded, iconAsset: 'reference/mezo/mezo/res/drawable-xxxhdpi/elem_net_card.png', color: Color(0xFF9AB2FF), sourceSmaliClass: 'StatusBarElementNetOne', category: 'Network', defaultSide: StatusbarBoardSide.left, defaultOrderIndex: 1, visibilityKey: 'elem_net1_element_visible', sideKey: 'status_bar_element_net1_side', orderKey: 'status_bar_element_net1_order', offsetKey: 'network_one_division'),
  StatusbarBoardModule(id: 'elem_net2', title: 'Network right', previewLabel: 'LTE', icon: Icons.network_cell_rounded, iconAsset: 'reference/mezo/mezo/res/drawable-xxxhdpi/elem_net_card.png', color: Color(0xFF9AB2FF), sourceSmaliClass: 'StatusBarElementNetTwo', category: 'Network', defaultSide: StatusbarBoardSide.left, defaultOrderIndex: 2, visibilityKey: 'elem_net2_element_visible', sideKey: 'status_bar_element_net2_side', orderKey: 'status_bar_element_net2_order', offsetKey: 'network_two_division'),
  StatusbarBoardModule(id: 'elem_wifi', title: 'Wifi', previewLabel: 'Wi-Fi', icon: Icons.wifi_rounded, iconAsset: 'reference/mezo/mezo/res/drawable-xxxhdpi/elem_net_card.png', color: Color(0xFF9AB2FF), sourceSmaliClass: 'StatusBarElementWifi', category: 'Wifi', defaultSide: StatusbarBoardSide.right, defaultOrderIndex: 2, visibilityKey: 'elem_wifi_element_visible', sideKey: 'status_bar_element_wifi_side', orderKey: 'status_bar_element_wifi_order', offsetKey: 'status_bar_element_wifi_offset'),
  StatusbarBoardModule(id: 'elem_notif', title: 'Notification icons', previewLabel: 'Alerts', icon: Icons.notifications_rounded, iconAsset: 'reference/mezo/mezo/res/drawable-xxxhdpi/elem_notif_card.png', color: Color(0xFFFFBE87), sourceSmaliClass: 'StatusBarElementNotif', category: 'Notification icons', defaultSide: StatusbarBoardSide.right, defaultOrderIndex: 3, visibilityKey: 'status_bar_show_notification_icon', sideKey: 'status_bar_element_notif_side', orderKey: 'status_bar_element_notif_order', offsetKey: 'notif_icon_division', visibilityType: StatusbarVisibilityType.intAsVisible),
  StatusbarBoardModule(id: 'elem_speed', title: 'Netspeed', previewLabel: '1.3MB/s', icon: Icons.speed_rounded, iconAsset: 'reference/mezo/mezo/res/drawable-xxxhdpi/elem_speed_card.png', color: Color(0xFF8DE8FF), sourceSmaliClass: 'StatusBarElementSpeed', category: 'Netspeed', defaultSide: StatusbarBoardSide.right, defaultOrderIndex: 4, visibilityKey: 'status_bar_show_network_speed', sideKey: 'status_bar_element_speed_side', orderKey: 'status_bar_element_speed_order', offsetKey: 'net_speed_division', visibilityType: StatusbarVisibilityType.intAsVisible),
  StatusbarBoardModule(id: 'elem_weather', title: 'Weather', previewLabel: '28°', icon: Icons.wb_sunny_rounded, iconAsset: 'reference/mezo/mezo/res/drawable-xxxhdpi/elem_weather_card.png', color: Color(0xFF8DE8FF), sourceSmaliClass: 'StatusBarElementWeather', category: 'Weather', defaultSide: StatusbarBoardSide.right, defaultOrderIndex: 5, visibilityKey: 'elem_weather_element_visible', sideKey: 'status_bar_element_weather_side', orderKey: 'status_bar_element_weather_order', offsetKey: 'status_weather_division'),
  StatusbarBoardModule(id: 'elem_date', title: 'Date', previewLabel: 'Thu 23', icon: Icons.calendar_month_rounded, iconAsset: 'reference/mezo/mezo/res/drawable-xxxhdpi/elem_date_card.png', color: Color(0xFFB7C6FF), sourceSmaliClass: 'StatusBarElementDate', category: 'Date', defaultSide: StatusbarBoardSide.right, defaultOrderIndex: 6, visibilityKey: 'elem_date_element_visible', sideKey: 'status_bar_element_date_side', orderKey: 'status_bar_element_date_order', offsetKey: 'status_date_division'),
];
