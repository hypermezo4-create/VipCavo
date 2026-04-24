import 'package:deadzon/features/statusbar/statusbar_board_config.dart';

class StatusbarBoardState {
  const StatusbarBoardState({
    required this.modules,
    required this.leftClusterOffset,
    required this.rightClusterOffset,
  });

  final List<StatusbarBoardModuleState> modules;
  final double leftClusterOffset;
  final double rightClusterOffset;

  StatusbarBoardState copyWith({
    List<StatusbarBoardModuleState>? modules,
    double? leftClusterOffset,
    double? rightClusterOffset,
  }) {
    return StatusbarBoardState(
      modules: modules ?? this.modules,
      leftClusterOffset: leftClusterOffset ?? this.leftClusterOffset,
      rightClusterOffset: rightClusterOffset ?? this.rightClusterOffset,
    );
  }
}

class StatusbarBoardModuleState {
  const StatusbarBoardModuleState({
    required this.module,
    required this.side,
    required this.row,
    required this.orderIndex,
    required this.visible,
    required this.enabled,
    required this.size,
    required this.offsetX,
    required this.offsetY,
  });

  final StatusbarBoardModule module;
  final StatusbarBoardSide side;
  final int row;
  final int orderIndex;
  final bool visible;
  final bool enabled;
  final double size;
  final double offsetX;
  final double offsetY;

  String get id => module.id;
  String get sourceSmaliClass => module.sourceSmaliClass;

  StatusbarBoardModuleState copyWith({
    StatusbarBoardSide? side,
    int? row,
    int? orderIndex,
    bool? visible,
    bool? enabled,
    double? size,
    double? offsetX,
    double? offsetY,
  }) {
    return StatusbarBoardModuleState(
      module: module,
      side: side ?? this.side,
      row: row ?? this.row,
      orderIndex: orderIndex ?? this.orderIndex,
      visible: visible ?? this.visible,
      enabled: enabled ?? this.enabled,
      size: size ?? this.size,
      offsetX: offsetX ?? this.offsetX,
      offsetY: offsetY ?? this.offsetY,
    );
  }
}
