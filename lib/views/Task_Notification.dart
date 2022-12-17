import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist_lite/models/toDo.dart';
import 'package:todolist_lite/services/Notification_service.dart';

class TaskNotification extends StatefulWidget {
  static final routeNames = "Task_Notification";
  const TaskNotification({Key? key}) : super(key: key);

  @override
  _TaskNotificationState createState() => _TaskNotificationState();
}

class _TaskNotificationState extends State<TaskNotification> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  late List<Todo> newTodos = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  CollectionReference<Map<String, dynamic>> getCollection() {
    return _db.collection('todo');
  }

  Stream<List<Todo>> readTodo() {
    return getCollection()
        .where('user_id', isEqualTo: auth.currentUser!.uid)
        .snapshots()
        .map((event) =>
            event.docs.map((doc) => Todo.fromJson(doc.data())).toList());
  }

  Widget buildNotif(Todo todo) {
    return Column(
      children: [
        Card(
            color: Colors.white,
            elevation: 4,
            margin: EdgeInsets.all(12),
            child: Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width * 0.90,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Wrap(
                  direction: Axis.vertical,
                  spacing: 6,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                      child: Row(
                        children: [
                          Icon(Icons.notifications, size: 24),
                          Text(
                            "AWASS!",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Text(todo.title.toString() + " sudah mendekati deadline!"),
                    Text("Segera dikerjakan ya!"),
                  ],
                ),
              ),
            )),
        SizedBox(
          height: 8,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateTime currTime = DateTime(
        now.year, now.month, now.day, now.hour, now.minute, now.second);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(),
        title: Text("Notification"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            // Text(currTime.toString()),
            Expanded(
              child: Row(children: [
                SizedBox(
                  height: 12,
                ),
                Expanded(
                    flex: 9,
                    child: Container(
                        //     child: FutureBuilder<DocumentSnapshot>(
                        //   future:
                        //       _db.collection('todo')
                        //       .doc(auth.currentUser!.uid).get(),
                        //   builder: (context, snapshot) {
                        //     if (snapshot.hasError) {
                        //       return Center(
                        //         child: Text(
                        //           "Something is Wrong! ${snapshot.error}",
                        //           textAlign: TextAlign.center,
                        //         ),
                        //       );
                        //     } else if (snapshot.hasData) {
                        //       final todo = snapshot.data!;
                        //       Map<String, dynamic> datas =
                        //           todo.data() as Map<String, dynamic>;
                        //       DateTime _now = DateTime.now();
                        //       DateTime _equalTime =
                        //           DateTime(_now.year, _now.month, _now.day, 12, 00, 00);
                        //       DateTime _duedate = datas['duedate'];
                        //       if (_duedate.difference(_equalTime).inHours == 24) {
                        //         return ListView(children: data.map(buildNotif));
                        //       }
                        //     } else {
                        //       return Center(
                        //         // child: CircularProgressIndicator(),
                        //         child: Text("Still no notification yet..."),
                        //       );
                        //     }
                        //   },
                        // )
                        // decoration: BoxDecoration(color: Colors.black),
                        child: StreamBuilder<List<Todo>>(
                      stream: readTodo(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              "Something is Wrong! ${snapshot.error}",
                              textAlign: TextAlign.center,
                            ),
                          );
                        } else if (snapshot.hasData) {
                          final todos = snapshot.data!;
                          for (var todo in todos) {
                            DateTime due = todo.duedate!;
                            int diff = due.difference(currTime).inDays;
                            if (diff <= 1) {
                              newTodos.add(todo);
                            }

                            //debug
                            // print(due.toString());
                            // print(todo.title.toString());
                            // print(diff.toString());
                          }
                          return ListView(
                              children: newTodos.map(buildNotif).toList());
                        } else if (!snapshot.hasData) {
                          print("No Notif");
                          return const Center(
                              child: Text(
                            "No Notification yet",
                            textAlign: TextAlign.center,
                          ));
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )))
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
