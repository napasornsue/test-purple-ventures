import 'package:flutter/material.dart';

class NavigatorCoordinate {
  NavigatorCoordinate();

  back(BuildContext context) {
    Navigator.pop(context);
  }

  backWithResult(BuildContext context, result) {
    Navigator.pop(context, result);
  }

  // goToLogin(BuildContext context) {
  //   Navigator.pushAndRemoveUntil(
  //     context,
  //     MaterialPageRoute(builder: (context) => LoginScreen()),
  //         (route) => false,
  //   );
  // }
  //
  // goToMain(BuildContext context, {
  //   String? trackId,
  //   int? selectedTab
  // }) {
  //   Navigator.pushAndRemoveUntil(
  //     context,
  //     MaterialPageRoute(builder: (context) => MainScreen(trackId: trackId, selectedTab: selectedTab)),
  //         (route) => false,
  //   );
  // }

}