import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab6_quizzler/main.dart';

void main() {
  testWidgets('Quizzler shows the first question and answer buttons',
      (WidgetTester tester) async {
    await tester.pumpWidget(const QuizzlerApp());

    expect(find.text('Bananas are berries, but strawberries are not.'),
        findsOneWidget);
    expect(find.text('True'), findsOneWidget);
    expect(find.text('False'), findsOneWidget);
  });

  testWidgets('Selecting an answer adds a score icon',
      (WidgetTester tester) async {
    await tester.pumpWidget(const QuizzlerApp());

    await tester.tap(find.text('True'));
    await tester.pump();

    expect(find.byIcon(Icons.check), findsOneWidget);
  });
}
