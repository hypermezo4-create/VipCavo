import 'package:deadzon/features/mount/domain/mount_config.dart';
import 'package:deadzon/features/mount/domain/mount_palette.dart';
import 'package:deadzon/features/mount/presentation/widgets/mount_glass_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MountColorTab extends StatefulWidget {
  const MountColorTab({
    required this.config,
    required this.paletteLibrary,
    required this.wallpaperSets,
    required this.onSeedChanged,
    required this.onPaletteSelected,
    required this.onOpenSystemWallpaperStyle,
    required this.onPullWallpaperColors,
    required this.onToggleFavorite,
    required this.onResetColor,
    required this.onRandomColor,
    super.key,
  });

  final MountConfig config;
  final List<MountPalette> paletteLibrary;
  final List<WallpaperColorSet> wallpaperSets;
  final ValueChanged<Color> onSeedChanged;
  final ValueChanged<MountPalette> onPaletteSelected;
  final VoidCallback onOpenSystemWallpaperStyle;
  final VoidCallback onPullWallpaperColors;
  final ValueChanged<Color> onToggleFavorite;
  final VoidCallback onResetColor;
  final VoidCallback onRandomColor;

  @override
  State<MountColorTab> createState() => _MountColorTabState();
}

class _MountColorTabState extends State<MountColorTab> {
  late final TextEditingController _hexController;

  @override
  void initState() {
    super.initState();
    _hexController = TextEditingController(text: widget.config.selectedColorHex);
  }

  @override
  void didUpdateWidget(covariant MountColorTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.config.selectedColorHex != widget.config.selectedColorHex) {
      _hexController.text = widget.config.selectedColorHex;
    }
  }

  @override
  void dispose() {
    _hexController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.config.selectedSeedColor;
    final hsv = HSVColor.fromColor(color);
    final favorite = widget.config.favoriteColors.contains(color.toARGB32());

    return Column(
      children: <Widget>[
        MountGlassCard(
          tint: color,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            const Text('Internal DeadZon Monet Engine', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            Row(children: <Widget>[
              Container(width: 44, height: 44, decoration: BoxDecoration(color: color, shape: BoxShape.circle, border: Border.all(color: Colors.white70))),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _hexController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(labelText: 'Hex', hintText: '#79E3CB'),
                  onSubmitted: (value) {
                    final parsed = _fromHex(value);
                    if (parsed != null) widget.onSeedChanged(parsed);
                  },
                ),
              ),
              IconButton(onPressed: () => Clipboard.setData(ClipboardData(text: widget.config.selectedColorHex)), icon: const Icon(Icons.copy_rounded, color: Colors.white)),
              IconButton(onPressed: () => widget.onToggleFavorite(color), icon: Icon(favorite ? Icons.favorite_rounded : Icons.favorite_outline_rounded, color: Colors.white)),
            ]),
            _rgbSlider('R', color.red.toDouble(), (v) => widget.onSeedChanged(Color.fromARGB(255, v.round(), color.green, color.blue))),
            _rgbSlider('G', color.green.toDouble(), (v) => widget.onSeedChanged(Color.fromARGB(255, color.red, v.round(), color.blue))),
            _rgbSlider('B', color.blue.toDouble(), (v) => widget.onSeedChanged(Color.fromARGB(255, color.red, color.green, v.round()))),
            _hsvSlider('H', hsv.hue, 360, (v) => widget.onSeedChanged(hsv.withHue(v).toColor())),
            _hsvSlider('S', hsv.saturation, 1, (v) => widget.onSeedChanged(hsv.withSaturation(v).toColor())),
            _hsvSlider('V', hsv.value, 1, (v) => widget.onSeedChanged(hsv.withValue(v).toColor())),
            const SizedBox(height: 8),
            Row(children: <Widget>[
              Expanded(child: OutlinedButton(onPressed: widget.onResetColor, child: const Text('Reset color'))),
              const SizedBox(width: 10),
              Expanded(child: OutlinedButton(onPressed: widget.onRandomColor, child: const Text('Random color'))),
            ]),

            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: widget.config.recentColors
                  .map((value) => GestureDetector(
                        onTap: () => widget.onSeedChanged(Color(value)),
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(color: Color(value), shape: BoxShape.circle, border: Border.all(color: Colors.white38)),
                        ),
                      ))
                  .toList(),
            ),
            if (widget.config.favoriteColors.isNotEmpty) ...[
              const SizedBox(height: 6),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: widget.config.favoriteColors
                    .map((value) => GestureDetector(
                          onTap: () => widget.onSeedChanged(Color(value)),
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(color: Color(value), shape: BoxShape.circle, border: Border.all(color: Colors.white70)),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ]),
        ),
        const SizedBox(height: 12),
        MountGlassCard(
          tint: color,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            const Text('Palette Library', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.paletteLibrary
                  .map((p) => FilterChip(
                        selected: widget.config.selectedPaletteId == p.id,
                        label: Text(p.name),
                        onSelected: (_) => widget.onPaletteSelected(p),
                        selectedColor: p.primary.withValues(alpha: 0.35),
                        backgroundColor: Colors.white.withValues(alpha: 0.08),
                        labelStyle: const TextStyle(color: Colors.white),
                      ))
                  .toList(),
            ),
          ]),
        ),
        const SizedBox(height: 12),
        MountGlassCard(
          tint: color,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            const Text('Material You tonal chips', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            ...widget.config.generatedPalettes.entries.map((entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(entry.key, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: entry.value.entries
                          .map((tone) => Container(
                                width: 34,
                                height: 34,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(color: Color(tone.value), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white24)),
                                child: Text(tone.key, style: const TextStyle(color: Colors.black, fontSize: 8, fontWeight: FontWeight.w700)),
                              ))
                          .toList(),
                    ),
                  ]),
                )),
          ]),
        ),
        const SizedBox(height: 12),
        MountGlassCard(
          tint: color,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            const Text('Wallpaper extraction', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            ...widget.wallpaperSets.map((set) {
              if (!set.available) {
                return Text(set.message ?? 'Wallpaper colors are not available on this ROM.', style: const TextStyle(color: Colors.white70));
              }
              return Row(children: [
                SizedBox(width: 52, child: Text(set.source.toUpperCase(), style: const TextStyle(color: Colors.white70, fontSize: 12))),
                _dot(set.primary),
                _dot(set.secondary),
                _dot(set.tertiary),
              ]);
            }),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(child: OutlinedButton(onPressed: widget.onPullWallpaperColors, child: const Text('Refresh wallpaper colors'))),
              const SizedBox(width: 8),
              Expanded(child: FilledButton(onPressed: widget.onOpenSystemWallpaperStyle, child: const Text('Open system Wallpaper & Style'))),
            ]),
          ]),
        ),
      ],
    );
  }

  Widget _dot(Color? color) => Container(
        width: 18,
        height: 18,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: color ?? Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white54),
        ),
      );

  Widget _rgbSlider(String label, double value, ValueChanged<double> onChanged) => Row(children: [
        SizedBox(width: 20, child: Text(label, style: const TextStyle(color: Colors.white70))),
        Expanded(child: Slider(min: 0, max: 255, value: value, onChanged: onChanged)),
        SizedBox(width: 28, child: Text(value.round().toString(), style: const TextStyle(color: Colors.white70, fontSize: 11))),
      ]);

  Widget _hsvSlider(String label, double value, double max, ValueChanged<double> onChanged) => Row(children: [
        SizedBox(width: 20, child: Text(label, style: const TextStyle(color: Colors.white70))),
        Expanded(child: Slider(min: 0, max: max, value: value.clamp(0, max), onChanged: onChanged)),
      ]);

  Color? _fromHex(String raw) {
    final hex = raw.replaceAll('#', '').trim();
    if (hex.length != 6) return null;
    final value = int.tryParse(hex, radix: 16);
    if (value == null) return null;
    return Color(0xFF000000 | value);
  }
}
