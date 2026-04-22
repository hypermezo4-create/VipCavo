import 'package:deadzon/core/widgets/glass_card.dart';
import 'package:deadzon/core/widgets/premium_top_bar.dart';
import 'package:deadzon/core/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class StatusbarScreen extends StatelessWidget {
  const StatusbarScreen({super.key});

  static const List<_StatusItem> _items = <_StatusItem>[
    _StatusItem('Resize statusbar', Icons.crop_rounded),
    _StatusItem('Battery', Icons.battery_6_bar_rounded),
    _StatusItem('Clock', Icons.access_time_rounded),
    _StatusItem('Netspeed', Icons.speed_rounded),
    _StatusItem('Network', Icons.signal_cellular_alt_rounded),
    _StatusItem('Notification icons', Icons.notifications_rounded),
    _StatusItem('Status icons', Icons.widgets_rounded),
    _StatusItem('Date', Icons.calendar_month_rounded),
    _StatusItem('Weather', Icons.cloud_rounded),
    _StatusItem('Prompt icon', Icons.chat_bubble_outline_rounded),
    _StatusItem('Background', Icons.format_paint_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Color(0xFF14303A), Color(0xFF10232B), Color(0xFF0A1419)],
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 120),
          children: <Widget>[
            const PremiumTopBar(
              title: 'Statusbar Adjustment',
              subtitle: 'Powerful and polished statusbar personalization',
            ),
            const SizedBox(height: 16),
            const _PreviewCard(),
            const SizedBox(height: 20),
            const SectionHeader(title: 'Sections', subtitle: 'Organized controls with smooth detail flow'),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.3,
              ),
              itemBuilder: (context, index) {
                final item = _items[index];
                return GlassCard(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${item.title} detail is next.'), behavior: SnackBarBehavior.floating),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(item.icon, color: const Color(0xFF87EED8)),
                      const SizedBox(height: 8),
                      Text(item.title, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                )
                    .animate(delay: (55 * index).ms)
                    .fadeIn(duration: 280.ms)
                    .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _PreviewCard extends StatelessWidget {
  const _PreviewCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SectionHeader(title: 'Live preview'),
          const SizedBox(height: 12),
          Container(
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.black.withValues(alpha: 0.28),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const Row(
              children: <Widget>[
                Text('09:15', style: TextStyle(color: Color(0xFF89F3A0), fontWeight: FontWeight.w700)),
                Spacer(),
                Icon(Icons.signal_cellular_alt_rounded, color: Colors.white70),
                SizedBox(width: 6),
                Icon(Icons.wifi_rounded, color: Colors.white70),
                SizedBox(width: 6),
                Icon(Icons.battery_5_bar_rounded, color: Color(0xFF90FFAC)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusItem {
  const _StatusItem(this.title, this.icon);

  final String title;
  final IconData icon;
}
