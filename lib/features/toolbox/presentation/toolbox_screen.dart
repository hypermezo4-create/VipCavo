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
              colors: <Color>[Color(0xFF0A0E24), Color(0xFF15173A), Color(0xFF1B2453)],
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
                const SectionHeader(title: 'DeadZone Tools', subtitle: 'Premium DeadZone recovery modules'),
                const SizedBox(height: 10),
                const _SystemToolsGrid(),
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
        final scaler = MediaQuery.textScalerOf(context).clamp(minScaleFactor: 0.9, maxScaleFactor: 1.1);
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: scaler),
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.82,
            maxChildSize: 0.94,
            minChildSize: 0.6,
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
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 48,
                        height: 5,
                        decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(8)),
                      ),
                      const SizedBox(height: 12),
                      const Text('DeadZone Hardware Details', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800, color: Colors.white)),
                      const SizedBox(height: 12),
                      Expanded(
                        child: ListView(
                          controller: controller,
                          children: <Widget>[
                            _HardwareRow(icon: Icons.business_rounded, label: 'Brand', value: _summary['brand']),
                            _HardwareRow(icon: Icons.factory_rounded, label: 'Manufacturer', value: _summary['manufacturer']),
                            _HardwareRow(icon: Icons.widgets_rounded, label: 'Product', value: _summary['product']),
                            _HardwareRow(icon: Icons.code_rounded, label: 'Codename', value: _summary['codename']),
                            _HardwareRow(icon: Icons.phone_android_rounded, label: 'Model', value: _summary['model']),
                            _HardwareRow(icon: Icons.android_rounded, label: 'Android Version', value: _summary['androidVersion']),
                            _HardwareRow(icon: Icons.numbers_rounded, label: 'SDK', value: _summary['sdk']),
                            _HardwareRow(icon: Icons.security_rounded, label: 'Security Patch', value: _summary['securityPatch']),
                            _HardwareRow(icon: Icons.developer_board_rounded, label: 'Kernel', value: _summary['kernel'], copyable: true),
                            _HardwareRow(icon: Icons.fingerprint_rounded, label: 'Fingerprint', value: _summary['fingerprint'], copyable: true),
                            _HardwareRow(icon: Icons.settings_ethernet_rounded, label: 'Radio Version', value: _summary['radioVersion'], copyable: true),
                            _HardwareRow(icon: Icons.badge_rounded, label: 'Build ID', value: _summary['buildId']),
                            _HardwareRow(icon: Icons.display_settings_rounded, label: 'Build Display', value: _summary['buildDisplay']),
                            _HardwareRow(icon: Icons.build_circle_rounded, label: 'Build Type', value: _summary['buildType']),
                            _HardwareRow(icon: Icons.sell_rounded, label: 'Build Tags', value: _summary['buildTags']),
                            _HardwareRow(icon: Icons.schedule_rounded, label: 'Build Time', value: _summary['buildTime']),
                            _HardwareRow(icon: Icons.dns_rounded, label: 'Build Host', value: _summary['buildHost']),
                            _HardwareRow(icon: Icons.person_rounded, label: 'Build User', value: _summary['buildUser']),
                            _HardwareRow(icon: Icons.update_rounded, label: 'Incremental', value: _summary['incremental']),
                            _HardwareRow(icon: Icons.memory_rounded, label: 'RAM', value: _summary['ram']),
                            _HardwareRow(icon: Icons.sd_storage_rounded, label: 'Storage', value: _summary['storage']),
                            _HardwareRow(icon: Icons.screen_rotation_alt_rounded, label: 'Resolution', value: _summary['resolution']),
                            _HardwareRow(icon: Icons.speed_rounded, label: 'Refresh Rate', value: _summary['refreshRate']),
                            _HardwareRow(icon: Icons.terminal_rounded, label: 'Java VM', value: _summary['javaVm']),
                            _HardwareRow(icon: Icons.language_rounded, label: 'Locale', value: _summary['locale']),
                            _HardwareRow(icon: Icons.public_rounded, label: 'Timezone', value: _summary['timezone']),
                            _HardwareRow(icon: Icons.developer_mode_rounded, label: 'Supported ABIs', value: _summary['supportedAbis'], copyable: true),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _HardwareRow extends StatelessWidget {
  const _HardwareRow({required this.icon, required this.label, required this.value, this.copyable = false});

  final IconData icon;
  final String label;
  final Object? value;
  final bool copyable;

  @override
  Widget build(BuildContext context) {
    final display = value == null || value.toString().trim().isEmpty ? '-' : value.toString();
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
        color: Colors.white.withValues(alpha: 0.06),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: Colors.cyanAccent.shade100, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12.5, fontWeight: FontWeight.w600)),
                const SizedBox(height: 3),
                Text(display, style: const TextStyle(color: Colors.white, fontSize: 14.5, height: 1.35)),
              ],
            ),
          ),
          if (copyable && display != '-')
            IconButton(
              visualDensity: VisualDensity.compact,
              tooltip: 'Copy',
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: display));
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Copied to clipboard')));
                }
              },
              icon: const Icon(Icons.copy_rounded, size: 18, color: Colors.white70),
            ),
        ],
      ),
    );
  }
}

class _DeviceDashboard extends StatelessWidget {
  const _DeviceDashboard({required this.summary, required this.onOpenHardwareDetails});

  final Map<String, dynamic> summary;
  final VoidCallback onOpenHardwareDetails;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('DeadZone Dashboard', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          const Text('DeadZone premium diagnostics overview', style: TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 12),
          Wrap(
            runSpacing: 10,
            spacing: 10,
            children: <Widget>[
              _mini(context, Icons.phone_iphone_rounded, 'Device', summary['model']),
              _mini(context, Icons.android_rounded, 'Android', '${summary['androidVersion'] ?? '-'} (SDK ${summary['sdk'] ?? '-'})'),
              _mini(context, Icons.memory_rounded, 'RAM', summary['ram']),
              _mini(context, Icons.sd_storage_rounded, 'Storage', summary['storage']),
              _mini(context, Icons.monitor_rounded, 'Display', '${summary['resolution'] ?? '-'} • ${summary['refreshRate'] ?? '-'}'),
              _mini(context, Icons.construction_rounded, 'Build', summary['buildDisplay']),
            ],
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton.icon(
              onPressed: onOpenHardwareDetails,
              style: FilledButton.styleFrom(backgroundColor: Colors.cyanAccent.withValues(alpha: 0.18)),
              icon: const Icon(Icons.memory_rounded),
              label: const Text('DeadZone Hardware Details'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mini(BuildContext context, IconData icon, String label, Object? value) {
    final text = value == null || value.toString().trim().isEmpty ? '-' : value.toString();
    final isWide = MediaQuery.of(context).size.width > 460;
    return Container(
      width: isWide ? 196 : (MediaQuery.of(context).size.width - 54) / 2,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(colors: <Color>[Colors.white.withValues(alpha: 0.12), Colors.white.withValues(alpha: 0.05)]),
        border: Border.all(color: Colors.white30),
        boxShadow: <BoxShadow>[BoxShadow(color: Colors.indigoAccent.withValues(alpha: 0.25), blurRadius: 14, spreadRadius: -8)],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Icon(icon, color: Colors.lightBlueAccent.shade100, size: 19),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11.5)),
        const SizedBox(height: 3),
        Text(text, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ]),
    );
  }
}

class _AboutThisDevice extends StatelessWidget {
  const _AboutThisDevice({required this.summary});
  final Map<String, dynamic> summary;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        const Text('DeadZone Device Info', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        _row(Icons.badge_rounded, 'Brand / Manufacturer', '${summary['brand'] ?? '-'} / ${summary['manufacturer'] ?? '-'}'),
        _row(Icons.widgets_rounded, 'Product / Codename', '${summary['product'] ?? '-'} / ${summary['codename'] ?? '-'}'),
        _row(Icons.build_rounded, 'Build', '${summary['buildId'] ?? '-'} (${summary['buildType'] ?? '-'})'),
        _row(Icons.verified_user_rounded, 'Security', summary['securityPatch']),
        _row(Icons.developer_board_rounded, 'Kernel', summary['kernel']),
        _row(Icons.fingerprint_rounded, 'Fingerprint', summary['fingerprint']),
        _row(Icons.public_rounded, 'Locale • Timezone', '${summary['locale'] ?? '-'} • ${summary['timezone'] ?? '-'}'),
      ]),
    );
  }

  Widget _row(IconData icon, String label, Object? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Icon(icon, size: 18, color: Colors.cyanAccent.shade100),
        const SizedBox(width: 10),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Text(label, style: const TextStyle(color: Colors.white60, fontSize: 12.5, fontWeight: FontWeight.w600)),
            const SizedBox(height: 2),
            Text('${value ?? '-'}', style: const TextStyle(color: Colors.white, height: 1.35)),
          ]),
        ),
      ]),
    );
  }
}

class _SystemToolsGrid extends StatelessWidget {
  const _SystemToolsGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1.17,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: const <Widget>[
        _FpsCpuOverlayCard(),
        _ToolCard(title: 'Payload Dumper', subtitle: 'Phase 2 placeholder module', icon: Icons.archive_rounded),
        _ToolCard(title: 'Integrity Suite', subtitle: 'Features and spoofing controls', icon: Icons.shield_rounded),
        _ToolCard(title: 'Hidden Features', subtitle: 'Premium staged controls', icon: Icons.tune_rounded),
      ],
    );
  }
}

class _ToolCard extends StatelessWidget {
  const _ToolCard({required this.title, required this.subtitle, required this.icon});
  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Icon(icon, color: Colors.white, size: 24),
        const Spacer(),
        Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        Text(subtitle, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ]),
    );
  }
}

class _FpsCpuOverlayCard extends StatefulWidget {
  const _FpsCpuOverlayCard();

  @override
  State<_FpsCpuOverlayCard> createState() => _FpsCpuOverlayCardState();
}

class _FpsCpuOverlayCardState extends State<_FpsCpuOverlayCard> {
  bool canOverlay = false;
  bool running = false;
  String position = 'topRight';
  bool showFps = true;
  bool showFpsLabel = true;
  bool reverseFormat = false;
  bool showAppName = false;
  bool showPackageName = false;
  bool showCpuInfo = false;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    final can = await ToolboxNativeService.canDrawOverlays();
    final isRunning = await ToolboxNativeService.isFpsOverlayRunning();
    if (!mounted) return;
    setState(() {
      canOverlay = can;
      running = isRunning;
    });
  }

  Future<void> _applySettings() async {
    await ToolboxNativeService.updateFpsOverlaySettings(<String, dynamic>{
      'position': position,
      'showFps': showFps,
      'showFpsLabel': showFpsLabel,
      'reverseFormat': reverseFormat,
      'showAppName': showAppName,
      'showPackageName': showPackageName,
      'showCpuInfo': showCpuInfo,
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(children: <Widget>[
            const Icon(Icons.speed_rounded, color: Colors.cyanAccent),
            const SizedBox(width: 8),
            const Expanded(child: Text('FPS & CPU Overlay', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700))),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(color: (running ? Colors.green : Colors.orange).withValues(alpha: 0.22), borderRadius: BorderRadius.circular(999)),
              child: Text(running ? 'Active' : 'Ready', style: const TextStyle(color: Colors.white, fontSize: 11)),
            ),
          ]),
          const SizedBox(height: 6),
          const Text('Live monitor controls and quick launch.', style: TextStyle(color: Colors.white70, fontSize: 12)),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: OutlinedButton(
              onPressed: () async {
                if (!canOverlay) {
                  await ToolboxNativeService.openOverlayPermissionPanel();
                  await _refresh();
                  return;
                }
                await _applySettings();
                if (!running) {
                  final ok = await ToolboxNativeService.startFpsOverlay();
                  if (mounted) setState(() => running = ok);
                }
              },
              child: Text(canOverlay ? (running ? 'Running' : 'Start') : 'Grant Permission'),
            ),
          ),
        ],
      ),
    );
  }
}
