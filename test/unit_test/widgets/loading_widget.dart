import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_purple_ventures/values/app_color.dart';
import 'package:test_purple_ventures/widgets/loading_widget.dart';

void main() {
  testWidgets('Test Loading Widget', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: LoadingWidget(),
        ),
      ),
    );

    final circularProgressIndicatorFinder = find.byType(CircularProgressIndicator);

    expect(circularProgressIndicatorFinder, findsOneWidget);

    final CircularProgressIndicator circularProgressIndicatorWidget =
    tester.widget(circularProgressIndicatorFinder) as CircularProgressIndicator;

    expect(circularProgressIndicatorWidget.backgroundColor, AppColor.lightBlue);
  });
}
