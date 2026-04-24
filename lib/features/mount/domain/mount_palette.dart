import 'package:flutter/material.dart';

class MountPalette {
  const MountPalette({
    required this.id,
    required this.name,
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.backgroundTint,
    required this.accent,
    required this.previewGradient,
  });

  final String id;
  final String name;
  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color backgroundTint;
  final Color accent;
  final List<Color> previewGradient;
}

class WallpaperColorSet {
  const WallpaperColorSet({
    required this.source,
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.available,
    this.message,
  });

  final String source;
  final Color? primary;
  final Color? secondary;
  final Color? tertiary;
  final bool available;
  final String? message;
}
