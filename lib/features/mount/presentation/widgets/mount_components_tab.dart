import 'package:deadzon/core/theme/deadzon_theme_controller.dart';
import 'package:deadzon/features/mount/domain/mount_config.dart';
import 'package:deadzon/features/mount/presentation/widgets/mount_glass_card.dart';
import 'package:flutter/material.dart';

class MountComponentsTab extends StatelessWidget {
  const MountComponentsTab({required this.config, required this.onTapItem, super.key});

  final MountConfig config;
  final ValueChanged<String> onTapItem;

  @override
  Widget build(BuildContext context) {
    final items = <({String key, String title, Color color})>[
      (key: 'seekbarColor', title: 'Seekbar / Progressbar color', color: config.seekbarColor),
      (key: 'switchOnColor', title: 'Switch ON color', color: config.switchOnColor),
      (key: 'switchOffColor', title: 'Switch OFF color', color: config.switchOffColor),
      (key: 'checkboxOnColor', title: 'Checkbox ON color', color: config.checkboxOnColor),
      (key: 'checkboxOffColor', title: 'Checkbox OFF color', color: config.checkboxOffColor),
      (key: 'cardBackgroundTint', title: 'Card background tint', color: config.cardBackgroundTint),
      (key: 'iconAccentColor', title: 'Icon accent color', color: config.iconAccentColor),
      (key: 'textAccentColor', title: 'Text accent color', color: config.textAccentColor),
    ];

    return MountGlassCard(
      tint: config.selectedColor,
      child: Column(
        children: items
            .map(
              (item) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(item.title, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600)),
                leading: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: item.color,
                    shape: BoxShape.circle,
                    border: Border.all(color: DeadzonThemeTokens.border(context)),
                  ),
                ),
                trailing: Icon(Icons.chevron_right_rounded, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7)),
                onTap: () => onTapItem(item.key),
              ),
            )
            .toList(),
      ),
    );
  }
}
