import 'package:flutter/material.dart';
import 'package:test_purple_ventures/screens/base/base_page_screen.dart';
import 'package:test_purple_ventures/values/app_color.dart';
import 'package:test_purple_ventures/values/app_constant.dart';
import 'package:test_purple_ventures/values/app_dependency_injection.dart';
import 'package:test_purple_ventures/values/app_string.dart';

class SettingScreen extends BasePageScreen {
  SettingScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends BasePageScreenState<SettingScreen> with BaseScreen {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget body() {
    var statusBarHeight = MediaQuery.of(context).viewPadding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: statusBarHeight),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColor.lightViolet,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: () {
                        AppDependency.instance.navigatorCoordinate.back(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 16, left: 16, bottom: 16),
                        alignment: Alignment.centerLeft,
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: AppColor.grey,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16, bottom: 16),
                    alignment: Alignment.center,
                    child: const Text(
                      "Setting",
                      style: TextStyle(
                        color: AppColor.darkGrey,
                        fontSize: 40,
                        fontFamily: AppString.FONT_FAMILY_SEMI_BOLD,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                AppDependency.instance.navigatorCoordinate.goToEnterPasscodeScreen(context, AppConstant.SETTING_PAGE);
              },
              child: Container(
                margin: const EdgeInsets.only(top: 24, left: 24, right: 24),
                height: 50,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: AppColor.moreLightGrey),
                child: const Center(
                  child: Text(
                    "Edit Your Passcode",
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: AppString.FONT_FAMILY_MEDIUM,
                      color: AppColor.grey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
