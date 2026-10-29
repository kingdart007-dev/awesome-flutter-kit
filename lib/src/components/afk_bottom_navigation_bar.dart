import 'package:flutter/material.dart';

/// A destination in [AfkBottomNavigationBar].
class AfkNavigationItem {
  const AfkNavigationItem({
    required this.label,
    required this.icon,
    this.selectedIcon,
    this.tooltip,
  });

  final String label;
  final IconData icon;
  final IconData? selectedIcon;
  final String? tooltip;
}

/// A controlled bottom navigation bar with restrained Material styling.
class AfkBottomNavigationBar extends StatelessWidget {
  const AfkBottomNavigationBar({
    required this.items,
    required this.selectedIndex,
    required this.onDestinationSelected,
    super.key,
  }) : assert(items.length >= 2),
       assert(selectedIndex >= 0 && selectedIndex < items.length);

  final List<AfkNavigationItem> items;
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      height: 72,
      backgroundColor: colors.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      indicatorColor: colors.onSurface.withValues(alpha: 0.08),
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      destinations: [
        for (final item in items)
          NavigationDestination(
            label: item.label,
            tooltip: item.tooltip ?? item.label,
            icon: Icon(item.icon),
            selectedIcon: Icon(item.selectedIcon ?? item.icon),
          ),
      ],
    );
  }
}
