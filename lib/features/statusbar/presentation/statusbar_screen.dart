import 'package:deadzon/core/widgets/glass_card.dart';
import 'package:deadzon/core/widgets/premium_top_bar.dart';
import 'package:deadzon/core/widgets/section_header.dart';
import 'package:deadzon/core/widgets/settings_row.dart';
import 'package:deadzon/features/statusbar/helper.dart';
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
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Color(0xFF14303A), Color(0xFF10232B), Color(0xFF0A1419)],
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 120),
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
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sections.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.05,
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
                        section.previewLabel ?? 'Customize',
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 12),
                      ),
                    ],
                  ),
                )
                    .animate(delay: (45 * index).ms)
                    .fadeIn(duration: 260.ms)
                    .scale(begin: const Offset(0.96, 0.96), end: const Offset(1, 1));
              },
            ),
          ],
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
        children: <Widget>[
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SectionHeader(title: widget.section.title, subtitle: widget.section.subtitle),
                const SizedBox(height: 8),
                Text(
                  'Reference: ${widget.section.sourceXmlReference ?? 'n/a'}',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.68), fontSize: 12),
                ),
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
            onChanged: onChanged,
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
        return SettingsRow(
          icon: Icons.view_list_rounded,
          iconColor: const Color(0xFF9FAAFF),
          title: setting.title,
          subtitle: setting.subtitle,
          trailing: DropdownButton<String>(
            value: current,
            dropdownColor: const Color(0xFF12242B),
            underline: const SizedBox.shrink(),
            items: setting.options
                .map((option) => DropdownMenuItem<String>(value: option.value, child: Text(option.label)))
                .toList(),
            onChanged: (v) {
              if (v != null) onChanged(v);
            },
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

class _StatusPreviewCard extends StatelessWidget {
  const _StatusPreviewCard();

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
          Container(
            height: 96,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.black.withValues(alpha: 0.28),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: const Row(
              children: <Widget>[
                Text('09:15', style: TextStyle(color: Color(0xFF89F3A0), fontWeight: FontWeight.w700)),
                SizedBox(width: 8),
                Text('22 Apr', style: TextStyle(color: Color(0xFFB7C6FF), fontWeight: FontWeight.w500)),
                Spacer(),
                Icon(Icons.speed_rounded, color: Color(0xFF8DE8FF), size: 18),
                SizedBox(width: 6),
                Icon(Icons.signal_cellular_alt_rounded, color: Colors.white70),
                SizedBox(width: 6),
                Icon(Icons.wifi_rounded, color: Colors.white70),
                SizedBox(width: 6),
                Icon(Icons.battery_5_bar_rounded, color: Color(0xFF90FFAC)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
