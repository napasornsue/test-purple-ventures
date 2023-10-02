import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_purple_ventures/screens/main/main_screen.dart';
import 'package:test_purple_ventures/values/app_dependency_injection.dart';

void main() {
  setUp(() {
    final appDependency = AppDependency.instance;
    appDependency.register();
  });

  testWidgets('Test MainScreen Widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: MainScreen()));
    expect(find.text('To-do'), findsOneWidget);
    expect(find.text('Doing'), findsOneWidget);
    expect(find.text('Done'), findsOneWidget);
  });
}
