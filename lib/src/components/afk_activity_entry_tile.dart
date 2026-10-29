import 'package:flutter/material.dart';

import '../theme/afk_spacing.dart';

/// A compact activity diary row for workouts and movement sessions.
class AfkActivityEntryTile extends StatelessWidget {
  const AfkActivityEntryTile({
    required this.title,
    required this.durationLabel,
    required this.burnedCalories,
    required this.calorieUnit,
    this.subtitle,
    this.leading,
    this.onTap,
    super.key,
  });

  final String title;
  final String durationLabel;
  final int burnedCalories;
  final String calorieUnit;
  final String? subtitle;
  final Widget? leading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: AfkSpacing.sm),
      leading: leading ?? const Icon(Icons.directions_run_outlined),
      title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        subtitle == null ? durationLabel : '$subtitle · $durationLabel',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            burnedCalories.toString(),
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
        ],
      ),
    );
  }
}
