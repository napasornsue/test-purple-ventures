import 'dart:convert';

Task taskFromJson(String str) =>
    Task.fromJson(json.decode(str));

String taskToJson(Task data) => json.encode(data.toJson());

class Task {
  Task({
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.status,
  });

  String? id;
  String? title;
  String? description;
  String? createdAt;
  String? status;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    createdAt: json["createdAt"],
    status: json["status"],
  );

  fromJson(Map<String, dynamic> json) => Task(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    createdAt: json["createdAt"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "createdAt": createdAt,
    "status": status,
  };
}