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
            body: AfkButton(
              label: 'Continue',
              onPressed: () => tapped = true,
            ),
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
                AfkButton(
                  label: 'Filled',
                  onPressed: null,
                ),
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

  testWidgets(
    'AfkSectionHeader shows title, subtitle, and trailing content',
    (tester) async {
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
    },
  );

  testWidgets(
    'AfkPage applies readable width and renders its child',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AfkPage(
              child: Text('Page content'),
            ),
          ),
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
    },
  );

  testWidgets('AfkPage can disable its safe area', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AfkPage(
            safeArea: false,
            child: Text('Edge content'),
          ),
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
