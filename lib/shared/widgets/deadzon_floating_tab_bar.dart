import 'dart:ui';

import 'package:flutter/material.dart';

class DeadzonFloatingTabItem {
  const DeadzonFloatingTabItem({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

class DeadzonFloatingTabBar extends StatelessWidget {
  const DeadzonFloatingTabBar({
    required this.currentIndex,
    required this.items,
    required this.onTap,
    required this.accentColor,
    required this.backgroundTint,
    super.key,
  });

  final int currentIndex;
  final List<DeadzonFloatingTabItem> items;
  final ValueChanged<int> onTap;
  final Color accentColor;
  final Color backgroundTint;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final idleColor = isLight ? const Color(0xFF4A5A63) : Colors.white70;
    final borderColor = isLight ? Colors.black.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.2);

    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(36),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: 74,
            decoration: BoxDecoration(
              color: backgroundTint.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(36),
              border: Border.all(color: borderColor),
              boxShadow: <BoxShadow>[
                BoxShadow(color: Colors.black.withValues(alpha: isLight ? 0.08 : 0.2), blurRadius: 20, offset: const Offset(0, 8)),
              ],
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth / items.length;
                return Stack(
                  children: <Widget>[
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic,
                      left: currentIndex * width + 8,
                      top: 8,
                      width: width - 16,
                      height: 58,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: accentColor.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(color: accentColor.withValues(alpha: 0.45)),
                        ),
                      ),
                    ),
                    Row(
                      children: List<Widget>.generate(items.length, (index) {
                        final selected = index == currentIndex;
                        final item = items[index];
                        return Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(28),
                            onTap: () => onTap(index),
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 280),
                              curve: Curves.easeOutCubic,
                              style: TextStyle(
                                color: selected ? accentColor : idleColor,
                                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                                fontSize: 11,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(item.icon, color: selected ? accentColor : idleColor, size: selected ? 22 : 20),
                                  const SizedBox(height: 4),
                                  Text(item.label),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
