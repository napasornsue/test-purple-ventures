import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test_purple_ventures/utils/navigator_coordinate/navigator_coordinate.dart';
import 'package:test_purple_ventures/values/app_dependency_injection.dart';
import 'package:test_purple_ventures/widgets/loading_widget.dart';

abstract class BasePageScreen extends StatefulWidget {
  BasePageScreen({Key? key}): super(key: key);
}

abstract class BasePageScreenState<Page extends BasePageScreen> extends State<Page> with RouteAware, WidgetsBindingObserver {

  String? title;
  bool? showNavigator;
  bool? showBack;
  List<Widget>? rightButtons;
  BehaviorSubject<bool>? isLoading;

  void screenOptions({
    String? title,
    bool? showNavigator,
    bool? showBack,
    List<Widget>? rightButtons,
  }) {
    this.title = title ?? this.title;
    this.showNavigator = showNavigator ?? this.showNavigator;
    this.showBack = showBack ?? this.showBack;
    this.rightButtons = rightButtons ?? this.rightButtons;
  }
}

mixin BaseScreen<Page extends BasePageScreen, STATE, EVENT> on BasePageScreenState<Page> {
  BehaviorSubject<bool>? isLoading;

  NavigatorCoordinate get navigatorCoordinate {
    return AppDependency.instance.navigatorCoordinate;
  }

  @override
  void initState() {
    super.initState();
    isLoading = BehaviorSubject<bool>.seeded(false);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppDependency.instance.routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    isLoading?.close();
    AppDependency.instance.routeObserver.unsubscribe(this);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Stack(
      children: [
        body(),
        _layerLoading(),
      ],
    );
  }

  Widget body();

  Widget _layerLoading() => StreamBuilder<bool>(
      stream: isLoading!.stream,
      builder: (context, snapshot) {
        return snapshot.data ?? false
            ? LoadingWidget()
            : const SizedBox(
          width: 1,
          height: 1,
        );
      });

}