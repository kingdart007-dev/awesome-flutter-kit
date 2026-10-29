import 'package:flutter/material.dart';

import '../theme/afk_spacing.dart';

/// A theme-aware linear progress indicator for determinate or ongoing work.
class AfkProgressBar extends StatelessWidget {
  const AfkProgressBar({
    this.value,
    this.label,
    this.showValue = false,
    this.minHeight = 4,
    super.key,
  }) : assert(value == null || (value >= 0 && value <= 1)),
       assert(minHeight > 0);

  /// A value from 0 to 1, or null for indeterminate progress.
  final double? value;
  final String? label;
  final bool showValue;
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final percent = value == null ? null : (value! * 100).round();
    final indicator = Semantics(
      label: label,
      value: percent == null ? null : '$percent%',
      child: LinearProgressIndicator(
        value: value,
        minHeight: minHeight,
        borderRadius: BorderRadius.circular(minHeight),
      ),
    );

    if (label == null && !showValue) return indicator;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (label != null || showValue)
          Padding(
            padding: const EdgeInsets.only(bottom: AfkSpacing.sm),
            child: Row(
              children: [
                if (label != null)
                  Expanded(
                    child: Text(label!, style: theme.textTheme.bodyMedium),
                  ),
                if (showValue && percent != null)
                  Text('$percent%', style: theme.textTheme.labelLarge),
              ],
            ),
          ),
        indicator,
      ],
    );
  }
}
