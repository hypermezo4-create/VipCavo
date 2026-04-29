import 'package:deadzon/core/theme/deadzon_theme_controller.dart';
import 'package:deadzon/core/theme/design_tokens.dart';
import 'package:flutter/material.dart';

class DeadZoneSettingsCard extends StatelessWidget {
  const DeadZoneSettingsCard({required this.child, super.key, this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 10)});
  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: DeadzonThemeTokens.cardTint(context).withValues(alpha: isLight ? 0.86 : 0.28),
        border: Border.all(color: DeadzonThemeTokens.border(context)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: (isLight ? const Color(0xFFBFD0E8) : Colors.black).withValues(alpha: isLight ? 0.28 : 0.24),
            blurRadius: isLight ? 20 : 12,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class DeadZoneSectionHeader extends StatelessWidget {
  const DeadZoneSectionHeader({required this.title, this.subtitle, super.key});
  final String title;
  final String? subtitle;
  @override
  Widget build(BuildContext context) {
    final accent = DeadzonThemeTokens.accent(context);
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: accent, letterSpacing: 0.2)),
        if (subtitle != null) ...<Widget>[
          const SizedBox(height: 2),
          Text(subtitle!, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: onSurface.withValues(alpha: 0.68))),
        ],
      ]),
    );
  }
}

class DeadZoneNavigationRow extends StatelessWidget {
  const DeadZoneNavigationRow({required this.icon, required this.title, required this.subtitle, required this.onTap, super.key});
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: SizedBox(
        height: 64,
        child: Row(children: <Widget>[
          _DeadZoneIconChip(icon: icon),
          const SizedBox(width: 10),
          Expanded(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Text(title, style: TextStyle(fontSize: 15.4, fontWeight: FontWeight.w700, color: onSurface)),
              Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, color: onSurface.withValues(alpha: 0.7))),
            ]),
          ),
          Icon(Icons.chevron_right_rounded, color: onSurface.withValues(alpha: 0.6)),
        ]),
      ),
    );
  }
}

class _DeadZoneIconChip extends StatelessWidget {
  const _DeadZoneIconChip({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final accent = DeadzonThemeTokens.accent(context);
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.26)),
      ),
      child: Icon(icon, size: 21, color: accent),
    );
  }
}
