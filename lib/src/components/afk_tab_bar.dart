import 'package:flutter/material.dart';

import '../theme/afk_radius.dart';
import '../theme/afk_spacing.dart';

/// A restrained, theme-aware tab bar for switching between related views.
///
/// Place this widget in an [AppBar.bottom] or above a [TabBarView]. The
/// controller and tab labels remain owned by the host application, so routing
/// and localization stay explicit.
class AfkTabBar extends StatelessWidget implements PreferredSizeWidget {
  const AfkTabBar({
    required this.tabs,
    this.controller,
    this.isScrollable = false,
    this.onTap,
    this.labelPadding = const EdgeInsets.symmetric(horizontal: AfkSpacing.md),
    super.key,
  });

  final List<Widget> tabs;
  final TabController? controller;
  final bool isScrollable;
  final ValueChanged<int>? onTap;
  final EdgeInsetsGeometry labelPadding;

  @override
  Size get preferredSize => const Size.fromHeight(48);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return TabBar(
      controller: controller,
      tabs: tabs,
      isScrollable: isScrollable,
      onTap: onTap,
      labelPadding: labelPadding,
      labelColor: colors.onSurface,
      unselectedLabelColor: colors.onSurfaceVariant,
      indicatorColor: colors.onSurface,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 2,
      dividerColor: colors.outlineVariant.withValues(alpha: 0.55),
      splashBorderRadius: BorderRadius.circular(AfkRadius.md),
      overlayColor: WidgetStatePropertyAll(
        colors.onSurface.withValues(alpha: 0.04),
      ),
    );
  }
}
