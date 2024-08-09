import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mqu_app/boost_of_caffeine.dart';
import 'package:mqu_app/order_screen.dart';
// Import your main.dart file

void main() {
  group('BoostOfCaffeinePage widget tests', () {
    testWidgets('Widget renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: BoostOfCaffeinePage(),
      ));

      expect(find.byType(BoostOfCaffeinePage), findsOneWidget);
    });

    testWidgets('DropdownButton changes value when clicked',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: BoostOfCaffeinePage(),
      ));

      // Wait for the dropdown button to appear
      await tester.pumpAndSettle();

      final dropdownFinder = find.byType(DropdownButtonFormField<String>);
      expect(dropdownFinder, findsOneWidget);

      // Open dropdown
      await tester.tap(dropdownFinder);
      await tester.pumpAndSettle();

      // Tap on an item
      await tester.tap(find.text('ESC Cafe, RPD').last);
      await tester.pumpAndSettle();

      // Verify selected value
      expect(find.text('ESC Cafe, RPD'), findsOneWidget);
    });

    testWidgets('ElevatedButton navigates to OrderScreen when clicked',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: BoostOfCaffeinePage(),
      ));

      // Open dropdown and select a cafe
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cult Eatery, 25 WW').last);
      await tester.pumpAndSettle();

      // Tap Confirm button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Verify navigation to OrderScreen
      expect(find.byType(OrderScreen), findsOneWidget);
    });
  });
}
