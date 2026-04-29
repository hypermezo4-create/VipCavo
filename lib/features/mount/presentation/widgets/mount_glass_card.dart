import 'package:deadzon/core/theme/deadzon_theme_controller.dart';
import 'package:flutter/material.dart';

class MountGlassCard extends StatelessWidget {
  const MountGlassCard({
    required this.child,
    super.key,
    this.padding = const EdgeInsets.all(16),
    this.radius = 24,
    this.tint,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final Color? tint;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            DeadzonThemeTokens.cardTint(context).withValues(alpha: 0.5),
            (tint ?? DeadzonThemeTokens.cardTint(context)).withValues(alpha: 0.24),
          ],
        ),
        border: Border.all(color: DeadzonThemeTokens.border(context)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: DeadzonThemeTokens.shadow(context),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}
