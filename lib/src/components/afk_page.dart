import 'package:flutter/material.dart';

import '../theme/afk_spacing.dart';

/// A responsive page layout with consistent padding and a readable content width.
class AfkPage extends StatelessWidget {
  const AfkPage({
    required this.child,
    this.padding = const EdgeInsets.all(AfkSpacing.lg),
    this.maxWidth = 640,
    this.safeArea = true,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double? maxWidth;
  final bool safeArea;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: padding,
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
          child: child,
        ),
      ),
    );

    return safeArea ? SafeArea(child: content) : content;
  }
}
