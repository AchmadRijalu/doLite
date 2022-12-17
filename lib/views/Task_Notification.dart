import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist_lite/services/Notification_service.dart';

class TaskNotification extends StatefulWidget {
  static final routeNames = "Task_Notification";
  const TaskNotification({Key? key}) : super(key: key);

  @override
  _TaskNotificationState createState() => _TaskNotificationState();
}

class _TaskNotificationState extends State<TaskNotification> {
  late final LocalNotificationService notifService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifService = LocalNotificationService();
    notifService.intialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(),
        title: Text("Notification"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          child: ElevatedButton(
            onPressed: () async {
              await notifService.showNotification(
                  id: 1,
                  title: "Congratulations!",
                  body: "You have made a new todo list!");
            },
            child: const Text("Click to add a new notification"),
          ),
          decoration: BoxDecoration(color: Colors.white),
        ),
      ),
    );
  }
}
