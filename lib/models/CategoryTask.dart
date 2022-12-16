import 'dart:ui';

import 'package:flutter/material.dart';

class CategoryTask {
  String? categoryName;
  Color? categoryColor;

  CategoryTask({required this.categoryColor, required this.categoryName});
}

List<CategoryTask> categoryList = [
  CategoryTask(categoryColor: Colors.red, categoryName: "Work"),
  CategoryTask(categoryColor: Colors.yellow, categoryName: "Entertainment"),
  CategoryTask(categoryColor: Colors.purple, categoryName: "Urgent"),
  CategoryTask(categoryColor: Colors.blue, categoryName: "School"),
  CategoryTask(categoryColor: Colors.green, categoryName: "Family"),
];
