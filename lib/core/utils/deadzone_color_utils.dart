import 'package:flutter/material.dart';

class DeadzoneColorUtils {
  const DeadzoneColorUtils._();

  static int toArgb32(Color color) => color.toARGB32();

  static String toArgbHex(int argb) => '#${argb.toUnsigned(32).toRadixString(16).padLeft(8, '0').toUpperCase()}';

  static int parseHex(String input, {required int fallbackArgb}) {
    final raw = input.trim().replaceAll('#', '').toUpperCase();
    if (raw.length == 8) {
      return int.tryParse(raw, radix: 16) ?? fallbackArgb;
    }
    if (raw.length == 6) {
      final rgb = int.tryParse(raw, radix: 16);
      if (rgb == null) return fallbackArgb;
      return 0xFF000000 | rgb;
    }
    return fallbackArgb;
  }
}
