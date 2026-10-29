import 'package:flutter/material.dart';

/// A compact checkbox row with a consistent layout and accessible tap target.
class AfkCheckboxTile extends StatelessWidget {
  const AfkCheckboxTile({
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
    this.enabled = true,
    super.key,
  });

  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: value,
      onChanged: enabled ? onChanged : null,
      title: Text(title),
      subtitle: subtitle == null ? null : Text(subtitle!),
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      dense: false,
      visualDensity: VisualDensity.standard,
      activeColor: Theme.of(context).colorScheme.primary,
    );
  }
}
