import 'package:deadzon/core/services/android_intent_bridge.dart';
import 'package:deadzon/core/theme/deadzon_theme_controller.dart';
import 'package:deadzon/core/utils/deadzone_color_utils.dart';
import 'package:deadzon/core/widgets/deadzone_color_picker_sheet.dart';
import 'package:deadzon/core/widgets/deadzone_settings_widgets.dart';
import 'package:deadzon/core/widgets/premium_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  bool _loading = true;
  bool _applying = false;

  bool _fullCallWindow = false;
  bool _coloredMezoNames = false;

  int _contactMezoColor = 0x00000000;
  int _incomingMezoColor = 0x00000000;
  int _outgoingMezoColor = 0x00000000;
  int _missedMezoColor = 0x00000000;
  int _rejectedMezoColor = 0x00000000;
  int _voicemailMezoColor = 0x00000000;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final loaded = await Future.wait<Object>([
      AndroidIntentBridge.readBool('full_call_window', defaultValue: false),
      AndroidIntentBridge.readBool('colored_mezo_names', defaultValue: false),
      AndroidIntentBridge.readString('contact_mezo_color', defaultValue: '#00000000'),
      AndroidIntentBridge.readString('incoming_mezo_color', defaultValue: '#00000000'),
      AndroidIntentBridge.readString('outgoing_mezo_color', defaultValue: '#00000000'),
      AndroidIntentBridge.readString('missed_mezo_color', defaultValue: '#00000000'),
      AndroidIntentBridge.readString('rejected_mezo_color', defaultValue: '#00000000'),
      AndroidIntentBridge.readString('voicemail_mezo_color', defaultValue: '#00000000'),
    ]);
    if (!mounted) return;
    setState(() {
      _fullCallWindow = loaded[0] as bool;
      _coloredMezoNames = loaded[1] as bool;
      _contactMezoColor = DeadzoneColorUtils.parseHex(loaded[2] as String, fallbackArgb: 0x00000000);
      _incomingMezoColor = DeadzoneColorUtils.parseHex(loaded[3] as String, fallbackArgb: 0x00000000);
      _outgoingMezoColor = DeadzoneColorUtils.parseHex(loaded[4] as String, fallbackArgb: 0x00000000);
      _missedMezoColor = DeadzoneColorUtils.parseHex(loaded[5] as String, fallbackArgb: 0x00000000);
      _rejectedMezoColor = DeadzoneColorUtils.parseHex(loaded[6] as String, fallbackArgb: 0x00000000);
      _voicemailMezoColor = DeadzoneColorUtils.parseHex(loaded[7] as String, fallbackArgb: 0x00000000);
      _loading = false;
    });
  }

  Future<void> _pickColor(String title, int current, ValueChanged<int> onChanged) async {
    final picked = await showDeadZoneColorPicker(context: context, initialArgb: current, defaultArgb: 0x00000000, title: title);
    if (picked == null || !mounted) return;
    setState(() => onChanged(picked));
  }

  Future<void> _apply() async {
    setState(() => _applying = true);
    final writes = await Future.wait<bool>([
      AndroidIntentBridge.writeBool('full_call_window', _fullCallWindow),
      AndroidIntentBridge.writeBool('colored_mezo_names', _coloredMezoNames),
      AndroidIntentBridge.writeString('contact_mezo_color', DeadzoneColorUtils.toArgbHex(_contactMezoColor)),
      AndroidIntentBridge.writeString('incoming_mezo_color', DeadzoneColorUtils.toArgbHex(_incomingMezoColor)),
      AndroidIntentBridge.writeString('outgoing_mezo_color', DeadzoneColorUtils.toArgbHex(_outgoingMezoColor)),
      AndroidIntentBridge.writeString('missed_mezo_color', DeadzoneColorUtils.toArgbHex(_missedMezoColor)),
      AndroidIntentBridge.writeString('rejected_mezo_color', DeadzoneColorUtils.toArgbHex(_rejectedMezoColor)),
      AndroidIntentBridge.writeString('voicemail_mezo_color', DeadzoneColorUtils.toArgbHex(_voicemailMezoColor)),
    ]);
    final writeOk = writes.every((ok) => ok);
    var message = 'Saved in DeadZone. Contacts apply requires ROM integration.';
    if (writeOk) {
      final sent = await AndroidIntentBridge.sendDeadzonBroadcast('my.settings.intent.RESTART_CONTACTS');
      message = sent ? 'Applied. Contacts refresh requested.' : 'Saved. Contacts refresh action could not be sent.';
    }
    if (!mounted) return;
    setState(() => _applying = false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final bgTop = DeadzonThemeTokens.appBackground(context);
    final bgBottom = DeadzonThemeTokens.pageBackground(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) context.go('/home');
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _loading || _applying ? null : _apply,
          icon: Icon(_applying ? Icons.sync_rounded : Icons.done_rounded),
          label: Text(_applying ? 'Applying...' : 'Apply'),
        ),
        body: Container(
          decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: <Color>[bgTop, bgBottom])),
          child: SafeArea(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                    padding: EdgeInsets.fromLTRB(14, 10, 14, MediaQuery.paddingOf(context).bottom + 120),
                    children: [
                      PremiumTopBar(title: 'Call', subtitle: 'Call window, contact colors and call history styles', onBack: () => context.go('/home')),
                      const SizedBox(height: 12),
                      const DeadZoneSectionHeader(title: 'Call Window', subtitle: 'In-call layout behavior'),
                      DeadZoneSettingsCard(
                        child: DeadZoneSwitchRow(icon: Icons.open_in_full_rounded, title: 'Full call window', subtitle: 'Use full-screen incoming call window', value: _fullCallWindow, onChanged: (v) => setState(() => _fullCallWindow = v)),
                      ),
                      const SizedBox(height: 12),
                      const DeadZoneSectionHeader(title: 'Colored Calls', subtitle: 'Contact and call history color styling'),
                      DeadZoneSettingsCard(
                        child: Column(children: [
                          DeadZoneSwitchRow(
                            icon: Icons.color_lens_rounded,
                            title: 'Colored calls',
                            subtitle: _coloredMezoNames ? 'Use custom colors for contacts and call logs' : 'Default contact and call history colors',
                            value: _coloredMezoNames,
                            onChanged: (v) => setState(() => _coloredMezoNames = v),
                          ),
                          const Divider(height: 1),
                          _colorRow('Contact color', Icons.person_rounded, _contactMezoColor, _coloredMezoNames, (v) => _contactMezoColor = v),
                          const Divider(height: 1),
                          _colorRow('Incoming color', Icons.call_received_rounded, _incomingMezoColor, _coloredMezoNames, (v) => _incomingMezoColor = v),
                          const Divider(height: 1),
                          _colorRow('Outgoing color', Icons.call_made_rounded, _outgoingMezoColor, _coloredMezoNames, (v) => _outgoingMezoColor = v),
                          const Divider(height: 1),
                          _colorRow('Missed color', Icons.call_missed_rounded, _missedMezoColor, _coloredMezoNames, (v) => _missedMezoColor = v),
                          const Divider(height: 1),
                          _colorRow('Rejected color', Icons.call_end_rounded, _rejectedMezoColor, _coloredMezoNames, (v) => _rejectedMezoColor = v),
                          const Divider(height: 1),
                          _colorRow('Voicemail color', Icons.voicemail_rounded, _voicemailMezoColor, _coloredMezoNames, (v) => _voicemailMezoColor = v),
                        ]),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _colorRow(String title, IconData icon, int argb, bool enabled, ValueChanged<int> onChanged) {
    return Opacity(
      opacity: enabled ? 1 : 0.48,
      child: IgnorePointer(
        ignoring: !enabled,
        child: DeadZoneSelectRow(
          icon: icon,
          title: title,
          valueLabel: DeadzoneColorUtils.toArgbHex(argb),
          leading: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Color(argb),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: DeadzonThemeTokens.border(context)),
            ),
          ),
          onTap: () => _pickColor(title, argb, onChanged),
        ),
      ),
    );
  }
}
