import 'package:flutter/material.dart';

import '../theme/afk_radius.dart';
import '../theme/afk_spacing.dart';

/// A compact calorie-budget ring for nutrition dashboards.
///
/// Values are estimates supplied by the host app. All labels are required so
/// the component can be localized without embedding product copy.
class AfkCalorieRing extends StatelessWidget {
  const AfkCalorieRing({
    required this.consumed,
    required this.goal,
    required this.centerLabel,
    required this.footerLabel,
    this.size = 184,
    this.strokeWidth = 12,
    this.remaining,
    super.key,
  }) : assert(consumed >= 0),
       assert(goal > 0),
       assert(size > 0),
       assert(strokeWidth > 0);

  final double consumed;
  final double goal;
  final String centerLabel;
  final String footerLabel;
  final double size;
  final double strokeWidth;
  final double? remaining;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final progress = (consumed / goal).clamp(0.0, 1.0);
    final remainingValue =
        remaining ?? (goal - consumed).clamp(0.0, double.infinity);

    return Semantics(
      label: centerLabel,
      value: '${consumed.round()} / ${goal.round()}',
      child: ExcludeSemantics(
        child: SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox.expand(
                child: CircularProgressIndicator(
                  value: 1,
                  strokeWidth: strokeWidth,
                  color: colors.surfaceContainerHighest,
                  strokeCap: StrokeCap.round,
                ),
              ),
              SizedBox.expand(
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: strokeWidth,
                  backgroundColor: Colors.transparent,
                  color: colors.onSurface,
                  strokeCap: StrokeCap.round,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AfkSpacing.md),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      consumed.round().toString(),
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        height: 1.05,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                    const SizedBox(height: AfkSpacing.xxs),
                    Text(
                      centerLabel,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AfkSpacing.sm),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AfkSpacing.sm,
                        vertical: AfkSpacing.xxs,
                      ),
                      decoration: BoxDecoration(
                        color: colors.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(AfkRadius.pill),
                      ),
                      child: Text(
                        '${remainingValue.round()} $footerLabel',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.labelMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
