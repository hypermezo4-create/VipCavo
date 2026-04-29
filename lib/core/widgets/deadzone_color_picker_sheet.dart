import 'package:deadzon/core/utils/deadzone_color_utils.dart';
import 'package:flutter/material.dart';

Future<int?> showDeadZoneColorPicker({
  required BuildContext context,
  required int initialArgb,
  required int defaultArgb,
  required String title,
}) {
  return showModalBottomSheet<int>(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) => DeadZoneColorPickerSheet(
      title: title,
      initialArgb: initialArgb,
      defaultArgb: defaultArgb,
    ),
  );
}

class DeadZoneColorPickerSheet extends StatefulWidget {
  const DeadZoneColorPickerSheet({
    required this.title,
    required this.initialArgb,
    required this.defaultArgb,
    super.key,
  });

  final String title;
  final int initialArgb;
  final int defaultArgb;

  @override
  State<DeadZoneColorPickerSheet> createState() => _DeadZoneColorPickerSheetState();
}

class _DeadZoneColorPickerSheetState extends State<DeadZoneColorPickerSheet> {
  late HSVColor _hsv;
  late double _alpha;
  late final TextEditingController _hex;

  @override
  void initState() {
    super.initState();
    final c = Color(widget.initialArgb);
    _hsv = HSVColor.fromColor(c.withAlpha(255));
    _alpha = c.a;
    _hex = TextEditingController(text: DeadzoneColorUtils.toArgbHex(widget.initialArgb));
  }

  @override
  void dispose() {
    _hex.dispose();
    super.dispose();
  }

  int get _argb => DeadzoneColorUtils.toArgb32(_hsv.toColor().withValues(alpha: _alpha));

  void _syncHex() => _hex.text = DeadzoneColorUtils.toArgbHex(_argb);

  @override
  Widget build(BuildContext context) {
    final color = Color(_argb);
    const presetColors = <int>[
      0x00000000,
      0xFFFF0000,
      0xFF00FF00,
      0xFF0000FF,
      0xFFFFFFFF,
      0xFF000000,
      0xFF00FFFF,
      0xFFFFA500,
    ];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xEE0A1721),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
      ),
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + MediaQuery.of(context).padding.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18)),
          const SizedBox(height: 12),
          _SvSquare(
            hsv: _hsv,
            onChanged: (h) {
              setState(() {
                _hsv = h;
                _syncHex();
              });
            },
          ),
          const SizedBox(height: 12),
          _HueSlider(
            hue: _hsv.hue,
            onChanged: (v) {
              setState(() {
                _hsv = _hsv.withHue(v);
                _syncHex();
              });
            },
          ),
          const SizedBox(height: 10),
          _AlphaSlider(
            color: _hsv.toColor(),
            alpha: _alpha,
            onChanged: (v) {
              setState(() {
                _alpha = v;
                _syncHex();
              });
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white24),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _hex,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: '#AARRGGBB',
                    labelStyle: TextStyle(color: Colors.white70),
                  ),
                  onSubmitted: (v) {
                    final parsed = DeadzoneColorUtils.parseHex(v, fallbackArgb: _argb);
                    final c = Color(parsed);
                    setState(() {
                      _hsv = HSVColor.fromColor(c.withAlpha(255));
                      _alpha = c.a;
                      _syncHex();
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: presetColors.map<Widget>((argb) {
              return GestureDetector(
                onTap: () {
                  final c = Color(argb);
                  setState(() {
                    _hsv = HSVColor.fromColor(c.withAlpha(255));
                    _alpha = c.a;
                    _syncHex();
                  });
                },
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Color(argb),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white54),
                  ),
                ),
              );
            }).toList(),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {
                final c = Color(widget.defaultArgb);
                setState(() {
                  _hsv = HSVColor.fromColor(c.withAlpha(255));
                  _alpha = c.a;
                  _syncHex();
                });
              },
              child: const Text('Reset to default'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(null),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton(
                  onPressed: () => Navigator.of(context).pop(_argb),
                  child: const Text('Apply'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SvSquare extends StatelessWidget {
  const _SvSquare({required this.hsv, required this.onChanged});

  final HSVColor hsv;
  final ValueChanged<HSVColor> onChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        return GestureDetector(
          onPanDown: (d) => _update(d.localPosition, c.biggest),
          onPanUpdate: (d) => _update(d.localPosition, c.biggest),
          child: Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  HSVColor.fromAHSV(1, hsv.hue, 1, 1).toColor(),
                ],
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _update(Offset p, Size s) {
    final sat = (p.dx / s.width).clamp(0.0, 1.0);
    final val = 1 - (p.dy / s.height).clamp(0.0, 1.0);
    onChanged(hsv.withSaturation(sat).withValue(val));
  }
}

class _HueSlider extends StatelessWidget {
  const _HueSlider({required this.hue, required this.onChanged});

  final double hue;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) => Slider(value: hue, min: 0, max: 360, onChanged: onChanged);
}

class _AlphaSlider extends StatelessWidget {
  const _AlphaSlider({required this.color, required this.alpha, required this.onChanged});

  final Color color;
  final double alpha;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) => Slider(value: alpha, min: 0, max: 1, onChanged: onChanged);
}
