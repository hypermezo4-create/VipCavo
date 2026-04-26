import 'package:deadzon/features/statusbar/data/resize_statusbar_service.dart';
import 'package:deadzon/features/statusbar/data/statusbar_board_model.dart';
import 'package:deadzon/features/statusbar/statusbar_board_config.dart';

class StatusbarBoardService {
  StatusbarBoardService._();

  static const String _refreshIntent = 'my.intent.action.REFRESH_STATUSBAR';

  static Future<StatusbarBoardState> load() async {
    final serialized = await ResizeStatusbarService.readString(
      key: statusbarBoardSerializedKey,
      fallback: statusbarBoardSourceDefaultLayout,
    );
    final parsed = parseSerializedLayout(serialized);
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
    await _sendRefreshIntent();
  }

  static Future<void> writeClusterOffsets({required double left, required double right}) async {
    return;
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
    final candidates = statusbarBoardAllowedPositionCodes.toList(growable: false)
      ..sort((a, b) => (a - around).abs().compareTo((b - around).abs()));
    for (final candidate in candidates) {
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
  static Future<void> _sendRefreshIntent() => ResizeStatusbarService.sendBroadcastIntent(_refreshIntent);
}
