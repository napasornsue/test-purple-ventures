import 'dart:async';
import 'package:flutter/material.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:test_purple_ventures/screens/base/base_page_screen.dart';
import 'package:test_purple_ventures/utils/shared_preferences_manager/shared_preferences_manager.dart';
import 'package:test_purple_ventures/values/app_color.dart';
import 'package:test_purple_ventures/values/app_constant.dart';
import 'package:test_purple_ventures/values/app_dependency_injection.dart';
import 'package:test_purple_ventures/values/app_string.dart';

class EnterPasscodeScreen extends BasePageScreen {
  String? from;

  EnterPasscodeScreen({
    Key? key,
    this.from,
  }) : super(key: key);

  @override
  _EnterPasscodeScreenState createState() => _EnterPasscodeScreenState();
}

class _EnterPasscodeScreenState extends BasePageScreenState<EnterPasscodeScreen> with BaseScreen {
  final StreamController<bool> _verificationNotifier = StreamController<bool>.broadcast();
  bool isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    screenOptions(title: "Passcode");
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget body() {
    var statusBarHeight = MediaQuery.of(context).viewPadding.top;

    return WillPopScope(
      onWillPop: () async {
        if (widget.from == AppConstant.SETTING_PAGE) return true;
        return isAuthenticated;
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          PasscodeScreen(
            backgroundColor: AppColor.lightViolet,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.from == AppConstant.SETTING_PAGE ? 'Enter New Passcode' : 'Enter Your Passcode',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColor.darkGrey, fontSize: 24, fontFamily: AppString.FONT_FAMILY_BOLD),
                ),
                widget.from == AppConstant.SETTING_PAGE || AppDependency.instance.sharedPreferencesManager.get(key: SharedPreferencesKey.storedPasscode) != AppConstant.DEFAULT_PASSCODE
                    ? Container()
                    : Text(
                        'Default Passcode is ${AppConstant.DEFAULT_PASSCODE}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: AppColor.grey, fontSize: 20, fontFamily: AppString.FONT_FAMILY_MEDIUM),
                      ),
              ],
            ),
            circleUIConfig: CircleUIConfig(borderColor: AppColor.grey, fillColor: AppColor.grey, circleSize: 30),
            keyboardUIConfig: KeyboardUIConfig(
              digitFillColor: AppColor.lightGrey,
              digitBorderWidth: 0,
              digitTextStyle: const TextStyle(color: AppColor.darkGrey, fontSize: 56, fontFamily: AppString.FONT_FAMILY_REGULAR),
            ),
            cancelCallback: null,
            cancelButton: Icon(
              Icons.cancel,
              color: Colors.transparent,
            ),
            // Hide cancel button
            passwordEnteredCallback: _onPasscodeEntered,
            deleteButton: Icon(
              Icons.backspace,
              color: AppColor.darkGrey,
              size: 30,
            ),
            shouldTriggerVerification: _verificationNotifier.stream,
            digits: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'],
            passwordDigits: 6,
            isValidCallback: _isValid,
          ),
          widget.from == AppConstant.SETTING_PAGE ? Positioned(
            top: 0,
            child: GestureDetector(
              onTap: () {
                AppDependency.instance.navigatorCoordinate.back(context);
              },
              child: Container(
                margin: EdgeInsets.only(top: 16 + statusBarHeight, left: 16, bottom: 16),
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.arrow_back_ios,
                  color: AppColor.grey,
                ),
              ),
            ),
          ) : Container(),
        ],
      ),
    );
  }

  _isValid() {
    switch (widget.from) {
      case AppConstant.SPLASH_PAGE:
        AppDependency.instance.navigatorCoordinate.goToMain(context);
        break;
      case AppConstant.MAIN_PAGE:
        AppDependency.instance.navigatorCoordinate.back(context);
        break;
      case AppConstant.SETTING_PAGE:
        AppDependency.instance.navigatorCoordinate.back(context);
        break;
      default:
        AppDependency.instance.navigatorCoordinate.back(context);
        break;
    }
  }

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  _onPasscodeEntered(String enteredPasscode) {
    if (widget.from == AppConstant.SETTING_PAGE) {
      AppDependency.instance.sharedPreferencesManager.update(key: SharedPreferencesKey.storedPasscode, value: enteredPasscode);
      _verificationNotifier.add(true);
      setState(() {
        this.isAuthenticated = true;
      });
      AppDependency.instance.sharedPreferencesManager.updateBool(key: SharedPreferencesKey.isPasscodeValid, value: true);
    } else {
      String? storedPasscode = AppDependency.instance.sharedPreferencesManager.get(key: SharedPreferencesKey.storedPasscode);
      bool isValid = storedPasscode == enteredPasscode;
      _verificationNotifier.add(isValid);
      if (isValid) {
        setState(() {
          this.isAuthenticated = isValid;
        });
        AppDependency.instance.sharedPreferencesManager.updateBool(key: SharedPreferencesKey.isPasscodeValid, value: true);
      }
    }
  }
}
