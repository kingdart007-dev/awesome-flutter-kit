import 'package:flutter/material.dart';

import '../theme/afk_motion.dart';
import '../theme/afk_spacing.dart';

/// An accessible, theme-aware disclosure section for secondary content.
///
/// The section owns only its expanded/collapsed presentation. The host app
/// remains responsible for the content, persistence, and localized labels.
class AfkExpandableSection extends StatefulWidget {
  const AfkExpandableSection({
    required this.title,
    required this.child,
    this.initiallyExpanded = false,
    this.leading,
    this.expandTooltip,
    this.collapseTooltip,
    this.onExpansionChanged,
    super.key,
  });

  final Widget title;
  final Widget child;
  final bool initiallyExpanded;
  final Widget? leading;
  final String? expandTooltip;
  final String? collapseTooltip;
  final ValueChanged<bool>? onExpansionChanged;

  @override
  State<AfkExpandableSection> createState() => _AfkExpandableSectionState();
}

class _AfkExpandableSectionState extends State<AfkExpandableSection> {
  late bool _expanded = widget.initiallyExpanded;

  @override
  void didUpdateWidget(covariant AfkExpandableSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initiallyExpanded != widget.initiallyExpanded) {
      _expanded = widget.initiallyExpanded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    final duration = reduceMotion ? Duration.zero : AfkMotion.normal;
    final tooltip = _expanded
        ? widget.collapseTooltip
        : widget.expandTooltip;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(
          button: true,
          expanded: _expanded,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                final next = !_expanded;
                setState(() => _expanded = next);
                widget.onExpansionChanged?.call(next);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AfkSpacing.sm,
                  horizontal: AfkSpacing.xs,
                ),
                child: Row(
                  children: [
                    if (widget.leading != null) ...[
                      widget.leading!,
                      const SizedBox(width: AfkSpacing.sm),
                    ],
                    Expanded(child: widget.title),
                    const SizedBox(width: AfkSpacing.sm),
                    AnimatedRotation(
                      turns: _expanded ? 0.5 : 0,
                      duration: duration,
                      curve: AfkMotion.standard,
                      child: tooltip == null
                          ? Icon(
                              Icons.expand_more,
                              color: theme.colorScheme.onSurfaceVariant,
                            )
                          : Tooltip(
                              message: tooltip,
                              child: Icon(
                                Icons.expand_more,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        AnimatedSize(
          duration: duration,
          curve: AfkMotion.standard,
          alignment: Alignment.topCenter,
          child: _expanded
              ? Padding(
                  padding: const EdgeInsets.only(
                    top: AfkSpacing.xs,
                    bottom: AfkSpacing.md,
                  ),
                  child: widget.child,
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
