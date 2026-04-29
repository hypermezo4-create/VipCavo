import 'package:deadzon/core/constants/app_identity.dart';
import 'package:deadzon/core/theme/deadzon_theme_controller.dart';
import 'package:deadzon/core/theme/design_tokens.dart';
import 'package:deadzon/core/widgets/glass_card.dart';
import 'package:deadzon/features/settings/presentation/widgets/deadzone_color_picker_dialog.dart';
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
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            DeadzonThemeTokens.appBackground(context),
            DeadzonThemeTokens.pageBackground(context),
            DeadzonThemeTokens.pageBackground(context).withValues(alpha: 0.92),
          ],
        ),
      ),
      child: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          padding: EdgeInsets.fromLTRB(16, 12, 16, MediaQuery.paddingOf(context).bottom + 140),
          children: <Widget>[
            _HeaderCard(accent: theme.accentColor),
            const SizedBox(height: 14),
            _SectionCard(
              title: 'Appearance',
              children: <Widget>[
                _settingsItem(
                  icon: Icons.language_rounded,
                  iconColor: const Color(0xFF14B8A6),
                  title: 'Language',
                  subtitle: 'English',
                ),
                _settingsItem(
                  icon: theme.themeMode == ThemeMode.dark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                  iconColor: const Color(0xFF2D7DED),
                  title: 'Theme',
                  subtitle: _modeSummary(theme.themeMode),
                  onTap: () => _showThemePicker(context, theme),
                ),
                _settingsItem(
                  icon: Icons.palette_rounded,
                  iconColor: theme.accentColor,
                  title: 'Accent Color',
                  subtitle: theme.selectedAccent.label,
                  trailing: _ColorDot(color: theme.selectedAccent.color),
                  onTap: () => _pickColor(
                    context,
                    title: 'Accent Color',
                    options: DeadzonThemeController.accentOptions,
                    selectedId: theme.selectedAccentId,
                    onSelected: theme.setAccentColor,
                  ),
                ),
                _settingsItem(
                  icon: Icons.color_lens_outlined,
                  iconColor: const Color(0xFF7F9AB0),
                  title: 'Light UI Palette',
                  subtitle: theme.selectedLightPalette.label,
                  onTap: () => _pickColor(
                    context,
                    title: 'Light UI Palette',
                    options: DeadzonThemeController.lightPaletteOptions,
                    selectedId: theme.selectedLightPaletteId,
                    onSelected: theme.setLightPalette,
                  ),
                ),
                _settingsItem(
                  icon: Icons.color_lens_outlined,
                  iconColor: const Color(0xFF315A77),
                  title: 'Dark UI Palette',
                  subtitle: theme.selectedDarkPalette.label,
                  onTap: () => _pickColor(
                    context,
                    title: 'Dark UI Palette',
                    options: DeadzonThemeController.darkPaletteOptions,
                    selectedId: theme.selectedDarkPaletteId,
                    onSelected: theme.setDarkPalette,
                  ),
                ),
                _settingsItem(
                  icon: Icons.light_mode_rounded,
                  iconColor: const Color(0xFFA4B5C5),
                  title: 'Light Background',
                  subtitle: theme.selectedLightBackground.label,
                  trailing: _ColorDot(color: theme.selectedLightBackground.color),
                  onTap: () => _pickColor(
                    context,
                    title: 'Light Background Color',
                    options: DeadzonThemeController.lightBackgroundOptions,
                    selectedId: theme.selectedLightBackgroundId,
                    onSelected: theme.setLightBackground,
                  ),
                ),
                _settingsItem(
                  icon: Icons.nights_stay_rounded,
                  iconColor: const Color(0xFF3D4D5D),
                  title: 'Dark Background',
                  subtitle: theme.selectedDarkBackground.label,
                  trailing: _ColorDot(color: theme.selectedDarkBackground.color),
                  onTap: () => _pickColor(
                    context,
                    title: 'Dark Background Color',
                    options: DeadzonThemeController.darkBackgroundOptions,
                    selectedId: theme.selectedDarkBackgroundId,
                    onSelected: theme.setDarkBackground,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _SectionCard(
              title: 'About',
              children: <Widget>[
                _settingsItem(
                  icon: Icons.apps_rounded,
                  iconColor: const Color(0xFF2ED9A6),
                  title: 'DeadZone Tools',
                  subtitle: AppIdentity.currentTrack,
                ),
                _settingsItem(
                  icon: Icons.send_rounded,
                  iconColor: const Color(0xFF2DA8FF),
                  title: 'Telegram Channel',
                  subtitle: 'DeadZone updates',
                ),
                _settingsItem(
                  icon: Icons.info_outline_rounded,
                  iconColor: const Color(0xFF8FB5D2),
                  title: 'Project Info',
                  subtitle: 'DeadZone ROM tools & customization layer',
                ),
                _settingsItem(
                  icon: Icons.link_rounded,
                  iconColor: const Color(0xFF49B571),
                  title: 'Website / GitHub',
                  subtitle: 'Project repository',
                ),
              ],
            ),
            const SizedBox(height: 14),
            _SectionCard(
              title: 'Reset',
              children: <Widget>[
                _settingsItem(
                  icon: Icons.restart_alt_rounded,
                  iconColor: const Color(0xFFFF5252),
                  title: 'Reset App Settings',
                  subtitle: 'Restore app preferences to defaults',
                  onTap: () => _showResetAppDialog(context),
                ),
                _settingsItem(
                  icon: Icons.restore_page_rounded,
                  iconColor: const Color(0xFF9B4DFF),
                  title: 'Reset DeadZone Customizations',
                  subtitle: 'Reset all DeadZone ROM settings to default',
                  onTap: () => _showResetCustomizationsDialog(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingsItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return _SettingsTile(icon: icon, iconColor: iconColor, title: title, subtitle: subtitle, trailing: trailing, onTap: onTap);
  }

  static String _modeSummary(ThemeMode mode) {
    return switch (mode) {
      ThemeMode.system => 'System default',
      ThemeMode.light => 'Light',
      ThemeMode.dark => 'Dark',
    };
  }

  Future<void> _pickColor(
    BuildContext context, {
    required String title,
    required List<DeadzoneColorOption> options,
    required String selectedId,
    required Future<void> Function(String id) onSelected,
  }) async {
    final picked = await showDialog<String>(
      context: context,
      builder: (context) => DeadZoneColorPickerDialog(title: title, options: options, selectedId: selectedId),
    );
    if (picked != null) {
      await onSelected(picked);
    }
  }

  Future<void> _showThemePicker(BuildContext context, DeadzonThemeController controller) async {
    final selected = await showModalBottomSheet<ThemeMode>(
      context: context,
      backgroundColor: DeadzonThemeTokens.sheetBackground(context),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _ThemeModeRow(label: 'System default', selected: controller.themeMode == ThemeMode.system, onTap: () => Navigator.pop(context, ThemeMode.system)),
                const SizedBox(height: 8),
                _ThemeModeRow(label: 'Light', selected: controller.themeMode == ThemeMode.light, onTap: () => Navigator.pop(context, ThemeMode.light)),
                const SizedBox(height: 8),
                _ThemeModeRow(label: 'Dark', selected: controller.themeMode == ThemeMode.dark, onTap: () => Navigator.pop(context, ThemeMode.dark)),
              ],
            ),
          ),
        );
      },
    );

    if (selected != null) {
      await controller.setThemeMode(selected);
    }
  }

  void _showResetAppDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset App Settings'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('The app will restore default values for app preferences.'),
            SizedBox(height: 12),
            Text('• App theme\n• Accent color\n• Language\n• Light background\n• Dark background\n• Light UI palette\n• Dark UI palette\n• Local preferences'),
          ],
        ),
        actions: <Widget>[
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            onPressed: () async {
              Navigator.pop(context);
              await context.read<DeadzonThemeController>().resetAppPreferences();
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('DeadZone app settings were reset to defaults.'), behavior: SnackBarBehavior.floating),
              );
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  void _showResetCustomizationsDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset DeadZone Customizations'),
        content: const Text('This will reset DeadZone customization settings to default. This action cannot be undone.'),
        actions: <Widget>[
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Reset action prepared. No system files were changed.'), behavior: SnackBarBehavior.floating),
              );
            },
            child: const Text('Reset All'),
          ),
        ],
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({required this.accent});

  final Color accent;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    'assets/branding/deadzon/webp_for_app/deadzon_logo_mark_2048.webp',
                    width: 44,
                    height: 44,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(color: accent.withValues(alpha: 0.18), borderRadius: BorderRadius.circular(14)),
                      child: Icon(Icons.settings_rounded, color: accent),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('DeadZone Tools', style: TextStyle(fontSize: DesignTokens.detailTitle, fontWeight: FontWeight.w800)),
                      SizedBox(height: 2),
                      Text('Settings & ROM preferences', style: TextStyle(fontSize: DesignTokens.pageSubtitle)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(color: accent.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(999)),
                  child: Text(AppIdentity.currentTrack, style: TextStyle(color: accent, fontWeight: FontWeight.w700, fontSize: DesignTokens.valueChip)),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Row(
              children: <Widget>[
                Icon(Icons.settings_rounded, size: 20),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Settings', style: TextStyle(fontWeight: FontWeight.w700, fontSize: DesignTokens.rowTitle)),
                    Text('Appearance & preferences', style: TextStyle(fontSize: DesignTokens.rowSubtitle)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Text(title, style: TextStyle(fontSize: DesignTokens.sectionTitle, fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.primary)),
          ),
          const Divider(height: 1),
          ...children.expand((Widget child) => <Widget>[child, const Divider(height: 1)]).toList()..removeLast(),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Row(
        children: <Widget>[
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(color: iconColor.withValues(alpha: 0.22), borderRadius: BorderRadius.circular(11)),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: const TextStyle(fontSize: DesignTokens.rowTitle, fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(subtitle, style: TextStyle(fontSize: DesignTokens.rowSubtitle, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.72))),
              ],
            ),
          ),
          const SizedBox(width: 10),
          trailing ?? Icon(Icons.chevron_right_rounded, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.55)),
        ],
      ),
    );

    if (onTap == null) return content;
    return InkWell(onTap: onTap, child: content);
  }
}

class _ThemeModeRow extends StatelessWidget {
  const _ThemeModeRow({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.16) : Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            children: <Widget>[
              Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: DesignTokens.buttonText))),
              Icon(selected ? Icons.check_circle_rounded : Icons.circle_outlined, color: selected ? Theme.of(context).colorScheme.primary : null),
            ],
          ),
        ),
      ),
    );
  }
}

class _ColorDot extends StatelessWidget {
  const _ColorDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.35)),
      ),
    );
  }
}
