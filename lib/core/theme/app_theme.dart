import 'package:deadzon/core/theme/deadzon_theme_controller.dart';
import 'package:deadzon/core/theme/design_tokens.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData light(DeadzonThemeController theme) {
    final base = ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: theme.accentColor, brightness: Brightness.light));

    return base.copyWith(
      scaffoldBackgroundColor: theme.selectedLightBackground.color,
      pageTransitionsTheme: const PageTransitionsTheme(builders: <TargetPlatform, PageTransitionsBuilder>{TargetPlatform.android: CupertinoPageTransitionsBuilder(), TargetPlatform.iOS: CupertinoPageTransitionsBuilder()}),
      textTheme: GoogleFonts.interTextTheme(base.textTheme).copyWith(
        headlineMedium: GoogleFonts.inter(fontSize: DesignTokens.mainTitle, fontWeight: FontWeight.w800, letterSpacing: -0.3),
        titleLarge: GoogleFonts.inter(fontSize: DesignTokens.sectionTitle, fontWeight: FontWeight.w700, letterSpacing: -0.2),
        titleMedium: GoogleFonts.inter(fontSize: DesignTokens.rowTitle, fontWeight: FontWeight.w600),
        bodyLarge: GoogleFonts.inter(fontSize: DesignTokens.pageSubtitle, fontWeight: FontWeight.w500, height: 1.3),
        bodyMedium: GoogleFonts.inter(fontSize: DesignTokens.rowSubtitle, fontWeight: FontWeight.w500, height: 1.3),
        labelLarge: GoogleFonts.inter(fontSize: DesignTokens.buttonText, fontWeight: FontWeight.w600),
        labelSmall: GoogleFonts.inter(fontSize: DesignTokens.navLabel, fontWeight: FontWeight.w600),
      ),
      appBarTheme: AppBarTheme(backgroundColor: Colors.transparent, elevation: 0, foregroundColor: theme.textAccentColor),
      cardTheme: CardThemeData(
        color: Color.lerp(theme.selectedLightBackground.color, theme.selectedLightPalette.color, 0.26)?.withValues(alpha: 0.88),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28), side: BorderSide(color: theme.borderColor)),
      ),
      dividerColor: Colors.black.withValues(alpha: 0.08),
      sliderTheme: base.sliderTheme.copyWith(
        trackHeight: 3.4,
        activeTrackColor: theme.sliderColor,
        inactiveTrackColor: Colors.black.withValues(alpha: 0.14),
        thumbColor: theme.sliderColor,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
        overlayShape: SliderComponentShape.noOverlay,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) => states.contains(WidgetState.selected) ? const Color(0xFFD9FFF7) : const Color(0xFFBEC9D4)),
        trackColor: WidgetStateProperty.resolveWith((states) => states.contains(WidgetState.selected) ? theme.switchOnColor.withValues(alpha: 0.84) : const Color(0xFF68829A)),
      ),
      checkboxTheme: CheckboxThemeData(fillColor: WidgetStatePropertyAll(theme.checkboxColor)),
    );
  }

  static ThemeData dark(DeadzonThemeController theme) {
    final base = ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: theme.accentColor, brightness: Brightness.dark));

    return base.copyWith(
      scaffoldBackgroundColor: theme.selectedDarkBackground.color,
      splashFactory: InkSparkle.splashFactory,
      pageTransitionsTheme: const PageTransitionsTheme(builders: <TargetPlatform, PageTransitionsBuilder>{TargetPlatform.android: CupertinoPageTransitionsBuilder(), TargetPlatform.iOS: CupertinoPageTransitionsBuilder()}),
      textTheme: GoogleFonts.interTextTheme(base.textTheme).apply(bodyColor: Colors.white, displayColor: Colors.white).copyWith(
        headlineMedium: GoogleFonts.inter(fontSize: DesignTokens.mainTitle, fontWeight: FontWeight.w800, letterSpacing: -0.3, color: Colors.white),
        titleLarge: GoogleFonts.inter(fontSize: DesignTokens.sectionTitle, fontWeight: FontWeight.w700, letterSpacing: -0.2, color: Colors.white),
        titleMedium: GoogleFonts.inter(fontSize: DesignTokens.rowTitle, fontWeight: FontWeight.w600, color: Colors.white),
        bodyLarge: GoogleFonts.inter(fontSize: DesignTokens.pageSubtitle, fontWeight: FontWeight.w500, height: 1.3, color: Colors.white),
        bodyMedium: GoogleFonts.inter(fontSize: DesignTokens.rowSubtitle, fontWeight: FontWeight.w500, height: 1.3, color: Colors.white),
        labelLarge: GoogleFonts.inter(fontSize: DesignTokens.buttonText, fontWeight: FontWeight.w600, color: Colors.white),
        labelSmall: GoogleFonts.inter(fontSize: DesignTokens.navLabel, fontWeight: FontWeight.w600, color: Colors.white),
      ),
      appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0, foregroundColor: Colors.white),
      cardTheme: CardThemeData(
        color: Color.lerp(theme.selectedDarkBackground.color, theme.selectedDarkPalette.color, 0.35)?.withValues(alpha: 0.86),
        shadowColor: DesignTokens.glassHighlight.withValues(alpha: 0.2),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28), side: BorderSide(color: theme.borderColor)),
      ),
      dividerColor: Colors.white.withValues(alpha: 0.08),
      sliderTheme: base.sliderTheme.copyWith(
        trackHeight: 3.4,
        activeTrackColor: theme.sliderColor,
        inactiveTrackColor: Colors.white.withValues(alpha: 0.18),
        thumbColor: const Color(0xFFC8FFF6),
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
        overlayShape: SliderComponentShape.noOverlay,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) => states.contains(WidgetState.selected) ? const Color(0xFFD8FFF8) : const Color(0xFFC9D3DE)),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? const Color(0xFF2FD2C0).withValues(alpha: 0.82) : const Color(0xFF344C61),
        ),
      ),
      checkboxTheme: CheckboxThemeData(fillColor: WidgetStatePropertyAll(theme.checkboxColor)),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(backgroundColor: theme.accentColor, foregroundColor: Colors.black87),
      ),
    );
  }
}
