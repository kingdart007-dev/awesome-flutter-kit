import 'package:flutter/material.dart';

/// A consistent radio row for selecting one option from a group.
class AfkRadioTile<T> extends StatelessWidget {
  const AfkRadioTile({
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.subtitle,
    this.enabled = true,
    super.key,
  });

  final String title;
  final String? subtitle;
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return RadioListTile<T>(
      value: value,
      groupValue: groupValue,
      onChanged: enabled ? onChanged : null,
      title: Text(title),
      subtitle: subtitle == null ? null : Text(subtitle!),
      contentPadding: EdgeInsets.zero,
      dense: false,
      visualDensity: VisualDensity.standard,
    );
  }
}
