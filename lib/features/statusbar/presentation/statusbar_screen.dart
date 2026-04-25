import 'package:deadzon/core/theme/design_tokens.dart';
import 'package:deadzon/core/widgets/glass_card.dart';
import 'package:deadzon/core/widgets/premium_top_bar.dart';
import 'package:deadzon/core/widgets/section_header.dart';
import 'package:deadzon/core/widgets/settings_row.dart';
import 'package:deadzon/features/statusbar/data/resize_statusbar_service.dart';
import 'package:deadzon/features/statusbar/data/statusbar_board_model.dart';
import 'package:deadzon/features/statusbar/data/statusbar_board_service.dart';
import 'package:deadzon/features/statusbar/presentation/mezo_controls.dart';
import 'package:deadzon/features/statusbar/statusbar_board_source_map.dart';
import 'package:deadzon/features/statusbar/mezo_port_map.dart';
import 'package:deadzon/features/statusbar/statusbar_detail_content.dart';
import 'package:deadzon/features/statusbar/statusbar_mapper.dart';
import 'package:deadzon/features/statusbar/statusbar_models.dart';
import 'package:deadzon/features/statusbar/statusbar_section_configs.dart';
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
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 300),
          children: <Widget>[
            const PremiumTopBar(
              title: 'Statusbar adjustment',
              subtitle: 'Customize status bar layout and icon positions',
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


class _StatusControlBoard extends StatefulWidget {
  const _StatusControlBoard({
    required this.boardState,
    required this.onChanged,
    required this.onOpenSection,
  });

  final StatusbarBoardState boardState;
  final ValueChanged<StatusbarBoardState> onChanged;
  final ValueChanged<String> onOpenSection;

  @override
  State<_StatusControlBoard> createState() => _StatusControlBoardState();
}

class _StatusControlBoardState extends State<_StatusControlBoard> {
  static const double _boardHeight = 302;
  static const double _boardHorizontalPadding = 10;
  static const double _boardTopInset = 62;
  static const double _boardActiveTopHeight = 86;
  static const double _boardLowerStartY = 202;
  static const double _minTileSize = 28;
  static const double _maxTileSize = 34;
  static const double _tileGap = 4;

  final GlobalKey _boardKey = GlobalKey();
  late StatusbarBoardState _workingState;
  String? _draggingId;
  int? _activePointer;
  Offset _dragOffset = Offset.zero;
  Offset _pointerAnchor = Offset.zero;

  @override
  void initState() {
    super.initState();
    _workingState = widget.boardState;
  }

  @override
  void didUpdateWidget(covariant _StatusControlBoard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_draggingId == null && oldWidget.boardState != widget.boardState) {
      _workingState = widget.boardState;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Statusbar adjustment',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
                ),
              ),
              TextButton.icon(
                onPressed: _resetBoard,
                icon: const Icon(Icons.restart_alt_rounded),
                label: const Text('Reset'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          LayoutBuilder(
            builder: (context, constraints) {
              final slots = _slots(constraints.maxWidth);
              final tileSize = _tileSizeForSlots(slots);
              return SizedBox(
                height: _boardHeight,
                child: DecoratedBox(
                  key: _boardKey,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: const Color(0xFF8D67FF).withValues(alpha: 0.55)),
                    color: const Color(0xFF060B10),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(child: _BoardGuides(slots: slots)),
                      ..._workingState.modules.where((m) => m.visible).map((module) => _moduleWidget(module, slots, tileSize)),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  List<_Slot> _slots(double width) {
    final centerX = width / 2;
    final topRowOneY = _boardTopInset;
    final topRowTwoY = _boardTopInset + 46;
    final bottomRowY = _boardLowerStartY;

    return <_Slot>[
      _Slot(sectorBase: 20, left: _boardHorizontalPadding, right: centerX - 6, y: topRowOneY),
      _Slot(sectorBase: 30, left: centerX + 6, right: width - _boardHorizontalPadding, y: topRowOneY),
      _Slot(sectorBase: 0, left: _boardHorizontalPadding, right: centerX - 6, y: topRowTwoY),
      _Slot(sectorBase: 10, left: centerX + 6, right: width - _boardHorizontalPadding, y: topRowTwoY),
      _Slot(sectorBase: 40, left: _boardHorizontalPadding, right: centerX - 6, y: bottomRowY),
      _Slot(sectorBase: 50, left: centerX + 6, right: width - _boardHorizontalPadding, y: bottomRowY),
    ];
  }

  double _tileSizeForSlots(List<_Slot> slots) {
    var size = _maxTileSize;
    for (final slot in slots) {
      final count = _workingState.modules.where((m) => _sectorBase(m.currentPositionCode) == slot.sectorBase && m.visible).length;
      if (count <= 1) {
        continue;
      }
      final slotWidth = slot.right - slot.left;
      final calculated = (slotWidth - (_tileGap * (count - 1))) / count;
      if (calculated < size) {
        size = calculated;
      }
    }
    return size.clamp(_minTileSize, _maxTileSize).toDouble();
  }

  Widget _moduleWidget(StatusbarBoardModuleState module, List<_Slot> slots, double tileSize) {
    final moduleSlot = slots.firstWhere((slot) => slot.sectorBase == _sectorBase(module.currentPositionCode), orElse: () => slots.first);
    final positionInSlot = _positionInSlot(module.currentPositionCode);
    final left = moduleSlot.left + ((positionInSlot - 1) * (tileSize + _tileGap));
    final top = moduleSlot.y + module.offsetY;
    final dragging = _draggingId == module.id;
    final pos = dragging ? _dragOffset : Offset(left, top);

    return Positioned(
      left: pos.dx,
      top: pos.dy,
      child: Listener(
        onPointerDown: (event) {
          setState(() {
            _activePointer = event.pointer;
            _draggingId = module.id;
            _dragOffset = Offset(left, top);
            _pointerAnchor = event.localPosition;
          });
        },
        onPointerMove: (event) {
          if (_activePointer != event.pointer || _draggingId != module.id) {
            return;
          }
          final boardContext = _boardKey.currentContext;
          final boardBox = boardContext?.findRenderObject() as RenderBox?;
          if (boardBox == null) {
            return;
          }
          final local = boardBox.globalToLocal(event.position);
          final nextTopLeft = local - _pointerAnchor;
          setState(() => _dragOffset = nextTopLeft);
          _liveRelayout(module.id, nextTopLeft, slots, tileSize);
        },
        onPointerUp: (event) => _endDrag(event.pointer),
        onPointerCancel: (event) => _endDrag(event.pointer),
        child: SizedBox(
          width: tileSize,
          height: tileSize,
          child: _BoardModuleBadge(
            module: module,
            size: tileSize,
            isDragging: dragging,
            onTap: () => _showModuleSheet(context, module),
          ),
        ),
      ),
    );
  }

  int _sectorBase(int code) {
    if (code >= 50) return 50;
    if (code >= 40) return 40;
    if (code >= 30) return 30;
    if (code >= 20) return 20;
    if (code >= 10) return 10;
    return 0;
  }

  int _positionInSlot(int code) {
    final pos = code % 10;
    return pos == 0 ? 1 : pos;
  }

  int _nearestCodeFor(Offset pos, List<_Slot> slots, double tileSize, Set<int> occupied, String moduleId) {
    final centerY = pos.dy + (tileSize / 2);
    final centerX = pos.dx + (tileSize / 2);

    final isBelowDivider = centerY > (_boardTopInset + _boardActiveTopHeight);
    final leftSide = centerX < (slots.first.right + slots[1].left) / 2;

    final sector = switch ((isBelowDivider, leftSide)) {
      (true, true) => 40,
      (true, false) => 50,
      (false, true) => centerY < (_boardTopInset + 28) ? 20 : 0,
      (false, false) => centerY < (_boardTopInset + 28) ? 30 : 10,
    };

    final sectorSlot = slots.firstWhere((slot) => slot.sectorBase == sector);
    final rawIndex = ((centerX - sectorSlot.left) / (tileSize + _tileGap)).round() + 1;
    final clamped = rawIndex.clamp(1, 9);

    var candidate = sector + clamped;
    if (!occupied.contains(candidate)) {
      return candidate;
    }
    for (var i = 1; i <= 9; i++) {
      final alt = sector + i;
      if (!occupied.contains(alt)) {
        return alt;
      }
    }
    final current = _workingState.modules.firstWhere((m) => m.id == moduleId).currentPositionCode;
    return current;
  }

  void _liveRelayout(String moduleId, Offset pos, List<_Slot> slots, double tileSize) {
    final occupied = _workingState.modules.where((m) => m.id != moduleId).map((m) => m.currentPositionCode).toSet();
    final nextCode = _nearestCodeFor(pos, slots, tileSize, occupied, moduleId);
    final moved = _workingState.modules.firstWhere((m) => m.id == moduleId).copyWith(currentPositionCode: nextCode, visible: true, enabled: true);
    final updated = <StatusbarBoardModuleState>[..._workingState.modules.where((m) => m.id != moduleId), moved];
    setState(() {
      _workingState = _workingState.copyWith(modules: updated);
    });
  }

  Future<void> _resetBoard() async {
    final next = _workingState.copyWith(modules: StatusbarBoardService.defaultModules());
    setState(() => _workingState = next);
    widget.onChanged(next);
  }

  Future<void> _showModuleSheet(BuildContext context, StatusbarBoardModuleState module) async {
    var current = module;
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: const Color(0xFF0B1418), borderRadius: BorderRadius.circular(24)),
        child: StatefulBuilder(
          builder: (context, setModal) => Column(mainAxisSize: MainAxisSize.min, children: [
            Text(current.module.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            SwitchListTile.adaptive(
              value: current.visible,
              onChanged: (v) {
                final n = current.copyWith(visible: v);
                setModal(() => current = n);
                _updateSingle(n);
              },
              title: const Text('Visible', style: TextStyle(color: Colors.white)),
            ),
          ]),
        ),
      ),
    );
  }

  void _updateSingle(StatusbarBoardModuleState next) {
    final updated = _workingState.modules.map((m) => m.id == next.id ? next : m).toList(growable: false);
    final nextState = _workingState.copyWith(modules: updated);
    setState(() => _workingState = nextState);
    widget.onChanged(nextState);
  }

  void _endDrag(int pointer) {
    if (_activePointer != pointer) {
      return;
    }
    final nextState = _workingState.copyWith(modules: _workingState.modules);
    setState(() {
      _activePointer = null;
      _draggingId = null;
      _workingState = nextState;
    });
    widget.onChanged(nextState);
  }
}

class _Slot {
  const _Slot({required this.sectorBase, required this.left, required this.right, required this.y});

  final int sectorBase;
  final double left;
  final double right;
  final double y;
}

class _BoardGuides extends StatelessWidget {
  const _BoardGuides({required this.slots});
  final List<_Slot> slots;

  @override
  Widget build(BuildContext context) {
    final leftTop = slots.firstWhere((slot) => slot.sectorBase == 20);
    final rightTop = slots.firstWhere((slot) => slot.sectorBase == 30);
    final center = (leftTop.right + rightTop.left) / 2;

    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xFF05090D), Color(0xFF080B13), Color(0xFF020407)],
              ),
            ),
          ),
        ),
        Positioned(
          left: center - 1,
          top: 22,
          bottom: 22,
          child: Container(
            width: 2,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.62),
              borderRadius: BorderRadius.circular(99),
              boxShadow: <BoxShadow>[
                BoxShadow(color: Colors.white.withValues(alpha: 0.14), blurRadius: 12),
              ],
            ),
          ),
        ),
        Positioned(
          left: 18,
          right: 18,
          top: 148,
          child: Container(
            height: 7,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.24),
              borderRadius: BorderRadius.circular(99),
            ),
          ),
        ),
        Positioned(
          left: 18,
          right: 18,
          top: 206,
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              color: const Color(0xFF8D67FF).withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(99),
            ),
          ),
        ),
        Positioned(
          left: 18,
          top: 18,
          child: Text(
            'Left side',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.72), fontSize: 13, fontWeight: FontWeight.w700),
          ),
        ),
        Positioned(
          left: center - 30,
          top: 18,
          child: Text(
            'Center',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.62), fontSize: 13, fontWeight: FontWeight.w700),
          ),
        ),
        Positioned(
          right: 18,
          top: 18,
          child: Text(
            'Right side',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.72), fontSize: 13, fontWeight: FontWeight.w700),
          ),
        ),
      ],
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
            mainAxisExtent: compact ? 152 : 148,
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
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _MezoDrawableImage(
                  path: source.drawableAssetPath,
                  width: 58,
                  height: 28,
                  fallbackIcon: Icons.widgets_rounded,
                ),
                const SizedBox(height: 12),
                Text(
                  source.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                        height: 1.05,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  source.summary,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.72),
                        height: 1.16,
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

class _BoardModuleBadge extends StatelessWidget {
  const _BoardModuleBadge({
    required this.module,
    required this.size,
    required this.isDragging,
    required this.onTap,
  });

  final StatusbarBoardModuleState module;
  final double size;
  final bool isDragging;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final opacity = module.visible ? 1.0 : 0.38;

    return AnimatedScale(
      duration: DesignTokens.motionFast,
      scale: isDragging ? 1.08 : 1,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AnimatedOpacity(
          duration: DesignTokens.motionFast,
          opacity: opacity,
          child: AnimatedContainer(
            duration: DesignTokens.motionFast,
            curve: DesignTokens.motionCurve,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size * 0.24),
              color: const Color(0xFF10272E),
              border: Border.all(color: module.module.color.withValues(alpha: isDragging ? 0.9 : 0.5), width: isDragging ? 1.6 : 1.1),
              boxShadow: isDragging
                  ? <BoxShadow>[
                      BoxShadow(color: module.module.color.withValues(alpha: 0.35), blurRadius: 16, spreadRadius: 2),
                    ]
                  : const <BoxShadow>[],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(size * 0.2),
              child: Image.asset(
                module.asset,
                width: size * 0.92,
                height: size * 0.92,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    module.module.icon,
                    color: Colors.white,
                    size: (size * 0.58).clamp(14, 24).toDouble(),
                  );
                },
              ),
            ),
          ),
        ),
      ),
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
