import 'package:flutter/material.dart';

import '../theme/afk_radius.dart';
import '../theme/afk_spacing.dart';

/// Visual treatment for [AfkBadge].
enum AfkBadgeVariant { subtle, outlined, filled }

/// A compact label for status, category, or small metadata.
class AfkBadge extends StatelessWidget {
  const AfkBadge({
    required this.label,
    this.variant = AfkBadgeVariant.subtle,
    this.icon,
    super.key,
  });

  final String label;
  final AfkBadgeVariant variant;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final background = variant == AfkBadgeVariant.subtle
        ? scheme.onSurface.withValues(alpha: 0.06)
        : variant == AfkBadgeVariant.filled
        ? scheme.primary
        : Colors.transparent;
    final foreground = variant == AfkBadgeVariant.filled
        ? scheme.onPrimary
        : scheme.onSurface;
    final border = variant == AfkBadgeVariant.outlined
        ? Border.all(color: scheme.outline)
        : null;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AfkSpacing.sm,
        vertical: AfkSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: background,
        border: border,
        borderRadius: BorderRadius.circular(AfkRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: foreground),
            const SizedBox(width: AfkSpacing.xs),
          ],
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: foreground,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
