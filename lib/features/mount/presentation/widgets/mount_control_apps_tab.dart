import 'package:deadzon/features/mount/presentation/mount_studio_controller.dart';
import 'package:deadzon/features/mount/presentation/app_picker_screen.dart';
import 'package:deadzon/features/mount/presentation/widgets/mount_glass_card.dart';
import 'package:flutter/material.dart';

class MountControlAppsTab extends StatelessWidget {
  const MountControlAppsTab({required this.controller, super.key});

  final MountStudioController controller;

  @override
  Widget build(BuildContext context) {
    final pluginEnabled = controller.config.monetEnabled;
    final apps = controller.filteredControlApps;

    return MountGlassCard(
      tint: controller.config.selectedColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _StatusCard(controller: controller),
          const SizedBox(height: 12),
          const Text('Enable Mount Plugin', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Mount Plugin', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            subtitle: Text('Prepare selected ROM apps for DeadZon Monet bridge', style: TextStyle(color: Colors.white.withValues(alpha: 0.72))),
            value: pluginEnabled,
            onChanged: controller.setMonetEnabled,
          ),
          const SizedBox(height: 6),
          _RomTargetsSection(controller: controller),
          const SizedBox(height: 12),
          TextField(
            onChanged: controller.setControlAppsSearch,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search control apps'),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 34,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: MountStudioController.controlCategories.length,
              itemBuilder: (context, index) {
                final c = MountStudioController.controlCategories[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(c),
                    selected: controller.selectedControlCategory == c,
                    onSelected: (_) => controller.setControlCategory(c),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              TextButton(onPressed: pluginEnabled ? () => controller.selectAllControlApps(true) : null, child: const Text('Select All')),
              TextButton(onPressed: pluginEnabled ? () => controller.selectAllControlApps(false) : null, child: const Text('Deselect All')),
            ],
          ),
          const SizedBox(height: 6),
          Opacity(
            opacity: pluginEnabled ? 1 : 0.45,
            child: ListView.builder(
              itemCount: apps.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final app = apps[index];
                return SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: app.enabled,
                  onChanged: pluginEnabled ? (v) => controller.toggleControlApp(app.key, v) : null,
                  title: Text(app.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  subtitle: Text(
                    '${app.key} • ${app.category} • ${app.isInstalled ? 'Installed' : 'Not installed'}',
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.68), fontSize: 12),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _RomTargetsSection extends StatelessWidget {
  const _RomTargetsSection({required this.controller});

  final MountStudioController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('ROM Targets', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
        const SizedBox(height: 6),
        Text(
          'Targets are saved for DeadZon ROM Bridge. They will affect system apps when the bridge is installed as a privileged ROM component.',
          style: TextStyle(color: Colors.white.withValues(alpha: 0.74), fontSize: 12),
        ),
        const SizedBox(height: 8),
        _toggle(
          label: 'Statusbar',
          value: controller.config.scopeStatusbar,
          onChanged: (value) => controller.setScope(statusbar: value),
        ),
        _toggle(
          label: 'Control Center',
          value: controller.config.scopeControlCenter,
          onChanged: (value) => controller.setScope(controlCenter: value),
        ),
        _toggle(
          label: 'Notifications',
          value: controller.config.scopeNotifications,
          onChanged: (value) => controller.setScope(notifications: value),
        ),
        _toggle(
          label: 'Lockscreen',
          value: controller.config.scopeLockscreen,
          onChanged: (value) => controller.setScope(lockscreen: value),
        ),
        _toggle(
          label: 'Settings',
          value: controller.config.scopeSettings,
          onChanged: (value) => controller.setScope(settings: value),
        ),
        _toggle(
          label: 'Launcher',
          value: controller.config.scopeLauncher,
          onChanged: (value) => controller.setScope(launcher: value),
        ),
        _toggle(
          label: 'Selected apps',
          value: controller.config.scopeSelectedApps,
          onChanged: (value) => controller.setScope(selectedApps: value),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () async {
                final selected = await Navigator.of(context).push<List<String>>(
                  MaterialPageRoute<List<String>>(
                    builder: (_) => AppPickerScreen(
                      apps: controller.selectableApps,
                      initialSelection: controller.config.selectedPackageNames,
                    ),
                  ),
                );
                if (selected != null) {
                  await controller.setSelectedPackages(selected);
                }
              },
              icon: const Icon(Icons.apps_rounded),
              label: const Text('Choose selected apps'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _toggle({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile.adaptive(
      contentPadding: EdgeInsets.zero,
      value: value,
      onChanged: onChanged,
      title: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({required this.controller});

  final MountStudioController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Mount Plugin: ${controller.config.monetEnabled ? 'Enabled' : 'Disabled'}',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text('App Theme: ${controller.appThemeApplied ? 'Applied' : 'Not applied'}', style: const TextStyle(color: Colors.white)),
          Text('ROM Config: ${controller.romConfigSaved ? 'Saved' : 'Not saved'}', style: const TextStyle(color: Colors.white)),
          const Text('Real ROM Bridge: Not installed', style: TextStyle(color: Colors.white)),
          Text('Apps selected: ${controller.selectedAppsCount}', style: const TextStyle(color: Colors.white)),
          Text('Installed targets: ${controller.installedTargetsCount}', style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 4),
          Text(
            controller.applyStatusMessage,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.74), fontSize: 12),
          ),
        ],
      ),
    );
  }
}
