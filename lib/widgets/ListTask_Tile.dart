import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todolist_lite/models/Task.dart';

class ListTaskTile extends StatefulWidget {
  String? id;
  String? name;

  final Function(int) onClick;
  ListTaskTile(
      {super.key, required this.name, required this.id, required this.onClick});

  @override
  State<ListTaskTile> createState() => _ListTaskTileState();
}

class _ListTaskTileState extends State<ListTaskTile> {
  callback() {
    setState(() {
      listTask;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.only(bottom: 12),
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.name!),
            GestureDetector(
              onTap: (() {
                // setState(() {
                //   listTask.removeAt(int.parse(widget.id!));
                // });
                setState(() {
                  widget.onClick(int.parse(widget.id!));
                });
              }),
              child: Icon(
                Icons.close,
                color: Colors.red,
              ),
            )
          ]),
    );
  }
}
