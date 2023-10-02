import 'package:flutter_test/flutter_test.dart';
import 'package:test_purple_ventures/models/response/task/task.dart';

void main() {
  Map<String, dynamic> taskAsJson = {
    "id": "1234-abcd",
    "title": "Have a rest",
    "description": "Spend an hour to have a rest",
    "createdAt": "2023-03-24T19:30:00Z", // Keep it as a String
    "status": "TODO",
  };

  Task expectTask = Task(
    id: "1234-abcd",
    title: "Have a rest",
    description: "Spend an hour to have a rest",
    createdAt: "2023-03-24T19:30:00Z", // Keep it as a String
    status: "TODO",
  );

  test('Test Task Model', () {
    var task = Task.fromJson(taskAsJson);
    expect(task.id, expectTask.id);
    expect(task.title, expectTask.title);
    expect(task.description, expectTask.description);
    expect(task.createdAt, expectTask.createdAt);
    expect(task.status, expectTask.status);
  });
}