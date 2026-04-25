import 'dart:ui';

import 'package:deadzon/core/theme/design_tokens.dart';
import 'package:flutter/material.dart';

class MezoAdjustButton extends StatelessWidget {
  const MezoAdjustButton({required this.icon, required this.onTap, super.key});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Ink(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.1),
          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        ),
        child: Icon(icon, size: 14, color: Colors.white70),
      ),
    );
  }
}

class MezoStepSlider extends StatelessWidget {
  const MezoStepSlider({
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.step = 1,
    super.key,
  });

  final double value;
  final double min;
  final double max;
  final double step;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final safe = value.clamp(min, max).toDouble();
    return Row(
      children: <Widget>[
        MezoAdjustButton(icon: Icons.remove_rounded, onTap: () => onChanged((safe - step).clamp(min, max).toDouble())),
        const SizedBox(width: 8),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 4,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
              overlayShape: SliderComponentShape.noOverlay,
              activeTrackColor: const Color(0xFF89E9D3),
              inactiveTrackColor: Colors.white.withValues(alpha: 0.18),
              thumbColor: const Color(0xFFB8FFF2),
            ),
            child: Slider(value: safe, min: min, max: max, onChanged: onChanged),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 36,
          child: Text(safe.toStringAsFixed(0), textAlign: TextAlign.right, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ),
        const SizedBox(width: 8),
        MezoAdjustButton(icon: Icons.add_rounded, onTap: () => onChanged((safe + step).clamp(min, max).toDouble())),
      ],
    );
  }
}

class MezoSourceSeekbarRow extends StatelessWidget {
  const MezoSourceSeekbarRow({
    required this.title,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    required this.onReset,
    this.subtitle,
    super.key,
  });

  final String title;
  final String? subtitle;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final safe = value.clamp(min, max).toDouble();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                    if (subtitle != null) ...<Widget>[
                      const SizedBox(height: 2),
                      Text(subtitle!, style: TextStyle(color: Colors.white.withValues(alpha: 0.66), fontSize: 12)),
                    ],
                  ],
                ),
              ),
              InkWell(
                onTap: onReset,
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
                  ),
                  child: const Text('RESET', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 8),
              Text(safe.toStringAsFixed(0), style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 9),
          Row(
            children: <Widget>[
              _MezoSeekAdjust(onTap: () => onChanged((safe - 1).clamp(min, max).toDouble()), symbol: '−'),
              const SizedBox(width: 7),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 3.2,
                    overlayShape: SliderComponentShape.noOverlay,
                    inactiveTrackColor: Colors.white.withValues(alpha: 0.2),
                    activeTrackColor: const Color(0xFF8DE8FF),
                    thumbColor: const Color(0xFFC2FFF5),
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7.8),
                  ),
                  child: Slider(value: safe, min: min, max: max, onChanged: onChanged),
                ),
              ),
              const SizedBox(width: 7),
              _MezoSeekAdjust(onTap: () => onChanged((safe + 1).clamp(min, max).toDouble()), symbol: '+'),
            ],
          ),
        ],
      ),
    );
  }
}

class _MezoSeekAdjust extends StatelessWidget {
  const _MezoSeekAdjust({required this.onTap, required this.symbol});

  final VoidCallback onTap;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 26,
        height: 27,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(9),
          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        ),
        child: Text(symbol, style: const TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w700, height: 1)),
      ),
    );
  }
}

class MezoColorChip extends StatelessWidget {
  const MezoColorChip({required this.hex, required this.onTap, super.key});

  final String hex;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(shape: BoxShape.circle, color: fromHex(hex)),
            ),
            const SizedBox(width: 8),
            Text(hex, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  static Color fromHex(String hex) {
    final value = hex.replaceAll('#', '');
    if (value.length == 6) {
      return Color(int.parse('FF$value', radix: 16));
    }
    if (value.length == 8) {
      return Color(int.parse(value, radix: 16));
    }
    return const Color(0xFF79E3CB);
  }
}

class MezoGlassPanel extends StatelessWidget {
  const MezoGlassPanel({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 9, sigmaY: 9),
        child: AnimatedContainer(
          duration: DesignTokens.motionFast,
          curve: DesignTokens.motionCurve,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color(0xFF132228).withValues(alpha: 0.56),
            border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
          ),
          child: child,
        ),
      ),
    );
  }
}
