import 'package:flutter/material.dart';

import '../theme/afk_radius.dart';
import '../theme/afk_spacing.dart';

/// A consistent confirmation dialog with an optional destructive action.
abstract final class AfkConfirmDialog {
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmLabel,
    required String cancelLabel,
    bool destructive = false,
    bool barrierDismissible = true,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (dialogContext) {
        final colors = Theme.of(dialogContext).colorScheme;
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AfkRadius.xl),
          ),
          actionsPadding: const EdgeInsets.fromLTRB(
            AfkSpacing.md,
            0,
            AfkSpacing.md,
            AfkSpacing.md,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(cancelLabel),
            ),
            FilledButton(
              style:
                  destructive
                      ? FilledButton.styleFrom(
                        backgroundColor: colors.error,
                        foregroundColor: colors.onError,
                      )
                      : null,
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(confirmLabel),
            ),
          ],
        );
      },
    );
  }
}
