import 'package:deadzon/core/constants/app_identity.dart';
import 'package:deadzon/core/theme/deadzon_theme_controller.dart';
import 'package:deadzon/core/theme/design_tokens.dart';
import 'package:deadzon/core/widgets/deadzone_settings_widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
                  DeadZoneNavigationRow(icon: Icons.settings_rounded, title: 'Settings', subtitle: 'General preferences', onTap: () {}, trailing: DeadZoneValueChip(label: AppIdentity.currentTrack)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            DeadZoneSettingsCard(
              child: Column(
                children: <Widget>[
                  const DeadZoneSectionHeader(title: 'Preferences'),
                  DeadZoneSelectRow(icon: Icons.dark_mode_rounded, title: 'Theme', valueLabel: _modeSummary(theme.themeMode), onTap: () => _showThemePicker(context, theme)),
                  DeadZoneNavigationRow(
                    icon: Icons.tune_rounded,
                    title: 'Customize appearance',
                    subtitle: 'Open DeadZone Mount Studio',
                    onTap: () => context.push('/mount'),
                    trailing: Icon(Icons.chevron_right_rounded, color: DeadzonThemeTokens.iconAccent(context).withValues(alpha: 0.74)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            DeadZoneSettingsCard(
              child: Column(children: <Widget>[
                const DeadZoneSectionHeader(title: 'Reset'),
                DeadZoneNavigationRow(icon: Icons.restart_alt_rounded, title: 'Reset App Settings', subtitle: 'Restore only app preferences', onTap: () => _showResetAppDialog(context)),
                DeadZoneNavigationRow(icon: Icons.restore_rounded, title: 'Reset Deadzon Customizations', subtitle: 'No system partition edits in app phase', onTap: () => _showResetCustomizationsDialog(context)),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  static String _modeSummary(ThemeMode mode) => switch (mode) {ThemeMode.system => 'System', ThemeMode.light => 'Light', ThemeMode.dark => 'Dark'};

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
      actions: <Widget>[TextButton(onPressed: () => Navigator.of(context).maybePop(), child: const Text('Cancel')), FilledButton(onPressed: () async {Navigator.of(context).maybePop(); await context.read<DeadzonThemeController>().resetAppPreferences();}, child: const Text('Reset'))],
    ),
  );

  void _showResetCustomizationsDialog(BuildContext context) => showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Reset Deadzon Customizations'),
      content: const Text('This resets in-app customization values only.'),
      actions: <Widget>[TextButton(onPressed: () => Navigator.of(context).maybePop(), child: const Text('Cancel')), FilledButton(onPressed: () => Navigator.of(context).maybePop(), child: const Text('OK'))],
    ),
  );
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
          Text(title, style: TextStyle(fontSize: DesignTokens.sectionTitle, fontWeight: FontWeight.w700, color: DeadzonThemeTokens.textPrimary(context))),
          const SizedBox(height: 10),
          ...options.map((option) => ListTile(contentPadding: EdgeInsets.zero, title: Text(option.label, style: TextStyle(color: DeadzonThemeTokens.textPrimary(context))), trailing: Icon(option.value == selected ? Icons.check_circle_rounded : Icons.circle_outlined, color: option.value == selected ? DeadzonThemeTokens.checkboxActive(context) : DeadzonThemeTokens.checkboxInactive(context)), onTap: () => Navigator.of(context).maybePop(option.value))),
        ]),
      ),
    );
  }
}
