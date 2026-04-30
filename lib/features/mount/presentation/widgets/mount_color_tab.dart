import 'package:deadzon/core/theme/deadzon_theme_controller.dart';
import 'package:deadzon/core/widgets/deadzone_settings_widgets.dart';
import 'package:deadzon/features/mount/domain/mount_config.dart';
import 'package:deadzon/features/mount/domain/mount_palette.dart';
import 'package:deadzon/features/mount/presentation/widgets/mount_glass_card.dart';
import 'package:flutter/material.dart';

class MountColorTab extends StatelessWidget {
  const MountColorTab({required this.config, required this.paletteLibrary, required this.onPaletteSelected, required this.onTapItem, super.key});

  final MountConfig config;
  final List<MountPalette> paletteLibrary;
  final ValueChanged<MountPalette> onPaletteSelected;
  final ValueChanged<String> onTapItem;

  @override
  Widget build(BuildContext context) {
    const curatedNames = <String>{
      'Default',
      'Mint Glass',
      'Graphite',
      'Sky',
      'Rose',
      'Lime',
      'Soft Gold',
      'Ocean',
      'Violet',
      'Carbon',
      'Midnight',
      'Slate',
      'Deep Blue',
      'Dark Teal',
    };
    final curatedPalettes = paletteLibrary.where((palette) => curatedNames.contains(palette.name)).toList();
    return Column(children: [
      MountGlassCard(
        tint: config.selectedColor,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const DeadZoneSectionHeader(title: 'Core colors'),
          _row('selectedColor', 'Primary accent', config.selectedColor, Icons.palette_rounded),
          _row('iconAccentColor', 'Icon accent', config.iconAccentColor, Icons.auto_awesome_rounded),
          _row('textAccentColor', 'Text accent', config.textAccentColor, Icons.text_fields_rounded),
          const DeadZoneSectionHeader(title: 'Backgrounds'),
          _row('backgroundDark', 'Dark background', const Color(0xFF0D1218), Icons.dark_mode_rounded),
          _row('backgroundLight', 'Light background', const Color(0xFFF3F7FB), Icons.light_mode_rounded),
          _row('cardBackgroundTint', 'Card surface', config.cardBackgroundTint, Icons.layers_rounded),
          const DeadZoneSectionHeader(title: 'Navigation'),
          _row('navSurface', 'Bottom nav surface', config.cardBackgroundTint.withValues(alpha: 0.9), Icons.space_dashboard_rounded),
          _row('navPill', 'Selected pill', config.selectedColor.withValues(alpha: 0.35), Icons.radio_button_checked_rounded),
          _row('navIcon', 'Selected icon/label', config.iconAccentColor, Icons.label_rounded),
          const DeadZoneSectionHeader(title: 'States'),
          _row('stateSuccess', 'Success', const Color(0xFF43C58D), Icons.check_circle_rounded),
          _row('stateWarning', 'Warning', const Color(0xFFE8B04E), Icons.warning_rounded),
          _row('stateError', 'Error', const Color(0xFFE46868), Icons.error_rounded),
        ]),
      ),
      const SizedBox(height: 12),
      MountGlassCard(
        tint: config.selectedColor,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const DeadZoneSectionHeader(title: 'Palette library'),
          Wrap(spacing: 8, runSpacing: 8, children: curatedPalettes.map((p) => FilterChip(selected: config.selectedPaletteId == p.id, label: Text(p.name), onSelected: (_) => onPaletteSelected(p), selectedColor: p.primary.withValues(alpha: 0.35), backgroundColor: DeadzonThemeTokens.cardBackground(context), labelStyle: TextStyle(color: DeadzonThemeTokens.textPrimary(context)))).toList()),
        ]),
      ),
    ]);
  }

  Widget _row(String key, String title, Color color, IconData icon) => Builder(
        builder: (context) => DeadZoneNavigationRow(
          icon: icon,
          title: title,
          subtitle: '#${color.toARGB32().toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}',
          onTap: () => onTapItem(key),
          trailing: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: DeadzonThemeTokens.border(context)),
            ),
          ),
        ),
      );
}
