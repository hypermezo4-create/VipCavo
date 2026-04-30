import 'package:deadzon/core/theme/deadzon_theme_controller.dart';
import 'package:deadzon/core/theme/design_tokens.dart';
import 'package:deadzon/core/widgets/deadzone_color_picker_sheet.dart';
import 'package:deadzon/core/widgets/deadzone_settings_widgets.dart';
import 'package:deadzon/core/widgets/premium_top_bar.dart';
import 'package:deadzon/features/mount/presentation/mount_studio_controller.dart';
import 'package:deadzon/features/mount/presentation/widgets/mount_color_tab.dart';
import 'package:deadzon/features/mount/presentation/widgets/mount_components_tab.dart';
import 'package:deadzon/features/mount/presentation/widgets/mount_control_apps_tab.dart';
import 'package:deadzon/features/mount/presentation/widgets/mount_effects_tab.dart';
import 'package:deadzon/features/mount/presentation/widgets/mount_profiles_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MountStudioScreen extends StatelessWidget {
  const MountStudioScreen({super.key});

  static const List<String> _tabs = <String>[
    'Colors',
    'App Effects',
    'Components',
    'Control Apps',
    'Profiles',
  ];

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MountStudioController>();
    final contentBottomPadding = (controller.currentTab == 3 ? 320.0 : 248.0) + MediaQuery.paddingOf(context).bottom;

    return Container(
      decoration: const BoxDecoration(gradient: DesignTokens.baseGradient),
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            ListView(
              padding: EdgeInsets.fromLTRB(18, 14, 18, contentBottomPadding),
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              children: <Widget>[
                const PremiumTopBar(title: 'Mount Studio', subtitle: 'Monet colors, app effects & bridge targets'),
                const SizedBox(height: 14),
                DeadZoneSettingsCard(
                  child: _SegmentTabs(
                    tabs: _tabs,
                    current: controller.currentTab,
                    onTap: controller.setTab,
                  ),
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
              bottom: 12 + MediaQuery.paddingOf(context).bottom,
              child: _BottomActionBar(
                onRestore: () => _showRestoreDialog(context, controller),
                liveApplyEnabled: controller.config.liveApplyEnabled,
                onLiveApplyChanged: controller.setLiveApplyEnabled,
                accentColor: DeadzonThemeTokens.accent(context),
                onApply: () async {
                  await controller.apply();
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Mount applied successfully. Theme tokens and targets are now active.')),
                  );
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
        return MountColorTab(
          config: controller.config,
          paletteLibrary: controller.paletteLibrary,
          onPaletteSelected: controller.selectPalette,
          onTapItem: (key) => _showComponentColorPicker(context, controller, key),
        );
      case 1:
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
      case 2:
        return MountComponentsTab(
          config: controller.config,
          onTapItem: (key) => _showComponentColorPicker(context, controller, key),
          onShadowDepthChanged: (value) => controller.setSlider(shadowDepth: value),
        );
      case 3:
        return MountControlAppsTab(controller: controller);
      case 4:
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

  Future<void> _showRestoreDialog(BuildContext context, MountStudioController controller) async {
    final shouldReset = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Restore Mount settings?'),
        content: const Text('This will restore Mount colors, effects, components, and profiles to the default DeadZone setup.'),
        actions: <Widget>[
          TextButton(onPressed: () => Navigator.of(context).maybePop(false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.of(context).maybePop(true), child: const Text('Restore')),
        ],
      ),
    );
    if (shouldReset == true) {
      await controller.restoreDefaults();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Mount restored to DeadZone defaults.')));
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
          TextButton(onPressed: () => Navigator.of(context).maybePop(false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.of(context).maybePop(true), child: const Text('Restore')),
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
      'selectedColor' => controller.config.selectedColor,
      'seekbarColor' => controller.config.seekbarColor,
      'switchOnColor' => controller.config.switchOnColor,
      'switchOffColor' => controller.config.switchOffColor,
      'checkboxOnColor' => controller.config.checkboxOnColor,
      'checkboxOffColor' => controller.config.checkboxOffColor,
      'cardBackgroundTint' => controller.config.cardBackgroundTint,
      'iconAccentColor' => controller.config.iconAccentColor,
      'seekbarInactiveColor' => controller.config.componentColors['seekbarInactiveColor'] != null ? Color(controller.config.componentColors['seekbarInactiveColor']!) : controller.config.seekbarColor.withValues(alpha: 0.35),
      'seekbarThumbColor' => controller.config.componentColors['seekbarThumbColor'] != null ? Color(controller.config.componentColors['seekbarThumbColor']!) : controller.config.seekbarColor,
      'cardBorderColor' => controller.config.componentColors['cardBorderColor'] != null ? Color(controller.config.componentColors['cardBorderColor']!) : Colors.white24,
      'shadowColor' => controller.config.componentColors['shadowColor'] != null ? Color(controller.config.componentColors['shadowColor']!) : Colors.black54,
      'backgroundDark' => const Color(0xFF0D1218),
      'backgroundLight' => const Color(0xFFF3F7FB),
      'navSurface' => controller.config.cardBackgroundTint.withValues(alpha: 0.9),
      'navPill' => controller.config.selectedColor.withValues(alpha: 0.35),
      'navIcon' => controller.config.iconAccentColor,
      'stateSuccess' => const Color(0xFF43C58D),
      'stateWarning' => const Color(0xFFE8B04E),
      'stateError' => const Color(0xFFE46868),
      _ => controller.config.textAccentColor,
    };

    final int? pickedArgb = await showDeadZoneColorPicker(
      context: context,
      initialArgb: initial.toARGB32(),
      defaultArgb: initial.toARGB32(),
      title: 'Pick component color',
    );
    if (pickedArgb != null) {
      if (componentKey == 'selectedColor') {
        await controller.setSeedColor(Color(pickedArgb));
      } else {
        await controller.setComponentColor(componentKey, Color(pickedArgb));
      }
    }
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
      height: 44,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        itemCount: tabs.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemBuilder: (context, index) {
          final active = current == index;
          return Padding(
            padding: EdgeInsets.only(right: 8, left: index == 0 ? 2 : 0),
            child: ChoiceChip(
              selected: active,
              label: Text(tabs[index]),
              onSelected: (_) => onTap(index),
              labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: active ? 0.98 : 0.72),
                fontWeight: FontWeight.w600,
              ),
              selectedColor: DeadzonThemeTokens.accent(context).withValues(alpha: 0.3),
              backgroundColor: DeadzonThemeTokens.cardTint(context).withValues(alpha: 0.52),
              side: BorderSide(color: DeadzonThemeTokens.border(context)),
            ),
          );
        },
      ),
    );
  }
}

class _BottomActionBar extends StatelessWidget {
  const _BottomActionBar({
    required this.onRestore,
    required this.onApply,
    required this.liveApplyEnabled,
    required this.onLiveApplyChanged,
    required this.accentColor,
  });

  final VoidCallback onRestore;
  final VoidCallback onApply;
  final bool liveApplyEnabled;
  final ValueChanged<bool> onLiveApplyChanged;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: DeadzonThemeTokens.sheetBackground(context).withValues(alpha: 0.96),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: DeadzonThemeTokens.border(context)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SwitchListTile.adaptive(
              dense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 6),
              activeThumbColor: accentColor,
              title: Text(
                'Live apply to DeadZone',
                style: TextStyle(fontSize: 13.5, color: Theme.of(context).colorScheme.onSurface),
              ),
              value: liveApplyEnabled,
              onChanged: onLiveApplyChanged,
            ),
            Row(
              children: <Widget>[
                Expanded(child: OutlinedButton(onPressed: onRestore, child: const Text('Restore'))),
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
