import 'package:flutter/material.dart';

import '../theme/afk_motion.dart';
import '../theme/afk_radius.dart';
import '../theme/afk_spacing.dart';

/// A compact, controlled single-selection control for a small set of options.
class AfkSegmentedOption<T> {
  const AfkSegmentedOption({required this.value, required this.label});

  final T value;
  final String label;
}

/// A restrained segmented selector with an animated selected surface.
class AfkSegmentedControl<T> extends StatelessWidget {
  const AfkSegmentedControl({
    required this.options,
    required this.value,
    required this.onChanged,
    super.key,
  }) : assert(options.length >= 2);

  final List<AfkSegmentedOption<T>> options;
  final T value;
  final ValueChanged<T>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Semantics(
      container: true,
      explicitChildNodes: true,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: colors.surfaceContainerHighest.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(AfkRadius.md),
        ),
        child: Row(
          children: [
            for (final option in options)
              Expanded(
                child: _Segment<T>(
                  option: option,
                  selected: option.value == value,
                  enabled: onChanged != null,
                  onTap:
                      onChanged == null ? null : () => onChanged!(option.value),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Segment<T> extends StatelessWidget {
  const _Segment({
    required this.option,
    required this.selected,
    required this.enabled,
    required this.onTap,
  });

  final AfkSegmentedOption<T> option;
  final bool selected;
  final bool enabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    return Semantics(
      button: true,
      selected: selected,
      enabled: enabled,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: AnimatedContainer(
          duration: reduceMotion ? Duration.zero : AfkMotion.fast,
          curve: AfkMotion.standard,
          decoration: BoxDecoration(
            color: selected ? colors.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(AfkRadius.sm),
            boxShadow:
                selected
                    ? [
                      BoxShadow(
                        color: colors.shadow.withValues(alpha: 0.06),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ]
                    : null,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(AfkRadius.sm),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 44),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AfkSpacing.xs,
                      vertical: AfkSpacing.sm,
                    ),
                    child: Text(
                      option.label,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color:
                            selected
                                ? colors.onSurface
                                : colors.onSurfaceVariant,
                        fontWeight:
                            selected ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
