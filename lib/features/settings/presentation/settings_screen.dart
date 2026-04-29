import 'package:deadzon/core/constants/app_identity.dart';
import 'package:deadzon/core/theme/deadzon_theme_controller.dart';
import 'package:deadzon/core/theme/design_tokens.dart';
import 'package:deadzon/core/widgets/deadzone_settings_widgets.dart';
import 'package:deadzon/features/settings/presentation/widgets/deadzone_color_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<DeadzonThemeController>();
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            DeadzonThemeTokens.appBackground(context),
            DeadzonThemeTokens.pageBackground(context),
            DeadzonThemeTokens.pageBackground(context).withValues(alpha: 0.94),
          ],
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(14, 10, 14, MediaQuery.paddingOf(context).bottom + 116),
          children: <Widget>[
            DeadZoneSettingsCard(
              child: Column(
                children: <Widget>[
                  DeadZoneNavigationRow(
                    icon: Icons.settings_rounded,
                    title: 'Settings',
                    subtitle: 'Appearance & preferences',
                    onTap: () {},
                    trailing: DeadZoneValueChip(label: AppIdentity.currentTrack),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            DeadZoneSettingsCard(
              child: Column(
                children: <Widget>[
                  const DeadZoneSectionHeader(title: 'Appearance'),
                  DeadZoneSelectRow(
                    icon: Icons.dark_mode_rounded,
                    title: 'Theme',
                    valueLabel: _modeSummary(theme.themeMode),
                    onTap: () => _showThemePicker(context, theme),
                  ),
                  DeadZoneColorRow(
                    icon: Icons.palette_rounded,
                    title: 'Primary color',
                    subtitle: theme.selectedAccent.label,
                    color: theme.selectedAccent.color,
                    onTap: () => _pickColor(context, title: 'Accent Color', options: DeadzonThemeController.accentOptions, selectedId: theme.selectedAccentId, onSelected: theme.setAccentColor),
                  ),
                  DeadZoneSelectRow(
                    icon: Icons.light_mode_rounded,
                    title: 'Light UI palette',
                    valueLabel: theme.selectedLightPalette.label,
                    onTap: () => _pickColor(context, title: 'Light UI Palette', options: DeadzonThemeController.lightPaletteOptions, selectedId: theme.selectedLightPaletteId, onSelected: theme.setLightPalette),
                  ),
                  DeadZoneSelectRow(
                    icon: Icons.nights_stay_rounded,
                    title: 'Dark UI palette',
                    valueLabel: theme.selectedDarkPalette.label,
                    onTap: () => _pickColor(context, title: 'Dark UI Palette', options: DeadzonThemeController.darkPaletteOptions, selectedId: theme.selectedDarkPaletteId, onSelected: theme.setDarkPalette),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 12),
          DeadZoneSettingsCard(
            child: Column(children: <Widget>[
              const DeadZoneSectionHeader(title: 'Backgrounds'),
              DeadZoneColorRow(
                icon: Icons.sunny_rounded,
                title: 'Light background',
                subtitle: theme.selectedLightBackground.label,
                color: theme.selectedLightBackground.color,
                onTap: () => _pickColor(context, title: 'Light Background Color', options: DeadzonThemeController.lightBackgroundOptions, selectedId: theme.selectedLightBackgroundId, onSelected: theme.setLightBackground),
              ),
              DeadZoneColorRow(
                icon: Icons.brightness_2_rounded,
                title: 'Dark background',
                subtitle: theme.selectedDarkBackground.label,
                color: theme.selectedDarkBackground.color,
                onTap: () => _pickColor(context, title: 'Dark Background Color', options: DeadzonThemeController.darkBackgroundOptions, selectedId: theme.selectedDarkBackgroundId, onSelected: theme.setDarkBackground),
              ),
            ]),
          ),
          const SizedBox(height: 12),
          DeadZoneSettingsCard(
            child: Column(children: <Widget>[
              const DeadZoneSectionHeader(title: 'Reset'),
              DeadZoneNavigationRow(icon: Icons.restart_alt_rounded, title: 'Reset App Settings', subtitle: 'Restore only app preferences', onTap: () => _showResetAppDialog(context)),
              DeadZoneNavigationRow(icon: Icons.restore_rounded, title: 'Reset Deadzon Customizations', subtitle: 'No system partition edits in app phase', onTap: () => _showResetCustomizationsDialog(context)),
            ]),
          ),
        ]),
      ),
    );
  }

  static String _modeSummary(ThemeMode mode) => switch (mode) {ThemeMode.system => 'System', ThemeMode.light => 'Light', ThemeMode.dark => 'Dark'};

  Future<void> _pickColor(BuildContext context, {required String title, required List<DeadzoneColorOption> options, required String selectedId, required Future<void> Function(String id) onSelected}) async {
    final picked = await showDialog<String>(context: context, builder: (context) => DeadZoneColorPickerDialog(title: title, options: options, selectedId: selectedId));
    if (picked != null) await onSelected(picked);
  }

  Future<void> _showThemePicker(BuildContext context, DeadzonThemeController controller) async {
    final selected = await showModalBottomSheet<ThemeMode>(
      context: context,
      backgroundColor: DeadzonThemeTokens.sheetBackground(context),
      builder: (context) => DeadZoneOptionSheet<ThemeMode>(
        title: 'Theme mode',
        options: const <DeadZoneOptionItem<ThemeMode>>[
          DeadZoneOptionItem(value: ThemeMode.system, label: 'System'),
          DeadZoneOptionItem(value: ThemeMode.light, label: 'Light'),
          DeadZoneOptionItem(value: ThemeMode.dark, label: 'Dark'),
        ],
        selected: controller.themeMode,
      ),
    );
    if (selected != null) await controller.setThemeMode(selected);
  }

  void _showResetAppDialog(BuildContext context) => showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Reset App Settings'),
      content: const Text('Reset app preferences to defaults?'),
      actions: <Widget>[TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')), FilledButton(onPressed: () async {Navigator.pop(context); await context.read<DeadzonThemeController>().resetAppPreferences();}, child: const Text('Reset'))],
    ),
  );

  void _showResetCustomizationsDialog(BuildContext context) => showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Reset Deadzon Customizations'),
      content: const Text('This resets in-app customization values only.'),
      actions: <Widget>[TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')), FilledButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
    ),
  );
}

class DeadZoneColorRow extends StatelessWidget {
  const DeadZoneColorRow({required this.icon, required this.title, required this.subtitle, required this.color, required this.onTap, super.key});
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return DeadZoneNavigationRow(icon: icon, title: title, subtitle: subtitle, onTap: onTap, trailing: Container(width: 22, height: 22, decoration: BoxDecoration(color: color, shape: BoxShape.circle, border: Border.all(color: Theme.of(context).dividerColor))));
  }
}

class DeadZoneOptionItem<T> {
  const DeadZoneOptionItem({required this.value, required this.label});
  final T value;
  final String label;
}

class DeadZoneOptionSheet<T> extends StatelessWidget {
  const DeadZoneOptionSheet({required this.title, required this.options, required this.selected, super.key});
  final String title;
  final List<DeadZoneOptionItem<T>> options;
  final T selected;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Text(title, style: const TextStyle(fontSize: DesignTokens.sectionTitle, fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          ...options.map((option) => ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(option.label),
            trailing: Icon(option.value == selected ? Icons.check_circle_rounded : Icons.circle_outlined),
            onTap: () => Navigator.pop(context, option.value),
          )),
        ]),
      ),
    );
  }
}
