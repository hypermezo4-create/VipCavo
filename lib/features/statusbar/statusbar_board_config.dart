import 'package:flutter/material.dart';

enum StatusbarBoardSide { left, right }

class StatusbarBoardModule {
  const StatusbarBoardModule({
    required this.id,
    required this.label,
    required this.icon,
    required this.color,
    required this.defaultSide,
  });

  final String id;
  final String label;
  final IconData icon;
  final Color color;
  final StatusbarBoardSide defaultSide;
}

const List<StatusbarBoardModule> statusbarBoardModules = <StatusbarBoardModule>[
  StatusbarBoardModule(
    id: 'clock',
    label: '09:15',
    icon: Icons.access_time_rounded,
    color: Color(0xFF89F3A0),
    defaultSide: StatusbarBoardSide.left,
  ),
  StatusbarBoardModule(
    id: 'date',
    label: '22 Apr',
    icon: Icons.calendar_month_rounded,
    color: Color(0xFFB7C6FF),
    defaultSide: StatusbarBoardSide.left,
  ),
  StatusbarBoardModule(
    id: 'speed',
    label: '1.3MB/s',
    icon: Icons.speed_rounded,
    color: Color(0xFF8DE8FF),
    defaultSide: StatusbarBoardSide.right,
  ),
  StatusbarBoardModule(
    id: 'network',
    label: '5G',
    icon: Icons.signal_cellular_alt_rounded,
    color: Colors.white70,
    defaultSide: StatusbarBoardSide.right,
  ),
  StatusbarBoardModule(
    id: 'battery',
    label: '84%',
    icon: Icons.battery_5_bar_rounded,
    color: Color(0xFF90FFAC),
    defaultSide: StatusbarBoardSide.right,
  ),
];
