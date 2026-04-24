import 'dart:ui';

import 'package:deadzon/features/mount/domain/mount_config.dart';
import 'package:deadzon/features/mount/presentation/widgets/mount_glass_card.dart';
import 'package:flutter/material.dart';

class MountLivePreview extends StatelessWidget {
  const MountLivePreview({required this.config, super.key});

  final MountConfig config;

  @override
  Widget build(BuildContext context) {
    final accent = Color.lerp(Colors.white, config.selectedColor, config.accentIntensity) ?? config.selectedColor;

    return RepaintBoundary(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(config.cornerRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: config.blurStrength, sigmaY: config.blurStrength),
          child: MountGlassCard(
            tint: config.cardBackgroundTint,
            radius: config.cornerRadius,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('9:41', style: TextStyle(color: config.textAccentColor, fontWeight: FontWeight.w700)),
                    const Spacer(),
                    Icon(Icons.network_cell, color: config.iconAccentColor, size: 16),
                    const SizedBox(width: 4),
                    Icon(Icons.wifi, color: config.iconAccentColor, size: 16),
                    const SizedBox(width: 4),
                    Icon(Icons.battery_full, color: config.iconAccentColor, size: 16),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: List<Widget>.generate(
                    4,
                    (i) => Expanded(
                      child: Container(
                        height: 30,
                        margin: EdgeInsets.only(right: i == 3 ? 0 : 8),
                        decoration: BoxDecoration(
                          color: accent.withValues(alpha: i.isEven ? 0.35 : 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.bolt_rounded, size: 16, color: config.iconAccentColor),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: config.seekbarColor,
                    inactiveTrackColor: config.seekbarColor.withValues(alpha: 0.2),
                    thumbColor: config.seekbarColor,
                  ),
                  child: const Slider(value: 0.6, onChanged: null),
                ),
                Row(
                  children: <Widget>[
                    Switch(value: true, onChanged: (_) {}, activeTrackColor: config.switchOnColor, inactiveTrackColor: config.switchOffColor),
                    const SizedBox(width: 8),
                    Checkbox(value: true, onChanged: (_) {}, fillColor: WidgetStatePropertyAll(config.checkboxOnColor)),
                    Checkbox(value: false, onChanged: (_) {}, fillColor: WidgetStatePropertyAll(config.checkboxOffColor)),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: config.glassOpacity * 0.35),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withValues(alpha: config.borderVisibility * 0.5)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: config.selectedColor.withValues(alpha: config.glowAmount * 0.35),
                        blurRadius: 16 + (config.shadowDepth * 16),
                      ),
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.notifications_active_rounded, color: config.iconAccentColor),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Mount Studio applied • Monet accents refreshed',
                          style: TextStyle(color: config.textAccentColor, fontSize: 12.5, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
