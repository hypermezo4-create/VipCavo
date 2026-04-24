import 'package:deadzon/features/mount/domain/mount_monet_app.dart';
import 'package:deadzon/features/mount/presentation/mount_studio_controller.dart';
import 'package:deadzon/features/mount/presentation/widgets/mount_glass_card.dart';
import 'package:flutter/material.dart';

class MountControlAppsTab extends StatelessWidget {
  const MountControlAppsTab({required this.controller, super.key});

  final MountStudioController controller;

  @override
  Widget build(BuildContext context) {
    final enabled = controller.config.monetEnabled;
    final apps = controller.filteredControlApps;

    return MountGlassCard(
      tint: controller.config.selectedColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Monet Effect', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            subtitle: Text('Active Monet Effect for System Apps', style: TextStyle(color: Colors.white.withValues(alpha: 0.72))),
            value: enabled,
            onChanged: controller.setMonetEnabled,
          ),
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
              TextButton(onPressed: enabled ? () => controller.selectAllControlApps(true) : null, child: const Text('Select All')),
              TextButton(onPressed: enabled ? () => controller.selectAllControlApps(false) : null, child: const Text('Deselect All')),
            ],
          ),
          const SizedBox(height: 6),
          Opacity(
            opacity: enabled ? 1 : 0.45,
            child: ListView.builder(
              itemCount: apps.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final app = apps[index];
                return SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: app.enabled,
                  onChanged: enabled ? (v) => controller.toggleControlApp(app.key, v) : null,
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
