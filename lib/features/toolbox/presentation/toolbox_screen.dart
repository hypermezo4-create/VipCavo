import 'package:deadzon/core/widgets/glass_card.dart';
import 'package:deadzon/core/widgets/section_header.dart';
import 'package:deadzon/features/toolbox/services/toolbox_native_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ToolboxScreen extends StatefulWidget {
  const ToolboxScreen({super.key});

  @override
  State<ToolboxScreen> createState() => _ToolboxScreenState();
}

class _ToolboxScreenState extends State<ToolboxScreen> {
  Map<String, dynamic> _summary = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final data = await ToolboxNativeService.getDeviceSummary();
    if (!mounted) return;
    setState(() => _summary = data);
  }

  @override
  Widget build(BuildContext context) {
    final scaler = MediaQuery.textScalerOf(context).clamp(minScaleFactor: 0.9, maxScaleFactor: 1.15);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: scaler),
      child: Scaffold(
        appBar: AppBar(title: const Text('DeadZone Toolbox')),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[Color(0xFF090E24), Color(0xFF121B3B), Color(0xFF14285A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                _DeviceDashboard(summary: _summary, onOpenHardwareDetails: _openHardwareDetails),
                const SizedBox(height: 16),
                _AboutThisDevice(summary: _summary),
                const SizedBox(height: 16),
                const SectionHeader(title: 'DeadZone Tools', subtitle: 'Unified module toolbox'),
                const SizedBox(height: 10),
                _SystemToolsGrid(summary: _summary, onOpenHardwareDetails: _openHardwareDetails),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openHardwareDetails() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return _HardwareDetailsSheet(summary: _summary);
      },
    );
  }
}

class _HardwareDetailsSheet extends StatelessWidget {
  const _HardwareDetailsSheet({required this.summary});
  final Map<String, dynamic> summary;

  @override
  Widget build(BuildContext context) {
    final scaler = MediaQuery.textScalerOf(context).clamp(minScaleFactor: 0.9, maxScaleFactor: 1.1);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: scaler),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.82,
        maxChildSize: 0.95,
        minChildSize: 0.58,
        builder: (BuildContext context, ScrollController controller) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
              gradient: LinearGradient(
                colors: <Color>[Colors.indigo.shade900.withValues(alpha: 0.95), Colors.black.withValues(alpha: 0.95)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: Colors.white24),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 16 + MediaQuery.viewPaddingOf(context).bottom),
              child: Column(
                children: <Widget>[
                  Container(width: 48, height: 5, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(8))),
                  const SizedBox(height: 12),
                  const Text('DeadZone Hardware Details', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView(controller: controller, children: <Widget>[
                      _HardwareRow(icon: Icons.business_rounded, label: 'Brand', value: summary['brand']),
                      _HardwareRow(icon: Icons.factory_rounded, label: 'Manufacturer', value: summary['manufacturer']),
                      _HardwareRow(icon: Icons.widgets_rounded, label: 'Product', value: summary['product']),
                      _HardwareRow(icon: Icons.code_rounded, label: 'Codename', value: summary['codename']),
                      _HardwareRow(icon: Icons.phone_android_rounded, label: 'Model', value: summary['model']),
                      _HardwareRow(icon: Icons.android_rounded, label: 'Android Version', value: _formatAndroid(summary['androidVersion'], summary['sdk'])),
                      _HardwareRow(icon: Icons.security_rounded, label: 'Security Patch', value: summary['securityPatch']),
                      _HardwareRow(icon: Icons.developer_board_rounded, label: 'Kernel', value: summary['kernel'], copyable: true),
                      _HardwareRow(icon: Icons.fingerprint_rounded, label: 'Fingerprint', value: summary['fingerprint'], copyable: true),
                      _HardwareRow(icon: Icons.settings_ethernet_rounded, label: 'Radio Version', value: summary['radioVersion'], copyable: true),
                      _HardwareRow(icon: Icons.badge_rounded, label: 'Build ID', value: summary['buildId']),
                      _HardwareRow(icon: Icons.display_settings_rounded, label: 'Build Display', value: summary['buildDisplay']),
                      _HardwareRow(icon: Icons.build_circle_rounded, label: 'Build Type', value: summary['buildType']),
                      _HardwareRow(icon: Icons.sell_rounded, label: 'Build Tags', value: summary['buildTags']),
                      _HardwareRow(icon: Icons.schedule_rounded, label: 'Build Time', value: _formatBuildTime(summary['buildTime'])),
                      _HardwareRow(icon: Icons.dns_rounded, label: 'Build Host', value: summary['buildHost']),
                      _HardwareRow(icon: Icons.person_rounded, label: 'Build User', value: summary['buildUser']),
                      _HardwareRow(icon: Icons.update_rounded, label: 'Incremental', value: summary['incremental']),
                      _HardwareRow(icon: Icons.memory_rounded, label: 'RAM', value: _formatRam(summary['ram'])),
                      _HardwareRow(icon: Icons.sd_storage_rounded, label: 'Storage', value: _formatStorage(summary['storage'])),
                      _HardwareRow(icon: Icons.screen_rotation_alt_rounded, label: 'Resolution', value: summary['resolution']),
                      _HardwareRow(icon: Icons.speed_rounded, label: 'Refresh Rate', value: _formatHz(summary['refreshRate'])),
                      _HardwareRow(icon: Icons.terminal_rounded, label: 'Java VM', value: summary['javaVm']),
                      _HardwareRow(icon: Icons.language_rounded, label: 'Locale', value: summary['locale']),
                      _HardwareRow(icon: Icons.public_rounded, label: 'Timezone', value: summary['timezone']),
                      _HardwareRow(icon: Icons.developer_mode_rounded, label: 'Supported ABIs', value: summary['supportedAbis'], copyable: true),
                    ]),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HardwareRow extends StatelessWidget { const _HardwareRow({required this.icon, required this.label, required this.value, this.copyable = false});
  final IconData icon; final String label; final Object? value; final bool copyable;
  @override Widget build(BuildContext context) {
    final display = _valueText(value);
    return Container(
      margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white24), color: Colors.white.withValues(alpha: 0.06)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Icon(icon, color: Colors.cyanAccent.shade100, size: 19), const SizedBox(width: 10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12.5, fontWeight: FontWeight.w600)), const SizedBox(height: 3),
          Text(display, style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.35)),
        ])),
        if (copyable && display != '-') IconButton(onPressed: () async { await Clipboard.setData(ClipboardData(text: display)); if (context.mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Copied to clipboard'))); } }, icon: const Icon(Icons.copy_rounded, size: 18, color: Colors.white70)),
      ]),
    );
  }
}

class _DeviceDashboard extends StatelessWidget { const _DeviceDashboard({required this.summary, required this.onOpenHardwareDetails});
  final Map<String, dynamic> summary; final VoidCallback onOpenHardwareDetails;
  @override Widget build(BuildContext context) {
    final items = <({IconData icon, String label, String value})>[
      (icon: Icons.phone_iphone_rounded, label: 'Device', value: _valueText(summary['model'])),
      (icon: Icons.android_rounded, label: 'Android', value: _formatAndroid(summary['androidVersion'], summary['sdk'])),
      (icon: Icons.memory_rounded, label: 'RAM', value: _formatRam(summary['ram'])),
      (icon: Icons.sd_storage_rounded, label: 'Storage', value: _formatStorage(summary['storage'])),
      (icon: Icons.monitor_rounded, label: 'Display', value: '${_valueText(summary['resolution'])} • ${_formatHz(summary['refreshRate'])}'),
      (icon: Icons.construction_rounded, label: 'Build', value: _valueText(summary['buildDisplay'])),
    ];
    return GlassCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      const Text('DeadZone Dashboard', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
      const SizedBox(height: 4),
      const Text('Compact system overview', style: TextStyle(color: Colors.white70, fontSize: 12)),
      const SizedBox(height: 12),
      GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: items.length, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 1.45), itemBuilder: (_, i) {
        final item = items[i];
        return Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), gradient: LinearGradient(colors: <Color>[Colors.white.withValues(alpha: 0.12), Colors.white.withValues(alpha: 0.05)]), border: Border.all(color: Colors.white30)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[Icon(item.icon, color: Colors.lightBlueAccent.shade100, size: 18), const SizedBox(height: 6), Text(item.label, style: const TextStyle(color: Colors.white70, fontSize: 11.5)), const SizedBox(height: 3), Text(item.value, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600))]));
      }),
      const SizedBox(height: 12), Align(alignment: Alignment.centerRight, child: FilledButton.icon(onPressed: onOpenHardwareDetails, style: FilledButton.styleFrom(backgroundColor: Colors.cyanAccent.withValues(alpha: 0.18)), icon: const Icon(Icons.memory_rounded), label: const Text('Hardware Details'))),
    ]));
  }
}

class _AboutThisDevice extends StatelessWidget { const _AboutThisDevice({required this.summary}); final Map<String, dynamic> summary;
  @override Widget build(BuildContext context) {
    return GlassCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      const Text('DeadZone Device Info', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)), const SizedBox(height: 12),
      _InfoRow(icon: Icons.badge_rounded, label: 'Brand / Manufacturer', value: '${_valueText(summary['brand'])} / ${_valueText(summary['manufacturer'])}'),
      _InfoRow(icon: Icons.widgets_rounded, label: 'Product / Codename', value: '${_valueText(summary['product'])} / ${_valueText(summary['codename'])}'),
      _InfoRow(icon: Icons.build_rounded, label: 'Build', value: '${_valueText(summary['buildId'])} (${_valueText(summary['buildType'])})'),
      _InfoRow(icon: Icons.verified_user_rounded, label: 'Security', value: _valueText(summary['securityPatch'])),
      _InfoRow(icon: Icons.developer_board_rounded, label: 'Kernel', value: _valueText(summary['kernel']), copyable: true),
      _InfoRow(icon: Icons.fingerprint_rounded, label: 'Fingerprint', value: _valueText(summary['fingerprint']), copyable: true),
      _InfoRow(icon: Icons.public_rounded, label: 'Locale • Timezone', value: '${_valueText(summary['locale'])} • ${_valueText(summary['timezone'])}'),
    ]));
  }
}

class _InfoRow extends StatelessWidget { const _InfoRow({required this.icon, required this.label, required this.value, this.copyable = false});
  final IconData icon; final String label; final String value; final bool copyable;
  @override Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Icon(icon, size: 18, color: Colors.cyanAccent.shade100), const SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[Text(label, style: const TextStyle(color: Colors.white60, fontSize: 12.5, fontWeight: FontWeight.w600)), const SizedBox(height: 2), Text(value, softWrap: true, style: const TextStyle(color: Colors.white, height: 1.35))])),
      if (copyable && value != '-') IconButton(visualDensity: VisualDensity.compact, onPressed: () async { await Clipboard.setData(ClipboardData(text: value)); if (context.mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Copied to clipboard'))); } }, icon: const Icon(Icons.copy_rounded, size: 18, color: Colors.white70)),
    ])),
  );
}

class _SystemToolsGrid extends StatelessWidget {
  const _SystemToolsGrid({required this.summary, required this.onOpenHardwareDetails});
  final Map<String, dynamic> summary;
  final VoidCallback onOpenHardwareDetails;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1.08,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        const _FpsCpuOverlayCard(),
        _ToolCard(title: 'Payload Dumper', subtitle: 'Ready for engine integration', icon: Icons.archive_rounded, onTap: () => _openPayloadDumper(context)),
        _ToolCard(title: 'Device Info / Hardware Details', subtitle: 'Open complete hardware sheet', icon: Icons.devices_rounded, onTap: onOpenHardwareDetails),
        const _ToolCard(title: 'Hidden Features', subtitle: 'Curated controls coming next', icon: Icons.tune_rounded),
        const _ToolCard(title: 'Backup & Restore', subtitle: 'Snapshot tools placeholder', icon: Icons.backup_rounded),
        const _ToolCard(title: 'Logs / Diagnostics', subtitle: 'System logs module placeholder', icon: Icons.article_rounded),
        const _ToolCard(title: 'Compatibility Center', subtitle: 'Compatibility checks placeholder', icon: Icons.verified_user_rounded),
      ],
    );
  }

  Future<void> _openPayloadDumper(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _PayloadDumperSheet(),
    );
  }
}

class _PayloadDumperSheet extends StatelessWidget {
  const _PayloadDumperSheet();
  @override
  Widget build(BuildContext context) => DraggableScrollableSheet(
    initialChildSize: 0.8, minChildSize: 0.58, maxChildSize: 0.95, expand: false,
    builder: (_, controller) => Container(
      decoration: BoxDecoration(borderRadius: const BorderRadius.vertical(top: Radius.circular(28)), color: const Color(0xFF10172F), border: Border.all(color: Colors.white24)),
      child: ListView(controller: controller, padding: EdgeInsets.fromLTRB(16, 16, 16, 18 + MediaQuery.viewPaddingOf(context).bottom), children: <Widget>[
        const Text('Payload Dumper', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        Wrap(spacing: 10, runSpacing: 10, children: const <Widget>[
          _ActionPill(icon: Icons.folder_open_rounded, label: 'From local'),
          _ActionPill(icon: Icons.link_rounded, label: 'From URL'),
          _ActionPill(icon: Icons.search_rounded, label: 'Search partitions'),
          _ActionPill(icon: Icons.play_arrow_rounded, label: 'Parse'),
        ]),
        const SizedBox(height: 12),
        const _PlaceholderPanel(title: 'Output folder', subtitle: 'Select output location'),
        const SizedBox(height: 10),
        const _PlaceholderPanel(title: 'Progress', subtitle: 'Waiting for parser engine'),
        const SizedBox(height: 10),
        const _PlaceholderPanel(title: 'Logs', subtitle: 'Logs will stream here'),
        const SizedBox(height: 10),
        const _PlaceholderPanel(title: 'Cancel', subtitle: 'Cancellation action placeholder'),
        const SizedBox(height: 10),
        const _PlaceholderPanel(title: 'Empty state', subtitle: 'No payload selected yet'),
      ]),
    ),
  );
}

class _ActionPill extends StatelessWidget { const _ActionPill({required this.icon, required this.label}); final IconData icon; final String label;
  @override Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10), decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white.withValues(alpha: 0.08), border: Border.all(color: Colors.white24)), child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[Icon(icon, color: Colors.cyanAccent.shade100, size: 18), const SizedBox(width: 6), Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600))]));
}
class _PlaceholderPanel extends StatelessWidget { const _PlaceholderPanel({required this.title, required this.subtitle}); final String title; final String subtitle;
  @override Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: Colors.white.withValues(alpha: 0.06), border: Border.all(color: Colors.white24)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)), const SizedBox(height: 2), Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 12))]));
}

class _ToolCard extends StatelessWidget { const _ToolCard({required this.title, required this.subtitle, required this.icon, this.onTap}); final String title; final String subtitle; final IconData icon; final VoidCallback? onTap;
  @override Widget build(BuildContext context) => GlassCard(child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(18), child: Padding(padding: const EdgeInsets.all(2), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[Icon(icon, color: Colors.white, size: 24), const Spacer(), Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)), const SizedBox(height: 4), Text(subtitle, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white70, fontSize: 12))]))));
}

class _FpsCpuOverlayCard extends StatefulWidget { const _FpsCpuOverlayCard(); @override State<_FpsCpuOverlayCard> createState() => _FpsCpuOverlayCardState(); }
class _FpsCpuOverlayCardState extends State<_FpsCpuOverlayCard> {
  bool canOverlay = false; bool running = false;
  @override void initState() { super.initState(); _refresh(); }
  Future<void> _refresh() async { final can = await ToolboxNativeService.canDrawOverlays(); final isRunning = await ToolboxNativeService.isFpsOverlayRunning(); if (!mounted) return; setState(() { canOverlay = can; running = isRunning; }); }
  @override Widget build(BuildContext context) => GlassCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[Row(children: <Widget>[const Icon(Icons.speed_rounded, color: Colors.cyanAccent), const SizedBox(width: 8), const Expanded(child: Text('FPS & CPU Overlay', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700))), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: (running ? Colors.green : Colors.orange).withValues(alpha: 0.22), borderRadius: BorderRadius.circular(999)), child: Text(running ? 'Active' : 'Ready', style: const TextStyle(color: Colors.white, fontSize: 11))) ]), const SizedBox(height: 6), const Text('Overlay permission, start/stop, position and display settings.', style: TextStyle(color: Colors.white70, fontSize: 12)), const Spacer(), Align(alignment: Alignment.bottomRight, child: FilledButton(onPressed: () async { if (!canOverlay) { await ToolboxNativeService.openOverlayPermissionPanel(); await _refresh(); return; } await _openOverlayControls(context); await _refresh(); }, child: Text(canOverlay ? 'Controls' : 'Grant Permission')))]));

  Future<void> _openOverlayControls(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _OverlayControlSheet(),
    );
  }
}

class _OverlayControlSheet extends StatefulWidget { const _OverlayControlSheet(); @override State<_OverlayControlSheet> createState() => _OverlayControlSheetState(); }
class _OverlayControlSheetState extends State<_OverlayControlSheet> {
  String position = 'topRight'; bool showFps = true; bool showFpsLabel = true; bool reverseFormat = false; bool showAppName = false; bool showPackageName = false; bool showCpuInfo = false; bool running = false;
  @override void initState() { super.initState(); _load(); }
  Future<void> _load() async { running = await ToolboxNativeService.isFpsOverlayRunning(); if (mounted) setState(() {}); }
  Future<void> _apply() => ToolboxNativeService.updateFpsOverlaySettings(<String, dynamic>{'position': position, 'showFps': showFps, 'showFpsLabel': showFpsLabel, 'reverseFormat': reverseFormat, 'showAppName': showAppName, 'showPackageName': showPackageName, 'showCpuInfo': showCpuInfo});
  @override Widget build(BuildContext context) => DraggableScrollableSheet(initialChildSize: 0.82, minChildSize: 0.62, maxChildSize: 0.95, expand: false, builder: (_, controller) => Container(decoration: BoxDecoration(borderRadius: const BorderRadius.vertical(top: Radius.circular(28)), color: const Color(0xFF10172F), border: Border.all(color: Colors.white24)), child: ListView(controller: controller, padding: EdgeInsets.fromLTRB(16, 16, 16, 18 + MediaQuery.viewPaddingOf(context).bottom), children: <Widget>[const Text('FPS & CPU Overlay', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)), const SizedBox(height: 10), DropdownButtonFormField<String>(value: position, dropdownColor: const Color(0xFF1A2343), decoration: const InputDecoration(labelText: 'Position'), items: const [DropdownMenuItem(value: 'topLeft', child: Text('Top left')), DropdownMenuItem(value: 'topRight', child: Text('Top right')), DropdownMenuItem(value: 'bottomLeft', child: Text('Bottom left')), DropdownMenuItem(value: 'bottomRight', child: Text('Bottom right'))], onChanged: (v) => setState(() => position = v ?? position)), SwitchListTile(value: showFps, onChanged: (v) => setState(() => showFps = v), title: const Text('Show FPS')), SwitchListTile(value: showFpsLabel, onChanged: (v) => setState(() => showFpsLabel = v), title: const Text('Show FPS Label')), SwitchListTile(value: reverseFormat, onChanged: (v) => setState(() => reverseFormat = v), title: const Text('Reverse Format')), SwitchListTile(value: showAppName, onChanged: (v) => setState(() => showAppName = v), title: const Text('Show App Name')), SwitchListTile(value: showPackageName, onChanged: (v) => setState(() => showPackageName = v), title: const Text('Show Package Name')), SwitchListTile(value: showCpuInfo, onChanged: (v) => setState(() => showCpuInfo = v), title: const Text('Show CPU Info')), const SizedBox(height: 8), Row(children: <Widget>[Expanded(child: OutlinedButton(onPressed: () async { await _apply(); final ok = await ToolboxNativeService.startFpsOverlay(); if (mounted) setState(() => running = ok); }, child: const Text('Start'))), const SizedBox(width: 10), Expanded(child: OutlinedButton(onPressed: () async { await ToolboxNativeService.stopFpsOverlay(); if (mounted) setState(() => running = false); }, child: const Text('Stop')))]), const SizedBox(height: 8), Text(running ? 'Overlay service is active' : 'Overlay service is stopped', style: const TextStyle(color: Colors.white70, fontSize: 12))])));
}

String _valueText(Object? value) => value == null || value.toString().trim().isEmpty ? '-' : value.toString();
String _formatAndroid(Object? version, Object? sdk) => '${_valueText(version) == '-' ? 'Android -' : 'Android ${_valueText(version)}'} (SDK ${_valueText(sdk)})';
String _formatHz(Object? value) { final input = _valueText(value); final parsed = double.tryParse(input.replaceAll(RegExp(r'[^0-9.]'), '')); if (parsed == null) return input; return '${parsed.toStringAsFixed(parsed.truncateToDouble() == parsed ? 0 : 1)} Hz'; }
String _formatStorage(Object? value) => _valueText(value).replaceAllMapped(RegExp(r'(\d+\.\d+)'), (m) => double.parse(m[1]!).toStringAsFixed(1));
String _formatRam(Object? value) => _formatStorage(value);
String _formatBuildTime(Object? value) { final raw = _valueText(value); final ms = int.tryParse(raw); if (ms == null) return raw; final dt = DateTime.fromMillisecondsSinceEpoch(ms); return '${dt.year.toString().padLeft(4, '0')}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}'; }
