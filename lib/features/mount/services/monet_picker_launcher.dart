import 'dart:ui' show Color;

import 'package:deadzon/features/mount/domain/mount_palette.dart';
import 'package:flutter/services.dart';

class MonetPickerLauncher {
  const MonetPickerLauncher();

  static const MethodChannel _channel = MethodChannel('deadzon/mezo_settings');

  Future<bool> launchMonetPicker() async {
    try {
      final launched = await _channel.invokeMethod<bool>('launchMonetPicker');
      return launched == true;
    } catch (_) {
      return false;
    }
  }

  Future<List<WallpaperColorSet>> getWallpaperColors() async {
    try {
      final payload = await _channel.invokeMethod<Map<Object?, Object?>>('getWallpaperColors');
      if (payload == null) {
        return const <WallpaperColorSet>[];
      }
      final available = payload['available'] == true;
      if (!available) {
        final message = (payload['message'] as String?) ?? 'Wallpaper colors are not available on this ROM.';
        return <WallpaperColorSet>[
          WallpaperColorSet(source: 'system', primary: null, secondary: null, tertiary: null, available: false, message: message),
          WallpaperColorSet(source: 'lock', primary: null, secondary: null, tertiary: null, available: false, message: message),
        ];
      }

      WallpaperColorSet parse(String key) {
        final map = payload[key] as Map<Object?, Object?>?;
        Color? c(String id) => map?[id] is int ? Color(map![id] as int) : null;
        return WallpaperColorSet(
          source: key,
          primary: c('primary'),
          secondary: c('secondary'),
          tertiary: c('tertiary'),
          available: map != null,
        );
      }

      return <WallpaperColorSet>[parse('system'), parse('lock')];
    } catch (_) {
      return const <WallpaperColorSet>[
        WallpaperColorSet(
          source: 'system',
          primary: null,
          secondary: null,
          tertiary: null,
          available: false,
          message: 'Wallpaper colors are not available on this ROM.',
        ),
      ];
    }
  }
}
