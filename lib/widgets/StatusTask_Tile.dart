import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatusTaskTile extends StatefulWidget {
  String? name;
  String? image;
  final VoidCallback selected;
  bool? check;

  StatusTaskTile(
      {super.key,
      required this.name,
      this.image,
      required this.selected,
      this.check});

  @override
  State<StatusTaskTile> createState() => _StatusTaskTileState();
}

class _StatusTaskTileState extends State<StatusTaskTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.selected,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
            color: widget.check! ? Colors.yellow : Colors.transparent,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(12)),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (widget.image == null) ...[
            SvgPicture.asset(""),
          ] else ...[
            SvgPicture.asset(
              widget.image!,
              width: 20,
            ),
          ],
          SizedBox(
            width: 4,
          ),
          Text(
            widget.name!,
            style:
                TextStyle(fontFamily: "Quicksand", fontWeight: FontWeight.w700),
          )
        ]),
      ),
    );
  }
}
