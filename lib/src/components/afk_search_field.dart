import 'package:flutter/material.dart';

import '../theme/afk_radius.dart';
import '../theme/afk_spacing.dart';

/// A compact search field with a controller-aware clear action.
class AfkSearchField extends StatelessWidget {
  const AfkSearchField({
    required this.controller,
    required this.onChanged,
    required this.hintText,
    required this.clearTooltip,
    this.enabled = true,
    this.onSubmitted,
    this.autofocus = false,
    super.key,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hintText;
  final String clearTooltip;
  final bool enabled;
  final ValueChanged<String>? onSubmitted;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AfkRadius.md),
      borderSide: BorderSide(color: colors.outlineVariant),
    );

    return TextField(
      controller: controller,
      enabled: enabled,
      autofocus: autofocus,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (context, value, child) {
            if (value.text.isEmpty || !enabled) return const SizedBox.shrink();
            return IconButton(
              tooltip: clearTooltip,
              onPressed: () {
                controller.clear();
                onChanged('');
              },
              icon: const Icon(Icons.close),
            );
          },
        ),
        filled: true,
        fillColor: colors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AfkSpacing.md,
          vertical: AfkSpacing.md,
        ),
        border: border,
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: BorderSide(color: colors.primary, width: 1.5),
        ),
        disabledBorder: border,
      ),
    );
  }
}
