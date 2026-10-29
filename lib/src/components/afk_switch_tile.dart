import 'package:flutter/material.dart';

/// A consistent switch row for settings and preference screens.
class AfkSwitchTile extends StatelessWidget {
  const AfkSwitchTile({
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
  final ValueChanged<bool>? onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      onChanged: enabled ? onChanged : null,
      title: Text(title),
      subtitle: subtitle == null ? null : Text(subtitle!),
      contentPadding: EdgeInsets.zero,
      activeTrackColor: Theme.of(context).colorScheme.primary,
    );
  }
}
