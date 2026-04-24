import 'package:deadzon/core/theme/deadzon_theme_controller.dart';
import 'package:deadzon/core/theme/design_tokens.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData light(DeadzonThemeController theme) {
    final base = ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: theme.accentColor, brightness: Brightness.light));

    return base.copyWith(
      scaffoldBackgroundColor: const Color(0xFFF2F7F8),
      pageTransitionsTheme: const PageTransitionsTheme(builders: <TargetPlatform, PageTransitionsBuilder>{TargetPlatform.android: CupertinoPageTransitionsBuilder(), TargetPlatform.iOS: CupertinoPageTransitionsBuilder()}),
      textTheme: GoogleFonts.interTextTheme(base.textTheme),
      appBarTheme: AppBarTheme(backgroundColor: Colors.transparent, elevation: 0, foregroundColor: theme.textAccentColor),
      cardTheme: CardThemeData(
        color: theme.cardTint.withValues(alpha: 0.35),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28), side: BorderSide(color: theme.borderColor)),
      ),
      dividerColor: Colors.black.withValues(alpha: 0.08),
      sliderTheme: base.sliderTheme.copyWith(activeTrackColor: theme.sliderColor, thumbColor: theme.sliderColor),
      switchTheme: SwitchThemeData(thumbColor: WidgetStatePropertyAll(theme.switchOnColor)),
      checkboxTheme: CheckboxThemeData(fillColor: WidgetStatePropertyAll(theme.checkboxColor)),
    );
  }

  static ThemeData dark(DeadzonThemeController theme) {
    final base = ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: theme.accentColor, brightness: Brightness.dark));

    return base.copyWith(
      scaffoldBackgroundColor: const Color(0xFF0B1418),
      splashFactory: InkSparkle.splashFactory,
      pageTransitionsTheme: const PageTransitionsTheme(builders: <TargetPlatform, PageTransitionsBuilder>{TargetPlatform.android: CupertinoPageTransitionsBuilder(), TargetPlatform.iOS: CupertinoPageTransitionsBuilder()}),
      textTheme: GoogleFonts.interTextTheme(base.textTheme).apply(bodyColor: Colors.white, displayColor: Colors.white),
      appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0, foregroundColor: Colors.white),
      cardTheme: CardThemeData(
        color: theme.cardTint.withValues(alpha: 0.4),
        shadowColor: DesignTokens.glassHighlight.withValues(alpha: 0.2),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28), side: BorderSide(color: theme.borderColor)),
      ),
      dividerColor: Colors.white.withValues(alpha: 0.08),
      sliderTheme: base.sliderTheme.copyWith(activeTrackColor: theme.sliderColor, thumbColor: theme.sliderColor),
      switchTheme: SwitchThemeData(thumbColor: WidgetStatePropertyAll(theme.switchOnColor)),
      checkboxTheme: CheckboxThemeData(fillColor: WidgetStatePropertyAll(theme.checkboxColor)),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(backgroundColor: theme.accentColor, foregroundColor: Colors.black87),
      ),
    );
  }
}
