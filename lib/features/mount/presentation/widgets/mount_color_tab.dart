import 'package:deadzon/features/mount/data/mount_defaults.dart';
import 'package:deadzon/features/mount/domain/mount_config.dart';
import 'package:deadzon/features/mount/presentation/widgets/mount_glass_card.dart';
import 'package:flutter/material.dart';

class MountColorTab extends StatelessWidget {
  const MountColorTab({
    required this.config,
    required this.onPresetTap,
    required this.onLaunchMonetPicker,
    required this.onPlaceholderTap,
    super.key,
  });

  final MountConfig config;
  final ValueChanged<MountColorPreset> onPresetTap;
  final VoidCallback onLaunchMonetPicker;
  final VoidCallback onPlaceholderTap;

  @override
  Widget build(BuildContext context) {
    final hex = '#${config.selectedColor.toARGB32().toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';

    return MountGlassCard(
      tint: config.selectedColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Color Studio', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(color: config.selectedColor, shape: BoxShape.circle, border: Border.all(color: Colors.white54)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(config.selectedColorName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                    Text(hex, style: TextStyle(color: Colors.white.withValues(alpha: 0.75))),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: MountDefaults.colorPresets
                .map(
                  (preset) => FilterChip(
                    selected: config.selectedColor == preset.color,
                    onSelected: (_) => onPresetTap(preset),
                    label: Text(preset.name),
                    selectedColor: preset.color.withValues(alpha: 0.35),
                    side: BorderSide(color: Colors.white.withValues(alpha: 0.22)),
                    labelStyle: const TextStyle(color: Colors.white),
                    backgroundColor: Colors.white.withValues(alpha: 0.07),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 14),
          Row(
            children: <Widget>[
              Expanded(child: _PlaceholderButton(label: 'Pick from wallpaper', onTap: onPlaceholderTap)),
              const SizedBox(width: 10),
              Expanded(child: _PlaceholderButton(label: 'Manual color picker', onTap: onPlaceholderTap)),
            ],
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: onLaunchMonetPicker,
            icon: const Icon(Icons.palette_outlined),
            label: const Text('Choose Your Monet Color'),
          ),
        ],
      ),
    );
  }
}

class _PlaceholderButton extends StatelessWidget {
  const _PlaceholderButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(onPressed: onTap, child: Text(label, textAlign: TextAlign.center));
  }
}
