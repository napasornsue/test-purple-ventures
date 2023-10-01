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

  int elapsedTimeInSeconds = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Future.delayed(const Duration(milliseconds: 2000), () {
      AppDependency.instance.sharedPreferencesManager.update(key: SharedPreferencesKey.storedPasscode, value: AppConstant.DEFAULT_PASSCODE);
      _checkAppPauseTime();
    });
  }

  @override
  Widget body() {
    return Container(
      color: AppColor.lightViolet,
      child: const Center(
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
    if (appSuspendedTime != null) {
      final currentTime = DateTime.now();
      final duration = currentTime.difference(appSuspendedTime!);
      elapsedTimeInSeconds = duration.inSeconds;

      bool? isPasscodeValid = AppDependency.instance.sharedPreferencesManager.getBool(key: SharedPreferencesKey.isPasscodeValid);

      if (elapsedTimeInSeconds >= 10 || isPasscodeValid == false) {
        AppDependency.instance.sharedPreferencesManager.updateBool(key: SharedPreferencesKey.isPasscodeValid, value: false);
        AppDependency.instance.navigatorCoordinate.goToEnterPasscodeScreen(context, AppConstant.SPLASH_PAGE);
      } else {
        AppDependency.instance.navigatorCoordinate.goToMain(context);
      }
    } else {
      AppDependency.instance.navigatorCoordinate.goToEnterPasscodeScreen(context, AppConstant.SPLASH_PAGE);
    }
  }
}