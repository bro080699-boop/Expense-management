import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:expense_management_task/controllers/theme_controller.dart';
import 'package:expense_management_task/main.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    Get.reset();
    Get.put(ThemeController());
  });

  testWidgets('Expense tracker home screen test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Daily Expense Tracker'), findsOneWidget);
    expect(find.text('Analytics'), findsOneWidget);
    expect(find.text('No expenses found'), findsOneWidget);
  });

  testWidgets('Add expense form validation test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Add'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Save Expense'));
    await tester.pump();

    expect(find.text('Please enter title'), findsOneWidget);
    expect(find.text('Please enter amount'), findsOneWidget);
  });
}
