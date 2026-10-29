import 'package:flutter/material.dart';

import '../theme/afk_spacing.dart';

/// A compact, accessible nutrient progress row for nutrition summaries.
class AfkMacroProgress extends StatelessWidget {
  const AfkMacroProgress({
    required this.label,
    required this.value,
    required this.goal,
    required this.unit,
    this.showValues = true,
    super.key,
  }) : assert(value >= 0),
       assert(goal > 0);

  final String label;
  final double value;
  final double goal;
  final String unit;
  final bool showValues;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final progress = (value / goal).clamp(0.0, 1.0);
    final valueText = '${value.round()} / ${goal.round()} $unit';

    return Semantics(
      label: label,
      value: valueText,
      child: ExcludeSemantics(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(label, style: theme.textTheme.labelLarge),
                ),
                if (showValues)
                  Text(
                    valueText,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AfkSpacing.xs),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                color: colors.onSurface,
                backgroundColor: colors.surfaceContainerHighest,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
