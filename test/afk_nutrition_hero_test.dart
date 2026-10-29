import 'package:awesome_flutter_kit/awesome_flutter_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows calorie budget and exposes photo-first action', (tester) async {
    var added = false;
    var openedBreakdown = false;

    await tester.pumpWidget(
      MaterialApp(
        theme: AfkTheme.light(),
        home: Scaffold(
          body: AfkNutritionHero(
            title: 'Today',
            consumed: 1240,
            goal: 2100,
            consumedLabel: 'kcal eaten',
            goalLabel: 'kcal goal',
            remainingLabel: 'kcal left',
            addFoodLabel: 'Add food',
            onAddFood: () => added = true,
            breakdownLabel: 'Nutrition details',
            onViewBreakdown: () => openedBreakdown = true,
          ),
        ),
      ),
    );

    expect(find.text('Today'), findsOneWidget);
    expect(find.text('1240'), findsOneWidget);
    expect(find.text('860'), findsOneWidget);
    expect(find.text('Add food'), findsOneWidget);
    await tester.tap(find.text('Add food'));
    expect(added, isTrue);
    await tester.tap(find.byTooltip('Nutrition details'));
    expect(openedBreakdown, isTrue);
  });

  testWidgets('clearly reports when consumption exceeds the goal', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AfkNutritionHero(
            title: 'Today',
            consumed: 2300,
            goal: 2100,
            consumedLabel: 'kcal eaten',
            goalLabel: 'kcal goal',
            remainingLabel: 'kcal left',
            addFoodLabel: 'Add food',
            onAddFood: null,
          ),
        ),
      ),
    );

    expect(find.text('+200'), findsOneWidget);
    expect(find.text('over kcal goal'), findsOneWidget);
  });
}
