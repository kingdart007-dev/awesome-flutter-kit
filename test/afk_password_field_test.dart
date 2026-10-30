import 'package:awesome_flutter_kit/awesome_flutter_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AfkPasswordField masks by default and toggles visibility', (
    tester,
  ) async {
    final controller = TextEditingController(text: 'secret123');
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      MaterialApp(
        theme: AfkTheme.light(),
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: AfkPasswordField(
              label: 'Password',
              showPasswordLabel: 'Show password',
              hidePasswordLabel: 'Hide password',
              controller: controller,
            ),
          ),
        ),
      ),
    );

    final field = tester.widget<TextFormField>(find.byType(TextFormField));
    expect(field.obscureText, isTrue);
    expect(find.byTooltip('Show password'), findsOneWidget);

    await tester.tap(find.byTooltip('Show password'));
    await tester.pump();

    final visibleField = tester.widget<TextFormField>(
      find.byType(TextFormField),
    );
    expect(visibleField.obscureText, isFalse);
    expect(find.byTooltip('Hide password'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('AfkPasswordField disables visibility control when disabled', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AfkTheme.light(),
        home: const Scaffold(
          body: AfkPasswordField(
            label: 'Password',
            showPasswordLabel: 'Show password',
            hidePasswordLabel: 'Hide password',
            enabled: false,
          ),
        ),
      ),
    );

    final toggle = tester.widget<IconButton>(
      find.ancestor(
        of: find.byTooltip('Show password'),
        matching: find.byType(IconButton),
      ),
    );
    expect(toggle.onPressed, isNull);
  });
}
