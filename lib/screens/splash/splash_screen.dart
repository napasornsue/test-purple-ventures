import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_purple_ventures/screens/base/base_page_screen.dart';
import 'package:test_purple_ventures/utils/shared_preferences_manager/shared_preferences_manager.dart';
import 'package:test_purple_ventures/values/app_color.dart';
import 'package:test_purple_ventures/values/app_constant.dart';
import 'package:test_purple_ventures/values/app_dependency_injection.dart';

class SplashScreen extends BasePageScreen {

  SplashScreen({
    Key? key,
  }): super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends BasePageScreenState<SplashScreen> with BaseScreen {

  DateTime? appSuspendedTime;
  int elapsedTimeInSeconds = 0;

  @override
  void initState() {
    super.initState();
    screenOptions(title: "Splash");
    WidgetsBinding.instance.addObserver(this);
    Future.delayed(const Duration(milliseconds: 2000), () {
      _checkAppPauseTime();
    });
  }

  @override
  Widget body() {
    return Container(
      color: AppColor.lightViolet,
      child: Center(
        child: Image(
          image: AssetImage("assets/images/app_logo.png"),
          width: 100,
          height: 100,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  _checkAppPauseTime() {
    String? appSuspendedTimeString = AppDependency.instance.sharedPreferencesManager.get(key: SharedPreferencesKey.appSuspendedTime);
    DateTime? appSuspendedTime = appSuspendedTimeString != null ? DateTime.parse(appSuspendedTimeString) : null;
    final currentTime = DateTime.now();
    final duration = currentTime.difference(appSuspendedTime!);
    elapsedTimeInSeconds = duration.inSeconds;

    // Check if the app was killed for at least 10 seconds
    bool? isPasscodeValid = AppDependency.instance.sharedPreferencesManager.getBool(key: SharedPreferencesKey.isPasscodeValid);

    if (elapsedTimeInSeconds >= 10 || isPasscodeValid == false) {
      AppDependency.instance.sharedPreferencesManager.updateBool(key: SharedPreferencesKey.isPasscodeValid, value: false);
      AppDependency.instance.navigatorCoordinate.goToEnterPasscodeScreen(context, AppConstant.SPLASH_PAGE);
    } else {
      AppDependency.instance.navigatorCoordinate.goToMain(context);
    }
  }
}