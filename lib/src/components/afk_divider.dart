import 'package:flutter/material.dart';

import '../theme/afk_spacing.dart';

/// A subtle divider with consistent spacing around it.
class AfkDivider extends StatelessWidget {
  const AfkDivider({
    this.indent = 0,
    this.endIndent = 0,
    this.spacing = AfkSpacing.md,
    super.key,
  });

  final double indent;
  final double endIndent;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spacing),
      child: Divider(
        indent: indent,
        endIndent: endIndent,
        height: 1,
        thickness: 1,
        color: Theme.of(context).dividerColor,
      ),
    );
  }
}
