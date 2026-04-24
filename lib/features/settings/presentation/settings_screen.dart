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
    final accent = controller.accentColor;
    final textColor = Theme.of(context).colorScheme.onSurface;
    final selected = await showModalBottomSheet<ThemeMode>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
            children: <Widget>[
              _ThemeModeOptionRow(
                label: 'System',
                isSelected: controller.themeMode == ThemeMode.system,
                accent: accent,
                textColor: textColor,
                onTap: () => Navigator.pop(context, ThemeMode.system),
              ),
              const SizedBox(height: 10),
              _ThemeModeOptionRow(
                label: 'Light',
                isSelected: controller.themeMode == ThemeMode.light,
                accent: accent,
                textColor: textColor,
                onTap: () => Navigator.pop(context, ThemeMode.light),
              ),
              const SizedBox(height: 10),
              _ThemeModeOptionRow(
                label: 'Dark',
                isSelected: controller.themeMode == ThemeMode.dark,
                accent: accent,
                textColor: textColor,
                onTap: () => Navigator.pop(context, ThemeMode.dark),
              ),
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

class _ThemeModeOptionRow extends StatelessWidget {
  const _ThemeModeOptionRow({
    required this.label,
    required this.isSelected,
    required this.accent,
    required this.textColor,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final Color accent;
  final Color textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? accent.withValues(alpha: 0.78) : Colors.white.withValues(alpha: 0.12),
            width: isSelected ? 1.6 : 1,
          ),
          color: isSelected ? accent.withValues(alpha: 0.18) : Colors.white.withValues(alpha: 0.05),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                ),
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 160),
              child: isSelected
                  ? Icon(Icons.check_circle_rounded, key: ValueKey<String>('selected-$label'), color: accent)
                  : Icon(Icons.circle_outlined, key: ValueKey<String>('unselected-$label'), color: textColor.withValues(alpha: 0.45)),
            ),
          ],
        ),
      ),
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
