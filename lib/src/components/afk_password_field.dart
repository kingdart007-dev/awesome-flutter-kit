import 'package:flutter/material.dart';

import '../theme/afk_radius.dart';
import '../theme/afk_spacing.dart';

/// A theme-aware password input with an accessible visibility toggle.
///
/// Supply localized [showPasswordLabel] and [hidePasswordLabel] values so the
/// toggle remains understandable to screen-reader and tooltip users.
class AfkPasswordField extends StatefulWidget {
  const AfkPasswordField({
    required this.label,
    required this.showPasswordLabel,
    required this.hidePasswordLabel,
    this.controller,
    this.initialValue,
    this.hintText,
    this.helperText,
    this.errorText,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction = TextInputAction.done,
    this.enabled = true,
    this.autofocus = false,
    super.key,
  }) : assert(initialValue == null || controller == null);

  final String label;
  final String showPasswordLabel;
  final String hidePasswordLabel;
  final TextEditingController? controller;
  final String? initialValue;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction textInputAction;
  final bool enabled;
  final bool autofocus;

  @override
  State<AfkPasswordField> createState() => _AfkPasswordFieldState();
}

class _AfkPasswordFieldState extends State<AfkPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AfkRadius.md),
      borderSide: BorderSide(color: colors.outlineVariant),
    );

    return TextFormField(
      controller: widget.controller,
      initialValue: widget.initialValue,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      textInputAction: widget.textInputAction,
      obscureText: _obscureText,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
      autocorrect: false,
      enableSuggestions: false,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hintText,
        helperText: widget.helperText,
        errorText: widget.errorText,
        suffixIcon: IconButton(
          tooltip: _obscureText
              ? widget.showPasswordLabel
              : widget.hidePasswordLabel,
          onPressed: widget.enabled
              ? () => setState(() => _obscureText = !_obscureText)
              : null,
          icon: Icon(
            _obscureText
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
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
        errorBorder: border.copyWith(
          borderSide: BorderSide(color: colors.error),
        ),
        focusedErrorBorder: border.copyWith(
          borderSide: BorderSide(color: colors.error, width: 1.5),
        ),
        disabledBorder: border,
      ),
    );
  }
}
