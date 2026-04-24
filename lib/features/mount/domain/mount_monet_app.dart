class MountMonetApp {
  const MountMonetApp({
    required this.title,
    required this.key,
    required this.defaultEnabled,
    required this.category,
    required this.packageNameCandidates,
    required this.isInstalled,
    required this.enabled,
  });

  final String title;
  final String key;
  final bool defaultEnabled;
  final String category;
  final List<String> packageNameCandidates;
  final bool isInstalled;
  final bool enabled;

  MountMonetApp copyWith({
    bool? isInstalled,
    bool? enabled,
  }) {
    return MountMonetApp(
      title: title,
      key: key,
      defaultEnabled: defaultEnabled,
      category: category,
      packageNameCandidates: packageNameCandidates,
      isInstalled: isInstalled ?? this.isInstalled,
      enabled: enabled ?? this.enabled,
    );
  }
}

class MountSelectableApp {
  const MountSelectableApp({
    required this.name,
    required this.packageName,
    this.packageNameCandidates = const <String>[],
    required this.category,
    required this.installed,
    this.selected = false,
  });

  final String name;
  final String packageName;
  final List<String> packageNameCandidates;
  final String category;
  final bool installed;
  final bool selected;

  MountSelectableApp copyWith({
    String? category,
    bool? installed,
    bool? selected,
  }) {
    return MountSelectableApp(
      name: name,
      packageName: packageName,
      packageNameCandidates: packageNameCandidates,
      category: category ?? this.category,
      installed: installed ?? this.installed,
      selected: selected ?? this.selected,
    );
  }
}
