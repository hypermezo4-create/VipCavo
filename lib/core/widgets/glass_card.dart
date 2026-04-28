import 'dart:ui';

import 'package:deadzon/core/theme/deadzon_theme_controller.dart';
import 'package:deadzon/core/theme/design_tokens.dart';
import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  const GlassCard({
    required this.child,
    super.key,
    this.padding = const EdgeInsets.all(15),
    this.onTap,
    this.borderRadius = DesignTokens.radiusCard,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final card = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
        child: AnimatedContainer(
          duration: DesignTokens.motionFast,
          curve: DesignTokens.motionCurve,
          padding: padding,
          decoration: BoxDecoration(
            color: DeadzonThemeTokens.cardTint(context).withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: DeadzonThemeTokens.border(context)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 14,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );

    if (onTap == null) return card;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onTap,
        child: card,
      ),
    );
  }
}
