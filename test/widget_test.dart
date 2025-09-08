import 'package:flutter_test/flutter_test.dart';

import 'package:task_manager/main.dart';

void main() {
  testWidgets('Task Manager App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const TaskManagerApp());

    expect(find.text('Task Manager'), findsOneWidget);
    expect(find.text('Firebase Connected!'), findsOneWidget);
    expect(find.text('Task Manager App is ready'), findsOneWidget);
  });
}
