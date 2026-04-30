import 'package:deadzon/core/services/deadzone_font_service.dart';
import 'package:deadzon/core/theme/deadzon_theme_controller.dart';
import 'package:flutter/material.dart';

Future<String?> showDeadZoneFontPicker({
  required BuildContext context,
  required String title,
  required String currentValue,
}) {
  return showModalBottomSheet<String>(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    builder: (sheetContext) => DeadZoneFontPickerSheet(title: title, currentValue: currentValue),
  );
}

class DeadZoneFontPickerSheet extends StatefulWidget {
  const DeadZoneFontPickerSheet({required this.title, required this.currentValue, super.key});

  final String title;
  final String currentValue;

  @override
  State<DeadZoneFontPickerSheet> createState() => _DeadZoneFontPickerSheetState();
}

class _DeadZoneFontPickerSheetState extends State<DeadZoneFontPickerSheet> {
  late Future<List<DeadZoneFontChoice>> _loader;

  @override
  void initState() {
    super.initState();
    _loader = DeadZoneFontService.listFonts(currentValue: widget.currentValue);
  }

  @override
  Widget build(BuildContext context) {
    final selected = DeadZoneFontService.normalizeStoredValue(widget.currentValue);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
        child: FutureBuilder<List<DeadZoneFontChoice>>(
          future: _loader,
          builder: (context, snapshot) {
            final items = snapshot.data ?? const <DeadZoneFontChoice>[];
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17, color: DeadzonThemeTokens.textPrimary(context))),
                const SizedBox(height: 10),
                if (snapshot.connectionState == ConnectionState.waiting)
                  const Padding(padding: EdgeInsets.all(18), child: CircularProgressIndicator())
                else
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, i) {
                        final item = items[i];
                        return ListTile(
                          title: Text(item.label),
                          subtitle: item.exists ? null : const Text('Missing from /product/media/fonts'),
                          trailing: Icon(item.value == selected ? Icons.check_circle : Icons.circle_outlined, color: item.value == selected ? DeadzonThemeTokens.checkboxActive(context) : DeadzonThemeTokens.checkboxInactive(context)),
                          onTap: () => Navigator.of(context).maybePop(item.value),
                        );
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
