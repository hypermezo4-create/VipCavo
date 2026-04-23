import 'package:flutter/material.dart';

enum StatusbarBoardSide { left, right }

class StatusbarBoardModule {
  const StatusbarBoardModule({
    required this.id,
    required this.title,
    required this.previewLabel,
    required this.icon,
    required this.color,
    required this.defaultSide,
    this.defaultSpacing = 0,
  });

  final String id;
  final String title;
  final String previewLabel;
  final IconData icon;
  final Color color;
  final StatusbarBoardSide defaultSide;
  final double defaultSpacing;
}

const List<StatusbarBoardModule> statusbarBoardModules = <StatusbarBoardModule>[
  StatusbarBoardModule(
    id: 'clock',
    title: 'Clock',
    previewLabel: '09:41',
    icon: Icons.access_time_rounded,
    color: Color(0xFF89F3A0),
    defaultSide: StatusbarBoardSide.left,
  ),
  StatusbarBoardModule(
    id: 'date',
    title: 'Date',
    previewLabel: 'Thu 23',
    icon: Icons.calendar_month_rounded,
    color: Color(0xFFB7C6FF),
    defaultSide: StatusbarBoardSide.left,
  ),
  StatusbarBoardModule(
    id: 'weather',
    title: 'Weather',
    previewLabel: '28° Clear',
    icon: Icons.wb_sunny_rounded,
    color: Color(0xFF8DE8FF),
    defaultSide: StatusbarBoardSide.left,
  ),
  StatusbarBoardModule(
    id: 'netspeed',
    title: 'Netspeed',
    previewLabel: '1.3MB/s',
    icon: Icons.speed_rounded,
    color: Color(0xFF8DE8FF),
    defaultSide: StatusbarBoardSide.right,
  ),
  StatusbarBoardModule(
    id: 'notification_icons',
    title: 'Notification',
    previewLabel: 'Alerts',
    icon: Icons.notifications_rounded,
    color: Color(0xFFFFBE87),
    defaultSide: StatusbarBoardSide.right,
  ),
  StatusbarBoardModule(
    id: 'network',
    title: 'Network',
    previewLabel: '5G • Wi-Fi',
    icon: Icons.signal_cellular_alt_rounded,
    color: Colors.white70,
    defaultSide: StatusbarBoardSide.right,
  ),
  StatusbarBoardModule(
    id: 'status_icons',
    title: 'Status icons',
    previewLabel: 'BT • Alarm',
    icon: Icons.widgets_rounded,
    color: Color(0xFFA9F4E0),
    defaultSide: StatusbarBoardSide.right,
  ),
  StatusbarBoardModule(
    id: 'prompt_icon',
    title: 'Prompt',
    previewLabel: 'Prompt',
    icon: Icons.chat_bubble_outline_rounded,
    color: Color(0xFFE2B4FF),
    defaultSide: StatusbarBoardSide.right,
  ),
  StatusbarBoardModule(
    id: 'battery',
    title: 'Battery',
    previewLabel: '84%',
    icon: Icons.battery_5_bar_rounded,
    color: Color(0xFF90FFAC),
    defaultSide: StatusbarBoardSide.right,
  ),
];
