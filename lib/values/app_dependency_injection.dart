import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:test_purple_ventures/utils/navigator_coordinate/navigator_coordinate.dart';
import 'package:test_purple_ventures/utils/network_manager/base_repository.dart';
import 'package:test_purple_ventures/utils/network_manager/network_manager.dart';
import 'package:test_purple_ventures/utils/shared_preferences_manager/shared_preferences_manager.dart';

class AppDependency {
  static AppDependency instance = AppDependency();
  final _getIt = GetIt.instance;

  AppDependency();

  NavigatorCoordinate get navigatorCoordinate => get<NavigatorCoordinate>();
  RouteObserver<ModalRoute<void>> get routeObserver => get<RouteObserver<ModalRoute<void>>>();
  NetworkManager get networkManager => get<NetworkManager>();
  BaseRepository get baseRepository => get<BaseRepository>();
  SharedPreferencesManager get sharedPreferencesManager => get<SharedPreferencesManager>();

  register() {
    _getIt.registerSingleton<NavigatorCoordinate>(NavigatorCoordinate());
    _getIt.registerSingleton<RouteObserver<ModalRoute<void>>>(RouteObserver<ModalRoute<void>>());
    _getIt.registerSingleton<NetworkManager>(NetworkManager());
    _getIt.registerSingleton<BaseRepository>(BaseRepository());
    _getIt.registerSingletonAsync<SharedPreferencesManager>(() async {
      final _prefs = SharedPreferencesManager();
      await _prefs.setPreference();
      return _prefs;
    });
  }

  Future<void> isReady<T extends Object>() {
    return _getIt.isReady<T>();
  }

  T get<T extends Object>() {
    return _getIt<T>();
  }
}