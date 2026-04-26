import 'package:deadzon/core/theme/design_tokens.dart';
import 'package:deadzon/core/widgets/glass_card.dart';
import 'package:deadzon/core/widgets/premium_top_bar.dart';
import 'package:deadzon/core/widgets/section_header.dart';
import 'package:deadzon/core/widgets/settings_row.dart';
import 'package:deadzon/features/statusbar/data/resize_statusbar_service.dart';
import 'package:deadzon/features/statusbar/data/statusbar_board_model.dart';
import 'package:deadzon/features/statusbar/data/statusbar_board_service.dart';
import 'package:deadzon/features/statusbar/data/statusbar_settings_repository.dart';
import 'package:deadzon/features/statusbar/mezo_port_map.dart';
import 'package:deadzon/features/statusbar/presentation/mezo_controls.dart';
import 'package:deadzon/features/statusbar/statusbar_detail_content.dart';
import 'package:deadzon/features/statusbar/statusbar_mapper.dart';
import 'package:deadzon/features/statusbar/statusbar_models.dart';
import 'package:deadzon/features/statusbar/statusbar_section_configs.dart';
import 'package:deadzon/features/statusbar/statusbar_strings.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _hydrateStatusbarBoard();
  }

  Future<void> _hydrateStatusbarBoard() async {
    try {
      final state = await StatusbarBoardService.load();
      if (!mounted) return;
      setState(() {
        _boardModules = state.modules;
        _isHydrating = false;
      });
    } catch (_) {
      if (!mounted) return;
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
      await StatusbarBoardService.writeModules(defaults);
      _showMessage('Layout restored');
    } catch (_) {
      _showMessage('Layout restored locally');
    } finally {
      if (mounted) setState(() => _isSavingLayout = false);
    }
  }

  Future<void> _openArrangeSheet() async {
    final result = await showModalBottomSheet<List<StatusbarBoardModuleState>>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _ArrangeLayoutSheet(modules: _boardModules),
    );
    if (result == null || !mounted) return;
    setState(() {
      _boardModules = result;
      _isSavingLayout = true;
    });
    try {
      await StatusbarBoardService.writeModules(result);
      _showMessage('Layout saved');
    } catch (_) {
      _showMessage('Layout saved locally');
    } finally {
      if (mounted) setState(() => _isSavingLayout = false);
    }
  }

  void _openSection(String sectionId) {
    final section = StatusbarSectionConfigs.values.firstWhere((item) => item.id == sectionId);
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => StatusbarDetailScreen(section: section)),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(18, 0, 18, 114),
        duration: const Duration(milliseconds: 1250),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 0,
        backgroundColor: const Color(0xFF102C50).withValues(alpha: 0.96),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Color(0xFF071225), Color(0xFF040812), Color(0xFF000000)],
        ),
      ),
      child: SafeArea(
        child: AnimatedSwitcher(
          duration: DesignTokens.motionFast,
          child: _isHydrating
              ? const Center(child: CircularProgressIndicator(color: Color(0xFF8DE8FF)))
              : ListView(
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  padding: const EdgeInsets.fromLTRB(18, 12, 18, 168),
                  children: <Widget>[
                    const PremiumTopBar(
                      title: 'Statusbar adjustment',
                      subtitle: 'Old Mezo controls, DeadZone skin',
                    ),
                    const SizedBox(height: 18),
                    _OldMezoPreviewPanel(
                      modules: _boardModules,
                      saving: _isSavingLayout,
                      onArrange: _openArrangeSheet,
                      onRestore: _isSavingLayout ? null : _restoreDefaultLayout,
                    ),
                    const SizedBox(height: 22),
                    const SectionHeader(
                      title: 'Full statusbar settings',
                      subtitle: 'Complete old Mezo section tree with real keys preserved',
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

class _OldMezoPreviewPanel extends StatelessWidget {
  const _OldMezoPreviewPanel({
    required this.modules,
    required this.saving,
    required this.onArrange,
    required this.onRestore,
  });

  final List<StatusbarBoardModuleState> modules;
  final bool saving;
  final VoidCallback onArrange;
  final VoidCallback? onRestore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _OldMezoBoardFrame(modules: modules),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            Expanded(
              child: _MezoMainButton(
                label: 'Arrange layout',
                icon: Icons.open_with_rounded,
                onTap: onArrange,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _MezoMainButton(
                label: saving ? 'Saving...' : 'Restore layout',
                icon: Icons.restore_rounded,
                onTap: onRestore,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ArrangeLayoutSheet extends StatefulWidget {
  const _ArrangeLayoutSheet({required this.modules});

  final List<StatusbarBoardModuleState> modules;

  @override
  State<_ArrangeLayoutSheet> createState() => _ArrangeLayoutSheetState();
}

class _ArrangeLayoutSheetState extends State<_ArrangeLayoutSheet> {
  late List<StatusbarBoardModuleState> _modules;

  @override
  void initState() {
    super.initState();
    _modules = widget.modules.map((module) => module.copyWith()).toList(growable: true);
  }

  void _restoreLocalDefault() {
    setState(() => _modules = StatusbarBoardService.defaultModules());
  }

  void _moveModule(String id, int targetCode) {
    if (!_isAllowedStatusbarCode(targetCode)) return;
    final sourceIndex = _modules.indexWhere((module) => module.id == id);
    if (sourceIndex == -1) return;
    final source = _modules[sourceIndex];
    if (source.currentPositionCode == targetCode) return;

    final occupiedIndex = _modules.indexWhere((module) => module.currentPositionCode == targetCode);
    setState(() {
      if (occupiedIndex != -1) {
        final occupied = _modules[occupiedIndex];
        _modules[occupiedIndex] = occupied.copyWith(currentPositionCode: source.currentPositionCode);
      }
      _modules[sourceIndex] = source.copyWith(currentPositionCode: targetCode);
    });
  }

  void _dropInLane(String id, _BoardLane lane, Offset localOffset, Size laneSize) {
    final occupiedCodes = _modules
        .where((module) => module.id != id)
        .map((module) => module.currentPositionCode)
        .where(_isAllowedStatusbarCode)
        .toSet();
    final freeCodes = lane.codes.where((code) => !occupiedCodes.contains(code)).toList(growable: false);
    final target = _nearestCodeFromOffset(
          lane: lane,
          offset: localOffset,
          size: laneSize,
          allowedCodes: freeCodes,
        ) ??
        _nearestCodeFromOffset(
          lane: lane,
          offset: localOffset,
          size: laneSize,
          allowedCodes: lane.codes,
        );
    if (target != null) {
      _moveModule(id, target);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.52,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF060B16),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          border: Border.all(color: const Color(0xFF6C4DFF).withValues(alpha: 0.34)),
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.black.withValues(alpha: 0.55), blurRadius: 34, offset: const Offset(0, -16)),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              Container(
                width: 46,
                height: 5,
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.28), borderRadius: BorderRadius.circular(100)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 6),
                child: Row(
                  children: <Widget>[
                    TextButton(onPressed: _restoreLocalDefault, child: const Text('Restore layout')),
                    Expanded(
                      child: Text(
                        'Mezo Position Board',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w900),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(_modules),
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(18, 6, 18, MediaQuery.of(context).padding.bottom + 84),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _OldMezoBoardFrame(
                        modules: _modules,
                        onDropInLane: _dropInLane,
                        editable: true,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Drag the small icons. Save writes only status_bar_elem_position.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.62), fontSize: 12, height: 1.35),
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

class _OldMezoBoardFrame extends StatelessWidget {
  const _OldMezoBoardFrame({
    required this.modules,
    this.onDropInLane,
    this.editable = false,
  });

  final List<StatusbarBoardModuleState> modules;
  final void Function(String id, _BoardLane lane, Offset localOffset, Size laneSize)? onDropInLane;
  final bool editable;

  @override
  Widget build(BuildContext context) {
    final grouped = _sortModulesForPreview(modules);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        boxShadow: <BoxShadow>[
          BoxShadow(color: const Color(0xFF6D3CFF).withValues(alpha: 0.22), blurRadius: 22, offset: const Offset(0, 10)),
        ],
      ),
      child: AspectRatio(
        aspectRatio: 2.22,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF000000),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: const Color(0xFF8B21FF).withValues(alpha: 0.95), width: 1.05),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(21),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: _BoardLaneRegion(
                                lane: _BoardLane.topLeft,
                                modules: grouped[_BoardLane.topLeft] ?? const <StatusbarBoardModuleState>[],
                                onDropInLane: onDropInLane,
                                alignRight: false,
                                alignBottom: false,
                                editable: editable,
                              ),
                            ),
                            Expanded(
                              child: _BoardLaneRegion(
                                lane: _BoardLane.topRight,
                                modules: grouped[_BoardLane.topRight] ?? const <StatusbarBoardModuleState>[],
                                onDropInLane: onDropInLane,
                                alignRight: true,
                                alignBottom: false,
                                editable: editable,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: _BoardLaneRegion(
                                lane: _BoardLane.bottomLeft,
                                modules: grouped[_BoardLane.bottomLeft] ?? const <StatusbarBoardModuleState>[],
                                onDropInLane: onDropInLane,
                                alignRight: false,
                                alignBottom: true,
                                editable: editable,
                              ),
                            ),
                            Expanded(
                              child: _BoardLaneRegion(
                                lane: _BoardLane.bottomRight,
                                modules: grouped[_BoardLane.bottomRight] ?? const <StatusbarBoardModuleState>[],
                                onDropInLane: onDropInLane,
                                alignRight: true,
                                alignBottom: true,
                                editable: editable,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: IgnorePointer(child: CustomPaint(painter: _OldMezoBoardPainter())),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OldMezoBoardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final purple = Paint()
      ..color = const Color(0xFF8B21FF).withValues(alpha: 0.66)
      ..strokeWidth = 1;
    final center = Paint()
      ..color = Colors.white.withValues(alpha: 0.86)
      ..strokeWidth = 1.7;
    final band = Paint()..color = const Color(0xFF5B5B5B).withValues(alpha: 0.78);
    final middleY = size.height / 2;
    canvas.drawRect(Rect.fromLTWH(0, middleY - 6, size.width, 12), band);
    canvas.drawLine(Offset(size.width / 2, 16), Offset(size.width / 2, middleY - 8), center);
    canvas.drawLine(Offset(size.width / 2, middleY + 8), Offset(size.width / 2, size.height - 16), center);
    canvas.drawLine(Offset(0, middleY), Offset(size.width, middleY), purple);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BoardLaneRegion extends StatefulWidget {
  const _BoardLaneRegion({
    required this.lane,
    required this.modules,
    required this.onDropInLane,
    required this.alignRight,
    required this.alignBottom,
    required this.editable,
  });

  final _BoardLane lane;
  final List<StatusbarBoardModuleState> modules;
  final void Function(String id, _BoardLane lane, Offset localOffset, Size laneSize)? onDropInLane;
  final bool alignRight;
  final bool alignBottom;
  final bool editable;

  @override
  State<_BoardLaneRegion> createState() => _BoardLaneRegionState();
}

class _BoardLaneRegionState extends State<_BoardLaneRegion> {
  final GlobalKey _targetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final interactive = widget.editable && widget.onDropInLane != null;
    return DragTarget<String>(
      key: _targetKey,
      onWillAcceptWithDetails: (_) => interactive,
      onAcceptWithDetails: (details) {
        if (!interactive) return;
        final box = _targetKey.currentContext?.findRenderObject() as RenderBox?;
        if (box == null) return;
        widget.onDropInLane!(details.data, widget.lane, box.globalToLocal(details.offset), box.size);
      },
      builder: (context, candidates, rejected) {
        final hovering = candidates.isNotEmpty;
        return AnimatedContainer(
          duration: DesignTokens.motionFast,
          curve: DesignTokens.motionCurve,
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(color: hovering ? const Color(0xFF4B27A8).withValues(alpha: 0.18) : Colors.transparent),
          alignment: Alignment(widget.alignRight ? 1 : -1, widget.alignBottom ? 1 : -1),
          child: Wrap(
            spacing: 5,
            runSpacing: 5,
            alignment: widget.alignRight ? WrapAlignment.end : WrapAlignment.start,
            runAlignment: widget.alignBottom ? WrapAlignment.end : WrapAlignment.start,
            children: widget.modules
                .map(
                  (module) => _StatusbarIconTile(
                    module: module,
                    draggable: interactive,
                  ),
                )
                .toList(growable: false),
          ),
        );
      },
    );
  }
}

class _StatusbarIconTile extends StatelessWidget {
  const _StatusbarIconTile({required this.module, required this.draggable});

  final StatusbarBoardModuleState module;
  final bool draggable;

  @override
  Widget build(BuildContext context) {
    final tile = AnimatedContainer(
      duration: DesignTokens.motionFast,
      curve: DesignTokens.motionCurve,
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: const Color(0xFF03060A),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: module.module.color.withValues(alpha: 0.9), width: 1.05),
        boxShadow: <BoxShadow>[BoxShadow(color: module.module.color.withValues(alpha: 0.30), blurRadius: 10, spreadRadius: 0.4)],
      ),
      child: Icon(module.module.icon, size: 15.8, color: Colors.white),
    );
    if (!draggable) return tile;
    return Draggable<String>(
      data: module.id,
      feedback: Material(color: Colors.transparent, child: Transform.scale(scale: 1.08, child: tile)),
      childWhenDragging: Opacity(opacity: 0.28, child: tile),
      child: tile,
    );
  }
}

class _MezoMainButton extends StatelessWidget {
  const _MezoMainButton({required this.label, required this.icon, required this.onTap});

  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: const Color(0xFF111A2B).withValues(alpha: onTap == null ? 0.44 : 0.9),
            border: Border.all(color: const Color(0xFF49D7FF).withValues(alpha: 0.34)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, size: 18, color: onTap == null ? Colors.white38 : const Color(0xFF8DE8FF)),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: onTap == null ? Colors.white38 : Colors.white, fontWeight: FontWeight.w800, fontSize: 13.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Map<_BoardLane, List<StatusbarBoardModuleState>> _sortModulesForPreview(List<StatusbarBoardModuleState> modules) {
  final grouped = <_BoardLane, List<StatusbarBoardModuleState>>{for (final lane in _BoardLane.values) lane: <StatusbarBoardModuleState>[]};
  for (final module in modules) {
    grouped[_laneForCode(module.currentPositionCode)]!.add(module);
  }
  for (final lane in grouped.keys) {
    grouped[lane]!.sort((a, b) => a.currentPositionCode.compareTo(b.currentPositionCode));
  }
  return grouped;
}

int? _nearestCodeFromOffset({required _BoardLane lane, required Offset offset, required Size size, required List<int> allowedCodes}) {
  final safeCodes = allowedCodes.where(_isAllowedStatusbarCode).toList(growable: false);
  if (safeCodes.isEmpty) return null;
  final clamped = Offset(offset.dx.clamp(0.0, size.width), offset.dy.clamp(0.0, size.height));
  var bestCode = safeCodes.first;
  var bestDistance = double.infinity;
  for (final code in safeCodes) {
    final anchor = _anchorForCode(code: code, lane: lane, size: size);
    final distance = (anchor - clamped).distanceSquared;
    if (distance < bestDistance) {
      bestDistance = distance;
      bestCode = code;
    }
  }
  return bestCode;
}

Offset _anchorForCode({required int code, required _BoardLane lane, required Size size}) {
  final index = (code - lane.startCode).clamp(0, 8);
  final column = index % 3;
  final row = index ~/ 3;
  return Offset((column + 0.5) * (size.width / 3), (row + 0.5) * (size.height / 3));
}

_BoardLane _laneForCode(int code) {
  if (code >= 31 && code <= 39) return _BoardLane.bottomRight;
  if (code >= 21 && code <= 29) return _BoardLane.bottomLeft;
  if (code >= 11 && code <= 19) return _BoardLane.topRight;
  return _BoardLane.topLeft;
}

bool _isAllowedStatusbarCode(int code) {
  return (code >= 1 && code <= 9) || (code >= 11 && code <= 19) || (code >= 21 && code <= 29) || (code >= 31 && code <= 39);
}

enum _BoardLane {
  topLeft(1),
  topRight(11),
  bottomLeft(21),
  bottomRight(31);

  const _BoardLane(this.startCode);
  final int startCode;

  List<int> get codes => List<int>.generate(9, (index) => startCode + index);
}

class _FullSectionGrid extends StatelessWidget {
  const _FullSectionGrid({required this.onOpenSection});

  final void Function(String sectionId) onOpenSection;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 560 ? 3 : 2;
        return GridView.builder(
          itemCount: StatusbarSectionConfigs.values.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: columns == 3 ? 1.38 : 1.22,
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
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
            color: const Color(0xFF020306),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFF8B21FF).withValues(alpha: 0.82), width: 1.05),
            boxShadow: <BoxShadow>[BoxShadow(color: const Color(0xFF4B00C8).withValues(alpha: 0.14), blurRadius: 14, offset: const Offset(0, 8))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: const Color(0xFF070A13),
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: section.accentColor.withValues(alpha: 0.64)),
                    ),
                    child: Icon(section.icon, size: 15, color: Colors.white),
                  ),
                  const Spacer(),
                  Icon(Icons.chevron_right_rounded, size: 20, color: Colors.white.withValues(alpha: 0.74)),
                ],
              ),
              const Spacer(),
              Text(section.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 14.2, fontWeight: FontWeight.w800)),
              const SizedBox(height: 4),
              Text(section.subtitle, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white.withValues(alpha: 0.68), fontSize: 10.2, height: 1.14)),
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

  void _handleLooseSettingChanged(String key, Object? value) {
    setState(() => _values[key] = value);
    StatusbarSettingsRepository.writeLoose(key, value);
  }

  @override
  Widget build(BuildContext context) {
    final grouped = <String, List<StatusBarSettingItem>>{};
    for (final setting in _settings) {
      final groupKey = setting.group ?? 'General';
      grouped.putIfAbsent(groupKey, () => <StatusBarSettingItem>[]).add(setting);
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Color(0xFF071225), Color(0xFF040812), Color(0xFF000000)],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 34),
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton.filledTonal(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.arrow_back_rounded),
                    style: IconButton.styleFrom(backgroundColor: const Color(0xFF11233E), foregroundColor: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: const Color(0xFF020306),
                      border: Border.all(color: widget.section.accentColor.withValues(alpha: 0.62)),
                    ),
                    child: Icon(widget.section.icon, color: Colors.white, size: 21),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                widget.section.title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 6),
              Text(
                widget.section.subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white.withValues(alpha: 0.68), height: 1.35),
              ),
              const SizedBox(height: 16),
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
              onChanged: _handleLooseSettingChanged,
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
        ),
      ),
    );
  }

  bool get _supportsLivePreview =>
      widget.section.id == 'resize_statusbar' || widget.section.id == 'battery' || widget.section.id == 'clock';

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
    final options = <String>['#00000000', '#142D35', '#1E4C59', '#79E3CB', '#90FFAC', '#FFFFFF'];
    final picked = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: const Color(0xFF101A1F),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(18))),
      builder: (_) => SafeArea(
        child: Wrap(
          children: options
              .map((hex) => ListTile(
                    leading: CircleAvatar(backgroundColor: MezoColorChip.fromHex(hex)),
                    title: Text(hex, style: const TextStyle(color: Colors.white)),
                    onTap: () => Navigator.pop(context, hex),
                  ))
              .toList(),
        ),
      ),
    );
    if (picked != null) {
      onChanged(key, picked);
    }
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
        final selected = (value as String?) ?? '#FFFFFF';
        return SettingsRow(
          icon: Icons.palette_rounded,
          iconColor: const Color(0xFFA1E9DB),
          title: _title,
          subtitle: setting.subtitle,
          trailing: MezoColorChip(
            hex: selected,
            onTap: () => _showColorPicker(context, selected),
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

  Future<void> _showColorPicker(BuildContext context, String current) async {
    const swatches = <String>[
      '#FFFFFF',
      '#8DE8FF',
      '#79E3CB',
      '#90FFAC',
      '#FFC66D',
      '#FF8EA8',
      '#B9A3FF',
      '#76A7FF',
    ];
    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: const Color(0xFF101B1F),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(_title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
              const SizedBox(height: 14),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: swatches
                    .map(
                      (hex) => InkWell(
                        onTap: () => Navigator.of(context).pop(hex),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: MezoColorChip.fromHex(hex),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: hex == current ? Colors.white : Colors.white.withValues(alpha: 0.3),
                              width: hex == current ? 2 : 1,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
    if (selected != null) {
      onChanged(selected);
    }
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

class _ClockPreview extends StatelessWidget {
  const _ClockPreview({required this.values});

  final Map<String, Object?> values;
  @override
  Widget build(BuildContext context) {
    final size = ((values['status_clock_zoom'] as num?) ?? 14).toDouble().clamp(11, 24).toDouble();
    final dateSize = ((values['Notif_date_zoom'] as num?) ?? 18).toDouble().clamp(12, 24).toDouble();
    final weatherSize = ((values['weather_notif_text_zoom'] as num?) ?? 16).toDouble().clamp(11, 22).toDouble();
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
          Text('12:48', style: TextStyle(color: Colors.white, fontSize: size)),
          const SizedBox(height: 4),
          Text('Wed, 23 Apr', style: TextStyle(color: Colors.white70, fontSize: dateSize)),
          const SizedBox(height: 4),
          Text('23°  Cloudy', style: TextStyle(color: const Color(0xFF8DE8FF), fontSize: weatherSize)),
        ],
      ),
    );
  }
}
