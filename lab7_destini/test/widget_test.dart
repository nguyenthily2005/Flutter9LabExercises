// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:lab7_destini/main.dart';

void main() {
  testWidgets('shows the initial story and choices', (tester) async {
    await tester.pumpWidget(const DestiniApp());

    expect(
      find.text(
        'Bạn đứng trước một ngã rẽ trong rừng, một con đường dẫn vào bóng tối, một con đường sáng hơn. Bạn sẽ đi đâu?',
      ),
      findsOneWidget,
    );
    expect(find.text('Đi vào bóng tối'), findsOneWidget);
    expect(find.text('Đi vào con đường sáng'), findsOneWidget);
    expect(find.text('Quay lại'), findsOneWidget);
    expect(find.text('Restart'), findsNothing);
  });

  testWidgets('selecting a choice moves to the next story and undo restores it',
      (tester) async {
    await tester.pumpWidget(const DestiniApp());

    await tester.tap(find.text('Đi vào bóng tối'));
    await tester.pump();

    expect(
      find.text(
        'Con đường tối tăm khiến bạn cảm thấy lạnh lẽo. Bỗng nhiên, bạn nghe thấy tiếng động lạ.',
      ),
      findsOneWidget,
    );
    expect(find.text('Đi về phía tiếng động'), findsOneWidget);
    expect(find.text('Bỏ đi và tiếp tục đi'), findsOneWidget);

    await tester.tap(find.text('Quay lại'));
    await tester.pump();

    expect(
      find.text(
        'Bạn đứng trước một ngã rẽ trong rừng, một con đường dẫn vào bóng tối, một con đường sáng hơn. Bạn sẽ đi đâu?',
      ),
      findsOneWidget,
    );
  });
}
