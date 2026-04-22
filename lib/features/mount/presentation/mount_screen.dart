import 'package:deadzon/core/widgets/action_chip.dart';
import 'package:deadzon/core/widgets/glass_card.dart';
import 'package:deadzon/core/widgets/premium_top_bar.dart';
import 'package:deadzon/core/widgets/section_header.dart';
import 'package:flutter/material.dart';

class MountScreen extends StatefulWidget {
  const MountScreen({super.key});

  @override
  State<MountScreen> createState() => _MountScreenState();
}

class _MountScreenState extends State<MountScreen> {
  Color monetColor = const Color(0xFF8CEFD2);
  bool colorEffect = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Color(0xFF15303A), Color(0xFF10242C), Color(0xFF0B1418)],
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 120),
          children: <Widget>[
            const PremiumTopBar(title: 'Mount', subtitle: 'Premium monet color controls and live previews'),
            const SizedBox(height: 16),
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SectionHeader(title: 'Choose monet color'),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: <Color>[
                      const Color(0xFF8CEFD2),
                      const Color(0xFFA992FF),
                      const Color(0xFF7BC7FF),
                      const Color(0xFFFF9BC7),
                      const Color(0xFFFFD372),
                    ].map((color) {
                      final hexColor = color
                          .toARGB32()
                          .toRadixString(16)
                          .padLeft(8, '0')
                          .substring(2)
                          .toUpperCase();
                      return ActionChipCell(
                        label: '#$hexColor',
                        icon: Icons.circle,
                        color: color,
                        onTap: () => setState(() => monetColor = color),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            GlassCard(
              child: SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: colorEffect,
                onChanged: (value) => setState(() => colorEffect = value),
                title: const Text('Color effect', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                subtitle: Text('Enable accent effect across preview widgets', style: TextStyle(color: Colors.white.withValues(alpha: 0.72))),
              ),
            ),
            const SizedBox(height: 12),
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SectionHeader(title: 'Live preview'),
                  const SizedBox(height: 10),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: monetColor,
                      thumbColor: monetColor,
                    ),
                    child: const Slider(value: 0.65, onChanged: null),
                  ),
                  Row(
                    children: <Widget>[
                      Switch(
                        value: true,
                        onChanged: (_) {},
                        activeTrackColor: monetColor,
                        activeThumbColor: Colors.white,
                      ),
                      const SizedBox(width: 14),
                      Checkbox(value: true, onChanged: (_) {}, fillColor: WidgetStatePropertyAll(monetColor)),
                      const SizedBox(width: 8),
                      Checkbox(value: false, onChanged: (_) {}),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
