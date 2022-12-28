part of 'Pages.dart';

class TaskDetailPage extends StatefulWidget {
  static const routeNames = "/TaskDetails";
  var todoId;
  TaskDetailPage({super.key, required this.todoId});

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  var _taskId = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _taskId = widget.todoId['todoId'];
  }

  Future getTodo() async {
    return await FirebaseFirestore.instance
        .collection('todo')
        .doc(_taskId)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.popAndPushNamed(
            context,
            TaskPage.routeNames,
          ),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, EditTaskPage.routeNames,
                      arguments: {'id': _taskId});
                },
                child: Icon(Icons.edit),
              ))
        ],
        title: Row(children: [
          Text(
            "Detail",
            style: TextStyle(
                fontFamily: "Quicksand",
                color: Colors.black,
                fontWeight: FontWeight.w700),
          ),
        ]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
            color: Colors.white,
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Container(
                child: FutureBuilder<dynamic>(
                  future: getTodo(),
                  builder: ((context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Something went wrong! ${snapshot.error}"),
                      );
                    } else if (snapshot.hasData) {
                      final todo = snapshot.data;
                      var catName;
                      var catColor;
                      var statName;
                      var statImg;
                      DateFormat dueDateFormat = DateFormat('d MMMM y');
                      String date =
                          dueDateFormat.format(todo['duedate'].toDate());
                      for (var i = 0; i < categoryList.length; i++) {
                        if (todo['category'] == categoryList[i].categoryName) {
                          catName = categoryList[i].categoryName;
                          catColor = categoryList[i].categoryColor;
                        }
                      }
                      for (var i = 0; i < StatusList.length; i++) {
                        if (todo['status'] == StatusList[i].name) {
                          if (StatusList[i].image == null) {
                            statName = StatusList[i].name;
                          } else {
                            statName = StatusList[i].name;
                            statImg = StatusList[i].image;
                          }
                        }
                      }
                      return Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Title',
                              style: TextStyle(
                                  fontFamily: "Quicksand",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              todo['title'],
                              style: TextStyle(
                                  fontFamily: "Quicksand",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18),
                            ),
                          ),
                          SizedBox(height: 38),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Due date',
                              style: TextStyle(
                                  fontFamily: "Quicksand",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              date,
                              style: TextStyle(
                                  fontFamily: "Quicksand",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18),
                            ),
                          ),
                          SizedBox(height: 38),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Description',
                              style: TextStyle(
                                  fontFamily: "Quicksand",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              todo['description'],
                              style: TextStyle(
                                  fontFamily: "Quicksand",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18),
                            ),
                          ),
                          SizedBox(height: 38),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Type',
                              style: TextStyle(
                                  fontFamily: "Quicksand",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.all(12),
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: catColor),
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              children: [
                                Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: catColor),
                                ),
                                SizedBox(width: 12),
                                Text(
                                  catName,
                                  style: TextStyle(
                                      fontFamily: "Quicksand",
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Status',
                              style: TextStyle(
                                  fontFamily: "Quicksand",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  statImg == null
                                      ? SvgPicture.asset("")
                                      : SvgPicture.asset(
                                          statImg,
                                          width: 20,
                                        ),
                                  SizedBox(width: 4),
                                  Text(statName,
                                      style: TextStyle(
                                          fontFamily: "Quicksand",
                                          fontWeight: FontWeight.w700))
                                ]),
                          )
                        ],
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
                ),
              ),
            )),
      ),
    );
  }
}
