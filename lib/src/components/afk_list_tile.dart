import 'package:flutter/material.dart';

import '../theme/afk_spacing.dart';

/// A compact list row with optional leading, trailing, and supporting text.
///
/// When [onTap] is null the row is rendered as non-interactive content.
class AfkListTile extends StatelessWidget {
  const AfkListTile({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.enabled = true,
    this.dense = false,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: AfkSpacing.md,
      vertical: AfkSpacing.sm,
    ),
    super.key,
  });

  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool enabled;
  final bool dense;
  final EdgeInsetsGeometry contentPadding;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: trailing,
      onTap: enabled ? onTap : null,
      enabled: enabled,
      dense: dense,
      contentPadding: contentPadding,
      minLeadingWidth: AfkSpacing.xl,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
