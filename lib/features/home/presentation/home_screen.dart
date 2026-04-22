import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<_HomeSection> _sections = <_HomeSection>[
    _HomeSection(
      title: 'Statusbar adjustment',
      subtitle: 'Customize every element in your statusbar',
      icon: Icons.signal_cellular_alt_rounded,
      color: Color(0xFF88F0A3),
      route: '/statusbar',
    ),
    _HomeSection(
      title: 'Mount',
      subtitle: 'Monet colors, effects and system accent',
      icon: Icons.palette_rounded,
      color: Color(0xFFC3A7FF),
      route: '/mount',
    ),
    _HomeSection(
      title: 'Spoof device',
      subtitle: 'Change device info for apps & games',
      icon: Icons.shield_rounded,
      color: Color(0xFF7CC7FF),
    ),
    _HomeSection(
      title: 'Settings',
      subtitle: 'App preferences and customization',
      icon: Icons.settings_rounded,
      color: Color(0xFFDCE7F3),
      route: '/settings',
    ),
    _HomeSection(
      title: 'Control center',
      subtitle: 'Customize toggles, layout and more',
      icon: Icons.grid_view_rounded,
      color: Color(0xFF5FF0E8),
    ),
    _HomeSection(
      title: 'Notifications',
      subtitle: 'Notification style, heads-up and more',
      icon: Icons.notifications_rounded,
      color: Color(0xFFFFBE6E),
    ),
    _HomeSection(
      title: 'Lockscreen',
      subtitle: 'Customize your lockscreen style',
      icon: Icons.lock_rounded,
      color: Color(0xFFFF9ED0),
    ),
    _HomeSection(
      title: 'More tools',
      subtitle: 'Additional system tweaks & utilities',
      icon: Icons.more_horiz_rounded,
      color: Color(0xFF94E48B),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Color(0xFF183C49),
              Color(0xFF122E39),
              Color(0xFF0B1519),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const _HeaderCard(),
                const SizedBox(height: 18),
                GridView.builder(
                  itemCount: _sections.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 0.94,
                  ),
                  itemBuilder: (context, index) {
                    final item = _sections[index];
                    return _SectionCard(
                      item: item,
                      onTap: () {
                        if (item.route != null) {
                          context.push(item.route!);
                          return;
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${item.title} is coming in the next pass.'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    )
                        .animate(delay: (80 * index).ms)
                        .fadeIn(duration: 420.ms)
                        .slideY(begin: 0.08, end: 0, duration: 420.ms);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const _FloatingNavBar(),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.22),
            ),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 92,
                height: 92,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Color(0xFFB4FFF0),
                      Color(0xFF5CE7C1),
                      Color(0xFF3AA2C8),
                    ],
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: const Color(0xFF77E7CF).withValues(alpha: 0.28),
                      blurRadius: 30,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'D',
                    style: TextStyle(
                      fontSize: 46,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Deadzon',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Mezo',
                      style: textTheme.titleMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.86),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Base Alpha',
                      style: textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withValues(alpha: 0.78),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'ROM Deadzon',
                      style: textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withValues(alpha: 0.78),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'CN 3.0.303',
                      style: textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withValues(alpha: 0.78),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none_rounded),
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 450.ms).slideY(begin: -0.05, end: 0);
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.item,
    required this.onTap,
  });

  final _HomeSection item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: Colors.white.withValues(alpha: 0.12),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.16),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: item.color.withValues(alpha: 0.08),
                blurRadius: 24,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(item.icon, color: item.color, size: 24),
                ),
                const Spacer(),
                Text(
                  item.title,
                  style: textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.subtitle,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.75),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FloatingNavBar extends StatelessWidget {
  const _FloatingNavBar();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            height: 72,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.18),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const <Widget>[
                _NavItem(icon: Icons.home_rounded, label: 'Home', active: true),
                _NavItem(icon: Icons.grid_view_rounded, label: 'Tools'),
                _NavItem(icon: Icons.layers_rounded, label: 'Profiles'),
                _NavItem(icon: Icons.more_horiz_rounded, label: 'More'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    this.active = false,
  });

  final IconData icon;
  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final color = active
        ? const Color(0xFF7BF2D7)
        : Colors.white.withValues(alpha: 0.72);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 260),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: active ? Colors.white.withValues(alpha: 0.10) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: active ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeSection {
  const _HomeSection({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.route,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String? route;
}