import 'package:deadzon/core/theme/deadzon_theme_controller.dart';
import 'package:deadzon/core/theme/design_tokens.dart';
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
  bool _saving = false;

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
    final currentMedia = MediaQuery.of(context);

    return MediaQuery(
      data: currentMedia.copyWith(textScaler: TextScaler.noScaling),
      child: DefaultTextStyle.merge(
        style: const TextStyle(decoration: TextDecoration.none),
        child: Container(
          decoration: const BoxDecoration(gradient: DesignTokens.baseGradient),
          child: SafeArea(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    padding: DesignTokens.pagePadding.copyWith(bottom: 132),
                    children: <Widget>[
                      const _ScreenHeader(),
                      const SizedBox(height: 18),
                      _RestartCard(onTap: _confirmSystemUiRefresh),
                      const SizedBox(height: 14),
                      _ControlPanel(
                        config: _config,
                        styleLabel: _selectedStyleLabel(),
                        tiles: _availableTiles,
                        onSquareChanged: _setSquareTiles,
                        onOpenStyle: _showStylePicker,
                        onTileToggle: _onTileToggle,
                        onBlurChanged: _setBlurRatio,
                      ),
                      const SizedBox(height: 14),
                      _BottomActions(
                        saving: _saving,
                        onReset: _confirmReset,
                        onSave: _applyConfig,
                      ),
                      const SizedBox(height: 10),
                      const _Footnote(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  void _setSquareTiles(bool value) {
    setState(() {
      _config = _config.copyWith(squareMezoTiles: value, lastUpdatedAt: DateTime.now());
    });
    _service.saveConfig(_config);
  }

  Future<void> _showStylePicker() async {
    final current = _config.controlCenterStyle;
    final accent = context.read<DeadzonThemeController>().accentColor;
    final selected = await showModalBottomSheet<int>(
      context: context,
      showDragHandle: true,
      backgroundColor: const Color(0xFF10252B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (BuildContext context) {
        final media = MediaQuery.of(context);
        return MediaQuery(
          data: media.copyWith(textScaler: TextScaler.noScaling),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 4, 18, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Control Center style',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 12),
                  for (final style in _styles) ...<Widget>[
                    _StylePickerRow(
                      label: style.label,
                      isSelected: style.value == current,
                      accent: accent,
                      onTap: () => Navigator.of(context).maybePop( style.value),
                    ),
                    const SizedBox(height: 8),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );

    if (selected == null) return;
    setState(() {
      _config = _config.copyWith(controlCenterStyle: selected, lastUpdatedAt: DateTime.now());
    });
    await _service.saveConfig(_config);
  }

  Future<void> _onTileToggle(String id) async {
    final selected = List<String>.from(_config.extraTwoMezoTiles);
    if (selected.contains(id)) {
      if (selected.length <= 2) {
        _showMessage('Select another tile first, then remove this one.');
        return;
      }
      selected.remove(id);
    } else {
      if (selected.length >= 2) {
        selected.removeAt(0);
      }
      selected.add(id);
    }

    setState(() {
      _config = _config.copyWith(extraTwoMezoTiles: selected.take(2).toList(), lastUpdatedAt: DateTime.now());
    });
    await _service.saveConfig(_config);
  }

  void _setBlurRatio(double value) {
    setState(() {
      _config = _config.copyWith(ccBlurRatio: value.round(), lastUpdatedAt: DateTime.now());
    });
    _service.saveConfig(_config);
  }

  Future<void> _confirmSystemUiRefresh() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Restart SystemUI'),
        content: const Text('Send the original Mezo refresh action now?'),
        actions: <Widget>[
          TextButton(onPressed: () => Navigator.of(context).maybePop( false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.of(context).maybePop( true), child: const Text('Refresh')),
        ],
      ),
    );

    if (confirmed != true) return;
    final sent = await _service.requestSystemUiRefresh();
    if (!mounted) return;
    _showMessage(sent ? 'SystemUI refresh requested.' : 'Saved locally. Refresh bridge is not available.');
  }

  Future<void> _applyConfig() async {
    if (_saving) return;
    setState(() => _saving = true);
    final applied = await _service.saveAndApplyConfig(_config);
    if (!mounted) return;
    setState(() => _saving = false);
    _showMessage(applied ? 'Saved and refresh requested.' : 'Saved locally. Native bridge is not available.');
  }

  Future<void> _confirmReset() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Control Center'),
        content: const Text('Restore the original Mezo defaults?'),
        actions: <Widget>[
          TextButton(onPressed: () => Navigator.of(context).maybePop( false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.of(context).maybePop( true), child: const Text('Reset')),
        ],
      ),
    );

    if (confirmed != true) return;
    final defaults = ControlCenterConfig.defaults();
    setState(() => _config = defaults);
    await _service.saveConfig(defaults);
    if (!mounted) return;
    _showMessage('Defaults restored. Press Save to apply.');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  String _selectedStyleLabel() => _styles.firstWhere((e) => e.value == _config.controlCenterStyle, orElse: () => _styles.first).label;
}

class _ScreenHeader extends StatelessWidget {
  const _ScreenHeader();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Control Center 13',
          style: TextStyle(
            color: Colors.white,
            fontSize: 34,
            height: 1.05,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.2,
            decoration: TextDecoration.none,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'CC big tiles customizations',
          style: TextStyle(
            color: Color(0xCCFFFFFF),
            fontSize: 17,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.none,
          ),
        ),
      ],
    );
  }
}

class _RestartCard extends StatelessWidget {
  const _RestartCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _GlassPanel(
      padding: const EdgeInsets.all(18),
      onTap: onTap,
      child: const Row(
        children: <Widget>[
          _RoundIcon(icon: Icons.restart_alt_rounded, color: Color(0xFFFF6370)),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Restart SystemUI',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Click it to apply some changes',
                  style: TextStyle(
                    color: Color(0xBFFFFFFF),
                    fontSize: 14,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: Colors.white, size: 26),
        ],
      ),
    );
  }
}

class _ControlPanel extends StatelessWidget {
  const _ControlPanel({
    required this.config,
    required this.styleLabel,
    required this.tiles,
    required this.onSquareChanged,
    required this.onOpenStyle,
    required this.onTileToggle,
    required this.onBlurChanged,
  });

  final ControlCenterConfig config;
  final String styleLabel;
  final List<_TileOption> tiles;
  final ValueChanged<bool> onSquareChanged;
  final VoidCallback onOpenStyle;
  final ValueChanged<String> onTileToggle;
  final ValueChanged<double> onBlurChanged;

  @override
  Widget build(BuildContext context) {
    return _GlassPanel(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SquareTilesRow(value: config.squareMezoTiles, onChanged: onSquareChanged),
          const _SoftDivider(),
          _StyleRow(styleLabel: styleLabel, onTap: onOpenStyle),
          const _SoftDivider(),
          _ExtraTilesPicker(
            selectedIds: config.extraTwoMezoTiles,
            tiles: tiles,
            onToggle: onTileToggle,
          ),
          const _SoftDivider(),
          _BlurRow(value: config.ccBlurRatio, onChanged: onBlurChanged),
        ],
      ),
    );
  }
}

class _SquareTilesRow extends StatelessWidget {
  const _SquareTilesRow({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const _RoundIcon(icon: Icons.crop_square_rounded, color: Color(0xFFFF6370)),
        const SizedBox(width: 16),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Square shaped toggles',
                style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w900, decoration: TextDecoration.none),
              ),
              SizedBox(height: 4),
              Text(
                'Old key: square_mezo_tiles',
                style: TextStyle(color: Color(0x99FFFFFF), fontSize: 12, decoration: TextDecoration.none),
              ),
            ],
          ),
        ),
        Switch(value: value, onChanged: onChanged),
      ],
    );
  }
}

class _StyleRow extends StatelessWidget {
  const _StyleRow({required this.styleLabel, required this.onTap});

  final String styleLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: <Widget>[
            const _RoundIcon(icon: Icons.style_rounded, color: Color(0xFFFF6370)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Control Center style',
                    style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w900, decoration: TextDecoration.none),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    styleLabel,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Color(0xCCFFFFFF), fontSize: 14, decoration: TextDecoration.none),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: Colors.white, size: 26),
          ],
        ),
      ),
    );
  }
}

class _ExtraTilesPicker extends StatelessWidget {
  const _ExtraTilesPicker({required this.selectedIds, required this.tiles, required this.onToggle});

  final List<String> selectedIds;
  final List<_TileOption> tiles;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Extra Two Tiles',
                    style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w900, decoration: TextDecoration.none),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Select exactly two tiles',
                    style: TextStyle(color: Color(0x99FFFFFF), fontSize: 12, decoration: TextDecoration.none),
                  ),
                ],
              ),
            ),
            Text(
              '${selectedIds.length}/2',
              style: const TextStyle(color: Color(0xFFFF6370), fontSize: 24, fontWeight: FontWeight.w900, decoration: TextDecoration.none),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'Selected: ${selectedIds.join(', ')}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Color(0xCCFFFFFF), fontSize: 13, fontWeight: FontWeight.w700, decoration: TextDecoration.none),
        ),
        const SizedBox(height: 14),
        GridView.builder(
          itemCount: tiles.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.05,
          ),
          itemBuilder: (context, index) {
            final tile = tiles[index];
            final selected = selectedIds.contains(tile.id);
            return _TileCard(tile: tile, selected: selected, onTap: () => onToggle(tile.id));
          },
        ),
      ],
    );
  }
}

class _TileCard extends StatelessWidget {
  const _TileCard({required this.tile, required this.selected, required this.onTap});

  final _TileOption tile;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? const Color(0xFFFF6370) : Colors.white;
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: AnimatedContainer(
        duration: DesignTokens.motionFast,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: selected ? const Color(0x33FF6370) : Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: selected ? const Color(0xFFFF6370) : Colors.white.withValues(alpha: 0.18), width: selected ? 1.5 : 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(tile.icon, color: color, size: 22),
            const SizedBox(height: 8),
            Text(
              tile.label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: selected ? Colors.white : const Color(0xD9FFFFFF), fontSize: 12, height: 1.15, fontWeight: selected ? FontWeight.w800 : FontWeight.w600, decoration: TextDecoration.none),
            ),
          ],
        ),
      ),
    );
  }
}

class _BlurRow extends StatelessWidget {
  const _BlurRow({required this.value, required this.onChanged});

  final int value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const _RoundIcon(icon: Icons.blur_on_rounded, color: Color(0xFFFF6370)),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Control Center Blur',
                    style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w900, decoration: TextDecoration.none),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Old key: cc_blur_ratio',
                    style: TextStyle(color: Color(0x99FFFFFF), fontSize: 12, decoration: TextDecoration.none),
                  ),
                ],
              ),
            ),
            Text(
              '$value%',
              style: const TextStyle(color: Color(0xFFFF6370), fontSize: 22, fontWeight: FontWeight.w900, decoration: TextDecoration.none),
            ),
          ],
        ),
        Slider(
          min: 0,
          max: 100,
          divisions: 100,
          value: value.clamp(0, 100).toDouble(),
          activeColor: const Color(0xFFFF6370),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _BottomActions extends StatelessWidget {
  const _BottomActions({required this.saving, required this.onReset, required this.onSave});

  final bool saving;
  final VoidCallback onReset;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return _GlassPanel(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: OutlinedButton(
              onPressed: saving ? null : onReset,
              child: const Text('Reset'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: FilledButton(
              onPressed: saving ? null : onSave,
              child: Text(saving ? 'Saving…' : 'Save'),
            ),
          ),
        ],
      ),
    );
  }
}

class _Footnote extends StatelessWidget {
  const _Footnote();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Uses the original Mezo keys. Press Save to apply refresh safely.',
      style: TextStyle(
        color: Color(0x99FFFFFF),
        fontSize: 12,
        height: 1.35,
        decoration: TextDecoration.none,
      ),
    );
  }
}

class _GlassPanel extends StatelessWidget {
  const _GlassPanel({required this.child, this.padding = const EdgeInsets.all(16), this.onTap});

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final panel = AnimatedContainer(
      duration: DesignTokens.motionFast,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.075),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withValues(alpha: 0.54), width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 24, offset: const Offset(0, 14)),
        ],
      ),
      child: child,
    );

    if (onTap == null) return panel;
    return InkWell(borderRadius: BorderRadius.circular(28), onTap: onTap, child: panel);
  }
}

class _RoundIcon extends StatelessWidget {
  const _RoundIcon({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(color: color.withValues(alpha: 0.18), shape: BoxShape.circle),
      child: Icon(icon, color: color, size: 24),
    );
  }
}

class _SoftDivider extends StatelessWidget {
  const _SoftDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      height: 1,
      color: Colors.white.withValues(alpha: 0.12),
    );
  }
}

class _StylePickerRow extends StatelessWidget {
  const _StylePickerRow({required this.label, required this.isSelected, required this.accent, required this.onTap});

  final String label;
  final bool isSelected;
  final Color accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: isSelected ? accent : Colors.white.withValues(alpha: 0.12), width: isSelected ? 1.5 : 1),
          color: isSelected ? accent.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.05),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800, decoration: TextDecoration.none),
              ),
            ),
            Icon(isSelected ? Icons.check_circle_rounded : Icons.circle_outlined, color: isSelected ? accent : Colors.white54),
          ],
        ),
      ),
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
