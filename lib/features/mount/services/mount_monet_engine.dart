import 'package:deadzon/features/mount/domain/mount_palette.dart';
import 'package:flutter/material.dart';

class MountMonetEngine {
  static const List<int> tones = <int>[0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 95, 99, 100];

  Map<String, Map<String, int>> generate(Color seed) {
    final hsl = HSLColor.fromColor(seed);
    final secondary = hsl.withSaturation((hsl.saturation * 0.55).clamp(0.0, 1.0)).toColor();
    final tertiary = hsl.withHue((hsl.hue + 60.0) % 360.0).toColor();
    final neutral = hsl.withSaturation(0.08).toColor();
    final neutralVariant = hsl.withSaturation(0.16).toColor();
    const error = Color(0xFFBA1A1A);

    Map<String, int> from(Color paletteSeed) {
      final generated = _tones(paletteSeed);
      return <String, int>{
        for (var i = 0; i < tones.length; i++) '${tones[i]}': generated[i].toARGB32(),
      };
    }

    return <String, Map<String, int>>{
      'primary': from(seed),
      'secondary': from(secondary),
      'tertiary': from(tertiary),
      'neutral': from(neutral),
      'neutralVariant': from(neutralVariant),
      'error': from(error),
    };
  }

  Color _tone(Color seed, double lightness) {
    final toneLightness = lightness.clamp(0.03, 0.98);
    return HSLColor.fromColor(seed).withLightness(toneLightness).toColor().withAlpha(0xFF);
  }

  List<Color> _tones(Color seed) => tones.map((tone) => _tone(seed, tone / 100.0)).toList(growable: false);

  MountPalette derivePaletteFromSeed({required String id, required String name, required Color seed}) {
    final tonal = generate(seed);
    Color tone(String family, int value) => Color(tonal[family]!['$value']!);
    return MountPalette(
      id: id,
      name: name,
      primary: tone('primary', 40),
      secondary: tone('secondary', 40),
      tertiary: tone('tertiary', 40),
      backgroundTint: tone('neutral', 20).withValues(alpha: 0.25),
      accent: tone('primary', 80),
      previewGradient: <Color>[tone('primary', 50), tone('tertiary', 60)],
    );
  }
}
