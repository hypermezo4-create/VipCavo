import 'package:deadzon/core/constants/app_identity.dart';
import 'package:deadzon/core/theme/deadzon_theme_controller.dart';
import 'package:deadzon/core/widgets/deadzone_settings_widgets.dart';
import 'package:deadzon/core/widgets/premium_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const List<_QuickAccess> _entries = <_QuickAccess>[
    _QuickAccess('Statusbar', 'Resize statusbar, battery, clock, network and icons', Icons.signal_cellular_alt_rounded, '/statusbar'),
    _QuickAccess('Control center', 'Quick toggles board and grouped utility actions', Icons.tune_rounded, '/control-center'),
    _QuickAccess('Notification', 'Heads-up, compact icons, and stack behavior', Icons.notifications_active_rounded, '/notifications'),
    _QuickAccess('Lock screen', 'Clock, shortcuts and lockscreen composition', Icons.lock_outline_rounded, '/lock-screen'),
    _QuickAccess('Call', 'Call window, contact colors and call history styles', Icons.call_rounded, '/call'),
    _QuickAccess('Gaming', 'Performance and game-focused utility experiences', Icons.sports_esports_rounded, '/gaming'),
    _QuickAccess('Mount', 'Monet colors, effect tuning, live component previews', Icons.palette_rounded, '/mount'),
    _QuickAccess('DeadZone toolbox', 'DeadZone dashboard and premium system modules', Icons.dashboard_customize_rounded, '/toolbox'),
    _QuickAccess('Settings', 'Appearance, build info, reset preferences', Icons.settings_rounded, '/settings'),
    _QuickAccess('Other Favorite', 'Extra ROM utility features', Icons.auto_awesome_rounded, '/other-favorite'),
  ];

  @override
  Widget build(BuildContext context) {
    final bgTop = DeadzonThemeTokens.appBackground(context);
    final bgBottom = DeadzonThemeTokens.pageBackground(context);
    return Container(
      decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: <Color>[bgTop, bgBottom])),
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(14, 10, 14, MediaQuery.paddingOf(context).bottom + 132),
          children: <Widget>[
            const PremiumTopBar(title: AppIdentity.appName, subtitle: 'Compact ROM tools hub'),
            const SizedBox(height: 10),
            DeadZoneSettingsCard(
              child: Row(children: <Widget>[
                Icon(Icons.verified_rounded, color: DeadzonThemeTokens.iconAccent(context), size: 18), const SizedBox(width: 8),
                const Expanded(child: Text('Base Alpha • CN 3.0.303', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600))),
              ]),
            ),
            const SizedBox(height: 14),
            const DeadZoneSectionHeader(title: 'Main tools', subtitle: 'Organized compact access'),
            DeadZoneSettingsCard(
              child: Column(
                children: _entries.map((entry) => Column(children: [
                  DeadZoneNavigationRow(icon: entry.icon, title: entry.title, subtitle: entry.subtitle, onTap: () {
                    context.go(entry.route);
                  }),
                  if (entry != _entries.last) const Divider(height: 1),
                ])).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }


}

class _QuickAccess {
  const _QuickAccess(this.title, this.subtitle, this.icon, this.route);
  final String title;
  final String subtitle;
  final IconData icon;
  final String route;
}
