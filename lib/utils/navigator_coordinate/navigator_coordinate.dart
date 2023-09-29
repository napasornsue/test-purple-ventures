import 'package:flutter/material.dart';
import 'package:test_purple_ventures/screens/main/main_screen.dart';
import 'package:test_purple_ventures/screens/passcode/enter_passcode_screen.dart';

class NavigatorCoordinate {
  NavigatorCoordinate();

  back(BuildContext context) {
    Navigator.maybePop(context);
  }

  backWithResult(BuildContext context, result) {
    Navigator.maybePop(context, result);
  }

  goToMain(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()),
          (route) => false,
    );
  }

  goToEnterPasscodeScreen(BuildContext context, String from) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EnterPasscodeScreen(from: from),
      ),
    );
  }

}