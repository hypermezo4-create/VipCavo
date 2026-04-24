import 'dart:ui';

import 'package:deadzon/core/theme/deadzon_theme_controller.dart';
import 'package:deadzon/core/theme/design_tokens.dart';
import 'package:deadzon/core/widgets/glass_card.dart';
import 'package:deadzon/core/widgets/premium_top_bar.dart';
import 'package:deadzon/core/widgets/section_header.dart';
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

  static const List<_StyleOption> _styles = <_StyleOption>[
    _StyleOption(0, 'Default'),
    _StyleOption(1, 'Compact'),
    _StyleOption(2, 'Rounded'),
    _StyleOption(3, 'iOS Glass'),
    _StyleOption(4, 'Minimal'),
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

    return Container(
      decoration: const BoxDecoration(gradient: DesignTokens.baseGradient),
      child: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                padding: DesignTokens.pagePadding,
                children: <Widget>[
                  const PremiumTopBar(
                    title: 'Control Center',
                    subtitle: 'Quick toggles, tile shape, style and blur tuning',
                  ),
                  const SizedBox(height: 16),
                  const SectionHeader(title: 'Live preview', subtitle: 'Reactive quick tile board with Mount accent sync'),
                  const SizedBox(height: 8),
                  RepaintBoundary(
                    child: _ControlCenterPreview(config: _config, accent: accent),
                  ),
                  const SizedBox(height: 14),
                  GlassCard(
                    onTap: _confirmSystemUiRefresh,
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: accent.withValues(alpha: 0.2),
                        child: Icon(Icons.restart_alt_rounded, color: accent),
                      ),
                      title: Text('Restart SystemUI', style: TextStyle(color: textColor, fontWeight: FontWeight.w700)),
                      subtitle: Text('Refresh system interface after changes', style: TextStyle(color: textColor.withValues(alpha: 0.72))),
                      trailing: const Icon(Icons.chevron_right_rounded),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const SectionHeader(title: 'Behavior', subtitle: 'ROM keys preserved for bridge wiring'),
                  const SizedBox(height: 8),
                  GlassCard(
                    child: Column(
                      children: <Widget>[
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text('Square tiles', style: TextStyle(color: textColor, fontWeight: FontWeight.w700)),
                          subtitle: Text('square_mezo_tiles', style: TextStyle(color: textColor.withValues(alpha: 0.7))),
                          value: _config.squareMezoTiles,
                          onChanged: (bool value) {
                            setState(() => _config = _config.copyWith(squareMezoTiles: value, lastUpdatedAt: DateTime.now()));
                            _persistAndBroadcastStatusbar();
                          },
                        ),
                        const Divider(height: 18),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text('Control center style', style: TextStyle(color: textColor, fontWeight: FontWeight.w700)),
                          subtitle: Text('swap_tiles_1 • ${_selectedStyleLabel()}', style: TextStyle(color: textColor.withValues(alpha: 0.7))),
                          trailing: const Icon(Icons.tune_rounded),
                          onTap: _showStylePicker,
                        ),
                        const Divider(height: 18),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Extra two tiles • extra_two_mezo_tiles', style: TextStyle(color: textColor, fontWeight: FontWeight.w700)),
                        ),
                        const SizedBox(height: 10),
                        _ExtraTilesGrid(
                          allTiles: _availableTiles,
                          selectedIds: _config.extraTwoMezoTiles,
                          accent: accent,
                          onToggle: _onTileToggle,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text('Blur ratio • cc_blur_ratio', style: TextStyle(color: textColor, fontWeight: FontWeight.w700)),
                            ),
                            Text('${_config.ccBlurRatio}%', style: TextStyle(color: textColor.withValues(alpha: 0.78))),
                          ],
                        ),
                        Slider(
                          min: 0,
                          max: 100,
                          divisions: 100,
                          value: _config.ccBlurRatio.toDouble(),
                          onChanged: (double value) {
                            setState(() => _config = _config.copyWith(ccBlurRatio: value.round(), lastUpdatedAt: DateTime.now()));
                          },
                          onChangeEnd: (_) => _service.saveConfig(_config),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
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
                            child: const Text('Apply'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
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
              return _buildStylePickerRow(
                style: style,
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
    await _persistAndBroadcastStatusbar();
  }

  Widget _buildStylePickerRow({
    required _StyleOption style,
    required bool isSelected,
    required Color accent,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
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
                style.label,
                style: TextStyle(
                  color: textColor,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                ),
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 160),
              child: isSelected
                  ? Icon(Icons.check_circle_rounded, key: ValueKey<int>(style.value), color: accent)
                  : Icon(Icons.circle_outlined, key: ValueKey<String>('unselected-${style.value}'), color: textColor.withValues(alpha: 0.45)),
            ),
          ],
        ),
      ),
    );
  }

  void _onTileToggle(String id) {
    final selected = List<String>.from(_config.extraTwoMezoTiles);
    if (selected.contains(id)) {
      selected.remove(id);
    } else {
      if (selected.length >= 2) {
        selected.removeAt(0);
      }
      selected.add(id);
    }

    setState(() => _config = _config.copyWith(extraTwoMezoTiles: selected, lastUpdatedAt: DateTime.now()));
    _service.saveConfig(_config);
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
        content: const Text('Request a SystemUI refresh now? This sends a safe broadcast only.'),
        actions: <Widget>[
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Refresh')),
        ],
      ),
    );

    if (confirmed != true) return;
    final ok = await _service.requestSystemUiRefresh();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(ok ? 'SystemUI refresh requested.' : 'SystemUI refresh requested.')),
    );
  }

  Future<void> _applyConfig() async {
    await _service.saveConfig(_config);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Control Center config saved for ROM bridge.'), behavior: SnackBarBehavior.floating),
    );
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
  }

  String _selectedStyleLabel() => _styles.firstWhere((e) => e.value == _config.controlCenterStyle, orElse: () => _styles.first).label;
}

class _ControlCenterPreview extends StatelessWidget {
  const _ControlCenterPreview({required this.config, required this.accent});

  final ControlCenterConfig config;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;
    final shape = switch (config.controlCenterStyle) {
      1 => 14.0,
      2 => 26.0,
      3 => 22.0,
      4 => 10.0,
      _ => config.squareMezoTiles ? 12.0 : 20.0,
    };
    final blur = (config.ccBlurRatio / 100) * 10;
    final opacity = 0.14 + (config.ccBlurRatio / 100) * 0.22;

    final baseTiles = <_TileOption>[
      _ControlCenterScreenState._availableTiles.firstWhere((e) => e.id == 'wifi'),
      _ControlCenterScreenState._availableTiles.firstWhere((e) => e.id == 'cell'),
      _ControlCenterScreenState._availableTiles.firstWhere((e) => e.id == 'bluetooth'),
      _ControlCenterScreenState._availableTiles.firstWhere((e) => e.id == 'flashlight'),
      _ControlCenterScreenState._availableTiles.firstWhere((e) => e.id == 'rotation'),
      _ControlCenterScreenState._availableTiles.firstWhere((e) => e.id == 'airplane'),
      ...config.extraTwoMezoTiles
          .map((id) => _ControlCenterScreenState._availableTiles.firstWhere((e) => e.id == id, orElse: () => _ControlCenterScreenState._availableTiles.first)),
    ];

    return GlassCard(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: accent.withValues(alpha: opacity)),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: baseTiles.take(8).map((tile) {
                return SizedBox(
                  width: 74,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(config.squareMezoTiles ? 12 : shape),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.26)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(tile.icon, color: textColor),
                          const SizedBox(height: 6),
                          Text(
                            tile.label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: textColor, fontSize: 11, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class _ExtraTilesGrid extends StatelessWidget {
  const _ExtraTilesGrid({
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
    return GridView.builder(
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
        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => onToggle(tile.id),
          child: AnimatedContainer(
            duration: DesignTokens.motionFast,
            decoration: BoxDecoration(
              color: selected ? accent.withValues(alpha: 0.22) : Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: selected ? accent.withValues(alpha: 0.7) : Colors.white.withValues(alpha: 0.2)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(tile.icon, size: 20, color: selected ? accent : textColor),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    tile.label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 11, color: textColor, fontWeight: selected ? FontWeight.w700 : FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
