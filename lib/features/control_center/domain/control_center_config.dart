import 'dart:convert';

class ControlCenterConfig {
  const ControlCenterConfig({
    required this.values,
    required this.lastUpdatedAt,
  });

  final Map<String, bool> values;
  final DateTime lastUpdatedAt;

  static const List<String> supportedKeys = <String>[
    'monetmode','glass_effect','bgblur','CustomCornerRadius','compactdpi','4tile','style2','largemedia','largemedia1','circlecard','cardtouch','hidesound','devicesize','squaretiles','custom_clock','defaultedit','traffic','slidericon','percent','smallvolume','columndown','circlebuttons','HideButtons','hidemore','extended_hyper_island','powermenu',
  ];

  static ControlCenterConfig defaults() => ControlCenterConfig(
        values: {for (final key in supportedKeys) key: false},
        lastUpdatedAt: DateTime.now(),
      );

  bool read(String key) => values[key] ?? false;

  ControlCenterConfig copyWith({Map<String, bool>? values, DateTime? lastUpdatedAt}) => ControlCenterConfig(
        values: values ?? this.values,
        lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'values': values,
        'lastUpdatedAt': lastUpdatedAt.toIso8601String(),
      };

  String encode() => jsonEncode(toJson());

  static ControlCenterConfig decode(String raw) {
    final map = jsonDecode(raw) as Map<String, dynamic>;
    final valuesRaw = (map['values'] as Map<String, dynamic>? ?? <String, dynamic>{});
    final merged = <String, bool>{for (final k in supportedKeys) k: false};
    for (final entry in valuesRaw.entries) {
      if (supportedKeys.contains(entry.key)) {
        merged[entry.key] = entry.value == true || entry.value == 1 || entry.value == '1';
      }
    }
    return ControlCenterConfig(values: merged, lastUpdatedAt: DateTime.tryParse(map['lastUpdatedAt'] as String? ?? '') ?? DateTime.now());
  }
}
