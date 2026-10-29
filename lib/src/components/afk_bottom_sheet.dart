import 'package:flutter/material.dart';

import '../theme/afk_radius.dart';
import '../theme/afk_spacing.dart';

/// Presents a consistently styled modal bottom sheet.
///
/// The builder owns its content and any state within it. Use a scrollable
/// child for content that may exceed the available height, especially when
/// [isScrollControlled] is true.
abstract final class AfkBottomSheet {
  static Future<T?> show<T>(
    BuildContext context, {
    required WidgetBuilder builder,
    bool isScrollControlled = true,
    bool useSafeArea = true,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
    double? elevation,
  }) {
    final theme = Theme.of(context);
    return showModalBottomSheet<T>(
      context: context,
      builder: builder,
      isScrollControlled: isScrollControlled,
      useSafeArea: useSafeArea,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor ?? theme.colorScheme.surface,
      elevation: elevation ?? 0,
      showDragHandle: enableDrag,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AfkRadius.xl),
        ),
      ),
      constraints: const BoxConstraints(maxWidth: 640),
    );
  }

  /// Adds predictable inner spacing to sheet content.
  static Widget content({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.all(AfkSpacing.lg),
      child: child,
    );
  }
}
