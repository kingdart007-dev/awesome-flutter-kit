import 'package:flutter/material.dart';

import '../theme/afk_radius.dart';
import '../theme/afk_spacing.dart';

/// A controlled horizontal selector for a short row of days or dates.
///
/// The host supplies stable values and localized labels; this widget does not
/// assume a week start, calendar locale, or date arithmetic policy.
class AfkDateOption {
  const AfkDateOption({
    required this.value,
    required this.label,
    this.caption,
  });

  final String value;
  final String label;
  final String? caption;
}

/// Compact date selection for diaries, progress summaries, and trackers.
class AfkDateSelector extends StatelessWidget {
  const AfkDateSelector({
    required this.options,
    required this.value,
    required this.onChanged,
    this.scrollable = true,
    super.key,
  }) : assert(options.length > 0);

  final List<AfkDateOption> options;
  final String value;
  final ValueChanged<String>? onChanged;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final items = [
      for (final option in options)
        Expanded(
          child: _AfkDateOptionButton(
            option: option,
            selected: option.value == value,
            enabled: onChanged != null,
            onTap: () => onChanged?.call(option.value),
          ),
        ),
    ];

    if (!scrollable) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: items,
      );
    }

    return SizedBox(
      height: 72,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: options.length,
        separatorBuilder: (_, __) => const SizedBox(width: AfkSpacing.xs),
        itemBuilder: (context, index) {
          final option = options[index];
          return SizedBox(
            width: 64,
            child: _AfkDateOptionButton(
              option: option,
              selected: option.value == value,
              enabled: onChanged != null,
              onTap: () => onChanged?.call(option.value),
            ),
          );
        },
      ),
    );
  }
}

class _AfkDateOptionButton extends StatelessWidget {
  const _AfkDateOptionButton({
    required this.option,
    required this.selected,
    required this.enabled,
    required this.onTap,
  });

  final AfkDateOption option;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final foreground = selected ? colors.onPrimary : colors.onSurface;
    return Semantics(
      button: true,
      selected: selected,
      enabled: enabled,
      label: option.caption == null
          ? option.label
          : '${option.label}, ${option.caption}',
      child: ExcludeSemantics(
        child: Material(
          color: selected ? colors.primary : colors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AfkRadius.md),
            side: BorderSide(
              color: selected ? colors.primary : colors.outlineVariant,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: enabled ? onTap : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AfkSpacing.xs,
                vertical: AfkSpacing.sm,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    option.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: foreground,
                      fontWeight: selected ? FontWeight.w700 : null,
                    ),
                  ),
                  if (option.caption != null) ...[
                    const SizedBox(height: AfkSpacing.xxs),
                    Text(
                      option.caption!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: foreground,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
