import 'package:deadzon/features/mount/domain/mount_config.dart';
import 'package:deadzon/features/mount/presentation/widgets/mount_glass_card.dart';
import 'package:flutter/material.dart';

class MountScopeTab extends StatelessWidget {
  const MountScopeTab({
    required this.config,
    required this.onChanged,
    required this.onChooseApps,
    super.key,
  });

  final MountConfig config;
  final Future<void> Function(String key, bool value) onChanged;
  final VoidCallback onChooseApps;

  @override
  Widget build(BuildContext context) {
    return MountGlassCard(
      tint: config.selectedColor,
      child: Column(
        children: <Widget>[
          _scopeRow('Statusbar', config.scopeStatusbar, (v) => onChanged('scopeStatusbar', v)),
          _scopeRow('Control Center', config.scopeControlCenter, (v) => onChanged('scopeControlCenter', v)),
          _scopeRow('Notifications', config.scopeNotifications, (v) => onChanged('scopeNotifications', v)),
          _scopeRow('Lockscreen', config.scopeLockscreen, (v) => onChanged('scopeLockscreen', v)),
          _scopeRow('Settings', config.scopeSettings, (v) => onChanged('scopeSettings', v)),
          _scopeRow('Launcher', config.scopeLauncher, (v) => onChanged('scopeLauncher', v)),
          _scopeRow('Selected apps', config.scopeSelectedApps, (v) => onChanged('scopeSelectedApps', v)),
          const SizedBox(height: 8),
          FilledButton.icon(onPressed: onChooseApps, icon: const Icon(Icons.apps_rounded), label: const Text('Choose apps')),
          if (config.selectedPackageNames.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text('${config.selectedPackageNames.length} app(s) selected', style: TextStyle(color: Colors.white.withValues(alpha: 0.78))),
            ),
        ],
      ),
    );
  }

  Widget _scopeRow(String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
    );
  }
}
