import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class StatusbarScreen extends StatelessWidget {
  const StatusbarScreen({super.key});

  static const List<_StatusSection> _items = <_StatusSection>[
    _StatusSection('Resize statusbar', Icons.crop_rounded, Color(0xFF7BFF96)),
    _StatusSection('Battery', Icons.battery_6_bar_rounded, Color(0xFFFF8FA8)),
    _StatusSection('Clock', Icons.access_time_rounded, Color(0xFF8CC2FF)),
    _StatusSection('Netspeed', Icons.speed_rounded, Color(0xFFE6A8FF)),
    _StatusSection('Network', Icons.signal_cellular_alt_rounded, Color(0xFFFFC668)),
    _StatusSection('Notification icons', Icons.notifications_rounded, Color(0xFF85B8FF)),
    _StatusSection('Status icons', Icons.widgets_rounded, Color(0xFF8EF0C1)),
    _StatusSection('Date', Icons.calendar_month_rounded, Color(0xFFFFD45E)),
    _StatusSection('Weather', Icons.cloud_rounded, Color(0xFF9FDBFF)),
    _StatusSection('Prompt icon', Icons.chat_bubble_outline_rounded, Color(0xFFFFA9C2)),
    _StatusSection('Background', Icons.format_paint_rounded, Color(0xFF67E6FF)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color(0xFF83AFC2),
              Color(0xFF56798B),
              Color(0xFF19303A),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _TopBar(
                  title: 'Statusbar adjustment',
                  subtitle: 'Customize every detail in your statusbar',
                  onBack: () => Navigator.of(context).pop(),
                ),
                const SizedBox(height: 18),
                const _PreviewCard(),
                const SizedBox(height: 18),
                GridView.builder(
                  itemCount: _items.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.95,
                  ),
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return _MiniFeatureCard(item: item)
                        .animate(delay: (55 * index).ms)
                        .fadeIn(duration: 320.ms)
                        .scale(begin: const Offset(0.92, 0.92), end: const Offset(1, 1));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.title,
    required this.subtitle,
    required this.onBack,
  });

  final String title;
  final String subtitle;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _CircleButton(
          icon: Icons.arrow_back_ios_new_rounded,
          onTap: onBack,
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.78),
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PreviewCard extends StatelessWidget {
  const _PreviewCard();

  @override
  Widget build(BuildContext context) {
    return _GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Live preview',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 14),
          Container(
            height: 118,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.black.withValues(alpha: 0.26),
              border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Text(
                      '09:15',
                      style: TextStyle(
                        color: Color(0xFF89F3A0),
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 92,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.signal_cellular_alt_rounded, color: Colors.white),
                    const SizedBox(width: 6),
                    const Icon(Icons.wifi_rounded, color: Colors.white),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF7BF2A0).withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Text(
                        '100',
                        style: TextStyle(
                          color: Color(0xFF90FFAC),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    _PreviewIcon(Icons.bluetooth_rounded, Color(0xFF7DB6FF)),
                    _PreviewIcon(Icons.wifi_tethering_rounded, Color(0xFF77F1D5)),
                    _PreviewIcon(Icons.notifications_rounded, Color(0xFFB29DFF)),
                    _PreviewIcon(Icons.camera_alt_rounded, Color(0xFFFFB66A)),
                    _PreviewIcon(Icons.music_note_rounded, Color(0xFF8CE4FF)),
                    _PreviewIcon(Icons.bolt_rounded, Color(0xFF8FFF93)),
                    _PreviewIcon(Icons.whatsapp_rounded, Color(0xFF7FFF91)),
                    _PreviewIcon(Icons.email_outlined, Color(0xFFFF90B5)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniFeatureCard extends StatelessWidget {
  const _MiniFeatureCard({required this.item});

  final _StatusSection item;

  @override
  Widget build(BuildContext context) {
    return _GlassPanel(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item.title} detail page comes next.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(item.icon, color: item.color, size: 28),
          const SizedBox(height: 12),
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}

class _PreviewIcon extends StatelessWidget {
  const _PreviewIcon(this.icon, this.color);

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Icon(icon, color: color, size: 18);
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.14),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 42,
          height: 42,
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}

class _GlassPanel extends StatelessWidget {
  const _GlassPanel({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
  });

  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final panel = ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
          ),
          child: child,
        ),
      ),
    );

    if (onTap == null) return panel;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(26),
        onTap: onTap,
        child: panel,
      ),
    );
  }
}

class _StatusSection {
  const _StatusSection(this.title, this.icon, this.color);

  final String title;
  final IconData icon;
  final Color color;
}