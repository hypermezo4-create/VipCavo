import 'package:deadzon/core/services/android_intent_bridge.dart';
import 'package:deadzon/features/statusbar/data/resize_statusbar_service.dart';
import 'package:deadzon/features/statusbar/data/statusbar_board_model.dart';
import 'package:deadzon/features/statusbar/statusbar_board_config.dart';

class StatusbarBoardService {
  StatusbarBoardService._();

  static const String _refreshIntent = 'my.intent.action.REFRESH_STATUSBAR';

  /// Load exactly what SystemUI/Settings currently stores when it is safe.
  ///
  /// PositionsElementsStatusbarDouble is the source for this board. It supports
  /// exactly the 10 legacy elements below and resets any value containing
  /// elem_prompt, so the app mirrors that behavior and falls back to the approved
  /// visual default instead of previewing a broken/foreign layout.
  static Future<StatusbarBoardState> load() async {
    final serialized = await AndroidIntentBridge.readString(
      statusbarBoardSerializedKey,
      defaultValue: statusbarBoardSourceDefaultLayout,
    );
    final safeSerialized = _isValidSerializedLayout(serialized)
        ? serialized
        : statusbarBoardSourceDefaultLayout;
    final parsed = parseSerializedLayout(safeSerialized);
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
          currentPositionCode: _safePositionCode(currentCode, fallback: originalCode),
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

  /// Save the current board order only.
  ///
  /// This writes status_bar_elem_position only. It never touches visibility,
  /// show/hide, clock, alarm, battery, notification, or prompt keys. The native
  /// Writes through the normal system/priv-app path only.
  static Future<bool> writeModules(List<StatusbarBoardModuleState> modules) async {
    final normalized = _ensureUniqueSlotOrdering(modules);
    final encoded = encodeSerializedLayout(normalized);
    final current = await AndroidIntentBridge.readString(
      statusbarBoardSerializedKey,
      defaultValue: '',
    );

    if (_normalizeSerialized(current) == _normalizeSerialized(encoded)) {
      return true;
    }

    return AndroidIntentBridge.writeString(
      statusbarBoardSerializedKey,
      encoded,
    );
  }

  static Future<bool> applyStatusbarRefresh() {
    return AndroidIntentBridge.sendDeadzonBroadcast(_refreshIntent);
  }

  static Future<bool> canWriteSystemSettings() {
    return AndroidIntentBridge.canWriteSystemSettings();
  }

  static Future<bool> openWriteSettingsPage() {
    return AndroidIntentBridge.openWriteSettingsPanel();
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
        currentPositionCode: _safePositionCode(code, fallback: originalCode),
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
        ..write(_safePositionCode(module.currentPositionCode, fallback: module.originalPositionCode))
        ..write(';');
    }
    return buffer.toString();
  }

  static bool _isValidSerializedLayout(String serialized) {
    if (serialized.trim().isEmpty || serialized.contains('elem_prompt')) {
      return false;
    }
    final parsed = parseSerializedLayout(serialized);
    if (parsed.length != statusbarBoardModules.length) {
      return false;
    }
    final seenCodes = <int>{};
    for (final module in statusbarBoardModules) {
      final entry = parsed[module.id];
      if (entry == null) {
        return false;
      }
      if (!statusbarBoardAllowedPositionCodes.contains(entry.currentPositionCode)) {
        return false;
      }
      if (!seenCodes.add(entry.currentPositionCode)) {
        return false;
      }
    }
    return true;
  }

  static String _normalizeSerialized(String serialized) {
    if (!_isValidSerializedLayout(serialized)) {
      return '';
    }
    return encodeSerializedLayout(_ensureUniqueSlotOrdering(parseSerializedLayout(serialized).values.toList(growable: false)));
  }

  static List<StatusbarBoardModuleState> _ensureUniqueSlotOrdering(List<StatusbarBoardModuleState> modules) {
    final updated = modules
        .map(
          (module) => module.copyWith(
            currentPositionCode: _safePositionCode(
              module.currentPositionCode,
              fallback: module.originalPositionCode,
            ),
          ),
        )
        .toList(growable: true);

    final bySlot = <int, List<StatusbarBoardModuleState>>{};
    for (final module in updated) {
      bySlot.putIfAbsent(module.currentPositionCode, () => <StatusbarBoardModuleState>[]).add(module);
    }

    for (final entry in bySlot.entries) {
      final colliding = entry.value;
      if (colliding.length <= 1) {
        continue;
      }
      colliding.sort((a, b) => a.module.legacyIndex.compareTo(b.module.legacyIndex));
      for (var i = 1; i < colliding.length; i++) {
        final candidate = colliding[i];
        final occupied = updated.map((module) => module.currentPositionCode).toSet();
        final nextCode = _findNearestEmptyCode(entry.key, occupied);
        final index = updated.indexWhere((module) => module.module.id == candidate.module.id);
        if (index != -1) {
          updated[index] = candidate.copyWith(currentPositionCode: nextCode);
        }
      }
    }
    return updated;
  }

  static int _safePositionCode(int code, {required int fallback}) {
    if (statusbarBoardAllowedPositionCodes.contains(code)) {
      return code;
    }
    if (statusbarBoardAllowedPositionCodes.contains(fallback)) {
      return fallback;
    }
    return statusbarBoardAllowedPositionCodes.first;
  }

  static int _findNearestEmptyCode(int around, Set<int> occupied) {
    final sectorStart = _sectorStartForCode(around);
    for (var i = 0; i < 9; i++) {
      final candidate = sectorStart + i;
      if (statusbarBoardAllowedPositionCodes.contains(candidate) && !occupied.contains(candidate)) {
        return candidate;
      }
    }
    return _safePositionCode(around, fallback: statusbarBoardAllowedPositionCodes.first);
  }

  static int _sectorStartForCode(int code) {
    if (code >= 31 && code <= 39) {
      return 31;
    }
    if (code >= 21 && code <= 29) {
      return 21;
    }
    if (code >= 11 && code <= 19) {
      return 11;
    }
    return 1;
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
