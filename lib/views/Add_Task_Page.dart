import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:todolist_lite/widgets/Category_Tile.dart';

class AddTaskPage extends StatefulWidget {
  static const routeNames = "AddTask";
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final _keyState = GlobalKey<FormState>();
  FocusNode? _focusNode = FocusNode();
  FocusNode? _focusNode2 = FocusNode();
  FocusNode? _focusNode3 = FocusNode();

  DateFormat dateFormat = DateFormat("E, d MMMM y");
  DateFormat dueDateFormat = DateFormat("d MMMM y");
  DateTime _dateTime = DateTime.now().add(Duration(days: 1));
  DateTime initialDate = DateTime.now().add(Duration(days: 1));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.titleController;
    this.dueDateController;
    this.descriptionController;

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
                            labelText: "Email",
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
                  height: 24,
                ),
                Container(
                  height: 80,
                  child: Row(children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                          height: double.infinity,
                          padding: const EdgeInsets.all(12),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(children: [
                              CategoryTile(
                                color: Colors.blue,
                                categoryName: "Design",
                              ),
                              CategoryTile(
                                color: Colors.blue,
                                categoryName: "Coding",
                              ),
                            ]),
                          )),
                    ),
                    Expanded(
                      child: Ink(
                        color: Colors.blue,
                        child: InkWell(
                          child: SvgPicture.asset(
                            "assets/images/icons/add_icon_svg.svg",
                            width: 40,
                            height: 20,
                          ),
                        ),
                      ),
                    )
                  ]),
                )
              ],
            ))),
      ),
    );
  }
}
