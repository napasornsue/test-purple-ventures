import 'dart:convert';
import 'dart:math';

import 'package:intl/intl.dart';
import 'package:test_purple_ventures/models/response/task/task.dart';
import 'package:test_purple_ventures/values/app_constant.dart';

TaskResponse taskResponseFromJson(String str) =>
    TaskResponse.fromJson(json.decode(str));

String taskResponseToJson(TaskResponse data) => json.encode(data.toJson());

class TaskResponse {
  TaskResponse({
    this.tasks,
    this.pageNumber,
    this.totalPages
  });

  List<Task>? tasks;
  int? pageNumber;
  int? totalPages;

  factory TaskResponse.fromJson(Map<String, dynamic> json) => TaskResponse(
      tasks: List<Task>.from(json["tasks"].map((x) => Task().fromJson(x))),
      pageNumber: json["pageNumber"],
      totalPages: json["totalPages"]
  );

  fromJson(Map<String, dynamic> json) => TaskResponse(
      tasks: List<Task>.from(json["tasks"].map((x) => Task().fromJson(x))),
      pageNumber: json["pageNumber"],
      totalPages: json["totalPages"]
  );

  Map<String, dynamic> toJson() => {
    "tasks": List<dynamic>.from(tasks ?? [].map((x) => x.toJson())),
    "pageNumber": pageNumber,
    "totalPages": totalPages
  };

}