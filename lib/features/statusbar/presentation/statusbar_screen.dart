import 'dart:async';
import 'dart:io';

import 'package:deadzon/core/theme/design_tokens.dart';
import 'package:deadzon/core/theme/deadzon_theme_controller.dart';
import 'package:deadzon/core/utils/deadzone_color_utils.dart';
import 'package:deadzon/core/widgets/deadzone_color_picker_sheet.dart';
import 'package:deadzon/core/widgets/glass_card.dart';
import 'package:deadzon/core/widgets/premium_top_bar.dart';
import 'package:deadzon/core/widgets/section_header.dart';
import 'package:deadzon/core/widgets/settings_row.dart';
import 'package:deadzon/features/statusbar/data/mezo_resize_source.dart';
import 'package:deadzon/features/statusbar/data/resize_statusbar_service.dart';
import 'package:deadzon/features/statusbar/data/statusbar_board_model.dart';
import 'package:deadzon/features/statusbar/data/statusbar_board_service.dart';
import 'package:deadzon/features/statusbar/data/statusbar_settings_repository.dart';
import 'package:deadzon/features/statusbar/mezo_port_map.dart';
import 'package:deadzon/features/statusbar/presentation/mezo_controls.dart';
import 'package:deadzon/features/statusbar/statusbar_board_config.dart';
import 'package:deadzon/features/statusbar/statusbar_detail_content.dart';
import 'package:deadzon/features/statusbar/statusbar_mapper.dart';
import 'package:deadzon/features/statusbar/statusbar_models.dart';
import 'package:deadzon/features/statusbar/statusbar_section_configs.dart';
import 'package:deadzon/features/statusbar/statusbar_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusbarScreen extends StatefulWidget {
  const StatusbarScreen({super.key});

  @override
  State<StatusbarScreen> createState() => _StatusbarScreenState();
}

class _StatusbarScreenState extends State<StatusbarScreen> {
  List<StatusbarBoardModuleState> _boardModules = StatusbarBoardService.defaultModules();
  bool _isHydrating = true;
  bool _isSavingLayout = false;
  bool _isApplyingLayout = false;

  @override
  void initState() {
    super.initState();
    _hydrateStatusbarBoard();
  }

  Future<void> _hydrateStatusbarBoard() async {
    try {
      final state = await StatusbarBoardService.load();
      if (!mounted) {
        return;
      }
      setState(() {
        _boardModules = state.modules;
        _isHydrating = false;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _boardModules = StatusbarBoardService.defaultModules();
        _isHydrating = false;
      });
    }
  }

  Future<void> _restoreDefaultLayout() async {
    final defaults = StatusbarBoardService.defaultModules();
    setState(() {
      _boardModules = defaults;
      _isSavingLayout = true;
    });
    try {
      final written = await StatusbarBoardService.writeModules(defaults);
      if (written) {
        _showMessage('Default layout saved. Tap Apply to refresh SystemUI.');
      } else {
        _showMessage(
          'Default loaded locally. Allow system write to save it.',
          actionLabel: 'Allow',
          onAction: () { _openWriteSettingsPage(); },
        );
      }
    } catch (_) {
      _showMessage(
        'Default loaded locally. Allow system write to save it.',
        actionLabel: 'Allow',
        onAction: () { _openWriteSettingsPage(); },
      );
    } finally {
      if (mounted) {
        setState(() => _isSavingLayout = false);
      }
    }
  }

  Future<void> _openWriteSettingsPage() async {
    await StatusbarBoardService.openWriteSettingsPage();
  }

  Future<void> _applyCurrentLayout() async {
    if (_isApplyingLayout) {
      return;
    }
    setState(() => _isApplyingLayout = true);
    try {
      final written = await StatusbarBoardService.writeModules(_boardModules);
      if (!written) {
        _showMessage(
          'Saved locally only. Allow system write first.',
          actionLabel: 'Allow',
          onAction: () { _openWriteSettingsPage(); },
        );
        return;
      }

      final applied = await StatusbarBoardService.applyStatusbarRefresh();
      _showMessage(applied ? 'Apply request sent to SystemUI' : 'Saved, but SystemUI refresh did not respond');
    } catch (_) {
      _showMessage('Apply failed. Layout kept locally.');
    } finally {
      if (mounted) {
        setState(() => _isApplyingLayout = false);
      }
    }
  }

  void _openSection(String sectionId) {
    final section = StatusbarSectionConfigs.values.firstWhere((item) => item.id == sectionId);
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => StatusbarDetailScreen(section: section),
      ),
    );
  }

  Future<void> _openArrangeSheet() async {
    final result = await showModalBottomSheet<List<StatusbarBoardModuleState>>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _ArrangeLayoutSheet(
        modules: _boardModules,
        onSaved: (modules) {
          if (!mounted) {
            return;
          }
          setState(() => _boardModules = modules);
        },
      ),
    );
    if (result == null || !mounted) {
      return;
    }
    setState(() => _boardModules = result);
  }

  void _showMessage(
    String message, {
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: DeadzonThemeTokens.textPrimary(context), fontWeight: FontWeight.w700),
        ),
        action: actionLabel == null || onAction == null
            ? null
            : SnackBarAction(
                label: actionLabel,
                textColor: DeadzonThemeTokens.accent(context),
                onPressed: onAction,
              ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(18, 0, 18, 112),
        duration: const Duration(milliseconds: 2200),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 0,
        backgroundColor: DeadzonThemeTokens.sheetBackground(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            DeadzonThemeTokens.appBackground(context),
            DeadzonThemeTokens.pageBackground(context),
            DeadzonThemeTokens.pageBackground(context).withValues(alpha: 0.92),
          ],
        ),
      ),
      child: SafeArea(
        child: AnimatedSwitcher(
          duration: DesignTokens.motionFast,
          child: _isHydrating
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  padding: EdgeInsets.fromLTRB(14, 10, 14, MediaQuery.paddingOf(context).bottom + 132),
                  children: <Widget>[
                    const PremiumTopBar(
                      title: 'Statusbar adjustment',
                      subtitle: 'Compact statusbar controls',
                    ),
                    const SizedBox(height: 18),
                    _StatusbarLivePreview(modules: _boardModules),
                    const SizedBox(height: 14),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: _StudioActionButton(
                            label: 'Arrange layout',
                            icon: Icons.open_with_rounded,
                            onTap: () {
                              _openArrangeSheet();
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _StudioActionButton(
                            label: _isSavingLayout ? 'Saving...' : 'Restore layout',
                            icon: Icons.restore_rounded,
                            onTap: _isSavingLayout
                                ? null
                                : () {
                                    _restoreDefaultLayout();
                                  },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _StudioActionButton(
                      label: _isApplyingLayout ? 'Applying...' : 'Apply to SystemUI',
                      icon: Icons.flash_on_rounded,
                      onTap: _isApplyingLayout ? null : _applyCurrentLayout,
                    ),
                    const SizedBox(height: 22),
                    const SectionHeader(
                      title: 'Statusbar sections',
                      subtitle: 'Compact organized tools'
                    ),
                    const SizedBox(height: 12),
                    _FullSectionGrid(onOpenSection: _openSection),
                  ],
                ),
        ),
      ),
    );
  }
}

class _StatusbarLivePreview extends StatelessWidget {
  const _StatusbarLivePreview({required this.modules});

  final List<StatusbarBoardModuleState> modules;

  @override
  Widget build(BuildContext context) {
    return _MezoIconBoard(
      modules: modules,
      compact: true,
    );
  }
}

class _ArrangeLayoutSheet extends StatefulWidget {
  const _ArrangeLayoutSheet({
    required this.modules,
    required this.onSaved,
  });

  final List<StatusbarBoardModuleState> modules;
  final ValueChanged<List<StatusbarBoardModuleState>> onSaved;

  @override
  State<_ArrangeLayoutSheet> createState() => _ArrangeLayoutSheetState();
}

class _ArrangeLayoutSheetState extends State<_ArrangeLayoutSheet> {
  late List<StatusbarBoardModuleState> _modules;
  bool _isSaving = false;
  bool _isApplying = false;

  @override
  void initState() {
    super.initState();
    _modules = widget.modules.map((module) => module.copyWith()).toList(growable: true);
  }

  void _moveModule(String id, int targetCode) {
    if (!statusbarBoardAllowedPositionCodes.contains(targetCode)) {
      return;
    }
    final sourceIndex = _modules.indexWhere((module) => module.id == id);
    if (sourceIndex == -1) {
      return;
    }
    final source = _modules[sourceIndex];
    if (source.currentPositionCode == targetCode) {
      return;
    }
    final occupiedIndex = _modules.indexWhere((module) => module.currentPositionCode == targetCode);
    setState(() {
      if (occupiedIndex != -1) {
        final occupied = _modules[occupiedIndex];
        _modules[occupiedIndex] = occupied.copyWith(currentPositionCode: source.currentPositionCode);
      }
      _modules[sourceIndex] = source.copyWith(currentPositionCode: targetCode);
    });
  }

  void _dropOnBoard(String id, Offset localOffset, Size boardSize) {
    final sourceIndex = _modules.indexWhere((module) => module.id == id);
    final source = sourceIndex == -1 ? null : _modules[sourceIndex];
    if (source == null) {
      return;
    }

    final tileSize = _tileSizeForBoard(boardSize.height, compact: false);
    final nearestCode = _nearestCodeFromBoardOffset(
      offset: localOffset,
      boardSize: boardSize,
      tileSize: tileSize,
    );
    if (nearestCode == null) {
      return;
    }
    _moveModule(id, nearestCode);
  }

  void _resetToDefault() {
    setState(() => _modules = StatusbarBoardService.defaultModules());
    widget.onSaved(_modules.map((module) => module.copyWith()).toList(growable: false));
    _showSheetMessage('Default loaded. Tap Save to store it.');
  }

  Future<void> _saveCurrentLayout() async {
    if (_isSaving) {
      return;
    }
    final snapshot = _modules.map((module) => module.copyWith()).toList(growable: false);
    setState(() => _isSaving = true);
    try {
      final written = await StatusbarBoardService.writeModules(snapshot);
      widget.onSaved(snapshot);
      if (written) {
        _showSheetMessage('Layout saved. Apply when you want SystemUI to refresh.');
      } else {
        _showSheetMessage(
          'Saved in preview only. Allow system write first.',
          actionLabel: 'Allow',
          onAction: () { _openWriteSettingsPage(); },
        );
      }
    } catch (_) {
      widget.onSaved(snapshot);
      _showSheetMessage(
        'Saved in preview only. Allow system write first.',
        actionLabel: 'Allow',
        onAction: () { _openWriteSettingsPage(); },
      );
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Future<void> _applyCurrentLayout() async {
    if (_isApplying) {
      return;
    }
    final snapshot = _modules.map((module) => module.copyWith()).toList(growable: false);
    setState(() => _isApplying = true);
    try {
      final written = await StatusbarBoardService.writeModules(snapshot);
      widget.onSaved(snapshot);
      if (!written) {
        _showSheetMessage(
          'Saved in preview only. Allow system write first.',
          actionLabel: 'Allow',
          onAction: () { _openWriteSettingsPage(); },
        );
        return;
      }
      final applied = await StatusbarBoardService.applyStatusbarRefresh();
      _showSheetMessage(applied ? 'Apply request sent to SystemUI' : 'Saved, but SystemUI refresh did not respond');
    } catch (_) {
      widget.onSaved(snapshot);
      _showSheetMessage('Apply failed. Layout kept in preview.');
    } finally {
      if (mounted) {
        setState(() => _isApplying = false);
      }
    }
  }

  Future<void> _openWriteSettingsPage() async {
    await StatusbarBoardService.openWriteSettingsPage();
  }

  void _showSheetMessage(
    String message, {
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        action: actionLabel == null || onAction == null
            ? null
            : SnackBarAction(
                label: actionLabel,
                textColor: const Color(0xFF8DE8FF),
                onPressed: onAction,
              ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(18, 0, 18, 112),
        duration: const Duration(milliseconds: 2200),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 0,
        backgroundColor: const Color(0xFF10335A),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.80,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF071121),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          border: Border.all(color: const Color(0xFF5BA6FF).withValues(alpha: 0.22)),
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.black.withValues(alpha: 0.45), blurRadius: 30, offset: const Offset(0, -12)),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              Container(width: 44, height: 5, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(100))),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 12, 0),
                child: Row(
                  children: <Widget>[
                    TextButton(onPressed: _resetToDefault, child: const Text('Restore layout')),
                    Expanded(
                      child: Text(
                        'Mezo Position Board',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w900),
                      ),
                    ),
                    TextButton(
                      onPressed: _isSaving ? null : _saveCurrentLayout,
                      child: Text(_isSaving ? 'Saving...' : 'Save'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).padding.bottom + 118),
                  child: Column(
                    children: <Widget>[
                      _MezoIconBoard(
                        modules: _modules,
                        onDropInLane: _dropOnBoard,
                        compact: false,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Save stores the layout only. Apply refreshes SystemUI when you choose.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.64), height: 1.25),
                      ),
                      const SizedBox(height: 12),
                      _StudioActionButton(
                        label: _isApplying ? 'Applying...' : 'Apply to SystemUI',
                        icon: Icons.flash_on_rounded,
                        onTap: _isApplying ? null : _applyCurrentLayout,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class _MezoIconBoard extends StatelessWidget {
  const _MezoIconBoard({
    required this.modules,
    this.onDropInLane,
    this.compact = false,
  });

  final List<StatusbarBoardModuleState> modules;
  final void Function(String id, Offset localOffset, Size boardSize)? onDropInLane;
  final bool compact;

  bool get _interactive => onDropInLane != null;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final boardHeight = (compact ? width * 0.47 : width * 0.49).clamp(
          compact ? 146.0 : 174.0,
          compact ? 184.0 : 218.0,
        ).toDouble();
        final tileSize = _tileSizeForBoard(boardHeight, compact: compact);

        return DragTarget<String>(
          onWillAcceptWithDetails: (_) => _interactive,
          onAcceptWithDetails: (details) {
            if (!_interactive) {
              return;
            }
            final box = context.findRenderObject() as RenderBox?;
            if (box == null) {
              return;
            }
            final localOffset = box.globalToLocal(details.offset);
            final boardSize = Size(width, boardHeight);
            onDropInLane!(details.data, localOffset, boardSize);
          },
          builder: (context, candidates, rejected) {
            final hovering = candidates.isNotEmpty;
            return AnimatedContainer(
              duration: DesignTokens.motionFast,
              curve: DesignTokens.motionCurve,
              height: boardHeight,
              decoration: BoxDecoration(
                color: const Color(0xFF020309),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: hovering
                      ? const Color(0xFFB661FF).withValues(alpha: 0.96)
                      : const Color(0xFF8A24FF).withValues(alpha: 0.86),
                  width: hovering ? 1.6 : 1.1,
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: const Color(0xFF792BFF).withValues(alpha: hovering ? 0.32 : 0.20),
                    blurRadius: hovering ? 28 : 20,
                    offset: const Offset(0, 10),
                  ),
                  BoxShadow(color: const Color(0xFF43D7FF).withValues(alpha: 0.08), blurRadius: 16),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(19),
                child: Stack(
                  clipBehavior: Clip.hardEdge,
                  children: <Widget>[
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            center: Alignment.topRight,
                            radius: 1.45,
                            colors: <Color>[
                              const Color(0xFF101B31).withValues(alpha: 0.24),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: boardHeight * 0.54 - 4,
                      child: Container(
                        height: 10,
                        color: const Color(0xFF777A80).withValues(alpha: 0.58),
                      ),
                    ),
                    Positioned(
                      top: 18,
                      bottom: 18,
                      left: width / 2 - 0.9,
                      child: Container(width: 1.8, color: Colors.white.withValues(alpha: 0.86)),
                    ),
                    ...modules.map(
                      (module) {
                        final position = _visualPositionForCode(
                          code: module.currentPositionCode,
                          boardSize: Size(width, boardHeight),
                          tileSize: tileSize,
                        );
                        return AnimatedPositioned(
                          duration: DesignTokens.motionMedium,
                          curve: DesignTokens.motionCurve,
                          left: position.dx,
                          top: position.dy,
                          child: _StatusbarIconTile(
                            module: module,
                            draggable: _interactive,
                            compact: compact,
                            size: tileSize,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _StatusbarIconTile extends StatelessWidget {
  const _StatusbarIconTile({
    required this.module,
    required this.draggable,
    required this.compact,
    required this.size,
  });

  final StatusbarBoardModuleState module;
  final bool draggable;
  final bool compact;
  final Size size;

  @override
  Widget build(BuildContext context) {
    final child = SizedBox(
      width: size.width,
      height: size.height,
      child: Image.asset(
        module.asset,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
        errorBuilder: (_, _, _) => DecoratedBox(
          decoration: BoxDecoration(
            color: const Color(0xFF0E1220),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: module.module.color.withValues(alpha: 0.78)),
          ),
          child: Icon(module.module.icon, size: 16, color: Colors.white),
        ),
      ),
    );

    if (!draggable) {
      return child;
    }
    return Draggable<String>(
      data: module.id,
      feedback: Material(
        color: Colors.transparent,
        child: Transform.scale(scale: 1.08, child: child),
      ),
      childWhenDragging: Opacity(opacity: 0.26, child: child),
      child: child,
    );
  }
}

class _StudioActionButton extends StatelessWidget {
  const _StudioActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        backgroundColor: const Color(0xFF07111F).withValues(alpha: onTap == null ? 0.42 : 0.76),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: const Color(0xFF68DFFF).withValues(alpha: 0.42)),
        ),
      ),
      icon: Icon(icon, size: 18, color: const Color(0xFF8DE8FF)),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
    );
  }
}



int? _nearestCodeFromBoardOffset({
  required Offset offset,
  required Size boardSize,
  required Size tileSize,
}) {
  final lane = _laneForBoardOffset(offset, boardSize);
  final codes = lane.codes;
  if (codes.isEmpty) {
    return null;
  }

  final splitY = _boardSplitY(boardSize.height);
  final horizontalBandHeight = _boardBandHeight(boardSize.height);
  final topRowCenterY = _boardTopY(tileSize);
  final bottomRowCenterY = splitY + horizontalBandHeight / 2 + _boardBottomInset(boardSize.height) + tileSize.height / 2;
  final isBottomLane = lane == _BoardLane.leftBottom || lane == _BoardLane.rightBottom;
  final rowCenterY = isBottomLane ? bottomRowCenterY : topRowCenterY + tileSize.height / 2;

  var bestCode = codes.first;
  var bestDistance = double.infinity;
  for (final code in codes) {
    final topLeft = _visualPositionForCode(
      code: code,
      boardSize: boardSize,
      tileSize: tileSize,
    );
    final center = Offset(
      topLeft.dx + tileSize.width / 2,
      topLeft.dy + tileSize.height / 2,
    );
    // Make horizontal position the primary snap signal, like the old Mezo board.
    // Vertical distance only decides top/bottom lane, not random cross-row snaps.
    final distance = (center.dx - offset.dx) * (center.dx - offset.dx) +
        (rowCenterY - offset.dy) * (rowCenterY - offset.dy) * 0.18;
    if (distance < bestDistance) {
      bestDistance = distance;
      bestCode = code;
    }
  }
  return bestCode;
}

_BoardLane _laneForBoardOffset(Offset offset, Size boardSize) {
  final splitY = _boardSplitY(boardSize.height);
  final centerX = boardSize.width / 2;
  final isBottom = offset.dy >= splitY;
  final isRight = offset.dx >= centerX;
  if (isBottom && isRight) {
    return _BoardLane.rightBottom;
  }
  if (isBottom) {
    return _BoardLane.leftBottom;
  }
  if (isRight) {
    return _BoardLane.rightTop;
  }
  return _BoardLane.leftTop;
}

_BoardLane _laneForCode(int code) {
  if (code >= 31 && code <= 39) {
    return _BoardLane.rightBottom;
  }
  if (code >= 21 && code <= 29) {
    return _BoardLane.leftBottom;
  }
  if (code >= 11 && code <= 19) {
    return _BoardLane.rightTop;
  }
  return _BoardLane.leftTop;
}

Offset _visualPositionForCode({
  required int code,
  required Size boardSize,
  required Size tileSize,
}) {
  final lane = _laneForCode(code);
  final step = _boardStep(tileSize);
  final leftPadding = _boardHorizontalInset(boardSize.width);
  final rightPadding = _boardHorizontalInset(boardSize.width);
  final splitY = _boardSplitY(boardSize.height);
  final horizontalBandHeight = _boardBandHeight(boardSize.height);
  final topY = _boardTopY(tileSize);
  final bottomY = splitY + horizontalBandHeight / 2 + _boardBottomInset(boardSize.height);
  final maxX = boardSize.width - rightPadding - tileSize.width;

  final double x = switch (lane) {
    _BoardLane.leftTop => leftPadding + (code - 1) * step,
    _BoardLane.rightTop => maxX - (code - 11) * step,
    _BoardLane.leftBottom => leftPadding + (code - 21) * step,
    _BoardLane.rightBottom => maxX - (code - 31) * step,
  };

  final y = switch (lane) {
    _BoardLane.leftTop || _BoardLane.rightTop => topY,
    _BoardLane.leftBottom || _BoardLane.rightBottom => bottomY,
  };

  return Offset(
    x.clamp(6.0, boardSize.width - tileSize.width - 6).toDouble(),
    y.clamp(6.0, boardSize.height - tileSize.height - 6).toDouble(),
  );
}

double _boardSplitY(double boardHeight) => boardHeight * 0.54;

double _boardBandHeight(double boardHeight) => (boardHeight * 0.055).clamp(7.0, 10.0).toDouble();

double _boardTopY(Size tileSize) => 12.0;

double _boardBottomInset(double boardHeight) => 12.0;

double _boardHorizontalInset(double boardWidth) => boardWidth >= 520 ? 18.0 : 14.0;

double _boardStep(Size tileSize) => tileSize.width + 6.0;

Size _tileSizeForBoard(double boardHeight, {required bool compact}) {
  // Old Mezo assets are tall two-icon strips. Keep them compact so all strips
  // can sit on the board without overlap or clipping, especially on phones.
  final tileHeight = (boardHeight * (compact ? 0.33 : 0.35)).clamp(
    compact ? 44.0 : 50.0,
    compact ? 58.0 : 66.0,
  ).toDouble();
  final tileWidth = tileHeight * 70 / 221;
  return Size(tileWidth, tileHeight);
}

enum _BoardLane {
  leftTop(<int>[1, 2, 3, 4, 5, 6, 7, 8, 9]),
  rightTop(<int>[11, 12, 13, 14, 15, 16, 17, 18, 19]),
  leftBottom(<int>[21, 22, 23, 24, 25, 26, 27, 28, 29]),
  rightBottom(<int>[31, 32, 33, 34, 35, 36, 37, 38, 39]);

  const _BoardLane(this.codes);

  final List<int> codes;
}

class _FullSectionGrid extends StatelessWidget {
  const _FullSectionGrid({required this.onOpenSection});

  final void Function(String sectionId) onOpenSection;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 520 ? 2 : 1;
        return GridView.builder(
          itemCount: StatusbarSectionConfigs.values.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: columns == 2 ? 1.42 : 2.85,
          ),
          itemBuilder: (context, index) {
            final section = StatusbarSectionConfigs.values[index];
            return _SectionCardTile(section: section, onTap: () => onOpenSection(section.id));
          },
        );
      },
    );
  }
}

class _SectionCardTile extends StatelessWidget {
  const _SectionCardTile({required this.section, required this.onTap});

  final StatusBarSectionDefinition section;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          padding: const EdgeInsets.fromLTRB(12, 12, 10, 10),
          decoration: BoxDecoration(
            color: const Color(0xFF05070D),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFF8A24FF).withValues(alpha: 0.72)),
            boxShadow: <BoxShadow>[
              BoxShadow(color: const Color(0xFF792BFF).withValues(alpha: 0.11), blurRadius: 16, offset: const Offset(0, 8)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: const Color(0xFF0C1220),
                      border: Border.all(color: section.accentColor.withValues(alpha: 0.78)),
                    ),
                    child: Icon(section.icon, size: 16, color: Colors.white),
                  ),
                  const Spacer(),
                  const Icon(Icons.chevron_right_rounded, size: 22, color: Colors.white70),
                ],
              ),
              const Spacer(),
              Text(
                section.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14.4, height: 1.05),
              ),
              const SizedBox(height: 4),
              Text(
                section.subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white.withValues(alpha: 0.68), fontSize: 11.0, height: 1.12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatusbarDetailScreen extends StatefulWidget {
  const StatusbarDetailScreen({required this.section, super.key});

  final StatusBarSectionDefinition section;

  @override
  State<StatusbarDetailScreen> createState() => _StatusbarDetailScreenState();
}

class _StatusbarDetailScreenState extends State<StatusbarDetailScreen> {
  static const MethodChannel _channel = MethodChannel('deadzon/mezo_settings');
  static const List<String> _batteryOrderedKeys = <String>[
    'elem_bat_element_visible',
    'battery_indicator_style',
    'use_legacy_drawable',
    'android.theme.customization.battery_icon',
    'batteryview_zoom',
    'batteryview_scale',
    'batteryview_division',
    'battery_percent_zoom',
    'battery_percent_division',
    'battery_charge_zoom',
    'battery_charge_scale',
    'battery_charge_division',
    'battery_percent_digit_zoom',
    'battery_percent_digit_division',
    'text_bat_color_0',
    'text_bat_color_1',
    'text_bat_color_2',
    'text_bat_color_3',
    'text_bat_color_4',
    'battery_percent_digit_color',
    'battery_charge_color',
    'battery_percent_typefase',
    'battery_percent_typefasestyle',
    'battery_percent_mark_enable',
    'battery_percent_mark_settings_enable',
    'battery_percent_mark_typefase',
    'battery_percent_mark_typefasestyle',
    'text_bat_color_mark_0',
    'text_bat_color_mark_1',
    'text_bat_color_mark_2',
    'text_bat_color_mark_3',
    'text_bat_color_mark_4',
    'battery_percent_mark_zoom',
    'battery_percent_mark_division',
  ];
  static const List<_NetworkIconStyleBinding> _networkIconStyles = <_NetworkIconStyleBinding>[
    _NetworkIconStyleBinding(
      title: 'Signal icon style',
      settingsKey: 'android.theme.customization.signal_icon',
      packageHintTokens: <String>['signal', 'mobile', 'cell'],
    ),
    _NetworkIconStyleBinding(
      title: 'Wi-Fi icon style',
      settingsKey: 'android.theme.customization.wifi_icon',
      packageHintTokens: <String>['wifi', 'wi-fi'],
    ),
    _NetworkIconStyleBinding(
      title: 'VoWiFi icon style',
      settingsKey: 'android.theme.customization.vowifi_icon',
      packageHintTokens: <String>['vowifi', 'wfc', 'wifi_call'],
    ),
    _NetworkIconStyleBinding(
      title: 'VoLTE icon style',
      settingsKey: 'android.theme.customization.volte_icon',
      packageHintTokens: <String>['volte', 'ims', 'lte'],
    ),
  ];
  late final List<StatusBarSettingItem> _settings;
  final Map<String, Object?> _values = <String, Object?>{};
  bool _isLoadingResize = false;
  bool _isLoadingStoredValues = false;

  @override
  void initState() {
    super.initState();
    _settings = StatusBarMapper.settingsForSection(widget.section.id);
    for (final setting in _settings) {
      _values[setting.legacyKey] = setting.defaultValue;
    }
    _loadStoredValues();
    if (widget.section.id == 'background') {
      for (final target in MezoPortMap.backgroundTargets) {
        for (final key in target.colorKeys) {
          _values.putIfAbsent(key, () => '#00000000');
        }
        for (final key in target.sliderKeys) {
          _values.putIfAbsent(key, () => key.endsWith('_stroke_width') ? 0.0 : key.contains('_corner') ? 35.0 : 0.0);
        }
      }
    }
    if (widget.section.id == 'resize_statusbar') {
      _isLoadingResize = true;
      _loadResizeValues();
    }
  }

  Future<void> _loadResizeValues() async {
    try {
      final loaded = await ResizeStatusbarService.loadAll();
      if (!mounted) {
        return;
      }
      setState(() {
        _values.addAll(loaded);
      });
    } catch (_) {
      // Keep source defaults when device settings read path is unavailable.
    } finally {
      if (mounted) {
        setState(() => _isLoadingResize = false);
      }
    }
  }

  Future<void> _loadStoredValues() async {
    setState(() => _isLoadingStoredValues = true);
    try {
      final loaded = await StatusbarSettingsRepository.readAll(_settings);
      if (!mounted) {
        return;
      }
      setState(() {
        _values.addAll(loaded);
      });
    } catch (_) {
      // Use source defaults if local persistence is not available.
    } finally {
      if (mounted) {
        setState(() => _isLoadingStoredValues = false);
      }
    }
  }

  void _handleSettingChanged(StatusBarSettingItem setting, Object? value) {
    setState(() => _values[setting.legacyKey] = value);
    StatusbarSettingsRepository.write(setting, value);
    if (widget.section.id == 'resize_statusbar') {
      ResizeStatusbarService.write(setting.legacyKey, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.section.id == 'resize_statusbar') {
      return _buildResizeStatusbarScreen(context);
    }
    if (widget.section.id == 'battery') {
      return _buildBatteryScreen(context);
    }
    if (widget.section.id == 'clock') {
      return _buildClockScreen(context);
    }
    if (widget.section.id == 'netspeed') {
      return _buildNetspeedScreen(context);
    }
    if (widget.section.id == 'network') {
      return _buildNetworkScreen(context);
    }
    if (widget.section.id == 'notification_icons') {
      return _buildNotificationIconsScreen(context);
    }

    final grouped = <String, List<StatusBarSettingItem>>{};
    for (final setting in _settings) {
      final groupKey = setting.group ?? 'General';
      grouped.putIfAbsent(groupKey, () => <StatusBarSettingItem>[]).add(setting);
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0B1418),
      appBar: AppBar(title: Text(widget.section.title)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: <Widget>[
          if (_isLoadingResize || _isLoadingStoredValues)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: LinearProgressIndicator(
                minHeight: 2,
                color: const Color(0xFF8DE8FF),
                backgroundColor: Colors.white.withValues(alpha: 0.08),
              ),
            ),
          if (_supportsLivePreview) ...<Widget>[
            _DetailLivePreview(
              sectionId: widget.section.id,
              values: _values,
            ),
            const SizedBox(height: 12),
          ],
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SectionHeader(title: widget.section.title, subtitle: widget.section.subtitle),
                const SizedBox(height: 10),
                ...((statusbarDetailContent[widget.section.id]?.highlights ?? const <String>[])
                    .map((line) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.only(top: 6),
                                child: Icon(Icons.circle, size: 6, color: Color(0xFF8DE8FF)),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  line,
                                  style: TextStyle(color: Colors.white.withValues(alpha: 0.8), height: 1.25),
                                ),
                              ),
                            ],
                          ),
                        ))),
              ],
            ),
          ),
          const SizedBox(height: 12),
          if (widget.section.id == 'background') ...<Widget>[
            _BackgroundModuleEditor(
              values: _values,
              onChanged: (key, value) {
                setState(() => _values[key] = value);
                StatusbarSettingsRepository.writeLoose(key, value);
              },
            ),
            const SizedBox(height: 12),
          ],
          for (final entry in grouped.entries) ...<Widget>[
            SectionHeader(
              title: _groupTitle(entry.key),
              subtitle: _groupSubtitle(entry.key),
            ),
            const SizedBox(height: 8),
            GlassCard(
              child: Column(
                children: <Widget>[
                  for (var i = 0; i < entry.value.length; i++) ...<Widget>[
                    _SettingControl(
                      setting: entry.value[i],
                      isResizeSection: widget.section.id == 'resize_statusbar',
                      value: _values[entry.value[i].legacyKey],
                      onChanged: (value) => _handleSettingChanged(entry.value[i], value),
                    ),
                    if (i != entry.value.length - 1) const Divider(height: 22),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }

  Widget _buildBatteryScreen(BuildContext context) {
    final batterySettings = <StatusBarSettingItem>[
      for (final key in _batteryOrderedKeys)
        ..._settings.where((setting) => setting.legacyKey == key),
    ];
    final byKey = <String, StatusBarSettingItem>{
      for (final setting in batterySettings) setting.legacyKey: setting,
    };
    final markDetailsEnabled = (_values['battery_percent_mark_settings_enable'] as bool?) ?? false;

    return Scaffold(
      backgroundColor: const Color(0xFF050B1A),
      appBar: AppBar(title: const Text('Battery')),
      body: ListView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.fromLTRB(16, 10, 16, MediaQuery.paddingOf(context).bottom + 140),
        children: <Widget>[
          if (_isLoadingStoredValues)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: LinearProgressIndicator(
                minHeight: 2,
                color: const Color(0xFF8DE8FF),
                backgroundColor: Colors.white.withValues(alpha: 0.12),
              ),
            ),
          _BatteryHeroCard(values: _values),
          const SizedBox(height: 14),
          _BatterySectionCard(
            title: 'Style and visibility',
            subtitle: 'Battery icon style, visibility, and shape.',
            children: <Widget>[
              _batteryToggle(byKey['elem_bat_element_visible']),
              _batterySelect(byKey['battery_indicator_style']),
              _batterySelect(byKey['use_legacy_drawable']),
              _BatteryInfoTile(
                title: byKey['android.theme.customization.battery_icon']?.title ?? 'Battery icon pack',
                subtitle: 'Icon-pack picker opens from the source overlay module.',
              ),
            ],
          ),
          const SizedBox(height: 12),
          _BatterySectionCard(
            title: 'Icon size & position',
            subtitle: 'Battery body dimensions from old source ranges.',
            children: <Widget>[
              _batterySlider(byKey['batteryview_zoom']),
              _batterySlider(byKey['batteryview_scale']),
              _batterySlider(byKey['batteryview_division']),
            ],
          ),
          const SizedBox(height: 12),
          _BatterySectionCard(
            title: 'Percentage',
            subtitle: 'Percent text and in-icon digit behavior.',
            children: <Widget>[
              _batterySlider(byKey['battery_percent_zoom']),
              _batterySlider(byKey['battery_percent_division']),
              _batterySlider(byKey['battery_percent_digit_zoom']),
              _batterySlider(byKey['battery_percent_digit_division']),
              _batteryColor(byKey['battery_percent_digit_color']),
              _batteryFontSelect(byKey['battery_percent_typefase']),
              _batterySelect(byKey['battery_percent_typefasestyle']),
              _batteryToggle(byKey['battery_percent_mark_enable']),
            ],
          ),
          const SizedBox(height: 12),
          _BatterySectionCard(
            title: 'Charging',
            subtitle: 'Charging icon size, position, and tint.',
            children: <Widget>[
              _batterySlider(byKey['battery_charge_zoom']),
              _batterySlider(byKey['battery_charge_scale']),
              _batterySlider(byKey['battery_charge_division']),
              _batteryColor(byKey['battery_charge_color']),
            ],
          ),
          const SizedBox(height: 12),
          _BatterySectionCard(
            title: 'Battery level colors',
            subtitle: 'Threshold color layers from less than 20% to less than 100%.',
            children: <Widget>[
              _batteryColor(byKey['text_bat_color_0']),
              _batteryColor(byKey['text_bat_color_1']),
              _batteryColor(byKey['text_bat_color_2']),
              _batteryColor(byKey['text_bat_color_3']),
              _batteryColor(byKey['text_bat_color_4']),
            ],
          ),
          const SizedBox(height: 12),
          _BatterySectionCard(
            title: 'Percent mark details',
            subtitle: 'Enabled only when mark custom settings are turned on.',
            children: <Widget>[
              _batteryToggle(byKey['battery_percent_mark_settings_enable']),
              if (markDetailsEnabled) ...<Widget>[
                _batteryFontSelect(byKey['battery_percent_mark_typefase']),
                _batterySelect(byKey['battery_percent_mark_typefasestyle']),
                _batteryColor(byKey['text_bat_color_mark_0']),
                _batteryColor(byKey['text_bat_color_mark_1']),
                _batteryColor(byKey['text_bat_color_mark_2']),
                _batteryColor(byKey['text_bat_color_mark_3']),
                _batteryColor(byKey['text_bat_color_mark_4']),
                _batterySlider(byKey['battery_percent_mark_zoom']),
                _batterySlider(byKey['battery_percent_mark_division']),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClockScreen(BuildContext context) {
    final byKey = <String, StatusBarSettingItem>{
      for (final setting in _settings) setting.legacyKey: setting,
    };
    final clockAnimOptions = byKey['status_clock_anim_style']?.options ?? const <StatusBarOption>[];
    final dateFormatOptions = byKey['Notif_date_format']?.options ?? const <StatusBarOption>[];

    return Scaffold(
      backgroundColor: const Color(0xFF050B1A),
      appBar: AppBar(title: const Text('Clock')),
      body: ListView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.fromLTRB(16, 10, 16, MediaQuery.paddingOf(context).bottom + 140),
        children: <Widget>[
          if (_isLoadingStoredValues)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: LinearProgressIndicator(
                minHeight: 2,
                color: const Color(0xFF8DE8FF),
                backgroundColor: Colors.white.withValues(alpha: 0.12),
              ),
            ),
          _ClockPreview(values: _values),
          const SizedBox(height: 14),
          _BatterySectionCard(
            title: 'Statusbar clock',
            subtitle: 'Personalize how the statusbar clock appears.',
            children: <Widget>[
              _clockToggle(byKey['elem_clock_element_visible'], 'Show clock'),
              _clockToggle(byKey['clock_mezo_time_style'], '24-hour clock'),
              _clockToggle(byKey['status_clock_second_enable'], 'Show seconds'),
              _clockToggle(byKey['status_clock_dots_enable'], 'Blinking dots'),
              _clockSelect(byKey['status_clock_anim_style'], clockAnimOptions, 'Digits change animation'),
              _clockColor(byKey['status_clock_color'], 'Clock color'),
              _clockFont(byKey['status_clock_typefase'], 'Clock font'),
              _clockSlider(byKey['status_clock_zoom'], 'Clock size'),
              _clockSlider(byKey['status_clock_division'], 'Clock spacing / division'),
            ],
          ),
          const SizedBox(height: 12),
          _BatterySectionCard(
            title: 'Notification center clock',
            subtitle: 'Tune the expanded clock block independently.',
            children: <Widget>[
              _clockSlider(byKey['expanded_clock_zoom'], 'Notification clock size'),
              _clockSlider(byKey['expanded_clock_division'], 'Notification clock spacing / division'),
              _clockColor(byKey['expanded_clock_color'], 'Notification clock color'),
              _clockToggle(byKey['expanded_clock_dots_enable'], 'Blinking dots'),
              _clockSelect(byKey['expanded_clock_anim_style'], clockAnimOptions, 'Digits change animation'),
              _clockToggle(byKey['expanded_clock_second_enable'], 'Show seconds'),
            ],
          ),
          const SizedBox(height: 12),
          _BatterySectionCard(
            title: 'Notification date style',
            subtitle: 'Date size, division, color, font, and format.',
            children: <Widget>[
              _clockSlider(byKey['Notif_date_zoom'], 'Date size'),
              _clockSlider(byKey['Notif_date_division'], 'Date spacing / division'),
              _clockColor(byKey['Notif_date_color'], 'Date color'),
              _clockFont(byKey['Notif_date_typefase'], 'Date font'),
              _clockSelect(byKey['Notif_date_format'], dateFormatOptions, 'Date format'),
            ],
          ),
          const SizedBox(height: 12),
          _BatterySectionCard(
            title: 'Weather text',
            subtitle: 'Notification weather typography and tint.',
            children: <Widget>[
              _clockSlider(byKey['weather_notif_text_zoom'], 'Weather text size'),
              _clockColor(byKey['weather_notif_text_color'], 'Weather text color'),
              _clockFont(byKey['weather_notif_text_typefase'], 'Weather text font'),
            ],
          ),
          const SizedBox(height: 12),
          _BatterySectionCard(
            title: 'Settings icon',
            subtitle: 'Settings / notification icon style controls.',
            children: <Widget>[
              _clockColor(byKey['Settingsfachen_color'], 'Settings icon color'),
              _clockSlider(byKey['Settingsfachen_zoom'], 'Settings icon size'),
              _clockSlider(byKey['Settingsfachen_scale'], 'Settings icon scale'),
              _clockSlider(byKey['Settingsfachen_division'], 'Settings icon spacing / division'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _clockToggle(StatusBarSettingItem? setting, String label) {
    if (setting == null) return const SizedBox.shrink();
    final defaultValue = setting.defaultValue as bool? ?? false;
    final current = (_values[setting.legacyKey] as bool?) ?? defaultValue;
    return _BatteryToggleTile(
      title: label,
      value: current,
      onChanged: (next) => _handleSettingChanged(setting, next),
    );
  }

  Widget _buildNetspeedScreen(BuildContext context) {
    final byKey = <String, StatusBarSettingItem>{
      for (final setting in _settings) setting.legacyKey: setting,
    };

    return Scaffold(
      backgroundColor: const Color(0xFF050B1A),
      appBar: AppBar(
        title: const Text('Netspeed'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: Text(
              'Customize the speed indicator.',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.72), fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.fromLTRB(16, 10, 16, MediaQuery.paddingOf(context).bottom + 140),
        children: <Widget>[
          if (_isLoadingStoredValues)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: LinearProgressIndicator(
                minHeight: 2,
                color: const Color(0xFF8DE8FF),
                backgroundColor: Colors.white.withValues(alpha: 0.12),
              ),
            ),
          _NetspeedPreview(values: _values),
          const SizedBox(height: 14),
          _BatterySectionCard(
            title: 'Visibility',
            subtitle: 'Control how the speed indicator appears.',
            children: <Widget>[
              _netspeedSelect(byKey['status_bar_show_network_speed']),
            ],
          ),
          const SizedBox(height: 12),
          _BatterySectionCard(
            title: 'Text appearance',
            subtitle: 'Size, spacing, position, color, and font.',
            children: <Widget>[
              _netspeedSlider(byKey['net_speed_zoom']),
              _netspeedSlider(byKey['net_speed_division']),
              _netspeedSlider(byKey['net_speed_height']),
              _netspeedColor(byKey['net_speed_color']),
              _netspeedFont(byKey['net_speed_typefase']),
            ],
          ),
          const SizedBox(height: 12),
          _BatterySectionCard(
            title: 'Units / behavior',
            subtitle: 'Keep refresh interval aligned with old Mezo behavior.',
            children: <Widget>[
              _netspeedSlider(byKey['status_bar_network_speed_interval']),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNetworkScreen(BuildContext context) {
    final byKey = <String, StatusBarSettingItem>{
      for (final setting in _settings) setting.legacyKey: setting,
    };
    return Scaffold(
      backgroundColor: const Color(0xFF050B1A),
      appBar: AppBar(
        title: const Text('Network'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: Text(
              'Customize SIM, Wi-Fi, and mobile indicators.',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.72), fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.fromLTRB(16, 10, 16, MediaQuery.paddingOf(context).bottom + 140),
        children: <Widget>[
          if (_isLoadingStoredValues)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: LinearProgressIndicator(
                minHeight: 2,
                color: const Color(0xFF8DE8FF),
                backgroundColor: Colors.white.withValues(alpha: 0.12),
              ),
            ),
          _NetworkPreview(values: _values),
          const SizedBox(height: 14),
          _BatterySectionCard(
            title: 'Visibility',
            subtitle: 'Show or hide each network cluster icon.',
            children: <Widget>[
              _networkToggle(byKey['elem_net_element_visible']),
              _networkToggle(byKey['elem_wifi_element_visible']),
              _networkToggle(byKey['vpn_visible']),
              _networkToggle(byKey['vowifi_visible']),
              _networkToggle(byKey['roam_visible']),
            ],
          ),
          const SizedBox(height: 12),
          _BatterySectionCard(
            title: 'Colors',
            subtitle: 'ARGB color controls with alpha support preserved.',
            children: <Widget>[
              _networkColor(byKey['sim_one_color']),
              _networkColor(byKey['sim_two_color']),
              _networkColor(byKey['wifiview_color']),
              _networkColor(byKey['airplaneview_color']),
              _networkColor(byKey['mobile_type_color']),
              _networkColor(byKey['mobile_inout_color']),
              _networkColor(byKey['vpn_color']),
              _networkColor(byKey['vowifi_color']),
              _networkColor(byKey['roam_color']),
            ],
          ),
          const SizedBox(height: 12),
          _BatterySectionCard(
            title: 'SIM and network type',
            subtitle: 'SIM icon, mobile type, network arrows, font, and rotation.',
            children: <Widget>[
              _networkSlider(byKey['simview_zoom']),
              _networkSlider(byKey['simview_scale']),
              _networkSlider(byKey['simview_division']),
              _networkSlider(byKey['mobile_type_zoom']),
              _networkSlider(byKey['mobile_type_division']),
              _networkSlider(byKey['mobile_inout_zoom']),
              _networkSlider(byKey['mobile_inout_scale']),
              _networkSlider(byKey['mobile_inout_division']),
              _networkFont(byKey['mobile_type_typefase']),
              _networkToggle(byKey['sim_type_position']),
              _networkSlider(byKey['sim_type_margin']),
              _networkToggle(byKey['elem_net1_rotate']),
              _networkToggle(byKey['elem_net2_rotate']),
            ],
          ),
          const SizedBox(height: 12),
          _BatterySectionCard(
            title: 'Wi-Fi',
            subtitle: 'Wi-Fi icon and Wi-Fi arrows dimensions.',
            children: <Widget>[
              _networkSlider(byKey['wifiview_zoom']),
              _networkSlider(byKey['wifiview_scale']),
              _networkSlider(byKey['wifiview_division']),
              _networkSlider(byKey['airplaneview_zoom']),
              _networkSlider(byKey['airplaneview_scale']),
              _networkSlider(byKey['airplaneview_division']),
            ],
          ),
          const SizedBox(height: 12),
          _BatterySectionCard(
            title: 'Extra icons',
            subtitle: 'VoLTE/VPN, VoWiFi, and roaming icon sizing.',
            children: <Widget>[
              _networkSlider(byKey['vpn_zoom']),
              _networkSlider(byKey['vpn_scale']),
              _networkSlider(byKey['vpn_division']),
              _networkSlider(byKey['vowifi_zoom']),
              _networkSlider(byKey['vowifi_scale']),
              _networkSlider(byKey['vowifi_division']),
              _networkSlider(byKey['roam_zoom']),
              _networkSlider(byKey['roam_scale']),
              _networkSlider(byKey['roam_division']),
            ],
          ),
          const SizedBox(height: 12),
          _BatterySectionCard(
            title: 'Icon style',
            subtitle: 'Choose the visual style for signal and connection icons.',
            children: _networkIconStyles.map((binding) => _networkIconStyleTile(binding)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationIconsScreen(BuildContext context) {
    final byKey = <String, StatusBarSettingItem>{
      for (final setting in _settings) setting.legacyKey: setting,
    };
    return Scaffold(
      backgroundColor: const Color(0xFF050B1A),
      appBar: AppBar(
        title: const Text('Notification icons'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: Text(
              'Adjust notification icon appearance.',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.72), fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.fromLTRB(16, 10, 16, MediaQuery.paddingOf(context).bottom + 140),
        children: <Widget>[
          if (_isLoadingStoredValues)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: LinearProgressIndicator(
                minHeight: 2,
                color: const Color(0xFF8DE8FF),
                backgroundColor: Colors.white.withValues(alpha: 0.12),
              ),
            ),
          _NotificationIconsPreview(values: _values),
          const SizedBox(height: 14),
          _BatterySectionCard(
            title: 'Appearance',
            subtitle: 'Tune icon order, tint, size, scale, and spacing.',
            children: <Widget>[
              _clockToggle(byKey['reverse_notification_sorting_order'], 'Reverse notification order'),
              _clockColor(byKey['notif_icon_color'], 'Notification icon color'),
              _clockSlider(byKey['notif_icon_zoom'], 'Notification icon size'),
              _clockSlider(byKey['notif_icon_scale'], 'Notification icon scale'),
              _clockSlider(byKey['notif_icon_division'], 'Notification icon spacing'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _networkToggle(StatusBarSettingItem? setting) {
    if (setting == null) return const SizedBox.shrink();
    final defaultValue = setting.defaultValue as bool? ?? false;
    final current = (_values[setting.legacyKey] as bool?) ?? defaultValue;
    return _BatteryToggleTile(
      title: setting.title ?? setting.legacyKey,
      value: current,
      onChanged: (next) => _handleSettingChanged(setting, next),
    );
  }

  Widget _networkSlider(StatusBarSettingItem? setting) {
    if (setting == null) return const SizedBox.shrink();
    final min = setting.min ?? 0;
    final max = setting.max ?? 100;
    final defaultValue = (setting.defaultValue as num?)?.toDouble() ?? min;
    final value = ((_values[setting.legacyKey] as num?)?.toDouble() ?? defaultValue).clamp(min, max).toDouble();
    return _BatterySliderTile(
      title: setting.title ?? setting.legacyKey,
      value: value,
      min: min,
      max: max,
      onChanged: (next) => _handleSettingChanged(setting, next.round()),
      onReset: () => _handleSettingChanged(setting, defaultValue.round()),
    );
  }

  Widget _networkColor(StatusBarSettingItem? setting) {
    if (setting == null) return const SizedBox.shrink();
    final defaultValue = (setting.defaultValue as int?) ?? 0x00000000;
    final current = _colorIntValue(setting, defaultValue);
    return _BatteryColorTile(
      title: setting.title ?? setting.legacyKey,
      colorValue: current,
      onTap: () async {
        final selected = await showModalBottomSheet<int>(
          context: context,
          useSafeArea: true,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (sheetContext) => _BatteryColorSheet(
            title: setting.title ?? setting.legacyKey,
            current: current,
            defaultValue: defaultValue,
            onSelected: (value) => Navigator.of(sheetContext).pop(value),
          ),
        );
        if (!context.mounted) return;
        if (selected != null) {
          _handleSettingChanged(setting, selected);
        }
      },
    );
  }

  Widget _networkFont(StatusBarSettingItem? setting) {
    if (setting == null) return const SizedBox.shrink();
    final current = _stringSettingValue(setting, 'Default');
    return _BatterySelectTile(
      title: setting.title ?? setting.legacyKey,
      valueLabel: _fontDisplayLabel(current),
      onTap: () async {
        final pageContext = context;
        final options = await _batteryFontOptions(current);
        if (!pageContext.mounted) return;
        final selected = await showModalBottomSheet<String>(
          context: pageContext,
          useSafeArea: true,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (sheetContext) => _BatteryOptionSheet(
            title: setting.title ?? setting.legacyKey,
            selectedValue: current,
            options: options,
            onSelected: (value) => Navigator.of(sheetContext).pop(value),
          ),
        );
        if (!pageContext.mounted) return;
        if (selected != null) {
          _handleSettingChanged(setting, selected);
        }
      },
    );
  }

  Widget _networkIconStyleTile(_NetworkIconStyleBinding binding) {
    final currentPackage = _stringSettingValueFromKey(binding.settingsKey, 'com.android.systemui');
    return _BatterySelectTile(
      title: binding.title,
      valueLabel: _networkStyleLabel(currentPackage),
      onTap: () async {
        final pageContext = context;
        final options = await _networkStyleOptions(binding, currentPackage);
        if (!pageContext.mounted) return;
        final selected = await showModalBottomSheet<String>(
          context: pageContext,
          useSafeArea: true,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (sheetContext) => _BatteryOptionSheet(
            title: binding.title,
            selectedValue: currentPackage,
            options: options,
            onSelected: (value) => Navigator.of(sheetContext).pop(value),
          ),
        );
        if (!pageContext.mounted) return;
        if (selected == null || selected == currentPackage) return;

        final setting = _settings.firstWhere(
          (item) => item.legacyKey == binding.settingsKey,
          orElse: () => StatusBarSettingItem(
            legacyKey: binding.settingsKey,
            controlType: StatusBarControlType.select,
            defaultValue: 'com.android.systemui',
            intentAction: 'my.intent.action.REFRESH_SYSTEMUI',
          ),
        );
        _handleSettingChanged(setting, selected);
      },
    );
  }

  Future<List<StatusBarOption>> _networkStyleOptions(
    _NetworkIconStyleBinding binding,
    String currentPackage,
  ) async {
    final options = <StatusBarOption>[
      const StatusBarOption(label: 'Choose', value: 'com.android.systemui'),
    ];
    final payload = await _readInstalledPackages();
    if (payload != null) {
      final discovered = <StatusBarOption>[];
      for (final item in payload) {
        if (item is! Map<Object?, Object?>) continue;
        final packageName = '${item['packageName'] ?? ''}'.trim();
        final label = '${item['name'] ?? packageName}'.trim();
        if (packageName.isEmpty || packageName == 'com.android.systemui') continue;
        if (_isMatchingNetworkOverlay(packageName, binding.packageHintTokens)) {
          discovered.add(StatusBarOption(label: label.isEmpty ? packageName : label, value: packageName));
        }
      }
      discovered.sort((a, b) => a.label.toLowerCase().compareTo(b.label.toLowerCase()));
      options.addAll(discovered);
    }
    if (options.every((entry) => entry.value != currentPackage)) {
      options.add(StatusBarOption(label: _networkStyleLabel(currentPackage), value: currentPackage));
    }
    return options;
  }

  Future<List<Object?>?> _readInstalledPackages() async {
    try {
      return await _channel.invokeMethod<List<Object?>>('getInstalledPackages');
    } on PlatformException {
      return null;
    } on MissingPluginException {
      return null;
    }
  }

  bool _isMatchingNetworkOverlay(String packageName, List<String> hintTokens) {
    final normalized = packageName.toLowerCase();
    if (!(normalized.contains('overlay') || normalized.contains('theme') || normalized.contains('icon'))) {
      return false;
    }
    for (final token in hintTokens) {
      if (normalized.contains(token)) return true;
    }
    return false;
  }

  String _stringSettingValueFromKey(String key, String fallback) {
    final raw = _values[key];
    if (raw is String && raw.trim().isNotEmpty) return raw.trim();
    return fallback;
  }

  String _networkStyleLabel(String packageName) {
    if (packageName == 'com.android.systemui') return 'Choose';
    final chunks = packageName.split('.');
    final raw = chunks.isEmpty ? packageName : chunks.last;
    final cleaned = raw.replaceAll('_', ' ').replaceAll('-', ' ').trim();
    if (cleaned.isEmpty) return 'Choose';
    return cleaned[0].toUpperCase() + cleaned.substring(1);
  }

  Widget _netspeedSlider(StatusBarSettingItem? setting) {
    if (setting == null) return const SizedBox.shrink();
    final min = setting.min ?? 0;
    final max = setting.max ?? 100;
    final defaultValue = (setting.defaultValue as num?)?.toDouble() ?? min;
    final value = ((_values[setting.legacyKey] as num?)?.toDouble() ?? defaultValue).clamp(min, max).toDouble();
    return _BatterySliderTile(
      title: _netspeedLabel(setting.legacyKey, setting.title),
      value: value,
      min: min,
      max: max,
      onChanged: (next) => _handleSettingChanged(setting, next.round()),
      onReset: () => _handleSettingChanged(setting, defaultValue.round()),
    );
  }

  Widget _netspeedSelect(StatusBarSettingItem? setting) {
    if (setting == null || setting.options.isEmpty) return const SizedBox.shrink();
    final fallback = setting.defaultValue?.toString() ?? setting.options.first.value;
    final current = _stringSettingValue(setting, fallback);
    final selectedOption = setting.options.where((option) => option.value == current);
    final valueLabel = selectedOption.isEmpty ? setting.options.first.label : selectedOption.first.label;
    return _BatterySelectTile(
      title: _netspeedLabel(setting.legacyKey, setting.title),
      valueLabel: valueLabel,
      onTap: () async {
        final selected = await showModalBottomSheet<String>(
          context: context,
          useSafeArea: true,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (sheetContext) => _BatteryOptionSheet(
            title: setting.title ?? setting.legacyKey,
            selectedValue: current,
            options: setting.options,
            onSelected: (value) => Navigator.of(sheetContext).pop(value),
          ),
        );
        if (!context.mounted) return;
        if (selected != null) {
          _handleSettingChanged(setting, selected);
        }
      },
    );
  }

  Widget _netspeedColor(StatusBarSettingItem? setting) {
    if (setting == null) return const SizedBox.shrink();
    final fallback = (setting.defaultValue as String?) ?? '#00000000';
    final current = _stringSettingValue(setting, fallback);
    final currentInt = _colorFromHex(current, _colorFromHex(fallback, 0));
    final defaultInt = _colorFromHex(fallback, 0);

    return _BatteryColorTile(
      title: _netspeedLabel(setting.legacyKey, setting.title),
      colorValue: currentInt,
      onTap: () async {
        final selected = await showModalBottomSheet<int>(
          context: context,
          useSafeArea: true,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (sheetContext) => _BatteryColorSheet(
            title: setting.title ?? setting.legacyKey,
            current: currentInt,
            defaultValue: defaultInt,
            onSelected: (value) => Navigator.of(sheetContext).pop(value),
          ),
        );
        if (!context.mounted) return;
        if (selected != null) {
          final hex = '#${selected.toUnsigned(32).toRadixString(16).padLeft(8, '0').toUpperCase()}';
          _handleSettingChanged(setting, hex);
        }
      },
    );
  }

  Widget _netspeedFont(StatusBarSettingItem? setting) {
    if (setting == null) return const SizedBox.shrink();
    final current = _stringSettingValue(setting, 'Default');
    return _BatterySelectTile(
      title: _netspeedLabel(setting.legacyKey, setting.title),
      valueLabel: _fontDisplayLabel(current),
      onTap: () async {
        final pageContext = context;
        final options = await _batteryFontOptions(current);
        if (!pageContext.mounted) return;
        final selected = await showModalBottomSheet<String>(
          context: pageContext,
          useSafeArea: true,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (sheetContext) => _BatteryOptionSheet(
            title: setting.title ?? setting.legacyKey,
            selectedValue: current,
            options: options,
            onSelected: (value) => Navigator.of(sheetContext).pop(value),
          ),
        );
        if (!pageContext.mounted) return;
        if (selected != null) {
          _handleSettingChanged(setting, selected);
        }
      },
    );
  }

  String _netspeedLabel(String key, String? fallback) {
    switch (key) {
      case 'status_bar_show_network_speed':
        return 'Show network speed';
      case 'net_speed_zoom':
        return 'Text size';
      case 'net_speed_division':
        return 'Spacing';
      case 'net_speed_height':
        return 'Vertical position';
      case 'net_speed_color':
        return 'Text color';
      case 'status_bar_network_speed_interval':
        return 'Refresh interval';
      case 'net_speed_typefase':
        return 'Font';
      default:
        return fallback ?? key;
    }
  }

  Widget _clockSlider(StatusBarSettingItem? setting, String label) {
    if (setting == null) return const SizedBox.shrink();
    final min = setting.min ?? 0;
    final max = setting.max ?? 100;
    final defaultValue = (setting.defaultValue as num?)?.toDouble() ?? min;
    final value = ((_values[setting.legacyKey] as num?)?.toDouble() ?? defaultValue).clamp(min, max).toDouble();
    return _BatterySliderTile(
      title: label,
      value: value,
      min: min,
      max: max,
      onChanged: (next) => _handleSettingChanged(setting, next.round()),
      onReset: () => _handleSettingChanged(setting, defaultValue.round()),
    );
  }

  Widget _clockColor(StatusBarSettingItem? setting, String label) {
    if (setting == null) return const SizedBox.shrink();
    final defaultValue = (setting.defaultValue as int?) ?? 0;
    final current = _colorIntValue(setting, defaultValue);
    return _BatteryColorTile(
      title: label,
      colorValue: current,
      onTap: () async {
        final selected = await showModalBottomSheet<int>(
          context: context,
          useSafeArea: true,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (sheetContext) => _BatteryColorSheet(
            title: label,
            current: current,
            defaultValue: defaultValue,
            onSelected: (value) => Navigator.of(sheetContext).pop(value),
          ),
        );
        if (!context.mounted) return;
        if (selected != null) {
          _handleSettingChanged(setting, selected);
        }
      },
    );
  }

  Widget _clockSelect(StatusBarSettingItem? setting, List<StatusBarOption> options, String label) {
    if (setting == null || options.isEmpty) return const SizedBox.shrink();
    final fallback = setting.defaultValue?.toString() ?? options.first.value;
    final current = _stringSettingValue(setting, fallback);
    final selectedOption = options.where((option) => option.value == current);
    final valueLabel = selectedOption.isEmpty ? options.first.label : selectedOption.first.label;
    return _BatterySelectTile(
      title: label,
      valueLabel: valueLabel,
      onTap: () async {
        final selected = await showModalBottomSheet<String>(
          context: context,
          useSafeArea: true,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (sheetContext) => _BatteryOptionSheet(
            title: label,
            selectedValue: current,
            options: options,
            onSelected: (value) => Navigator.of(sheetContext).pop(value),
          ),
        );
        if (!context.mounted) return;
        if (selected != null) {
          _handleSettingChanged(setting, selected);
        }
      },
    );
  }

  Widget _clockFont(StatusBarSettingItem? setting, String label) {
    if (setting == null) return const SizedBox.shrink();
    final current = _stringSettingValue(setting, 'Default');
    return _BatterySelectTile(
      title: label,
      valueLabel: _fontDisplayLabel(current),
      onTap: () async {
        final pageContext = context;
        final options = await _batteryFontOptions(current);
        if (!pageContext.mounted) return;
        final selected = await showModalBottomSheet<String>(
          context: pageContext,
          useSafeArea: true,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (sheetContext) => _BatteryOptionSheet(
            title: label,
            selectedValue: current,
            options: options,
            onSelected: (value) => Navigator.of(sheetContext).pop(value),
          ),
        );
        if (!pageContext.mounted) return;
        if (selected != null) {
          _handleSettingChanged(setting, selected);
        }
      },
    );
  }

  Widget _batteryToggle(StatusBarSettingItem? setting) {
    if (setting == null) return const SizedBox.shrink();
    return _BatteryToggleTile(
      title: _batteryLabel(setting),
      subtitle: _batterySubtitle(setting),
      value: (_values[setting.legacyKey] as bool?) ?? (setting.defaultValue as bool? ?? false),
      onChanged: (next) => _handleSettingChanged(setting, next),
    );
  }

  Widget _batterySlider(StatusBarSettingItem? setting) {
    if (setting == null) return const SizedBox.shrink();
    final min = setting.min ?? 0;
    final max = setting.max ?? 100;
    final value = ((_values[setting.legacyKey] as num?)?.toDouble() ?? (setting.defaultValue as num?)?.toDouble() ?? min).clamp(min, max).toDouble();
    return _BatterySliderTile(
      title: _batteryLabel(setting),
      subtitle: _batterySubtitle(setting),
      value: value,
      min: min,
      max: max,
      onChanged: (next) => _handleSettingChanged(setting, next),
      onReset: () => _handleSettingChanged(setting, setting.defaultValue),
    );
  }

  Widget _batterySelect(StatusBarSettingItem? setting) {
    if (setting == null) return const SizedBox.shrink();
    final options = _batteryOptionsFor(setting);
    if (options.isEmpty) return const SizedBox.shrink();
    final current = _stringSettingValue(setting, options.first.value);
    final selectedOption = options.where((o) => o.value == current);
    final label = selectedOption.isEmpty ? options.first.label : selectedOption.first.label;
    return _BatterySelectTile(
      title: _batteryLabel(setting),
      subtitle: _batterySubtitle(setting),
      valueLabel: label,
      onTap: () async {
        final selected = await showModalBottomSheet<String>(
          context: context,
          useSafeArea: true,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (sheetContext) => _BatteryOptionSheet(
            title: _batteryLabel(setting),
            selectedValue: current,
            options: options,
            onSelected: (value) => Navigator.of(sheetContext).pop(value),
          ),
        );
        if (!mounted) return;
        if (selected != null) {
          _handleSettingChanged(setting, selected);
        }
      },
    );
  }

  Widget _batteryFontSelect(StatusBarSettingItem? setting) {
    if (setting == null) return const SizedBox.shrink();
    final current = _stringSettingValue(setting, 'Default');
    return _BatterySelectTile(
      title: _batteryLabel(setting),
      subtitle: _batterySubtitle(setting),
      valueLabel: _fontDisplayLabel(current),
      onTap: () async {
        final options = await _batteryFontOptions(current);
        if (!mounted) return;
        final selected = await showModalBottomSheet<String>(
          context: context,
          useSafeArea: true,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (sheetContext) => _BatteryOptionSheet(
            title: _batteryLabel(setting),
            selectedValue: current,
            options: options,
            onSelected: (value) => Navigator.of(sheetContext).pop(value),
          ),
        );
        if (!mounted) return;
        if (selected != null) {
          _handleSettingChanged(setting, selected);
        }
      },
    );
  }

  List<StatusBarOption> _batteryOptionsFor(StatusBarSettingItem setting) {
    switch (setting.legacyKey) {
      case 'battery_indicator_style':
        return const <StatusBarOption>[
          StatusBarOption(label: 'Graphical', value: '0'),
          StatusBarOption(label: 'Percentage (center) and graphical', value: '1'),
          StatusBarOption(label: 'Percentages (right) and graphical', value: '3'),
          StatusBarOption(label: 'Percentages (left) and graphical', value: '6'),
          StatusBarOption(label: 'Percent only', value: '5'),
          StatusBarOption(label: 'Do not show', value: '4'),
        ];
      case 'use_legacy_drawable':
        return const <StatusBarOption>[
          StatusBarOption(label: 'Android (Rectangle)', value: '0'),
          StatusBarOption(label: 'MIUI (Oval)', value: '1'),
        ];
      case 'battery_percent_typefasestyle':
      case 'battery_percent_mark_typefasestyle':
        return const <StatusBarOption>[
          StatusBarOption(label: 'Normal', value: '0'),
          StatusBarOption(label: 'Bold', value: '1'),
          StatusBarOption(label: 'Italic', value: '2'),
          StatusBarOption(label: 'Bold italic', value: '3'),
        ];
      default:
        return setting.options;
    }
  }

  Widget _batteryColor(StatusBarSettingItem? setting) {
    if (setting == null) return const SizedBox.shrink();
    final current = _colorIntValue(setting, (setting.defaultValue as int?) ?? 0);
    return _BatteryColorTile(
      title: _batteryLabel(setting),
      subtitle: _batterySubtitle(setting),
      colorValue: current,
      onTap: () async {
        final selected = await showModalBottomSheet<int>(
          context: context,
          useSafeArea: true,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (sheetContext) => _BatteryColorSheet(
            title: _batteryLabel(setting),
            current: current,
            defaultValue: (setting.defaultValue as int?) ?? 0,
            onSelected: (value) => Navigator.of(sheetContext).pop(value),
          ),
        );
        if (!mounted) return;
        if (selected != null) {
          _handleSettingChanged(setting, selected);
        }
      },
    );
  }

  String _batteryLabel(StatusBarSettingItem setting) {
    const labels = <String, String>{
      'elem_bat_element_visible': 'Show battery icon',
      'battery_indicator_style': 'Battery indicator style',
      'use_legacy_drawable': 'Battery icon shape',
      'android.theme.customization.battery_icon': 'Battery icon pack',
      'batteryview_zoom': 'Icon size',
      'batteryview_scale': 'Icon scale',
      'batteryview_division': 'Icon division',
      'battery_percent_zoom': 'Percent size',
      'battery_percent_division': 'Percent division',
      'battery_charge_zoom': 'Charging size',
      'battery_charge_scale': 'Charging scale',
      'battery_charge_division': 'Charging division',
      'battery_percent_digit_zoom': 'Digit size',
      'battery_percent_digit_division': 'Digit division',
      'text_bat_color_0': 'Color less than 20%',
      'text_bat_color_1': 'Color less than 40%',
      'text_bat_color_2': 'Color less than 60%',
      'text_bat_color_3': 'Color less than 80%',
      'text_bat_color_4': 'Color less than 100%',
      'battery_percent_digit_color': 'Battery percent digit color',
      'battery_charge_color': 'Charging color',
      'battery_percent_typefase': 'Percent font',
      'battery_percent_typefasestyle': 'Percent font style',
      'battery_percent_mark_enable': 'Show percent mark',
      'battery_percent_mark_settings_enable': 'Enable mark custom settings',
      'battery_percent_mark_typefase': 'Percent mark font',
      'battery_percent_mark_typefasestyle': 'Percent mark font style',
      'text_bat_color_mark_0': 'Mark color less than 20%',
      'text_bat_color_mark_1': 'Mark color less than 40%',
      'text_bat_color_mark_2': 'Mark color less than 60%',
      'text_bat_color_mark_3': 'Mark color less than 80%',
      'text_bat_color_mark_4': 'Mark color less than 100%',
      'battery_percent_mark_zoom': 'Mark size',
      'battery_percent_mark_division': 'Mark division',
    };
    return labels[setting.legacyKey] ?? setting.title ?? setting.legacyKey;
  }

  String? _batterySubtitle(StatusBarSettingItem setting) {
    const subtitles = <String, String>{
      'elem_bat_element_visible': 'Show or hide the status bar battery icon.',
      'battery_indicator_style': 'Matches the original Mezo style list.',
      'use_legacy_drawable': 'Switch between rectangle and MIUI oval icon render.',
      'battery_percent_typefase': 'Font file path value (Default or /product/media/fonts/*).',
      'battery_percent_mark_typefase': 'Font file path value for the percent mark.',
      'battery_percent_typefasestyle': 'Normal, bold, italic, or bold italic.',
      'battery_percent_mark_typefasestyle': 'Normal, bold, italic, or bold italic.',
      'battery_percent_mark_settings_enable': 'Enable custom mark font, colors, and size controls.',
    };
    return subtitles[setting.legacyKey];
  }

  String _stringSettingValue(StatusBarSettingItem setting, String fallback) {
    final raw = _values[setting.legacyKey];
    if (raw is String && raw.isNotEmpty) return raw;
    if (raw is num) return raw.round().toString();
    return fallback;
  }

  int _colorIntValue(StatusBarSettingItem setting, int fallback) {
    final raw = _values[setting.legacyKey];
    if (raw is int) return raw;
    if (raw is num) return raw.round();
    if (raw is String) return _colorFromHex(raw, fallback);
    return fallback;
  }

  int _colorFromHex(String hex, int fallback) {
    final value = hex.replaceAll('#', '');
    try {
      if (value.length == 6) return int.parse('FF$value', radix: 16);
      if (value.length == 8) return int.parse(value, radix: 16);
    } catch (_) {
      return fallback;
    }
    return fallback;
  }

  Future<List<StatusBarOption>> _batteryFontOptions(String current) async {
    const fontsPath = '/product/media/fonts/';
    final options = <StatusBarOption>[const StatusBarOption(label: 'Default', value: 'Default')];
    try {
      final directory = Directory(fontsPath);
      if (await directory.exists()) {
        final files = await directory.list().where((entity) => entity is File).cast<File>().toList();
        final names = files
            .map((file) => file.path.split('/').last)
            .where((name) => name.isNotEmpty)
            .toSet()
            .toList()
          ..sort();
        for (final name in names) {
          options.add(StatusBarOption(label: name, value: '$fontsPath$name'));
        }
      }
    } catch (_) {
      // Source path may not be accessible on all devices.
    }
    if (current != 'Default' && current.isNotEmpty && !options.any((option) => option.value == current)) {
      options.add(StatusBarOption(label: _fontDisplayLabel(current), value: current));
    }
    return options;
  }

  String _fontDisplayLabel(String value) {
    if (value == 'Default' || value.isEmpty) return 'Default';
    return value.split('/').last;
  }

  bool get _supportsLivePreview =>
      widget.section.id == 'battery' || widget.section.id == 'clock';

  String _groupTitle(String group) {
    switch (group) {
      case StatusBarStrings.groupLayout:
        return 'Statusbar height and structure';
      case StatusBarStrings.groupSpacing:
        return widget.section.id == 'battery' ? 'Dimensions and measurements' : 'Spacing and margins';
      case StatusBarStrings.groupNotch:
        return 'Notch settings';
      case StatusBarStrings.groupBehavior:
        return 'Behavior and visibility';
      default:
        return group;
    }
  }

  String? _groupSubtitle(String group) {
    if (widget.section.id == 'clock' && group == StatusBarStrings.groupTypography) {
      return 'Statusbar clock, notification center clock, date, weather, and settings icon scales.';
    }
    if (widget.section.id == 'battery' && group == StatusBarStrings.groupColor) {
      return 'Battery level colors, charging color, and percent tint.';
    }
    if (widget.section.id == 'resize_statusbar' && group == 'Notch settings') {
      return 'Camera location, vertical alignment, and reserved width tuning.';
    }
    if (widget.section.id == 'resize_statusbar' && group == 'Left camera notch settings') {
      return 'Left camera layout mode, reserved width, and row reservation behavior.';
    }
    return null;
  }

  StatusBarSettingItem _resizeSetting(String key) {
    final source = _settings.firstWhere((item) => item.legacyKey == key);
    if (source.controlType != StatusBarControlType.select) {
      return source;
    }
    final fallbackCandidates = MezoResizeSource.settings.where((item) => item.legacyKey == key);
    if (fallbackCandidates.isEmpty) {
      return source;
    }
    final fallback = fallbackCandidates.first;
    final hasOnlyDefaultOption = source.options.length == 1 && source.options.first.label == 'Default';
    final resolvedOptions = source.options.isEmpty || hasOnlyDefaultOption ? fallback.options : source.options;
    return StatusBarSettingItem(
      legacyKey: source.legacyKey,
      title: source.title,
      subtitle: source.subtitle,
      controlType: source.controlType,
      group: source.group,
      defaultValue: source.defaultValue,
      min: source.min,
      max: source.max,
      options: resolvedOptions,
      step: source.step,
      preferenceType: source.preferenceType,
      intentAction: source.intentAction,
      entriesReference: source.entriesReference,
      entryValuesReference: source.entryValuesReference,
      xmlReference: source.xmlReference,
      layoutReferences: source.layoutReferences,
      drawableReferences: source.drawableReferences,
    );
  }

  Future<void> _writeResizeSetting(StatusBarSettingItem setting, Object? value) async {
    if (!mounted) return;
    setState(() => _values[setting.legacyKey] = value);
    StatusbarSettingsRepository.write(setting, value);
    await ResizeStatusbarService.write(setting.legacyKey, value);
  }

  Future<bool> _ensureResizeWritePermission() async {
    final canWrite = await ResizeStatusbarService.canWriteSystemSettings();
    if (canWrite || !mounted) {
      return canWrite;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Allow modify system settings to save Resize values.'),
        action: SnackBarAction(
          label: 'Open',
          onPressed: () {
            ResizeStatusbarService.openWriteSettingsPanel();
          },
        ),
      ),
    );
    return false;
  }

  Widget _buildResizeStatusbarScreen(BuildContext context) {
    final sizeSetting = _resizeSetting('custom_status_bar_height');
    final centerSetting = _resizeSetting('status_bar_elem_center_in_island');
    final topSetting = _resizeSetting('custom_status_bar_top');
    final sideSetting = _resizeSetting('custom_status_bar_left_right');
    final cutoutPaddingSetting = _resizeSetting('status_bar_element_cutout_padding');
    final cutoutTypeSetting = _resizeSetting('status_bar_element_cutout_type');
    final cutoutCenterSetting = _resizeSetting('status_bar_element_cutout_center');
    final cutoutWidthSetting = _resizeSetting('status_bar_element_cutout_camera_width');
    final cutoutLeftSetting = _resizeSetting('status_bar_element_cutout_left');
    final leftPaddingSetting = _resizeSetting('status_bar_element_cutout_padding_left_camera');
    final leftCalcSetting = _resizeSetting('status_bar_element_cutout_left_not_calculate');

    return Scaffold(
      backgroundColor: const Color(0xFF060B17),
      appBar: AppBar(title: const Text('Resize statusbar')),
      body: ListView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 12,
          bottom: MediaQuery.paddingOf(context).bottom + 140,
        ),
        children: <Widget>[
          if (_isLoadingResize || _isLoadingStoredValues)
            const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: LinearProgressIndicator(minHeight: 2),
            ),
          const SectionHeader(
            title: 'Resize statusbar',
            subtitle: 'Adjust height, margins, and camera cutout behavior.',
          ),
          const SizedBox(height: 12),
          _ResizeHeroSizeCard(
            value: ((_values[sizeSetting.legacyKey] as num?) ?? 99).toDouble(),
            subtitle: sizeSetting.subtitle ?? 'Reboot device after adjustment',
            onTap: () => _openResizeSliderSheet(setting: sizeSetting, title: 'Status bar size'),
          ),
          const SizedBox(height: 14),
          const SectionHeader(title: 'Layout spacing'),
          const SizedBox(height: 8),
          MezoGlassPanel(
            child: Column(
              children: <Widget>[
                _ResizeSwitchCard(
                  title: centerSetting.title ?? centerSetting.legacyKey,
                  value: (_values[centerSetting.legacyKey] as bool?) ?? true,
                  onChanged: (next) async {
                    if (!await _ensureResizeWritePermission()) return;
                    await _writeResizeSetting(centerSetting, next);
                  },
                ),
                const Divider(height: 18),
                _ResizeInlineSliderCard(
                  title: topSetting.title ?? topSetting.legacyKey,
                  min: topSetting.min ?? 0,
                  max: topSetting.max ?? 40,
                  defaultValue: (topSetting.defaultValue as num).toDouble(),
                  value: ((_values[topSetting.legacyKey] as num?) ?? 2).toDouble(),
                  onLiveChanged: (v) => setState(() => _values[topSetting.legacyKey] = v),
                  onCommitted: (v) async {
                    if (!await _ensureResizeWritePermission()) return;
                    await _writeResizeSetting(topSetting, v);
                  },
                ),
                const Divider(height: 18),
                _ResizeInlineSliderCard(
                  title: sideSetting.title ?? sideSetting.legacyKey,
                  min: sideSetting.min ?? 0,
                  max: sideSetting.max ?? 200,
                  defaultValue: (sideSetting.defaultValue as num).toDouble(),
                  value: ((_values[sideSetting.legacyKey] as num?) ?? 0).toDouble(),
                  onLiveChanged: (v) => setState(() => _values[sideSetting.legacyKey] = v),
                  onCommitted: (v) async {
                    if (!await _ensureResizeWritePermission()) return;
                    await _writeResizeSetting(sideSetting, v);
                  },
                ),
                const Divider(height: 18),
                _ResizeInlineSliderCard(
                  title: cutoutPaddingSetting.title ?? cutoutPaddingSetting.legacyKey,
                  min: cutoutPaddingSetting.min ?? 0,
                  max: cutoutPaddingSetting.max ?? 150,
                  defaultValue: (cutoutPaddingSetting.defaultValue as num).toDouble(),
                  value: ((_values[cutoutPaddingSetting.legacyKey] as num?) ?? 35).toDouble(),
                  onLiveChanged: (v) => setState(() => _values[cutoutPaddingSetting.legacyKey] = v),
                  onCommitted: (v) async {
                    if (!await _ensureResizeWritePermission()) return;
                    await _writeResizeSetting(cutoutPaddingSetting, v);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const SectionHeader(title: 'Camera cutout'),
          const SizedBox(height: 8),
          MezoGlassPanel(
            child: Column(
              children: <Widget>[
                _ResizeSelectCard(
                  title: cutoutTypeSetting.title ?? cutoutTypeSetting.legacyKey,
                  value: (_values[cutoutTypeSetting.legacyKey] as String?) ?? '${cutoutTypeSetting.defaultValue}',
                  options: cutoutTypeSetting.options,
                  onTap: () => _openResizeSelectSheet(cutoutTypeSetting),
                ),
                const Divider(height: 18),
                _ResizeSelectCard(
                  title: cutoutCenterSetting.title ?? cutoutCenterSetting.legacyKey,
                  value: (_values[cutoutCenterSetting.legacyKey] as String?) ?? '${cutoutCenterSetting.defaultValue}',
                  options: cutoutCenterSetting.options,
                  onTap: () => _openResizeSelectSheet(cutoutCenterSetting),
                ),
                const Divider(height: 18),
                _ResizeInlineSliderCard(
                  title: cutoutWidthSetting.title ?? cutoutWidthSetting.legacyKey,
                  min: cutoutWidthSetting.min ?? 1,
                  max: cutoutWidthSetting.max ?? 200,
                  defaultValue: (cutoutWidthSetting.defaultValue as num).toDouble(),
                  value: ((_values[cutoutWidthSetting.legacyKey] as num?) ?? 80).toDouble(),
                  onLiveChanged: (v) => setState(() => _values[cutoutWidthSetting.legacyKey] = v),
                  onCommitted: (v) async {
                    if (!await _ensureResizeWritePermission()) return;
                    await _writeResizeSetting(cutoutWidthSetting, v);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const SectionHeader(title: 'Left camera notch settings'),
          const SizedBox(height: 8),
          MezoGlassPanel(
            child: Column(
              children: <Widget>[
                _ResizeSelectCard(
                  title: cutoutLeftSetting.title ?? cutoutLeftSetting.legacyKey,
                  value: (_values[cutoutLeftSetting.legacyKey] as String?) ?? '${cutoutLeftSetting.defaultValue}',
                  options: cutoutLeftSetting.options,
                  onTap: () => _openResizeSelectSheet(cutoutLeftSetting),
                ),
                const Divider(height: 18),
                _ResizeInlineSliderCard(
                  title: leftPaddingSetting.title ?? leftPaddingSetting.legacyKey,
                  min: leftPaddingSetting.min ?? 10,
                  max: leftPaddingSetting.max ?? 150,
                  defaultValue: (leftPaddingSetting.defaultValue as num).toDouble(),
                  value: ((_values[leftPaddingSetting.legacyKey] as num?) ?? 75).toDouble(),
                  onLiveChanged: (v) => setState(() => _values[leftPaddingSetting.legacyKey] = v),
                  onCommitted: (v) async {
                    if (!await _ensureResizeWritePermission()) return;
                    await _writeResizeSetting(leftPaddingSetting, v);
                  },
                ),
                const Divider(height: 18),
                _ResizeSelectCard(
                  title: leftCalcSetting.title ?? leftCalcSetting.legacyKey,
                  value: (_values[leftCalcSetting.legacyKey] as String?) ?? '${leftCalcSetting.defaultValue}',
                  options: leftCalcSetting.options,
                  onTap: () => _openResizeSelectSheet(leftCalcSetting),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openResizeSliderSheet({
    required StatusBarSettingItem setting,
    required String title,
  }) async {
    if (!await _ensureResizeWritePermission()) return;
    final initial = ((_values[setting.legacyKey] as num?) ?? (setting.defaultValue as num)).toDouble();
    if (!mounted) return;
    final selected = await showModalBottomSheet<double>(
      context: context,
      backgroundColor: const Color(0xFF0D1424),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (context) => _ResizeSliderSheet(
        title: title,
        initial: initial,
        min: setting.min ?? 0,
        max: setting.max ?? 100,
        defaultValue: (setting.defaultValue as num).toDouble(),
      ),
    );
    if (!mounted || selected == null) return;
    await _writeResizeSetting(setting, selected);
  }

  Future<void> _openResizeSelectSheet(StatusBarSettingItem setting) async {
    if (!await _ensureResizeWritePermission()) return;
    if (!mounted) return;
    final current = (_values[setting.legacyKey] as String?) ?? '${setting.defaultValue}';
    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (sheetContext) => _ResizeSelectSheet(
        title: setting.title ?? setting.legacyKey,
        current: current,
        options: setting.options,
        sheetContext: sheetContext,
      ),
    );
    if (!context.mounted) return;
    if (selected == null) return;
    await _writeResizeSetting(setting, selected);
  }
}

class _ResizeHeroSizeCard extends StatelessWidget {
  const _ResizeHeroSizeCard({
    required this.value,
    required this.subtitle,
    required this.onTap,
  });

  final double value;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Ink(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: const LinearGradient(colors: <Color>[Color(0xFF123750), Color(0xFF291B48)]),
          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: <Widget>[
            const Icon(Icons.height_rounded, color: Color(0xFF8DE8FF)),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Status bar size', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
                  SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            Text(
              value.toStringAsFixed(0),
              style: const TextStyle(color: Color(0xFFC4FDFF), fontSize: 28, fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResizeSwitchCard extends StatelessWidget {
  const _ResizeSwitchCard({required this.title, required this.value, required this.onChanged});

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
        Switch(value: value, onChanged: onChanged),
      ],
    );
  }
}

class _ResizeInlineSliderCard extends StatefulWidget {
  const _ResizeInlineSliderCard({
    required this.title,
    required this.value,
    required this.min,
    required this.max,
    required this.defaultValue,
    required this.onLiveChanged,
    required this.onCommitted,
  });

  final String title;
  final double value;
  final double min;
  final double max;
  final double defaultValue;
  final ValueChanged<double> onLiveChanged;
  final ValueChanged<double> onCommitted;

  @override
  State<_ResizeInlineSliderCard> createState() => _ResizeInlineSliderCardState();
}

class _ResizeInlineSliderCardState extends State<_ResizeInlineSliderCard> {
  late double _localValue = widget.value.clamp(widget.min, widget.max).toDouble();

  @override
  void didUpdateWidget(covariant _ResizeInlineSliderCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _localValue = widget.value.clamp(widget.min, widget.max).toDouble();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(child: Text(widget.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(99),
              ),
              child: Text(_localValue.toStringAsFixed(0), style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w700)),
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () {
                setState(() => _localValue = widget.defaultValue);
                widget.onLiveChanged(widget.defaultValue);
                widget.onCommitted(widget.defaultValue);
              },
              child: const Text('Reset'),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                final next = (_localValue - 1).clamp(widget.min, widget.max).toDouble();
                setState(() => _localValue = next);
                widget.onLiveChanged(next);
                widget.onCommitted(next);
              },
              icon: const Icon(Icons.remove_rounded, color: Colors.white70),
            ),
            Expanded(
              child: Slider(
                value: _localValue,
                min: widget.min,
                max: widget.max,
                activeColor: const Color(0xFF8DE8FF),
                onChanged: (value) {
                  setState(() => _localValue = value);
                  widget.onLiveChanged(value);
                },
                onChangeEnd: widget.onCommitted,
              ),
            ),
            IconButton(
              onPressed: () {
                final next = (_localValue + 1).clamp(widget.min, widget.max).toDouble();
                setState(() => _localValue = next);
                widget.onLiveChanged(next);
                widget.onCommitted(next);
              },
              icon: const Icon(Icons.add_rounded, color: Colors.white70),
            ),
          ],
        ),
      ],
    );
  }
}

class _ResizeSelectCard extends StatelessWidget {
  const _ResizeSelectCard({
    required this.title,
    required this.value,
    required this.options,
    required this.onTap,
  });

  final String title;
  final String value;
  final List<StatusBarOption> options;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (options.isEmpty) {
      return const SizedBox.shrink();
    }
    final label = options.firstWhere((option) => option.value == value, orElse: () => options.first).label;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: <Widget>[
            Expanded(child: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
            Flexible(
              child: Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white60),
          ],
        ),
      ),
    );
  }
}

class _ResizeSliderSheet extends StatefulWidget {
  const _ResizeSliderSheet({
    required this.title,
    required this.initial,
    required this.min,
    required this.max,
    required this.defaultValue,
  });

  final String title;
  final double initial;
  final double min;
  final double max;
  final double defaultValue;

  @override
  State<_ResizeSliderSheet> createState() => _ResizeSliderSheetState();
}

class _ResizeSliderSheetState extends State<_ResizeSliderSheet> {
  late double _value = widget.initial;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(18, 14, 18, MediaQuery.of(context).padding.bottom + 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(widget.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
            const SizedBox(height: 8),
            Text(_value.toStringAsFixed(0), style: const TextStyle(color: Color(0xFF8DE8FF), fontSize: 28, fontWeight: FontWeight.w800)),
            Slider(
              value: _value,
              min: widget.min,
              max: widget.max,
              activeColor: const Color(0xFF8DE8FF),
              onChanged: (value) => setState(() => _value = value),
            ),
            Row(
              children: <Widget>[
                OutlinedButton(
                  onPressed: () => setState(() => _value = widget.defaultValue),
                  child: const Text('Reset'),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(_value);
                  },
                  child: const Text('Set'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ResizeSelectSheet extends StatelessWidget {
  const _ResizeSelectSheet({
    required this.title,
    required this.current,
    required this.options,
    required this.sheetContext,
  });

  final String title;
  final String current;
  final List<StatusBarOption> options;
  final BuildContext sheetContext;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        child: Container(
          constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.72),
          decoration: BoxDecoration(
            color: const Color(0xFF0B1522).withValues(alpha: 0.96),
            border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
          ),
          child: ListView(
            padding: EdgeInsets.fromLTRB(16, 14, 16, MediaQuery.paddingOf(context).bottom + 18),
            shrinkWrap: true,
            children: <Widget>[
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 17)),
              const SizedBox(height: 12),
              for (final option in options) ...<Widget>[
                InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => Navigator.of(sheetContext).pop(option.value),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            option.label,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(width: 10),
                        if (option.value == current) const Icon(Icons.check_rounded, color: Color(0xFF8DE8FF)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _BackgroundModuleEditor extends StatelessWidget {
  const _BackgroundModuleEditor({required this.values, required this.onChanged});

  final Map<String, Object?> values;
  final void Function(String key, Object? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SectionHeader(
            title: 'Background of statusbar icons',
            subtitle: 'Source-backed editor from settings_iback + elem_bg_* references.',
          ),
          const SizedBox(height: 10),
          ...MezoPortMap.backgroundTargets.map((target) {
            return ExpansionTile(
              tilePadding: EdgeInsets.zero,
              collapsedIconColor: Colors.white70,
              iconColor: Colors.white,
              title: Text(target.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              subtitle: Text(target.xmlSource, style: TextStyle(color: Colors.white.withValues(alpha: 0.56), fontSize: 11)),
              children: <Widget>[
                for (final colorKey in target.colorKeys) ...<Widget>[
                  SettingsRow(
                    icon: Icons.palette_outlined,
                    iconColor: const Color(0xFF94E0D4),
                    title: _prettyKey(colorKey),
                    subtitle: colorKey,
                    trailing: MezoColorChip(
                      hex: (values[colorKey] as String?) ?? '#00000000',
                      onTap: () => _showColorPicker(context, colorKey),
                    ),
                  ),
                  const Divider(height: 18),
                ],
                for (final sliderKey in target.sliderKeys) ...<Widget>[
                  SettingsRow(
                    icon: Icons.tune_rounded,
                    iconColor: const Color(0xFF8FCBFF),
                    title: _prettyKey(sliderKey),
                    subtitle: sliderKey,
                    trailing: Text(((values[sliderKey] as num?) ?? 0).toStringAsFixed(0), style: const TextStyle(color: Colors.white70)),
                  ),
                  MezoStepSlider(
                    value: ((values[sliderKey] as num?) ?? 0).toDouble(),
                    min: _minForSlider(sliderKey),
                    max: _maxForSlider(sliderKey),
                    onChanged: (v) => onChanged(sliderKey, v),
                  ),
                  const Divider(height: 18),
                ],
              ],
            );
          }),
        ],
      ),
    );
  }

  Future<void> _showColorPicker(BuildContext context, String key) async {
    final current = DeadzoneColorUtils.parseHex((values[key] as String?) ?? '#00000000', fallbackArgb: 0);
    final picked = await showDeadZoneColorPicker(context: context, initialArgb: current, defaultArgb: 0x00000000, title: _prettyKey(key));
    if (!context.mounted || picked == null) return;
    onChanged(key, DeadzoneColorUtils.toArgbHex(picked));
  }

  static String _prettyKey(String key) => key
      .replaceAll('elem_', '')
      .replaceAll('_bg_', ' ')
      .replaceAll('_', ' ')
      .replaceAll('padd', 'padding')
      .replaceAll('LT', 'top-left')
      .replaceAll('RT', 'top-right')
      .replaceAll('LB', 'bottom-left')
      .replaceAll('RB', 'bottom-right');

  static double _minForSlider(String key) {
    if (key.endsWith('_stroke_width')) return 0;
    if (key.contains('_corner')) return -25;
    return -10;
  }

  static double _maxForSlider(String key) {
    if (key.endsWith('_stroke_width')) return 5;
    if (key.contains('_corner')) return 90;
    return 30;
  }
}

class _BatteryHeroCard extends StatelessWidget {
  const _BatteryHeroCard({required this.values});

  final Map<String, Object?> values;

  @override
  Widget build(BuildContext context) {
    final visible = (values['elem_bat_element_visible'] as bool?) ?? true;
    final iconSize = ((values['batteryview_zoom'] as num?) ?? 100).toDouble();
    final percentSize = ((values['battery_percent_zoom'] as num?) ?? 14).toDouble();
    final rawColor = values['text_bat_color_4'];
    final color = rawColor is int
        ? Color(rawColor)
        : MezoColorChip.fromHex((rawColor as String?) ?? '#00000000');
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(colors: <Color>[Color(0xFF0A1F3E), Color(0xFF1A1540)]),
        border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Battery', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30)),
          Text(
            'Battery icon style, size, percent, and charging visuals',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.75)),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.28),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.battery_6_bar_rounded, color: visible ? color : Colors.white24, size: (iconSize / 100) * 28),
                const SizedBox(width: 10),
                Text(
                  visible ? '78%' : 'Hidden',
                  style: TextStyle(color: Colors.white, fontSize: percentSize.clamp(12, 24).toDouble(), fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                Text('Live', style: TextStyle(color: const Color(0xFF8DE8FF).withValues(alpha: 0.9))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String? _cleanVisibleSubtitle(String? subtitle) {
  if (subtitle == null) return null;
  final trimmed = subtitle.trim();
  if (trimmed.isEmpty) return null;
  final value = trimmed.toLowerCase();
  if (value.contains('source-preserved') ||
      value.contains('depends on') ||
      value.contains('legacy fragment') ||
      value.contains('android.theme')) {
    return null;
  }
  return trimmed;
}

class _BatterySectionCard extends StatelessWidget {
  const _BatterySectionCard({required this.title, required this.subtitle, required this.children});

  final String title;
  final String subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final sectionSubtitle = _cleanVisibleSubtitle(subtitle);
    return MezoGlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
          if (sectionSubtitle != null) ...<Widget>[
            const SizedBox(height: 4),
            Text(sectionSubtitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.68), fontSize: 12.5)),
          ],
          const SizedBox(height: 12),
          for (var i = 0; i < children.length; i++) ...<Widget>[
            children[i],
            if (i != children.length - 1) Divider(height: 18, color: Colors.white.withValues(alpha: 0.08)),
          ],
        ],
      ),
    );
  }
}

class _BatteryToggleTile extends StatelessWidget {
  const _BatteryToggleTile({required this.title, required this.value, required this.onChanged, this.subtitle});

  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final visibleSubtitle = _cleanVisibleSubtitle(subtitle);
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              if (visibleSubtitle != null)
                Text(visibleSubtitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12)),
            ],
          ),
        ),
        Switch(value: value, onChanged: onChanged),
      ],
    );
  }
}

class _BatterySliderTile extends StatelessWidget {
  const _BatterySliderTile({
    required this.title,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    required this.onReset,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return MezoSourceSeekbarRow(
      title: title,
      subtitle: subtitle,
      value: value,
      min: min,
      max: max,
      onChanged: onChanged,
      onReset: onReset,
    );
  }
}

class _BatterySelectTile extends StatelessWidget {
  const _BatterySelectTile({required this.title, required this.valueLabel, required this.onTap, this.subtitle});

  final String title;
  final String? subtitle;
  final String valueLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final visibleSubtitle = _cleanVisibleSubtitle(subtitle);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  if (visibleSubtitle != null)
                    Text(visibleSubtitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              decoration: BoxDecoration(
                color: const Color(0xFF102938).withValues(alpha: 0.82),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF8DE8FF).withValues(alpha: 0.25)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(valueLabel, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                  const SizedBox(width: 4),
                  const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white54, size: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BatteryColorTile extends StatelessWidget {
  const _BatteryColorTile({required this.title, required this.colorValue, required this.onTap, this.subtitle});

  final String title;
  final String? subtitle;
  final int colorValue;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final visibleSubtitle = _cleanVisibleSubtitle(subtitle);
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              if (visibleSubtitle != null)
                Text(visibleSubtitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12)),
            ],
          ),
        ),
        MezoColorChip(
          hex: '#${colorValue.toUnsigned(32).toRadixString(16).padLeft(8, '0').toUpperCase()}',
          onTap: onTap,
        ),
      ],
    );
  }
}

class _BatteryInfoTile extends StatelessWidget {
  const _BatteryInfoTile({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.info_outline_rounded, color: Color(0xFF8DE8FF), size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                Text(subtitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BatteryOptionSheet extends StatelessWidget {
  const _BatteryOptionSheet({
    required this.title,
    required this.options,
    required this.selectedValue,
    required this.onSelected,
  });

  final String title;
  final List<StatusBarOption> options;
  final String selectedValue;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.78),
        decoration: BoxDecoration(
          color: const Color(0xFF071320).withValues(alpha: 0.98),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          border: Border.all(color: const Color(0xFF8DE8FF).withValues(alpha: 0.22)),
        ),
        padding: EdgeInsets.fromLTRB(16, 14, 16, MediaQuery.paddingOf(context).bottom + 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 17)),
            const SizedBox(height: 12),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: options.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final option = options[index];
                  return InkWell(
                    onTap: () => onSelected(option.value),
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F2434).withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFF8DE8FF).withValues(alpha: 0.2)),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(child: Text(option.label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
                          if (option.value == selectedValue) const Icon(Icons.check_rounded, color: Color(0xFF8DE8FF)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BatteryColorSheet extends StatelessWidget {
  const _BatteryColorSheet({
    required this.title,
    required this.current,
    required this.defaultValue,
    required this.onSelected,
  });

  final String title;
  final int current;
  final int defaultValue;
  final ValueChanged<int> onSelected;

  static const List<int> _swatches = <int>[
    0x00000000,
    0xFFFFFFFF,
    0xFF8DE8FF,
    0xFF76A7FF,
    0xFFB9A3FF,
    0xFF90FFAC,
    0xFFFFC66D,
    0xFFFF8EA8,
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF071320).withValues(alpha: 0.98),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          border: Border.all(color: const Color(0xFF8DE8FF).withValues(alpha: 0.22)),
        ),
        padding: EdgeInsets.fromLTRB(16, 14, 16, MediaQuery.paddingOf(context).bottom + 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 17)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _swatches
                  .map(
                    (value) => InkWell(
                      onTap: () => onSelected(value),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: Color(value),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: value == current ? Colors.white : Colors.white.withValues(alpha: 0.3),
                            width: value == current ? 2 : 1,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 14),
            TextButton(
              onPressed: () => onSelected(defaultValue),
              child: const Text('Reset to default'),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailLivePreview extends StatelessWidget {
  const _DetailLivePreview({required this.sectionId, required this.values});

  final String sectionId;
  final Map<String, Object?> values;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SectionHeader(
            title: 'Live preview',
            subtitle: 'Instant response while you tune controls.',
          ),
          const SizedBox(height: 12),
          if (sectionId == 'resize_statusbar') _ResizePreview(values: values),
          if (sectionId == 'battery') _BatteryPreview(values: values),
          if (sectionId == 'clock') _ClockPreview(values: values),
        ],
      ),
    );
  }
}

class _SettingControl extends StatelessWidget {
  const _SettingControl({
    required this.setting,
    required this.value,
    required this.onChanged,
    required this.isResizeSection,
  });

  final StatusBarSettingItem setting;
  final Object? value;
  final ValueChanged<Object?> onChanged;
  final bool isResizeSection;

  String get _title => setting.title ?? setting.legacyKey;

  @override
  Widget build(BuildContext context) {
    switch (setting.controlType) {
      case StatusBarControlType.toggle:
        return SettingsRow(
          icon: Icons.toggle_on_rounded,
          iconColor: const Color(0xFF87EED8),
          title: _title,
          subtitle: setting.subtitle,
          trailing: Switch(
            value: (value as bool?) ?? false,
            onChanged: (next) => onChanged(next),
          ),
        );
      case StatusBarControlType.slider:
        final min = setting.min ?? 0;
        final max = setting.max ?? 100;
        final current = (value as num?)?.toDouble() ?? min;
        if (isResizeSection) {
          return MezoSourceSeekbarRow(
            title: _title,
            subtitle: setting.subtitle,
            value: current.clamp(min, max),
            min: min,
            max: max,
            onChanged: (v) => onChanged(v),
            onReset: () => onChanged(setting.defaultValue),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SettingsRow(
              icon: Icons.tune_rounded,
              iconColor: const Color(0xFF8FCBFF),
              title: _title,
              subtitle: setting.subtitle,
              trailing: Text(current.toStringAsFixed(0), style: const TextStyle(color: Colors.white70)),
            ),
            MezoStepSlider(
              value: current.clamp(min, max),
              min: min,
              max: max,
              onChanged: (v) => onChanged(v),
            ),
          ],
        );
      case StatusBarControlType.select:
        final current = (value as String?) ?? setting.options.first.value;
        final label = setting.options.firstWhere((option) => option.value == current).label;
        return SettingsRow(
          icon: Icons.view_list_rounded,
          iconColor: const Color(0xFF9FAAFF),
          title: _title,
          subtitle: setting.subtitle,
          trailing: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => _showOptionPicker(context, current),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                  const SizedBox(width: 4),
                  const Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: Colors.white54),
                ],
              ),
            ),
          ),
        );
      case StatusBarControlType.color:
        final int currentArgb = value is int
            ? value as int
            : DeadzoneColorUtils.parseHex((value as String?) ?? '#00000000', fallbackArgb: 0);
        return SettingsRow(
          icon: Icons.palette_rounded,
          iconColor: const Color(0xFFA1E9DB),
          title: _title,
          subtitle: setting.subtitle,
          trailing: MezoColorChip(
            hex: DeadzoneColorUtils.toArgbHex(currentArgb),
            onTap: () => _showColorPicker(context, currentArgb),
          ),
        );
    }
  }

  Future<void> _showOptionPicker(BuildContext context, String current) async {
    final isFontPicker = _title.toLowerCase().contains('font');
    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: const Color(0xFF101B1F),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (context) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
                child: Text(_title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
              ),
              for (final option in setting.options)
                isFontPicker
                    ? ListTile(
                        title: Text(
                          option.label,
                          style: _fontFor(option.value, const TextStyle(color: Colors.white, fontSize: 15)),
                        ),
                        subtitle: Text(
                          '12:48  Wed',
                          style: _fontFor(option.value, TextStyle(color: Colors.white.withValues(alpha: 0.62), fontSize: 12)),
                        ),
                        trailing: option.value == current ? const Icon(Icons.check_rounded, color: Color(0xFF79E3CB)) : null,
                        onTap: () => Navigator.of(context).pop(option.value),
                      )
                    : ListTile(
                        title: Text(option.label, style: const TextStyle(color: Colors.white70)),
                        trailing: option.value == current ? const Icon(Icons.check_rounded, color: Color(0xFF79E3CB)) : null,
                        onTap: () => Navigator.of(context).pop(option.value),
                      ),
            ],
          ),
        );
      },
    );

    if (selected != null) {
      onChanged(selected);
    }
  }

  Future<void> _showColorPicker(BuildContext context, int currentArgb) async {
    final int? selectedArgb = await showDeadZoneColorPicker(context: context, initialArgb: currentArgb, defaultArgb: 0x00000000, title: _title);
    if (!context.mounted || selectedArgb == null) return;
    if (value is int || setting.defaultValue is int) {
      onChanged(selectedArgb);
      return;
    }
    onChanged(DeadzoneColorUtils.toArgbHex(selectedArgb));
  }

  TextStyle _fontFor(String value, TextStyle fallback) {
    switch (value) {
      case 'inter':
        return GoogleFonts.inter(textStyle: fallback);
      case 'din':
        return GoogleFonts.getFont('Roboto Condensed', textStyle: fallback);
      case 'mono':
        return GoogleFonts.robotoMono(textStyle: fallback);
      case 'roboto':
        return GoogleFonts.roboto(textStyle: fallback);
      default:
        return fallback;
    }
  }
}

class _ResizePreview extends StatelessWidget {
  const _ResizePreview({required this.values});

  final Map<String, Object?> values;

  String _resizePreviewSummary({
    required double height,
    required String cutoutType,
    required String cutoutPosition,
    required String removeCameraBehavior,
  }) {
    final cameraLocationLabel = switch (cutoutType) {
      '0' => 'No camera cutout',
      '2' => 'Left camera cutout',
      _ => 'Center camera cutout',
    };

    final cameraPositionLabel = switch (cutoutPosition) {
      '0' => 'Top aligned',
      '1' => 'Middle aligned',
      _ => 'Bottom aligned',
    };

    final reservationLabel = switch (removeCameraBehavior) {
      '0' => 'Top row reserved',
      '1' => 'Bottom row reserved',
      _ => 'Both rows balanced',
    };

    return 'Height ${height.toStringAsFixed(0)} • $cameraLocationLabel • $cameraPositionLabel • $reservationLabel';
  }

  @override
  Widget build(BuildContext context) {
    final statusbarHeight = ((values['custom_status_bar_height'] as num?) ?? 99).toDouble();
    final top = ((values['custom_status_bar_top'] as num?) ?? 2).toDouble();
    final side = ((values['custom_status_bar_left_right'] as num?) ?? 0).toDouble();
    final cutoutPadding = ((values['status_bar_element_cutout_padding'] as num?) ?? 35).toDouble();
    final cameraWidth = ((values['status_bar_element_cutout_camera_width'] as num?) ?? 80).toDouble();
    final cutoutType = (values['status_bar_element_cutout_type'] as String?) ?? '1';
    final cutoutPosition = (values['status_bar_element_cutout_center'] as String?) ?? '2';
    final leftCutoutPlacement = (values['status_bar_element_cutout_left'] as String?) ?? '2';
    final firstElementPosition = ((values['status_bar_element_cutout_padding_left_camera'] as num?) ?? 75).toDouble();
    final removeCameraBehavior = (values['status_bar_element_cutout_left_not_calculate'] as String?) ?? '2';
    final showCenterInIsland = (values['status_bar_elem_center_in_island'] as bool?) ?? true;

    final previewScale = (statusbarHeight / 100).clamp(0.5, 2.5);
    final barHeight = (34 * previewScale).clamp(24, 70).toDouble();
    final baseTopMargin = (top / 2).clamp(0, 20).toDouble();
    final horizontalMargin = (side / 8).clamp(0, 25).toDouble();
    final cameraPillWidth = cameraWidth.clamp(30, 140).toDouble();

    final bool showCamera = cutoutType != '0';
    Alignment cameraAlignment = Alignment.topCenter;
    if (cutoutType == '2') {
      cameraAlignment = Alignment.topLeft;
    }
    final cameraY = switch (cutoutPosition) {
      '0' => baseTopMargin + 3,
      '1' => baseTopMargin + (barHeight / 2) - 6,
      _ => baseTopMargin + barHeight - 12,
    };

    final reserveTopLine = removeCameraBehavior == '0';
    final reserveBottomLine = removeCameraBehavior == '1';
    final leftShift = ((firstElementPosition - 75) / 7).clamp(-8, 12).toDouble();

    double leftTopX = 8 + leftShift;
    double leftBottomX = 8 + leftShift;
    double rightTopX = 8;
    double rightBottomX = 8;

    if (cutoutType == '2') {
      switch (leftCutoutPlacement) {
        case '0':
          rightTopX = 26;
          rightBottomX = 26;
          break;
        case '1':
          rightTopX = 26;
          break;
        case '2':
          rightBottomX = 26;
          break;
        case '3':
          leftTopX = 22 + leftShift;
          leftBottomX = 22 + leftShift;
          break;
      }
    }

    return Container(
      height: 130,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            const Color(0xFF153242).withValues(alpha: 0.56),
            const Color(0xFF0D1A2A).withValues(alpha: 0.34),
          ],
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF83E9FF).withValues(alpha: 0.12),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              margin: EdgeInsets.fromLTRB(horizontalMargin, baseTopMargin, horizontalMargin, 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
              ),
            ),
          ),
          Positioned(
            left: 12 + leftTopX,
            top: baseTopMargin + 4,
            child: _PreviewDot(
              width: reserveTopLine ? 26 : 18,
              active: !reserveTopLine,
            ),
          ),
          Positioned(
            left: 12 + leftBottomX,
            top: baseTopMargin + barHeight - 14,
            child: _PreviewDot(
              width: reserveBottomLine ? 26 : 18,
              active: !reserveBottomLine,
            ),
          ),
          Positioned(
            right: 12 + rightTopX,
            top: baseTopMargin + 4,
            child: const _PreviewDot(width: 18),
          ),
          Positioned(
            right: 12 + rightBottomX,
            top: baseTopMargin + barHeight - 14,
            child: const _PreviewDot(width: 18),
          ),
          if (showCenterInIsland)
            Positioned(
              left: 0,
              right: 0,
              top: baseTopMargin + (barHeight / 2) - 6,
              child: const Center(child: _PreviewDot(width: 22)),
            ),
          if (showCamera)
            Align(
              alignment: cameraAlignment,
              child: Container(
                width: cameraPillWidth,
                height: 12,
                margin: EdgeInsets.only(
                  top: cameraY + (cutoutPadding / 18),
                  left: cutoutType == '2' ? 14 : 0,
                ),
                decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(8)),
              ),
            ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 2,
            child: Text(
              _resizePreviewSummary(
                height: statusbarHeight,
                cutoutType: cutoutType,
                cutoutPosition: cutoutPosition,
                removeCameraBehavior: removeCameraBehavior,
              ),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewDot extends StatelessWidget {
  const _PreviewDot({required this.width, this.active = true});

  final double width;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: DesignTokens.motionFast,
      curve: DesignTokens.motionCurve,
      width: width,
      height: 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(99),
        color: active ? const Color(0xFF8DE8FF) : Colors.white.withValues(alpha: 0.28),
      ),
    );
  }
}

class _NetspeedPreview extends StatelessWidget {
  const _NetspeedPreview({required this.values});

  final Map<String, Object?> values;

  @override
  Widget build(BuildContext context) {
    final mode = (values['status_bar_show_network_speed'] as String?) ?? '1';
    final textSize = ((values['net_speed_zoom'] as num?) ?? 12).toDouble().clamp(8, 26).toDouble();
    final spacing = ((values['net_speed_division'] as num?) ?? 20).toDouble().clamp(0, 40).toDouble();
    final offset = ((values['net_speed_height'] as num?) ?? 50).toDouble();
    final colorHex = (values['net_speed_color'] as String?) ?? '#00000000';
    final colorValue = _StaticColorTools.fromHex(colorHex, 0xFFFFFFFF);
    final fontValue = (values['net_speed_typefase'] as String?) ?? 'Default';

    final interval = ((values['status_bar_network_speed_interval'] as num?) ?? 1000).toInt();
    final sample = switch (mode) {
      '0' => '--',
      '2' => '↑ 24 KB/s\n↓ 128 KB/s',
      '3' => '12.4 KB/s',
      _ => '↑↓ 12.4 KB/s',
    };
    final modeLabel = switch (mode) {
      '0' => 'Hidden',
      '1' => 'One line',
      '2' => 'Two lines',
      _ => 'Default',
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            const Color(0xFF153347).withValues(alpha: 0.62),
            const Color(0xFF0B1B2E).withValues(alpha: 0.34),
          ],
        ),
        border: Border.all(color: const Color(0xFF8DE8FF).withValues(alpha: 0.24)),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.speed_rounded, color: Color(0xFF8DE8FF), size: 18),
          SizedBox(width: (spacing / 5).clamp(6, 18).toDouble()),
          Transform.translate(
            offset: Offset(0, (offset - 50) / 20),
            child: Text(
              sample,
              style: _StaticColorTools.fontFor(
                fontValue,
                TextStyle(
                  color: Color(colorValue),
                  fontSize: textSize,
                  fontWeight: FontWeight.w700,
                  height: 1.05,
                ),
              ),
            ),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                modeLabel,
                style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 11, fontWeight: FontWeight.w600),
              ),
              Text(
                '${interval}ms',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.58), fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NetworkPreview extends StatelessWidget {
  const _NetworkPreview({required this.values});

  final Map<String, Object?> values;

  @override
  Widget build(BuildContext context) {
    final simVisible = (values['elem_net_element_visible'] as bool?) ?? true;
    final wifiVisible = (values['elem_wifi_element_visible'] as bool?) ?? true;
    final vpnVisible = (values['vpn_visible'] as bool?) ?? true;
    final vowifiVisible = (values['vowifi_visible'] as bool?) ?? true;
    final roamVisible = (values['roam_visible'] as bool?) ?? true;

    final simColor = Color((values['sim_one_color'] as int?) ?? 0xFF8DE8FF);
    final wifiColor = Color((values['wifiview_color'] as int?) ?? 0xFF90FFAC);
    final vpnColor = Color((values['vpn_color'] as int?) ?? 0xFFB9A3FF);
    final vowifiColor = Color((values['vowifi_color'] as int?) ?? 0xFF76A7FF);
    final roamColor = Color((values['roam_color'] as int?) ?? 0xFFFFC66D);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            const Color(0xFF153347).withValues(alpha: 0.62),
            const Color(0xFF0B1B2E).withValues(alpha: 0.34),
          ],
        ),
        border: Border.all(color: const Color(0xFF8DE8FF).withValues(alpha: 0.24)),
      ),
      child: Row(
        children: <Widget>[
          if (simVisible) ...<Widget>[
            Icon(Icons.sim_card_rounded, color: simColor, size: 18),
            const SizedBox(width: 6),
            Icon(Icons.sim_card_rounded, color: simColor.withValues(alpha: 0.75), size: 18),
          ],
          if (wifiVisible) ...<Widget>[
            const SizedBox(width: 8),
            Icon(Icons.wifi_rounded, color: wifiColor, size: 18),
          ],
          if (vpnVisible) ...<Widget>[
            const SizedBox(width: 8),
            Icon(Icons.verified_rounded, color: vpnColor, size: 16),
          ],
          if (vowifiVisible) ...<Widget>[
            const SizedBox(width: 8),
            Icon(Icons.wifi_calling_3_rounded, color: vowifiColor, size: 16),
          ],
          if (roamVisible) ...<Widget>[
            const SizedBox(width: 8),
            Icon(Icons.travel_explore_rounded, color: roamColor, size: 16),
          ],
          const Spacer(),
          Text(
            '5G',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.82), fontWeight: FontWeight.w700, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _BatteryPreview extends StatelessWidget {
  const _BatteryPreview({required this.values});

  final Map<String, Object?> values;
  @override
  Widget build(BuildContext context) {
    final show = (values['elem_bat_element_visible'] as bool?) ?? true;
    final iconScale = ((((values['batteryview_zoom'] as num?) ?? 100).toDouble() / 100).clamp(0.5, 1.5)).toDouble();
    final percentSize = ((values['battery_percent_zoom'] as num?) ?? 14).toDouble();
    final batteryColor = MezoColorChip.fromHex((values['battery_level_80_color'] as String?) ?? '#90FFAC');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.black.withValues(alpha: 0.22),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Row(
        children: <Widget>[
          AnimatedOpacity(
            duration: DesignTokens.motionFast,
            opacity: show ? 1 : 0.3,
            child: Transform.scale(
              scale: iconScale,
              child: Container(
                width: 34,
                height: 16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: batteryColor, width: 1.6),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 20,
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(color: batteryColor, borderRadius: BorderRadius.circular(2)),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '82%',
            style: TextStyle(color: Colors.white, fontSize: percentSize.clamp(10, 22).toDouble()),
          ),
        ],
      ),
    );
  }
}

class _NetworkIconStyleBinding {
  const _NetworkIconStyleBinding({
    required this.title,
    required this.settingsKey,
    required this.packageHintTokens,
  });

  final String title;
  final String settingsKey;
  final List<String> packageHintTokens;
}

class _StaticColorTools {
  static int fromHex(String hex, int fallback) {
    final value = hex.replaceAll('#', '');
    try {
      if (value.length == 6) return int.parse('FF$value', radix: 16);
      if (value.length == 8) return int.parse(value, radix: 16);
    } catch (_) {
      return fallback;
    }
    return fallback;
  }

  static TextStyle fontFor(String value, TextStyle fallback) {
    switch (value) {
      case 'inter':
        return GoogleFonts.inter(textStyle: fallback);
      case 'din':
        return GoogleFonts.getFont('Roboto Condensed', textStyle: fallback);
      case 'mono':
        return GoogleFonts.robotoMono(textStyle: fallback);
      case 'roboto':
        return GoogleFonts.roboto(textStyle: fallback);
      default:
        return fallback;
    }
  }
}

class _NotificationIconsPreview extends StatelessWidget {
  const _NotificationIconsPreview({required this.values});

  final Map<String, Object?> values;

  @override
  Widget build(BuildContext context) {
    final colorRaw = values['notif_icon_color'];
    final tint = switch (colorRaw) {
      final int value => Color(value.toUnsigned(32)),
      final num value => Color(value.toInt().toUnsigned(32)),
      final String value => _parseHex(value),
      _ => const Color(0xFFB7F5FF),
    };
    final scale = (((values['notif_icon_scale'] as num?) ?? 100).toDouble() / 100).clamp(0, 1.5).toDouble();
    final zoom = (((values['notif_icon_zoom'] as num?) ?? 100).toDouble() / 100).clamp(0.1, 1.5).toDouble();
    final spacing = (((values['notif_icon_division'] as num?) ?? 0).toDouble() / 8).clamp(-6.25, 6.25).toDouble();
    final iconSize = (12.5 * zoom * scale).clamp(8, 20).toDouble();
    final rowIcons = <IconData>[
      Icons.notifications_active_rounded,
      Icons.chat_bubble_rounded,
      Icons.mail_rounded,
      Icons.alarm_rounded,
    ];
    final reverse = (values['reverse_notification_sorting_order'] as bool?) ?? false;
    final shownIcons = reverse ? rowIcons.reversed.toList() : rowIcons;

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SectionHeader(
            title: 'Preview',
            subtitle: 'Static notification row style preview.',
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xFF102231).withValues(alpha: 0.72),
              border: Border.all(color: const Color(0xFF8DE8FF).withValues(alpha: 0.2)),
            ),
            child: Row(
              children: <Widget>[
                const Expanded(
                  child: Text(
                    '8:45',
                    style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w700, letterSpacing: 0.5),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: shownIcons
                      .map(
                        (icon) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: spacing + 1.5),
                          child: Icon(
                            icon,
                            size: iconSize,
                            color: tint.withValues(alpha: (tint.a * 255.0).round().clamp(0, 255) == 0 ? 0.9 : 1),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.signal_cellular_alt_rounded, size: 13, color: Colors.white60),
                const SizedBox(width: 3),
                const Icon(Icons.wifi_rounded, size: 13, color: Colors.white60),
                const SizedBox(width: 3),
                const Icon(Icons.battery_full_rounded, size: 13, color: Colors.white60),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Color _parseHex(String hex) {
    final value = hex.replaceAll('#', '');
    if (value.length == 6) {
      return Color(int.parse('FF$value', radix: 16));
    }
    if (value.length == 8) {
      return Color(int.parse(value, radix: 16));
    }
    return const Color(0xFFB7F5FF);
  }
}

class _ClockPreview extends StatefulWidget {
  const _ClockPreview({required this.values});

  final Map<String, Object?> values;

  @override
  State<_ClockPreview> createState() => _ClockPreviewState();
}

class _ClockPreviewState extends State<_ClockPreview> {
  Timer? _timer;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _scheduleTimer();
  }

  @override
  void didUpdateWidget(covariant _ClockPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldSeconds = (oldWidget.values['status_clock_second_enable'] as bool?) ?? true;
    final newSeconds = (widget.values['status_clock_second_enable'] as bool?) ?? true;
    if (oldSeconds != newSeconds) {
      _scheduleTimer();
    }
  }

  void _scheduleTimer() {
    _timer?.cancel();
    final secondsEnabled = (widget.values['status_clock_second_enable'] as bool?) ?? true;
    final period = secondsEnabled ? const Duration(seconds: 1) : const Duration(minutes: 1);
    _timer = Timer.periodic(period, (_) {
      if (!mounted) return;
      setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final values = widget.values;
    final show24h = (values['clock_mezo_time_style'] as bool?) ?? false;
    final showSeconds = (values['status_clock_second_enable'] as bool?) ?? true;
    final blinkDots = (values['status_clock_dots_enable'] as bool?) ?? true;
    final colorValue = (values['status_clock_color'] as int?) ?? 0;
    final dateColor = (values['Notif_date_color'] as int?) ?? -1;
    final weatherColor = (values['weather_notif_text_color'] as int?) ?? 0xFF8DE8FF;

    final size = ((values['status_clock_zoom'] as num?) ?? 14).toDouble().clamp(11, 24).toDouble();
    final dateSize = ((values['Notif_date_zoom'] as num?) ?? 18).toDouble().clamp(12, 24).toDouble();
    final weatherSize = ((values['weather_notif_text_zoom'] as num?) ?? 16).toDouble().clamp(11, 22).toDouble();

    final hour24 = _now.hour.toString().padLeft(2, '0');
    final hour12Raw = _now.hour % 12 == 0 ? 12 : _now.hour % 12;
    final hour = show24h ? hour24 : hour12Raw.toString().padLeft(2, '0');
    final minute = _now.minute.toString().padLeft(2, '0');
    final second = _now.second.toString().padLeft(2, '0');
    final separator = blinkDots && _now.second.isOdd ? ' ' : ':';
    final suffix = show24h ? '' : (_now.hour < 12 ? ' AM' : ' PM');
    final time = showSeconds ? '$hour$separator$minute$separator$second$suffix' : '$hour$separator$minute$suffix';

    const weekdays = <String>['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const months = <String>['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final dateText = '${weekdays[_now.weekday - 1]}, ${_now.day} ${months[_now.month - 1]}';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.black.withValues(alpha: 0.22),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(time, style: TextStyle(color: Color(colorValue), fontSize: size)),
          const SizedBox(height: 4),
          Text(dateText, style: TextStyle(color: Color(dateColor), fontSize: dateSize)),
          const SizedBox(height: 4),
          Text('23°  Cloudy', style: TextStyle(color: Color(weatherColor), fontSize: weatherSize)),
        ],
      ),
    );
  }
}
