import 'dart:async';

import 'package:deadzon/core/theme/deadzon_theme_controller.dart';
import 'package:deadzon/core/theme/design_tokens.dart';
import 'package:deadzon/core/widgets/glass_card.dart';
import 'package:deadzon/core/widgets/premium_top_bar.dart';
import 'package:deadzon/features/control_center/domain/control_center_config.dart';
import 'package:deadzon/features/control_center/services/control_center_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ControlCenterScreen extends StatefulWidget {
  const ControlCenterScreen({super.key});

  @override
  State<ControlCenterScreen> createState() => _ControlCenterScreenState();
}

class _ControlCenterScreenState extends State<ControlCenterScreen> {
  final ControlCenterService _service = ControlCenterService();
  ControlCenterConfig _config = ControlCenterConfig.defaults();
  bool _loading = true;
  Timer? _blurSaveDebounce;

  static const List<_StyleOption> _styles = <_StyleOption>[
    _StyleOption(0, 'Default'),
    _StyleOption(1, 'Style 1'),
    _StyleOption(2, 'Style 2'),
    _StyleOption(3, 'Style 3'),
    _StyleOption(4, 'Style 4'),
    _StyleOption(5, 'Style 5'),
    _StyleOption(7, 'Style 6'),
  ];

  static const List<_TileOption> _availableTiles = <_TileOption>[
    _TileOption('wifi', 'Wi-Fi', Icons.wifi_rounded),
    _TileOption('cell', 'Mobile Data', Icons.signal_cellular_alt_rounded),
    _TileOption('bluetooth', 'Bluetooth', Icons.bluetooth_rounded),
    _TileOption('flashlight', 'Flashlight', Icons.flashlight_on_rounded),
    _TileOption('rotation', 'Rotation', Icons.screen_rotation_alt_rounded),
    _TileOption('airplane', 'Airplane', Icons.airplanemode_active_rounded),
    _TileOption('hotspot', 'Hotspot', Icons.wifi_tethering_rounded),
    _TileOption('location', 'Location', Icons.location_on_rounded),
    _TileOption('battery', 'Battery Saver', Icons.battery_charging_full_rounded),
    _TileOption('dark_mode', 'Dark Mode', Icons.dark_mode_rounded),
    _TileOption('screen_record', 'Screen Record', Icons.fiber_manual_record_rounded),
    _TileOption('screenshot', 'Screenshot', Icons.photo_camera_rounded),
  ];

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  @override
  void dispose() {
    _blurSaveDebounce?.cancel();
    super.dispose();
  }

  Future<void> _loadConfig() async {
    final loaded = await _service.loadConfig();
    if (!mounted) return;
    setState(() {
      _config = loaded;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final accent = context.watch<DeadzonThemeController>().accentColor;
    final textColor = Theme.of(context).colorScheme.onSurface;

    final media = MediaQuery.of(context);

    return MediaQuery(
      data: media.copyWith(textScaler: const TextScaler.linear(1.0)),
      child: DefaultTextStyle.merge(
        style: const TextStyle(
          decoration: TextDecoration.none,
          decorationColor: Colors.transparent,
        ),
        child: Container(
          decoration: const BoxDecoration(gradient: DesignTokens.baseGradient),
          child: SafeArea(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                padding: DesignTokens.pagePadding.copyWith(bottom: 132),
                children: <Widget>[
                  const PremiumTopBar(
                    title: 'Control Center 13',
                    subtitle: 'CC big tiles customizations',
                  ),
                  const SizedBox(height: 16),
                  GlassCard(
                    onTap: _confirmSystemUiRefresh,
                    child: _PreferenceActionRow(
                      icon: Icons.restart_alt_rounded,
                      iconColor: accent,
                      title: 'Restart SystemUI',
                      subtitle: 'Click it to apply some changes',
                      trailing: const Icon(Icons.chevron_right_rounded),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GlassCard(
                    child: Column(
                      children: <Widget>[
                        _SwitchPreferenceRow(
                          icon: Icons.crop_square_rounded,
                          title: 'Square shaped toggles',
                          subtitle: _config.squareMezoTiles ? 'Enabled' : 'Disabled',
                          value: _config.squareMezoTiles,
                          accent: accent,
                          onChanged: _setSquareTiles,
                        ),
                        const _PreferenceDivider(),
                        _PreferenceActionRow(
                          icon: Icons.style_rounded,
                          iconColor: accent,
                          title: 'Control Center style',
                          subtitle: _selectedStyleLabel(),
                          trailing: const Icon(Icons.chevron_right_rounded),
                          onTap: _showStylePicker,
                        ),
                        const _PreferenceDivider(),
                        _ExtraTilesSection(
                          allTiles: _availableTiles,
                          selectedIds: _config.extraTwoMezoTiles,
                          accent: accent,
                          onToggle: _onTileToggle,
                        ),
                        const _PreferenceDivider(),
                        _BlurSeekbarRow(
                          value: _config.ccBlurRatio,
                          accent: accent,
                          onChanged: _setBlurRatio,
                          onChangeEnd: _saveBlurRatio,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  GlassCard(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _confirmReset,
                            child: const Text('Reset'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: FilledButton(
                            onPressed: _applyConfig,
                            child: const Text('Save'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Uses the original Mezo keys. Press Save to apply refresh safely.',
                    style: TextStyle(
                      color: textColor.withValues(alpha: 0.62),
                      fontSize: 12,
                      height: 1.35,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
          ),
        ),
      ),
    );
  }

  Future<void> _setSquareTiles(bool value) async {
    setState(() => _config = _config.copyWith(squareMezoTiles: value, lastUpdatedAt: DateTime.now()));
    await _persistLocalOnly();
  }

  Future<void> _showStylePicker() async {
    final current = _config.controlCenterStyle;
    final accent = context.read<DeadzonThemeController>().accentColor;
    final textColor = Theme.of(context).colorScheme.onSurface;
    final selected = await showModalBottomSheet<int>(
      context: context,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (BuildContext context) {
        return SafeArea(
          child: ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
            itemCount: _styles.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (BuildContext context, int index) {
              final style = _styles[index];
              final isSelected = style.value == current;
              return _SelectableSheetRow(
                label: style.label,
                isSelected: isSelected,
                accent: accent,
                textColor: textColor,
                onTap: () => Navigator.pop(context, style.value),
              );
            },
          ),
        );
      },
    );

    if (selected == null) return;
    setState(() => _config = _config.copyWith(controlCenterStyle: selected, lastUpdatedAt: DateTime.now()));
    await _persistLocalOnly();
  }

  Future<void> _onTileToggle(String id) async {
    final selected = List<String>.from(_config.extraTwoMezoTiles);
    if (selected.contains(id)) {
      if (selected.length <= 2) {
        _showMessage('Choose exactly two tiles. Select another tile before removing this one.');
        return;
      }
      selected.remove(id);
    } else {
      if (selected.length >= 2) {
        selected.removeAt(0);
      }
      selected.add(id);
    }

    setState(() => _config = _config.copyWith(extraTwoMezoTiles: selected.take(2).toList(), lastUpdatedAt: DateTime.now()));
    await _persistLocalOnly();
  }

  void _setBlurRatio(double value) {
    setState(() => _config = _config.copyWith(ccBlurRatio: value.round(), lastUpdatedAt: DateTime.now()));
    _blurSaveDebounce?.cancel();
    _blurSaveDebounce = Timer(const Duration(milliseconds: 350), () {
      _service.saveLocalConfig(_config);
    });
  }

  Future<void> _saveBlurRatio(double _) async {
    _blurSaveDebounce?.cancel();
    await _persistLocalOnly();
  }

  Future<void> _persistLocalOnly() async {
    await _service.saveLocalConfig(_config);
  }

  Future<void> _persistAndBroadcastStatusbar() async {
    await _service.saveConfig(_config);
    await _service.requestStatusbarRefresh();
  }

  Future<void> _confirmSystemUiRefresh() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Restart SystemUI'),
        content: const Text('Apply the current Control Center changes now?'),
        actions: <Widget>[
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Refresh')),
        ],
      ),
    );

    if (confirmed != true) return;
    await _service.requestSystemUiRefresh();
    if (!mounted) return;
    _showMessage('Refresh requested.');
  }

  Future<void> _applyConfig() async {
    await _persistAndBroadcastStatusbar();
    if (!mounted) return;
    _showMessage('Control Center changes saved.');
  }

  Future<void> _confirmReset() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Control Center'),
        content: const Text('Restore default tile shape, style, blur and extra tile configuration?'),
        actions: <Widget>[
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Reset')),
        ],
      ),
    );

    if (confirmed != true) return;
    final defaults = ControlCenterConfig.defaults();
    setState(() => _config = defaults);
    await _service.saveConfig(defaults);
    await _service.requestStatusbarRefresh();
    if (!mounted) return;
    _showMessage('Control Center defaults restored.');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  String _selectedStyleLabel() => _styles.firstWhere((e) => e.value == _config.controlCenterStyle, orElse: () => _styles.first).label;
}

class _PreferenceActionRow extends StatelessWidget {
  const _PreferenceActionRow({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;
    final content = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          radius: 22,
          backgroundColor: iconColor.withValues(alpha: 0.18),
          child: Icon(icon, color: iconColor),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: TextStyle(color: textColor, fontWeight: FontWeight.w800, fontSize: 16)),
              const SizedBox(height: 3),
              Text(subtitle, style: TextStyle(color: textColor.withValues(alpha: 0.7), height: 1.25)),
            ],
          ),
        ),
        if (trailing != null) ...<Widget>[
          const SizedBox(width: 10),
          trailing!,
        ],
      ],
    );

    if (onTap == null) return content;
    return GestureDetector(behavior: HitTestBehavior.opaque, onTap: onTap, child: content);
  }
}

class _SwitchPreferenceRow extends StatelessWidget {
  const _SwitchPreferenceRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.accent,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final Color accent;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return _PreferenceActionRow(
      icon: icon,
      iconColor: accent,
      title: title,
      subtitle: subtitle,
      trailing: Switch(value: value, onChanged: onChanged),
      onTap: () => onChanged(!value),
    );
  }
}

class _ExtraTilesSection extends StatelessWidget {
  const _ExtraTilesSection({
    required this.allTiles,
    required this.selectedIds,
    required this.accent,
    required this.onToggle,
  });

  final List<_TileOption> allTiles;
  final List<String> selectedIds;
  final Color accent;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text('Extra Two Tiles', style: TextStyle(color: textColor, fontWeight: FontWeight.w800, fontSize: 16)),
            ),
            Text('${selectedIds.length}/2', style: TextStyle(color: accent, fontWeight: FontWeight.w700)),
          ],
        ),
        const SizedBox(height: 3),
        Text('Selected: ${selectedIds.join(', ')}', style: TextStyle(color: textColor.withValues(alpha: 0.68))),
        const SizedBox(height: 12),
        GridView.builder(
          itemCount: allTiles.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.1,
          ),
          itemBuilder: (context, index) {
            final tile = allTiles[index];
            final selected = selectedIds.contains(tile.id);
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onToggle(tile.id),
              child: AnimatedContainer(
                duration: DesignTokens.motionFast,
                decoration: BoxDecoration(
                  color: selected ? accent.withValues(alpha: 0.22) : Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: selected ? accent.withValues(alpha: 0.72) : Colors.white.withValues(alpha: 0.2)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(tile.icon, size: 20, color: selected ? accent : textColor.withValues(alpha: 0.82)),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        tile.label,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 11, color: textColor, fontWeight: selected ? FontWeight.w800 : FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _BlurSeekbarRow extends StatelessWidget {
  const _BlurSeekbarRow({
    required this.value,
    required this.accent,
    required this.onChanged,
    required this.onChangeEnd,
  });

  final int value;
  final Color accent;
  final ValueChanged<double> onChanged;
  final ValueChanged<double> onChangeEnd;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            CircleAvatar(
              radius: 22,
              backgroundColor: accent.withValues(alpha: 0.18),
              child: Icon(Icons.blur_on_rounded, color: accent),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Control Center Blur', style: TextStyle(color: textColor, fontWeight: FontWeight.w800, fontSize: 16)),
                  const SizedBox(height: 3),
                  Text('Blur ratio on control center', style: TextStyle(color: textColor.withValues(alpha: 0.68))),
                ],
              ),
            ),
            Text('$value%', style: TextStyle(color: accent, fontWeight: FontWeight.w800)),
          ],
        ),
        Slider(
          min: 0,
          max: 100,
          divisions: 100,
          value: value.toDouble(),
          onChanged: onChanged,
          onChangeEnd: onChangeEnd,
        ),
      ],
    );
  }
}

class _SelectableSheetRow extends StatelessWidget {
  const _SelectableSheetRow({
    required this.label,
    required this.isSelected,
    required this.accent,
    required this.textColor,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final Color accent;
  final Color textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? accent.withValues(alpha: 0.78) : Colors.white.withValues(alpha: 0.12),
            width: isSelected ? 1.6 : 1.0,
          ),
          color: isSelected ? accent.withValues(alpha: 0.18) : Colors.white.withValues(alpha: 0.05),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                label,
                style: TextStyle(color: textColor, fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600),
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 160),
              child: isSelected
                  ? Icon(Icons.check_circle_rounded, key: ValueKey<String>('selected-$label'), color: accent)
                  : Icon(Icons.circle_outlined, key: ValueKey<String>('unselected-$label'), color: textColor.withValues(alpha: 0.45)),
            ),
          ],
        ),
      ),
    );
  }
}

class _PreferenceDivider extends StatelessWidget {
  const _PreferenceDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(height: 24, color: Theme.of(context).dividerColor);
  }
}

class _StyleOption {
  const _StyleOption(this.value, this.label);

  final int value;
  final String label;
}

class _TileOption {
  const _TileOption(this.id, this.label, this.icon);

  final String id;
  final String label;
  final IconData icon;
}
