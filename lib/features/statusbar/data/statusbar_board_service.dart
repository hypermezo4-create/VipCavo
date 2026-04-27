import 'package:deadzon/features/statusbar/data/resize_statusbar_service.dart';
import 'package:deadzon/features/statusbar/data/statusbar_board_model.dart';
import 'package:deadzon/features/statusbar/statusbar_board_config.dart';

class StatusbarBoardService {
  StatusbarBoardService._();

  static Future<StatusbarBoardState> load() async {
    final serialized = await ResizeStatusbarService.readString(
      key: statusbarBoardSerializedKey,
      fallback: statusbarBoardSourceDefaultLayout,
    );
    final parsed = parseSerializedLayout(_normalizeStoredDefaultLayout(serialized));
    final modules = <StatusbarBoardModuleState>[];

    for (final module in statusbarBoardModules) {
      final parsedEntry = parsed[module.id];
      final originalCode = statusbarBoardDefaultCodeById[module.id] ?? 0;
      final currentCode = parsedEntry?.currentPositionCode ?? originalCode;
      final visible = await _readVisible(module);
      final enabled = await _readBool(
        module.enabledKey ?? 'status_bar_element_${module.id}_enabled',
        module.defaultEnabled,
      );
      final size = await _readInt(
        module.sizeKey ?? 'status_bar_element_${module.id}_size',
        (module.defaultSize * 100).round(),
      );
      final offsetX = await _readInt(module.offsetKey, module.defaultOffset.round());
      final offsetY = await _readInt(
        module.offsetYKey ?? 'status_bar_element_${module.id}_offset_y',
        module.defaultOffsetY.round(),
      );

      modules.add(
        StatusbarBoardModuleState(
          module: module,
          originalPositionCode: originalCode,
          currentPositionCode: currentCode,
          asset: module.iconAsset,
          visible: visible,
          enabled: enabled,
          size: size / 100,
          offsetX: offsetX.toDouble(),
          offsetY: offsetY.toDouble(),
        ),
      );
    }

    return StatusbarBoardState(
      modules: _ensureUniqueSlotOrdering(modules),
      leftClusterOffset: 0,
      rightClusterOffset: 0,
    );
  }

  static Future<void> writeModules(List<StatusbarBoardModuleState> modules) async {
    // The arrange board must only write the old Mezo position key.
    // Visibility, size, offsets and enabled flags belong to their own settings screens,
    // so this method intentionally does not force show/hide or rewrite unrelated keys.
    final normalized = _ensureUniqueSlotOrdering(modules);
    await ResizeStatusbarService.writeString(
      key: statusbarBoardSerializedKey,
      value: encodeSerializedLayout(normalized),
    );
    // No broadcast here. Native writeString notifies the Settings URI.
    // The REFRESH_STATUSBAR broadcast is too aggressive on this ROM and can recreate the app.
  }

  static Future<void> writeClusterOffsets({required double left, required double right}) async {
    return;
  }


  static String _normalizeStoredDefaultLayout(String serialized) {
    final compact = serialized.trim();
    const oldSmaliDefault =
        'elem_status.33;elem_clock.21;elem_bat.31;elem_net1.1;elem_net2.11;elem_wifi.2;elem_notif.22;elem_speed.3;elem_weather.32;elem_date.12;';
    const oldEarlyDefault =
        'elem_clock.1;elem_notif.2;elem_bat.11;elem_net1.12;elem_net2.13;elem_wifi.14;elem_speed.15;elem_status.16;elem_prompt.21;elem_date.22;elem_weather.31;';

    // Migrate only the known old defaults. Custom user layouts stay untouched.
    if (compact.isEmpty || compact == oldSmaliDefault || compact == oldEarlyDefault) {
      return statusbarBoardSourceDefaultLayout;
    }
    return serialized;
  }

  static List<StatusbarBoardModuleState> defaultModules() {
    final parsed = parseSerializedLayout(statusbarBoardSourceDefaultLayout);
    return _ensureUniqueSlotOrdering(
      statusbarBoardModules.map((module) {
        final defaultCode = statusbarBoardDefaultCodeById[module.id] ?? 0;
        return StatusbarBoardModuleState(
          module: module,
          originalPositionCode: defaultCode,
          currentPositionCode: parsed[module.id]?.currentPositionCode ?? defaultCode,
          asset: module.iconAsset,
          visible: module.defaultVisible,
          enabled: module.defaultEnabled,
          size: module.defaultSize,
          offsetX: module.defaultOffset,
          offsetY: module.defaultOffsetY,
        );
      }).toList(growable: false),
    );
  }

  static Map<String, StatusbarBoardModuleState> parseSerializedLayout(String serialized) {
    final parsed = <String, StatusbarBoardModuleState>{};
    final entries = serialized.split(';').where((entry) => entry.contains('.'));
    for (final entry in entries) {
      final parts = entry.split('.');
      if (parts.length != 2) {
        continue;
      }
      final id = parts.first.trim();
      final code = int.tryParse(parts.last.trim());
      final module = statusbarBoardModulesById[id];
      if (id.isEmpty || code == null || module == null) {
        continue;
      }
      final originalCode = statusbarBoardDefaultCodeById[id] ?? code;
      parsed[id] = StatusbarBoardModuleState(
        module: module,
        originalPositionCode: originalCode,
        currentPositionCode: code,
        asset: module.iconAsset,
        visible: module.defaultVisible,
        enabled: module.defaultEnabled,
        size: module.defaultSize,
        offsetX: module.defaultOffset,
        offsetY: module.defaultOffsetY,
      );
    }
    return parsed;
  }

  static String encodeSerializedLayout(List<StatusbarBoardModuleState> modules) {
    final sortedByLegacyOrder = modules.toList(growable: false)
      ..sort((a, b) => a.module.legacyIndex.compareTo(b.module.legacyIndex));
    final buffer = StringBuffer();
    for (final module in sortedByLegacyOrder) {
      buffer
        ..write(module.id)
        ..write('.')
        ..write(module.currentPositionCode)
        ..write(';');
    }
    return buffer.toString();
  }

  static List<StatusbarBoardModuleState> _ensureUniqueSlotOrdering(List<StatusbarBoardModuleState> modules) {
    final bySlot = <int, List<StatusbarBoardModuleState>>{};
    for (final module in modules) {
      bySlot.putIfAbsent(module.currentPositionCode, () => <StatusbarBoardModuleState>[]).add(module);
    }

    final updated = modules.toList(growable: true);
    for (final entry in bySlot.entries) {
      final colliding = entry.value;
      if (colliding.length <= 1) {
        continue;
      }
      colliding.sort((a, b) => a.module.legacyIndex.compareTo(b.module.legacyIndex));
      for (var i = 1; i < colliding.length; i++) {
        final candidate = colliding[i];
        final nextCode = _findNearestEmptyCode(entry.key, updated.map((m) => m.currentPositionCode).toSet());
        final index = updated.indexWhere((m) => m.id == candidate.id);
        updated[index] = candidate.copyWith(currentPositionCode: nextCode);
      }
    }
    return updated;
  }

  static int _findNearestEmptyCode(int around, Set<int> occupied) {
    final sector = (around ~/ 10) * 10;
    for (var i = 1; i <= 9; i++) {
      final candidate = sector + i;
      if (!occupied.contains(candidate)) {
        return candidate;
      }
    }
    return around;
  }

  static Future<bool> _readVisible(StatusbarBoardModule module) async {
    if (module.visibilityType == StatusbarVisibilityType.intAsVisible) {
      final value = await _readInt(module.visibilityKey, module.defaultVisible ? 1 : 0);
      return value != 0;
    }
    return _readBool(module.visibilityKey, module.defaultVisible);
  }

  static Future<int> _readInt(String key, int fallback) => ResizeStatusbarService.readInt(key: key, fallback: fallback);
  static Future<bool> _readBool(String key, bool fallback) => ResizeStatusbarService.readBool(key: key, fallback: fallback);
}
