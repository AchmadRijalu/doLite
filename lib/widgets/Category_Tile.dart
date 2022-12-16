import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CategoryTile extends StatelessWidget {
  Color color;
  String categoryName;
  CategoryTile({super.key, required this.color, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        Container(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: color),
        ),
        SizedBox(
          width: 12,
        ),
        Text(categoryName)
      ]),
    );
  }
}
