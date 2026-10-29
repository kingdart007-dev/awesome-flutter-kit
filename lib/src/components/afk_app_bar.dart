import 'package:flutter/material.dart';

/// A low-elevation app bar that follows the kit's quiet surface language.
class AfkAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AfkAppBar({
    required this.title,
    this.leading,
    this.actions,
    this.centerTitle,
    this.bottom,
    this.automaticallyImplyLeading = true,
    super.key,
  });

  final Widget title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool? centerTitle;
  final PreferredSizeWidget? bottom;
  final bool automaticallyImplyLeading;

  @override
  Size get preferredSize => Size.fromHeight(
    kToolbarHeight + (bottom?.preferredSize.height ?? 0),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      title: title,
      leading: leading,
      actions: actions,
      centerTitle: centerTitle,
      bottom: bottom,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: theme.colorScheme.surface,
      foregroundColor: theme.colorScheme.onSurface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleSpacing: 20,
    );
  }
}
