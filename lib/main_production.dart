import 'package:flutter/material.dart';
import 'package:test_purple_ventures/main.dart';
import 'package:test_purple_ventures/values/app_config.dart';
import 'package:test_purple_ventures/values/app_dependency_injection.dart';

void main() async {
  AppConfig.ENVIRONMENT = EnvironmentType.Production;
  AppDependency.instance.register();
  runApp(const MyApp());
}