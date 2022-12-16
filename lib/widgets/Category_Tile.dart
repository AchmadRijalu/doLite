import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CategoryTile extends StatefulWidget {
  Color color;
  String categoryName;
  final VoidCallback selectedCategory;
  bool? checkCategory;
  CategoryTile(
      {super.key,
      required this.color,
      required this.categoryName,
      required this.selectedCategory,
      required this.checkCategory});

  @override
  State<CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.selectedCategory,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(12),
        height: 40,
        decoration: BoxDecoration(
            color: widget.checkCategory!
                ? Colors.orangeAccent
                : Colors.transparent,
            border: Border.all(color: widget.color),
            borderRadius: BorderRadius.circular(12)),
        child: Row(children: [
          Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50), color: widget.color),
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            widget.categoryName,
            style:
                TextStyle(fontFamily: "Quicksand", fontWeight: FontWeight.w700),
          )
        ]),
      ),
    );
  }
}
