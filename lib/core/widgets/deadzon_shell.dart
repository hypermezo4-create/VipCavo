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

class _DeadzonShellState extends State<DeadzonShell> with SingleTickerProviderStateMixin {
  static const String _lastTabIndexKey = 'deadzone_last_tab_index';

  static const List<DeadzonFloatingTabItem> _items = <DeadzonFloatingTabItem>[
    DeadzonFloatingTabItem(label: 'Home', icon: Icons.home_rounded),
    DeadzonFloatingTabItem(label: 'Mount', icon: Icons.palette_rounded),
    DeadzonFloatingTabItem(label: 'Settings', icon: Icons.settings_rounded),
  ];

  bool _restoredLastTab = false;
  int? _rememberedIndex;
  bool _showStartupOverlay = true;
  late final AnimationController _entranceController;
  late final Animation<double> _shellOpacity;
  late final Animation<Offset> _shellSlide;
  late final Animation<double> _navOpacity;
  late final Animation<Offset> _navSlide;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1160));
    _shellOpacity = CurvedAnimation(parent: _entranceController, curve: const Interval(0.44, 0.9, curve: Curves.easeOut));
    _shellSlide = Tween<Offset>(begin: const Offset(0, 0.04), end: Offset.zero).animate(
      CurvedAnimation(parent: _entranceController, curve: const Interval(0.44, 0.92, curve: Curves.easeOutCubic)),
    );
    _navOpacity = CurvedAnimation(parent: _entranceController, curve: const Interval(0.66, 1, curve: Curves.easeOut));
    _navSlide = Tween<Offset>(begin: const Offset(0, 0.14), end: Offset.zero).animate(
      CurvedAnimation(parent: _entranceController, curve: const Interval(0.66, 1, curve: Curves.easeOutCubic)),
    );
    _entranceController.forward().whenComplete(() {
      if (mounted) {
        setState(() => _showStartupOverlay = false);
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _restoreLastTab());
  }

  @override
  void didUpdateWidget(covariant DeadzonShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    _rememberCurrentTab();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
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

    return Stack(
      children: <Widget>[
        Scaffold(
          extendBody: true,
          body: FadeTransition(opacity: _shellOpacity, child: SlideTransition(position: _shellSlide, child: widget.navigationShell)),
          bottomNavigationBar: FadeTransition(
            opacity: _navOpacity,
            child: SlideTransition(
              position: _navSlide,
              child: DeadzonFloatingTabBar(
                currentIndex: widget.navigationShell.currentIndex,
                items: _items,
                accentColor: theme.accentColor,
                backgroundTint: DeadzonThemeTokens.bottomNavBackground(context),
                onTap: (index) {
                  _goToTab(index);
                },
              ),
            ),
          ),
        ),
        IgnorePointer(
          ignoring: !_showStartupOverlay,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 320),
            curve: Curves.easeOut,
            opacity: _showStartupOverlay ? 1 : 0,
            child: const _StartupEntranceOverlay(),
          ),
        ),
      ],
    );
  }
}

class _StartupEntranceOverlay extends StatefulWidget {
  const _StartupEntranceOverlay();

  @override
  State<_StartupEntranceOverlay> createState() => _StartupEntranceOverlayState();
}

class _StartupEntranceOverlayState extends State<_StartupEntranceOverlay> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1080),
  )..forward();
  late final Animation<double> _contentOpacity = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.08, 0.68, curve: Curves.easeOutCubic),
  );
  late final Animation<double> _contentScale = Tween<double>(begin: 0.94, end: 1).animate(
    CurvedAnimation(parent: _controller, curve: const Interval(0.08, 0.72, curve: Curves.easeOutBack)),
  );
  late final Animation<double> _ringScale = Tween<double>(begin: 0.78, end: 1.16).animate(
    CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.86, curve: Curves.easeOutCubic)),
  );
  late final Animation<double> _ringOpacity = Tween<double>(begin: 0.52, end: 0).animate(
    CurvedAnimation(parent: _controller, curve: const Interval(0.26, 1, curve: Curves.easeOut)),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFF030913),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: <Color>[Color(0xFF04142B), Color(0xFF071024), Color(0xFF071818)]),
            ),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    width: 250,
                    height: 250,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: <Color>[Color(0x6658E8FF), Color(0x0022BAAF)],
                      ),
                    ),
                  ),
                  Transform.scale(
                    scale: _ringScale.value,
                    child: Opacity(
                      opacity: _ringOpacity.value,
                      child: Container(
                        width: 168,
                        height: 168,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF7CF3DA).withValues(alpha: 0.48), width: 1.5),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: const Color(0xFF67E6FF).withValues(alpha: 0.26),
                              blurRadius: 34,
                              spreadRadius: 8,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: _contentOpacity.value,
                    child: Transform.scale(
                      scale: _contentScale.value,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const <Widget>[
                          Text('DeadZone', style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.w800, letterSpacing: 0.2)),
                          SizedBox(height: 8),
                          Text(
                            'ROM Hub',
                            style: TextStyle(color: Color(0xB3D7F9FF), fontSize: 13, letterSpacing: 2.2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
