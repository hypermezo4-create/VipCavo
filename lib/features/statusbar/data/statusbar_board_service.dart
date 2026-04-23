import 'package:deadzon/features/statusbar/data/resize_statusbar_service.dart';
import 'package:deadzon/features/statusbar/data/statusbar_board_model.dart';
import 'package:deadzon/features/statusbar/statusbar_board_config.dart';

class StatusbarBoardService {
  StatusbarBoardService._();

  static const String _refreshIntent = 'my.intent.action.REFRESH_STATUSBAR';

  static Future<StatusbarBoardState> load() async {
    final modules = <StatusbarBoardModuleState>[];
    for (var index = 0; index < statusbarBoardModules.length; index++) {
      final module = statusbarBoardModules[index];
      final visible = await _readVisible(module);
      final sideValue = await _readInt(module.sideKey, module.defaultSide == StatusbarBoardSide.left ? 0 : 1);
      final order = await _readInt(module.orderKey, index);
      final offset = await _readInt(module.offsetKey, module.defaultOffset.round());
      modules.add(
        StatusbarBoardModuleState(
          module: module,
          side: sideValue == 0 ? StatusbarBoardSide.left : StatusbarBoardSide.right,
          visible: visible,
          order: order,
          offset: offset.toDouble(),
        ),
      );
    }

    modules.sort((a, b) => a.order.compareTo(b.order));

    final leftCluster = await _readInt(statusbarBoardLeftClusterOffsetKey, 0);
    final rightCluster = await _readInt(statusbarBoardRightClusterOffsetKey, 0);

    return StatusbarBoardState(
      modules: modules,
      leftClusterOffset: leftCluster.toDouble(),
      rightClusterOffset: rightCluster.toDouble(),
    );
  }

  static Future<void> writeModule(StatusbarBoardModuleState module) async {
    await Future.wait(<Future<void>>[
      _writeVisible(module),
      _writeInt(module.module.sideKey, module.side == StatusbarBoardSide.left ? 0 : 1),
      _writeInt(module.module.orderKey, module.order),
      _writeInt(module.module.offsetKey, module.offset.round()),
    ]);
    await _sendRefreshIntent();
  }

  static Future<void> writeModules(List<StatusbarBoardModuleState> modules) async {
    for (final module in modules) {
      await writeModule(module);
    }
  }

  static Future<void> writeClusterOffsets({required double left, required double right}) async {
    await _writeInt(statusbarBoardLeftClusterOffsetKey, left.round());
    await _writeInt(statusbarBoardRightClusterOffsetKey, right.round());
    await _sendRefreshIntent();
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

  static Future<int> _readInt(String key, int fallback) {
    return ResizeStatusbarService.readInt(key: key, fallback: fallback);
  }

  static Future<bool> _readBool(String key, bool fallback) {
    return ResizeStatusbarService.readBool(key: key, fallback: fallback);
  }

  static Future<void> _writeInt(String key, int value) {
    return ResizeStatusbarService.writeInt(key: key, value: value);
  }

  static Future<void> _writeBool(String key, bool value) {
    return ResizeStatusbarService.writeBool(key: key, value: value);
  }

  static Future<void> _sendRefreshIntent() {
    return ResizeStatusbarService.sendBroadcastIntent(_refreshIntent);
  }
}
