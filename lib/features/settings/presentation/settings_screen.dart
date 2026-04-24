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

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
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
            const PremiumTopBar(title: 'Settings', subtitle: 'Appearance, palette, build details and resets'),
            const SizedBox(height: 14),
            GlassCard(
              child: Column(
                children: <Widget>[
                  SettingsRow(
                    icon: Icons.dark_mode_rounded,
                    iconColor: theme.iconAccentColor,
                    title: 'Theme mode',
                    subtitle: 'System, light, or dark',
                    trailing: DropdownButton<ThemeMode>(
                      value: theme.themeMode,
                      dropdownColor: const Color(0xFF12242B),
                      items: const <DropdownMenuItem<ThemeMode>>[
                        DropdownMenuItem(value: ThemeMode.system, child: Text('System')),
                        DropdownMenuItem(value: ThemeMode.light, child: Text('Light')),
                        DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
                      ],
                      onChanged: (mode) {
                        if (mode == null) return;
                        context.read<DeadzonThemeController>().setThemeMode(mode);
                      },
                    ),
                  ),
                  const Divider(height: 22),
                  SettingsRow(
                    icon: Icons.palette_rounded,
                    iconColor: theme.accentColor,
                    title: 'UI palette',
                    subtitle: 'Global accent from Mount Studio',
                    trailing: const Icon(Icons.color_lens_outlined, color: Colors.white70),
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
                subtitle: 'Reset app visual settings safely',
                onTap: () => _showResetDialog(context),
                trailing: const Icon(Icons.chevron_right_rounded, color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showResetDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Reset Deadzon settings'),
          content: const Text('This will restore visual preferences in this alpha build.'),
          actions: <Widget>[
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Reset complete.'), behavior: SnackBarBehavior.floating),
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
