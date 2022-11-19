import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 2,
              offset: Offset(0.8, 1.2), // Shadow position
            ),
          ],
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12)),
      width: double.infinity,
      height: 120,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
            flex: 3,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Expanded(
                        child: Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Week 1 College Tasks",
                                  style: TextStyle(
                                      fontFamily: "Quicksand",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Friday, 5 November 2022",
                                  style: TextStyle(
                                      fontFamily: "Quicksand",
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13),
                                )
                              ]),
                        ),
                      ),
                      IconButton(
                          onPressed: (() {}), icon: Icon(Icons.more_horiz))
                    ]),
                  ],
                ))),
        Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(4),
              // color: Colors.blue,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                        flex: 5,
                        child: Container(
                          child: LinearPercentIndicator(
                            lineHeight: 10,
                            percent: 0.25,
                            progressColor: Color(0XFF2D31FA),
                            backgroundColor: Colors.blue.shade100,
                          ),
                        )),
                    Expanded(
                        child: Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "25%",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontFamily: "Quicksand",
                                  fontWeight: FontWeight.w700),
                            )
                          ]),
                    ))
                  ]),
            ))
      ]),
    );
  }
}
