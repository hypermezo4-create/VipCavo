import 'package:deadzon/features/mount/domain/mount_palette.dart';
import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:flutter/material.dart';

class MountMonetEngine {
  static const List<int> tones = <int>[0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 95, 99, 100];

  Map<String, Map<String, int>> generate(Color seed) {
    final argb = seed.toARGB32();
    final palettes = CorePalettes.of(argb);
    Map<String, int> from(TonalPalette palette) => {
          for (final tone in tones) '$tone': palette.get(tone),
        };

    return <String, Map<String, int>>{
      'primary': from(palettes.primary),
      'secondary': from(palettes.secondary),
      'tertiary': from(palettes.tertiary),
      'neutral': from(palettes.neutral),
      'neutralVariant': from(palettes.neutralVariant),
      'error': from(palettes.error),
    };
  }

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
