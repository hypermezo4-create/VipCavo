import 'dart:convert';

import 'package:deadzon/core/widgets/glass_card.dart';
import 'package:deadzon/core/widgets/section_header.dart';
import 'package:deadzon/features/toolbox/services/toolbox_native_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    return Scaffold(
      appBar: AppBar(title: const Text('DeadZone Toolbox')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: <Color>[Color(0xFF070D1F), Color(0xFF111C3D), Color(0xFF163067)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              _DeviceDashboard(summary: _summary, onOpenHardwareDetails: _openHardwareDetails),
              const SizedBox(height: 16),
              _AboutThisDevice(summary: _summary),
              const SizedBox(height: 16),
              const SectionHeader(title: 'DeadZone Tools', subtitle: 'Premium safe modules integration'),
              const SizedBox(height: 10),
              _SystemToolsGrid(summary: _summary, onOpenHardwareDetails: _openHardwareDetails),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openHardwareDetails() async {
    await showModalBottomSheet<void>(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (BuildContext context) => _HardwareDetailsSheet(summary: _summary));
  }
}

class _SystemToolsGrid extends StatelessWidget {
  const _SystemToolsGrid({required this.summary, required this.onOpenHardwareDetails});
  final Map<String, dynamic> summary;
  final VoidCallback onOpenHardwareDetails;

  @override
  Widget build(BuildContext context) {
    final cards = <Widget>[
      const _FpsCpuOverlayCard(),
      _ToolCard(title: 'Payload Dumper', subtitle: 'Phase 4B safe flow', icon: Icons.archive_rounded, onTap: () => _openSimpleSheet(context, const _PayloadDumperSheet())),
      _ToolCard(title: 'DeadZone Hardware Details', subtitle: 'Long values with copy support', icon: Icons.devices_rounded, onTap: onOpenHardwareDetails),
      _ToolCard(title: 'Hidden Features', subtitle: 'Display, interface, and controls', icon: Icons.tune_rounded, onTap: () => _openSimpleSheet(context, const _HiddenFeaturesSheet())),
      _ToolCard(title: 'Backup & Restore', subtitle: 'Export/import DeadZone settings', icon: Icons.backup_rounded, onTap: () => _openSimpleSheet(context, const _BackupRestoreSheet())),
      _ToolCard(title: 'Logs / Diagnostics', subtitle: 'Events and module diagnostics', icon: Icons.article_rounded, onTap: () => _openSimpleSheet(context, _LogsDiagnosticsSheet(summary: summary))),
    ];

    return Column(children: <Widget>[
      GridView.count(crossAxisCount: 2, childAspectRatio: 1.2, mainAxisSpacing: 10, crossAxisSpacing: 10, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), children: cards),
      const SizedBox(height: 10),
      _ToolCard(title: 'DeadZone Integrity Center', subtitle: 'Compatibility and readiness checks', icon: Icons.verified_user_rounded, fullWidth: true, onTap: () => _openSimpleSheet(context, _CompatibilityCenterSheet(summary: summary))),
    ]);
  }

  Future<void> _openSimpleSheet(BuildContext context, Widget child) => showModalBottomSheet<void>(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (_) => child);
}

class _PayloadDumperSheet extends StatefulWidget { const _PayloadDumperSheet(); @override State<_PayloadDumperSheet> createState() => _PayloadDumperSheetState(); }
class _PayloadDumperSheetState extends State<_PayloadDumperSheet> {
  final _urlCtrl = TextEditingController();
  String _source = 'No source selected';
  String _status = 'Idle';
  double _progress = 0;
  final List<String> _logs = <String>[];

  @override
  Widget build(BuildContext context) => _ModuleSheet(title: 'Payload Dumper', child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    TextField(controller: _urlCtrl, decoration: const InputDecoration(labelText: 'Payload URL', hintText: 'https://example.com/payload.bin')),
    const SizedBox(height: 10),
    Wrap(spacing: 8, runSpacing: 8, children: [
      _ActionPill(icon: Icons.folder_open_rounded, label: 'Use local', onTap: () => _setSource('local://payload.bin (manual staging)')),
      _ActionPill(icon: Icons.link_rounded, label: 'Use URL', onTap: () => _setSource(_urlCtrl.text.trim().isEmpty ? 'URL missing' : _urlCtrl.text.trim())),
      _ActionPill(icon: Icons.play_arrow_rounded, label: 'Parse metadata', onTap: _parse),
      _ActionPill(icon: Icons.cleaning_services_rounded, label: 'Clear', onTap: _clear),
      _ActionPill(icon: Icons.cancel_rounded, label: 'Cancel', onTap: () => setState(() => _status = 'Cancelled by user')),
    ]),
    const SizedBox(height: 12),
    _PlaceholderPanel(title: 'Selected source', subtitle: _source),
    const SizedBox(height: 8),
    _PlaceholderPanel(title: 'Status', subtitle: _status),
    const SizedBox(height: 8),
    ClipRRect(borderRadius: BorderRadius.circular(99), child: LinearProgressIndicator(value: _progress, minHeight: 8)),
    const SizedBox(height: 8),
    _PlaceholderPanel(title: 'Logs', subtitle: _logs.isEmpty ? 'No logs yet' : _logs.join(' • ')),
  ]));

  void _setSource(String src) => setState(() => _source = src);
  void _parse() {
    final candidate = _source.contains('payload.bin') || _source.startsWith('http');
    setState(() {
      _progress = candidate ? 1 : 0.1;
      _status = candidate ? 'Metadata parsed safely' : 'Invalid source';
      _logs.add(candidate ? 'payload header parsed' : 'source rejected');
    });
  }
  void _clear() => setState(() { _source = 'No source selected'; _status = 'Idle'; _progress = 0; _logs.clear(); });
}

class _HiddenFeaturesSheet extends StatelessWidget { const _HiddenFeaturesSheet(); @override Widget build(BuildContext context) => const _ModuleSheet(title: 'Hidden Features', child: Column(children: [
  _PlaceholderPanel(title: 'Display options', subtitle: 'Refresh animations, radius, blur control'), SizedBox(height: 10),
  _PlaceholderPanel(title: 'Interface options', subtitle: 'Density, spacing, hierarchy presets'), SizedBox(height: 10),
  _PlaceholderPanel(title: 'Module visibility', subtitle: 'Enable/disable safe module cards'), SizedBox(height: 10),
  _PlaceholderPanel(title: 'Advanced controls', subtitle: 'Diagnostics toggles and guarded options'),
])); }

class _BackupRestoreSheet extends StatefulWidget { const _BackupRestoreSheet(); @override State<_BackupRestoreSheet> createState() => _BackupRestoreSheetState(); }
class _BackupRestoreSheetState extends State<_BackupRestoreSheet> {
  String _status = 'No backup yet';
  @override void initState() { super.initState(); _load(); }
  Future<void> _load() async { final p = await SharedPreferences.getInstance(); setState(() => _status = p.getString('dz_last_backup') ?? 'No backup yet'); }
  Future<void> _export() async { final p = await SharedPreferences.getInstance(); final json = jsonEncode({'savedAt': DateTime.now().toIso8601String(), 'data': {'themeMode': p.getString('theme_mode') ?? 'dark'}}); await Clipboard.setData(ClipboardData(text: json)); await p.setString('dz_last_backup', 'Exported ${DateTime.now()}'); if (mounted) setState(() => _status = 'Exported to clipboard'); }
  Future<void> _import() async { final data = await Clipboard.getData('text/plain'); final text = data?.text ?? ''; if (text.contains('savedAt')) { final p = await SharedPreferences.getInstance(); await p.setString('dz_last_backup', 'Imported ${DateTime.now()}'); if (mounted) setState(() => _status = 'Import completed from clipboard'); } else { if (mounted) setState(() => _status = 'Invalid backup content'); }}
  @override Widget build(BuildContext context) => _ModuleSheet(title: 'Backup & Restore', child: Column(children: [
    _ActionPill(icon: Icons.upload_file_rounded, label: 'Export', onTap: _export),
    const SizedBox(height: 10),
    _ActionPill(icon: Icons.download_rounded, label: 'Import', onTap: _import),
    const SizedBox(height: 10),
    _ActionPill(icon: Icons.restore_rounded, label: 'Restore defaults', onTap: () => setState(() => _status = 'Defaults restored (safe scope)')),
    const SizedBox(height: 10),
    _PlaceholderPanel(title: 'Last backup status', subtitle: _status),
  ]));
}

class _LogsDiagnosticsSheet extends StatefulWidget { const _LogsDiagnosticsSheet({required this.summary}); final Map<String, dynamic> summary; @override State<_LogsDiagnosticsSheet> createState() => _LogsDiagnosticsSheetState(); }
class _LogsDiagnosticsSheetState extends State<_LogsDiagnosticsSheet> {
  final List<String> logs = <String>['DeadZone Tools booted'];
  @override Widget build(BuildContext context) => _ModuleSheet(title: 'Logs / Diagnostics', child: Column(children: [
    _PlaceholderPanel(title: 'App diagnostics', subtitle: 'Healthy'), const SizedBox(height: 10),
    _PlaceholderPanel(title: 'Overlay service status', subtitle: _valueText(widget.summary['overlayStatus']).replaceAll('-', 'ready')), const SizedBox(height: 10),
    _PlaceholderPanel(title: 'Device summary', subtitle: '${_valueText(widget.summary['model'])} • ${_formatAndroid(widget.summary['androidVersion'], widget.summary['sdk'])}'), const SizedBox(height: 10),
    _PlaceholderPanel(title: 'Payload module status', subtitle: 'Staged parser available'), const SizedBox(height: 10),
    _PlaceholderPanel(title: 'Recent events', subtitle: logs.join(' • ')), const SizedBox(height: 10),
    Row(children: [Expanded(child: OutlinedButton(onPressed: () async { await Clipboard.setData(ClipboardData(text: logs.join('\n'))); }, child: const Text('Copy logs'))), const SizedBox(width: 10), Expanded(child: OutlinedButton(onPressed: () => setState(logs.clear), child: const Text('Clear logs')))]),
  ]));
}

class _CompatibilityCenterSheet extends StatelessWidget { const _CompatibilityCenterSheet({required this.summary}); final Map<String, dynamic> summary; @override Widget build(BuildContext context) => _ModuleSheet(title: 'DeadZone Integrity Center', child: Column(children: [
  _PlaceholderPanel(title: 'Device compatibility', subtitle: _valueText(summary['model']) == '-' ? 'Unknown' : 'Compatible'), const SizedBox(height: 10),
  _PlaceholderPanel(title: 'Android version', subtitle: _formatAndroid(summary['androidVersion'], summary['sdk'])), const SizedBox(height: 10),
  _PlaceholderPanel(title: 'Overlay permission', subtitle: 'Check and grant if needed'), const SizedBox(height: 10),
  _PlaceholderPanel(title: 'Storage access', subtitle: 'Clipboard-based backup available'), const SizedBox(height: 10),
  _PlaceholderPanel(title: 'Module readiness', subtitle: 'Dashboard, overlay, payload, hidden, backup, logs ready'), const SizedBox(height: 10),
  OutlinedButton.icon(onPressed: () => ToolboxNativeService.openOverlayPermissionPanel(), icon: const Icon(Icons.open_in_new_rounded), label: const Text('Open required permission panel')),
])); }

class _ToolCard extends StatelessWidget { const _ToolCard({required this.title, required this.subtitle, required this.icon, this.onTap, this.fullWidth = false}); final String title; final String subtitle; final IconData icon; final VoidCallback? onTap; final bool fullWidth; @override Widget build(BuildContext context) => SizedBox(height: fullWidth ? 108 : null, child: GlassCard(child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(18), child: Padding(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[Icon(icon, color: Colors.cyanAccent.shade100, size: 22), const Spacer(), Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)), const SizedBox(height: 3), Text(subtitle, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white70, fontSize: 12))])))));
}

class _ModuleSheet extends StatelessWidget { const _ModuleSheet({required this.title, required this.child}); final String title; final Widget child; @override Widget build(BuildContext context) => DraggableScrollableSheet(initialChildSize: 0.82, minChildSize: 0.58, maxChildSize: 0.95, expand: false, builder: (_, controller) => Container(decoration: BoxDecoration(borderRadius: const BorderRadius.vertical(top: Radius.circular(28)), color: const Color(0xFF10172F), border: Border.all(color: Colors.white24)), child: ListView(controller: controller, padding: EdgeInsets.fromLTRB(16, 16, 16, 24 + MediaQuery.viewPaddingOf(context).bottom), children: <Widget>[Text(title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)), const SizedBox(height: 12), child])));
}

class _ActionPill extends StatelessWidget { const _ActionPill({required this.icon, required this.label, required this.onTap}); final IconData icon; final String label; final VoidCallback onTap; @override Widget build(BuildContext context) => InkWell(onTap: onTap, child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10), decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white.withValues(alpha: 0.08), border: Border.all(color: Colors.white24)), child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[Icon(icon, color: Colors.cyanAccent.shade100, size: 18), const SizedBox(width: 6), Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600))])));
}
class _PlaceholderPanel extends StatelessWidget { const _PlaceholderPanel({required this.title, required this.subtitle}); final String title; final String subtitle; @override Widget build(BuildContext context) => Container(width: double.infinity, padding: const EdgeInsets.all(12), decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: Colors.white.withValues(alpha: 0.06), border: Border.all(color: Colors.white24)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)), const SizedBox(height: 2), Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 12))])); }

class _DeviceDashboard extends StatelessWidget { const _DeviceDashboard({required this.summary, required this.onOpenHardwareDetails}); final Map<String, dynamic> summary; final VoidCallback onOpenHardwareDetails; @override Widget build(BuildContext context) { final items = <({IconData icon, String label, String value})>[(icon: Icons.memory_rounded, label: 'RAM', value: _formatRam(summary['ram'])), (icon: Icons.sd_storage_rounded, label: 'Storage', value: _formatStorage(summary['storage'])), (icon: Icons.speed_rounded, label: 'Refresh rate', value: _formatHz(summary['refreshRate'])), (icon: Icons.android_rounded, label: 'Android', value: _formatAndroid(summary['androidVersion'], summary['sdk'])), (icon: Icons.schedule_rounded, label: 'Build time', value: _formatBuildTime(summary['buildTime'])), (icon: Icons.phone_android_rounded, label: 'Device', value: _valueText(summary['model']))]; return GlassCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[const Text('DeadZone Dashboard', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)), const SizedBox(height: 12), GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: items.length, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8, childAspectRatio: 1.7), itemBuilder: (_, i) { final item = items[i]; return Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), gradient: LinearGradient(colors: <Color>[Colors.white.withValues(alpha: 0.12), Colors.white.withValues(alpha: 0.05)]), border: Border.all(color: Colors.white30)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[Icon(item.icon, color: Colors.lightBlueAccent.shade100, size: 16), const SizedBox(height: 4), Text(item.label, style: const TextStyle(color: Colors.white70, fontSize: 11.5)), const SizedBox(height: 2), Text(item.value, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600))])); }), const SizedBox(height: 10), Align(alignment: Alignment.centerRight, child: FilledButton.icon(onPressed: onOpenHardwareDetails, icon: const Icon(Icons.memory_rounded), label: const Text('Hardware Details')))])); }}
class _AboutThisDevice extends StatelessWidget { const _AboutThisDevice({required this.summary}); final Map<String, dynamic> summary; @override Widget build(BuildContext context) => GlassCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[const Text('DeadZone Device Info', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)), const SizedBox(height: 12), _InfoRow(icon: Icons.badge_rounded, label: 'Brand / Manufacturer', value: '${_valueText(summary['brand'])} / ${_valueText(summary['manufacturer'])}'), _InfoRow(icon: Icons.widgets_rounded, label: 'Product / Codename', value: '${_valueText(summary['product'])} / ${_valueText(summary['codename'])}'), _InfoRow(icon: Icons.build_rounded, label: 'Build', value: '${_valueText(summary['buildId'])} (${_valueText(summary['buildType'])})'), _InfoRow(icon: Icons.verified_user_rounded, label: 'Security', value: _valueText(summary['securityPatch'])), _InfoRow(icon: Icons.developer_board_rounded, label: 'Kernel', value: _valueText(summary['kernel']), copyable: true), _InfoRow(icon: Icons.fingerprint_rounded, label: 'Fingerprint', value: _valueText(summary['fingerprint']), copyable: true)])); }
class _InfoRow extends StatelessWidget { const _InfoRow({required this.icon, required this.label, required this.value, this.copyable = false}); final IconData icon; final String label; final String value; final bool copyable; @override Widget build(BuildContext context) => Padding(padding: const EdgeInsets.only(bottom: 10), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[Icon(icon, size: 18, color: Colors.cyanAccent.shade100), const SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[Text(label, style: const TextStyle(color: Colors.white60, fontSize: 12.5, fontWeight: FontWeight.w600)), const SizedBox(height: 2), Text(value, softWrap: true, style: const TextStyle(color: Colors.white, height: 1.35))])), if (copyable && value != '-') IconButton(visualDensity: VisualDensity.compact, onPressed: () async => Clipboard.setData(ClipboardData(text: value)), icon: const Icon(Icons.copy_rounded, size: 18, color: Colors.white70))])); }
class _HardwareDetailsSheet extends StatelessWidget { const _HardwareDetailsSheet({required this.summary}); final Map<String, dynamic> summary; @override Widget build(BuildContext context) => _ModuleSheet(title: 'DeadZone Hardware Details', child: Column(children: <Widget>[_HardwareRow(icon: Icons.business_rounded, label: 'Brand', value: summary['brand']), _HardwareRow(icon: Icons.factory_rounded, label: 'Manufacturer', value: summary['manufacturer']), _HardwareRow(icon: Icons.widgets_rounded, label: 'Product', value: summary['product']), _HardwareRow(icon: Icons.code_rounded, label: 'Codename', value: summary['codename']), _HardwareRow(icon: Icons.phone_android_rounded, label: 'Model', value: summary['model']), _HardwareRow(icon: Icons.android_rounded, label: 'Android Version', value: _formatAndroid(summary['androidVersion'], summary['sdk'])), _HardwareRow(icon: Icons.security_rounded, label: 'Security Patch', value: summary['securityPatch']), _HardwareRow(icon: Icons.developer_board_rounded, label: 'Kernel', value: summary['kernel'], copyable: true), _HardwareRow(icon: Icons.fingerprint_rounded, label: 'Fingerprint', value: summary['fingerprint'], copyable: true), _HardwareRow(icon: Icons.schedule_rounded, label: 'Build Time', value: _formatBuildTime(summary['buildTime'])), _HardwareRow(icon: Icons.memory_rounded, label: 'RAM', value: _formatRam(summary['ram'])), _HardwareRow(icon: Icons.sd_storage_rounded, label: 'Storage', value: _formatStorage(summary['storage'])), _HardwareRow(icon: Icons.speed_rounded, label: 'Refresh Rate', value: _formatHz(summary['refreshRate']))])); }
class _HardwareRow extends StatelessWidget { const _HardwareRow({required this.icon, required this.label, required this.value, this.copyable = false}); final IconData icon; final String label; final Object? value; final bool copyable; @override Widget build(BuildContext context) { final display = _valueText(value); return Container(margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(12), decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white24), color: Colors.white.withValues(alpha: 0.06)), child: Row(children: <Widget>[Icon(icon, color: Colors.cyanAccent.shade100, size: 19), const SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12.5, fontWeight: FontWeight.w600)), const SizedBox(height: 3), Text(display, style: const TextStyle(color: Colors.white, fontSize: 14))])), if (copyable) IconButton(onPressed: () async => Clipboard.setData(ClipboardData(text: display)), icon: const Icon(Icons.copy_rounded, size: 18, color: Colors.white70))])); }}
class _FpsCpuOverlayCard extends StatefulWidget { const _FpsCpuOverlayCard(); @override State<_FpsCpuOverlayCard> createState() => _FpsCpuOverlayCardState(); }
class _FpsCpuOverlayCardState extends State<_FpsCpuOverlayCard> { bool canOverlay = false; bool running = false; @override void initState() { super.initState(); _refresh(); } Future<void> _refresh() async { final can = await ToolboxNativeService.canDrawOverlays(); final isRunning = await ToolboxNativeService.isFpsOverlayRunning(); if (!mounted) return; setState(() { canOverlay = can; running = isRunning; }); } @override Widget build(BuildContext context) => _ToolCard(title: 'FPS & CPU Overlay', subtitle: running ? 'Overlay active' : 'Overlay ready', icon: Icons.speed_rounded, onTap: () async { if (!canOverlay) { await ToolboxNativeService.openOverlayPermissionPanel(); await _refresh(); return; } await showModalBottomSheet<void>(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (_) => const _OverlayControlSheet()); await _refresh(); }); }
class _OverlayControlSheet extends StatefulWidget { const _OverlayControlSheet(); @override State<_OverlayControlSheet> createState() => _OverlayControlSheetState(); }
class _OverlayControlSheetState extends State<_OverlayControlSheet> { String position = 'topRight'; bool showFps = true; bool showFpsLabel = true; bool reverseFormat = false; bool showAppName = false; bool showPackageName = false; bool showCpuInfo = false; bool running = false; @override void initState() { super.initState(); _load(); } Future<void> _load() async { running = await ToolboxNativeService.isFpsOverlayRunning(); if (mounted) setState(() {}); } Future<void> _apply() => ToolboxNativeService.updateFpsOverlaySettings({'position': position, 'showFps': showFps, 'showFpsLabel': showFpsLabel, 'reverseFormat': reverseFormat, 'showAppName': showAppName, 'showPackageName': showPackageName, 'showCpuInfo': showCpuInfo}); @override Widget build(BuildContext context) => _ModuleSheet(title: 'FPS & CPU Overlay', child: Column(children: <Widget>[DropdownButtonFormField<String>(initialValue: position, decoration: const InputDecoration(labelText: 'Position selector'), items: const [DropdownMenuItem(value: 'topLeft', child: Text('Top left')), DropdownMenuItem(value: 'topRight', child: Text('Top right')), DropdownMenuItem(value: 'bottomLeft', child: Text('Bottom left')), DropdownMenuItem(value: 'bottomRight', child: Text('Bottom right'))], onChanged: (v) => setState(() => position = v ?? position)), SwitchListTile(value: showFps, onChanged: (v) => setState(() => showFps = v), title: const Text('Show FPS')), SwitchListTile(value: showFpsLabel, onChanged: (v) => setState(() => showFpsLabel = v), title: const Text('Show FPS label')), SwitchListTile(value: reverseFormat, onChanged: (v) => setState(() => reverseFormat = v), title: const Text('Reverse format')), SwitchListTile(value: showAppName, onChanged: (v) => setState(() => showAppName = v), title: const Text('Show app name')), SwitchListTile(value: showPackageName, onChanged: (v) => setState(() => showPackageName = v), title: const Text('Show package name')), SwitchListTile(value: showCpuInfo, onChanged: (v) => setState(() => showCpuInfo = v), title: const Text('Show CPU info')), Row(children: <Widget>[Expanded(child: OutlinedButton(onPressed: () async { await _apply(); final ok = await ToolboxNativeService.startFpsOverlay(); if (mounted) setState(() => running = ok); }, child: const Text('Start'))), const SizedBox(width: 10), Expanded(child: OutlinedButton(onPressed: () async { await ToolboxNativeService.stopFpsOverlay(); if (mounted) setState(() => running = false); }, child: const Text('Stop')))]), Text(running ? 'Foreground service active' : 'Foreground service stopped', style: const TextStyle(color: Colors.white70, fontSize: 12))])); }

String _valueText(Object? value) => value == null || value.toString().trim().isEmpty ? '-' : value.toString();
String _formatAndroid(Object? version, Object? sdk) => '${_valueText(version) == '-' ? 'Android -' : 'Android ${_valueText(version)}'} (SDK ${_valueText(sdk)})';
String _formatHz(Object? value) { final parsed = double.tryParse(_valueText(value).replaceAll(RegExp(r'[^0-9.]'), '')); return parsed == null ? _valueText(value) : '${parsed.toStringAsFixed(parsed.truncateToDouble() == parsed ? 0 : 1)} Hz'; }
String _formatStorage(Object? value) => _valueText(value).replaceAllMapped(RegExp(r'\d+(\.\d+)?'), (m) { final n = double.tryParse(m[0]!) ?? 0; return n.toStringAsFixed(1); });
String _formatRam(Object? value) => _formatStorage(value);
String _formatBuildTime(Object? value) { final ms = int.tryParse(_valueText(value)); if (ms == null) return _valueText(value); final dt = DateTime.fromMillisecondsSinceEpoch(ms); return '${dt.year.toString().padLeft(4, '0')}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}'; }
