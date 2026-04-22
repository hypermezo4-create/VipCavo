import 'package:flutter/material.dart';

class DesignTokens {
  const DesignTokens._();

  static const Color bgTop = Color(0xFF173945);
  static const Color bgMid = Color(0xFF112830);
  static const Color bgBottom = Color(0xFF0A1419);

  static const Color glassFill = Color(0x1CFFFFFF);
  static const Color glassStroke = Color(0x29FFFFFF);
  static const Color glassHighlight = Color(0x3379E3CB);

  static const double radiusCard = 24;
  static const double radiusPanel = 18;

  static const EdgeInsets pagePadding = EdgeInsets.fromLTRB(18, 14, 18, 120);

  static const Curve motionCurve = Curves.easeOutCubic;
  static const Duration motionFast = Duration(milliseconds: 220);
  static const Duration motionMedium = Duration(milliseconds: 360);

  static const LinearGradient baseGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[bgTop, bgMid, bgBottom],
  );
}
