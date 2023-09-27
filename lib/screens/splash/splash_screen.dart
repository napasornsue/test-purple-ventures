import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_purple_ventures/blocs/splash/splash_bloc.dart';
import 'package:test_purple_ventures/blocs/splash/splash_state.dart';
import 'package:test_purple_ventures/screens/base/base_page_screen.dart';
import 'package:test_purple_ventures/widgets/app_logo_widget.dart';
import 'package:test_purple_ventures/widgets/linear_gradient_widget.dart';

class SplashScreen extends BasePageScreen {
  SplashScreen({Key? key}): super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends BasePageScreenState<SplashScreen> with BaseScreen {
  late SplashBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = SplashBloc();
    screenOptions(title: "Splash");
    // _bloc.add(CheckForceUpdateEvent());
  }

  void _blocListener(BuildContext context, SplashState state) async {
    if (state.status.checkCommon(context, isLoading)) {
      // if (state.status is StateSuccess) {
      //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
      //   int buildNumber = int.parse(packageInfo.buildNumber);
      //
      //   if (state.model == null) {
      //     AlertManager.instance.showPopupError(context);
      //   } else if (state.model!.maintenance!.isUnderMaintenance!) {
      //     _showPopupMaintenance(state.model!.maintenance!.msg!);
      //   } else if (buildNumber < state.model!.update!.minimumForceUpdateVersion!) {
      //     _showPopupForceUpdate(state.model!.update!.forcedUpdateMsg!);
      //   } else if (buildNumber < state.model!.update!.currentVersion!) {
      //     _showPopupNeedUpdate(state.model!.update!.updateAvailableMsg!);
      //   } else {
      //     _bloc.add(GetAppConfigEvent());
      //   }
      //
      // } else if (state.status is StateFetchSuccess) {
      //   AppConfigResponse appConfigResponse = (state.status as StateFetchSuccess).models;
      //   AppDependency.instance.sharedPreferencesManager.update(key: SharedPreferencesKey.visitHelpSite, value: appConfigResponse.visitHelpSite);
      //   AppDependency.instance.sharedPreferencesManager.update(key: SharedPreferencesKey.guestToken, value: appConfigResponse.guestToken);
      //   Future.delayed(const Duration(milliseconds: 3000), () {
      //     _checkLogin();
      //   });
      //
      // } else if (state.status is StateFail) {
      //   AlertManager.instance.showPopupError(
      //       context,
      //       detail: (state.status as StateFail).errorMessage,
      //       onPress: () {
      //         _exitApp();
      //       }
      //   );
      // }
    }
  }

  @override
  Widget body() {
    double screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<SplashBloc, SplashState>(
        listener: _blocListener,
        child: BlocBuilder<SplashBloc, SplashState>(
          builder: (context, state) {
            return LinearGradientWidget(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: screenHeight / 2),
                    child: const AppLogoWidget(),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

}