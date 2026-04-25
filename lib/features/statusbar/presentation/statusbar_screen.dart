import 'package:deadzon/core/theme/design_tokens.dart';
import 'package:deadzon/core/widgets/glass_card.dart';
import 'package:deadzon/core/widgets/premium_top_bar.dart';
import 'package:deadzon/core/widgets/section_header.dart';
import 'package:deadzon/core/widgets/settings_row.dart';
import 'package:deadzon/features/statusbar/data/resize_statusbar_service.dart';
import 'package:deadzon/features/statusbar/data/statusbar_board_model.dart';
import 'package:deadzon/features/statusbar/data/statusbar_board_service.dart';
import 'package:deadzon/features/statusbar/statusbar_board_config.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

class StatusbarScreen extends StatefulWidget {
  const StatusbarScreen({super.key});

  @override
  State<StatusbarScreen> createState() => _StatusbarScreenState();
}

class _StatusbarScreenState extends State<StatusbarScreen> {
  static const String _prefsModeKey = 'statusbar_studio_layout_mode';

  late StatusbarBoardState _boardState;
  _StudioLayoutMode _layoutMode = _StudioLayoutMode.singleRow;
  bool _isHydrating = true;

  @override
  void initState() {
    super.initState();
    _boardState = StatusbarBoardState(
      modules: StatusbarBoardService.defaultModules(),
      leftClusterOffset: 0,
      rightClusterOffset: 0,
    );
    _hydrateStudioLayout();
  }

  Future<void> _hydrateStudioLayout() async {
    final prefs = await SharedPreferences.getInstance();
    final mode = prefs.getString(_prefsModeKey);
    StatusbarBoardState boardState;
    try {
      boardState = await StatusbarBoardService.load();
    } catch (_) {
      boardState = _boardStateFromSerialized(
        prefs.getString(statusbarBoardSerializedKey) ?? statusbarBoardSourceDefaultLayout,
      );
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _layoutMode = mode == _StudioLayoutMode.twoRows.name ? _StudioLayoutMode.twoRows : _StudioLayoutMode.singleRow;
      _boardState = boardState;
      _isHydrating = false;
    });
  }

  Future<void> _restoreDefaultLayout() async {
    setState(() {
      _layoutMode = _StudioLayoutMode.singleRow;
      _boardState = _boardState.copyWith(modules: StatusbarBoardService.defaultModules());
    });
    await _persistStudioLayout();
    _showMessage('Default layout restored');
  }

  Future<void> _persistStudioLayout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsModeKey, _layoutMode.name);
    await prefs.setString(statusbarBoardSerializedKey, StatusbarBoardService.encodeSerializedLayout(_boardState.modules));
    try {
      await StatusbarBoardService.writeModules(_boardState.modules);
    } catch (_) {
      // Local old-key-compatible layout is still saved when native apply is unavailable.
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
    final result = await showModalBottomSheet<_ArrangeLayoutResult>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _ArrangeLayoutSheet(
        mode: _layoutMode,
        boardState: _boardState,
      ),
    );
    if (result == null || !mounted) {
      return;
    }
    setState(() {
      _layoutMode = result.mode;
      _boardState = _boardState.copyWith(modules: result.modules);
    });
    await _persistStudioLayout();
    _showMessage('Layout saved');
  }

  void _showPreviewFeedback() {
    _showMessage('Preview updated');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF0D263F),
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
          colors: <Color>[Color(0xFF071225), Color(0xFF050E1F), Color(0xFF020812)],
        ),
      ),
      child: SafeArea(
        child: AnimatedSwitcher(
          duration: DesignTokens.motionFast,
          child: _isHydrating
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  padding: const EdgeInsets.fromLTRB(20, 14, 20, 170),
                  children: <Widget>[
                    const PremiumTopBar(
                      title: 'Statusbar Studio',
                      subtitle: 'Arrange your layout with live preview',
                    ),
                    const SizedBox(height: 18),
                    GlassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: const Color(0xFF173A69).withValues(alpha: 0.66),
                                ),
                                child: const Icon(Icons.space_dashboard_rounded, color: Color(0xFF8DE8FF)),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Layout Studio', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w800)),
                                    Text(
                                      'Design and arrange your status bar',
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white.withValues(alpha: 0.72)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: <Widget>[
                              _StudioActionButton(label: 'Arrange layout', icon: Icons.reorder_rounded, onTap: _openArrangeSheet),
                              _StudioActionButton(label: 'Preview', icon: Icons.preview_rounded, onTap: _showPreviewFeedback),
                              _StudioActionButton(label: 'Restore default', icon: Icons.restart_alt_rounded, onTap: _restoreDefaultLayout),
                            ],
                          ),
                          const SizedBox(height: 18),
                          const SectionHeader(title: 'Live Preview', subtitle: 'Single Row by default with all icons visible'),
                          const SizedBox(height: 10),
                          _StatusbarLivePreview(
                            mode: _layoutMode,
                            modules: _boardState.modules,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    const SectionHeader(
                      title: 'Full statusbar settings',
                      subtitle: 'Complete old Mezo section tree with preserved behavior',
                    ),
                    const SizedBox(height: 10),
                    GlassCard(
                      child: Column(
                        children: <Widget>[
                          for (var i = 0; i < StatusbarSectionConfigs.values.length; i++) ...<Widget>[
                            _FullSectionRow(
                              section: StatusbarSectionConfigs.values[i],
                              onTap: () => _openSection(StatusbarSectionConfigs.values[i].id),
                            ),
                            if (i != StatusbarSectionConfigs.values.length - 1) const Divider(height: 20),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}


class _StatusbarLivePreview extends StatelessWidget {
  const _StatusbarLivePreview({
    required this.mode,
    required this.modules,
  });

  final _StudioLayoutMode mode;
  final List<StatusbarBoardModuleState> modules;

  @override
  Widget build(BuildContext context) {
    final visibleModules = modules.where((module) => module.visible && module.enabled).toList(growable: false);
    return AnimatedContainer(
      duration: DesignTokens.motionFast,
      curve: DesignTokens.motionCurve,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xFF06101F).withValues(alpha: 0.92),
        border: Border.all(color: const Color(0xFF6FAAFF).withValues(alpha: 0.42)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF1B7DFF).withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: mode == _StudioLayoutMode.singleRow
          ? _SourceSingleRowPreview(modules: _singleSortedModules(visibleModules))
          : _SourceTwoRowPreview(modules: visibleModules),
    );
  }
}

class _SourceSingleRowPreview extends StatelessWidget {
  const _SourceSingleRowPreview({required this.modules});

  final List<StatusbarBoardModuleState> modules;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 46),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black.withValues(alpha: 0.68),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 6,
        runSpacing: 6,
        children: modules.map((module) => _PreviewModule(module: module, dense: true)).toList(),
      ),
    );
  }
}

class _SourceTwoRowPreview extends StatelessWidget {
  const _SourceTwoRowPreview({required this.modules});

  final List<StatusbarBoardModuleState> modules;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black.withValues(alpha: 0.62),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        children: <Widget>[
          _PreviewLaneRow(lane: _TwoRowLane.leftTop, modules: modules),
          const SizedBox(height: 5),
          _PreviewLaneRow(lane: _TwoRowLane.leftBottom, modules: modules),
          Divider(height: 14, color: Colors.white.withValues(alpha: 0.08)),
          _PreviewLaneRow(lane: _TwoRowLane.rightTop, modules: modules),
          const SizedBox(height: 5),
          _PreviewLaneRow(lane: _TwoRowLane.rightBottom, modules: modules),
        ],
      ),
    );
  }
}

class _PreviewLaneRow extends StatelessWidget {
  const _PreviewLaneRow({required this.lane, required this.modules});

  final _TwoRowLane lane;
  final List<StatusbarBoardModuleState> modules;

  @override
  Widget build(BuildContext context) {
    final laneModules = _modulesForLane(modules, lane);
    return Row(
      children: <Widget>[
        SizedBox(
          width: 48,
          child: Text(
            lane.previewTitle,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.45), fontSize: 9, fontWeight: FontWeight.w800),
          ),
        ),
        Expanded(
          child: Wrap(
            spacing: 5,
            runSpacing: 5,
            alignment: lane.isRight ? WrapAlignment.end : WrapAlignment.start,
            children: laneModules.map((module) => _PreviewModule(module: module, dense: true)).toList(),
          ),
        ),
      ],
    );
  }
}

class _PreviewModule extends StatelessWidget {
  const _PreviewModule({required this.module, this.dense = false});

  final StatusbarBoardModuleState module;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final width = dense ? 24.0 : 34.0;
    final height = dense ? 22.0 : 34.0;
    final label = module.module.previewLabel;
    final showText = label.length <= 5 || module.module.id == 'elem_speed' || module.module.id == 'elem_clock' || module.module.id == 'elem_date';
    return AnimatedOpacity(
      duration: DesignTokens.motionFast,
      opacity: module.visible && module.enabled ? 1 : 0.32,
      child: Transform.scale(
        scale: module.size.clamp(0.72, 1.35).toDouble(),
        child: Container(
          constraints: BoxConstraints(minWidth: width, minHeight: height),
          padding: EdgeInsets.symmetric(horizontal: dense ? 5 : 8, vertical: dense ? 3 : 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: module.module.color.withValues(alpha: 0.10),
            border: Border.all(color: module.module.color.withValues(alpha: 0.24)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: dense ? 14 : 18,
                height: dense ? 14 : 18,
                child: Image.asset(
                  module.asset,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Icon(module.module.icon, color: Colors.white, size: dense ? 14 : 18),
                ),
              ),
              if (showText) ...<Widget>[
                SizedBox(width: dense ? 4 : 6),
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: dense ? 10 : 12,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ArrangeLayoutSheet extends StatefulWidget {
  const _ArrangeLayoutSheet({
    required this.mode,
    required this.boardState,
  });

  final _StudioLayoutMode mode;
  final StatusbarBoardState boardState;

  @override
  State<_ArrangeLayoutSheet> createState() => _ArrangeLayoutSheetState();
}

class _ArrangeLayoutSheetState extends State<_ArrangeLayoutSheet> {
  late _StudioLayoutMode _mode;
  late List<StatusbarBoardModuleState> _modules;

  @override
  void initState() {
    super.initState();
    _mode = widget.mode;
    _modules = List<StatusbarBoardModuleState>.from(widget.boardState.modules);
  }

  void _resetToDefault() {
    setState(() {
      _mode = _StudioLayoutMode.singleRow;
      _modules = StatusbarBoardService.defaultModules();
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Default layout restored')));
  }

  void _moveSingle(String sourceId, String targetId) {
    final ordered = _singleSortedModules(_modules);
    final sourceIndex = ordered.indexWhere((item) => item.id == sourceId);
    final targetIndex = ordered.indexWhere((item) => item.id == targetId);
    if (sourceIndex == -1 || targetIndex == -1 || sourceIndex == targetIndex) {
      return;
    }
    final moved = ordered.removeAt(sourceIndex);
    final insertIndex = sourceIndex < targetIndex ? targetIndex - 1 : targetIndex;
    ordered.insert(insertIndex, moved);
    _rewriteModulesFromSingleOrder(ordered);
  }

  void _moveToLane(String sourceId, _TwoRowLane targetLane, {String? beforeId}) {
    final lanes = <_TwoRowLane, List<StatusbarBoardModuleState>>{
      for (final lane in _TwoRowLane.values) lane: _modulesForLane(_modules, lane).toList(),
    };
    StatusbarBoardModuleState? moving;
    for (final lane in _TwoRowLane.values) {
      final index = lanes[lane]!.indexWhere((item) => item.id == sourceId);
      if (index != -1) {
        moving = lanes[lane]!.removeAt(index);
        break;
      }
    }
    if (moving == null) {
      return;
    }
    final target = lanes[targetLane]!;
    final insertIndex = beforeId == null ? target.length : target.indexWhere((item) => item.id == beforeId);
    target.insert(insertIndex < 0 ? target.length : insertIndex, moving);
    _rewriteModulesFromLanes(lanes);
  }

  void _rewriteModulesFromSingleOrder(List<StatusbarBoardModuleState> ordered) {
    final next = <StatusbarBoardModuleState>[];
    for (var i = 0; i < ordered.length; i++) {
      final slotIndex = i < _singleSlotCodes.length ? i : _singleSlotCodes.length - 1;
      final code = _singleSlotCodes[slotIndex];
      next.add(ordered[i].copyWith(currentPositionCode: code));
    }
    setState(() => _modules = _mergeWithMissing(next));
  }

  void _rewriteModulesFromLanes(Map<_TwoRowLane, List<StatusbarBoardModuleState>> lanes) {
    final next = <StatusbarBoardModuleState>[];
    for (final lane in _TwoRowLane.values) {
      final laneItems = lanes[lane]!;
      for (var i = 0; i < laneItems.length; i++) {
        next.add(laneItems[i].copyWith(currentPositionCode: lane.baseCode + i));
      }
    }
    setState(() => _modules = _mergeWithMissing(next));
  }

  List<StatusbarBoardModuleState> _mergeWithMissing(List<StatusbarBoardModuleState> next) {
    final included = next.map((item) => item.id).toSet();
    final missing = _modules.where((item) => !included.contains(item.id));
    return <StatusbarBoardModuleState>[...next, ...missing];
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.92,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF071121),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          border: Border.all(color: const Color(0xFF5BA6FF).withValues(alpha: 0.22)),
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.black.withValues(alpha: 0.35), blurRadius: 22, offset: const Offset(0, -8)),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              Container(width: 48, height: 5, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(100))),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 12, 0),
                child: Row(
                  children: <Widget>[
                    TextButton(onPressed: _resetToDefault, child: const Text('Reset')),
                    Expanded(
                      child: Text(
                        'Arrange Layout',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(
                          _ArrangeLayoutResult(
                            mode: _mode,
                            modules: _modules,
                          ),
                        );
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: SegmentedButton<_StudioLayoutMode>(
                  style: SegmentedButton.styleFrom(
                    selectedBackgroundColor: const Color(0xFF183A63),
                    selectedForegroundColor: Colors.white,
                    foregroundColor: Colors.white70,
                  ),
                  segments: const <ButtonSegment<_StudioLayoutMode>>[
                    ButtonSegment<_StudioLayoutMode>(value: _StudioLayoutMode.singleRow, label: Text('Single Row')),
                    ButtonSegment<_StudioLayoutMode>(value: _StudioLayoutMode.twoRows, label: Text('Two Rows')),
                  ],
                  selected: <_StudioLayoutMode>{_mode},
                  onSelectionChanged: (selection) => setState(() => _mode = selection.first),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 26),
                  child: _LegacyArrangeBoard(
                    mode: _mode,
                    modules: _modules,
                    onMoveSingle: _moveSingle,
                    onMoveToLane: _moveToLane,
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

class _LegacyArrangeBoard extends StatelessWidget {
  const _LegacyArrangeBoard({
    required this.mode,
    required this.modules,
    required this.onMoveSingle,
    required this.onMoveToLane,
  });

  final _StudioLayoutMode mode;
  final List<StatusbarBoardModuleState> modules;
  final void Function(String source, String target) onMoveSingle;
  final void Function(String sourceId, _TwoRowLane targetLane, {String? beforeId}) onMoveToLane;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: const Color(0xFF10151B).withValues(alpha: 0.98),
        border: Border.all(color: Colors.white.withValues(alpha: 0.72)),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black.withValues(alpha: 0.28), blurRadius: 22, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Expanded(
                child: Text(
                  'Mezo source position board',
                  style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w900),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(99),
                  color: const Color(0xFF142D4B),
                  border: Border.all(color: const Color(0xFF6FAAFF).withValues(alpha: 0.36)),
                ),
                child: Text(
                  mode == _StudioLayoutMode.singleRow ? 'single row' : 'two rows',
                  style: const TextStyle(color: Color(0xFFBFDFFF), fontSize: 11, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Drag any old Mezo module. Preview and saved key update immediately after Save.',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.62), fontSize: 12, height: 1.25),
          ),
          const SizedBox(height: 14),
          if (mode == _StudioLayoutMode.singleRow)
            _BoardDropLane(
              title: 'Single row order',
              subtitle: 'All source modules visible in one board',
              modules: _singleSortedModules(modules),
              onMoveWithin: onMoveSingle,
              onAcceptToLane: null,
            )
          else
            Column(
              children: <Widget>[
                _BoardDropLane(
                  title: 'Left side • row 1',
                  subtitle: 'Old position codes 1–9',
                  modules: _modulesForLane(modules, _TwoRowLane.leftTop),
                  onMoveWithin: (source, target) => onMoveToLane(source, _TwoRowLane.leftTop, beforeId: target),
                  onAcceptToLane: (source) => onMoveToLane(source, _TwoRowLane.leftTop),
                ),
                const SizedBox(height: 10),
                _BoardDropLane(
                  title: 'Left side • row 2',
                  subtitle: 'Old position codes 11–19',
                  modules: _modulesForLane(modules, _TwoRowLane.leftBottom),
                  onMoveWithin: (source, target) => onMoveToLane(source, _TwoRowLane.leftBottom, beforeId: target),
                  onAcceptToLane: (source) => onMoveToLane(source, _TwoRowLane.leftBottom),
                ),
                const SizedBox(height: 12),
                Divider(color: Colors.white.withValues(alpha: 0.13), height: 1),
                const SizedBox(height: 12),
                _BoardDropLane(
                  title: 'Right side • row 1',
                  subtitle: 'Old position codes 21–29',
                  modules: _modulesForLane(modules, _TwoRowLane.rightTop),
                  onMoveWithin: (source, target) => onMoveToLane(source, _TwoRowLane.rightTop, beforeId: target),
                  onAcceptToLane: (source) => onMoveToLane(source, _TwoRowLane.rightTop),
                ),
                const SizedBox(height: 10),
                _BoardDropLane(
                  title: 'Right side • row 2',
                  subtitle: 'Old position codes 31–39',
                  modules: _modulesForLane(modules, _TwoRowLane.rightBottom),
                  onMoveWithin: (source, target) => onMoveToLane(source, _TwoRowLane.rightBottom, beforeId: target),
                  onAcceptToLane: (source) => onMoveToLane(source, _TwoRowLane.rightBottom),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _BoardDropLane extends StatelessWidget {
  const _BoardDropLane({
    required this.title,
    required this.subtitle,
    required this.modules,
    required this.onMoveWithin,
    required this.onAcceptToLane,
  });

  final String title;
  final String subtitle;
  final List<StatusbarBoardModuleState> modules;
  final void Function(String source, String target) onMoveWithin;
  final void Function(String source)? onAcceptToLane;

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      onWillAcceptWithDetails: (details) => onAcceptToLane != null && !modules.any((module) => module.id == details.data),
      onAcceptWithDetails: (details) => onAcceptToLane?.call(details.data),
      builder: (context, candidate, rejected) {
        final hovered = candidate.isNotEmpty;
        return AnimatedContainer(
          duration: DesignTokens.motionFast,
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: hovered ? const Color(0xFF102B4D) : const Color(0xFF07101D),
            border: Border.all(color: hovered ? const Color(0xFF8DE8FF) : const Color(0xFF355F8C).withValues(alpha: 0.58)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(child: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900))),
                  Text(
                    hovered ? 'release to drop' : 'drop here',
                    style: TextStyle(color: Colors.white.withValues(alpha: hovered ? 0.78 : 0.36), fontSize: 11),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(subtitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.48), fontSize: 11)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: modules.map((module) {
                  return DragTarget<String>(
                    onWillAcceptWithDetails: (details) => details.data != module.id,
                    onAcceptWithDetails: (details) => onMoveWithin(details.data, module.id),
                    builder: (context, itemCandidate, rejected) {
                      final chipHovered = itemCandidate.isNotEmpty;
                      return Draggable<String>(
                        data: module.id,
                        feedback: Material(
                          color: Colors.transparent,
                          child: Transform.scale(
                            scale: 1.06,
                            child: _ArrangeChip(module: module, highlighted: true),
                          ),
                        ),
                        childWhenDragging: Opacity(opacity: 0.18, child: _ArrangeChip(module: module)),
                        child: _ArrangeChip(module: module, highlighted: chipHovered),
                      );
                    },
                  );
                }).toList(),
              ),
              if (modules.isEmpty) ...<Widget>[
                const SizedBox(height: 8),
                Text('Drop a module here', style: TextStyle(color: Colors.white.withValues(alpha: 0.55))),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _ArrangeChip extends StatelessWidget {
  const _ArrangeChip({
    required this.module,
    this.highlighted = false,
  });

  final StatusbarBoardModuleState module;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: DesignTokens.motionFast,
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: highlighted ? const Color(0xFF1B4777) : const Color(0xFF10273F),
        border: Border.all(color: module.module.color.withValues(alpha: highlighted ? 0.95 : 0.56)),
        boxShadow: highlighted
            ? <BoxShadow>[BoxShadow(color: module.module.color.withValues(alpha: 0.24), blurRadius: 16, offset: const Offset(0, 5))]
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: 18,
            height: 18,
            child: Image.asset(
              module.asset,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Icon(module.module.icon, size: 18, color: Colors.white),
            ),
          ),
          const SizedBox(width: 7),
          Text(module.module.title, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w900)),
        ],
      ),
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
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        backgroundColor: const Color(0xFF1A3F6C).withValues(alpha: 0.68),
        foregroundColor: Colors.white,
      ),
      icon: Icon(icon, size: 18),
      label: Text(label),
    );
  }
}

class _FullSectionRow extends StatelessWidget {
  const _FullSectionRow({
    required this.section,
    required this.onTap,
  });

  final StatusBarSectionDefinition section;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: const Color(0xFF112339).withValues(alpha: 0.64),
            border: Border.all(color: section.accentColor.withValues(alpha: 0.42)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: <Widget>[
              Icon(section.icon, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(section.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 2),
                    Text(
                      section.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.72), fontSize: 12),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.white70),
            ],
          ),
        ),
      ),
    );
  }
}


StatusbarBoardState _boardStateFromSerialized(String serialized) {
  final parsed = StatusbarBoardService.parseSerializedLayout(serialized);
  final defaults = StatusbarBoardService.defaultModules();
  final defaultsById = {for (final module in defaults) module.id: module};
  final modules = <StatusbarBoardModuleState>[];
  for (final defaultModule in defaults) {
    modules.add(parsed[defaultModule.id] ?? defaultsById[defaultModule.id]!);
  }
  return StatusbarBoardState(modules: modules, leftClusterOffset: 0, rightClusterOffset: 0);
}

enum _StudioLayoutMode { singleRow, twoRows }

enum _TwoRowLane {
  leftTop('Left Row 1', 'L1', 1, false),
  leftBottom('Left Row 2', 'L2', 11, false),
  rightTop('Right Row 1', 'R1', 21, true),
  rightBottom('Right Row 2', 'R2', 31, true);

  const _TwoRowLane(this.title, this.previewTitle, this.baseCode, this.isRight);
  final String title;
  final String previewTitle;
  final int baseCode;
  final bool isRight;
}

@immutable
class _ArrangeLayoutResult {
  const _ArrangeLayoutResult({
    required this.mode,
    required this.modules,
  });

  final _StudioLayoutMode mode;
  final List<StatusbarBoardModuleState> modules;
}

const List<int> _singleSlotCodes = <int>[1, 2, 3, 11, 12, 21, 22, 31, 32, 33];

List<StatusbarBoardModuleState> _singleSortedModules(List<StatusbarBoardModuleState> modules) {
  final sorted = modules.toList(growable: false);
  sorted.sort((a, b) {
    final aIndex = _singleSlotCodes.indexOf(a.currentPositionCode);
    final bIndex = _singleSlotCodes.indexOf(b.currentPositionCode);
    final safeA = aIndex == -1 ? 999 + a.module.legacyIndex : aIndex;
    final safeB = bIndex == -1 ? 999 + b.module.legacyIndex : bIndex;
    return safeA.compareTo(safeB);
  });
  return sorted;
}

_TwoRowLane _laneForCode(int code) {
  if (code >= 31) {
    return _TwoRowLane.rightBottom;
  }
  if (code >= 21) {
    return _TwoRowLane.rightTop;
  }
  if (code >= 11) {
    return _TwoRowLane.leftBottom;
  }
  return _TwoRowLane.leftTop;
}

List<StatusbarBoardModuleState> _modulesForLane(List<StatusbarBoardModuleState> modules, _TwoRowLane lane) {
  final laneItems = modules.where((module) => _laneForCode(module.currentPositionCode) == lane).toList(growable: false);
  laneItems.sort((a, b) => a.currentPositionCode.compareTo(b.currentPositionCode));
  return laneItems;
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
      _loadBackgroundModuleValues();
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

  Future<void> _loadBackgroundModuleValues() async {
    final prefs = await SharedPreferences.getInstance();
    final loaded = <String, Object?>{};
    for (final target in MezoPortMap.backgroundTargets) {
      for (final key in target.colorKeys) {
        final value = prefs.getString(key);
        if (value != null) {
          loaded[key] = value;
        }
      }
      for (final key in target.sliderKeys) {
        final raw = prefs.get(key);
        if (raw is num) {
          loaded[key] = raw.toDouble();
        }
      }
    }
    if (!mounted || loaded.isEmpty) {
      return;
    }
    setState(() => _values.addAll(loaded));
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
                StatusbarSettingsRepository.writeRaw(key, value);
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
            subtitle: 'Every old background module is kept and saved with the same behavior.',
          ),
          const SizedBox(height: 10),
          ...MezoPortMap.backgroundTargets.map((target) {
            return ExpansionTile(
              tilePadding: EdgeInsets.zero,
              collapsedIconColor: Colors.white70,
              iconColor: Colors.white,
              title: Text(target.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              subtitle: Text('Color, padding, corner, stroke, and margin controls', style: TextStyle(color: Colors.white.withValues(alpha: 0.56), fontSize: 11)),
              children: <Widget>[
                for (final colorKey in target.colorKeys) ...<Widget>[
                  SettingsRow(
                    icon: Icons.palette_outlined,
                    iconColor: const Color(0xFF94E0D4),
                    title: _prettyKey(colorKey),
                    subtitle: 'Color control preserved from the old module',
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
                    subtitle: 'Position and shape control preserved from the old module',
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
