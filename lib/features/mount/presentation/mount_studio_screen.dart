import 'package:deadzon/core/theme/deadzon_theme_controller.dart';
import 'package:deadzon/core/theme/design_tokens.dart';
import 'package:deadzon/core/widgets/premium_top_bar.dart';
import 'package:deadzon/features/mount/presentation/app_picker_screen.dart';
import 'package:deadzon/features/mount/presentation/mount_studio_controller.dart';
import 'package:deadzon/features/mount/presentation/widgets/mount_color_tab.dart';
import 'package:deadzon/features/mount/presentation/widgets/mount_components_tab.dart';
import 'package:deadzon/features/mount/presentation/widgets/mount_effects_tab.dart';
import 'package:deadzon/features/mount/presentation/widgets/mount_glass_card.dart';
import 'package:deadzon/features/mount/presentation/widgets/mount_live_preview.dart';
import 'package:deadzon/features/mount/presentation/widgets/mount_profiles_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MountStudioScreen extends StatelessWidget {
  const MountStudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MountStudioController>();

    return Container(
      decoration: const BoxDecoration(gradient: DesignTokens.baseGradient),
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            ListView(
              padding: EdgeInsets.fromLTRB(18, 14, 18, 248 + MediaQuery.paddingOf(context).bottom),
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              children: <Widget>[
                const PremiumTopBar(title: 'Mount Studio', subtitle: 'Theme Engine and app effects for DeadZone'),
                const SizedBox(height: 14),
                _ThemeEngineStatus(controller: controller),
                const SizedBox(height: 14),
                _StudioHubGrid(controller: controller),
                const SizedBox(height: 14),
                MountLivePreview(config: controller.config),
              ],
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 12 + MediaQuery.paddingOf(context).bottom,
              child: _BottomActionBar(
                onPreview: () => _openEditorSheet(
                  context,
                  title: 'Preview',
                  subtitle: 'See how your current profile looks before applying changes.',
                  child: MountLivePreview(config: controller.config),
                ),
                onReset: () => _showResetDialog(context, controller),
                liveApplyEnabled: controller.config.liveApplyEnabled,
                onLiveApplyChanged: controller.setLiveApplyEnabled,
                accentColor: DeadzonThemeTokens.accent(context),
                onApply: () async {
                  await controller.apply();
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Changes applied successfully.')));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> _openEditorSheet(
    BuildContext context, {
    required String title,
    required String subtitle,
    required Widget child,
  }) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return DraggableScrollableSheet(
          initialChildSize: 0.88,
          minChildSize: 0.62,
          maxChildSize: 0.96,
          builder: (context, controller) {
            return Container(
              margin: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              decoration: BoxDecoration(
                color: const Color(0xFF101923),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
                boxShadow: const <BoxShadow>[BoxShadow(color: Color(0x66000000), blurRadius: 28, offset: Offset(0, 14))],
              ),
              child: ListView(
                controller: controller,
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w800)),
                            const SizedBox(height: 4),
                            Text(subtitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.68))),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(sheetContext).pop(),
                        icon: const Icon(Icons.close_rounded, color: Colors.white70),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  child,
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _showResetDialog(BuildContext context, MountStudioController controller) async {
    final shouldReset = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Mount Studio?'),
        content: const Text('This will restore colors, effects, components, scope, target apps, and profiles to defaults.'),
        actions: <Widget>[
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Reset')),
        ],
      ),
    );
    if (shouldReset == true) {
      await controller.reset();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Mount Studio reset to defaults.')));
      }
    }
  }
}

class _StudioHubGrid extends StatelessWidget {
  const _StudioHubGrid({required this.controller});

  final MountStudioController controller;

  @override
  Widget build(BuildContext context) {
    final items = <_StudioHubItem>[
      _StudioHubItem(
        title: 'Colors',
        subtitle: 'Theme palettes and accent colors',
        icon: Icons.palette_rounded,
        onTap: () => MountStudioScreen._openEditorSheet(
          context,
          title: 'Colors',
          subtitle: 'Tune the DeadZone palette and color engine.',
          child: MountColorTab(
            config: controller.config,
            paletteLibrary: controller.paletteLibrary,
            wallpaperSets: controller.wallpaperSets,
            onSeedChanged: controller.setSeedColor,
            onPaletteSelected: controller.selectPalette,
            onPullWallpaperColors: controller.pullWallpaperColors,
            onToggleFavorite: controller.toggleFavorite,
            onResetColor: controller.resetSeedColor,
            onRandomColor: controller.randomizeColor,
            onOpenSystemWallpaperStyle: () async {
              final launched = await controller.launchMonetPicker();
              if (!context.mounted) return;
              if (!launched) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Wallpaper and style app is unavailable on this ROM.')));
              }
            },
          ),
        ),
      ),
      _StudioHubItem(
        title: 'App Effects',
        subtitle: 'Opacity, blur, glow and radius',
        icon: Icons.auto_awesome_rounded,
        onTap: () => MountStudioScreen._openEditorSheet(
          context,
          title: 'App Effects',
          subtitle: 'Fine tune glass and animation intensity.',
          child: MountEffectsTab(
            config: controller.config,
            onChanged: (key, value) {
              switch (key) {
                case 'glassOpacity':
                  return controller.setSlider(glassOpacity: value);
                case 'blurStrength':
                  return controller.setSlider(blurStrength: value);
                case 'accentIntensity':
                  return controller.setSlider(accentIntensity: value);
                case 'glowAmount':
                  return controller.setSlider(glowAmount: value);
                case 'cornerRadius':
                  return controller.setSlider(cornerRadius: value);
                case 'shadowDepth':
                  return controller.setSlider(shadowDepth: value);
                default:
                  return controller.setSlider(borderVisibility: value);
              }
            },
          ),
        ),
      ),
      _StudioHubItem(
        title: 'Components',
        subtitle: 'Seekbar, switch, checkbox and cards',
        icon: Icons.tune_rounded,
        onTap: () => MountStudioScreen._openEditorSheet(
          context,
          title: 'Components',
          subtitle: 'Customize component colors and details.',
          child: MountComponentsTab(config: controller.config, onTapItem: (key) => _showComponentColorPicker(context, controller, key)),
        ),
      ),
      _StudioHubItem(
        title: 'Scope',
        subtitle: 'Choose where styling is applied',
        icon: Icons.layers_rounded,
        onTap: () => MountStudioScreen._openEditorSheet(
          context,
          title: 'Scope',
          subtitle: 'Enable feature areas for app-wide styling.',
          child: _ScopeEditor(controller: controller),
        ),
      ),
      _StudioHubItem(
        title: 'Target Apps',
        subtitle: '${controller.selectedAppsCount} selected • ${controller.installedTargetsCount} available',
        icon: Icons.apps_rounded,
        onTap: () async {
          final result = await Navigator.of(context).push<List<String>>(
            MaterialPageRoute<List<String>>(
              builder: (_) => AppPickerScreen(
                apps: controller.selectableApps,
                initialSelection: controller.config.selectedPackageNames,
              ),
            ),
          );
          if (result != null) {
            await controller.setSelectedPackages(result);
          }
        },
      ),
      _StudioHubItem(
        title: 'Profiles',
        subtitle: 'Switch between preset configurations',
        icon: Icons.bookmark_rounded,
        onTap: () => MountStudioScreen._openEditorSheet(
          context,
          title: 'Profiles',
          subtitle: 'Apply or reset profile presets.',
          child: MountProfilesTab(
            profiles: controller.profiles,
            activeProfileId: controller.config.activeProfileId,
            onProfileTap: controller.applyProfile,
            onResetProfile: () async {
              await controller.resetCurrentProfileToDefault();
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile reset complete.')));
            },
            onEditProfile: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile editing will be added in a future update.'))),
          ),
        ),
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        mainAxisExtent: 120,
      ),
      itemBuilder: (context, index) => _StudioHubCard(item: items[index]),
    );
  }

  Future<void> _showComponentColorPicker(BuildContext context, MountStudioController controller, String componentKey) async {
    final initial = switch (componentKey) {
      'seekbarColor' => controller.config.seekbarColor,
      'switchOnColor' => controller.config.switchOnColor,
      'switchOffColor' => controller.config.switchOffColor,
      'checkboxOnColor' => controller.config.checkboxOnColor,
      'checkboxOffColor' => controller.config.checkboxOffColor,
      'cardBackgroundTint' => controller.config.cardBackgroundTint,
      'iconAccentColor' => controller.config.iconAccentColor,
      _ => controller.config.textAccentColor,
    };

    final picked = await showDialog<Color>(
      context: context,
      builder: (context) => _InlineColorDialog(initial: initial),
    );
    if (picked != null) {
      await controller.setComponentColor(componentKey, picked);
    }
  }
}

class _StudioHubItem {
  const _StudioHubItem({required this.title, required this.subtitle, required this.icon, required this.onTap});

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
}

class _StudioHubCard extends StatelessWidget {
  const _StudioHubCard({required this.item});

  final _StudioHubItem item;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: item.onTap,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white.withValues(alpha: 0.06),
            border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(item.icon, color: Colors.white, size: 22),
                const Spacer(),
                Text(item.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 17)),
                const SizedBox(height: 4),
                Text(item.subtitle, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 12.5)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ScopeEditor extends StatelessWidget {
  const _ScopeEditor({required this.controller});

  final MountStudioController controller;

  @override
  Widget build(BuildContext context) {
    return MountGlassCard(
      tint: controller.config.selectedColor,
      child: Column(
        children: <Widget>[
          _scope('Statusbar', controller.config.scopeStatusbar, (v) => controller.setScope(statusbar: v)),
          _scope('Control Center', controller.config.scopeControlCenter, (v) => controller.setScope(controlCenter: v)),
          _scope('Notifications', controller.config.scopeNotifications, (v) => controller.setScope(notifications: v)),
          _scope('Lockscreen', controller.config.scopeLockscreen, (v) => controller.setScope(lockscreen: v)),
          _scope('Settings', controller.config.scopeSettings, (v) => controller.setScope(settings: v)),
          _scope('Launcher', controller.config.scopeLauncher, (v) => controller.setScope(launcher: v)),
          _scope('Selected apps', controller.config.scopeSelectedApps, (v) => controller.setScope(selectedApps: v)),
        ],
      ),
    );
  }

  Widget _scope(String label, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile.adaptive(
      dense: true,
      contentPadding: EdgeInsets.zero,
      value: value,
      onChanged: onChanged,
      title: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
    );
  }
}

class _ThemeEngineStatus extends StatelessWidget {
  const _ThemeEngineStatus({required this.controller});

  final MountStudioController controller;

  @override
  Widget build(BuildContext context) {
    final paletteName = controller.config.selectedColorName;
    final status = controller.config.liveApplyEnabled ? 'Ready' : 'Saved';

    return MountGlassCard(
      tint: controller.config.selectedColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Theme Engine', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 22)),
          const SizedBox(height: 8),
          Text(
            'Current palette: $paletteName',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.82), fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            'App effects and target apps are managed from dedicated sections below.',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _StatusChip(label: status, active: controller.config.liveApplyEnabled),
              _StatusChip(label: 'Profiles ${controller.profiles.length}', active: true),
              _StatusChip(label: 'Target apps ${controller.selectedAppsCount}', active: true),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.label, required this.active});

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final color = active ? const Color(0xFF7CF6D1) : Colors.white70;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: active ? 0.5 : 0.25)),
        color: color.withValues(alpha: active ? 0.12 : 0.06),
      ),
      child: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 12)),
    );
  }
}

class _InlineColorDialog extends StatefulWidget {
  const _InlineColorDialog({required this.initial});

  final Color initial;

  @override
  State<_InlineColorDialog> createState() => _InlineColorDialogState();
}

class _InlineColorDialogState extends State<_InlineColorDialog> {
  late Color color;

  @override
  void initState() {
    super.initState();
    color = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF131B2A),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Expanded(child: Text('Pick component color', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800))),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close_rounded, color: Colors.white70)),
                ],
              ),
              CircleAvatar(radius: 22, backgroundColor: color),
              const SizedBox(height: 8),
              _rgbSlider(color.red.toDouble(), (v) => setState(() => color = color.withRed(v.round()))),
              _rgbSlider(color.green.toDouble(), (v) => setState(() => color = color.withGreen(v.round()))),
              _rgbSlider(color.blue.toDouble(), (v) => setState(() => color = color.withBlue(v.round()))),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: FilledButton(onPressed: () => Navigator.pop(context, color), child: const Text('Apply color')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _rgbSlider(double value, ValueChanged<double> onChanged) {
    return Slider(min: 0, max: 255, value: value.clamp(0, 255), onChanged: onChanged);
  }
}

class _BottomActionBar extends StatelessWidget {
  const _BottomActionBar({
    required this.onPreview,
    required this.onReset,
    required this.onApply,
    required this.liveApplyEnabled,
    required this.onLiveApplyChanged,
    required this.accentColor,
  });

  final VoidCallback onPreview;
  final VoidCallback onReset;
  final VoidCallback onApply;
  final bool liveApplyEnabled;
  final ValueChanged<bool> onLiveApplyChanged;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFF10222B).withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SwitchListTile.adaptive(
              dense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 6),
              activeThumbColor: accentColor,
              title: const Text('Live apply to DeadZone', style: TextStyle(fontSize: 13.5)),
              value: liveApplyEnabled,
              onChanged: onLiveApplyChanged,
            ),
            Row(
              children: <Widget>[
                Expanded(child: OutlinedButton(onPressed: onPreview, child: const Text('Preview'))),
                const SizedBox(width: 8),
                Expanded(child: OutlinedButton(onPressed: onReset, child: const Text('Reset'))),
                const SizedBox(width: 8),
                Expanded(child: FilledButton(onPressed: onApply, child: const Text('Apply changes'))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
