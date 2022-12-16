import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todolist_lite/models/item.dart';
import 'package:todolist_lite/views/Add_Task_Page.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0XFF2D31FA),
        child: Icon(Icons.add),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: () {
          Navigator.pushNamed(context, AddTaskPage.routeNames);
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
                            onPressed: (() {}),
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
              // AppBar(
              //   bottom: TabBar(tabs: [
              //     Tab(
              //       text: "toDo",
              //     ),
              //     Tab(
              //       text: "Finish",
              //     )
              //   ]),
              // )
              // Expanded(
              //     flex: 9,
              //     child: Container(
              //       child: ListView.builder(
              //           itemCount: listItem.length,
              //           itemBuilder: ((context, index) {
              //             return Slidable(
              //                 endActionPane:
              //                     ActionPane(motion: ScrollMotion(), children: [
              //                   SlidableAction(
              //                     autoClose: true,
              //                     // An action can be bigger than the others.

              //                     onPressed: (value) {
              //                       setState(() {
              //                         listItem.removeAt(index);
              //                       });
              //                     },
              //                     backgroundColor: Colors.red,
              //                     foregroundColor: Colors.white,
              //                     icon: Icons.delete,
              //                     label: 'Delete',
              //                   ),
              //                 ]),
              //                 child: Container(
              //                   child: Column(children: [
              //                     TaskTile(),
              //                     SizedBox(
              //                       height: 12,
              //                     )
              //                   ]),
              //                 ));
              //           })),
              //     ))
            ],
          )),
        ),
      ),
    );
  }
}
