import 'package:flutter/material.dart';

/// Typography roles shared by the kit's themes and example applications.
abstract final class AfkTypography {
  static const TextStyle pageTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: -0.4,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.25,
    letterSpacing: -0.2,
  );

  static const TextStyle itemTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.35,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static const TextStyle label = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  static TextTheme apply(TextTheme base, Color foreground) {
    return base.apply(bodyColor: foreground, displayColor: foreground).copyWith(
      headlineSmall: pageTitle.copyWith(color: foreground),
      titleLarge: sectionTitle.copyWith(color: foreground),
      titleMedium: itemTitle.copyWith(color: foreground),
      bodyMedium: body.copyWith(color: foreground),
      labelLarge: label.copyWith(color: foreground),
    );
  }
}
