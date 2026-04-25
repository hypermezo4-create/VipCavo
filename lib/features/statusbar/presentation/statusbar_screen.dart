import 'dart:convert';

import 'package:deadzon/core/theme/design_tokens.dart';
import 'package:deadzon/core/widgets/glass_card.dart';
import 'package:deadzon/core/widgets/premium_top_bar.dart';
import 'package:deadzon/core/widgets/section_header.dart';
import 'package:deadzon/core/widgets/settings_row.dart';
import 'package:deadzon/features/statusbar/data/resize_statusbar_service.dart';
import 'package:deadzon/features/statusbar/mezo_port_map.dart';
import 'package:deadzon/features/statusbar/presentation/mezo_controls.dart';
import 'package:deadzon/features/statusbar/statusbar_detail_content.dart';
import 'package:deadzon/features/statusbar/statusbar_mapper.dart';
import 'package:deadzon/features/statusbar/statusbar_models.dart';
import 'package:deadzon/features/statusbar/statusbar_section_configs.dart';
import 'package:deadzon/features/statusbar/statusbar_strings.dart';
import 'package:flutter/foundation.dart';
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
  static const String _prefsSingleOrderKey = 'statusbar_studio_single_order';
  static const String _prefsTwoRowOrderKey = 'statusbar_studio_two_row_order';

  late List<String> _singleRowOrder;
  late Map<_TwoRowLane, List<String>> _twoRowOrder;
  _StudioLayoutMode _layoutMode = _StudioLayoutMode.singleRow;
  bool _isHydrating = true;

  @override
  void initState() {
    super.initState();
    _singleRowOrder = _defaultSingleRowOrder();
    _twoRowOrder = _defaultTwoRowsOrder();
    _hydrateStudioLayout();
  }

  Future<void> _hydrateStudioLayout() async {
    final prefs = await SharedPreferences.getInstance();
    final mode = prefs.getString(_prefsModeKey);
    final singleRaw = prefs.getStringList(_prefsSingleOrderKey);
    final twoRowsRaw = prefs.getString(_prefsTwoRowOrderKey);
    if (!mounted) {
      return;
    }
    setState(() {
      _layoutMode = mode == _StudioLayoutMode.twoRows.name ? _StudioLayoutMode.twoRows : _StudioLayoutMode.singleRow;
      if (singleRaw != null && singleRaw.length == _studioItems.length) {
        _singleRowOrder = _normalizeOrder(singleRaw);
      }
      if (twoRowsRaw != null) {
        final decoded = _decodeTwoRowOrder(twoRowsRaw);
        if (decoded != null) {
          _twoRowOrder = decoded;
        }
      }
      _isHydrating = false;
    });
  }

  List<String> _normalizeOrder(List<String> candidate) {
    final allowed = _studioItems.map((item) => item.id).toSet();
    final next = <String>[];
    for (final id in candidate) {
      if (allowed.contains(id) && !next.contains(id)) {
        next.add(id);
      }
    }
    for (final item in _studioItems) {
      if (!next.contains(item.id)) {
        next.add(item.id);
      }
    }
    return next;
  }

  Future<void> _restoreDefaultLayout() async {
    setState(() {
      _layoutMode = _StudioLayoutMode.singleRow;
      _singleRowOrder = _defaultSingleRowOrder();
      _twoRowOrder = _defaultTwoRowsOrder();
    });
    await _persistStudioLayout();
    _showMessage('Default layout restored');
  }

  Future<void> _persistStudioLayout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsModeKey, _layoutMode.name);
    await prefs.setStringList(_prefsSingleOrderKey, _singleRowOrder);
    await prefs.setString(_prefsTwoRowOrderKey, jsonEncode(_twoRowOrder.map((k, v) => MapEntry(k.name, v))));
  }

  Map<_TwoRowLane, List<String>>? _decodeTwoRowOrder(String raw) {
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) {
        return null;
      }
      final next = <_TwoRowLane, List<String>>{};
      for (final lane in _TwoRowLane.values) {
        final current = decoded[lane.name];
        if (current is! List) {
          return null;
        }
        next[lane] = current.map((item) => item.toString()).toList(growable: false);
      }
      return next;
    } catch (_) {
      return null;
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
        singleRowOrder: _singleRowOrder,
        twoRowsOrder: _twoRowOrder,
      ),
    );
    if (result == null || !mounted) {
      return;
    }
    setState(() {
      _layoutMode = result.mode;
      _singleRowOrder = result.singleRowOrder;
      _twoRowOrder = result.twoRowsOrder;
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

  Future<void> _openQuickSection(_QuickSection section) async {
    if (section.children.isEmpty) {
      _openSection(section.sectionId!);
      return;
    }
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF0A1B2F),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 8),
              Container(
                width: 42,
                height: 5,
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.24), borderRadius: BorderRadius.circular(100)),
              ),
              const SizedBox(height: 14),
              Text(section.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18)),
              const SizedBox(height: 8),
              ...section.children.map((child) {
                return ListTile(
                  leading: Icon(child.icon, color: const Color(0xFF8DE8FF)),
                  title: Text(child.title, style: const TextStyle(color: Colors.white)),
                  subtitle: Text(child.subtitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.66))),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.white70),
                  onTap: () {
                    Navigator.of(context).pop();
                    _openSection(child.sectionId);
                  },
                );
              }),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
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
                            singleRowOrder: _singleRowOrder,
                            twoRowsOrder: _twoRowOrder,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    const SectionHeader(title: 'Quick Sections', subtitle: 'Jump to focused controls'),
                    const SizedBox(height: 10),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _quickSections.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        mainAxisExtent: 120,
                      ),
                      itemBuilder: (context, index) {
                        final section = _quickSections[index];
                        return _QuickSectionCard(section: section, onTap: () => _openQuickSection(section));
                      },
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
    required this.singleRowOrder,
    required this.twoRowsOrder,
  });

  final _StudioLayoutMode mode;
  final List<String> singleRowOrder;
  final Map<_TwoRowLane, List<String>> twoRowsOrder;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: DesignTokens.motionFast,
      curve: DesignTokens.motionCurve,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xFF081224).withValues(alpha: 0.9),
        border: Border.all(color: const Color(0xFF6FAAFF).withValues(alpha: 0.42)),
      ),
      child: mode == _StudioLayoutMode.singleRow
          ? _PreviewIconWrap(order: singleRowOrder)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _PreviewIconWrap(order: twoRowsOrder[_TwoRowLane.leftTop]!),
                const SizedBox(height: 6),
                _PreviewIconWrap(order: twoRowsOrder[_TwoRowLane.leftBottom]!),
                const SizedBox(height: 10),
                _PreviewIconWrap(order: twoRowsOrder[_TwoRowLane.rightTop]!),
                const SizedBox(height: 6),
                _PreviewIconWrap(order: twoRowsOrder[_TwoRowLane.rightBottom]!),
              ],
            ),
    );
  }
}

class _PreviewIconWrap extends StatelessWidget {
  const _PreviewIconWrap({required this.order});

  final List<String> order;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: order.map((id) {
        final item = _studioItemById[id]!;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFF17314F).withValues(alpha: 0.8),
            border: Border.all(color: item.color.withValues(alpha: 0.42)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(item.icon, size: 14, color: Colors.white),
              const SizedBox(width: 5),
              Text(item.shortLabel, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600)),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _ArrangeLayoutSheet extends StatefulWidget {
  const _ArrangeLayoutSheet({
    required this.mode,
    required this.singleRowOrder,
    required this.twoRowsOrder,
  });

  final _StudioLayoutMode mode;
  final List<String> singleRowOrder;
  final Map<_TwoRowLane, List<String>> twoRowsOrder;

  @override
  State<_ArrangeLayoutSheet> createState() => _ArrangeLayoutSheetState();
}

class _ArrangeLayoutSheetState extends State<_ArrangeLayoutSheet> {
  late _StudioLayoutMode _mode;
  late List<String> _singleOrder;
  late Map<_TwoRowLane, List<String>> _twoRows;

  @override
  void initState() {
    super.initState();
    _mode = widget.mode;
    _singleOrder = List<String>.from(widget.singleRowOrder);
    _twoRows = <_TwoRowLane, List<String>>{
      for (final lane in _TwoRowLane.values) lane: List<String>.from(widget.twoRowsOrder[lane]!),
    };
  }

  void _swapSingle(String source, String target) {
    final sourceIndex = _singleOrder.indexOf(source);
    final targetIndex = _singleOrder.indexOf(target);
    if (sourceIndex == -1 || targetIndex == -1 || sourceIndex == targetIndex) {
      return;
    }
    setState(() {
      final hold = _singleOrder[sourceIndex];
      _singleOrder[sourceIndex] = _singleOrder[targetIndex];
      _singleOrder[targetIndex] = hold;
    });
  }

  void _swapTwoRows(_TwoRowLane lane, String source, String target) {
    final items = _twoRows[lane]!;
    final sourceIndex = items.indexOf(source);
    final targetIndex = items.indexOf(target);
    if (sourceIndex == -1 || targetIndex == -1 || sourceIndex == targetIndex) {
      return;
    }
    setState(() {
      final hold = items[sourceIndex];
      items[sourceIndex] = items[targetIndex];
      items[targetIndex] = hold;
    });
  }

  void _resetToDefault() {
    setState(() {
      _mode = _StudioLayoutMode.singleRow;
      _singleOrder = _defaultSingleRowOrder();
      _twoRows = _defaultTwoRowsOrder();
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Default layout restored')));
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF071121),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          border: Border.all(color: const Color(0xFF5BA6FF).withValues(alpha: 0.22)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              Container(width: 44, height: 5, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(100))),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 12, 0),
                child: Row(
                  children: <Widget>[
                    TextButton(onPressed: _resetToDefault, child: const Text('Reset')),
                    Expanded(
                      child: Text(
                        'Arrange Layout',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(
                          _ArrangeLayoutResult(
                            mode: _mode,
                            singleRowOrder: _singleOrder,
                            twoRowsOrder: _twoRows,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _StatusbarLivePreview(mode: _mode, singleRowOrder: _singleOrder, twoRowsOrder: _twoRows),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 2, 16, 24),
                  child: _mode == _StudioLayoutMode.singleRow
                      ? _DragArrangeLane(
                          label: 'Single row icons',
                          order: _singleOrder,
                          onSwap: _swapSingle,
                        )
                      : Column(
                          children: _TwoRowLane.values.map((lane) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: _DragArrangeLane(
                                label: lane.title,
                                order: _twoRows[lane]!,
                                onSwap: (source, target) => _swapTwoRows(lane, source, target),
                              ),
                            );
                          }).toList(),
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

class _DragArrangeLane extends StatelessWidget {
  const _DragArrangeLane({
    required this.label,
    required this.order,
    required this.onSwap,
  });

  final String label;
  final List<String> order;
  final void Function(String source, String target) onSwap;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: order.map((id) {
              final item = _studioItemById[id]!;
              return DragTarget<String>(
                onWillAcceptWithDetails: (details) => details.data != id,
                onAcceptWithDetails: (details) => onSwap(details.data, id),
                builder: (context, candidate, rejected) {
                  final hovered = candidate.isNotEmpty;
                  return Draggable<String>(
                    data: id,
                    feedback: Material(
                      color: Colors.transparent,
                      child: _ArrangeChip(item: item, highlighted: true),
                    ),
                    childWhenDragging: Opacity(opacity: 0.34, child: _ArrangeChip(item: item)),
                    child: _ArrangeChip(item: item, highlighted: hovered),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _ArrangeChip extends StatelessWidget {
  const _ArrangeChip({
    required this.item,
    this.highlighted = false,
  });

  final _StudioItem item;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: DesignTokens.motionFast,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: highlighted ? const Color(0xFF1B4777) : const Color(0xFF10273F),
        border: Border.all(color: item.color.withValues(alpha: highlighted ? 0.9 : 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(item.icon, size: 14, color: Colors.white),
          const SizedBox(width: 6),
          Text(item.shortLabel, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
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

class _QuickSectionCard extends StatelessWidget {
  const _QuickSectionCard({
    required this.section,
    required this.onTap,
  });

  final _QuickSection section;
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
            borderRadius: BorderRadius.circular(22),
            color: const Color(0xFF112339).withValues(alpha: 0.84),
            border: Border.all(color: section.color.withValues(alpha: 0.42)),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(section.icon, color: Colors.white),
              const Spacer(),
              Text(section.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
              const SizedBox(height: 2),
              Text(section.subtitle, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white.withValues(alpha: 0.72), fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}

enum _StudioLayoutMode { singleRow, twoRows }

enum _TwoRowLane {
  leftTop('Left Row 1'),
  leftBottom('Left Row 2'),
  rightTop('Right Row 1'),
  rightBottom('Right Row 2');

  const _TwoRowLane(this.title);
  final String title;
}

@immutable
class _ArrangeLayoutResult {
  const _ArrangeLayoutResult({
    required this.mode,
    required this.singleRowOrder,
    required this.twoRowsOrder,
  });

  final _StudioLayoutMode mode;
  final List<String> singleRowOrder;
  final Map<_TwoRowLane, List<String>> twoRowsOrder;
}

@immutable
class _StudioItem {
  const _StudioItem({
    required this.id,
    required this.shortLabel,
    required this.icon,
    required this.color,
  });

  final String id;
  final String shortLabel;
  final IconData icon;
  final Color color;
}

@immutable
class _QuickSection {
  const _QuickSection({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.sectionId,
    this.children = const <_QuickSectionChild>[],
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String? sectionId;
  final List<_QuickSectionChild> children;
}

@immutable
class _QuickSectionChild {
  const _QuickSectionChild({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.sectionId,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String sectionId;
}

const List<_StudioItem> _studioItems = <_StudioItem>[
  _StudioItem(id: 'time_status_time', shortLabel: 'Time', icon: Icons.access_time_rounded, color: Color(0xFF7DDCFF)),
  _StudioItem(id: 'notification_call', shortLabel: 'Call', icon: Icons.call_rounded, color: Color(0xFFFFA1A1)),
  _StudioItem(id: 'speed_gauge', shortLabel: 'Gauge', icon: Icons.speed_rounded, color: Color(0xFF7BC5FF)),
  _StudioItem(id: 'clock', shortLabel: 'Clock', icon: Icons.schedule_rounded, color: Color(0xFF9CD9FF)),
  _StudioItem(id: 'prompt_plug', shortLabel: 'Plug', icon: Icons.power_rounded, color: Color(0xFFBDE9FF)),
  _StudioItem(id: 'netspeed_moon', shortLabel: 'Moon', icon: Icons.nightlight_round, color: Color(0xFFABC3FF)),
  _StudioItem(id: 'temperature', shortLabel: 'Temp', icon: Icons.thermostat_rounded, color: Color(0xFFA8E7FF)),
  _StudioItem(id: 'date_day', shortLabel: 'Day', icon: Icons.calendar_today_rounded, color: Color(0xFFD0DCFF)),
  _StudioItem(id: 'bluetooth', shortLabel: 'BT', icon: Icons.bluetooth_rounded, color: Color(0xFF97C0FF)),
  _StudioItem(id: 'sim_1', shortLabel: 'SIM1', icon: Icons.sim_card_rounded, color: Color(0xFF9FB7FF)),
  _StudioItem(id: 'sim_2', shortLabel: 'SIM2', icon: Icons.sim_card_rounded, color: Color(0xFFA8C1FF)),
  _StudioItem(id: 'wifi', shortLabel: 'Wi-Fi', icon: Icons.wifi_rounded, color: Color(0xFF89DFFF)),
  _StudioItem(id: 'battery', shortLabel: 'Battery', icon: Icons.battery_5_bar_rounded, color: Color(0xFF95FFBA)),
  _StudioItem(id: 'weather', shortLabel: 'Weather', icon: Icons.wb_sunny_rounded, color: Color(0xFF8EE6FF)),
  _StudioItem(id: 'date_31_12', shortLabel: '31/12', icon: Icons.event_note_rounded, color: Color(0xFFC1CDFF)),
  _StudioItem(id: 'alarm', shortLabel: 'Alarm', icon: Icons.alarm_rounded, color: Color(0xFFDED8FF)),
  _StudioItem(id: 'network_blue', shortLabel: 'Net B', icon: Icons.network_cell_rounded, color: Color(0xFF81C9FF)),
  _StudioItem(id: 'network_red', shortLabel: 'Net R', icon: Icons.network_cell_rounded, color: Color(0xFFFFACAC)),
  _StudioItem(id: 'wifi_secondary', shortLabel: 'Wi-Fi2', icon: Icons.wifi_tethering_rounded, color: Color(0xFF89DBFF)),
  _StudioItem(id: 'charging', shortLabel: 'Charge', icon: Icons.bolt_rounded, color: Color(0xFFB6FFB0)),
];

final Map<String, _StudioItem> _studioItemById = {for (final item in _studioItems) item.id: item};

const List<_QuickSection> _quickSections = <_QuickSection>[
  _QuickSection(title: 'Battery', subtitle: 'Style, percent and charging', icon: Icons.battery_6_bar_rounded, color: Color(0xFF8BF3AE), sectionId: 'battery'),
  _QuickSection(title: 'Clock', subtitle: 'Time format and spacing', icon: Icons.access_time_rounded, color: Color(0xFF8DD0FF), sectionId: 'clock'),
  _QuickSection(title: 'Network', subtitle: 'Wi-Fi and SIM indicators', icon: Icons.signal_cellular_alt_rounded, color: Color(0xFF9AB2FF), sectionId: 'network'),
  _QuickSection(
    title: 'Date & Weather',
    subtitle: 'Date and weather cards',
    icon: Icons.calendar_month_rounded,
    color: Color(0xFFB7C6FF),
    children: <_QuickSectionChild>[
      _QuickSectionChild(title: 'Date', subtitle: 'Date format and layout', icon: Icons.calendar_month_rounded, sectionId: 'date'),
      _QuickSectionChild(title: 'Weather', subtitle: 'Weather icon and temperature', icon: Icons.cloud_rounded, sectionId: 'weather'),
    ],
  ),
  _QuickSection(
    title: 'Icons',
    subtitle: 'Status and notifications',
    icon: Icons.widgets_rounded,
    color: Color(0xFFA9F4E0),
    children: <_QuickSectionChild>[
      _QuickSectionChild(title: 'Status icons', subtitle: 'Utility icons visibility', icon: Icons.widgets_rounded, sectionId: 'status_icons'),
      _QuickSectionChild(title: 'Notification icons', subtitle: 'Notification icon layout', icon: Icons.notifications_rounded, sectionId: 'notification_icons'),
    ],
  ),
  _QuickSection(
    title: 'Prompt & Background',
    subtitle: 'Prompt and visual layer',
    icon: Icons.format_paint_rounded,
    color: Color(0xFF94E0D4),
    children: <_QuickSectionChild>[
      _QuickSectionChild(title: 'Prompt icon', subtitle: 'Prompt icon behavior', icon: Icons.chat_bubble_outline_rounded, sectionId: 'prompt_icon'),
      _QuickSectionChild(title: 'Background', subtitle: 'Background blur and glow', icon: Icons.format_paint_rounded, sectionId: 'background'),
    ],
  ),
];

List<String> _defaultSingleRowOrder() => const <String>[
      'time_status_time',
      'notification_call',
      'speed_gauge',
      'clock',
      'prompt_plug',
      'netspeed_moon',
      'temperature',
      'date_day',
      'bluetooth',
      'sim_1',
      'sim_2',
      'wifi',
      'battery',
      'weather',
      'date_31_12',
      'alarm',
      'network_blue',
      'network_red',
      'wifi_secondary',
      'charging',
    ];

Map<_TwoRowLane, List<String>> _defaultTwoRowsOrder() => <_TwoRowLane, List<String>>{
      _TwoRowLane.leftTop: <String>['time_status_time', 'notification_call', 'speed_gauge'],
      _TwoRowLane.leftBottom: <String>['clock', 'prompt_plug', 'netspeed_moon'],
      _TwoRowLane.rightTop: <String>['temperature', 'date_day', 'bluetooth', 'sim_1', 'sim_2', 'wifi', 'battery'],
      _TwoRowLane.rightBottom: <String>['weather', 'date_31_12', 'alarm', 'network_blue', 'network_red', 'wifi_secondary', 'charging'],
    };

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
