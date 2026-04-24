import 'dart:convert';

import 'package:deadzon/features/mount/presentation/mount_studio_controller.dart';
import 'package:deadzon/features/mount/presentation/widgets/mount_glass_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MountControlAppsTab extends StatelessWidget {
  const MountControlAppsTab({required this.controller, super.key});

  final MountStudioController controller;

  @override
  Widget build(BuildContext context) {
    final pluginEnabled = controller.config.monetEnabled;
    final apps = controller.filteredSelectableApps;

    return MountGlassCard(
      tint: controller.config.selectedColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _StatusCard(
            controller: controller,
            onDebugViewBridgeConfig: () => _showBridgeConfig(context),
          ),
          const SizedBox(height: 12),
          const Text('Enable Mount Plugin', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Mount Plugin', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            subtitle: Text('Prepare selected ROM apps for DeadZon bridge payload', style: TextStyle(color: Colors.white.withValues(alpha: 0.72))),
            value: pluginEnabled,
            onChanged: controller.setMonetEnabled,
          ),
          const SizedBox(height: 6),
          _RomTargetsSection(controller: controller),
          const SizedBox(height: 12),
          TextField(
            onChanged: controller.setControlAppsSearch,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search apps by name or package'),
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
          Wrap(
            spacing: 8,
            runSpacing: 8,
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
                final interactive = pluginEnabled && app.installed;
                return Opacity(
                  opacity: app.installed ? 1 : 0.58,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.03),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          app.installed ? Icons.check_circle_rounded : Icons.error_outline_rounded,
                          color: app.installed ? Colors.greenAccent : Colors.orangeAccent,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(app.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 2),
                              Text(
                                '${app.packageName} • ${app.category}',
                                style: TextStyle(color: Colors.white.withValues(alpha: 0.68), fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Switch.adaptive(
                          value: app.selected,
                          onChanged: interactive ? (v) => controller.toggleSelectableApp(app.packageName, v) : null,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showBridgeConfig(BuildContext context) async {
    final payload = controller.exportBridgePayload();
    final prettyJson = const JsonEncoder.withIndent('  ').convert(payload);

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF12212C).withValues(alpha: 0.94),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Bridge Config Viewer', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                const SizedBox(height: 10),
                Flexible(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.24),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
                    ),
                    child: SingleChildScrollView(
                      child: SelectableText(
                        prettyJson,
                        style: const TextStyle(color: Colors.white, fontSize: 12.5, height: 1.4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          await Clipboard.setData(ClipboardData(text: prettyJson));
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bridge payload copied.')));
                          }
                        },
                        icon: const Icon(Icons.copy_rounded),
                        label: const Text('Copy'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FilledButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Done'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
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
          'Targets are saved for the upcoming DeadZon ROM bridge. This phase only prepares payload/config and does not modify external system apps.',
          style: TextStyle(color: Colors.white.withValues(alpha: 0.74), fontSize: 12),
        ),
        const SizedBox(height: 8),
        _toggle(label: 'Statusbar', value: controller.config.scopeStatusbar, onChanged: (value) => controller.setScope(statusbar: value)),
        _toggle(label: 'Control Center', value: controller.config.scopeControlCenter, onChanged: (value) => controller.setScope(controlCenter: value)),
        _toggle(label: 'Notifications', value: controller.config.scopeNotifications, onChanged: (value) => controller.setScope(notifications: value)),
        _toggle(label: 'Lockscreen', value: controller.config.scopeLockscreen, onChanged: (value) => controller.setScope(lockscreen: value)),
        _toggle(label: 'Settings', value: controller.config.scopeSettings, onChanged: (value) => controller.setScope(settings: value)),
        _toggle(label: 'Launcher', value: controller.config.scopeLauncher, onChanged: (value) => controller.setScope(launcher: value)),
        _toggle(label: 'Selected apps', value: controller.config.scopeSelectedApps, onChanged: (value) => controller.setScope(selectedApps: value)),
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
  const _StatusCard({required this.controller, required this.onDebugViewBridgeConfig});

  final MountStudioController controller;
  final VoidCallback onDebugViewBridgeConfig;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onDebugViewBridgeConfig,
      child: Container(
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
            Text('Mount Plugin: ${controller.config.monetEnabled ? 'Enabled' : 'Disabled'}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text('App Theme: ${controller.appThemeApplied ? 'Applied' : 'Not applied'}', style: const TextStyle(color: Colors.white)),
            Text('ROM Config: ${controller.romConfigSaved ? 'Saved' : 'Not saved'}', style: const TextStyle(color: Colors.white)),
            const Text('Real ROM Bridge: Not installed', style: TextStyle(color: Colors.white)),
            Text('Apps selected: ${controller.selectedAppsCount}', style: const TextStyle(color: Colors.white)),
            Text('Installed targets: ${controller.installedTargetsCount}', style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 4),
            Text(controller.applyStatusMessage, style: TextStyle(color: Colors.white.withValues(alpha: 0.74), fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
