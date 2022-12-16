import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TaskDetailPage extends StatefulWidget {
  static const routeNames = "/TaskDetails";
  const TaskDetailPage({super.key});

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF2D31FA),
        title: Text("Task Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(children: [
            LinearPercentIndicator(
              lineHeight: 10,
              percent: 0.25,
              progressColor: Color(0XFF2D31FA),
              backgroundColor: Colors.blue.shade100,
            ),
          ]),
        ),
      ),
    );
  }
}
