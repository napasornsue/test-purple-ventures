import 'package:flutter/material.dart';
import 'package:test_purple_ventures/screens/splash/splash_screen.dart';
import 'package:test_purple_ventures/values/app_config.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.APP_NAME,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}