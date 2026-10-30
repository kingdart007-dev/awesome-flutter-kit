import 'package:flutter/material.dart';

import '../theme/afk_radius.dart';
import '../theme/afk_spacing.dart';

/// A controlled numeric stepper with accessible increment/decrement actions.
///
/// The host app supplies localized labels and owns the value. Buttons disable
/// at the bounds, and the control never changes its value independently.
class AfkStepper extends StatelessWidget {
  const AfkStepper({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    required this.decreaseTooltip,
    required this.increaseTooltip,
    this.step = 1,
    this.valueLabelBuilder,
    super.key,
  }) : assert(max >= min),
       assert(value >= min && value <= max),
       assert(step > 0);

  final String label;
  final int value;
  final int min;
  final int max;
  final ValueChanged<int>? onChanged;
  final String decreaseTooltip;
  final String increaseTooltip;
  final int step;
  final String Function(int value)? valueLabelBuilder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final canDecrease = onChanged != null && value > min;
    final canIncrease = onChanged != null && value < max;
    final displayValue = valueLabelBuilder?.call(value) ?? '$value';

    return Row(
      children: [
        Expanded(child: Text(label, style: theme.textTheme.bodyLarge)),
        IconButton(
          tooltip: decreaseTooltip,
          onPressed:
              canDecrease
                  ? () => onChanged!((value - step).clamp(min, max).toInt())
                  : null,
          constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AfkRadius.md),
            ),
          ),
          icon: const Icon(Icons.remove),
        ),
        const SizedBox(width: AfkSpacing.xs),
        SizedBox(
          width: 44,
          child: Semantics(
            label: label,
            value: displayValue,
            liveRegion: true,
            child: ExcludeSemantics(
              child: Text(
                displayValue,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium,
              ),
            ),
          ),
        ),
        const SizedBox(width: AfkSpacing.xs),
        IconButton(
          tooltip: increaseTooltip,
          onPressed:
              canIncrease
                  ? () => onChanged!((value + step).clamp(min, max).toInt())
                  : null,
          constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AfkRadius.md),
            ),
          ),
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
