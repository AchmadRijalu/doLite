import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:todolist_lite/models/CategoryTask.dart';
import 'package:todolist_lite/models/Task.dart';
import 'package:todolist_lite/models/item.dart';
import 'package:todolist_lite/widgets/Category_Tile.dart';
import 'package:todolist_lite/widgets/ListTask_Tile.dart';

class AddTaskPage extends StatefulWidget {
  static const routeNames = "AddTask";
  AddTaskPage();

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  callback() {
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.titleController;
    this.dueDateController;
    this.descriptionController;
    setState(() {
      listTask = listTask;
    });
    listTask;
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

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _keyStateTaskList,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: taskListController,
                        validator: (value) {
                          return value.toString().length < 2
                              ? "Please input your Task"
                              : null;
                        },
                        decoration: InputDecoration(hintText: "Enter New Task"),
                      ),
                    ],
                  )),
              title: Text('Add New Task'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.pink,
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                        fontFamily: "Quicksand", fontWeight: FontWeight.w700),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (_keyStateTaskList.currentState!.validate()) {
                      setState(() {
                        listTask = List.from(listTask)
                          ..add(Task(name: taskListController.text));
                      });
                    }
                    setState(
                      () {
                        callback();
                      },
                    );
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(
                        fontFamily: "Quicksand", fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            );
          });
        });
  }

  // Future createTodo(
  //     {required String title,
  //     required DateTime dateTime,
  //     required String description,
  //     required String category}) {}

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
                    ]),
                  ),
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
                            color: category.categoryColor!,
                            categoryName: category.categoryName!);
                      })),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  child: Row(children: [
                    Text("List of Tasks",
                        style: TextStyle(
                            fontFamily: "Quicksand",
                            fontWeight: FontWeight.bold))
                  ]),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  width: double.infinity,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: listTask.length,
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        Task task = listTask[index];
                        return ListTaskTile(
                          onClick: (int val) {
                            setState(() {
                              listTask.removeAt(index);
                              callback();
                            });
                          },
                          name: task.name.toString(),
                          id: index.toString(),
                        );
                      })),
                ),
                GestureDetector(
                  onTap: (() {
                    _showDialog(context);
                  }),
                  child: Container(
                    child: Column(children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.shade100,
                        ),
                        padding: const EdgeInsets.all(8),
                        width: double.infinity,
                        height: 40,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/images/icons/add_icon_svg.svg",
                                width: 40,
                                height: 20,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Add More",
                                style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontWeight: FontWeight.w500,
                                    color: Color(0XFF2D31FA)),
                              )
                            ]),
                      ),
                    ]),
                  ),
                ),
                SizedBox(
                  height: 32,
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
                        setState(() {
                          listTask = [];
                        });
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
                    onPressed: (() {}),
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)))),
                  ),
                ),
              ],
            ))),
      ),
    );
  }
}
