import 'package:deadzon/core/theme/design_tokens.dart';
import 'package:flutter/material.dart';

class PremiumTopBar extends StatelessWidget {
  const PremiumTopBar({
    required this.title,
    required this.subtitle,
    super.key,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;
    return Container(
      padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: textColor,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
                fontSize: DesignTokens.mainTitle,
              ),
        ),
        const SizedBox(height: 3),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: textColor.withValues(alpha: 0.74),
                height: 1.35,
                fontSize: DesignTokens.pageSubtitle,
              ),
        ),
      ],
    ));
  }
}
