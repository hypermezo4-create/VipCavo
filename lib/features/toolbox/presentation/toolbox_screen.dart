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
      body: SafeArea(child: ListView(padding: const EdgeInsets.all(16), children: <Widget>[
            GlassCard(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                const Text('Device Dashboard', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                Text('Device: ${_summary['model'] ?? 'Unknown'}', style: const TextStyle(color: Colors.white70)),
                Text('Android: ${_summary['release'] ?? '-'} (SDK ${_summary['sdk'] ?? '-'})', style: const TextStyle(color: Colors.white70)),
                Text('Battery: ${_summary['batteryPercent'] ?? '-'}%', style: const TextStyle(color: Colors.white70)),
                Text('RAM used: ${_summary['usedRamMb'] ?? '-'} MB / ${_summary['totalRamMb'] ?? '-'} MB', style: const TextStyle(color: Colors.white70)),
              ]),
            ),
            const SizedBox(height: 16),
            const SectionHeader(title: 'System Tools', subtitle: 'Targeted recovery modules from Kaorios Toolbox'),
            const SizedBox(height: 10),
            _ToolCard(title: 'FPS & CPU Overlay', subtitle: 'Permission, position, and display options (stage 1 shell).'),
            _ToolCard(title: 'Payload Dumper', subtitle: 'Parse payload sources from local file or URL (stage 1 shell).'),
            _ToolCard(title: 'Integrity / Features / Spoofing', subtitle: 'Recovered UI structure for configuration management.'),
            _ToolCard(title: 'Hidden Features', subtitle: 'Staged advanced cards and import/export placeholders.'),
      ])),
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

