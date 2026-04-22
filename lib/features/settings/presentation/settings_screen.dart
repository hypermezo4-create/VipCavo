import 'dart:ui';

import 'package:deadzon/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color(0xFF0E1F26),
              Color(0xFF0B161B),
              Color(0xFF080D10),
            ],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
            children: <Widget>[
              _TopBar(onBack: () => Navigator.of(context).pop()),
              const SizedBox(height: 18),
              _GlassSection(
                title: 'Appearance',
                child: Column(
                  children: <Widget>[
                    _ModeRow(
                      title: 'Theme',
                      mode: themeMode,
                      onChanged: (mode) => ref.read(themeModeProvider.notifier).state = mode,
                    ),
                    const Divider(height: 24),
                    _SimpleRow(
                      icon: Icons.color_lens_rounded,
                      iconColor: const Color(0xFF79E3CB),
                      title: 'Primary color',
                      subtitle: 'Blue-green glass palette',
                    ),
                    const Divider(height: 24),
                    _SimpleRow(
                      icon: Icons.blur_on_rounded,
                      iconColor: const Color(0xFFC3A7FF),
                      title: 'UI style',
                      subtitle: 'Premium glassmorphism',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _GlassSection(
                title: 'Build',
                child: Column(
                  children: const <Widget>[
                    _SimpleRow(
                      icon: Icons.verified_rounded,
                      iconColor: Color(0xFF8DF5AA),
                      title: 'Project',
                      subtitle: 'Deadzon • Mezo • Base Alpha',
                    ),
                    Divider(height: 24),
                    _SimpleRow(
                      icon: Icons.memory_rounded,
                      iconColor: Color(0xFF88CFFF),
                      title: 'ROM',
                      subtitle: 'ROM Deadzon • CN 3.0.303',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _GlassSection(
                title: 'Reset',
                child: Column(
                  children: <Widget>[
                    _ActionRow(
                      icon: Icons.restart_alt_rounded,
                      iconColor: const Color(0xFFFF8E8E),
                      title: 'Reset app settings',
                      subtitle: 'Restore only app preferences to default',
                      onTap: () => _showResetDialog(
                        context,
                        title: 'Reset app settings',
                        body: 'This will reset Deadzon appearance and local preferences.',
                      ),
                    ),
                    const Divider(height: 24),
                    _ActionRow(
                      icon: Icons.delete_outline_rounded,
                      iconColor: const Color(0xFFD49BFF),
                      title: 'Reset Deadzon customizations',
                      subtitle: 'Clear all current UI customization choices',
                      onTap: () => _showResetDialog(
                        context,
                        title: 'Reset Deadzon customizations',
                        body: 'This will clear current customization choices in this alpha build.',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showResetDialog(
    BuildContext context, {
    required String title,
    required String body,
  }) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF13262D),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          title: Text(title, style: const TextStyle(color: Colors.white)),
          content: Text(
            body,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.78)),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Reset action placeholder completed.'),
                    behavior: SnackBarBehavior.floating,
                  ),
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

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Material(
          color: Colors.white.withValues(alpha: 0.12),
          shape: const CircleBorder(),
          child: InkWell(
            onTap: onBack,
            customBorder: const CircleBorder(),
            child: const SizedBox(
              width: 42,
              height: 42,
              child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Text(
          'Settings',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}

class _GlassSection extends StatelessWidget {
  const _GlassSection({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 14),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class _ModeRow extends StatelessWidget {
  const _ModeRow({
    required this.title,
    required this.mode,
    required this.onChanged,
  });

  final String title;
  final ThemeMode mode;
  final ValueChanged<ThemeMode> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: <Widget>[
            _ModeChip(
              label: 'System',
              selected: mode == ThemeMode.system,
              onTap: () => onChanged(ThemeMode.system),
            ),
            _ModeChip(
              label: 'Light',
              selected: mode == ThemeMode.light,
              onTap: () => onChanged(ThemeMode.light),
            ),
            _ModeChip(
              label: 'Dark',
              selected: mode == ThemeMode.dark,
              onTap: () => onChanged(ThemeMode.dark),
            ),
          ],
        ),
      ],
    );
  }
}

class _ModeChip extends StatelessWidget {
  const _ModeChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      labelStyle: TextStyle(
        color: selected ? const Color(0xFF0F262B) : Colors.white,
        fontWeight: FontWeight.w600,
      ),
      selectedColor: const Color(0xFF8AEFD7),
      backgroundColor: Colors.white.withValues(alpha: 0.08),
      side: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}

class _SimpleRow extends StatelessWidget {
  const _SimpleRow({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          radius: 22,
          backgroundColor: Colors.white.withValues(alpha: 0.10),
          child: Icon(icon, color: iconColor),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(color: Colors.white.withValues(alpha: 0.72)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white.withValues(alpha: 0.10),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.72)),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: Colors.white70),
        ],
      ),
    );
  }
}