import 'dart:io';

class DeadZoneFontChoice {
  const DeadZoneFontChoice({required this.label, required this.value, this.exists = true});

  final String label;
  final String value;
  final bool exists;
}

class DeadZoneFontService {
  static const String productFontDir = '/product/media/fonts';
  static const String defaultValue = 'Default';

  static Future<List<DeadZoneFontChoice>> listFonts({String? currentValue}) async {
    final options = <DeadZoneFontChoice>[const DeadZoneFontChoice(label: defaultValue, value: defaultValue)];
    try {
      final dir = Directory(productFontDir);
      if (await dir.exists()) {
        final entries = await dir.list().toList();
        final names = entries
            .whereType<File>()
            .map((f) => f.path.split('/').last)
            .where((n) => n.toLowerCase().endsWith('.ttf') || n.toLowerCase().endsWith('.otf'))
            .toSet()
            .toList()
          ..sort();
        options.addAll(names.map((name) => DeadZoneFontChoice(label: name, value: '$productFontDir/$name')));
      }
    } catch (_) {}

    final current = normalizeStoredValue(currentValue);
    if (current != defaultValue && options.every((e) => e.value != current)) {
      options.add(DeadZoneFontChoice(label: displayLabel(current), value: current, exists: false));
    }
    return options;
  }

  static String normalizeStoredValue(String? value) {
    final raw = (value ?? '').trim();
    if (raw.isEmpty || raw == defaultValue) return defaultValue;
    return raw;
  }

  static String displayLabel(String? value) {
    final normalized = normalizeStoredValue(value);
    if (normalized == defaultValue) return defaultValue;
    return normalized.split('/').last;
  }
}
