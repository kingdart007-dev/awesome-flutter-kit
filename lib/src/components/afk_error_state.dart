import 'package:flutter/material.dart';

import '../theme/afk_spacing.dart';

/// A calm, actionable error message with an optional retry action.
class AfkErrorState extends StatelessWidget {
  const AfkErrorState({
    required this.title,
    required this.description,
    this.retryLabel,
    this.onRetry,
    super.key,
  });

  final String title;
  final String description;
  final String? retryLabel;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AfkSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 32,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: AfkSpacing.md),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: AfkSpacing.xs),
            Text(
              description,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            if (onRetry != null && retryLabel != null) ...[
              const SizedBox(height: AfkSpacing.lg),
              FilledButton.tonal(
                onPressed: onRetry,
                child: Text(retryLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
