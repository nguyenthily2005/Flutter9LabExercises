import 'package:flutter_test/flutter_test.dart';
import 'package:lab9/main.dart';

void main() {
  testWidgets('Clima app displays weather screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ClimaApp());

    expect(find.text('28°C'), findsOneWidget);
    expect(find.text('Sunny'), findsOneWidget);
    expect(find.text('Da Nang, Vietnam'), findsOneWidget);
  });
}
