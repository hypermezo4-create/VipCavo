import 'package:flutter/material.dart';

enum StatusbarBoardSide { left, right }

enum StatusbarVisibilityType { boolFlag, intAsVisible }

class StatusbarBoardModule {
  const StatusbarBoardModule({
    required this.id,
    required this.title,
    required this.previewLabel,
    required this.icon,
    required this.color,
    required this.defaultSide,
    required this.visibilityKey,
    required this.sideKey,
    required this.orderKey,
    required this.offsetKey,
    this.defaultVisible = true,
    this.defaultOffset = 0,
    this.visibilityType = StatusbarVisibilityType.boolFlag,
  });

  final String id;
  final String title;
  final String previewLabel;
  final IconData icon;
  final Color color;
  final StatusbarBoardSide defaultSide;
  final String visibilityKey;
  final String sideKey;
  final String orderKey;
  final String offsetKey;
  final bool defaultVisible;
  final double defaultOffset;
  final StatusbarVisibilityType visibilityType;
}

const String statusbarBoardLeftClusterOffsetKey = 'status_bar_element_left_cluster_offset';
const String statusbarBoardRightClusterOffsetKey = 'status_bar_element_right_cluster_offset';

const List<StatusbarBoardModule> statusbarBoardModules = <StatusbarBoardModule>[
  StatusbarBoardModule(
    id: 'clock',
    title: 'Clock',
    previewLabel: '09:41',
    icon: Icons.access_time_rounded,
    color: Color(0xFF89F3A0),
    defaultSide: StatusbarBoardSide.left,
    visibilityKey: 'elem_clock_element_visible',
    sideKey: 'status_bar_element_clock_side',
    orderKey: 'status_bar_element_clock_order',
    offsetKey: 'status_clock_division',
  ),
  StatusbarBoardModule(
    id: 'battery',
    title: 'Battery',
    previewLabel: '84%',
    icon: Icons.battery_5_bar_rounded,
    color: Color(0xFF90FFAC),
    defaultSide: StatusbarBoardSide.right,
    visibilityKey: 'elem_bat_element_visible',
    sideKey: 'status_bar_element_bat_side',
    orderKey: 'status_bar_element_bat_order',
    offsetKey: 'batteryview_division',
  ),
  StatusbarBoardModule(
    id: 'netspeed',
    title: 'Netspeed',
    previewLabel: '1.3MB/s',
    icon: Icons.speed_rounded,
    color: Color(0xFF8DE8FF),
    defaultSide: StatusbarBoardSide.right,
    visibilityKey: 'status_bar_show_network_speed',
    sideKey: 'status_bar_element_speed_side',
    orderKey: 'status_bar_element_speed_order',
    offsetKey: 'net_speed_division',
    visibilityType: StatusbarVisibilityType.intAsVisible,
  ),
  StatusbarBoardModule(
    id: 'network',
    title: 'Network',
    previewLabel: '5G • Wi-Fi',
    icon: Icons.signal_cellular_alt_rounded,
    color: Colors.white70,
    defaultSide: StatusbarBoardSide.right,
    visibilityKey: 'elem_net_element_visible',
    sideKey: 'status_bar_element_network_side',
    orderKey: 'status_bar_element_network_order',
    offsetKey: 'status_bar_element_network_offset',
  ),
  StatusbarBoardModule(
    id: 'notification_icons',
    title: 'Notification icons',
    previewLabel: 'Alerts',
    icon: Icons.notifications_rounded,
    color: Color(0xFFFFBE87),
    defaultSide: StatusbarBoardSide.right,
    visibilityKey: 'status_bar_show_notification_icon',
    sideKey: 'status_bar_element_notif_side',
    orderKey: 'status_bar_element_notif_order',
    offsetKey: 'notif_icon_division',
    visibilityType: StatusbarVisibilityType.intAsVisible,
  ),
  StatusbarBoardModule(
    id: 'status_icons',
    title: 'Status icons',
    previewLabel: 'BT • Alarm',
    icon: Icons.widgets_rounded,
    color: Color(0xFFA9F4E0),
    defaultSide: StatusbarBoardSide.right,
    visibilityKey: 'elem_status_element_visible',
    sideKey: 'status_bar_element_status_side',
    orderKey: 'status_bar_element_status_order',
    offsetKey: 'status_icon_division',
  ),
  StatusbarBoardModule(
    id: 'date',
    title: 'Date',
    previewLabel: 'Thu 23',
    icon: Icons.calendar_month_rounded,
    color: Color(0xFFB7C6FF),
    defaultSide: StatusbarBoardSide.left,
    visibilityKey: 'elem_date_element_visible',
    sideKey: 'status_bar_element_date_side',
    orderKey: 'status_bar_element_date_order',
    offsetKey: 'status_date_division',
    defaultVisible: false,
  ),
  StatusbarBoardModule(
    id: 'weather',
    title: 'Weather',
    previewLabel: '28° Clear',
    icon: Icons.wb_sunny_rounded,
    color: Color(0xFF8DE8FF),
    defaultSide: StatusbarBoardSide.left,
    visibilityKey: 'elem_weather_element_visible',
    sideKey: 'status_bar_element_weather_side',
    orderKey: 'status_bar_element_weather_order',
    offsetKey: 'status_weather_division',
  ),
  StatusbarBoardModule(
    id: 'prompt_icon',
    title: 'Prompt icon',
    previewLabel: 'Prompt',
    icon: Icons.chat_bubble_outline_rounded,
    color: Color(0xFFE2B4FF),
    defaultSide: StatusbarBoardSide.right,
    visibilityKey: 'elem_prompt_element_visible',
    sideKey: 'status_bar_element_prompt_side',
    orderKey: 'status_bar_element_prompt_order',
    offsetKey: 'elem_prompt_division',
  ),
];
