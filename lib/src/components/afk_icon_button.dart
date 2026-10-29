import 'package:flutter/material.dart';

import '../theme/afk_radius.dart';

/// Shape treatment for [AfkIconButton].
enum AfkIconButtonVariant { plain, filled, outlined }

/// An icon button with a required tooltip and a predictable touch target.
class AfkIconButton extends StatelessWidget {
  const AfkIconButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.variant = AfkIconButtonVariant.plain,
    this.iconSize = 22,
    super.key,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final AfkIconButtonVariant variant;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AfkRadius.md),
      side: variant == AfkIconButtonVariant.outlined
          ? BorderSide(color: scheme.outline)
          : BorderSide.none,
    );
    final background = switch (variant) {
      AfkIconButtonVariant.plain => Colors.transparent,
      AfkIconButtonVariant.filled => scheme.primary,
      AfkIconButtonVariant.outlined => Colors.transparent,
    };
    final foreground = variant == AfkIconButtonVariant.filled
        ? scheme.onPrimary
        : scheme.onSurface;

    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      icon: Icon(icon, size: iconSize),
      color: foreground,
      style: IconButton.styleFrom(
        backgroundColor: background,
        minimumSize: const Size(48, 48),
        shape: shape,
      ),
    );
  }
}
