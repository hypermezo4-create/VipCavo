import 'package:deadzon/core/constants/app_identity.dart';
import 'package:deadzon/core/services/android_intent_bridge.dart';
import 'package:deadzon/core/theme/deadzon_theme_controller.dart';
import 'package:deadzon/core/widgets/deadzone_settings_widgets.dart';
import 'package:deadzon/core/widgets/premium_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String _kaoriosPackage = 'com.kousei.kaorios';

  static const List<_QuickAccess> _entries = <_QuickAccess>[
    _QuickAccess('Statusbar Adjustment', 'Resize, battery, clock, icons and backgrounds', Icons.signal_cellular_alt_rounded, '/statusbar'),
    _QuickAccess('Mount', 'Monet colors, effect tuning, live component previews', Icons.palette_rounded, '/mount'),
    _QuickAccess('Spoof device', 'Open Kaorios Toolbox for profiles and presets', Icons.smartphone_rounded, 'external:kaorios'),
    _QuickAccess('Settings', 'Appearance, build info, reset preferences', Icons.settings_rounded, '/settings'),
    _QuickAccess('Control center', 'Quick toggles board and grouped utility actions', Icons.tune_rounded, '/control-center'),
    _QuickAccess('Notifications', 'Heads-up, compact icons, and stack behavior', Icons.notifications_active_rounded, '/notifications'),
    _QuickAccess('Lockscreen', 'Clock and shortcuts composition', Icons.lock_outline_rounded, '/lockscreen'),
    _QuickAccess('More tools', 'Extra ROM utility features', Icons.auto_awesome_rounded, '/more-tools'),
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
                Icon(Icons.verified_rounded, color: DeadzonThemeTokens.accent(context), size: 18), const SizedBox(width: 8),
                const Expanded(child: Text('Base Alpha • CN 3.0.303', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600))),
              ]),
            ),
            const SizedBox(height: 14),
            const DeadZoneSectionHeader(title: 'Main tools', subtitle: 'Organized compact access'),
            DeadZoneSettingsCard(
              child: Column(
                children: _entries.map((entry) => Column(children: [
                  DeadZoneNavigationRow(icon: entry.icon, title: entry.title, subtitle: entry.subtitle, onTap: () {
                    if (entry.route == 'external:kaorios') {
                      launchKaorios(context);
                    } else {
                      context.go(entry.route);
                    }
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

  static Future<void> launchKaorios(BuildContext context) async {
    final opened = await AndroidIntentBridge.openExternalApp(_kaoriosPackage);
    if (!context.mounted || opened) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Kaorios Toolbox is not installed.')));
  }
}

class _QuickAccess {
  const _QuickAccess(this.title, this.subtitle, this.icon, this.route);
  final String title;
  final String subtitle;
  final IconData icon;
  final String route;
}
