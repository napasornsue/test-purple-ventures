import 'package:flutter_test/flutter_test.dart';
import 'package:test_purple_ventures/models/response/task/task.dart';
import 'package:test_purple_ventures/models/response/task/task_response.dart';

void main() {
  Map<String, dynamic> taskResponseAsJson = {
    "tasks": [
      {
        "id": "cbb0732a-c9ab-4855-b66f-786cd41a3cd1",
        "title": "Read a book",
        "description": "Spend an hour reading a book for pleasure",
        "createdAt": "2023-03-24T19:30:00Z",
        "status": "DOING"
      },
    ],
    "pageNumber": 0,
    "totalPages": 1
  };

  TaskResponse expectTaskResponse = TaskResponse(
    tasks: [
      Task(
        id: "cbb0732a-c9ab-4855-b66f-786cd41a3cd1",
        title: "Read a book",
        description: "Spend an hour reading a book for pleasure",
        createdAt: "2023-03-24T19:30:00Z",
        status: "DOING",
      ),
    ],
    pageNumber: 0,
    totalPages: 1,
  );

  test('Test TaskResponse Model', () {
    var taskResponse = TaskResponse.fromJson(taskResponseAsJson);
    taskResponse.tasks?.forEach((task) {
      var expectTask = expectTaskResponse.tasks?.firstWhere((expectTask) => expectTask.id == task.id);
      expect(task.id, expectTask?.id);
      expect(task.title, expectTask?.title);
      expect(task.description, expectTask?.description);
      expect(task.createdAt, expectTask?.createdAt);
      expect(task.status, expectTask?.status);
    });
    expect(taskResponse.pageNumber, expectTaskResponse.pageNumber);
    expect(taskResponse.totalPages, expectTaskResponse.totalPages);
  });
}