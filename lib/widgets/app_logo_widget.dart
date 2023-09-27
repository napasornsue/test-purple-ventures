import 'package:flutter/material.dart';

class AppLogoWidget extends StatefulWidget {
  const AppLogoWidget({Key? key}) : super(key: key);

  @override
  State<AppLogoWidget> createState() => _AppLogoWidgetState();
}

class _AppLogoWidgetState extends State<AppLogoWidget> {
  @override
  Widget build(BuildContext context) {
    return const Image(
      image: AssetImage("assets/images/app_logo.png"),
      width: 152,
      height: 72,
    );
  }
}
