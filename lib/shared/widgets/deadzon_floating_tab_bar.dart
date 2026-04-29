import 'package:deadzon/core/theme/design_tokens.dart';
import 'package:deadzon/core/theme/deadzon_theme_controller.dart';
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
    final idleColor = DeadzonThemeTokens.bottomNavText(context);
    final borderColor = DeadzonThemeTokens.bottomNavBorder(context);

    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(36),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: backgroundTint.withValues(alpha: 0.93),
              borderRadius: BorderRadius.circular(36),
              border: Border.all(color: borderColor),
              boxShadow: <BoxShadow>[
                BoxShadow(color: Colors.black.withValues(alpha: 0.16), blurRadius: 20, offset: const Offset(0, 8)),
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
                      top: 7,
                      width: width - 16,
                      height: 56,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: DeadzonThemeTokens.bottomNavSelectedBackground(context),
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
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => onTap(index),
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 280),
                              curve: Curves.easeOutCubic,
                              style: TextStyle(
                                color: selected ? DeadzonThemeTokens.bottomNavSelectedText(context) : idleColor,
                                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                                fontSize: DesignTokens.navLabel,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(item.icon, color: selected ? DeadzonThemeTokens.bottomNavSelectedText(context) : idleColor, size: selected ? 21 : 19),
                                  const SizedBox(height: 3),
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
