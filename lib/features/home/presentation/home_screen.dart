import 'package:deadzon/core/constants/app_identity.dart';
import 'package:deadzon/core/services/external_app_launcher_service.dart';
import 'package:deadzon/core/theme/design_tokens.dart';
import 'package:deadzon/core/widgets/glass_card.dart';
import 'package:deadzon/core/widgets/premium_top_bar.dart';
import 'package:deadzon/core/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<_QuickAccess> _entries = <_QuickAccess>[
    _QuickAccess('Statusbar Adjustment', 'Resize, battery, clock, icons and backgrounds', Icons.signal_cellular_alt_rounded, '/statusbar'),
    _QuickAccess('Mount', 'Monet colors, effect tuning, live component previews', Icons.palette_rounded, '/mount'),
    _QuickAccess('Integrity', 'Launch Kaorios Toolbox directly from Deadzon', Icons.verified_user_rounded, null,
        accentColor: Color(0xFFE1B65A),
        avatarBackgroundColor: Color(0x3316110A),
        useGoldStyle: true,
        packageName: 'com.kousei.kaorios'),
    _QuickAccess('Spoof device', 'Profile simulation controls and compatibility presets', Icons.smartphone_rounded, '/spoof-device'),
    _QuickAccess('Settings', 'Appearance, build info, reset preferences', Icons.settings_rounded, '/settings'),
    _QuickAccess('Control center', 'Quick toggles board and grouped utility actions', Icons.tune_rounded, '/control-center'),
    _QuickAccess('Notifications', 'Heads-up, compact icons, and stack behavior', Icons.notifications_active_rounded, '/notifications'),
    _QuickAccess('Lockscreen', 'Clock and shortcuts composition', Icons.lock_outline_rounded, '/lockscreen'),
    _QuickAccess('More tools', 'Extra ROM utility features for future phases', Icons.auto_awesome_rounded, '/more-tools'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: DesignTokens.baseGradient),
      child: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          padding: DesignTokens.pagePadding,
          children: <Widget>[
            const PremiumTopBar(
              title: 'Deadzon',
              subtitle: 'Premium standalone ROM feature hub',
            ).animate().fadeIn(duration: 400.ms),
            const SizedBox(height: 16),
            const _IdentityHero().animate().fadeIn(duration: 450.ms).slideY(begin: 0.06, end: 0),
            const SizedBox(height: 20),
            const SectionHeader(title: 'Main hub', subtitle: 'Core destinations for the premium Deadzon experience'),
            const SizedBox(height: 10),
            ..._entries.asMap().entries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _EntryCard(entry.value)
                        .animate(delay: (75 * entry.key).ms)
                        .fadeIn(duration: 300.ms)
                        .slideX(begin: 0.04, end: 0),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

class _IdentityHero extends StatelessWidget {
  const _IdentityHero();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(AppIdentity.appName, style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800)),
          SizedBox(height: 8),
          Text('Developer: ${AppIdentity.developer}', style: TextStyle(color: Colors.white70)),
          Text('Build: ${AppIdentity.buildLabel}', style: TextStyle(color: Colors.white70)),
          Text('ROM: ${AppIdentity.romLabel}', style: TextStyle(color: Colors.white70)),
          Text('Version: ${AppIdentity.versionLabel}', style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}

class _EntryCard extends StatelessWidget {
  const _EntryCard(this.entry);

  final _QuickAccess entry;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: () async {
        if (entry.packageName != null) {
          final didLaunch = await ExternalAppLauncherService.launchPackage(entry.packageName!);
          if (!context.mounted || didLaunch) {
            return;
          }

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Kaorios Toolbox is not installed.'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          return;
        }

        if (entry.route != null) {
          context.go(entry.route!);
        }
      },
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          radius: 22,
          backgroundColor: entry.avatarBackgroundColor ?? const Color(0xFF83EED5).withValues(alpha: 0.18),
          child: Icon(entry.icon, color: entry.accentColor ?? const Color(0xFF92F3DE)),
        ),
        title: Text(
          entry.title,
          style: TextStyle(
            color: entry.useGoldStyle ? const Color(0xFFFFD57A) : Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          entry.subtitle,
          style: TextStyle(
            color: entry.useGoldStyle ? const Color(0xFFE1D0AA) : Colors.white.withValues(alpha: 0.72),
          ),
        ),
        trailing: Icon(Icons.chevron_right_rounded, color: entry.useGoldStyle ? const Color(0xFFE1B65A) : Colors.white70),
      ),
    );
  }
}

class _QuickAccess {
  const _QuickAccess(this.title, this.subtitle, this.icon, this.route,
      {this.accentColor, this.avatarBackgroundColor, this.useGoldStyle = false, this.packageName});

  final String title;
  final String subtitle;
  final IconData icon;
  final String? route;
  final Color? accentColor;
  final Color? avatarBackgroundColor;
  final bool useGoldStyle;
  final String? packageName;
}
