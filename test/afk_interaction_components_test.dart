import 'package:awesome_flutter_kit/awesome_flutter_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AfkButton', () {
    testWidgets('invokes the action when enabled', (tester) async {
      var pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AfkTheme.light(),
          home: Scaffold(
            body: AfkButton(
              label: 'Continue',
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Continue'));
      expect(pressed, isTrue);
    });

    testWidgets('prevents repeated actions while loading', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AfkTheme.light(),
          home: const Scaffold(
            body: AfkButton(
              label: 'Saving',
              onPressed: null,
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.text('Saving'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
          isNull);
    });
  });

  group('AfkPressable', () {
    testWidgets('reports a tap without owning the host action', (
      tester,
    ) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AfkPressable(
              onTap: () => tapped = true,
              child: const Text('Open details'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open details'));
      expect(tapped, isTrue);
    });

    testWidgets('supports reduced motion without throwing', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(disableAnimations: true),
            child: Scaffold(
              body: AfkPressable(
                onTap: () => tapped = true,
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pump();
      expect(tapped, isTrue);
      expect(tester.takeException(), isNull);
    });
  });

  group('AfkTextField', () {
    testWidgets('renders helper and validation text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AfkTheme.light(),
          home: const Scaffold(
            body: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  AfkTextField(
                    label: 'Email address',
                    helperText: 'Use your work email',
                  ),
                  AfkTextField(
                    label: 'Password',
                    errorText: 'Password is required',
                    obscureText: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Email address'), findsOneWidget);
      expect(find.text('Use your work email'), findsOneWidget);
      expect(find.text('Password is required'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });

  group('AfkBottomSheet', () {
    testWidgets('presents content and closes through navigator', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AfkTheme.light(),
          home: Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: FilledButton(
                  onPressed: () => AfkBottomSheet.show<void>(
                    context,
                    builder: (sheetContext) => AfkBottomSheet.content(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Sheet content'),
                          TextButton(
                            onPressed: () => Navigator.of(sheetContext).pop(),
                            child: const Text('Close sheet'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  child: const Text('Open sheet'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open sheet'));
      await tester.pumpAndSettle();
      expect(find.text('Sheet content'), findsOneWidget);

      await tester.tap(find.text('Close sheet'));
      await tester.pumpAndSettle();
      expect(find.text('Sheet content'), findsNothing);
      expect(tester.takeException(), isNull);
    });
  });
}
