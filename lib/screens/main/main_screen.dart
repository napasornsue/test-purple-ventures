import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_purple_ventures/screens/base/base_page_screen.dart';
import 'package:test_purple_ventures/utils/shared_preferences_manager/shared_preferences_manager.dart';
import 'package:test_purple_ventures/values/app_color.dart';
import 'package:test_purple_ventures/values/app_constant.dart';
import 'package:test_purple_ventures/values/app_dependency_injection.dart';
import 'package:test_purple_ventures/values/app_string.dart';

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
    var statusBarHeight = MediaQuery.of(context).viewPadding.top;

    return WillPopScope(
      onWillPop: () async {
        if (!passcodeShowing) {
          AppDependency.instance.sharedPreferencesManager.update(key: SharedPreferencesKey.appSuspendedTime, value: DateTime.now().toString());
        }
        passcodeShowing = false;
        return true;
      },
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            padding: EdgeInsets.only(top: statusBarHeight),
            child: Stack(
              children: [
                _tabBar()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tabBar() {
    return Column(
      children: [
        Stack(
          children: [
            Positioned.fill(
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: AppColor.lightViolet,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 16, bottom: 16),
                    alignment: Alignment.topRight,
                    child: Icon(Icons.settings, color: AppColor.grey,),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8),
                    child: Text(
                      "Hi! User",
                      style: const TextStyle(
                        color: AppColor.darkGrey,
                        fontSize: 40,
                        fontFamily: AppString.FONT_FAMILY_BOLD,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8, top: 8),
                    child: Text(
                      "Have a nice day.",
                      style: const TextStyle(
                        color: AppColor.darkGrey,
                        fontSize: 24,
                        fontFamily: AppString.FONT_FAMILY_BOLD,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 24),
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24), color: AppColor.moreLightGrey),
                    child: TabBar(
                      splashFactory: NoSplash.splashFactory,
                      indicatorPadding: EdgeInsets.all(8),
                      indicator: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
                          colors: <Color>[
                            AppColor.lightBlue,
                            AppColor.moreLightBlue,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: AppColor.grey,
                      tabs: [
                        Tab(
                          child: Text(
                            "To-do",
                            style: const TextStyle(
                              fontSize: 22,
                              fontFamily: AppString.FONT_FAMILY_MEDIUM,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Doing",
                            style: const TextStyle(
                              fontSize: 22,
                              fontFamily: AppString.FONT_FAMILY_MEDIUM,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Done",
                            style: const TextStyle(
                              fontSize: 22,
                              fontFamily: AppString.FONT_FAMILY_MEDIUM,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Expanded(
          child: TabBarView(children: [
            _tabBarView("It's cloudy here"),
            _tabBarView("It's rainy here"),
            _tabBarView("It's sunny here"),
          ]),
        )
      ],
    );
  }

  Widget _tabBarView(String type) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 24),
      itemCount: 9, // The number of items in your list
      itemBuilder: (context, index) {
        // Build each item in the list based on the index
        int randomNumber = (Random().nextInt(9) + 1);

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (index % 2 == 0) ? Container(
                margin: EdgeInsets.only(top: 30),
                child: Text(
                  "Tomorrow",
                  style: const TextStyle(
                    color: AppColor.dimBlack,
                    fontSize: 24,
                    fontFamily: AppString.FONT_FAMILY_BOLD,
                  ),
                ),
              ) : Container(),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    Image(
                      width: 48,
                      height: 48,
                      image: AssetImage("assets/images/task$randomNumber.png"),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Title",
                            style: const TextStyle(
                              color: AppColor.dimBlack,
                              fontSize: 22,
                              fontFamily: AppString.FONT_FAMILY_SEMI_BOLD,
                            ),
                          ),
                          Text(
                            "Description",
                            style: const TextStyle(
                              color: AppColor.grey,
                              fontSize: 18,
                              fontFamily: AppString.FONT_FAMILY_REGULAR,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }


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