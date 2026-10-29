import 'package:flutter/material.dart';

import '../theme/afk_radius.dart';
import '../theme/afk_spacing.dart';

/// A compact, theme-aware selectable chip.
class AfkChoiceChip extends StatelessWidget {
  const AfkChoiceChip({
    required this.label,
    required this.selected,
    required this.onSelected,
    this.leading,
    super.key,
  });

  final String label;
  final bool selected;
  final ValueChanged<bool>? onSelected;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      selected: selected,
      enabled: onSelected != null,
      child: Material(
        color: selected ? colors.primary : colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AfkRadius.pill),
          side: BorderSide(
            color: selected ? colors.primary : colors.outlineVariant,
          ),
        ),
        child: InkWell(
          onTap: onSelected == null ? null : () => onSelected!(!selected),
          borderRadius: BorderRadius.circular(AfkRadius.pill),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 40),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AfkSpacing.md,
                vertical: AfkSpacing.xs,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (leading != null) ...[
                    IconTheme(
                      data: IconThemeData(
                        size: 18,
                        color: selected ? colors.onPrimary : colors.onSurface,
                      ),
                      child: leading!,
                    ),
                    const SizedBox(width: AfkSpacing.xs),
                  ],
                  Text(
                    label,
                    style: TextStyle(
                      color: selected ? colors.onPrimary : colors.onSurface,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
