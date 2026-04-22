import 'package:deadzon/core/constants/app_identity.dart';
import 'package:deadzon/core/theme/app_theme.dart';
import 'package:deadzon/core/widgets/glass_card.dart';
import 'package:deadzon/core/widgets/premium_top_bar.dart';
import 'package:deadzon/core/widgets/settings_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

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
                    iconColor: const Color(0xFF8CEFD2),
                    title: 'Theme mode',
                    subtitle: 'System, light, or dark',
                    trailing: DropdownButton<ThemeMode>(
                      value: themeMode,
                      dropdownColor: const Color(0xFF12242B),
                      items: const <DropdownMenuItem<ThemeMode>>[
                        DropdownMenuItem(value: ThemeMode.system, child: Text('System')),
                        DropdownMenuItem(value: ThemeMode.light, child: Text('Light')),
                        DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
                      ],
                      onChanged: (mode) {
                        if (mode == null) return;
                        ref.read(themeModeProvider.notifier).setMode(mode);
                      },
                    ),
                  ),
                  const Divider(height: 22),
                  const SettingsRow(
                    icon: Icons.palette_rounded,
                    iconColor: Color(0xFFA992FF),
                    title: 'UI palette',
                    subtitle: 'Blue/green premium glass language',
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
