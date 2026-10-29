import 'package:flutter/material.dart';

import '../theme/afk_spacing.dart';

/// A reusable meal diary row with a clear nutrition summary.
class AfkMealEntryTile extends StatelessWidget {
  const AfkMealEntryTile({
    required this.title,
    required this.calories,
    this.subtitle,
    this.leading,
    this.onTap,
    this.trailing,
    this.calorieUnit = 'kcal',
    super.key,
  });

  final String title;
  final int calories;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final String calorieUnit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: AfkSpacing.sm),
      minLeadingWidth: 44,
      leading: leading == null
          ? null
          : SizedBox(
              width: 44,
              height: 44,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Center(child: leading),
              ),
            ),
      title: Text(title, maxLines: 2, overflow: TextOverflow.ellipsis),
      subtitle: subtitle == null
          ? null
          : Padding(
              padding: const EdgeInsets.only(top: AfkSpacing.xxs),
              child: Text(
                subtitle!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
      trailing: trailing ??
          Padding(
            padding: const EdgeInsets.only(left: AfkSpacing.xs),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  calories.toString(),
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
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
          ),
    );
  }
}
