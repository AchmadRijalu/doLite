part of 'Pages.dart';

class CustomSearchDelegate extends SearchDelegate {
  get context => null;
  late final toDo_lookup todolookup;

  Stream<List<Todo>> readTodo(String string) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return FirebaseFirestore.instance
        .collection('todo')
        .where('user_id', isEqualTo: auth.currentUser!.uid)
        .where('title'.toLowerCase(), isEqualTo: string.toLowerCase())
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
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    //query = 'p';
    //final searched = todolookup.searchString(query);
    //print(searched);
    return Column(
      children: [
        Expanded(
            flex: 9,
            child: Container(
                child: StreamBuilder<List<Todo>>(
              stream: readTodo(query),
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
                  return ListView(
                    padding: const EdgeInsets.all(20),
                    children: todo.map(buildTodo).toList());
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )))
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildResults

    return Column(
      children: [
        Expanded(
            flex: 9,
            child: Container(
                child: StreamBuilder<List<Todo>>(
              stream: readTodo(query),
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
