import 'package:deadzon/core/theme/deadzon_theme_controller.dart';
import 'package:flutter/material.dart';

class DeadZoneColorPickerDialog extends StatefulWidget {
  const DeadZoneColorPickerDialog({
    required this.title,
    required this.options,
    required this.selectedId,
    super.key,
  });

  final String title;
  final List<DeadzoneColorOption> options;
  final String selectedId;

  @override
  State<DeadZoneColorPickerDialog> createState() => _DeadZoneColorPickerDialogState();
}

class _DeadZoneColorPickerDialogState extends State<DeadZoneColorPickerDialog> {
  late String _selectedId;
  late final TextEditingController _hexController;

  @override
  void initState() {
    super.initState();
    _selectedId = widget.selectedId;
    _hexController = TextEditingController(text: _hex(_selected.color));
  }

  @override
  void dispose() {
    _hexController.dispose();
    super.dispose();
  }

  DeadzoneColorOption get _selected {
    return widget.options.firstWhere(
      (DeadzoneColorOption option) => option.id == _selectedId,
      orElse: () => widget.options.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF131B2A) : Colors.white;
    final borderColor = isDark ? Colors.white.withValues(alpha: 0.1) : const Color(0xFFE1E8F0);

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: cardColor.withValues(alpha: 0.96),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: borderColor),
          boxShadow: <BoxShadow>[BoxShadow(color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.1), blurRadius: 28, offset: const Offset(0, 16))],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(widget.title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700, fontSize: 22)),
                  ),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close_rounded)),
                ],
              ),
              const SizedBox(height: 8),
              Flexible(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 12,
                    children: widget.options.map((DeadzoneColorOption option) {
                      final selected = option.id == _selectedId;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedId = option.id;
                            _hexController.text = _hex(option.color);
                          });
                        },
                        child: SizedBox(
                          width: 68,
                          child: Column(
                            children: <Widget>[
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: option.color,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: selected ? const Color(0xFF2ED9A6) : borderColor, width: selected ? 2.5 : 1),
                                ),
                                child: selected ? const Icon(Icons.check_rounded, color: Colors.white, size: 24) : null,
                              ),
                              const SizedBox(height: 5),
                              Text(option.label, maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodySmall),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(color: _selected.color, borderRadius: BorderRadius.circular(12), border: Border.all(color: borderColor)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _hexController,
                      readOnly: true,
                      decoration: const InputDecoration(labelText: 'Hex color', border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: () => Navigator.pop(context, _selectedId),
                    style: FilledButton.styleFrom(shape: const CircleBorder(), padding: const EdgeInsets.all(12)),
                    child: const Icon(Icons.check_rounded),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _hex(Color color) => '#${color.toARGB32().toRadixString(16).substring(2).toUpperCase()}';
}
