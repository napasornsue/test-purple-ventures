import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_purple_ventures/blocs/base/base_bloc_status.dart';
import 'package:test_purple_ventures/blocs/splash/splash_event.dart';
import 'package:test_purple_ventures/blocs/splash/splash_state.dart';
import 'package:test_purple_ventures/values/app_dependency_injection.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(): super(SplashStateInitial()) {
    // on<CheckForceUpdateEvent>(_mapEventCheckForceUpdate);
    // on<GetAppConfigEvent>(_mapEventGetAppConfig);
  }

  // void _mapEventCheckForceUpdate(CheckForceUpdateEvent event, Emitter<SplashState> emit) async {
  //   emit(await _checkForceUpdate());
  // }
  //
  // void _mapEventGetAppConfig(GetAppConfigEvent event, Emitter<SplashState> emit) async {
  //   emit(await _willGetAppConfig());
  // }

  // Future<SplashState> _checkForceUpdate() => AppDependency.instance.baseRepository.checkForceUpdate(platform: Platform.operatingSystem)!.then((networkResponse) {
  //   final value = networkResponse.response;
  //   return state.copyWith(
  //     model: value?.responseObject,
  //     status: networkResponse.status,
  //   );
  // }).onError((error, stackTrace) {
  //   return state.copyWith(status: StateFail(errorMessage: error.toString()));
  // });
  //
  // Future<SplashState> _willGetAppConfig() => AppDependency.instance.baseRepository.getAppConfig()!
  //     .then((resp) => state.copyWith(status: StateFetchSuccess(resp.response?.responseObject)))
  //     .onError((error, stackTrace) => state.copyWith(status: StateFail(errorMessage: error.toString())));
}