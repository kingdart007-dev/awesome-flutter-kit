import 'package:flutter/material.dart';

import '../theme/afk_radius.dart';
import '../theme/afk_spacing.dart';

/// A compact, photo-first nutrition summary for a daily calorie dashboard.
///
/// The component only presents values supplied by the host app. It does not
/// calculate nutrition, infer food, or persist diary entries.
class AfkNutritionHero extends StatelessWidget {
  const AfkNutritionHero({
    required this.title,
    required this.consumed,
    required this.goal,
    required this.consumedLabel,
    required this.goalLabel,
    required this.remainingLabel,
    required this.addFoodLabel,
    required this.onAddFood,
    this.breakdownLabel,
    this.onViewBreakdown,
    this.addFoodIcon = Icons.camera_alt_outlined,
    super.key,
  }) : assert(consumed >= 0),
       assert(goal > 0);

  final String title;
  final double consumed;
  final double goal;
  final String consumedLabel;
  final String goalLabel;
  final String remainingLabel;
  final String addFoodLabel;
  final VoidCallback? onAddFood;
  final String? breakdownLabel;
  final VoidCallback? onViewBreakdown;
  final IconData addFoodIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final remaining = (goal - consumed).round();
    final progress = (consumed / goal).clamp(0.0, 1.0);
    final isOverGoal = consumed > goal;

    return Semantics(
      container: true,
      label: title,
      value: '${consumed.round()} $consumedLabel, ${goal.round()} $goalLabel',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AfkSpacing.lg),
        decoration: BoxDecoration(
          color: colors.surfaceContainerHighest.withValues(alpha: 0.58),
          borderRadius: BorderRadius.circular(AfkRadius.xl),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(title, style: theme.textTheme.titleMedium),
                ),
                Icon(
                  Icons.auto_awesome_outlined,
                  size: 18,
                  color: colors.onSurfaceVariant,
                ),
              ],
            ),
            const SizedBox(height: AfkSpacing.lg),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        consumed.round().toString(),
                        style: theme.textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          height: 1,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
                      const SizedBox(height: AfkSpacing.xxs),
                      Text(
                        consumedLabel,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AfkSpacing.md),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      isOverGoal
                          ? '+${remaining.abs()}'
                          : '${remaining.clamp(0, goal.round())}',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                    const SizedBox(height: AfkSpacing.xxs),
                    Text(
                      isOverGoal ? 'over $goalLabel' : remainingLabel,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AfkSpacing.lg),
            ClipRRect(
              borderRadius: BorderRadius.circular(AfkRadius.pill),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 7,
                color: colors.onSurface,
                backgroundColor: colors.surface,
              ),
            ),
            const SizedBox(height: AfkSpacing.sm),
            Text(
              '${goal.round()} $goalLabel',
              style: theme.textTheme.labelMedium?.copyWith(
                color: colors.onSurfaceVariant,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
            const SizedBox(height: AfkSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: onAddFood,
                    icon: Icon(addFoodIcon),
                    label: Text(addFoodLabel),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(0, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AfkRadius.md),
                      ),
                    ),
                  ),
                ),
                if (breakdownLabel != null) ...[
                  const SizedBox(width: AfkSpacing.sm),
                  IconButton(
                    tooltip: breakdownLabel,
                    onPressed: onViewBreakdown,
                    icon: const Icon(Icons.tune_rounded),
                    style: IconButton.styleFrom(
                      minimumSize: const Size(48, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AfkRadius.md),
                        side: BorderSide(color: colors.outlineVariant),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
