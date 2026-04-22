import 'package:deadzon/features/hub/presentation/hub_tool_screen.dart';
import 'package:flutter/material.dart';

class SpoofDeviceScreen extends StatelessWidget {
  const SpoofDeviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HubToolScreen(
      title: 'Spoof device',
      subtitle: 'Profile simulation controls and compatibility presets',
      modules: <HubModuleDefinition>[
        HubModuleDefinition(
          title: 'Identity profile',
          subtitle: 'Tune model identity and spoof safety.',
          toggles: <HubToggleDefinition>[
            HubToggleDefinition(id: 'spoof_enabled', title: 'Enable spoof profile', subtitle: 'Apply selected profile to target modules.'),
            HubToggleDefinition(id: 'spoof_secure', title: 'Safety guard', subtitle: 'Block risky combinations automatically.'),
          ],
          sliders: <HubSliderDefinition>[
            HubSliderDefinition(id: 'spoof_level', title: 'Compatibility level', min: 0, max: 100, defaultValue: 72),
          ],
        ),
      ],
    );
  }
}

class ControlCenterScreen extends StatelessWidget {
  const ControlCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HubToolScreen(
      title: 'Control center',
      subtitle: 'Quick toggles board and grouped utility actions',
      modules: <HubModuleDefinition>[
        HubModuleDefinition(
          title: 'Tile behavior',
          subtitle: 'Configure spacing, motion, and blur response.',
          toggles: <HubToggleDefinition>[
            HubToggleDefinition(id: 'cc_grouping', title: 'Smart grouping', subtitle: 'Group tiles by usage patterns.'),
            HubToggleDefinition(id: 'cc_labels', title: 'Show labels', subtitle: 'Display compact labels under tiles.'),
          ],
          sliders: <HubSliderDefinition>[
            HubSliderDefinition(id: 'cc_radius', title: 'Tile roundness', min: 8, max: 32, defaultValue: 22),
            HubSliderDefinition(id: 'cc_blur', title: 'Backdrop blur', min: 0, max: 40, defaultValue: 18),
          ],
        ),
      ],
    );
  }
}

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
