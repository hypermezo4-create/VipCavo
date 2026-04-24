import 'package:deadzon/core/constants/app_identity.dart';
import 'package:deadzon/core/theme/deadzon_theme_controller.dart';
import 'package:deadzon/core/widgets/glass_card.dart';
import 'package:deadzon/core/widgets/premium_top_bar.dart';
import 'package:deadzon/core/widgets/settings_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<DeadzonThemeController>();
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Container(
      decoration: BoxDecoration(
        gradient: isLight
            ? const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color(0xFFF3FAFC), Color(0xFFEDF6F8), Color(0xFFE8F1F5)],
              )
            : const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color(0xFF142D35), Color(0xFF102229), Color(0xFF0B1418)],
              ),
      ),
      child: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 120),
          children: <Widget>[
            const PremiumTopBar(title: 'Settings', subtitle: 'Appearance, palette, build details'),
            const SizedBox(height: 14),
            GlassCard(
              child: Column(
                children: <Widget>[
                  SettingsRow(
                    icon: Icons.dark_mode_rounded,
                    iconColor: theme.iconAccentColor,
                    title: 'Theme mode',
                    subtitle: _modeSummary(theme.themeMode),
                    trailing: const Icon(Icons.keyboard_arrow_down_rounded),
                    onTap: () => _showThemePicker(context, theme),
                  ),
                  const Divider(height: 22),
                  SettingsRow(
                    icon: Icons.palette_rounded,
                    iconColor: theme.accentColor,
                    title: 'UI palette',
                    subtitle: 'Global accent from Mount Studio',
                    trailing: _AccentChip(color: theme.accentColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            GlassCard(
              child: const Column(
                children: <Widget>[
                  SettingsRow(
                    icon: Icons.info_rounded,
                    iconColor: Color(0xFF79C8FF),
                    title: AppIdentity.appName,
                    subtitle: '${AppIdentity.developer} • ${AppIdentity.buildLabel}',
                  ),
                  Divider(height: 22),
                  SettingsRow(
                    icon: Icons.memory_rounded,
                    iconColor: Color(0xFF8EF0C1),
                    title: AppIdentity.romLabel,
                    subtitle: AppIdentity.versionLabel,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            GlassCard(
              child: SettingsRow(
                icon: Icons.restart_alt_rounded,
                iconColor: const Color(0xFFFF9C9C),
                title: 'Reset dialogs',
                subtitle: 'Reset visual and theme settings safely',
                onTap: () => _showResetDialog(context),
                trailing: const Icon(Icons.chevron_right_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _modeSummary(ThemeMode mode) {
    return switch (mode) {
      ThemeMode.system => 'System',
      ThemeMode.light => 'Light',
      ThemeMode.dark => 'Dark',
    };
  }

  Future<void> _showThemePicker(BuildContext context, DeadzonThemeController controller) async {
    final selected = await showModalBottomSheet<ThemeMode>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RadioListTile<ThemeMode>(
                value: ThemeMode.system,
                groupValue: controller.themeMode,
                title: const Text('System'),
                onChanged: (value) => Navigator.pop(context, value),
              ),
              RadioListTile<ThemeMode>(
                value: ThemeMode.light,
                groupValue: controller.themeMode,
                title: const Text('Light'),
                onChanged: (value) => Navigator.pop(context, value),
              ),
              RadioListTile<ThemeMode>(
                value: ThemeMode.dark,
                groupValue: controller.themeMode,
                title: const Text('Dark'),
                onChanged: (value) => Navigator.pop(context, value),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );

    if (selected != null) {
      await controller.setThemeMode(selected);
    }
  }

  void _showResetDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Reset visual settings'),
          content: const Text('This resets DeadZon appearance preferences (theme mode). Mount palette remains intact.'),
          actions: <Widget>[
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            FilledButton(
              onPressed: () async {
                Navigator.pop(context);
                await context.read<DeadzonThemeController>().setThemeMode(ThemeMode.system);
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Visual settings reset complete.'), behavior: SnackBarBehavior.floating),
                );
              },
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );
  }
}

class _AccentChip extends StatelessWidget {
  const _AccentChip({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withValues(alpha: 0.7)),
      ),
    );
  }
}
