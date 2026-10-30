import 'package:awesome_flutter_kit/awesome_flutter_kit.dart';
import 'package:flutter/material.dart';

void main() => runApp(const KitShowcaseApp());

class KitShowcaseApp extends StatefulWidget {
  const KitShowcaseApp({super.key});

  @override
  State<KitShowcaseApp> createState() => _KitShowcaseAppState();
}

class _KitShowcaseAppState extends State<KitShowcaseApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome Flutter Kit',
      debugShowCheckedModeBanner: false,
      theme: AfkTheme.light(),
      darkTheme: AfkTheme.dark(),
      themeMode: _themeMode,
      home: KitShowcaseHome(
        themeMode: _themeMode,
        onThemeModeChanged: (value) => setState(() => _themeMode = value),
      ),
    );
  }
}

class KitShowcaseHome extends StatefulWidget {
  const KitShowcaseHome({
    required this.themeMode,
    required this.onThemeModeChanged,
    super.key,
  });

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  @override
  State<KitShowcaseHome> createState() => _KitShowcaseHomeState();
}

class _KitShowcaseHomeState extends State<KitShowcaseHome> {
  int _index = 0;
  String _period = 'Week';
  bool _notifications = true;
  bool _compact = false;
  bool _includeArchived = false;
  double _progress = 62;
  int _quantity = 2;
  int _waterMl = 1250;
  String _selectedDay = 'today';
  bool _fastingActive = true;
  final Set<String> _filters = {'All'};
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final titles = ['Design', 'Controls', 'Feedback', 'Nutrition'];
    return Scaffold(
      appBar: AfkAppBar(
        title: Text(titles[_index]),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AfkSpacing.xs),
            child: PopupMenuButton<ThemeMode>(
              tooltip: 'Appearance',
              initialValue: widget.themeMode,
              onSelected: widget.onThemeModeChanged,
              icon: const Icon(Icons.contrast_outlined),
              itemBuilder:
                  (context) => const [
                    PopupMenuItem(
                      value: ThemeMode.system,
                      child: Text('System'),
                    ),
                    PopupMenuItem(value: ThemeMode.light, child: Text('Light')),
                    PopupMenuItem(value: ThemeMode.dark, child: Text('Dark')),
                  ],
            ),
          ),
        ],
      ),
      body: AfkPage(
        padding: EdgeInsets.zero,
        safeArea: false,
        child: IndexedStack(
          index: _index,
          children: [
            _buildDesignPage(context),
            _buildControlsPage(context),
            _buildFeedbackPage(context),
            _buildNutritionPage(context),
          ],
        ),
      ),
      bottomNavigationBar: AfkBottomNavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        items: const [
          AfkNavigationItem(
            label: 'Design',
            icon: Icons.palette_outlined,
            selectedIcon: Icons.palette,
          ),
          AfkNavigationItem(
            label: 'Controls',
            icon: Icons.tune_outlined,
            selectedIcon: Icons.tune,
          ),
          AfkNavigationItem(
            label: 'Feedback',
            icon: Icons.chat_bubble_outline,
            selectedIcon: Icons.chat_bubble,
          ),
          AfkNavigationItem(
            label: 'Nutrition',
            icon: Icons.restaurant_outlined,
            selectedIcon: Icons.restaurant,
          ),
        ],
      ),
    );
  }

  Widget _buildDesignPage(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return ListView(
      padding: const EdgeInsets.all(AfkSpacing.lg),
      children: [
        Text('A calmer starting point', style: theme.textTheme.headlineSmall),
        const SizedBox(height: AfkSpacing.xs),
        Text(
          'A small, coherent mobile UI system built around clarity, comfortable spacing, and deliberate interaction.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AfkSpacing.xl),
        const AfkSectionHeader(
          title: 'Surface and hierarchy',
          subtitle: 'Use space and typography before decoration.',
        ),
        const SizedBox(height: AfkSpacing.md),
        AfkCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Weekly overview',
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  const AfkBadge(
                    label: 'Updated',
                    variant: AfkBadgeVariant.subtle,
                    icon: Icons.check,
                  ),
                ],
              ),
              const SizedBox(height: AfkSpacing.md),
              Text(
                'Your activity is moving in the right direction.',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: AfkSpacing.lg),
              const AfkProgressBar(
                value: 0.72,
                label: 'Weekly target',
                showValue: true,
              ),
              const SizedBox(height: AfkSpacing.sm),
              Text(
                '72% of your weekly target',
                style: theme.textTheme.labelMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: AfkSpacing.xl),
        const AfkSectionHeader(title: 'Actions'),
        const SizedBox(height: AfkSpacing.md),
        Wrap(
          spacing: AfkSpacing.sm,
          runSpacing: AfkSpacing.sm,
          children: [
            AfkButton(
              label: 'Primary action',
              onPressed:
                  () => AfkSnackBar.show(
                    context,
                    message: 'Primary action selected',
                    variant: AfkSnackBarVariant.success,
                  ),
            ),
            AfkButton(
              label: 'Secondary',
              variant: AfkButtonVariant.outlined,
              onPressed:
                  () => AfkSnackBar.show(
                    context,
                    message: 'Secondary action selected',
                  ),
            ),
            AfkButton(
              label: 'Text action',
              variant: AfkButtonVariant.text,
              onPressed:
                  () => AfkSnackBar.show(
                    context,
                    message: 'Text action selected',
                  ),
            ),
          ],
        ),
        const SizedBox(height: AfkSpacing.xl),
        const AfkSectionHeader(title: 'Motion'),
        const SizedBox(height: AfkSpacing.md),
        AfkPressable(
          onTap:
              () => AfkSnackBar.show(
                context,
                message: 'Press feedback respects reduced-motion settings.',
              ),
          child: const AfkCard(
            child: Row(
              children: [
                Icon(Icons.touch_app_outlined),
                SizedBox(width: AfkSpacing.md),
                Expanded(child: Text('Tap this surface for subtle feedback')),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildControlsPage(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(AfkSpacing.lg),
      children: [
        Text('Input and selection', style: theme.textTheme.headlineSmall),
        const SizedBox(height: AfkSpacing.xs),
        Text(
          'Controlled components keep application state explicit and easy to test.',
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: AfkSpacing.xl),
        const AfkSectionHeader(title: 'Segmented control'),
        const SizedBox(height: AfkSpacing.sm),
        AfkSegmentedControl<String>(
          options: const [
            AfkSegmentedOption(value: 'Day', label: 'Day'),
            AfkSegmentedOption(value: 'Week', label: 'Week'),
            AfkSegmentedOption(value: 'Month', label: 'Month'),
          ],
          value: _period,
          onChanged: (value) => setState(() => _period = value),
        ),
        const SizedBox(height: AfkSpacing.xl),
        const AfkSectionHeader(title: 'Filter chips'),
        const SizedBox(height: AfkSpacing.sm),
        Wrap(
          spacing: AfkSpacing.sm,
          runSpacing: AfkSpacing.sm,
          children:
              ['All', 'Favorites', 'Recent', 'Archived']
                  .map(
                    (label) => AfkChoiceChip(
                      label: label,
                      selected: _filters.contains(label),
                      onSelected:
                          (selected) => setState(() {
                            if (label == 'All' && selected) {
                              _filters
                                ..clear()
                                ..add('All');
                            } else {
                              _filters.remove('All');
                              if (selected) {
                                _filters.add(label);
                              } else {
                                _filters.remove(label);
                              }
                              if (_filters.isEmpty) _filters.add('All');
                            }
                          }),
                    ),
                  )
                  .toList(),
        ),
        const SizedBox(height: AfkSpacing.xl),
        const AfkSectionHeader(title: 'Form fields'),
        const SizedBox(height: AfkSpacing.sm),
        AfkTextField(
          label: 'Search',
          controller: _searchController,
          hintText: 'Search items',
          prefixIcon: const Icon(Icons.search),
          textInputAction: TextInputAction.search,
        ),
        const SizedBox(height: AfkSpacing.sm),
        AfkCheckboxTile(
          title: 'Include archived items',
          subtitle: 'Show items that are no longer active',
          value: _includeArchived,
          onChanged:
              (value) => setState(() => _includeArchived = value ?? false),
        ),
        AfkSwitchTile(
          title: 'Notifications',
          subtitle: 'Receive useful activity updates',
          value: _notifications,
          onChanged: (value) => setState(() => _notifications = value),
        ),
        AfkRadioTile<String>(
          title: 'Comfortable density',
          value: 'comfortable',
          groupValue: _compact ? 'compact' : 'comfortable',
          onChanged: (value) => setState(() => _compact = value == 'compact'),
        ),
        AfkRadioTile<String>(
          title: 'Compact density',
          value: 'compact',
          groupValue: _compact ? 'compact' : 'comfortable',
          onChanged: (value) => setState(() => _compact = value == 'compact'),
        ),
        const SizedBox(height: AfkSpacing.md),
        AfkSlider(
          value: _progress,
          min: 0,
          max: 100,
          divisions: 20,
          label: 'Progress',
          showValue: true,
          onChanged: (value) => setState(() => _progress = value),
        ),
        const SizedBox(height: AfkSpacing.lg),
        const AfkSectionHeader(
          title: 'Numeric stepper',
          subtitle: 'Bounded adjustments with accessible actions.',
        ),
        AfkStepper(
          label: 'Quantity',
          value: _quantity,
          min: 1,
          max: 5,
          onChanged: (value) => setState(() => _quantity = value),
          decreaseTooltip: 'Decrease quantity',
          increaseTooltip: 'Increase quantity',
        ),
      ],
    );
  }

  Widget _buildNutritionPage(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return ListView(
      padding: const EdgeInsets.all(AfkSpacing.lg),
      children: [
        Text('Your day', style: theme.textTheme.headlineSmall),
        const SizedBox(height: AfkSpacing.xs),
        Text(
          'A nutrition-dashboard pattern inspired by photo-first trackers. All figures below are illustrative demo data.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AfkSpacing.xl),
        AfkNutritionHero(
          title: 'Today’s calories',
          consumed: 1240,
          goal: 2100,
          consumedLabel: 'kcal consumed',
          goalLabel: 'kcal goal',
          remainingLabel: 'kcal left',
          addFoodLabel: 'Add food',
          breakdownLabel: 'Nutrition details',
          onAddFood: () => _showAddFoodMethods(context),
          onViewBreakdown:
              () => AfkSnackBar.show(
                context,
                message:
                    'Nutrition details are shown in Daily nutrients below.',
              ),
        ),
        const SizedBox(height: AfkSpacing.lg),
        AfkDateSelector(
          value: _selectedDay,
          onChanged: (value) => setState(() => _selectedDay = value),
          options: const [
            AfkDateOption(value: 'mon', label: 'Mon', caption: '20'),
            AfkDateOption(value: 'tue', label: 'Tue', caption: '21'),
            AfkDateOption(value: 'today', label: 'Today', caption: '22'),
            AfkDateOption(value: 'thu', label: 'Thu', caption: '23'),
            AfkDateOption(value: 'fri', label: 'Fri', caption: '24'),
            AfkDateOption(value: 'sat', label: 'Sat', caption: '25'),
            AfkDateOption(value: 'sun', label: 'Sun', caption: '26'),
          ],
        ),
        const SizedBox(height: AfkSpacing.xl),
        const AfkSectionHeader(
          title: 'Daily nutrients',
          subtitle: 'A quick scan of your macro targets.',
        ),
        const SizedBox(height: AfkSpacing.md),
        const AfkMacroProgress(
          label: 'Protein',
          value: 76,
          goal: 130,
          unit: 'g',
        ),
        const SizedBox(height: AfkSpacing.md),
        const AfkMacroProgress(
          label: 'Carbs',
          value: 118,
          goal: 220,
          unit: 'g',
        ),
        const SizedBox(height: AfkSpacing.md),
        const AfkMacroProgress(label: 'Fat', value: 42, goal: 70, unit: 'g'),

        const SizedBox(height: AfkSpacing.lg),
        AfkFastingCard(
          title: 'Fasting window',
          statusLabel:
              _fastingActive ? 'Session in progress' : 'Session paused',
          durationLabel: '12 h 20 min',
          actionLabel: _fastingActive ? 'End' : 'Start',
          isActive: _fastingActive,
          onAction: () => setState(() => _fastingActive = !_fastingActive),
        ),
        const SizedBox(height: AfkSpacing.lg),
        AfkCard(
          child: AfkHydrationTracker(
            currentMl: _waterMl,
            goalMl: 2500,
            title: 'Water',
            amountLabel: 'Add a glass whenever you need it.',
            addTooltip: 'Add 250 ml of water',
            onAdd:
                (amount) => setState(() {
                  _waterMl = (_waterMl + amount).clamp(0, 2500).toInt();
                }),
          ),
        ),
        const SizedBox(height: AfkSpacing.xl),
        Row(
          children: [
            Expanded(
              child: Text(
                _selectedDay == 'today'
                    ? 'Today’s meals'
                    : 'Meals · $_selectedDay',
                style: theme.textTheme.titleLarge,
              ),
            ),
            Text('2 entries', style: theme.textTheme.labelMedium),
          ],
        ),
        const SizedBox(height: AfkSpacing.sm),
        AfkCard(
          padding: const EdgeInsets.symmetric(vertical: AfkSpacing.xs),
          child: Column(
            children: [
              AfkMealEntryTile(
                title: 'Greek yogurt bowl',
                subtitle: 'Breakfast · yogurt, berries, oats',
                calories: 360,
                calorieUnit: 'kcal',
                leading: const Icon(Icons.restaurant_outlined),
                onTap:
                    () => AfkSnackBar.show(
                      context,
                      message:
                          'Demo entry selected. Your app owns meal details.',
                    ),
              ),
              const AfkDivider(spacing: 0, indent: AfkSpacing.sm),
              AfkMealEntryTile(
                title: 'Grilled chicken bowl',
                subtitle: 'Lunch · rice, chicken, vegetables',
                calories: 640,
                calorieUnit: 'kcal',
                leading: const Icon(Icons.fastfood_outlined),
                onTap:
                    () => AfkSnackBar.show(
                      context,
                      message:
                          'Demo entry selected. Your app owns meal details.',
                    ),
              ),
            ],
          ),
        ),

        const SizedBox(height: AfkSpacing.xl),
        const AfkSectionHeader(
          title: 'Movement',
          subtitle: 'Activity entries can sit beside food and hydration.',
        ),
        const SizedBox(height: AfkSpacing.sm),
        const AfkCard(
          padding: EdgeInsets.symmetric(vertical: AfkSpacing.xs),
          child: AfkActivityEntryTile(
            title: 'Evening walk',
            durationLabel: '32 min',
            burnedCalories: 180,
            calorieUnit: 'kcal',
            subtitle: 'Walking',
          ),
        ),
        const SizedBox(height: AfkSpacing.xl),
        const AfkSectionHeader(
          title: 'Review an estimate',
          subtitle: 'Keep recognition results editable before saving.',
        ),
        const SizedBox(height: AfkSpacing.sm),
        AfkCard(
          child: AfkFoodEstimateTile(
            title: 'Grilled chicken',
            subtitle: 'Illustrative estimate · review before saving',
            portionLabel: '150 g',
            calories: 280,
            calorieUnit: 'kcal',
            editLabel: 'Edit',
            leading: const Icon(Icons.fastfood_outlined),
            onEdit:
                () => AfkSnackBar.show(
                  context,
                  message:
                      'Demo only — portion editing belongs to the host flow.',
                ),
          ),
        ),
        const SizedBox(height: AfkSpacing.lg),
      ],
    );
  }

  void _showAddFoodMethods(BuildContext context) {
    final theme = Theme.of(context);
    AfkBottomSheet.show<void>(
      context,
      builder:
          (sheetContext) => AfkBottomSheet.content(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Add a meal', style: theme.textTheme.titleLarge),
                  const SizedBox(height: AfkSpacing.sm),
                  AfkListTile(
                    title: const Text('Photo scan'),
                    subtitle: const Text('Connect your host app’s camera flow'),
                    leading: const Icon(Icons.camera_alt_outlined),
                    onTap:
                        () => _showIntegrationNotice(
                          context,
                          sheetContext,
                          'camera capture',
                        ),
                  ),
                  AfkListTile(
                    title: const Text('Search foods'),
                    subtitle: const Text('Connect your chosen food database'),
                    leading: const Icon(Icons.search),
                    onTap:
                        () => _showIntegrationNotice(
                          context,
                          sheetContext,
                          'food search',
                        ),
                  ),
                  AfkListTile(
                    title: const Text('Barcode scan'),
                    subtitle: const Text(
                      'Connect a barcode scanner and data source',
                    ),
                    leading: const Icon(Icons.qr_code_scanner),
                    onTap:
                        () => _showIntegrationNotice(
                          context,
                          sheetContext,
                          'barcode scanning',
                        ),
                  ),
                  AfkListTile(
                    title: const Text('Choose from gallery'),
                    subtitle: const Text('Select an existing meal photo'),
                    leading: const Icon(Icons.photo_library_outlined),
                    onTap:
                        () => _showIntegrationNotice(
                          context,
                          sheetContext,
                          'gallery selection',
                        ),
                  ),
                  AfkListTile(
                    title: const Text('Describe by voice'),
                    subtitle: const Text('Connect speech input and parsing'),
                    leading: const Icon(Icons.mic_none),
                    onTap:
                        () => _showIntegrationNotice(
                          context,
                          sheetContext,
                          'voice logging',
                        ),
                  ),
                  AfkListTile(
                    title: const Text('Manual entry'),
                    subtitle: const Text('Enter food and portion details'),
                    leading: const Icon(Icons.edit_note),
                    onTap:
                        () => _showIntegrationNotice(
                          context,
                          sheetContext,
                          'manual entry',
                        ),
                  ),
                  AfkListTile(
                    title: const Text('Nutrition label'),
                    subtitle: const Text('Read packaged-food nutrition facts'),
                    leading: const Icon(Icons.document_scanner),
                    onTap:
                        () => _showIntegrationNotice(
                          context,
                          sheetContext,
                          'nutrition-label scanning',
                        ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  void _showIntegrationNotice(
    BuildContext context,
    BuildContext sheetContext,
    String method,
  ) {
    Navigator.of(sheetContext).pop();
    AfkSnackBar.show(
      context,
      message: 'Showcase only — $method belongs to the host app.',
    );
  }

  Widget _buildFeedbackPage(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(AfkSpacing.lg),
      children: [
        Text('States and feedback', style: theme.textTheme.headlineSmall),
        const SizedBox(height: AfkSpacing.xs),
        Text(
          'Useful states explain what is happening and provide a clear next step.',
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: AfkSpacing.xl),
        const AfkSectionHeader(title: 'Status messages'),
        const SizedBox(height: AfkSpacing.sm),
        const AfkStatusMessage(
          message: 'Your changes have been saved.',
          variant: AfkStatusVariant.success,
        ),
        const SizedBox(height: AfkSpacing.sm),
        const AfkStatusMessage(
          message: 'You are viewing the latest available information.',
          variant: AfkStatusVariant.info,
        ),
        const SizedBox(height: AfkSpacing.sm),
        const AfkStatusMessage(
          message: 'Some items may need your attention.',
          variant: AfkStatusVariant.warning,
        ),
        const SizedBox(height: AfkSpacing.xl),
        const AfkSectionHeader(title: 'Loading placeholders'),
        const SizedBox(height: AfkSpacing.md),
        const AfkCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AfkSkeleton(width: 140, height: 20),
              SizedBox(height: AfkSpacing.md),
              AfkSkeleton(width: double.infinity, height: 14),
              SizedBox(height: AfkSpacing.sm),
              AfkSkeleton(width: 220, height: 14),
            ],
          ),
        ),
        const SizedBox(height: AfkSpacing.xl),
        const AfkSectionHeader(title: 'Empty state'),
        const SizedBox(height: AfkSpacing.md),
        const AfkCard(
          child: AfkEmptyState(
            title: 'Nothing here yet',
            description:
                'When you add your first item, it will appear in this space.',
            icon: Icons.inbox_outlined,
          ),
        ),
        const SizedBox(height: AfkSpacing.xl),
        const AfkSectionHeader(title: 'Recoverable error'),
        const SizedBox(height: AfkSpacing.md),
        AfkErrorState(
          title: 'Could not refresh',
          description: 'Check your connection and try again.',
          onRetry:
              () => AfkSnackBar.show(
                context,
                message: 'Retry requested',
                variant: AfkSnackBarVariant.neutral,
              ),
        ),
        const SizedBox(height: AfkSpacing.xl),
        const AfkSectionHeader(title: 'Overlays'),
        const SizedBox(height: AfkSpacing.md),
        Wrap(
          spacing: AfkSpacing.sm,
          runSpacing: AfkSpacing.sm,
          children: [
            AfkButton(
              label: 'Show snackbar',
              onPressed:
                  () => AfkSnackBar.show(
                    context,
                    message: 'This is brief, non-blocking feedback.',
                    variant: AfkSnackBarVariant.success,
                  ),
            ),
            AfkButton(
              label: 'Open bottom sheet',
              variant: AfkButtonVariant.outlined,
              onPressed:
                  () => AfkBottomSheet.show<void>(
                    context,
                    builder:
                        (sheetContext) => AfkBottomSheet.content(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Quick actions',
                                style: theme.textTheme.titleLarge,
                              ),
                              const SizedBox(height: AfkSpacing.md),
                              AfkListTile(
                                title: const Text('Edit details'),
                                leading: const Icon(Icons.edit_outlined),
                                onTap: () => Navigator.of(sheetContext).pop(),
                              ),
                              AfkListTile(
                                title: const Text('Manage preferences'),
                                leading: const Icon(Icons.tune_outlined),
                                onTap: () => Navigator.of(sheetContext).pop(),
                              ),
                            ],
                          ),
                        ),
                  ),
            ),
            AfkButton(
              label: 'Confirm action',
              variant: AfkButtonVariant.outlined,
              onPressed: () async {
                final confirmed = await AfkConfirmDialog.show(
                  context,
                  title: 'Continue?',
                  message: 'This demonstrates a clear confirmation step.',
                  confirmLabel: 'Continue',
                  cancelLabel: 'Cancel',
                );
                if (context.mounted && confirmed == true) {
                  AfkSnackBar.show(context, message: 'Confirmed');
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
