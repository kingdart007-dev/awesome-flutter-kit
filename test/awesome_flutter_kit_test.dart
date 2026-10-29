import 'package:awesome_flutter_kit/awesome_flutter_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AfkTheme', () {
    test('creates light and dark themes', () {
      expect(AfkTheme.light().brightness, Brightness.light);
      expect(AfkTheme.dark().brightness, Brightness.dark);
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
