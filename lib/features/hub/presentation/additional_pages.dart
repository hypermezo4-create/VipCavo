import 'package:deadzon/features/hub/presentation/hub_tool_screen.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HubToolScreen(
      title: 'Notifications',
      subtitle: 'Heads-up, compact icons, and stack behavior',
      modules: <HubModuleDefinition>[
        HubModuleDefinition(
          title: 'Display behavior',
          subtitle: 'Tune heads-up behavior and compact stack flow.',
          toggles: <HubToggleDefinition>[
            HubToggleDefinition(id: 'notif_heads_up', title: 'Heads-up alerts', subtitle: 'Allow floating alerts while unlocked.'),
            HubToggleDefinition(id: 'notif_compact', title: 'Compact stack', subtitle: 'Use condensed notification spacing.'),
          ],
          sliders: <HubSliderDefinition>[
            HubSliderDefinition(id: 'notif_corner', title: 'Card corner radius', min: 8, max: 28, defaultValue: 18),
          ],
        ),
      ],
    );
  }
}

class LockscreenScreen extends StatelessWidget {
  const LockscreenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HubToolScreen(
      title: 'Lockscreen',
      subtitle: 'Clock and shortcuts composition',
      modules: <HubModuleDefinition>[
        HubModuleDefinition(
          title: 'Layout',
          subtitle: 'Refine lockscreen clock and shortcut rhythm.',
          toggles: <HubToggleDefinition>[
            HubToggleDefinition(id: 'lock_compact_clock', title: 'Compact clock', subtitle: 'Use tighter lockscreen clock style.'),
            HubToggleDefinition(id: 'lock_shortcuts', title: 'Quick shortcuts', subtitle: 'Enable dual shortcut pills.'),
          ],
          sliders: <HubSliderDefinition>[
            HubSliderDefinition(id: 'lock_clock_size', title: 'Clock size', min: 26, max: 72, defaultValue: 46),
          ],
        ),
      ],
    );
  }
}

class MoreToolsScreen extends StatelessWidget {
  const MoreToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HubToolScreen(
      title: 'More tools',
      subtitle: 'Extra ROM utility features for future phases',
      modules: <HubModuleDefinition>[
        HubModuleDefinition(
          title: 'Utilities',
          subtitle: 'Keep power utilities discoverable and safe.',
          toggles: <HubToggleDefinition>[
            HubToggleDefinition(id: 'tools_backup', title: 'Auto backup prompts', subtitle: 'Prompt backups before major changes.'),
            HubToggleDefinition(id: 'tools_expert', title: 'Expert hints', subtitle: 'Show context for advanced actions.'),
          ],
          sliders: <HubSliderDefinition>[
            HubSliderDefinition(id: 'tools_density', title: 'Tools density', min: 0, max: 100, defaultValue: 55),
          ],
        ),
      ],
    );
  }
}


class GamingScreen extends StatelessWidget {
  const GamingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HubToolScreen(
      title: 'Gaming',
      subtitle: 'Performance and gaming utility controls',
      modules: <HubModuleDefinition>[],
    );
  }
}

class OtherFavoriteScreen extends StatelessWidget {
  const OtherFavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HubToolScreen(
      title: 'Other Favorite',
      subtitle: 'Extra favorite modules and utilities',
      modules: <HubModuleDefinition>[],
    );
  }
}
