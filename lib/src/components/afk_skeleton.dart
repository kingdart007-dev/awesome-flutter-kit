import 'package:flutter/material.dart';

import '../theme/afk_radius.dart';

/// A neutral placeholder for content that is temporarily loading.
class AfkSkeleton extends StatelessWidget {
  const AfkSkeleton({
    this.width,
    this.height = 16,
    this.borderRadius = AfkRadius.sm,
    super.key,
  }) : assert(height > 0),
       assert(width == null || width > 0);

  final double? width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return ExcludeSemantics(
      child: SizedBox(
        width: width,
        height: height,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colors.onSurface.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}
