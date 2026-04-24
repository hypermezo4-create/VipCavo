import 'package:deadzon/core/theme/design_tokens.dart';
import 'package:deadzon/core/widgets/glass_card.dart';
import 'package:deadzon/core/widgets/premium_top_bar.dart';
import 'package:deadzon/core/widgets/section_header.dart';
import 'package:flutter/material.dart';

class HubToolScreen extends StatefulWidget {
  const HubToolScreen({
    required this.title,
    required this.subtitle,
    required this.modules,
    super.key,
  });

  final String title;
  final String subtitle;
  final List<HubModuleDefinition> modules;

  @override
  State<HubToolScreen> createState() => _HubToolScreenState();
}

class _HubToolScreenState extends State<HubToolScreen> {
  late final Map<String, bool> _toggles;
  late final Map<String, double> _sliders;

  @override
  void initState() {
    super.initState();
    _toggles = <String, bool>{
      for (final module in widget.modules)
        for (final toggle in module.toggles) toggle.id: toggle.defaultValue,
    };
    _sliders = <String, double>{
      for (final module in widget.modules)
        for (final slider in module.sliders) slider.id: slider.defaultValue,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: DesignTokens.baseGradient),
      child: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          padding: DesignTokens.pagePadding,
          children: <Widget>[
            PremiumTopBar(title: widget.title, subtitle: widget.subtitle),
            const SizedBox(height: 16),
            for (final module in widget.modules) ...<Widget>[
              SectionHeader(title: module.title, subtitle: module.subtitle),
              const SizedBox(height: 8),
              GlassCard(
                child: Column(
                  children: <Widget>[
                    for (var i = 0; i < module.toggles.length; i++) ...<Widget>[
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        value: _toggles[module.toggles[i].id] ?? false,
                        onChanged: (value) => setState(() => _toggles[module.toggles[i].id] = value),
                        title: Text(module.toggles[i].title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                        subtitle: Text(module.toggles[i].subtitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.72))),
                      ),
                      if (i != module.toggles.length - 1 || module.sliders.isNotEmpty) const Divider(height: 20),
                    ],
                    for (var i = 0; i < module.sliders.length; i++) ...<Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(module.sliders[i].title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                          ),
                          Text((_sliders[module.sliders[i].id] ?? module.sliders[i].defaultValue).toStringAsFixed(0),
                              style: const TextStyle(color: Colors.white70)),
                        ],
                      ),
                      Slider(
                        value: _sliders[module.sliders[i].id] ?? module.sliders[i].defaultValue,
                        min: module.sliders[i].min,
                        max: module.sliders[i].max,
                        onChanged: (value) => setState(() => _sliders[module.sliders[i].id] = value),
                      ),
                      if (i != module.sliders.length - 1) const Divider(height: 18),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 14),
            ],
          ],
        ),
      ),
    );
  }
}

class HubModuleDefinition {
  const HubModuleDefinition({
    required this.title,
    required this.subtitle,
    this.toggles = const <HubToggleDefinition>[],
    this.sliders = const <HubSliderDefinition>[],
  });

  final String title;
  final String subtitle;
  final List<HubToggleDefinition> toggles;
  final List<HubSliderDefinition> sliders;
}

class HubToggleDefinition {
  const HubToggleDefinition({
    required this.id,
    required this.title,
    required this.subtitle,
    this.defaultValue = true,
  });

  final String id;
  final String title;
  final String subtitle;
  final bool defaultValue;
}

class HubSliderDefinition {
  const HubSliderDefinition({
    required this.id,
    required this.title,
    required this.min,
    required this.max,
    required this.defaultValue,
  });

  final String id;
  final String title;
  final double min;
  final double max;
  final double defaultValue;
}
