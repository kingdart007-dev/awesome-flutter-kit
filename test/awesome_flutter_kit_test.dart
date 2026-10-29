import 'package:awesome_flutter_kit/awesome_flutter_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('AfkDateSelector', () {
    testWidgets('shows date options and reports selection', (tester) async {
      String selected = 'today';
      await tester.pumpWidget(
        MaterialApp(
          theme: AfkTheme.light(),
          home: StatefulBuilder(
            builder: (context, setState) => Scaffold(
              body: AfkDateSelector(
                options: const [
                  AfkDateOption(value: 'mon', label: 'Mon', caption: '21'),
                  AfkDateOption(value: 'today', label: 'Today', caption: '22'),
                  AfkDateOption(value: 'wed', label: 'Wed', caption: '23'),
                ],
                value: selected,
                onChanged: (value) => setState(() => selected = value),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Today'), findsOneWidget);
      await tester.tap(find.text('Wed'));
      await tester.pumpAndSettle();
      expect(selected, 'wed');
    });
  });


  group('AfkFoodScanCard', () {
    testWidgets('presents the scan action and handles taps', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AfkFoodScanCard(
              title: 'Scan meal',
              description: 'Take a photo of your food',
              actionLabel: 'Start scan',
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      expect(find.text('Scan meal'), findsOneWidget);
      expect(find.text('Start scan'), findsOneWidget);
      await tester.tap(find.byType(AfkFoodScanCard));
      expect(tapped, isTrue);
    });
  });

  group('AfkHydrationTracker', () {
    testWidgets('reports the configured water increment', (tester) async {
      int? added;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AfkHydrationTracker(
              currentMl: 500,
              goalMl: 2000,
              title: 'Water',
              amountLabel: 'One glass at a time',
              addTooltip: 'Add water',
              onAdd: (amount) => added = amount,
            ),
          ),
        ),
      );

      expect(find.text('500 / 2000 ml'), findsOneWidget);
      await tester.tap(find.byTooltip('Add water'));
      expect(added, 250);
    });
  });


  group('AfkCalorieRing', () {
    testWidgets('shows calorie total and remaining budget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AfkTheme.light(),
          home: const Scaffold(
            body: AfkCalorieRing(
              consumed: 1200,
              goal: 2000,
              centerLabel: 'consumed',
              footerLabel: 'kcal left',
            ),
          ),
        ),
      );

      expect(find.text('1200'), findsOneWidget);
      expect(find.text('800 kcal left'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNWidgets(2));
    });
  });

  group('AfkMacroProgress', () {
    testWidgets('exposes nutrient progress and values', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const Scaffold(
            body: AfkMacroProgress(
              label: 'Protein',
              value: 60,
              goal: 120,
              unit: 'g',
            ),
          ),
        ),
      );

      expect(find.text('Protein'), findsOneWidget);
      expect(find.text('60 / 120 g'), findsOneWidget);
      expect(tester.widget<LinearProgressIndicator>(
        find.byType(LinearProgressIndicator),
      ).value, 0.5);
    });
  });

  group('AfkMealEntryTile', () {
    testWidgets('shows meal details and reports selection', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AfkMealEntryTile(
              title: 'Grilled chicken bowl',
              subtitle: 'Lunch · 48 g protein',
              calories: 520,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      expect(find.text('Grilled chicken bowl'), findsOneWidget);
      expect(find.text('520'), findsOneWidget);
      await tester.tap(find.byType(AfkMealEntryTile));
      expect(tapped, isTrue);
    });
  });


  group('AfkStepper', () {
    testWidgets('increments, decrements, and disables at bounds', (
      tester,
    ) async {
      var value = 2;
      await tester.pumpWidget(
        MaterialApp(
          theme: AfkTheme.light(),
          home: StatefulBuilder(
            builder: (context, setState) => Scaffold(
              body: AfkStepper(
                label: 'Quantity',
                value: value,
                min: 1,
                max: 3,
                onChanged: (next) => setState(() => value = next),
                decreaseTooltip: 'Decrease quantity',
                increaseTooltip: 'Increase quantity',
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byTooltip('Increase quantity'));
      await tester.pumpAndSettle();
      expect(find.text('3'), findsOneWidget);

      await tester.tap(find.byTooltip('Increase quantity'));
      await tester.pumpAndSettle();
      expect(value, 3);

      await tester.tap(find.byTooltip('Decrease quantity'));
      await tester.pumpAndSettle();
      expect(value, 2);
    });

    testWidgets('supports custom value labels and disabled state', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AfkStepper(
              label: 'Items',
              value: 1,
              min: 1,
              max: 5,
              onChanged: null,
              decreaseTooltip: 'Decrease',
              increaseTooltip: 'Increase',
              valueLabelBuilder: (value) => '$value item',
            ),
          ),
        ),
      );

      expect(find.text('1 item'), findsOneWidget);
      expect(
        tester.widget<IconButton>(
          find.descendant(
            of: find.byType(AfkStepper),
            matching: find.byType(IconButton),
          ).first,
        ).onPressed,
        isNull,
      );
      expect(
        tester.widget<IconButton>(
          find.descendant(
            of: find.byType(AfkStepper),
            matching: find.byType(IconButton),
          ).last,
        ).onPressed,
        isNull,
      );
    });
  });


  group('AfkTabBar', () {
    testWidgets('renders tabs and allows the controller to change views', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AfkTheme.light(),
          home: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(bottom: const AfkTabBar(
                tabs: [Tab(text: 'Overview'), Tab(text: 'Details')],
              )),
              body: const TabBarView(
                children: [Text('Overview content'), Text('Details content')],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Overview'), findsOneWidget);
      await tester.tap(find.text('Details'));
      await tester.pumpAndSettle();
      expect(find.text('Details content'), findsOneWidget);
    });
  });

  group('AfkContentSwitcher', () {
    testWidgets('shows replacement content and respects reduced motion', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(disableAnimations: true),
            child: const Scaffold(
              body: AfkContentSwitcher(
                child: Text('Current content', key: ValueKey('current')),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Current content'), findsOneWidget);
      final switcher = tester.widget<AnimatedSwitcher>(
        find.byType(AnimatedSwitcher),
      );
      expect(switcher.duration, Duration.zero);
    });
  });


  group('AfkListTile', () {
    testWidgets('shows title and subtitle and responds to taps', (
      tester,
    ) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          theme: AfkTheme.light(),
          home: Scaffold(
            body: AfkListTile(
              title: const Text('Profile'),
              subtitle: const Text('Account preferences'),
              leading: const Icon(Icons.person_outline),
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('Account preferences'), findsOneWidget);
      await tester.tap(find.byType(AfkListTile));
      expect(tapped, isTrue);
    });
  });

  group('AfkBottomSheet', () {
    testWidgets('presents content and returns a selected result', (
      tester,
    ) async {
      String? result;
      await tester.pumpWidget(
        MaterialApp(
          theme: AfkTheme.light(),
          home: Builder(
            builder: (context) => Scaffold(
              body: TextButton(
                onPressed: () async {
                  result = await AfkBottomSheet.show<String>(
                    context,
                    builder: (sheetContext) => AfkBottomSheet.content(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Choose an option'),
                          TextButton(
                            onPressed: () =>
                                Navigator.of(sheetContext).pop('selected'),
                            child: const Text('Select'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: const Text('Open sheet'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open sheet'));
      await tester.pumpAndSettle();
      expect(find.text('Choose an option'), findsOneWidget);
      await tester.tap(find.text('Select'));
      await tester.pumpAndSettle();
      expect(result, 'selected');
    });
  });

  group('AfkTheme', () {
    test('creates light and dark themes', () {
      expect(AfkTheme.light().brightness, Brightness.light);
      expect(AfkTheme.dark().brightness, Brightness.dark);
    });

    test('applies the shared typography scale', () {
      final textTheme = AfkTheme.light().textTheme;
      expect(textTheme.headlineSmall?.fontSize, AfkTypography.pageTitle.fontSize);
      expect(textTheme.titleLarge?.fontSize, AfkTypography.sectionTitle.fontSize);
      expect(textTheme.titleMedium?.fontSize, AfkTypography.itemTitle.fontSize);
      expect(textTheme.bodyMedium?.fontSize, AfkTypography.body.fontSize);
    });

    test('keeps a monochrome primary color in both themes', () {
      expect(AfkTheme.light().colorScheme.primary, AfkColors.black);
      expect(AfkTheme.dark().colorScheme.primary, AfkColors.white);
    });
  });

  group('AfkButton', () {
    testWidgets('exposes its label and responds to taps', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AfkTheme.light(),
          home: Scaffold(
            body: AfkButton(label: 'Continue', onPressed: () => tapped = true),
          ),
        ),
      );

      expect(find.text('Continue'), findsOneWidget);
      await tester.tap(find.byType(AfkButton));
      expect(tapped, isTrue);
    });

    testWidgets('does not invoke its callback while loading', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AfkTheme.light(),
          home: Scaffold(
            body: AfkButton(
              label: 'Saving',
              isLoading: true,
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.tap(find.byType(AfkButton));
      expect(tapped, isFalse);
    });

    testWidgets('supports all visual variants', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AfkTheme.light(),
          home: const Scaffold(
            body: Column(
              children: [
                AfkButton(label: 'Filled', onPressed: null),
                AfkButton(
                  label: 'Outlined',
                  variant: AfkButtonVariant.outlined,
                  onPressed: null,
                ),
                AfkButton(
                  label: 'Text',
                  variant: AfkButtonVariant.text,
                  onPressed: null,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Filled'), findsOneWidget);
      expect(find.text('Outlined'), findsOneWidget);
      expect(find.text('Text'), findsOneWidget);
    });
  });

  testWidgets('AfkSectionHeader shows title, subtitle, and trailing content', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AfkTheme.light(),
        home: const Scaffold(
          body: AfkSectionHeader(
            title: 'Recent activity',
            subtitle: 'Your latest entries',
            trailing: Icon(Icons.more_horiz),
          ),
        ),
      ),
    );

    expect(find.text('Recent activity'), findsOneWidget);
    expect(find.text('Your latest entries'), findsOneWidget);
    expect(find.byIcon(Icons.more_horiz), findsOneWidget);
  });

  testWidgets('AfkPage applies readable width and renders its child', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: AfkPage(child: Text('Page content'))),
      ),
    );

    expect(find.text('Page content'), findsOneWidget);

    final constraints = tester.widget<ConstrainedBox>(
      find.descendant(
        of: find.byType(AfkPage),
        matching: find.byType(ConstrainedBox),
      ),
    );
    expect(constraints.constraints.maxWidth, 640);
  });

  testWidgets('AfkPage can disable its safe area', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AfkPage(safeArea: false, child: Text('Edge content')),
        ),
      ),
    );

    expect(find.text('Edge content'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(AfkPage),
        matching: find.byType(SafeArea),
      ),
      findsNothing,
    );
  });

  testWidgets('AfkPage accepts a custom maximum width', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AfkPage(
            maxWidth: 480,
            padding: EdgeInsets.zero,
            child: Text('Narrow content'),
          ),
        ),
      ),
    );

    final constraints = tester.widget<ConstrainedBox>(
      find.descendant(
        of: find.byType(AfkPage),
        matching: find.byType(ConstrainedBox),
      ),
    );

    expect(constraints.constraints.maxWidth, 480);
    expect(find.text('Narrow content'), findsOneWidget);
  });

  testWidgets('AfkDivider uses theme color and configurable spacing', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AfkTheme.light(),
        home: const Scaffold(
          body: AfkDivider(spacing: 12, indent: 8, endIndent: 16),
        ),
      ),
    );

    final padding = tester.widget<Padding>(
      find
          .ancestor(of: find.byType(Divider), matching: find.byType(Padding))
          .first,
    );
    final divider = tester.widget<Divider>(find.byType(Divider));

    expect(padding.padding, const EdgeInsets.symmetric(vertical: 12));
    expect(divider.indent, 8);
    expect(divider.endIndent, 16);
    expect(divider.color, AfkTheme.light().dividerColor);
  });

  group('AfkTextField', () {
    testWidgets('shows label, hint, and helper text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AfkTheme.light(),
          home: const Scaffold(
            body: Padding(
              padding: EdgeInsets.all(16),
              child: AfkTextField(
                label: 'Email',
                hintText: 'you@example.com',
                helperText: 'We will never share your email.',
              ),
            ),
          ),
        ),
      );

      expect(find.text('Email'), findsOneWidget);
      expect(find.text('you@example.com'), findsOneWidget);
      expect(find.text('We will never share your email.'), findsOneWidget);
    });

    testWidgets('reports text changes and displays validation errors', (
      tester,
    ) async {
      String? changedValue;

      await tester.pumpWidget(
        MaterialApp(
          theme: AfkTheme.light(),
          home: Scaffold(
            body: AfkTextField(
              label: 'Name',
              errorText: 'Name is required',
              onChanged: (value) => changedValue = value,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'Ada');
      expect(changedValue, 'Ada');
      expect(find.text('Name is required'), findsOneWidget);
    });

    testWidgets('supports obscured input and disabled state', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                AfkTextField(label: 'Password', obscureText: true),
                AfkTextField(label: 'Read only', enabled: false),
              ],
            ),
          ),
        ),
      );

      final fields =
          tester.widgetList<TextFormField>(find.byType(TextFormField)).toList();
      final obscuredField = tester.widget<EditableText>(
        find.descendant(
          of: find.byType(AfkTextField).first,
          matching: find.byType(EditableText),
        ),
      );

      expect(obscuredField.obscureText, isTrue);
      expect(fields[1].enabled, isFalse);
    });
  });

  group('AfkCheckboxTile', () {
    testWidgets('renders title and subtitle and reports changes', (
      tester,
    ) async {
      bool? changedValue;

      await tester.pumpWidget(
        MaterialApp(
          theme: AfkTheme.light(),
          home: Scaffold(
            body: AfkCheckboxTile(
              title: 'Remember me',
              subtitle: 'Keep this preference on this device.',
              value: false,
              onChanged: (value) => changedValue = value,
            ),
          ),
        ),
      );

      expect(find.text('Remember me'), findsOneWidget);
      expect(find.text('Keep this preference on this device.'), findsOneWidget);
      await tester.tap(find.byType(CheckboxListTile));
      expect(changedValue, isTrue);
    });

    testWidgets('does not respond when disabled', (tester) async {
      bool? changedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AfkCheckboxTile(
              title: 'Disabled',
              value: false,
              enabled: false,
              onChanged: (value) => changedValue = value,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(CheckboxListTile));
      expect(changedValue, isNull);
    });
  });

  group('AfkSwitchTile', () {
    testWidgets('renders settings copy and reports changes', (tester) async {
      bool? changedValue;

      await tester.pumpWidget(
        MaterialApp(
          theme: AfkTheme.light(),
          home: Scaffold(
            body: AfkSwitchTile(
              title: 'Notifications',
              subtitle: 'Receive important updates.',
              value: false,
              onChanged: (value) => changedValue = value,
            ),
          ),
        ),
      );

      expect(find.text('Notifications'), findsOneWidget);
      expect(find.text('Receive important updates.'), findsOneWidget);
      await tester.tap(find.byType(Switch));
      expect(changedValue, isTrue);
    });

    testWidgets('does not respond when disabled', (tester) async {
      bool? changedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AfkSwitchTile(
              title: 'Disabled',
              value: false,
              enabled: false,
              onChanged: (value) => changedValue = value,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(Switch));
      expect(changedValue, isNull);
    });
  });

  group('AfkCard', () {
    testWidgets('renders content and responds to taps', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AfkTheme.light(),
          home: Scaffold(
            body: AfkCard(
              onTap: () => tapped = true,
              child: const Text('Card content'),
            ),
          ),
        ),
      );

      expect(find.text('Card content'), findsOneWidget);
      await tester.tap(find.byType(AfkCard));
      expect(tapped, isTrue);
    });
  });

  testWidgets('AfkBadge renders its label and optional icon', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AfkBadge(label: 'Active', icon: Icons.check_circle_outline),
        ),
      ),
    );

    expect(find.text('Active'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
  });

  testWidgets('AfkIconButton exposes a tooltip and responds to taps', (
    tester,
  ) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AfkIconButton(
            icon: Icons.close,
            tooltip: 'Close',
            onPressed: () => tapped = true,
          ),
        ),
      ),
    );

    expect(find.byTooltip('Close'), findsOneWidget);
    await tester.tap(find.byType(AfkIconButton));
    expect(tapped, isTrue);
  });

  testWidgets('AfkLoadingIndicator shows optional label', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: AfkLoadingIndicator(label: 'Loading your data')),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Loading your data'), findsOneWidget);
  });

  testWidgets('AfkErrorState offers a working retry action', (tester) async {
    var retried = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AfkErrorState(
            title: 'Could not load',
            description: 'Check your connection and try again.',
            retryLabel: 'Retry',
            onRetry: () => retried = true,
          ),
        ),
      ),
    );

    expect(find.text('Could not load'), findsOneWidget);
    expect(find.text('Check your connection and try again.'), findsOneWidget);
    await tester.tap(find.text('Retry'));
    expect(retried, isTrue);
  });

  group('AfkMotion', () {
    test('provides shared short and standard motion timings', () {
      expect(
        AfkMotion.fast.inMilliseconds,
        lessThan(AfkMotion.normal.inMilliseconds),
      );
      expect(
        AfkMotion.normal.inMilliseconds,
        lessThan(AfkMotion.deliberate.inMilliseconds),
      );
    });
  });

  group('AfkPressable', () {
    testWidgets('renders its child and responds to taps', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AfkTheme.light(),
          home: Scaffold(
            body: AfkPressable(
              onTap: () => tapped = true,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Tap me'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Tap me'), findsOneWidget);
      await tester.tap(find.byType(AfkPressable));
      expect(tapped, isTrue);
    });

    testWidgets('disables animated scaling when reduced motion is enabled', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder:
                (context) => MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(disableAnimations: true),
                  child: Scaffold(
                    body: AfkPressable(
                      onTap: () {},
                      child: Text('Reduced motion'),
                    ),
                  ),
                ),
          ),
        ),
      );

      final animatedScale = tester.widget<AnimatedScale>(
        find.byType(AnimatedScale),
      );
      expect(animatedScale.duration, Duration.zero);
    });
  });

  group('AfkSegmentedControl', () {
    testWidgets('shows options and reports selection', (tester) async {
      String selected = 'day';
      await tester.pumpWidget(
        MaterialApp(
          theme: AfkTheme.light(),
          home: Scaffold(
            body: StatefulBuilder(
              builder:
                  (context, setState) => AfkSegmentedControl<String>(
                    options: const [
                      AfkSegmentedOption(value: 'day', label: 'Day'),
                      AfkSegmentedOption(value: 'week', label: 'Week'),
                      AfkSegmentedOption(value: 'month', label: 'Month'),
                    ],
                    value: selected,
                    onChanged: (value) => setState(() => selected = value),
                  ),
            ),
          ),
        ),
      );
      expect(find.text('Day'), findsOneWidget);
      await tester.tap(find.text('Week'));
      await tester.pumpAndSettle();
      expect(selected, 'week');
    });

    testWidgets('respects disabled state', (tester) async {
      final changed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AfkSegmentedControl<int>(
              options: const [
                AfkSegmentedOption(value: 0, label: 'Off'),
                AfkSegmentedOption(value: 1, label: 'On'),
              ],
              value: 0,
              onChanged: null,
            ),
          ),
        ),
      );
      await tester.tap(find.text('On'));
      expect(changed, isFalse);
    });
  });

  group('AfkChoiceChip', () {
    testWidgets('toggles selection through callback', (tester) async {
      bool selected = false;
      await tester.pumpWidget(
        MaterialApp(
          theme: AfkTheme.light(),
          home: Scaffold(
            body: StatefulBuilder(
              builder:
                  (context, setState) => AfkChoiceChip(
                    label: 'Design',
                    selected: selected,
                    onSelected: (value) => setState(() => selected = value),
                  ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Design'));
      await tester.pumpAndSettle();
      expect(selected, isTrue);
    });
  });

  group('AfkSlider', () {
    testWidgets('shows label and value', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AfkTheme.light(),
          home: const Scaffold(
            body: AfkSlider(
              value: 5,
              min: 0,
              max: 10,
              label: 'Volume',
              showValue: true,
              onChanged: null,
            ),
          ),
        ),
      );
      expect(find.text('Volume'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
      expect(find.byType(Slider), findsOneWidget);
    });
  });

  group('AfkRadioTile', () {
    testWidgets('shows title and subtitle', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AfkRadioTile<String>(
              title: 'Compact',
              subtitle: 'Use less space',
              value: 'compact',
              groupValue: 'comfortable',
              onChanged: (_) {},
            ),
          ),
        ),
      );
      expect(find.text('Compact'), findsOneWidget);
      expect(find.text('Use less space'), findsOneWidget);
    });
  });

  group('AfkSkeleton', () {
    testWidgets('renders a sized, excluded placeholder', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AfkSkeleton(width: 120, height: 20)),
        ),
      );
      final skeleton = tester.widget<AfkSkeleton>(find.byType(AfkSkeleton));
      expect(skeleton.width, 120);
      expect(skeleton.height, 20);
      expect(
        find.descendant(
          of: find.byType(AfkSkeleton),
          matching: find.byType(ExcludeSemantics),
        ),
        findsOneWidget,
      );
    });
  });

  group('AfkStatusMessage', () {
    testWidgets('renders a live-region status message', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AfkStatusMessage(
              message: 'Saved successfully',
              variant: AfkStatusVariant.success,
            ),
          ),
        ),
      );
      expect(find.text('Saved successfully'), findsOneWidget);
      expect(find.byType(Semantics), findsWidgets);
    });
  });


  group('AfkAppBar', () {
    testWidgets('renders a title with the theme surface', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AfkTheme.light(),
          home: const Scaffold(
            appBar: AfkAppBar(title: Text('Overview')),
            body: SizedBox.shrink(),
          ),
        ),
      );
      expect(find.text('Overview'), findsOneWidget);
      expect(find.byType(AfkAppBar), findsOneWidget);
    });
  });

  group('AfkBottomNavigationBar', () {
    testWidgets('reports selected destination changes', (tester) async {
      var selected = 0;
      await tester.pumpWidget(
        MaterialApp(
          theme: AfkTheme.light(),
          home: Scaffold(
            bottomNavigationBar: StatefulBuilder(
              builder: (context, setState) => AfkBottomNavigationBar(
                selectedIndex: selected,
                onDestinationSelected: (index) =>
                    setState(() => selected = index),
                items: const [
                  AfkNavigationItem(label: 'Home', icon: Icons.home_outlined),
                  AfkNavigationItem(label: 'Search', icon: Icons.search),
                  AfkNavigationItem(label: 'Profile', icon: Icons.person_outline),
                ],
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();
      expect(selected, 1);
    });
  });


  group('AfkConfirmDialog', () {
    testWidgets('returns true when the confirm action is selected', (
      tester,
    ) async {
      bool? result;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: TextButton(
                onPressed: () async {
                  result = await AfkConfirmDialog.show(
                    context,
                    title: 'Delete item?',
                    message: 'This cannot be undone.',
                    confirmLabel: 'Delete',
                    cancelLabel: 'Cancel',
                    destructive: true,
                  );
                },
                child: const Text('Open dialog'),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Open dialog'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();
      expect(result, isTrue);
    });
  });

  group('AfkSnackBar', () {
    testWidgets('shows a localized message in the scaffold messenger', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: TextButton(
                onPressed: () => AfkSnackBar.show(
                  context,
                  message: 'Changes saved',
                  variant: AfkSnackBarVariant.success,
                ),
                child: const Text('Show feedback'),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Show feedback'));
      await tester.pump();
      expect(find.text('Changes saved'), findsOneWidget);
    });
  });


  group('AfkSearchField', () {
    testWidgets('reports input and clears the current query', (tester) async {
      final controller = TextEditingController();
      final changes = <String>[];
      await tester.pumpWidget(
        MaterialApp(
          theme: AfkTheme.light(),
          home: Scaffold(
            body: AfkSearchField(
              controller: controller,
              hintText: 'Search items',
              clearTooltip: 'Clear search',
              onChanged: changes.add,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'sample');
      await tester.pumpAndSettle();
      expect(changes.last, 'sample');
      await tester.tap(find.byTooltip('Clear search'));
      await tester.pumpAndSettle();
      expect(controller.text, isEmpty);
      expect(changes.last, isEmpty);
      controller.dispose();
    });
  });


  group('AfkProgressBar', () {
    testWidgets('shows a label and determinate percentage', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AfkProgressBar(
              value: 0.6,
              label: 'Upload',
              showValue: true,
            ),
          ),
        ),
      );
      expect(find.text('Upload'), findsOneWidget);
      expect(find.text('60%'), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });

    testWidgets('supports indeterminate progress without a value label', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AfkProgressBar(label: 'Loading', value: null)),
        ),
      );
      expect(find.text('Loading'), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });
  });

  testWidgets('AfkEmptyState shows its content', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AfkEmptyState(
            title: 'Nothing here yet',
            description: 'Your items will appear here.',
          ),
        ),
      ),
    );

    expect(find.text('Nothing here yet'), findsOneWidget);
    expect(find.text('Your items will appear here.'), findsOneWidget);
  });
}
