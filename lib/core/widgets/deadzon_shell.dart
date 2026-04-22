import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeadzonShell extends StatelessWidget {
  const DeadzonShell({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  static const List<_NavItem> _items = <_NavItem>[
    _NavItem('Home', Icons.home_rounded),
    _NavItem('Status Bar', Icons.signal_cellular_alt_rounded),
    _NavItem('Mount', Icons.palette_rounded),
    _NavItem('Settings', Icons.settings_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: const Color(0xFF13242B).withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.22),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: NavigationBar(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: (index) {
              navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
            },
            backgroundColor: Colors.transparent,
            indicatorColor: const Color(0xFF79E3CB).withValues(alpha: 0.24),
            height: 72,
            destinations: _items
                .map(
                  (item) => NavigationDestination(
                    icon: Icon(item.icon, color: Colors.white70),
                    selectedIcon: Icon(item.icon, color: const Color(0xFF8AF0D8)),
                    label: item.label,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem(this.label, this.icon);

  final String label;
  final IconData icon;
}
