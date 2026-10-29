import 'package:flutter/material.dart';

/// Neutral color tokens for the kit's monochrome foundation.
abstract final class AfkColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF111110);
  static const Color charcoal = Color(0xFF1B1B19);
  static const Color gray50 = Color(0xFFF8F8F7);
  static const Color gray100 = Color(0xFFF0F0EE);
  static const Color gray200 = Color(0xFFE2E2DF);
  static const Color gray300 = Color(0xFFCACAC5);
  static const Color gray500 = Color(0xFF85857E);
  static const Color gray700 = Color(0xFF4B4B46);
  static const Color gray900 = Color(0xFF242421);

  static const Color lightBackground = Color(0xFFFCFCFB);
  static const Color darkBackground = Color(0xFF111110);
  static const Color lightSurface = white;
  static const Color darkSurface = charcoal;

  // Semantic feedback colors are separate from the neutral brand foundation.
  static const Color successForegroundLight = Color(0xFF216E45);
  static const Color successForegroundDark = Color(0xFF9ADCB3);
  static const Color successContainerLight = Color(0xFFEAF5EE);
  static const Color successContainerDark = Color(0xFF1C3929);
  static const Color warningForegroundLight = Color(0xFF805000);
  static const Color warningForegroundDark = Color(0xFFFFD08A);
  static const Color warningContainerLight = Color(0xFFFFF4DE);
  static const Color warningContainerDark = Color(0xFF3B2D16);
}
