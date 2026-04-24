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
    required this.installed,
  });

  final String name;
  final String packageName;
  final bool installed;
}
