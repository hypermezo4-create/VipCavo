import 'package:deadzon/core/theme/deadzon_theme_controller.dart';
import 'package:deadzon/shared/widgets/deadzon_floating_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DeadzonShell extends ConsumerWidget {
  const DeadzonShell({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  static const List<DeadzonFloatingTabItem> _items = <DeadzonFloatingTabItem>[
    DeadzonFloatingTabItem(label: 'Home', icon: Icons.home_rounded),
    DeadzonFloatingTabItem(label: 'Statusbar', icon: Icons.signal_cellular_alt_rounded),
    DeadzonFloatingTabItem(label: 'Mount', icon: Icons.palette_rounded),
    DeadzonFloatingTabItem(label: 'Settings', icon: Icons.settings_rounded),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(deadzonThemeControllerProvider);

    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: DeadzonFloatingTabBar(
        currentIndex: navigationShell.currentIndex,
        items: _items,
        accentColor: theme.accentColor,
        backgroundTint: DeadzonThemeTokens.navBackground(context),
        onTap: (index) {
          navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
        },
      ),
    );
  }
}
