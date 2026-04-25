import 'package:deadzon/features/statusbar/data/resize_statusbar_service.dart';
import 'package:deadzon/features/statusbar/data/statusbar_board_model.dart';
import 'package:deadzon/features/statusbar/statusbar_board_config.dart';

class StatusbarBoardService {
  StatusbarBoardService._();

  static const String _refreshIntent = 'my.intent.action.REFRESH_STATUSBAR';

  static Future<StatusbarBoardState> load() async {
    final sourcePlacements = _decodeSerializedPlacements(statusbarBoardSourceDefaultLayout);
    final modules = <StatusbarBoardModuleState>[];
    for (final module in statusbarBoardModules) {
      final sourcePlacement = sourcePlacements[module.id];
      final visible = await _readVisible(module);
      final sideValue = await _readInt(module.sideKey, (sourcePlacement?.side ?? module.defaultSide) == StatusbarBoardSide.right ? 1 : 0);
      final row = await _readInt(module.rowKey ?? 'status_bar_element_${module.id}_row', sourcePlacement?.row ?? module.defaultRow);
      final order = await _readInt(module.orderKey, sourcePlacement?.orderIndex ?? module.defaultOrderIndex);
      final offsetX = await _readInt(module.offsetKey, module.defaultOffset.round());
      final enabled = await _readBool(module.enabledKey ?? 'status_bar_element_${module.id}_enabled', module.defaultEnabled);
      final size = await _readInt(module.sizeKey ?? 'status_bar_element_${module.id}_size', (module.defaultSize * 100).round());
      final offsetY = await _readInt(module.offsetYKey ?? 'status_bar_element_${module.id}_offset_y', module.defaultOffsetY.round());
      modules.add(
        StatusbarBoardModuleState(
          module: module,
          side: sideValue == 1 ? StatusbarBoardSide.right : StatusbarBoardSide.left,
          row: row == 2 ? 2 : 1,
          orderIndex: order,
          visible: visible,
          enabled: enabled,
          size: size / 100,
          offsetX: offsetX.toDouble(),
          offsetY: offsetY.toDouble(),
        ),
      );
    }

    final leftCluster = await _readInt(statusbarBoardLeftClusterOffsetKey, 0);
    final rightCluster = await _readInt(statusbarBoardRightClusterOffsetKey, 0);

    return StatusbarBoardState(
      modules: _normalize(modules),
      leftClusterOffset: leftCluster.toDouble(),
      rightClusterOffset: rightCluster.toDouble(),
    );
  }

  static Future<void> writeModules(List<StatusbarBoardModuleState> modules) async {
    for (final module in modules) {
      await Future.wait(<Future<void>>[
        _writeVisible(module),
        _writeBool(module.module.enabledKey ?? 'status_bar_element_${module.id}_enabled', module.enabled),
        _writeInt(module.module.sideKey, module.side == StatusbarBoardSide.right ? 1 : 0),
        _writeInt(module.module.orderKey, module.orderIndex),
        _writeInt(module.module.rowKey ?? 'status_bar_element_${module.id}_row', module.row),
        _writeInt(module.module.offsetKey, module.offsetX.round()),
        _writeInt(module.module.sizeKey ?? 'status_bar_element_${module.id}_size', (module.size * 100).round()),
        _writeInt(module.module.offsetYKey ?? 'status_bar_element_${module.id}_offset_y', module.offsetY.round()),
      ]);
    }
    await _sendRefreshIntent();
  }

  static Future<void> writeClusterOffsets({required double left, required double right}) async {
    await _writeInt(statusbarBoardLeftClusterOffsetKey, left.round());
    await _writeInt(statusbarBoardRightClusterOffsetKey, right.round());
    await _sendRefreshIntent();
  }

  static List<StatusbarBoardModuleState> defaultModules() {
    final sourcePlacements = _decodeSerializedPlacements(statusbarBoardSourceDefaultLayout);
    return _normalize(statusbarBoardModules.map((module) {
      final sourcePlacement = sourcePlacements[module.id];
      return StatusbarBoardModuleState(
        module: module,
        side: sourcePlacement?.side ?? module.defaultSide,
        row: sourcePlacement?.row ?? 1,
        orderIndex: sourcePlacement?.orderIndex ?? module.defaultOrderIndex,
        visible: module.defaultVisible,
        enabled: module.defaultEnabled,
        size: module.defaultSize,
        offsetX: module.defaultOffset,
        offsetY: module.defaultOffsetY,
      );
    }).toList(growable: false));
  }

  static Map<String, _SourcePlacement> _decodeSerializedPlacements(String serialized) {
    final entries = serialized.split(';').where((entry) => entry.contains('.'));
    final ordered = <_DecodedEntry>[];
    for (final entry in entries) {
      final parts = entry.split('.');
      if (parts.length != 2) {
        continue;
      }
      final id = parts.first.trim();
      final code = int.tryParse(parts.last.trim());
      if (id.isEmpty || code == null) {
        continue;
      }
      final decoded = _decodeSideAndRow(code);
      ordered.add(_DecodedEntry(id: id, side: decoded.side, row: decoded.row));
    }

    final orderCounters = <String, int>{};
    final placements = <String, _SourcePlacement>{};
    for (final item in ordered) {
      final key = '${item.side.name}:${item.row}';
      final index = orderCounters[key] ?? 0;
      orderCounters[key] = index + 1;
      placements[item.id] = _SourcePlacement(side: item.side, row: item.row, orderIndex: index);
    }
    return placements;
  }

  static _DecodedSideRow _decodeSideAndRow(int code) {
    if (code >= 40) {
      return const _DecodedSideRow(side: StatusbarBoardSide.right, row: 2);
    }
    if (code >= 30) {
      return const _DecodedSideRow(side: StatusbarBoardSide.right, row: 1);
    }
    if (code >= 20) {
      return const _DecodedSideRow(side: StatusbarBoardSide.left, row: 1);
    }
    if (code >= 10) {
      return const _DecodedSideRow(side: StatusbarBoardSide.left, row: 1);
    }
    if (code >= 4) {
      return const _DecodedSideRow(side: StatusbarBoardSide.left, row: 2);
    }
    if (code <= 1) {
      return const _DecodedSideRow(side: StatusbarBoardSide.left, row: 1);
    }
    return const _DecodedSideRow(side: StatusbarBoardSide.right, row: 1);
  }

  static List<StatusbarBoardModuleState> _normalize(List<StatusbarBoardModuleState> modules) {
    final out = <StatusbarBoardModuleState>[];
    for (final side in <StatusbarBoardSide>[StatusbarBoardSide.left, StatusbarBoardSide.right]) {
      for (var row = 1; row <= 2; row++) {
        final group = modules.where((m) => m.side == side && m.row == row).toList()..sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
        for (var i = 0; i < group.length; i++) {
          out.add(group[i].copyWith(orderIndex: i));
        }
      }
    }
    return out;
  }

  static Future<bool> _readVisible(StatusbarBoardModule module) async {
    if (module.visibilityType == StatusbarVisibilityType.intAsVisible) {
      final value = await _readInt(module.visibilityKey, module.defaultVisible ? 1 : 0);
      return value != 0;
    }
    return _readBool(module.visibilityKey, module.defaultVisible);
  }

  static Future<void> _writeVisible(StatusbarBoardModuleState moduleState) async {
    if (moduleState.module.visibilityType == StatusbarVisibilityType.intAsVisible) {
      await _writeInt(moduleState.module.visibilityKey, moduleState.visible ? 1 : 0);
      return;
    }
    await _writeBool(moduleState.module.visibilityKey, moduleState.visible);
  }

  static Future<int> _readInt(String key, int fallback) => ResizeStatusbarService.readInt(key: key, fallback: fallback);
  static Future<bool> _readBool(String key, bool fallback) => ResizeStatusbarService.readBool(key: key, fallback: fallback);
  static Future<void> _writeInt(String key, int value) => ResizeStatusbarService.writeInt(key: key, value: value);
  static Future<void> _writeBool(String key, bool value) => ResizeStatusbarService.writeBool(key: key, value: value);
  static Future<void> _sendRefreshIntent() => ResizeStatusbarService.sendBroadcastIntent(_refreshIntent);
}

class _SourcePlacement {
  const _SourcePlacement({
    required this.side,
    required this.row,
    required this.orderIndex,
  });

  final StatusbarBoardSide side;
  final int row;
  final int orderIndex;
}

class _DecodedSideRow {
  const _DecodedSideRow({
    required this.side,
    required this.row,
  });

  final StatusbarBoardSide side;
  final int row;
}

class _DecodedEntry {
  const _DecodedEntry({
    required this.id,
    required this.side,
    required this.row,
  });

  final String id;
  final StatusbarBoardSide side;
  final int row;
}
