import 'package:flutter/material.dart';

@immutable
abstract class MainEvent {}

class GetTodoListEvent with MainEvent {
  int offset;
  String status;

  GetTodoListEvent({
    required this.offset,
    required this.status
  });
}