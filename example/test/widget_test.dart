import 'package:awesome_flutter_kit_example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('showcase opens and navigates between component pages', (
    tester,
  ) async {
    await tester.pumpWidget(const KitShowcaseApp());

    expect(find.text('A calmer starting point'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.tune_outlined));
    await tester.pumpAndSettle();
    expect(find.text('Input and selection'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.chat_bubble_outline));
    await tester.pumpAndSettle();
    expect(find.text('States and feedback'), findsOneWidget);
  });

  testWidgets('appearance menu offers system, light, and dark modes', (
    tester,
  ) async {
    await tester.pumpWidget(const KitShowcaseApp());

    await tester.tap(find.byIcon(Icons.contrast_outlined));
    await tester.pumpAndSettle();

    expect(find.text('System'), findsOneWidget);
    expect(find.text('Light'), findsOneWidget);
    expect(find.text('Dark'), findsOneWidget);
  });
}
