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
    required this.visible,
    required this.order,
    required this.offset,
  });

  final StatusbarBoardModule module;
  final StatusbarBoardSide side;
  final bool visible;
  final int order;
  final double offset;

  String get id => module.id;

  StatusbarBoardModuleState copyWith({
    StatusbarBoardSide? side,
    bool? visible,
    int? order,
    double? offset,
  }) {
    return StatusbarBoardModuleState(
      module: module,
      side: side ?? this.side,
      visible: visible ?? this.visible,
      order: order ?? this.order,
      offset: offset ?? this.offset,
    );
  }
}
