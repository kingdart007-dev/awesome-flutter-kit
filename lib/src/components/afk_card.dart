import 'package:flutter/material.dart';

import '../theme/afk_radius.dart';
import '../theme/afk_spacing.dart';

/// A quiet, bordered surface for grouping related content.
class AfkCard extends StatelessWidget {
  const AfkCard({
    required this.child,
    this.padding = const EdgeInsets.all(AfkSpacing.md),
    this.onTap,
    this.color,
    this.borderRadius = AfkRadius.lg,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Color? color;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      side: BorderSide(color: theme.dividerColor),
    );

    return Material(
      color: color ?? theme.colorScheme.surface,
      shape: shape,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        customBorder: shape,
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
