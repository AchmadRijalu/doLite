import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              "Detail",
              style: TextStyle(
                  fontFamily: "Quicksand",
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
          ]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Title',style: TextStyle(
                  fontFamily: "Quicksand",
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 16),),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Mengerjakan UI/UX',style: TextStyle(
                  fontFamily: "Quicksand",
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 18),),
                ),
                SizedBox(
                  height: 38,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Due Date',style: TextStyle(
                  fontFamily: "Quicksand",
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 16),),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('22 Desember 2022',style: TextStyle(
                  fontFamily: "Quicksand",
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 18),),
                ),
                SizedBox(
                  height: 38,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Description',style: TextStyle(
                  fontFamily: "Quicksand",
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 16),),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Menggunakan Figma',style: TextStyle(
                  fontFamily: "Quicksand",
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 18),),
                ),
              ]),)
        ),
      ),
    );
  }
}
