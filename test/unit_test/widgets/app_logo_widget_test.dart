import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_purple_ventures/widgets/app_logo_widget.dart';

void main() {
  testWidgets('Test AppLogo Widget', (WidgetTester tester) async {

    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: AppLogoWidget(),
      ),
    ));

    final imageFinder = find.byWidgetPredicate(
          (widget) => widget is Image && widget.image is AssetImage,
    );

    expect(imageFinder, findsOneWidget);

    final Image imageWidget = tester.widget(imageFinder) as Image;
    expect(imageWidget.width, 152);
    expect(imageWidget.height, 72);

    final AssetImage assetImage = imageWidget.image as AssetImage;
    expect(assetImage.assetName, "assets/images/app_logo.png");
  });
}
