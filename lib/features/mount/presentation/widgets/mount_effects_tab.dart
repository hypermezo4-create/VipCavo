import 'package:deadzon/features/mount/domain/mount_config.dart';
import 'package:deadzon/features/mount/presentation/widgets/mount_glass_card.dart';
import 'package:flutter/material.dart';

class MountEffectsTab extends StatelessWidget {
  const MountEffectsTab({required this.config, required this.onChanged, super.key});

  final MountConfig config;
  final Future<void> Function(String key, double value) onChanged;

  @override
  Widget build(BuildContext context) {
    return MountGlassCard(
      tint: config.selectedColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Controls DeadZon app glass, blur, glow and accent only.',
            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          _SliderTile(title: 'Glass opacity', value: config.glassOpacity, min: 0.2, max: 1, format: _SliderFormat.percent, onChanged: (v) => onChanged('glassOpacity', v)),
          _SliderTile(title: 'Blur strength', value: config.blurStrength, min: 0, max: 30, format: _SliderFormat.pixels, onChanged: (v) => onChanged('blurStrength', v)),
          _SliderTile(title: 'Accent intensity', value: config.accentIntensity, min: 0, max: 1, format: _SliderFormat.percent, onChanged: (v) => onChanged('accentIntensity', v)),
          _SliderTile(title: 'Glow amount', value: config.glowAmount, min: 0, max: 1, format: _SliderFormat.percent, onChanged: (v) => onChanged('glowAmount', v)),
          _SliderTile(title: 'Corner radius', value: config.cornerRadius, min: 12, max: 36, format: _SliderFormat.pixels, onChanged: (v) => onChanged('cornerRadius', v)),
          _SliderTile(title: 'Shadow depth', value: config.shadowDepth, min: 0, max: 1, format: _SliderFormat.percent, onChanged: (v) => onChanged('shadowDepth', v)),
          _SliderTile(title: 'Border visibility', value: config.borderVisibility, min: 0, max: 1, format: _SliderFormat.percent, onChanged: (v) => onChanged('borderVisibility', v)),
        ],
      ),
    );
  }
}

class _SliderTile extends StatelessWidget {
  const _SliderTile({
    required this.title,
    required this.value,
    required this.min,
    required this.max,
    required this.format,
    required this.onChanged,
  });

  final String title;
  final double value;
  final double min;
  final double max;
  final _SliderFormat format;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
              Text(_formatValue(value), style: TextStyle(color: Colors.white.withValues(alpha: 0.74))),
            ],
          ),
          Slider(value: value.clamp(min, max), min: min, max: max, onChanged: onChanged),
        ],
      ),
    );
  }

  String _formatValue(double rawValue) {
    switch (format) {
      case _SliderFormat.percent:
        return '${(rawValue * 100).round()}%';
      case _SliderFormat.pixels:
        return '${rawValue.round()} px';
    }
  }
}

enum _SliderFormat { percent, pixels }
