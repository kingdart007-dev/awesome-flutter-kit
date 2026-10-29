import 'package:flutter/material.dart';

import '../theme/afk_radius.dart';
import '../theme/afk_spacing.dart';

/// An editable food-recognition result row for a host-owned analysis flow.
///
/// Calories and portion text are estimates; this widget does not perform
/// recognition or imply a level of confidence that the host has not supplied.
class AfkFoodEstimateTile extends StatelessWidget {
  const AfkFoodEstimateTile({
    required this.title,
    required this.portionLabel,
    required this.calories,
    required this.calorieUnit,
    required this.editLabel,
    required this.onEdit,
    this.leading,
    this.subtitle,
    super.key,
  });

  final String title;
  final String portionLabel;
  final int calories;
  final String calorieUnit;
  final String editLabel;
  final VoidCallback? onEdit;
  final Widget? leading;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Row(
      children: [
        Container(
          width: 52,
          height: 52,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colors.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(AfkRadius.md),
          ),
          clipBehavior: Clip.antiAlias,
          child: leading ?? const Icon(Icons.restaurant_outlined),
        ),
        const SizedBox(width: AfkSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: theme.textTheme.titleSmall),
              const SizedBox(height: AfkSpacing.xxs),
              Text(
                subtitle ?? portionLabel,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: AfkSpacing.xxs),
                Text(
                  portionLabel,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(width: AfkSpacing.sm),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              calories.toString(),
              style: theme.textTheme.titleSmall?.copyWith(
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
            Text(
              calorieUnit,
              style: theme.textTheme.labelSmall?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
            TextButton(
              onPressed: onEdit,
              style: TextButton.styleFrom(
                minimumSize: const Size(48, 36),
                padding: const EdgeInsets.symmetric(horizontal: AfkSpacing.xs),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(editLabel),
            ),
          ],
        ),
      ],
    );
  }
}
