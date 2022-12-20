import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:todolist_lite/models/item.dart';
import 'package:todolist_lite/models/toDo.dart';
import 'package:todolist_lite/views/Add_Task_Page.dart';
import 'package:todolist_lite/views/Task_Notification.dart';
import 'package:todolist_lite/widgets/Task_Tile.dart';
import 'package:url_launcher/url_launcher.dart';

class TaskPage extends StatefulWidget {
  static final routeNames = "Task";
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  bool dark = false;
  late TabController _tabController;
  Future signOut() async {
    Firebase.initializeApp();
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut().then((value) {});
  }

  //  void initState() {
  //   _tabController = TabController(length: 2, vsync: this);
  //   super.initState();
  // }

  _openSourceCode() async {
    var url = Uri.parse('https://github.com/AchmadRijalu/doLite');

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw "Could not launch $url";
    }
  }

  //show dialog
  Future<void> _showFluidDialog() async {
    return showDialog<void>(
      context: context,
      builder: (context) => FluidDialog(
        sizeDuration: const Duration(milliseconds: 300),
        alignmentDuration: const Duration(milliseconds: 600),
        transitionDuration: const Duration(milliseconds: 300),
        // Set the first page of the dialog.
        rootPage: FluidDialogPage(
          alignment: Alignment.topRight, //Aligns the dialog to the bottom left.
          builder: (context) {
            return Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
              height: 130,
              padding: const EdgeInsets.all(16),
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton.icon(
                        onPressed: (() async {
                          await _openSourceCode();
                          DialogNavigator.of(context).close();
                        }),
                        icon: Icon(Icons.code),
                        label: Text("Source")),
                    TextButton.icon(
                        onPressed: (() {
                          signOut();
                          DialogNavigator.of(context).close();
                        }),
                        icon: Icon(Icons.logout),
                        label: Text("Logout")),
                  ]),
            );
          }, // This can be any widget.
        ),
      ),
    );
  }

  Stream<List<Todo>> readTodo() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return FirebaseFirestore.instance
        .collection('todo')
        .where('user_id', isEqualTo: auth.currentUser!.uid)
        .snapshots()
        .map((event) =>
            event.docs.map((doc) => Todo.fromJson(doc.data())).toList());
  }

  Widget buildTodo(Todo todo) {
    DateFormat dueDateFormat = DateFormat("d MMMM y");
    return Column(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Dismissible(
                confirmDismiss: (DismissDirection direction) async {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirm"),
                        content: const Text(
                            "Are you sure you wish to delete this Task?"),
                        actions: <Widget>[
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16)))),
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text("Cancel")),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16)))),
                            onPressed: () {
                              final docTodo = FirebaseFirestore.instance
                                  .collection('todo')
                                  .doc(todo.id);

                              docTodo.delete();
                              Navigator.of(context).pop(true);
                            },
                            child: const Text("Delete"),
                          ),
                        ],
                      );
                    },
                  );
                },
                key: UniqueKey(),
                background: Container(
                  decoration: ShapeDecoration(
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                secondaryBackground: Container(
                  decoration: ShapeDecoration(
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: <Color>[Colors.red, Colors.red], // red to yellow
                    ),
                  ),
                  child: Card(
                    color: Colors.red,
                    margin: EdgeInsets.all(0),
                    child: TaskTile(
                        todoID: todo.id,
                        title: todo.title,
                        status: todo.status,
                        duedate:
                            dueDateFormat.format(todo.duedate as DateTime)),
                  ),
                ))),
        SizedBox(
          height: 12,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0XFF2D31FA),
        child: Icon(Icons.add),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: () {
          Navigator.push(context, _SlideUpAddTask());
        },
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
                            onPressed: (() {
                              Navigator.pushNamed(
                                  context, TaskNotification.routeNames);
                            }),
                            icon: Icon(Icons.notifications_none_outlined)),
                        IconButton(
                            onPressed: (() async {
                              await _showFluidDialog();
                            }),
                            icon: Icon(Icons.more_horiz))
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
                        final todo = snapshot.data!;

                        return ListView(children: todo.map(buildTodo).toList());
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  )))
            ],
          )),
        ),
      ),
    );
  }
}

Route _SlideUpAddTask() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => AddTaskPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
