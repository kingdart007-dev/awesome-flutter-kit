import 'package:flutter/material.dart';

import '../theme/afk_radius.dart';
import '../theme/afk_spacing.dart';

/// Visual style for [AfkButton].
enum AfkButtonVariant { filled, outlined, text }

/// A small button primitive with consistent sizing and disabled/loading states.
class AfkButton extends StatelessWidget {
  const AfkButton({
    required this.label,
    required this.onPressed,
    this.variant = AfkButtonVariant.filled,
    this.leading,
    this.isLoading = false,
    this.expand = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final AfkButtonVariant variant;
  final Widget? leading;
  final bool isLoading;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading)
          const SizedBox.square(
            dimension: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        else if (leading != null)
          leading!,
        if (isLoading || leading != null) const SizedBox(width: AfkSpacing.xs),
        Flexible(child: Text(label, textAlign: TextAlign.center)),
      ],
    );

    final enabled = onPressed != null && !isLoading;
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AfkRadius.md),
    );

    final Widget button;
    if (variant == AfkButtonVariant.filled) {
      button = FilledButton(
        onPressed: enabled ? onPressed : null,
        style: FilledButton.styleFrom(
          shape: shape,
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(
            horizontal: AfkSpacing.lg,
            vertical: AfkSpacing.md,
          ),
        ),
        child: child,
      );
    } else if (variant == AfkButtonVariant.outlined) {
      button = OutlinedButton(
        onPressed: enabled ? onPressed : null,
        style: OutlinedButton.styleFrom(
          shape: shape,
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(
            horizontal: AfkSpacing.lg,
            vertical: AfkSpacing.md,
          ),
        ),
        child: child,
      );
    } else {
      button = TextButton(
        onPressed: enabled ? onPressed : null,
        style: TextButton.styleFrom(
          shape: shape,
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(
            horizontal: AfkSpacing.md,
            vertical: AfkSpacing.md,
          ),
        ),
        child: child,
      );
    }

    return Semantics(
      button: true,
      enabled: enabled,
      liveRegion: isLoading,
      label: isLoading ? '$label, loading' : label,
      child: expand ? SizedBox(width: double.infinity, child: button) : button,
    );
  }
}
