import 'package:flutter/material.dart';

class DesignTokens {
  const DesignTokens._();

  static const Color bgTop = Color(0xFF08192B);
  static const Color bgMid = Color(0xFF061427);
  static const Color bgBottom = Color(0xFF030B18);

  static const Color glassFill = Color(0x1CFFFFFF);
  static const Color glassStroke = Color(0x29FFFFFF);
  static const Color glassHighlight = Color(0x3379E3CB);

  static const double radiusCard = 24;
  static const double radiusPanel = 20;

  static const EdgeInsets pagePadding = EdgeInsets.fromLTRB(18, 12, 18, 140);

  static const double mainTitle = 28;
  static const double detailTitle = 26;
  static const double pageSubtitle = 13.4;
  static const double sectionTitle = 14;
  static const double rowTitle = 15.2;
  static const double rowSubtitle = 12;
  static const double valueChip = 13;
  static const double buttonText = 14.5;
  static const double navLabel = 11.2;

  static const Curve motionCurve = Curves.easeOutCubic;
  static const Duration motionFast = Duration(milliseconds: 220);
  static const Duration motionMedium = Duration(milliseconds: 360);

  static const LinearGradient baseGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[bgTop, bgMid, bgBottom],
  );
}
