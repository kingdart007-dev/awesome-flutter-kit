import 'package:flutter/material.dart';

import 'afk_colors.dart';
import 'afk_radius.dart';

/// Theme factory for Awesome Flutter Kit.
///
/// The host app can still override individual ThemeData properties after
/// calling these helpers. No brand accent is imposed by default.
abstract final class AfkTheme {
  static ThemeData light() => _build(Brightness.light);

  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final background = isDark ? AfkColors.darkBackground : AfkColors.lightBackground;
    final surface = isDark ? AfkColors.darkSurface : AfkColors.lightSurface;
    final foreground = isDark ? AfkColors.white : AfkColors.black;
    final subtle = isDark ? AfkColors.gray500 : AfkColors.gray700;
    final outline = isDark ? AfkColors.gray700 : AfkColors.gray200;

    final scheme = ColorScheme(
      brightness: brightness,
      primary: foreground,
      onPrimary: isDark ? AfkColors.black : AfkColors.white,
      secondary: subtle,
      onSecondary: isDark ? AfkColors.black : AfkColors.white,
      error: const Color(0xFFB42318),
      onError: AfkColors.white,
      surface: surface,
      onSurface: foreground,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      canvasColor: background,
      dividerColor: outline,
      cardColor: surface,
      splashFactory: InkSparkle.splashFactory,
      visualDensity: VisualDensity.standard,
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: foreground,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: foreground,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AfkRadius.lg),
          side: BorderSide(color: outline),
        ),
      ),
      dividerTheme: DividerThemeData(color: outline, thickness: 1, space: 1),
      textTheme: ThemeData(brightness: brightness).textTheme.apply(
            bodyColor: foreground,
            displayColor: foreground,
          ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AfkRadius.md),
          borderSide: BorderSide(color: outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AfkRadius.md),
          borderSide: BorderSide(color: outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AfkRadius.md),
          borderSide: BorderSide(color: foreground, width: 1.5),
        ),
      ),
    );
  }
}
