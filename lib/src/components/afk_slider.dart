import 'package:flutter/material.dart';

import '../theme/afk_spacing.dart';

/// A labelled, controlled slider with optional divisions and value display.
class AfkSlider extends StatelessWidget {
  const AfkSlider({
    required this.value,
    required this.onChanged,
    required this.min,
    required this.max,
    this.label,
    this.divisions,
    this.showValue = false,
    super.key,
  }) : assert(max > min),
       assert(value >= min && value <= max),
       assert(divisions == null || divisions > 0);

  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final String? label;
  final int? divisions;
  final bool showValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final slider = Slider(
      value: value,
      onChanged: onChanged,
      min: min,
      max: max,
      divisions: divisions,
      label: label == null ? null : '$label: ${value.round()}',
    );
    if (label == null && !showValue) return slider;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (label != null || showValue)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AfkSpacing.xs),
            child: Row(
              children: [
                if (label != null)
                  Expanded(
                    child: Text(label!, style: theme.textTheme.bodyMedium),
                  ),
                if (showValue)
                  Text(
                    value.toStringAsFixed(
                      value.truncateToDouble() == value ? 0 : 1,
                    ),
                    style: theme.textTheme.labelLarge,
                  ),
              ],
            ),
          ),
        slider,
      ],
    );
  }
}
