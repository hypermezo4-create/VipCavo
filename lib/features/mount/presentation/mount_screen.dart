import 'dart:ui';

import 'package:flutter/material.dart';

class MountScreen extends StatefulWidget {
  const MountScreen({super.key});

  @override
  State<MountScreen> createState() => _MountScreenState();
}

class _MountScreenState extends State<MountScreen> {
  bool colorEffect = true;
  Color seekbarColor = const Color(0xFFA992FF);
  Color checkboxOnBg = const Color(0xFF77F1B7);
  Color checkboxOffBg = const Color(0xFF6E8C96);
  Color checkboxOn = Colors.white;
  Color checkboxOff = const Color(0xFFD8E4E8);

  final List<Color> monetPalette = <Color>[
    const Color(0xFF8CEFD2),
    const Color(0xFFA992FF),
    const Color(0xFF7BC7FF),
    const Color(0xFFFF9BC7),
    const Color(0xFFFFD372),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color(0xFF264350),
              Color(0xFF152830),
              Color(0xFF091115),
            ],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
            children: <Widget>[
              _TopBar(
                title: 'Mount',
                subtitle: 'Monet colors and system accent',
                onBack: () => Navigator.of(context).pop(),
              ),
              const SizedBox(height: 18),
              _GlassCard(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const CircleAvatar(
                    radius: 22,
                    backgroundColor: Color(0x22FFFFFF),
                    child: Icon(Icons.palette_rounded, color: Color(0xFFC7B4FF)),
                  ),
                  title: const Text(
                    'Choose your Monet color',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(
                    'Pick a color for Monet picker',
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.72)),
                  ),
                  trailing: const Icon(Icons.chevron_right_rounded, color: Colors.white70),
                ),
              ),
              const SizedBox(height: 16),
              _SectionTitle('Color effect'),
              const SizedBox(height: 10),
              _GlassCard(
                child: SwitchListTile(
                  value: colorEffect,
                  onChanged: (value) => setState(() => colorEffect = value),
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    'Enable Monet color effects',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    'Applies accent color effect across the UI preview',
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _SectionTitle('Colors for toggles & seekbars'),
              const SizedBox(height: 10),
              _ColorRow(
                title: 'Seekbar / Progressbar',
                color: seekbarColor,
                onTap: () => _showColorPicker(
                  title: 'Seekbar / Progressbar',
                  onSelected: (color) => setState(() => seekbarColor = color),
                ),
              ),
              const SizedBox(height: 10),
              _ColorRow(
                title: 'Checkbox background (On)',
                color: checkboxOnBg,
                onTap: () => _showColorPicker(
                  title: 'Checkbox background (On)',
                  onSelected: (color) => setState(() => checkboxOnBg = color),
                ),
              ),
              const SizedBox(height: 10),
              _ColorRow(
                title: 'Checkbox background (Off)',
                color: checkboxOffBg,
                onTap: () => _showColorPicker(
                  title: 'Checkbox background (Off)',
                  onSelected: (color) => setState(() => checkboxOffBg = color),
                ),
              ),
              const SizedBox(height: 10),
              _ColorRow(
                title: 'Checkbox (On)',
                color: checkboxOn,
                onTap: () => _showColorPicker(
                  title: 'Checkbox (On)',
                  onSelected: (color) => setState(() => checkboxOn = color),
                ),
              ),
              const SizedBox(height: 10),
              _ColorRow(
                title: 'Checkbox (Off)',
                color: checkboxOff,
                onTap: () => _showColorPicker(
                  title: 'Checkbox (Off)',
                  onSelected: (color) => setState(() => checkboxOff = color),
                ),
              ),
              const SizedBox(height: 18),
              _SectionTitle('Preview'),
              const SizedBox(height: 10),
              _GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: seekbarColor,
                        thumbColor: seekbarColor,
                        inactiveTrackColor: Colors.white.withValues(alpha: 0.14),
                      ),
                      child: const Slider(
                        value: 0.58,
                        onChanged: null,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: <Widget>[
                        Switch(
                          value: true,
                          onChanged: (_) {},
                          activeColor: checkboxOn,
                          activeTrackColor: checkboxOnBg,
                          inactiveThumbColor: checkboxOff,
                          inactiveTrackColor: checkboxOffBg,
                        ),
                        const SizedBox(width: 16),
                        Theme(
                          data: Theme.of(context).copyWith(
                            checkboxTheme: CheckboxThemeData(
                              fillColor: WidgetStateProperty.resolveWith((states) {
                                if (states.contains(WidgetState.selected)) {
                                  return checkboxOnBg;
                                }
                                return checkboxOffBg;
                              }),
                              checkColor: WidgetStatePropertyAll(checkboxOn),
                              side: BorderSide(color: Colors.white.withValues(alpha: 0.28)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                          child: Checkbox(value: false, onChanged: (_) {}),
                        ),
                        const SizedBox(width: 16),
                        Theme(
                          data: Theme.of(context).copyWith(
                            checkboxTheme: CheckboxThemeData(
                              fillColor: WidgetStatePropertyAll(checkboxOnBg),
                              checkColor: WidgetStatePropertyAll(checkboxOn),
                              side: BorderSide(color: Colors.white.withValues(alpha: 0.28)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                          child: Checkbox(value: true, onChanged: (_) {}),
                        ),
                      ],
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

  void _showColorPicker({
    required String title,
    required ValueChanged<Color> onSelected,
  }) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF15262E).withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                ),
                child: SafeArea(
                  top: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: monetPalette.map((color) {
                          return GestureDetector(
                            onTap: () {
                              onSelected(color);
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 58,
                              height: 58,
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.20),
                                  width: 2,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 18),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.title,
    required this.subtitle,
    required this.onBack,
  });

  final String title;
  final String subtitle;
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.75),
                  ),
            ),
          ],
        ),
      ],
    );
  }
}

class _GlassCard extends StatelessWidget {
  const _GlassCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.86),
            fontWeight: FontWeight.w700,
          ),
    );
  }
}

class _ColorRow extends StatelessWidget {
  const _ColorRow({
    required this.title,
    required this.color,
    required this.onTap,
  });

  final String title;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        trailing: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
          ),
        ),
      ),
    );
  }
}