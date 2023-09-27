import 'package:flutter/material.dart';

@immutable
abstract class SplashEvent {}

class CheckForceUpdateEvent with SplashEvent {
  CheckForceUpdateEvent();
}

class GetAppConfigEvent with SplashEvent {
  GetAppConfigEvent();
}