import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:todolist_lite/views/Task_Detail_Page.dart';

class TaskTile extends StatelessWidget {
  String? todoID;
  String? title;
  String? duedate;
  String? desc;
  String? status;
  TaskTile(
      {super.key,
      required this.todoID,
      required this.title,
      required this.duedate,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.pushNamed(context, TaskDetailPage.routeNames, arguments: {
          'todoId' : todoID
        });
      }),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(12), bottom: Radius.circular(12)),
          ),
          width: double.infinity,
          height: 75,
          child: Row(
            children: [
              Flexible(
                child: Container(
                  margin: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  width: 12,
                  height: double.infinity,
                ),
              ),
              Expanded(
                  flex: 6,
                  child: Container(
                    margin: const EdgeInsets.only(left: 16),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            "${title!}",
                            style: TextStyle(
                                fontFamily: "Quicksand",
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            child: Row(
                              children: [
                                Text(
                                  "${duedate!}",
                                  style: TextStyle(
                                      fontFamily: "Quicksand",
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13),
                                )
                              ],
                            ),
                          )
                        ]),
                  )),
              Expanded(
                  child: Container(
                width: double.infinity,
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  if (status == "Completed") ...[
                    SvgPicture.asset(
                      "assets/images/icons/check.svg",
                      width: 30,
                    )
                  ] else ...[
                    Text(
                      "${status}",
                      style: TextStyle(
                          fontFamily: "Quicksand", fontWeight: FontWeight.w500),
                    )
                  ]
                ]),
              ))
            ],
          )),
    );
  }
}
