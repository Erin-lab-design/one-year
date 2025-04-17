import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:one_year/pages/blackdot_page.dart';

void main() {
  testWidgets('BlackDotPage renders successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: BlackDotPage()));
    expect(find.byType(GridView), findsOneWidget);
  });
}
