import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBlocStatus {
  const BaseBlocStatus();
}

class BaseBlocStatusInit extends BaseBlocStatus {
  const BaseBlocStatusInit();
}

class StateSuccess extends BaseBlocStatus {
  String? from;

  StateSuccess({this.from});
}

class StateFail extends BaseBlocStatus {
  final String? errorMessage;

  StateFail({
    this.errorMessage,
  });

  @override
  String toString() {
    return errorMessage?.replaceAll("Exception: ", "") ?? "";
  }
}