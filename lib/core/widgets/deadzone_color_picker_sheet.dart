import 'package:deadzon/core/utils/deadzone_color_utils.dart';
import 'package:flutter/material.dart';

Future<int?> showDeadZoneColorPicker({
  required BuildContext context,
  required int initialArgb,
  required int defaultArgb,
  required String title,
}) async {
  return showModalBottomSheet<int>(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) {
      return DeadZoneColorPickerSheet(
        title: title,
        initialArgb: initialArgb,
        defaultArgb: defaultArgb,
      );
    },
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
  static const List<int> _presetColors = <int>[
    0x00000000,
    0xFFFF0000,
    0xFF00FF00,
    0xFF0000FF,
    0xFFFFFFFF,
    0xFF000000,
    0xFF00FFFF,
    0xFFFFA500,
  ];

  late HSVColor _hsv;
  late double _alpha;
  late final TextEditingController _hexController;

  @override
  void initState() {
    super.initState();
    final color = Color(widget.initialArgb);
    _hsv = HSVColor.fromColor(color.withAlpha(255));
    _alpha = color.a;
    _hexController = TextEditingController(text: DeadzoneColorUtils.toArgbHex(widget.initialArgb));
  }

  @override
  void dispose() {
    _hexController.dispose();
    super.dispose();
  }

  int get _selectedArgb => DeadzoneColorUtils.toArgb32(_hsv.toColor().withValues(alpha: _alpha));

  void _syncHex() {
    _hexController.text = DeadzoneColorUtils.toArgbHex(_selectedArgb);
  }

  void _setFromArgb(int argb) {
    final color = Color(argb);
    setState(() {
      _hsv = HSVColor.fromColor(color.withAlpha(255));
      _alpha = color.a;
      _syncHex();
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedColor = Color(_selectedArgb);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xEE0A1721),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
      ),
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + MediaQuery.of(context).padding.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(widget.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18)),
          const SizedBox(height: 12),
          _SvSquare(
            hsv: _hsv,
            onChanged: (next) {
              setState(() {
                _hsv = next;
                _syncHex();
              });
            },
          ),
          const SizedBox(height: 12),
          _HueSlider(
            hue: _hsv.hue,
            onChanged: (value) {
              setState(() {
                _hsv = _hsv.withHue(value);
                _syncHex();
              });
            },
          ),
          const SizedBox(height: 10),
          _AlphaSlider(
            alpha: _alpha,
            onChanged: (value) {
              setState(() {
                _alpha = value;
                _syncHex();
              });
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: selectedColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white24),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _hexController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: '#AARRGGBB',
                    labelStyle: TextStyle(color: Colors.white70),
                  ),
                  onSubmitted: (value) => _setFromArgb(DeadzoneColorUtils.parseHex(value, fallbackArgb: _selectedArgb)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _presetColors.map<Widget>((argb) {
              return GestureDetector(
                onTap: () => _setFromArgb(argb),
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Color(argb),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _selectedArgb == argb ? Colors.white : Colors.white54,
                      width: _selectedArgb == argb ? 2 : 1,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () => _setFromArgb(widget.defaultArgb),
              child: const Text('Reset to default'),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(null),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton(
                  onPressed: () => Navigator.of(context).pop(_selectedArgb),
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
      builder: (context, constraints) {
        return GestureDetector(
          onPanDown: (details) => _update(details.localPosition, constraints.biggest),
          onPanUpdate: (details) => _update(details.localPosition, constraints.biggest),
          child: Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: LinearGradient(colors: <Color>[Colors.white, HSVColor.fromAHSV(1, hsv.hue, 1, 1).toColor()]),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Colors.transparent, Colors.black],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _update(Offset position, Size size) {
    final saturation = (position.dx / size.width).clamp(0.0, 1.0);
    final value = 1 - (position.dy / size.height).clamp(0.0, 1.0);
    onChanged(hsv.withSaturation(saturation).withValue(value));
  }
}

class _HueSlider extends StatelessWidget {
  const _HueSlider({required this.hue, required this.onChanged});

  final double hue;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Slider(value: hue, min: 0, max: 360, onChanged: onChanged);
  }
}

class _AlphaSlider extends StatelessWidget {
  const _AlphaSlider({required this.alpha, required this.onChanged});

  final double alpha;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Slider(value: alpha, min: 0, max: 1, onChanged: onChanged);
  }
}
