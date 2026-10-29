import 'package:flutter/animation.dart';

/// Timing and easing tokens for consistent, restrained interface motion.
abstract final class AfkMotion {
  /// Very short feedback, such as a pressed or selected state.
  static const Duration fast = Duration(milliseconds: 120);

  /// Standard component transitions.
  static const Duration normal = Duration(milliseconds: 200);

  /// Larger changes in layout or content hierarchy.
  static const Duration deliberate = Duration(milliseconds: 280);

  static const Curve standard = Curves.easeOutCubic;
  static const Curve enter = Curves.easeOutQuart;
  static const Curve exit = Curves.easeInCubic;
  static const Curve emphasized = Curves.easeInOutCubic;
}
