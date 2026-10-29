import 'package:awesome_flutter_kit/awesome_flutter_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AfkTheme', () {
    test('creates light and dark themes', () {
      expect(AfkTheme.light().brightness, Brightness.light);
      expect(AfkTheme.dark().brightness, Brightness.dark);
    });
  });

  testWidgets('AfkButton exposes its label and responds to taps', (tester) async {
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
