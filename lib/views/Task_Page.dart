import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todolist_lite/widgets/Task_Tile.dart';

class TaskPage extends StatelessWidget {
  static final routeNames = "Task";
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0XFF2D31FA),
        child: Icon(Icons.add),
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(4)),
        onPressed: () {},
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Container(
                  // color: Colors.red,
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
                        IconButton(
                            onPressed: (() {}), icon: Icon(Icons.search)),
                        IconButton(
                            onPressed: (() {}),
                            icon: Icon(Icons.notifications_none_outlined)),
                        IconButton(
                            onPressed: (() {}), icon: Icon(Icons.more_horiz))
                      ],
                    ))),
                  ]),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Flexible(
                child: Container(
                  child: Row(children: [
                    Text(
                      "My Tasks",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Quicksand"),
                    )
                  ]),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Expanded(
                  flex: 9,
                  child: Container(
                    child: Column(children: [TaskTile()]),
                  ))
            ],
          )),
        ),
      ),
    );
  }
}