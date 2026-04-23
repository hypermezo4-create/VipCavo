import 'package:deadzon/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App renders Deadzon shell', (WidgetTester tester) async {
    await tester.pumpWidget(const DeadzonApp());
    await tester.pumpAndSettle();

    expect(find.text('Deadzon'), findsWidgets);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Statusbar'), findsOneWidget);
    expect(find.text('Mount'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });
}
