import 'dart:convert';

class ControlCenterConfig {
  const ControlCenterConfig({
    required this.squareMezoTiles,
    required this.controlCenterStyle,
    required this.extraTwoMezoTiles,
    required this.ccBlurRatio,
    required this.lastUpdatedAt,
  });

  final bool squareMezoTiles;
  final int controlCenterStyle;
  final List<String> extraTwoMezoTiles;
  final int ccBlurRatio;
  final DateTime lastUpdatedAt;

  static ControlCenterConfig defaults() => ControlCenterConfig(
        squareMezoTiles: true,
        controlCenterStyle: 0,
        extraTwoMezoTiles: const <String>['wifi', 'cell'],
        ccBlurRatio: 100,
        lastUpdatedAt: DateTime.now(),
      );

  static const String squareMezoTilesKey = 'square_mezo_tiles';
  static const String controlCenterStyleKey = 'swap_tiles_1';
  static const String extraTwoMezoTilesKey = 'extra_two_mezo_tiles';
  static const String ccBlurRatioKey = 'cc_blur_ratio';

  ControlCenterConfig copyWith({
    bool? squareMezoTiles,
    int? controlCenterStyle,
    List<String>? extraTwoMezoTiles,
    int? ccBlurRatio,
    DateTime? lastUpdatedAt,
  }) {
    return ControlCenterConfig(
      squareMezoTiles: squareMezoTiles ?? this.squareMezoTiles,
      controlCenterStyle: controlCenterStyle ?? this.controlCenterStyle,
      extraTwoMezoTiles: extraTwoMezoTiles ?? this.extraTwoMezoTiles,
      ccBlurRatio: ccBlurRatio ?? this.ccBlurRatio,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        squareMezoTilesKey: squareMezoTiles,
        controlCenterStyleKey: controlCenterStyle,
        extraTwoMezoTilesKey: extraTwoMezoTiles,
        ccBlurRatioKey: ccBlurRatio,
        'lastUpdatedAt': lastUpdatedAt.toIso8601String(),
      };

  String encode() => jsonEncode(toJson());

  String get extraTwoAsBridgeString => extraTwoMezoTiles.join(',');

  static ControlCenterConfig decode(String raw) {
    final map = jsonDecode(raw) as Map<String, dynamic>;
    return ControlCenterConfig(
      squareMezoTiles: map[squareMezoTilesKey] as bool? ?? true,
      controlCenterStyle: (map[controlCenterStyleKey] as num?)?.toInt() ?? 0,
      extraTwoMezoTiles: (map[extraTwoMezoTilesKey] as List<dynamic>? ?? const <dynamic>['wifi', 'cell'])
          .map((dynamic e) => '$e')
          .toList(),
      ccBlurRatio: (map[ccBlurRatioKey] as num?)?.toInt() ?? 100,
      lastUpdatedAt: DateTime.tryParse(map['lastUpdatedAt'] as String? ?? '') ?? DateTime.now(),
    );
  }
}
