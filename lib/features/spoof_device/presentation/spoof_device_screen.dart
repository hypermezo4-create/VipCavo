import 'package:deadzon/core/services/android_intent_bridge.dart';
import 'package:deadzon/core/theme/design_tokens.dart';
import 'package:deadzon/core/widgets/glass_card.dart';
import 'package:deadzon/core/widgets/premium_top_bar.dart';
import 'package:flutter/material.dart';

class SpoofDeviceScreen extends StatelessWidget {
  const SpoofDeviceScreen({super.key});

  static const String _kaoriosPackage = 'com.kousei.kaorios';

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;
    return Container(
      decoration: const BoxDecoration(gradient: DesignTokens.baseGradient),
      child: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          padding: DesignTokens.pagePadding,
          children: <Widget>[
            const PremiumTopBar(
              title: 'Spoof device',
              subtitle: 'Open Kaorios Toolbox for profiles and presets',
            ),
            const SizedBox(height: 16),
            GlassCard(
              onTap: () => _launchKaorios(context),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  radius: 22,
                  child: Icon(Icons.open_in_new_rounded),
                ),
                title: Text('Open Kaorios Toolbox', style: TextStyle(color: textColor, fontWeight: FontWeight.w700)),
                subtitle: Text('Launch external app package: $_kaoriosPackage', style: TextStyle(color: textColor.withValues(alpha: 0.72))),
                trailing: const Icon(Icons.chevron_right_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchKaorios(BuildContext context) async {
    final ok = await AndroidIntentBridge.openExternalApp(_kaoriosPackage);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(ok ? 'Opening Kaorios Toolbox…' : 'Kaorios Toolbox is not installed.'),
      ),
    );
  }
}
