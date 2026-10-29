import 'package:flutter/material.dart';

import '../theme/afk_spacing.dart';

/// A centered progress indicator with optional explanatory copy.
class AfkLoadingIndicator extends StatelessWidget {
  const AfkLoadingIndicator({
    this.label,
    this.size = 24,
    super.key,
  });

  final String? label;
  final double size;

  @override
  Widget build(BuildContext context) {
    final indicator = SizedBox.square(
      dimension: size,
      child: const CircularProgressIndicator(strokeWidth: 2.4),
    );

    if (label == null) {
      return Center(child: indicator);
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          indicator,
          const SizedBox(height: AfkSpacing.md),
          Text(
            label!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
