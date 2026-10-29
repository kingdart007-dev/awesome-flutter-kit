import 'package:flutter/material.dart';

import '../theme/afk_colors.dart';
import '../theme/afk_radius.dart';
import '../theme/afk_spacing.dart';

/// A compact inline message for success, information, or caution.
enum AfkStatusVariant { success, info, warning }

class AfkStatusMessage extends StatelessWidget {
  const AfkStatusMessage({
    required this.message,
    required this.variant,
    this.icon,
    super.key,
  });

  final String message;
  final AfkStatusVariant variant;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final (foreground, background, defaultIcon) = switch (variant) {
      AfkStatusVariant.success => (
        isDark
            ? AfkColors.successForegroundDark
            : AfkColors.successForegroundLight,
        isDark
            ? AfkColors.successContainerDark
            : AfkColors.successContainerLight,
        Icons.check_circle_outline,
      ),
      AfkStatusVariant.info => (
        colors.onSurfaceVariant,
        colors.onSurface.withValues(alpha: 0.05),
        Icons.info_outline,
      ),
      AfkStatusVariant.warning => (
        isDark
            ? AfkColors.warningForegroundDark
            : AfkColors.warningForegroundLight,
        isDark
            ? AfkColors.warningContainerDark
            : AfkColors.warningContainerLight,
        Icons.warning_amber_rounded,
      ),
    };
    return Semantics(
      liveRegion: true,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AfkSpacing.md),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(AfkRadius.md),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon ?? defaultIcon, size: 20, color: foreground),
            const SizedBox(width: AfkSpacing.sm),
            Expanded(
              child: Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(color: foreground),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
