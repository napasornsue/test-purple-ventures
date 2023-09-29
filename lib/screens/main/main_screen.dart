import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_purple_ventures/screens/base/base_page_screen.dart';
import 'package:test_purple_ventures/utils/shared_preferences_manager/shared_preferences_manager.dart';
import 'package:test_purple_ventures/values/app_color.dart';
import 'package:test_purple_ventures/values/app_constant.dart';
import 'package:test_purple_ventures/values/app_dependency_injection.dart';

class MainScreen extends BasePageScreen {

  MainScreen({
    Key? key,
  }): super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends BasePageScreenState<MainScreen> with BaseScreen {

  DateTime? appSuspendedTime;
  int elapsedTimeInSeconds = 0;
  final StreamController<bool> _verificationNotifier = StreamController<bool>.broadcast();
  bool passcodeShowing = false;

  @override
  void initState() {
    super.initState();
    screenOptions(title: "Main");
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget body() {
    return WillPopScope(
      onWillPop: () async {
        if (!passcodeShowing) {
          AppDependency.instance.sharedPreferencesManager.update(key: SharedPreferencesKey.appSuspendedTime, value: DateTime.now().toString());
        }
        passcodeShowing = false;
        return true;
      },
      child: Container(
        color: AppColor.dimBlack,
        child: DefaultTabController(
          length: 3,
          child: Stack(
            children: [
              _mainMenu(),
              _createButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mainMenu() => Scaffold(
    appBar: AppBar(
      title: const Text('TabBar Sample'),
      bottom: const TabBar(
        tabs: <Widget>[
          Tab(
            icon: Icon(Icons.cloud_outlined),
          ),
          Tab(
            icon: Icon(Icons.beach_access_sharp),
          ),
          Tab(
            icon: Icon(Icons.brightness_5_sharp),
          ),
        ],
      ),
    ),
    body: const TabBarView(
      children: <Widget>[
        Center(
          child: Text("It's cloudy here"),
        ),
        Center(
          child: Text("It's rainy here"),
        ),
        Center(
          child: Text("It's sunny here"),
        ),
      ],
    ),
  );

  Widget _createButton() => Align(
    alignment: Alignment.bottomCenter,
    child: Material(
      color: Colors.transparent,
      child: Container(
        width: 72,
        height: 72,
        decoration: const BoxDecoration(
          color: AppColor.blueSecond,
          shape: BoxShape.circle,
        ),
        // child: IconButton(
        //   onPressed: () {
        //
        //   },
        //   icon: const Image(
        //     image: AssetImage("assets/images/add_ic.png"),
        //     width: 24,
        //     height: 24,
        //   ),
        //   iconSize: 40,
        // ),
      ),
    ),
  );

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    String? appSuspendedTimeString = AppDependency.instance.sharedPreferencesManager.get(key: SharedPreferencesKey.appSuspendedTime);
    DateTime? appSuspendedTime = appSuspendedTimeString != null ? DateTime.parse(appSuspendedTimeString) : null;
    if (state == AppLifecycleState.paused) {
      AppDependency.instance.sharedPreferencesManager.update(key: SharedPreferencesKey.appSuspendedTime, value: dateFormat.format(DateTime.now()));
      passcodeShowing = false;
    } else if (state == AppLifecycleState.resumed && appSuspendedTime != null) {
      _checkAppPauseTime();
    }
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
      if (!passcodeShowing) {
        AppDependency.instance.navigatorCoordinate.goToEnterPasscodeScreen(context, AppConstant.MAIN_PAGE);
        passcodeShowing = true;
      }
    }
  }
}