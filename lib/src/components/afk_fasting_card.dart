import 'package:flutter/material.dart';

import '../theme/afk_radius.dart';
import '../theme/afk_spacing.dart';

/// A controlled fasting-session summary.
///
/// The host app owns timer persistence, scheduling, reminders, and any health
/// guidance. This component only presents the supplied state and action.
class AfkFastingCard extends StatelessWidget {
  const AfkFastingCard({
    required this.title,
    required this.statusLabel,
    required this.durationLabel,
    required this.actionLabel,
    required this.onAction,
    this.isActive = false,
    this.icon = Icons.schedule_outlined,
    super.key,
  });

  final String title;
  final String statusLabel;
  final String durationLabel;
  final String actionLabel;
  final VoidCallback? onAction;
  final bool isActive;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(AfkSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AfkRadius.lg),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isActive\n                  ? colors.onSurface.withValues(alpha: 0.06)\n                  : colors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AfkRadius.md),
            ),
            alignment: Alignment.center,
            child: Icon(icon),
          ),
          const SizedBox(width: AfkSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.titleSmall),
                const SizedBox(height: AfkSpacing.xxs),
                Text(
                  statusLabel,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AfkSpacing.xxs),
                Text(
                  durationLabel,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AfkSpacing.xs),
          TextButton(
            onPressed: onAction,
            child: Text(actionLabel),
          ),
        ],
      ),
    );
  }
}
