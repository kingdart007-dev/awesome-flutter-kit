import 'package:flutter/material.dart';

import '../theme/afk_radius.dart';
import '../theme/afk_spacing.dart';

/// A prominent entry point for a host app's food-photo scanning flow.
///
/// This is intentionally UI-only: camera permissions, image capture, upload,
/// and food recognition are responsibilities of the consuming application.
class AfkFoodScanCard extends StatelessWidget {
  const AfkFoodScanCard({
    required this.title,
    required this.description,
    required this.actionLabel,
    required this.onTap,
    this.icon = Icons.camera_alt_outlined,
    super.key,
  });

  final String title;
  final String description;
  final String actionLabel;
  final VoidCallback? onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Semantics(
      button: true,
      enabled: onTap != null,
      label: title,
      hint: description,
      child: Material(
        color: colors.surfaceContainerHighest.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(AfkRadius.xl),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AfkSpacing.lg),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(AfkRadius.lg),
                  ),
                  alignment: Alignment.center,
                  child: Icon(icon, size: 26),
                ),
                const SizedBox(width: AfkSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: theme.textTheme.titleMedium),
                      const SizedBox(height: AfkSpacing.xxs),
                      Text(
                        description,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: AfkSpacing.sm),
                      Text(
                        actionLabel,
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AfkSpacing.sm),
                const Icon(Icons.arrow_forward_rounded),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
