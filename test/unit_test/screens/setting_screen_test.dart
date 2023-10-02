import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_purple_ventures/screens/setting/setting_screen.dart';
import 'package:test_purple_ventures/values/app_dependency_injection.dart';

void main() {
  setUp(() {
    final appDependency = AppDependency.instance;
    appDependency.register(); // Register your dependencies, including RouteObserver
  });

  testWidgets('Test SettingScreen Widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SettingScreen()));
    expect(find.text('Setting'), findsOneWidget);
    expect(find.text('Edit Your Passcode'), findsOneWidget);
  });
}
