import 'package:deadzon/core/theme/design_tokens.dart';
import 'package:deadzon/core/widgets/glass_card.dart';
import 'package:deadzon/core/widgets/premium_top_bar.dart';
import 'package:deadzon/core/widgets/section_header.dart';
import 'package:deadzon/core/widgets/settings_row.dart';
import 'package:deadzon/features/statusbar/data/resize_statusbar_service.dart';
import 'package:deadzon/features/statusbar/data/statusbar_board_model.dart';
import 'package:deadzon/features/statusbar/data/statusbar_board_service.dart';
import 'package:deadzon/features/statusbar/presentation/mezo_controls.dart';
import 'package:deadzon/features/statusbar/statusbar_board_config.dart';
import 'package:deadzon/features/statusbar/statusbar_board_source_map.dart';
import 'package:deadzon/features/statusbar/mezo_port_map.dart';
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
  late final List<MezoStatusbarCardSource> _cards;
  StatusbarBoardState? _boardState;

  @override
  void initState() {
    super.initState();
    _cards = MezoStatusbarBoardSourceMap.cards;
    _loadBoard();
  }

  Future<void> _loadBoard() async {
    final loaded = await StatusbarBoardService.load();
    if (!mounted) {
      return;
    }
    setState(() => _boardState = loaded);
  }

  Future<void> _updateBoard(StatusbarBoardState next) async {
    setState(() => _boardState = next);
    await StatusbarBoardService.writeModules(next.modules);
    await StatusbarBoardService.writeClusterOffsets(
      left: next.leftClusterOffset,
      right: next.rightClusterOffset,
    );
  }

  void _openSection(String sectionId) {
    final section = StatusbarSectionConfigs.values.firstWhere((item) => item.id == sectionId);
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => StatusbarDetailScreen(section: section),
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
          colors: <Color>[Color(0xFF0F2E39), Color(0xFF0A1E27), Color(0xFF040809)],
        ),
      ),
      child: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 120),
          children: <Widget>[
            const PremiumTopBar(
              title: 'Statusbar adjustment',
              subtitle: 'Source-faithful Mezo board with real moving modules and original section cards',
            ),
            const SizedBox(height: 18),
            if (_boardState == null)
              const GlassCard(
                child: Padding(
                  padding: EdgeInsets.all(14),
                  child: LinearProgressIndicator(minHeight: 2),
                ),
              )
            else
              _StatusControlBoard(
                boardState: _boardState!,
                onChanged: _updateBoard,
                onOpenSection: _openSection,
              ),
            const SizedBox(height: 18),
            _StatusbarSectionGrid(cards: _cards, onOpenSection: _openSection),
          ],
        ),
      ),
    );
  }
}


class _StatusControlBoard extends StatelessWidget {
  const _StatusControlBoard({
    required this.boardState,
    required this.onChanged,
    required this.onOpenSection,
  });

  final StatusbarBoardState boardState;
  final ValueChanged<StatusbarBoardState> onChanged;
  final ValueChanged<String> onOpenSection;

  @override
  Widget build(BuildContext context) {
    final orderedModules = List<StatusbarBoardModuleState>.from(boardState.modules)
      ..sort((a, b) => a.order.compareTo(b.order));
    final leftModules = orderedModules
        .where((module) => module.side == StatusbarBoardSide.left)
        .toList(growable: false);
    final rightModules = orderedModules
        .where((module) => module.side == StatusbarBoardSide.right)
        .toList(growable: false);

    return GlassCard(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Statusbar adjustment',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Long-press any module to move it. Tap a module to edit its side, visibility, and spacing.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withValues(alpha: 0.74),
                            height: 1.28,
                          ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => _showBoardManager(context),
                icon: const Icon(Icons.tune_rounded),
                color: Colors.white.withValues(alpha: 0.82),
                tooltip: 'Manage hidden modules',
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildBoard(context, leftModules, rightModules),
        ],
      ),
    );
  }

  Widget _buildBoard(
    BuildContext context,
    List<StatusbarBoardModuleState> leftModules,
    List<StatusbarBoardModuleState> rightModules,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boardWidth = constraints.maxWidth;
        final leftSlots = _slotsForSide(StatusbarBoardSide.left, boardWidth);
        final rightSlots = _slotsForSide(StatusbarBoardSide.right, boardWidth);

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: const Color(0xFF9E38FF).withValues(alpha: 0.78), width: 1.15),
            boxShadow: const <BoxShadow>[
              BoxShadow(color: Color(0x2200FFF0), blurRadius: 18, spreadRadius: -10),
              BoxShadow(color: Color(0x33000000), blurRadius: 24, offset: Offset(0, 12)),
            ],
          ),
          child: SizedBox(
            height: 270,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(29),
              child: Stack(
                children: <Widget>[
                  const Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Color(0xFF010304),
                            Color(0xFF020608),
                            Color(0xFF000000),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Column(
                        children: <Widget>[
                          const Expanded(child: SizedBox.shrink()),
                          Container(height: 28, color: Colors.white.withValues(alpha: 0.28)),
                          const Expanded(child: SizedBox.shrink()),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: IgnorePointer(
                      child: Align(
                        child: Container(
                          width: 4,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.86),
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ..._buildSideSlots(
                    context,
                    modules: leftModules,
                    slots: leftSlots,
                    side: StatusbarBoardSide.left,
                    clusterOffset: boardState.leftClusterOffset,
                  ),
                  ..._buildSideSlots(
                    context,
                    modules: rightModules,
                    slots: rightSlots,
                    side: StatusbarBoardSide.right,
                    clusterOffset: boardState.rightClusterOffset,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildSideSlots(
    BuildContext context, {
    required List<StatusbarBoardModuleState> modules,
    required List<_BoardSlot> slots,
    required StatusbarBoardSide side,
    required double clusterOffset,
  }) {
    final children = <Widget>[];
    for (var index = 0; index < slots.length; index++) {
      final slot = slots[index];
      final module = index < modules.length ? modules[index] : null;
      children.add(
        Positioned(
          left: slot.left + clusterOffset,
          top: slot.top,
          child: DragTarget<String>(
            onAcceptWithDetails: (details) => _moveModuleToSlot(details.data, side, index),
            builder: (context, candidateData, rejectedData) {
              final hovering = candidateData.isNotEmpty;
              if (module == null) {
                return _BoardSlotTarget(
                  width: slot.width,
                  height: slot.height,
                  hovering: hovering,
                );
              }
              final badge = _BoardModuleBadge(
                module: module,
                assetPath: _assetForModule(module.id),
                width: slot.width,
                height: slot.height,
                onTap: () => _showModuleSheet(context, module),
              );
              return LongPressDraggable<String>(
                data: module.id,
                feedback: Material(
                  color: Colors.transparent,
                  child: Opacity(
                    opacity: 0.94,
                    child: Transform.scale(scale: 1.04, child: badge),
                  ),
                ),
                childWhenDragging: Opacity(opacity: 0.18, child: badge),
                child: badge,
              );
            },
          ),
        ),
      );
    }
    return children;
  }

  List<_BoardSlot> _slotsForSide(StatusbarBoardSide side, double boardWidth) {
    const tileHeight = 30.0;
    const narrowWidth = 46.0;
    const regularWidth = 52.0;
    const wideWidth = 60.0;
    const edge = 18.0;
    const columnGap = 10.0;

    if (side == StatusbarBoardSide.left) {
      return const <_BoardSlot>[
        _BoardSlot(left: edge, top: 20, width: regularWidth, height: tileHeight),
        _BoardSlot(left: edge + regularWidth + columnGap, top: 20, width: regularWidth, height: tileHeight),
        _BoardSlot(left: edge, top: 190, width: regularWidth, height: tileHeight),
        _BoardSlot(left: edge + regularWidth + columnGap, top: 190, width: regularWidth, height: tileHeight),
      ];
    }

    final firstColumn = boardWidth - edge - regularWidth;
    final secondColumn = firstColumn - columnGap - regularWidth;
    final wideColumn = boardWidth - edge - wideWidth;
    return <_BoardSlot>[
      _BoardSlot(left: secondColumn, top: 20, width: narrowWidth, height: tileHeight),
      _BoardSlot(left: firstColumn, top: 20, width: narrowWidth, height: tileHeight),
      _BoardSlot(left: secondColumn, top: 66, width: regularWidth, height: tileHeight),
      _BoardSlot(left: firstColumn, top: 66, width: regularWidth, height: tileHeight),
      _BoardSlot(left: secondColumn, top: 192, width: regularWidth, height: tileHeight),
      _BoardSlot(left: firstColumn, top: 192, width: regularWidth, height: tileHeight),
      _BoardSlot(left: wideColumn - columnGap - regularWidth, top: 224, width: regularWidth, height: tileHeight),
      _BoardSlot(left: wideColumn, top: 224, width: regularWidth, height: tileHeight),
      _BoardSlot(left: boardWidth - edge - wideWidth, top: 224, width: wideWidth, height: tileHeight),
    ];
  }

  Future<void> _showModuleSheet(BuildContext context, StatusbarBoardModuleState module) async {
    var current = module;
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final section = StatusbarSectionConfigs.values.firstWhere((item) => item.id == current.id);
            return Container(
              margin: const EdgeInsets.fromLTRB(12, 12, 12, 18),
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                color: const Color(0xFF0B1418).withValues(alpha: 0.96),
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                boxShadow: const <BoxShadow>[
                  BoxShadow(color: Color(0x44000000), blurRadius: 32, offset: Offset(0, 14)),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Container(
                        width: 42,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        _MezoDrawableImage(path: _assetForModule(current.id), width: 58, height: 30, fallbackIcon: current.module.icon),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            current.module.title,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    _ModuleControlRow(
                      label: 'Visible',
                      child: Switch.adaptive(
                        value: current.visible,
                        onChanged: (value) {
                          final updated = current.copyWith(visible: value);
                          setModalState(() => current = updated);
                          _updateSingleModule(updated);
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    _ModuleControlRow(
                      label: 'Side',
                      child: SegmentedButton<StatusbarBoardSide>(
                        segments: const <ButtonSegment<StatusbarBoardSide>>[
                          ButtonSegment<StatusbarBoardSide>(value: StatusbarBoardSide.left, label: Text('Left')),
                          ButtonSegment<StatusbarBoardSide>(value: StatusbarBoardSide.right, label: Text('Right')),
                        ],
                        selected: <StatusbarBoardSide>{current.side},
                        onSelectionChanged: (value) {
                          final updated = current.copyWith(side: value.first);
                          setModalState(() => current = updated);
                          _updateSingleModule(updated);
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    _ModuleControlRow(
                      label: 'Spacing',
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          MezoAdjustButton(
                            icon: Icons.remove_rounded,
                            onTap: () {
                              final updated = current.copyWith(offset: (current.offset - 1).clamp(-20.0, 20.0).toDouble());
                              setModalState(() => current = updated);
                              _updateSingleModule(updated);
                            },
                          ),
                          const SizedBox(width: 10),
                          Text(
                            current.offset.toStringAsFixed(0),
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 10),
                          MezoAdjustButton(
                            icon: Icons.add_rounded,
                            onTap: () {
                              final updated = current.copyWith(offset: (current.offset + 1).clamp(-20.0, 20.0).toDouble());
                              setModalState(() => current = updated);
                              _updateSingleModule(updated);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () {
                          Navigator.of(sheetContext).pop();
                          onOpenSection(section.id);
                        },
                        icon: const Icon(Icons.open_in_new_rounded),
                        label: const Text('Open section'),
                      ),
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

  Future<void> _showBoardManager(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        final hiddenModules = boardState.modules.where((module) => !module.visible).toList(growable: false);
        return Container(
          margin: const EdgeInsets.fromLTRB(12, 12, 12, 18),
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: const Color(0xFF0B1418).withValues(alpha: 0.96),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Board manager',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(
                  'Restore hidden modules and fine-tune the global left/right cluster offsets.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white.withValues(alpha: 0.72), height: 1.35),
                ),
                if (hiddenModules.isNotEmpty) ...<Widget>[
                  const SizedBox(height: 18),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: hiddenModules
                        .map(
                          (module) => ActionChip(
                            onPressed: () {
                              final updated = module.copyWith(visible: true);
                              _updateSingleModule(updated);
                              Navigator.of(sheetContext).pop();
                            },
                            avatar: _MezoDrawableImage(
                              path: _assetForModule(module.id),
                              width: 34,
                              height: 18,
                              fallbackIcon: module.module.icon,
                            ),
                            label: Text(module.module.title),
                          ),
                        )
                        .toList(growable: false),
                  ),
                ],
                const SizedBox(height: 18),
                Text('Left cluster offset', style: TextStyle(color: Colors.white.withValues(alpha: 0.82))),
                MezoStepSlider(
                  value: boardState.leftClusterOffset,
                  min: -30,
                  max: 30,
                  onChanged: (value) => onChanged(boardState.copyWith(leftClusterOffset: value)),
                ),
                Text('Right cluster offset', style: TextStyle(color: Colors.white.withValues(alpha: 0.82))),
                MezoStepSlider(
                  value: boardState.rightClusterOffset,
                  min: -30,
                  max: 30,
                  onChanged: (value) => onChanged(boardState.copyWith(rightClusterOffset: value)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _moveModuleToSlot(String moduleId, StatusbarBoardSide side, int targetIndex) {
    final dragged = boardState.modules.firstWhere((module) => module.id == moduleId);
    final remaining = boardState.modules.where((module) => module.id != moduleId).toList(growable: false);

    final leftModules = remaining
        .where((module) => module.side == StatusbarBoardSide.left)
        .toList(growable: true)
      ..sort((a, b) => a.order.compareTo(b.order));
    final rightModules = remaining
        .where((module) => module.side == StatusbarBoardSide.right)
        .toList(growable: true)
      ..sort((a, b) => a.order.compareTo(b.order));

    final updatedDragged = dragged.copyWith(side: side, visible: true);
    final targetList = side == StatusbarBoardSide.left ? leftModules : rightModules;
    final insertAt = targetIndex.clamp(0, targetList.length);
    targetList.insert(insertAt, updatedDragged);

    final rebuilt = <StatusbarBoardModuleState>[
      ...leftModules,
      ...rightModules,
    ];
    onChanged(boardState.copyWith(modules: _normalizeOrders(rebuilt)));
  }

  void _updateSingleModule(StatusbarBoardModuleState next) {
    final updated = boardState.modules
        .map((module) => module.id == next.id ? next : module)
        .toList(growable: false);
    onChanged(boardState.copyWith(modules: _normalizeOrders(updated)));
  }

  List<StatusbarBoardModuleState> _normalizeOrders(List<StatusbarBoardModuleState> modules) {
    final ordered = List<StatusbarBoardModuleState>.from(modules);
    return ordered.indexed.map((entry) => entry.$2.copyWith(order: entry.$1)).toList(growable: false);
  }

  String _assetForModule(String moduleId) {
    final match = MezoStatusbarBoardSourceMap.cards.where((card) => card.sectionId == moduleId);
    if (match.isNotEmpty) {
      return match.first.drawableAssetPath;
    }
    return 'reference/mezo/mezo/res/drawable-xxxhdpi/elem_clock_card.png';
  }
}

class _BoardSlot {
  const _BoardSlot({
    required this.left,
    required this.top,
    required this.width,
    required this.height,
  });

  final double left;
  final double top;
  final double width;
  final double height;
}

class _BoardSlotTarget extends StatelessWidget {
  const _BoardSlotTarget({
    required this.width,
    required this.height,
    required this.hovering,
  });

  final double width;
  final double height;
  final bool hovering;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: DesignTokens.motionFast,
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: hovering ? const Color(0xFF9E38FF).withValues(alpha: 0.70) : Colors.white.withValues(alpha: 0.05),
        ),
        color: hovering ? const Color(0x229E38FF) : Colors.transparent,
      ),
    );
  }
}

class _BoardModuleBadge extends StatelessWidget {
  const _BoardModuleBadge({
    required this.module,
    required this.assetPath,
    required this.width,
    required this.height,
    required this.onTap,
  });

  final StatusbarBoardModuleState module;
  final String assetPath;
  final double width;
  final double height;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final opacity = module.visible ? 1.0 : 0.34;
    final translatedX = module.side == StatusbarBoardSide.left ? module.offset * 0.45 : -module.offset * 0.45;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        duration: DesignTokens.motionFast,
        opacity: opacity,
        child: Transform.translate(
          offset: Offset(translatedX, 0),
          child: AnimatedContainer(
            duration: DesignTokens.motionFast,
            curve: DesignTokens.motionCurve,
            width: width,
            height: height,
            alignment: Alignment.center,
            child: _MezoDrawableImage(
              path: assetPath,
              width: width,
              height: height,
              fallbackIcon: module.module.icon,
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusbarSectionGrid extends StatelessWidget {
  const _StatusbarSectionGrid({
    required this.cards,
    required this.onOpenSection,
  });

  final List<MezoStatusbarCardSource> cards;
  final ValueChanged<String> onOpenSection;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 430;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cards.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: compact ? 2 : 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: compact ? 170 : 176,
          ),
          itemBuilder: (context, index) {
            final card = cards[index];
            return _StatusSectionCard(
              source: card,
              onTap: () => onOpenSection(card.sectionId),
            );
          },
        );
      },
    );
  }
}

class _StatusSectionCard extends StatelessWidget {
  const _StatusSectionCard({
    required this.source,
    required this.onTap,
  });

  final MezoStatusbarCardSource source;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(26),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            color: const Color(0xFF141619).withValues(alpha: 0.94),
            border: Border.all(color: const Color(0xFF9E38FF).withValues(alpha: 0.82), width: 1.1),
            boxShadow: const <BoxShadow>[
              BoxShadow(color: Color(0x1C9E38FF), blurRadius: 18, spreadRadius: -10),
              BoxShadow(color: Color(0x32000000), blurRadius: 18, offset: Offset(0, 10)),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _MezoDrawableImage(
                  path: source.drawableAssetPath,
                  width: 70,
                  height: 36,
                  fallbackIcon: Icons.widgets_rounded,
                ),
                const Spacer(),
                Text(
                  source.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  source.summary,
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.74),
                        height: 1.25,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ModuleControlRow extends StatelessWidget {
  const _ModuleControlRow({
    required this.label,
    required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        const SizedBox(width: 12),
        Flexible(child: child),
      ],
    );
  }
}

class _MezoDrawableImage extends StatelessWidget {
  const _MezoDrawableImage({
    required this.path,
    required this.width,
    required this.height,
    required this.fallbackIcon,
  });

  final String path;
  final double width;
  final double height;
  final IconData fallbackIcon;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      width: width,
      height: height,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return SizedBox(
          width: width,
          height: height,
          child: Icon(fallbackIcon, color: Colors.white70, size: height * 0.7),
        );
      },
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

  @override
  void initState() {
    super.initState();
    _settings = StatusBarMapper.settingsForSection(widget.section.id);
    for (final setting in _settings) {
      _values[setting.legacyKey] = setting.defaultValue;
    }
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

  void _handleSettingChanged(StatusBarSettingItem setting, Object? value) {
    setState(() => _values[setting.legacyKey] = value);
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
          if (_isLoadingResize)
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
              onChanged: (key, value) => setState(() => _values[key] = value),
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
