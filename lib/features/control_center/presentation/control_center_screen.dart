import 'dart:ui';

import 'package:deadzon/core/theme/deadzon_theme_controller.dart';
import 'package:deadzon/core/theme/design_tokens.dart';
import 'package:deadzon/features/control_center/domain/control_center_config.dart';
import 'package:deadzon/features/control_center/services/control_center_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ControlCenterScreen extends StatefulWidget {
  const ControlCenterScreen({super.key});

  @override
  State<ControlCenterScreen> createState() => _ControlCenterScreenState();
}

class _ControlCenterScreenState extends State<ControlCenterScreen> {
  final _service = ControlCenterService();
  ControlCenterConfig _config = ControlCenterConfig.defaults();
  bool _loading = true;
  bool _saving = false;

  @override
  void initState() { super.initState(); _load(); }
  Future<void> _load() async { final c = await _service.loadConfig(); if(!mounted) return; setState(() { _config = c; _loading = false; }); }

  static const _groups = <String, List<_Item>>{
    'Appearance':[ _Item('MonetUI','monetmode',Icons.palette_rounded), _Item('Glass Effect','glass_effect',Icons.layers_rounded), _Item('Reduced Blur','bgblur',Icons.blur_on_rounded), _Item('Rounded Corners','CustomCornerRadius',Icons.rounded_corner_rounded), _Item('Compact DPI','compactdpi',Icons.fit_screen_rounded)],
    'Layout Styles':[ _Item('4 Tiles Layout','4tile',Icons.grid_view_rounded), _Item('Ladder Layout','style2',Icons.view_stream_rounded)],
    'Large MediaPlayer Styles':[ _Item('Expanded MediaPlayer','largemedia',Icons.library_music_rounded), _Item('Lowered MediaPlayer','largemedia1',Icons.vertical_align_bottom_rounded)],
    'Card Customisation':[ _Item('Circle Card Look','circlecard',Icons.circle_outlined), _Item('Custom Touch Effect','cardtouch',Icons.touch_app_rounded)],
    'Preferences':[ _Item('Enable Sound Tile','hidesound',Icons.volume_up_rounded), _Item('Small Device Center','devicesize',Icons.devices_rounded), _Item('Square Tiles','squaretiles',Icons.crop_square_rounded)],
    'Edit Button Styles':[ _Item('Top Clock + Edit Button','custom_clock',Icons.schedule_rounded), _Item('Default Edit Button','defaultedit',Icons.edit_rounded), _Item('Traffic Edit Button','traffic',Icons.traffic_rounded)],
    'Customize Sliders':[ _Item('Modern Slider Icons','slidericon',Icons.tune_rounded), _Item('BlendBlur Sliders Icon','bgblur',Icons.blur_circular_rounded), _Item('Percentage on Sliders','percent',Icons.percent_rounded)],
    'Volume Panel':[ _Item('Small Volume Panel','smallvolume',Icons.volume_down_rounded), _Item('Lower Volume Panel','columndown',Icons.south_rounded), _Item('Rounded Shortcuts','circlebuttons',Icons.apps_rounded), _Item('Hide Dnd & Silent','HideButtons',Icons.do_not_disturb_on_rounded), _Item('Hide More Icons','hidemore',Icons.more_horiz_rounded)],
    'Advanced Options':[ _Item('Extended Hyper Island','extended_hyper_island',Icons.auto_awesome_rounded), _Item('Extended Power Menu','powermenu',Icons.power_settings_new_rounded)],
  };

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final accent = context.watch<DeadzonThemeController>().accentColor;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(gradient: dark ? DesignTokens.baseGradient : const LinearGradient(colors: [Color(0xFFF5FAFF), Color(0xFFEAF4FF)], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SafeArea(
          child: _loading ? const Center(child: CircularProgressIndicator()) : Column(children: [
            const Padding(padding: EdgeInsets.fromLTRB(20, 12, 20, 4), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Control Center',style: TextStyle(fontSize: 34,fontWeight: FontWeight.w800)), SizedBox(height: 6), Text('Panel styles, layout, sliders, media and advanced controls')])) ,
            Expanded(child: ListView(padding: const EdgeInsets.fromLTRB(16,12,16,120), children: [for(final entry in _groups.entries)...[Text(entry.key, style: TextStyle(color: dark ? Colors.white70 : const Color(0xFF334155),fontSize: 28/1.4,fontWeight: FontWeight.w600)), const SizedBox(height: 10), ...entry.value.map((item)=>Padding(padding: const EdgeInsets.only(bottom: 12), child: _row(item, dark, accent))), const SizedBox(height: 10)]])),
          ]),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
          child: FilledButton(
            onPressed: _saving ? null : () async {
              setState(() => _saving = true);
              final applied = await _service.saveAndApplyConfig(_config);
              if (!mounted) return;
              setState(() => _saving = false);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(applied ? 'Changes saved.' : 'Saved in DeadZone. System apply requires ROM integration.')));
            },
            style: FilledButton.styleFrom(backgroundColor: const Color(0xFF2D7CF6), padding: const EdgeInsets.symmetric(vertical: 18), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
            child: Text(_saving ? 'APPLYING...' : 'APPLY CHANGES', style: const TextStyle(fontWeight: FontWeight.w700,letterSpacing: .6)),
          ),
        ),
      ),
    );
  }

  Widget _row(_Item item, bool dark, Color accent) {
    final value = _config.read(item.key);
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          decoration: BoxDecoration(color: dark ? Colors.white.withOpacity(.12) : Colors.white.withOpacity(.86), borderRadius: BorderRadius.circular(24), border: Border.all(color: dark ? Colors.white12 : const Color(0xFFD5E4F6))),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(children: [Container(width: 54,height: 54,decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white.withOpacity(.1)), clipBehavior: Clip.antiAlias, child: Icon(item.icon, color: accent, size: 30)), const SizedBox(width: 12), Expanded(child: Text(item.label, style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500))), Switch(value: value, activeColor: Colors.white, activeTrackColor: const Color(0xFF2D7CF6), onChanged: (v){ final map = Map<String, bool>.from(_config.values); map[item.key]=v; setState(() => _config = _config.copyWith(values: map)); })]),
        ),
      ),
    );
  }
}

class _Item { const _Item(this.label,this.key,this.icon); final String label; final String key; final IconData icon; }
