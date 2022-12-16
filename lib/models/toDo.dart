import 'dart:convert';

import 'package:intl/intl.dart';

ToDo toDoFromJson(String str) => ToDo.fromJson(json.decode(str));

String toDoToJson(ToDo data) => json.encode(data.toJson());

class ToDo {
  ToDo({
    required this.category,
    required this.description,
    required this.duedate,
    required this.title,
  });

  String category;
  String description;
  DateTime duedate;
  String title;

  factory ToDo.fromJson(Map<String, dynamic> json) => ToDo(
        category: json["Category"],
        description: json["description"],
        duedate: json["duedate"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "Category": category,
        "description": description,
        "duedate": duedate,
        "title": title,
      };
}
