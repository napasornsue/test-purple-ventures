import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBlocStatus {
  const BaseBlocStatus();

  bool checkCommon(BuildContext context, BehaviorSubject<bool>? isLoading) {
    if (this is StateLoading) {
      isLoading?.add(true);
      return true;
    } else if (this is StateLoaded) {
      isLoading?.add(false);
      return true;
    } else if (this is StateFailNeedToBack) {
      isLoading?.add(false);
      return false;
    } else {
      return true;
    }
  }
}

//wait state
class BaseBlocStatusInit extends BaseBlocStatus {
  const BaseBlocStatusInit();
}

//state success
class StateSuccess extends BaseBlocStatus {
  String? from;

  StateSuccess({this.from});
}

//state login provider success
class StateLoginProviderSuccess extends BaseBlocStatus {
  final String idToken;

  StateLoginProviderSuccess(this.idToken);
}

//state fetch data success, pass data
class StateFetchSuccess<T> extends BaseBlocStatus {
  final T? models;

  StateFetchSuccess(this.models);
}

//state fail
class StateFail extends BaseBlocStatus {
  final String errorMessage;
  final dynamic? models;

  StateFail({
    required this.errorMessage,
    this.models,
  });

  @override
  String toString() {
    return errorMessage.replaceAll("Exception: ", "");
  }
}

class StateUnAuthorize extends BaseBlocStatus {}

//state start loading
class StateLoading extends BaseBlocStatus {}

//state stop load
class StateLoaded extends BaseBlocStatus {}

class StateFailNeedToBack extends BaseBlocStatus {
  final String errorMessage;
  final dynamic? models;

  StateFailNeedToBack({
    required this.errorMessage,
    this.models,
  });

  @override
  String toString() {
    return errorMessage.replaceAll("Exception: ", "");
  }
}

//state tableview empty state
class StateListEmpty extends BaseBlocStatus {}

//state tableview error state
class StateListError extends BaseBlocStatus {
  final String? title;
  final String? detail;

  StateListError({
    this.title,
    this.detail
  });
}

class StateDeleteSuccess extends BaseBlocStatus {}

class StateClearData extends BaseBlocStatus {}

class StateCancel extends BaseBlocStatus {}