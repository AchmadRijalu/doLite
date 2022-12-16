// To parse this JSON data, do
//
//     final todo = todoFromJson(jsonString);

import 'dart:convert';

Todo todoFromJson(String str) => Todo.fromJson(json.decode(str));

String todoToJson(Todo data) => json.encode(data.toJson());

class Todo {
  Todo({
    this.category,
    this.description,
    this.duedate,
    this.id,
    this.status,
    this.title,
    this.userId,
  });

  String? category;
  String? description;
  DateTime? duedate;
  String? id;
  String? status;
  String? title;
  String? userId;

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        category: json["category"],
        description: json["description"],
        duedate: json["duedate"].toDate(),
        id: json["id"],
        status: json["status"],
        title: json["title"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "description": description,
        "duedate": duedate,
        "id": id,
        "status": status,
        "title": title,
        "user_id": userId,
      };
}
