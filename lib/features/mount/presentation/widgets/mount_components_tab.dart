import 'package:deadzon/core/widgets/deadzone_settings_widgets.dart';
import 'package:deadzon/features/mount/domain/mount_config.dart';
import 'package:deadzon/features/mount/presentation/widgets/mount_glass_card.dart';
import 'package:flutter/material.dart';

class MountComponentsTab extends StatelessWidget {
  const MountComponentsTab({required this.config, required this.onTapItem, super.key});

  final MountConfig config;
  final ValueChanged<String> onTapItem;

  @override
  Widget build(BuildContext context) {
    final items = <({String key, String title, Color color, IconData icon})>[
      (key: 'seekbarColor', title: 'Seekbar / Progressbar color', color: config.seekbarColor, icon: Icons.tune_rounded),
      (key: 'seekbarInactiveColor', title: 'Seekbar inactive color', color: config.componentColors['seekbarInactiveColor'] != null ? Color(config.componentColors['seekbarInactiveColor']!) : config.seekbarColor.withValues(alpha: 0.35), icon: Icons.linear_scale_rounded),
      (key: 'seekbarThumbColor', title: 'Seekbar thumb color', color: config.componentColors['seekbarThumbColor'] != null ? Color(config.componentColors['seekbarThumbColor']!) : config.seekbarColor, icon: Icons.circle_rounded),
      (key: 'switchOnColor', title: 'Switch ON color', color: config.switchOnColor, icon: Icons.toggle_on_rounded),
      (key: 'switchOffColor', title: 'Switch OFF color', color: config.switchOffColor, icon: Icons.toggle_off_rounded),
      (key: 'checkboxOnColor', title: 'Checkbox active color', color: config.checkboxOnColor, icon: Icons.check_box_rounded),
      (key: 'checkboxOffColor', title: 'Checkbox inactive color', color: config.checkboxOffColor, icon: Icons.check_box_outline_blank_rounded),
      (key: 'cardBackgroundTint', title: 'Card tint color', color: config.cardBackgroundTint, icon: Icons.style_rounded),
      (key: 'cardBorderColor', title: 'Card border color', color: config.componentColors['cardBorderColor'] != null ? Color(config.componentColors['cardBorderColor']!) : Colors.white24, icon: Icons.crop_square_rounded),
      (key: 'iconAccentColor', title: 'Icon chip color', color: config.iconAccentColor, icon: Icons.bubble_chart_rounded),
      (key: 'shadowColor', title: 'Shadow color', color: config.componentColors['shadowColor'] != null ? Color(config.componentColors['shadowColor']!) : Colors.black54, icon: Icons.blur_on_rounded),
    ];

    return MountGlassCard(
      tint: config.selectedColor,
      child: Column(children: items.map((item) => DeadZoneColorRow(icon: item.icon, title: item.title, argb: item.color.toARGB32(), onTap: () => onTapItem(item.key))).toList()),
    );
  }
}
