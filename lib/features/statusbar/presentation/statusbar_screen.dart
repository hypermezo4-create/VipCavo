import 'dart:ui';

import 'package:deadzon/core/theme/design_tokens.dart';
import 'package:deadzon/core/widgets/glass_card.dart';
import 'package:deadzon/core/widgets/premium_top_bar.dart';
import 'package:deadzon/core/widgets/section_header.dart';
import 'package:deadzon/core/widgets/settings_row.dart';
import 'package:deadzon/features/statusbar/statusbar_board_config.dart';
import 'package:deadzon/features/statusbar/helper.dart';
import 'package:deadzon/features/statusbar/statusbar_detail_content.dart';
import 'package:deadzon/features/statusbar/statusbar_mapper.dart';
import 'package:deadzon/features/statusbar/statusbar_models.dart';
import 'package:deadzon/features/statusbar/statusbar_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class StatusbarScreen extends StatelessWidget {
  const StatusbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = StatusBarHelper.orderedSections();

    return Container(
      decoration: const BoxDecoration(gradient: DesignTokens.baseGradient),
      child: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          padding: DesignTokens.pagePadding,
          children: <Widget>[
            const PremiumTopBar(
              title: StatusBarStrings.title,
              subtitle: StatusBarStrings.subtitle,
            ),
            const SizedBox(height: 16),
            const _StatusPreviewCard(),
            const SizedBox(height: 20),
            const SectionHeader(
              title: StatusBarStrings.sectionHeader,
              subtitle: StatusBarStrings.sectionHeaderSubtitle,
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, constraints) {
                final compact = constraints.maxWidth < 420;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: sections.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: compact ? 1 : 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: compact ? 2.2 : 1.08,
                  ),
                  itemBuilder: (context, index) {
                    final section = sections[index];
                    return GlassCard(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => StatusbarDetailScreen(section: section),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(section.icon, color: section.accentColor),
                          const Spacer(),
                          Text(
                            section.title,
                            maxLines: 2,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            section.previewLabel ?? StatusBarStrings.customizeLabel,
                            style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 12),
                          ),
                        ],
                      ),
                    )
                        .animate(delay: (45 * index).ms)
                        .fadeIn(duration: 260.ms)
                        .scale(begin: const Offset(0.96, 0.96), end: const Offset(1, 1));
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusPreviewCard extends StatefulWidget {
  const _StatusPreviewCard();

  @override
  State<_StatusPreviewCard> createState() => _StatusPreviewCardState();
}

class _StatusPreviewCardState extends State<_StatusPreviewCard> {
  late final List<_PreviewGroup> _groups;

  double _leftOffset = 0;
  double _rightOffset = 0;

  @override
  void initState() {
    super.initState();
    _groups = statusbarBoardModules
        .map(
          (module) => _PreviewGroup(
            module.id,
            module.title,
            module.previewLabel,
            module.icon,
            module.color,
            side: module.defaultSide,
            spacing: module.defaultSpacing,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SectionHeader(
            title: StatusBarStrings.livePreviewTitle,
            subtitle: StatusBarStrings.livePreviewSubtitle,
          ),
          const SizedBox(height: 12),
          _buildPreviewCanvas(),
          const SizedBox(height: 14),
          Text(
            StatusBarStrings.iconBoardTitle,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.82), fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            StatusBarStrings.iconBoardSubtitle,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.68), fontSize: 12),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _groups.map(_buildDraggableGroup).toList(),
          ),
          const SizedBox(height: 12),
          Text(StatusBarStrings.leftClusterOffsetLabel, style: TextStyle(color: Colors.white.withValues(alpha: 0.74))),
          Slider(value: _leftOffset, min: -28, max: 28, onChanged: (v) => setState(() => _leftOffset = v)),
          Text(StatusBarStrings.rightClusterOffsetLabel, style: TextStyle(color: Colors.white.withValues(alpha: 0.74))),
          Slider(value: _rightOffset, min: -28, max: 28, onChanged: (v) => setState(() => _rightOffset = v)),
        ],
      ),
    );
  }

  Widget _buildPreviewCanvas() {
    final leftGroups = _groups.where((group) => group.side == StatusbarBoardSide.left && group.enabled).toList();
    final rightGroups = _groups.where((group) => group.side == StatusbarBoardSide.right && group.enabled).toList();
    return AnimatedContainer(
      duration: DesignTokens.motionFast,
      curve: DesignTokens.motionCurve,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.black.withValues(alpha: 0.22),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            constraints: const BoxConstraints(minHeight: 80),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF132228).withValues(alpha: 0.58),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final compact = constraints.maxWidth < 360;
                if (compact) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Transform.translate(
                        offset: Offset(_leftOffset, 0),
                        child: Wrap(spacing: 6, runSpacing: 6, children: leftGroups.map(_groupChip).toList()),
                      ),
                      const SizedBox(height: 8),
                      Transform.translate(
                        offset: Offset(_rightOffset, 0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Wrap(
                            alignment: WrapAlignment.end,
                            spacing: 6,
                            runSpacing: 6,
                            children: rightGroups.map(_groupChip).toList(),
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Transform.translate(
                        offset: Offset(_leftOffset, 0),
                        child: Wrap(spacing: 6, runSpacing: 6, children: leftGroups.map(_groupChip).toList()),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Transform.translate(
                        offset: Offset(_rightOffset, 0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Wrap(
                            alignment: WrapAlignment.end,
                            spacing: 6,
                            runSpacing: 6,
                            children: rightGroups.map(_groupChip).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _groupChip(_PreviewGroup group) {
    return AnimatedContainer(
      duration: DesignTokens.motionFast,
      margin: EdgeInsets.only(right: group.spacing),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(group.icon, size: 14, color: group.color),
          const SizedBox(width: 4),
          Text(group.label, style: const TextStyle(color: Colors.white70, fontSize: 11.5, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildDraggableGroup(_PreviewGroup group) {
    final index = _groups.indexOf(group);
    return DragTarget<String>(
      onAcceptWithDetails: (details) {
        final fromIndex = _groups.indexWhere((g) => g.id == details.data);
        final toIndex = index;
        if (fromIndex == -1 || fromIndex == toIndex) {
          return;
        }
        setState(() {
          final item = _groups.removeAt(fromIndex);
          _groups.insert(toIndex, item);
        });
      },
      builder: (context, candidateData, rejectedData) {
        return LongPressDraggable<String>(
          data: group.id,
          feedback: Material(
            color: Colors.transparent,
            child: _boardPill(group, active: true),
          ),
          childWhenDragging: Opacity(opacity: 0.35, child: _boardPill(group)),
          child: _boardPill(group),
        );
      },
    );
  }

  Widget _boardPill(_PreviewGroup group, {bool active = false}) {
    return AnimatedContainer(
      duration: DesignTokens.motionFast,
      curve: DesignTokens.motionCurve,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: active ? 0.2 : 0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(group.icon, size: 15, color: group.color),
          const SizedBox(width: 6),
          Text(group.title, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w600)),
          const SizedBox(width: 8),
          InkWell(
            onTap: () => setState(() {
              group.side = group.side == StatusbarBoardSide.left ? StatusbarBoardSide.right : StatusbarBoardSide.left;
            }),
            child: Icon(group.side == StatusbarBoardSide.left ? Icons.west_rounded : Icons.east_rounded, size: 16, color: Colors.white70),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: () => setState(() => group.enabled = !group.enabled),
            child: Icon(group.enabled ? Icons.visibility_rounded : Icons.visibility_off_rounded, size: 16, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class _PreviewGroup {
  _PreviewGroup(
    this.id,
    this.title,
    this.label,
    this.icon,
    this.color, {
    required this.side,
    required this.spacing,
  });

  final String id;
  final String title;
  final String label;
  final IconData icon;
  final Color color;
  StatusbarBoardSide side;
  bool enabled = true;
  double spacing;
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

  @override
  void initState() {
    super.initState();
    _settings = StatusBarMapper.settingsForSection(widget.section.id);
    for (final setting in _settings) {
      _values[setting.legacyKey] = setting.defaultValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final grouped = <String, List<StatusBarSettingItem>>{};
    for (final setting in _settings) {
      grouped.putIfAbsent(setting.group, () => <StatusBarSettingItem>[]).add(setting);
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0B1418),
      appBar: AppBar(title: Text(widget.section.title)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: <Widget>[
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
          for (final entry in grouped.entries) ...<Widget>[
            SectionHeader(title: entry.key),
            const SizedBox(height: 8),
            GlassCard(
              child: Column(
                children: <Widget>[
                  for (var i = 0; i < entry.value.length; i++) ...<Widget>[
                    _SettingControl(
                      setting: entry.value[i],
                      value: _values[entry.value[i].legacyKey],
                      onChanged: (value) => setState(() => _values[entry.value[i].legacyKey] = value),
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
}

class _SettingControl extends StatelessWidget {
  const _SettingControl({
    required this.setting,
    required this.value,
    required this.onChanged,
  });

  final StatusBarSettingItem setting;
  final Object? value;
  final ValueChanged<Object?> onChanged;

  @override
  Widget build(BuildContext context) {
    switch (setting.controlType) {
      case StatusBarControlType.toggle:
        return SettingsRow(
          icon: Icons.toggle_on_rounded,
          iconColor: const Color(0xFF87EED8),
          title: setting.title,
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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SettingsRow(
              icon: Icons.tune_rounded,
              iconColor: const Color(0xFF8FCBFF),
              title: setting.title,
              subtitle: setting.subtitle,
              trailing: Text(current.toStringAsFixed(0), style: const TextStyle(color: Colors.white70)),
            ),
            Slider(
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
          title: setting.title,
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
          title: setting.title,
          subtitle: setting.subtitle,
          trailing: _ColorChip(
            hex: selected,
            onTap: () {
              final next = selected == '#FFFFFF' ? '#79E3CB' : '#FFFFFF';
              onChanged(next);
            },
          ),
        );
    }
  }

  Future<void> _showOptionPicker(BuildContext context, String current) async {
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
                child: Text(setting.title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
              ),
              for (final option in setting.options)
                ListTile(
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
}

class _ColorChip extends StatelessWidget {
  const _ColorChip({required this.hex, required this.onTap});

  final String hex;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _fromHex(hex),
              ),
            ),
            const SizedBox(width: 8),
            Text(hex, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Color _fromHex(String hex) {
    final value = hex.replaceAll('#', '');
    if (value.length == 6) {
      return Color(int.parse('FF$value', radix: 16));
    }
    return const Color(0xFF79E3CB);
  }
}
