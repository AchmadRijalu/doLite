import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TaskView extends StatelessWidget {
  static final routeNames = "Task";
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: Row(children: [
                  Expanded(
                      child: Container(
                          child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          "assets/images/crazy scientist.png",
                          width: 50,
                        ),
                      ),
                    ],
                  ))),
                  Expanded(
                      child: Container(
                          child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(onPressed: (() {}), icon: Icon(Icons.search)),
                      IconButton(
                          onPressed: (() {}),
                          icon: Icon(Icons.notifications_none_outlined)),
                      IconButton(
                          onPressed: (() {}), icon: Icon(Icons.more_horiz))
                    ],
                  ))),
                ]),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                child: Row(children: [
                  Text(
                    "My Tasks",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  )
                ]),
              )
            ],
          )),
        ),
      ),
    );
  }
}
