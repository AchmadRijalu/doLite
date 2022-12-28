part of 'Pages.dart';

class EditTaskPage extends StatefulWidget {
  static const routeNames = "/EditTaskPage";
  var id;
  EditTaskPage({super.key, required this.id});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  int? statusSelected;
  int? categorySelected;
  String? statusTask;
  String? categoryTask;
  int loopStatIndex = 0;
  int loopCatIndex = 0;

  static String _taskId = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _taskId = widget.id['id'];
    FirebaseFirestore.instance
        .collection('todo')
        .where('id', isEqualTo: _taskId)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      this.titleController.text = snapshot.docs.first['title'];
      this.dueDateController.text =
          dueDateFormat.format(snapshot.docs.first['duedate'].toDate());
      this._dateTime = snapshot.docs.first['duedate'].toDate();
      this.descriptionController.text = snapshot.docs.first['description'];
      for (var cat in categoryList) {
        if (snapshot.docs.first['category'] == cat.categoryName) {
          this.categorySelected = loopCatIndex;
          this.categoryTask = cat.categoryName;
        } else {
          loopCatIndex++;
        }
      }
      for (var stat in StatusList) {
        if (snapshot.docs.first['status'] == stat.name) {
          this.statusSelected = loopStatIndex;
          this.statusTask = stat.name;
        } else {
          loopStatIndex++;
        }
      }
    });
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

  Future getTodo() async {
    return await FirebaseFirestore.instance
        .collection('todo')
        .doc(_taskId)
        .get();
  }

  Future updateTodo(
      {required String description, required String title}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final todo = Todo(
        id: _taskId,
        title: title,
        description: description,
        userId: auth.currentUser!.uid,
        duedate: _dateTime,
        status: statusTask,
        category: categoryTask);

    await FirebaseFirestore.instance
        .collection('todo')
        .doc(_taskId)
        .update(todo.toJson());
  }

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
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              child: Icon(
                Icons.edit,
                color: Colors.greenAccent,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Text("Edit Task",
                style: TextStyle(
                    fontFamily: "Quicksand",
                    color: Colors.black,
                    fontWeight: FontWeight.w700)),
          ],
        ),
      ),
      body: FutureBuilder<dynamic>(
        future: getTodo(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error occurred ${snapshot.error}");
          } else if (snapshot.hasData) {
            final todo = snapshot.data;
            return Container(
              child: Padding(
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
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    return value.toString().length < 2
                                        ? "Title must not empty"
                                        : null;
                                  },
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
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
                                            initialDate: _dateTime,
                                            firstDate: initialDate,
                                            lastDate: new DateTime(2034))
                                        .then((date) {
                                      setState(() {
                                        date == null
                                            ? _dateTime = initialDate
                                            : _dateTime = date;
                                      });
                                    });
                                    dueDateController.text = dueDateFormat
                                        .format(_dateTime as DateTime);
                                  },
                                  focusNode: _focusNode2,
                                  controller: dueDateController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
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
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    return value.toString().length < 2
                                        ? "Description must not empty"
                                        : null;
                                  },
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
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
                                      CategoryTask category =
                                          categoryList[index];
                                      print("Cat Select: $categorySelected");
                                      print(index);
                                      return CategoryTile(
                                          selectedCategory: () =>
                                              onselectedCategory(index),
                                          checkCategory:
                                              index == categorySelected,
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
                                      print(index);
                                      print("Status Select : $statusSelected");
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
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      backgroundColor: Colors.white,

                                      side: BorderSide(
                                          color: Colors.red,
                                          width: 2), //<-- SEE HERE
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
                                                layoutOrientation:
                                                    ToastOrientation.ltr,
                                                animationType:
                                                    AnimationType.fromRight,
                                                width: 300,
                                                title: Text("Oopss!"),
                                                description: Text(
                                                    "Please fill the status and category for your task!"))
                                            .show(context);
                                      } else {
                                        await updateTodo(
                                            description:
                                                descriptionController.text,
                                            title: titleController.text);
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            TaskDetailPage.routeNames,
                                            arguments: {
                                              'todoId': widget.id['id']
                                            },
                                            (route) => false);
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
                                          MaterialStateProperty.all(
                                              Color(0XFF2D31FA)),
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
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
