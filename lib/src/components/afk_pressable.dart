import 'package:flutter/material.dart';

import '../theme/afk_motion.dart';
import '../theme/afk_radius.dart';

/// Adds restrained press feedback to custom interactive content.
///
/// The callback remains owned by the host app. Reduced-motion preferences are
/// respected, and the child keeps its normal layout and semantics.
class AfkPressable extends StatefulWidget {
  const AfkPressable({
    required this.child,
    required this.onTap,
    this.borderRadius = AfkRadius.lg,
    this.scaleFactor = 0.985,
    this.enableFeedback = true,
    super.key,
  }) : assert(scaleFactor > 0 && scaleFactor <= 1);

  final Widget child;
  final VoidCallback? onTap;
  final double borderRadius;
  final double scaleFactor;
  final bool enableFeedback;

  @override
  State<AfkPressable> createState() => _AfkPressableState();
}

class _AfkPressableState extends State<AfkPressable> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    final enabled = widget.onTap != null;

    return AnimatedScale(
      scale: enabled && _pressed ? widget.scaleFactor : 1,
      duration: reduceMotion ? Duration.zero : AfkMotion.fast,
      curve: AfkMotion.standard,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: InkWell(
          onTap: widget.onTap,
          enableFeedback: widget.enableFeedback,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          onHighlightChanged: enabled
              ? (value) => setState(() => _pressed = value)
              : null,
          child: widget.child,
        ),
      ),
    );
  }
}
