import 'package:deadzon/core/theme/deadzon_theme_controller.dart';
import 'package:deadzon/shared/widgets/deadzon_floating_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeadzonShell extends StatefulWidget {
  const DeadzonShell({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  State<DeadzonShell> createState() => _DeadzonShellState();
}

class _DeadzonShellState extends State<DeadzonShell> {
  static const String _lastTabIndexKey = 'deadzone_last_tab_index';

  static const List<DeadzonFloatingTabItem> _items = <DeadzonFloatingTabItem>[
    DeadzonFloatingTabItem(label: 'Home', icon: Icons.home_rounded),
    DeadzonFloatingTabItem(label: 'Statusbar', icon: Icons.signal_cellular_alt_rounded),
    DeadzonFloatingTabItem(label: 'Mount', icon: Icons.palette_rounded),
    DeadzonFloatingTabItem(label: 'Settings', icon: Icons.settings_rounded),
  ];

  bool _restoredLastTab = false;
  int? _rememberedIndex;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _restoreLastTab());
  }

  @override
  void didUpdateWidget(covariant DeadzonShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    _rememberCurrentTab();
  }

  Future<void> _restoreLastTab() async {
    if (_restoredLastTab) {
      return;
    }
    _restoredLastTab = true;

    final prefs = await SharedPreferences.getInstance();
    final savedIndex = prefs.getInt(_lastTabIndexKey);
    if (!mounted || savedIndex == null || savedIndex < 0 || savedIndex >= _items.length) {
      _rememberCurrentTab();
      return;
    }

    if (savedIndex != widget.navigationShell.currentIndex) {
      widget.navigationShell.goBranch(savedIndex, initialLocation: false);
    }
    _rememberedIndex = savedIndex;
  }

  void _rememberCurrentTab() {
    final index = widget.navigationShell.currentIndex;
    if (_rememberedIndex == index) {
      return;
    }
    _rememberedIndex = index;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt(_lastTabIndexKey, index);
    });
  }

  Future<void> _goToTab(int index) async {
    _rememberedIndex = index;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastTabIndexKey, index);
    if (!mounted) {
      return;
    }
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    _rememberCurrentTab();
    final theme = context.watch<DeadzonThemeController>();

    return Scaffold(
      extendBody: true,
      body: widget.navigationShell,
      bottomNavigationBar: DeadzonFloatingTabBar(
        currentIndex: widget.navigationShell.currentIndex,
        items: _items,
        accentColor: theme.accentColor,
        backgroundTint: DeadzonThemeTokens.navBackground(context),
        onTap: (index) {
          _goToTab(index);
        },
      ),
    );
  }
}
