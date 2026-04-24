import 'package:deadzon/core/theme/deadzon_theme_controller.dart';
import 'package:deadzon/core/theme/design_tokens.dart';
import 'package:deadzon/core/widgets/premium_top_bar.dart';
import 'package:deadzon/features/mount/presentation/app_picker_screen.dart';
import 'package:deadzon/features/mount/presentation/mount_studio_controller.dart';
import 'package:deadzon/features/mount/presentation/widgets/mount_color_tab.dart';
import 'package:deadzon/features/mount/presentation/widgets/mount_components_tab.dart';
import 'package:deadzon/features/mount/presentation/widgets/mount_control_apps_tab.dart';
import 'package:deadzon/features/mount/presentation/widgets/mount_effects_tab.dart';
import 'package:deadzon/features/mount/presentation/widgets/mount_live_preview.dart';
import 'package:deadzon/features/mount/presentation/widgets/mount_profiles_tab.dart';
import 'package:deadzon/features/mount/presentation/widgets/mount_scope_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


int colorChannelTo255(double channel) {
  return (channel * 255.0).round().clamp(0, 255).toInt();
}


class MountStudioScreen extends StatelessWidget {
  const MountStudioScreen({super.key});

  static const List<String> _tabs = <String>[
    'Preview',
    'Colors',
    'Effects',
    'Components',
    'Scope',
    'Control Apps',
    'Profiles',
  ];

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MountStudioController>();

    return Container(
      decoration: const BoxDecoration(gradient: DesignTokens.baseGradient),
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            ListView(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 170),
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              children: <Widget>[
                const PremiumTopBar(title: 'Mount Studio', subtitle: 'Monet colors, effects & system accent'),
                const SizedBox(height: 14),
                _SegmentTabs(
                  tabs: _tabs,
                  current: controller.currentTab,
                  onTap: controller.setTab,
                ),
                const SizedBox(height: 14),
                if (controller.loading)
                  const Center(child: Padding(padding: EdgeInsets.all(32), child: CircularProgressIndicator()))
                else
                  _tabContent(context, controller),
              ],
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 12,
              child: _BottomActionBar(
                onPreview: () => controller.setTab(0),
                onReset: () => _showResetDialog(context, controller),
                liveApplyEnabled: controller.config.liveApplyEnabled,
                onLiveApplyChanged: controller.setLiveApplyEnabled,
                accentColor: DeadzonThemeTokens.accent(context),
                onApply: () async {
                  await controller.apply();
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved for ROM bridge. Applied inside DeadZon.')));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabContent(BuildContext context, MountStudioController controller) {
    switch (controller.currentTab) {
      case 0:
        return MountLivePreview(config: controller.config);
      case 1:
        return MountColorTab(
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
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Monet picker is not available on this ROM.')));
            }
          },
        );
      case 2:
        return MountEffectsTab(
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
        );
      case 3:
        return MountComponentsTab(
          config: controller.config,
          onTapItem: (key) => _showComponentColorPicker(context, controller, key),
        );
      case 4:
        return MountScopeTab(
          config: controller.config,
          onChanged: (key, value) {
            switch (key) {
              case 'scopeStatusbar':
                return controller.setScope(statusbar: value);
              case 'scopeControlCenter':
                return controller.setScope(controlCenter: value);
              case 'scopeNotifications':
                return controller.setScope(notifications: value);
              case 'scopeLockscreen':
                return controller.setScope(lockscreen: value);
              case 'scopeSettings':
                return controller.setScope(settings: value);
              case 'scopeLauncher':
                return controller.setScope(launcher: value);
              default:
                return controller.setScope(selectedApps: value);
            }
          },
          onChooseApps: () async {
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
        );
      case 5:
        return MountControlAppsTab(controller: controller);
      case 6:
        return MountProfilesTab(
          profiles: controller.profiles,
          activeProfileId: controller.config.activeProfileId,
          onProfileTap: controller.applyProfile,
          onResetProfile: () => _showResetProfileDialog(context, controller),
          onEditProfile: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile editing will be added in the next iteration.')));
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Future<void> _showResetDialog(BuildContext context, MountStudioController controller) async {
    final shouldReset = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Mount Studio?'),
        content: const Text('This will restore defaults for color, effects, components, scopes, and control apps.'),
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

  Future<void> _showResetProfileDialog(BuildContext context, MountStudioController controller) async {
    final shouldReset = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset active profile?'),
        content: const Text('This will restore the active profile values to their defaults.'),
        actions: <Widget>[
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Reset')),
        ],
      ),
    );
    if (shouldReset == true) {
      await controller.resetCurrentProfileToDefault();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile reset complete.')));
      }
    }
  }

  Future<void> _showComponentColorPicker(
    BuildContext context,
    MountStudioController controller,
    String componentKey,
  ) async {
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
    return AlertDialog(
      title: const Text('Pick component color'),
      content: SizedBox(
        width: 320,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(radius: 22, backgroundColor: color),
            Slider(
              min: 0,
              max: 255,
              value: colorChannelTo255(color.r).toDouble(),
              onChanged: (v) => setState(() {
                final g = colorChannelTo255(color.g);
                final b = colorChannelTo255(color.b);
                color = Color.fromARGB(255, v.round(), g, b);
              }),
            ),
            Slider(
              min: 0,
              max: 255,
              value: colorChannelTo255(color.g).toDouble(),
              onChanged: (v) => setState(() {
                final r = colorChannelTo255(color.r);
                final b = colorChannelTo255(color.b);
                color = Color.fromARGB(255, r, v.round(), b);
              }),
            ),
            Slider(
              min: 0,
              max: 255,
              value: colorChannelTo255(color.b).toDouble(),
              onChanged: (v) => setState(() {
                final r = colorChannelTo255(color.r);
                final g = colorChannelTo255(color.g);
                color = Color.fromARGB(255, r, g, v.round());
              }),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(onPressed: () => Navigator.pop(context, color), child: const Text('Apply')),
      ],
    );
  }
}

class _SegmentTabs extends StatelessWidget {
  const _SegmentTabs({required this.tabs, required this.current, required this.onTap});

  final List<String> tabs;
  final int current;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.builder(
        itemCount: tabs.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final active = current == index;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              selected: active,
              label: Text(tabs[index]),
              onSelected: (_) => onTap(index),
              labelStyle: TextStyle(color: Colors.white.withValues(alpha: active ? 0.98 : 0.72), fontWeight: FontWeight.w600),
              selectedColor: DeadzonThemeTokens.accent(context).withValues(alpha: 0.3),
              backgroundColor: Colors.white.withValues(alpha: 0.08),
              side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
            ),
          );
        },
      ),
    );
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
              title: const Text('Live apply to DeadZon', style: TextStyle(fontSize: 13.5)),
              value: liveApplyEnabled,
              onChanged: onLiveApplyChanged,
            ),
            Row(
              children: <Widget>[
                Expanded(child: OutlinedButton(onPressed: onPreview, child: const Text('Preview'))),
                const SizedBox(width: 8),
                Expanded(child: OutlinedButton(onPressed: onReset, child: const Text('Reset'))),
                const SizedBox(width: 8),
                Expanded(child: FilledButton(onPressed: onApply, child: const Text('Apply'))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
