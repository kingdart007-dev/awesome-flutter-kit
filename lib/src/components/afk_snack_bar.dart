import 'package:flutter/material.dart';

import '../theme/afk_radius.dart';
import '../theme/afk_spacing.dart';

/// Semantic tone for a brief snackbar message.
enum AfkSnackBarVariant { neutral, success, warning, error }

/// Shows a consistent floating snackbar through the nearest ScaffoldMessenger.
abstract final class AfkSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    AfkSnackBarVariant variant = AfkSnackBarVariant.neutral,
    Duration duration = const Duration(seconds: 4),
  }) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final (icon, foreground, background) = switch (variant) {
      AfkSnackBarVariant.neutral => (
        Icons.info_outline,
        colors.onSurface,
        colors.surfaceContainerHighest,
      ),
      AfkSnackBarVariant.success => (
        Icons.check_circle_outline,
        theme.brightness == Brightness.dark
            ? const Color(0xFF9ADCB3)
            : const Color(0xFF216E45),
        theme.brightness == Brightness.dark
            ? const Color(0xFF1C3929)
            : const Color(0xFFEAF5EE),
      ),
      AfkSnackBarVariant.warning => (
        Icons.warning_amber_rounded,
        theme.brightness == Brightness.dark
            ? const Color(0xFFFFD08A)
            : const Color(0xFF805000),
        theme.brightness == Brightness.dark
            ? const Color(0xFF3B2D16)
            : const Color(0xFFFFF4DE),
      ),
      AfkSnackBarVariant.error => (
        Icons.error_outline,
        colors.onErrorContainer,
        colors.errorContainer,
      ),
    };

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: duration,
          behavior: SnackBarBehavior.floating,
          backgroundColor: background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AfkRadius.md),
          ),
          content: Row(
            children: [
              Icon(icon, color: foreground, size: 20),
              const SizedBox(width: AfkSpacing.sm),
              Expanded(
                child: Text(message, style: TextStyle(color: foreground)),
              ),
            ],
          ),
        ),
      );
  }
}
