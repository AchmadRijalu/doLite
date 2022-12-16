import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:todolist_lite/models/CategoryTask.dart';
import 'package:todolist_lite/models/StatusTask.dart';
import 'package:todolist_lite/models/item.dart';
import 'package:todolist_lite/models/todo.dart';
import 'package:todolist_lite/views/Task_Page.dart';
import 'package:todolist_lite/widgets/Category_Tile.dart';

import '../widgets/StatusTask_Tile.dart';

class AddTaskPage extends StatefulWidget {
  static const routeNames = "AddTask";
  AddTaskPage();

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  // callback() {
  //   setState(() {});
  // }

  int? statusSelected;
  int? categorySelected;
  String? statusTask;
  String? categoryTask;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.titleController;
    this.statusSelected;
    this.categorySelected;
    this.categoryTask;
    this.statusTask;
    this.dueDateController;
    this.descriptionController;

    super.didChangeDependencies();

    _focusNode!.addListener(() {
      setState(() {});
    });

    _focusNode2!.addListener(() {
      setState(() {});
    });
    _focusNode3!.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _focusNode!.dispose();
    super.dispose();
    titleController.dispose();
    dueDateController.dispose();
    descriptionController.dispose();
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final TextEditingController taskListController = TextEditingController();
  final _keyState = GlobalKey<FormState>();
  final _keyStateTaskList = GlobalKey<FormState>();
  FocusNode? _focusNode = FocusNode();
  FocusNode? _focusNode2 = FocusNode();
  FocusNode? _focusNode3 = FocusNode();

  DateFormat dateFormat = DateFormat("E, d MMMM y");
  DateFormat dueDateFormat = DateFormat("d MMMM y");
  DateTime _dateTime = DateTime.now().add(Duration(days: 1));
  DateTime initialDate = DateTime.now().add(Duration(days: 1));

  Future createTodo(
      {required String description, required String title}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final createTodo = FirebaseFirestore.instance.collection("todo").doc();

    final todo = Todo(
        id: createTodo.id,
        title: title,
        description: description,
        userId: auth.currentUser!.uid,
        duedate: _dateTime,
        status: statusTask,
        category: categoryTask);

    final todojson = todo.toJson();
    await createTodo.set(todojson);
  }

  void onSelected(int index) {
    setState(() {
      statusSelected = index;
      statusTask = StatusList[statusSelected!].name;
    });
  }

  void onselectedCategory(int index) {
    setState(() {
      categorySelected = index;
      categoryTask = categoryList[categorySelected!].categoryName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              child: SvgPicture.asset("assets/images/icons/add_icon_svg.svg"),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              "Add New Task",
              style: TextStyle(
                  fontFamily: "Quicksand",
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  child: Form(
                    key: _keyState,
                    child: Column(children: [
                      Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 2.0,
                              spreadRadius: 0.4)
                        ]),
                        child: TextFormField(
                          focusNode: _focusNode,
                          controller: titleController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            return value.toString().length < 2
                                ? "Title must not empty"
                                : null;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            labelText: "Title",
                            labelStyle: TextStyle(
                                fontFamily: "Quicksand",
                                fontWeight: FontWeight.w700,
                                color: _focusNode!.hasFocus
                                    ? Colors.black
                                    : Colors.grey.shade600),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        child: TextFormField(
                          onTap: () async {
                            await showDatePicker(
                                    context: context,
                                    initialDate: initialDate,
                                    firstDate: initialDate,
                                    lastDate: new DateTime(2034))
                                .then((date) {
                              setState(() {
                                date == null
                                    ? _dateTime = initialDate
                                    : _dateTime = date;
                              });
                            });
                            dueDateController.text =
                                dueDateFormat.format(_dateTime as DateTime);
                          },
                          focusNode: _focusNode2,
                          controller: dueDateController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            return value.toString().length < 2
                                ? "Title must not empty"
                                : null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.calendar_month,
                              color: Color(0XFF2D31FA),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            labelText: "Due Date",
                            labelStyle: TextStyle(
                                fontFamily: "Quicksand",
                                fontWeight: FontWeight.w700,
                                color: _focusNode2!.hasFocus
                                    ? Colors.black
                                    : Colors.grey.shade600),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 2.0,
                              spreadRadius: 0.4)
                        ]),
                        child: TextFormField(
                          focusNode: _focusNode3,
                          controller: descriptionController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            return value.toString().length < 2
                                ? "Description must not empty"
                                : null;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            labelText: "Description",
                            labelStyle: TextStyle(
                                fontFamily: "Quicksand",
                                fontWeight: FontWeight.w700,
                                color: _focusNode3!.hasFocus
                                    ? Colors.black
                                    : Colors.grey.shade600),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text(
                              "Category",
                              style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: categoryList.length,
                            itemBuilder: ((context, index) {
                              CategoryTask category = categoryList[index];
                              return CategoryTile(
                                  selectedCategory: () =>
                                      onselectedCategory(index),
                                  checkCategory: index == categorySelected,
                                  color: category.categoryColor!,
                                  categoryName: category.categoryName!);
                            })),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text(
                              "Status",
                              style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: StatusList.length,
                            itemBuilder: ((context, index) {
                              StatusTask status = StatusList[index];
                              return StatusTaskTile(
                                selected: () => onSelected(index),
                                check: index == statusSelected,
                                image: status.image,
                                name: status.name.toString(),
                              );
                            })),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                          width: double.infinity,
                          height: 48,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              backgroundColor: Colors.white,

                              side: BorderSide(
                                  color: Colors.red, width: 2), //<-- SEE HERE
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.red),
                            ),
                          )),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: (() async {
                            if (_keyState.currentState!.validate()) {
                              if (statusTask == null ||
                                  categorySelected == null) {
                                MotionToast.error(
                                        layoutOrientation: ToastOrientation.ltr,
                                        animationType: AnimationType.fromRight,
                                        width: 300,
                                        title: Text("Oopss!"),
                                        description: Text(
                                            "Please fill the status and category for your task!"))
                                    .show(context);
                                // Fluttertoast.showToast(
                                //     msg:
                                //         "Please fill the status and category for your task!",
                                //     toastLength: Toast.LENGTH_SHORT,
                                //     gravity: ToastGravity.BOTTOM,
                                //     timeInSecForIosWeb: 1,
                                //     backgroundColor: Colors.red,
                                //     textColor: Colors.white,
                                //     fontSize: 16.0);
                              } else {
                                await createTodo(
                                    description: descriptionController.text,
                                    title: titleController.text);
                                Navigator.pushNamedAndRemoveUntil(context,
                                    TaskPage.routeNames, (route) => false);
                              }
                            }
                          }),
                          child: Text(
                            "Save",
                            style: TextStyle(
                              fontFamily: "Quicksand",
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0XFF2D31FA)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12)))),
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ))),
      ),
    );
  }
}
