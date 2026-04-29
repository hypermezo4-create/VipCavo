import 'package:deadzon/core/theme/deadzon_theme_controller.dart';
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
            color: DeadzonThemeTokens.shadow(context),
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
    final accent = DeadzonThemeTokens.iconAccent(context);
    final onSurface = DeadzonThemeTokens.textPrimary(context);
    final secondary = DeadzonThemeTokens.textSecondary(context);
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
  const DeadZoneNavigationRow({required this.icon, required this.title, required this.subtitle, required this.onTap, this.trailing, super.key});
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final onSurface = DeadzonThemeTokens.textPrimary(context);
    final secondary = DeadzonThemeTokens.textSecondary(context);
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: SizedBox(
        height: 64,
        child: Row(children: <Widget>[
          DeadZoneIconChip(icon: icon),
          const SizedBox(width: 10),
          Expanded(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Text(title, style: TextStyle(fontSize: 15.4, fontWeight: FontWeight.w700, color: onSurface)),
              Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, color: secondary.withValues(alpha: 0.86))),
            ]),
          ),
          trailing ?? Icon(Icons.chevron_right_rounded, color: DeadzonThemeTokens.iconAccent(context).withValues(alpha: 0.74)),
        ]),
      ),
    );
  }
}

class DeadZoneIconChip extends StatelessWidget {
  const DeadZoneIconChip({required this.icon, super.key, this.selected = true});
  final IconData icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final accent = DeadzonThemeTokens.accent(context);
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: accent.withValues(alpha: selected ? 0.16 : 0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: selected ? 0.26 : 0.18)),
      ),
      child: Icon(icon, size: 21, color: selected ? accent : accent.withValues(alpha: 0.84)),
    );
  }
}

class DeadZoneValueChip extends StatelessWidget {
  const DeadZoneValueChip({required this.label, super.key});
  final String label;

  @override
  Widget build(BuildContext context) {
    final accent = DeadzonThemeTokens.accent(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.22)),
      ),
      child: Text(label, style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: accent)),
    );
  }
}

class DeadZoneSwitchRow extends StatelessWidget {
  const DeadZoneSwitchRow({required this.icon, required this.title, required this.value, required this.onChanged, this.subtitle, super.key});
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final onSurface = DeadzonThemeTokens.textPrimary(context);
    final secondary = DeadzonThemeTokens.textSecondary(context);
    return SizedBox(
      height: 68,
      child: Row(children: <Widget>[
        DeadZoneIconChip(icon: icon),
        const SizedBox(width: 10),
        Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Text(title, style: TextStyle(fontSize: 15.2, fontWeight: FontWeight.w600, color: onSurface)),
          if (subtitle != null) Text(subtitle!, style: TextStyle(fontSize: 12, color: secondary.withValues(alpha: 0.86))),
        ])),
        SwitchTheme(
          data: SwitchThemeData(
            thumbColor: WidgetStateProperty.resolveWith((states) => states.contains(WidgetState.selected) ? DeadzonThemeTokens.switchActive(context) : DeadzonThemeTokens.switchInactive(context)),
            trackColor: WidgetStateProperty.resolveWith((states) => states.contains(WidgetState.selected) ? DeadzonThemeTokens.switchActive(context).withValues(alpha: 0.46) : DeadzonThemeTokens.switchInactive(context).withValues(alpha: 0.42)),
          ),
          child: Switch.adaptive(value: value, onChanged: onChanged),
        ),
      ]),
    );
  }
}

class DeadZoneSliderRow extends StatelessWidget {
  const DeadZoneSliderRow({
    required this.icon,
    required this.title,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    super.key,
    this.subtitle,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final onSurface = DeadzonThemeTokens.textPrimary(context);
    final secondary = DeadzonThemeTokens.textSecondary(context);
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            DeadZoneIconChip(icon: icon),
            const SizedBox(width: 10),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: onSurface)),
                if (subtitle != null) Text(subtitle!, style: TextStyle(fontSize: 12, color: secondary.withValues(alpha: 0.86))),
              ]),
            ),
            DeadZoneValueChip(label: value.toStringAsFixed(0)),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: DeadzonThemeTokens.sliderActive(context),
            thumbColor: DeadzonThemeTokens.sliderActive(context),
            inactiveTrackColor: DeadzonThemeTokens.sliderInactive(context),
          ),
          child: Slider(value: value, min: min, max: max, onChanged: onChanged),
        ),
      ],
    );
  }
}

class DeadZoneSelectRow extends StatelessWidget {
  const DeadZoneSelectRow({required this.icon, required this.title, required this.valueLabel, required this.onTap, super.key, this.subtitle});
  final IconData icon;
  final String title;
  final String valueLabel;
  final String? subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return DeadZoneNavigationRow(
      icon: icon,
      title: title,
      subtitle: subtitle ?? valueLabel,
      trailing: DeadZoneValueChip(label: valueLabel),
      onTap: onTap,
    );
  }
}

class DeadZoneColorRow extends StatelessWidget {
  const DeadZoneColorRow({
    required this.icon,
    required this.title,
    required this.argb,
    required this.onTap,
    super.key,
    this.subtitle,
  });

  final IconData icon;
  final String title;
  final int argb;
  final String? subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hex = '#${argb.toRadixString(16).padLeft(8, '0').toUpperCase()}';
    return DeadZoneNavigationRow(
      icon: icon,
      title: title,
      subtitle: subtitle ?? hex,
      trailing: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: Color(argb),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: DeadzonThemeTokens.border(context)),
        ),
      ),
      onTap: onTap,
    );
  }
}


class DeadZoneFontRow extends StatelessWidget {
  const DeadZoneFontRow({
    required this.icon,
    required this.title,
    required this.valueLabel,
    required this.onTap,
    super.key,
    this.subtitle,
  });

  final IconData icon;
  final String title;
  final String valueLabel;
  final String? subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return DeadZoneNavigationRow(
      icon: icon,
      title: title,
      subtitle: subtitle ?? valueLabel,
      trailing: DeadZoneValueChip(label: valueLabel),
      onTap: onTap,
    );
  }
}
