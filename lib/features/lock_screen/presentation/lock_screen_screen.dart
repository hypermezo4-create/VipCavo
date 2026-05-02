import 'package:deadzon/core/theme/deadzon_theme_controller.dart';
import 'package:deadzon/core/widgets/deadzone_settings_widgets.dart';
import 'package:deadzon/core/widgets/premium_top_bar.dart';
import 'package:deadzon/features/statusbar/data/statusbar_settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LockScreenScreen extends StatefulWidget {
  const LockScreenScreen({super.key});

  @override
  State<LockScreenScreen> createState() => _LockScreenScreenState();
}

class _LockScreenScreenState extends State<LockScreenScreen> {
  static const String _fodKey = 'android.theme.customization.fod_icon';
  static const String _fodSourcePath = 'mobx.settings.overlay.icon.fod.fodIcons';

  bool _showNotif = true;
  bool _vibrateOn = false;
  int _chargeAnimationType = 1;
  bool _extraChargingInfo = true;
  bool _showTemp = true;
  bool _hideOriginalText = true;
  bool _showAmpere = true;
  bool _showVoltage = false;
  bool _showPower = true;
  int _refreshInterval = 2000;
  double _chargingTextSize = 15;
  String _selectedFod = 'default';
  bool _isApplying = false;

  final List<_SelectOption> _chargeAnimationOptions = const <_SelectOption>[
    _SelectOption('Classic', '0'),
    _SelectOption('Modern', '1'),
    _SelectOption('Pulse', '2'),
  ];
  final List<_SelectOption> _refreshOptions = const <_SelectOption>[
    _SelectOption('500 ms', '500'),
    _SelectOption('1000 ms', '1000'),
    _SelectOption('2000 ms', '2000'),
    _SelectOption('3000 ms', '3000'),
  ];
  final List<_FodOption> _fodOptions = const <_FodOption>[
    _FodOption(value: 'default', label: 'Default', icon: Icons.circle_outlined),
  ];

  @override
  void initState() {
    super.initState();
    _loadValues();
  }

  Future<void> _loadValues() async {
    _showNotif = await _readBool('show_notif_mezo_lock', true);
    _vibrateOn = await _readBool('vibrate_mezo_on', false);
    _chargeAnimationType = await _readInt('charge_animation_type', 1);
    _extraChargingInfo = await _readBool('bg_extra_charging_info', true);
    _showTemp = await _readBool('bg_show_temp', true);
    _hideOriginalText = await _readBool('bg_hide_original_charging_text', true);
    _showAmpere = await _readBool('bg_show_ampere', true);
    _showVoltage = await _readBool('bg_show_voltage', false);
    _showPower = await _readBool('bg_show_power', true);
    _refreshInterval = await _readInt('bg_refresh_interval', 2000);
    _chargingTextSize = (await _readInt('bg_charging_info_text_size', 15)).toDouble();
    _selectedFod = await _readString(_fodKey, 'default');
    if (mounted) setState(() {});
  }

  Future<void> _apply() async {
    setState(() => _isApplying = true);
    var nativeWriteOk = true;
    try {
      await StatusbarSettingsRepository.writeLoose('show_notif_mezo_lock', _showNotif ? 1 : 0);
      await StatusbarSettingsRepository.writeLoose('vibrate_mezo_on', _vibrateOn ? 1 : 0);
      await StatusbarSettingsRepository.writeLoose('charge_animation_type', _chargeAnimationType);
      await StatusbarSettingsRepository.writeLoose('bg_extra_charging_info', _extraChargingInfo ? 1 : 0);
      await StatusbarSettingsRepository.writeLoose('bg_show_temp', _showTemp ? 1 : 0);
      await StatusbarSettingsRepository.writeLoose('bg_hide_original_charging_text', _hideOriginalText ? 1 : 0);
      await StatusbarSettingsRepository.writeLoose('bg_show_ampere', _showAmpere ? 1 : 0);
      await StatusbarSettingsRepository.writeLoose('bg_show_voltage', _showVoltage ? 1 : 0);
      await StatusbarSettingsRepository.writeLoose('bg_show_power', _showPower ? 1 : 0);
      await StatusbarSettingsRepository.writeLoose('bg_refresh_interval', _refreshInterval);
      await StatusbarSettingsRepository.writeLoose('bg_charging_info_text_size', _chargingTextSize.round());
      await StatusbarSettingsRepository.writeLoose(_fodKey, _selectedFod);
    } catch (_) {
      nativeWriteOk = false;
    }
    if (!mounted) return;
    setState(() => _isApplying = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(nativeWriteOk ? 'Applied. Lock screen settings saved.' : 'Saved in DeadZone. Lock screen apply requires ROM integration.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bgTop = DeadzonThemeTokens.appBackground(context);
    final bgBottom = DeadzonThemeTokens.pageBackground(context);
    final chargingEnabled = _extraChargingInfo;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: <Color>[bgTop, bgBottom])),
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.fromLTRB(14, 10, 14, MediaQuery.paddingOf(context).bottom + 24),
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(onPressed: () => context.go('/home'), icon: const Icon(Icons.arrow_back_rounded)),
              ),
              const SizedBox(height: 4),
              const PremiumTopBar(
                title: 'Lock screen',
                subtitle: 'FOD icon, lock notifications and charging info',
              ),
              const SizedBox(height: 12),
              const DeadZoneSectionHeader(title: 'Identity'),
              DeadZoneSettingsCard(child: DeadZoneSelectRow(icon: Icons.fingerprint_rounded, title: 'FOD icon', subtitle: 'Fingerprint unlock icon style', valueLabel: _friendlyFod(_selectedFod), onTap: () => _openFodPicker(sourcePath: _fodSourcePath))),
              const SizedBox(height: 12),
              const DeadZoneSectionHeader(title: 'Lock Behavior'),
              DeadZoneSettingsCard(child: Column(children: <Widget>[
                DeadZoneSwitchRow(icon: Icons.notifications_active_rounded, title: 'Show notifications on lock screen', value: _showNotif, onChanged: (v) => setState(() => _showNotif = v)),
                const Divider(height: 1),
                DeadZoneSwitchRow(icon: Icons.vibration_rounded, title: 'Vibrate on lock', value: _vibrateOn, onChanged: (v) => setState(() => _vibrateOn = v)),
              ])),
              const SizedBox(height: 12),
              const DeadZoneSectionHeader(title: 'Charging Animation'),
              DeadZoneSettingsCard(child: DeadZoneSelectRow(icon: Icons.bolt_rounded, title: 'Charge animation style', valueLabel: _chargeAnimationLabel(), onTap: () => _openSelectSheet('Charge animation style', _chargeAnimationOptions, (val) => setState(() => _chargeAnimationType = int.parse(val))))),
              const SizedBox(height: 12),
              const DeadZoneSectionHeader(title: 'Charging Info'),
              DeadZoneSettingsCard(child: Column(children: <Widget>[
                DeadZoneSwitchRow(icon: Icons.info_outline_rounded, title: 'Extra charging info', value: _extraChargingInfo, onChanged: (v) => setState(() => _extraChargingInfo = v)),
                const Divider(height: 1),
                _dependentSwitch('Show temperature', _showTemp, (v) => _showTemp = v, Icons.thermostat_rounded, chargingEnabled),
                const Divider(height: 1),
                _dependentSwitch('Hide original charging text', _hideOriginalText, (v) => _hideOriginalText = v, Icons.text_fields_rounded, chargingEnabled),
                const Divider(height: 1),
                _dependentSwitch('Show ampere', _showAmpere, (v) => _showAmpere = v, Icons.electric_bolt_rounded, chargingEnabled),
                const Divider(height: 1),
                _dependentSwitch('Show voltage', _showVoltage, (v) => _showVoltage = v, Icons.battery_2_bar_rounded, chargingEnabled),
                const Divider(height: 1),
                _dependentSwitch('Show power', _showPower, (v) => _showPower = v, Icons.flash_on_rounded, chargingEnabled),
                const Divider(height: 1),
                _dependentSelect(chargingEnabled),
                const Divider(height: 1),
                Opacity(opacity: chargingEnabled ? 1 : 0.45, child: IgnorePointer(ignoring: !chargingEnabled, child: Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: DeadZoneAdjustmentRow(icon: Icons.format_size_rounded, title: 'Charging info text size', value: _chargingTextSize, min: 0, max: 30, step: 1, defaultValue: 15, onChanged: (v) => setState(() => _chargingTextSize = v), onReset: () => setState(() => _chargingTextSize = 15))))),
              ])),
              const SizedBox(height: 14),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton.icon(
                  onPressed: _isApplying ? null : _apply,
                  icon: _isApplying ? const SizedBox(height: 14, width: 14, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.done_rounded),
                  label: const Text('Apply'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Future<bool> _readBool(String key, bool fallback) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.get(key);
    if (raw is bool) return raw;
    if (raw is int) return raw == 1;
    return fallback;
  }

  Future<int> _readInt(String key, int fallback) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.get(key);
    if (raw is int) return raw;
    if (raw is num) return raw.round();
    return fallback;
  }

  Future<String> _readString(String key, String fallback) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(key);
    if (raw == null || raw.isEmpty) return fallback;
    return raw;
  }

  Widget _dependentSwitch(String title, bool value, ValueChanged<bool> onChanged, IconData icon, bool enabled) {
    return Opacity(opacity: enabled ? 1 : 0.45, child: IgnorePointer(ignoring: !enabled, child: DeadZoneSwitchRow(icon: icon, title: title, value: value, onChanged: (v) => setState(() => onChanged(v)))));
  }

  Widget _dependentSelect(bool enabled) {
    return Opacity(
      opacity: enabled ? 1 : 0.45,
      child: IgnorePointer(
        ignoring: !enabled,
        child: DeadZoneSelectRow(icon: Icons.schedule_rounded, title: 'Refresh interval', valueLabel: _refreshLabel(), onTap: () => _openSelectSheet('Refresh interval', _refreshOptions, (val) => setState(() => _refreshInterval = int.parse(val)))),
      ),
    );
  }

  Future<void> _openFodPicker({required String sourcePath}) async {
    final pickerSourcePath = sourcePath;

    await showModalBottomSheet<void>(
      context: context,
      useRootNavigator: false,
      builder: (context) {
        assert(pickerSourcePath.isNotEmpty);
        if (_fodOptions.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(20),
            child: Text('FOD icon picker is prepared for ROM integration.'),
          );
        }
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: _fodOptions.map((option) => ListTile(
              leading: DeadZoneIconChip(icon: option.icon),
              title: Text(option.label),
              trailing: _selectedFod == option.value ? const Icon(Icons.check_rounded) : null,
              onTap: () {
                setState(() => _selectedFod = option.value);
                Navigator.of(context).pop();
              },
            )).toList(),
          ),
        );
      },
    );
  }

  Future<void> _openSelectSheet(String title, List<_SelectOption> options, ValueChanged<String> onSelect) async {
    await showModalBottomSheet<void>(
      context: context,
      useRootNavigator: false,
      builder: (context) => SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          ListTile(title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700))),
          ...options.map((option) => ListTile(title: Text(option.label), onTap: () {
            onSelect(option.value);
            Navigator.of(context).pop();
          })),
        ]),
      ),
    );
  }

  String _chargeAnimationLabel() => _chargeAnimationOptions.firstWhere((e) => e.value == _chargeAnimationType.toString(), orElse: () => _chargeAnimationOptions[1]).label;
  String _refreshLabel() => _refreshOptions.firstWhere((e) => e.value == _refreshInterval.toString(), orElse: () => _refreshOptions[2]).label;
  static String _friendlyFod(String value) => value == 'default' ? 'Default' : 'Custom';
}

class _SelectOption {
  const _SelectOption(this.label, this.value);
  final String label;
  final String value;
}

class _FodOption {
  const _FodOption({required this.value, required this.label, required this.icon});
  final String value;
  final String label;
  final IconData icon;
}

