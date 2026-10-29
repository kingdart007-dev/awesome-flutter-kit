import 'package:flutter/material.dart';

import '../theme/afk_motion.dart';

/// Animates replacement content with a subtle fade.
///
/// The transition becomes immediate when the operating system requests
/// reduced motion. Use stable, distinct keys on children when replacing
/// content so [AnimatedSwitcher] can identify each state.
class AfkContentSwitcher extends StatelessWidget {
  const AfkContentSwitcher({
    required this.child,
    this.duration = AfkMotion.normal,
    this.switchInCurve = AfkMotion.enter,
    this.switchOutCurve = AfkMotion.exit,
    super.key,
  });

  final Widget child;
  final Duration duration;
  final Curve switchInCurve;
  final Curve switchOutCurve;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    return AnimatedSwitcher(
      duration: reduceMotion ? Duration.zero : duration,
      switchInCurve: switchInCurve,
      switchOutCurve: switchOutCurve,
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      child: child,
    );
  }
}
