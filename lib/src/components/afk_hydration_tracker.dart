import 'package:flutter/material.dart';

import '../theme/afk_spacing.dart';

/// A compact water-intake summary with a controlled quick-add action.
class AfkHydrationTracker extends StatelessWidget {
  const AfkHydrationTracker({
    required this.currentMl,
    required this.goalMl,
    required this.title,
    required this.amountLabel,
    required this.addTooltip,
    required this.onAdd,
    this.addAmountMl = 250,
    this.unitLabel = 'ml',
    super.key,
  }) : assert(currentMl >= 0),
       assert(goalMl > 0),
       assert(addAmountMl > 0);

  final int currentMl;
  final int goalMl;
  final String title;
  final String amountLabel;
  final String addTooltip;
  final ValueChanged<int>? onAdd;
  final int addAmountMl;
  final String unitLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final progress = (currentMl / goalMl).clamp(0.0, 1.0);

    return Semantics(
      label: title,
      value: '$currentMl / $goalMl $unitLabel',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(Icons.water_drop_outlined, color: colors.onSurfaceVariant),
              const SizedBox(width: AfkSpacing.sm),
              Expanded(
                child: Text(title, style: theme.textTheme.titleMedium),
              ),
              Text(
                '$currentMl / $goalMl $unitLabel',
                style: theme.textTheme.labelMedium?.copyWith(
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
              const SizedBox(width: AfkSpacing.xs),
              IconButton(
                tooltip: addTooltip,
                onPressed: onAdd == null
                    ? null
                    : () => onAdd!(addAmountMl),
                constraints: const BoxConstraints(
                  minWidth: 48,
                  minHeight: 48,
                ),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: AfkSpacing.xs),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              color: colors.onSurface,
              backgroundColor: colors.surfaceContainerHighest,
            ),
          ),
          const SizedBox(height: AfkSpacing.xs),
          Text(
            amountLabel,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
