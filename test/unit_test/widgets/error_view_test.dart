import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_purple_ventures/widgets/error_view.dart';

void main() {
  testWidgets('Test ErrorView Widget', (WidgetTester tester) async {

    const assetImage = "assets/images/error_ic.png";
    const title = "Error Title";
    const detail = "Error detail message";
    const buttonTitle = "Retry";

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ErrorView(
            assetImage: assetImage,
            title: title,
            detail: detail,
            buttonTitle: buttonTitle,
          ),
        ),
      ),
    );

    expect(find.text(title), findsOneWidget);
    expect(find.text(detail), findsOneWidget);
    expect(find.text(buttonTitle), findsOneWidget);

    final imageFinder = find.byType(Image);
    expect(imageFinder, findsOneWidget);

    final Image imageWidget = tester.widget(imageFinder) as Image;
    expect(imageWidget.image, isA<AssetImage>());
    expect(imageWidget.image, isNotNull);

    final buttonFinder = find.byType(TextButton);
    expect(buttonFinder, findsOneWidget);
  });
}