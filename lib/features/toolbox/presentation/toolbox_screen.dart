import 'package:deadzon/core/widgets/glass_card.dart';
import 'package:deadzon/core/widgets/section_header.dart';
import 'package:deadzon/features/toolbox/services/toolbox_native_service.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(title: const Text('Toolbox Studio')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            _DeviceDashboard(summary: _summary, onOpenHardwareDetails: _openHardwareDetails),
            const SizedBox(height: 16),
            _AboutThisDevice(summary: _summary),
            const SizedBox(height: 16),
            const SectionHeader(title: 'System Tools', subtitle: 'Targeted recovery modules from Kaorios Toolbox'),
            const SizedBox(height: 10),
            const _ToolCard(title: 'FPS & CPU Overlay', subtitle: 'Placeholder UI kept for Phase 2 only.'),
            const _ToolCard(title: 'Payload Dumper', subtitle: 'Placeholder UI kept for Phase 2 only.'),
            const _ToolCard(title: 'Integrity / Features / Spoofing', subtitle: 'Recovered UI structure for configuration management.'),
            const _ToolCard(title: 'Hidden Features', subtitle: 'Staged advanced cards and import/export placeholders.'),
          ],
        ),
      ),
    );
  }

  Future<void> _openHardwareDetails() async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hardware Details'),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _kv('Brand', _summary['brand']),
                  _kv('Manufacturer', _summary['manufacturer']),
                  _kv('Product', _summary['product']),
                  _kv('Codename', _summary['codename']),
                  _kv('Model', _summary['model']),
                  _kv('Android Version', _summary['androidVersion']),
                  _kv('SDK', _summary['sdk']),
                  _kv('Security Patch', _summary['securityPatch']),
                  _kv('Kernel', _summary['kernel']),
                  _kv('Build ID', _summary['buildId']),
                  _kv('Build Display', _summary['buildDisplay']),
                  _kv('Build Type', _summary['buildType']),
                  _kv('Build Tags', _summary['buildTags']),
                  _kv('Build Time', _summary['buildTime']),
                  _kv('Build Host', _summary['buildHost']),
                  _kv('Build User', _summary['buildUser']),
                  _kv('Incremental', _summary['incremental']),
                  _kv('Radio Version', _summary['radioVersion']),
                  _kv('Java VM', _summary['javaVm']),
                  _kv('Locale', _summary['locale']),
                  _kv('Timezone', _summary['timezone']),
                  _kv('Fingerprint', _summary['fingerprint']),
                  _kv('Supported ABIs', _summary['supportedAbis']),
                  _kv('RAM', _summary['ram']),
                  _kv('Storage', _summary['storage']),
                  _kv('Resolution', _summary['resolution']),
                  _kv('Refresh Rate', _summary['refreshRate']),
                ],
              ),
            ),
          ),
          actions: <Widget>[TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close'))],
        );
      },
    );
  }

  Widget _kv(String label, Object? value) {
    final display = value == null || value.toString().trim().isEmpty ? '-' : value.toString();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            TextSpan(text: '$label: ', style: const TextStyle(fontWeight: FontWeight.w700)),
            TextSpan(text: display),
          ],
        ),
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
          const Text('Device Dashboard', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          const Text('Kaorios-style diagnostics overview', style: TextStyle(color: Colors.white60, fontSize: 12)),
          const SizedBox(height: 12),
          Wrap(
            runSpacing: 8,
            spacing: 8,
            children: <Widget>[
              _mini(context, 'Device', summary['model']),
              _mini(context, 'Android', '${summary['androidVersion'] ?? '-'} (SDK ${summary['sdk'] ?? '-'})'),
              _mini(context, 'RAM', summary['ram']),
              _mini(context, 'Storage', summary['storage']),
              _mini(context, 'Display', '${summary['resolution'] ?? '-'} • ${summary['refreshRate'] ?? '-'}'),
              _mini(context, 'Build', summary['buildDisplay']),
            ],
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton.icon(
              onPressed: onOpenHardwareDetails,
              icon: const Icon(Icons.memory_rounded),
              label: const Text('Hardware Details'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mini(BuildContext context, String label, Object? value) {
    final text = value == null || value.toString().trim().isEmpty ? '-' : value.toString();
    return Container(
      width: MediaQuery.of(context).size.width > 440 ? 190 : 160,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Text(label, style: const TextStyle(color: Colors.white60, fontSize: 11)),
        const SizedBox(height: 4),
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
        const Text('About This Device', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        _row('Brand / Manufacturer', '${summary['brand'] ?? '-'} / ${summary['manufacturer'] ?? '-'}'),
        _row('Product / Codename', '${summary['product'] ?? '-'} / ${summary['codename'] ?? '-'}'),
        _row('Build', '${summary['buildId'] ?? '-'} (${summary['buildType'] ?? '-'})'),
        _row('Security', summary['securityPatch']),
        _row('Kernel', summary['kernel']),
        _row('Fingerprint', summary['fingerprint']),
        _row('Locale • Timezone', '${summary['locale'] ?? '-'} • ${summary['timezone'] ?? '-'}'),
      ]),
    );
  }

  Widget _row(String label, Object? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        SizedBox(width: 130, child: Text(label, style: const TextStyle(color: Colors.white60))),
        Expanded(child: Text('${value ?? '-'}', style: const TextStyle(color: Colors.white))),
      ]),
    );
  }
}

class _ToolCard extends StatelessWidget {
  const _ToolCard({required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GlassCard(
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
          trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white60, size: 16),
        ),
      ),
    );
  }
}
