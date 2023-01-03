part of 'Pages.dart';

class CustomSearchDelegate extends SearchDelegate {
  get context => null;
  late final toDo_lookup todolookup;

  Widget buildTodo(Todo todo) {
    DateFormat dueDateFormat = DateFormat("d MMMM y");
    return Column(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Dismissible(
                key: UniqueKey(),
                onDismissed: (DismissDirection direction) {
                  final docTodo = FirebaseFirestore.instance
                      .collection('todo')
                      .doc(todo.id);

                  docTodo.delete();
                  Navigator.of(context).pop(true);
                },
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

  Stream<List<Todo>> readTodo(String string) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return FirebaseFirestore.instance
        .collection('todo')
        .where('user_id', isEqualTo: auth.currentUser!.uid)
        .snapshots()
        .map((event) =>
            event.docs.map((doc) => Todo.fromJson(doc.data())).toList());
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

  Widget displayList(BuildContext context) {
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
                  late List<Todo> newTodos = [];
                  final todos = snapshot.data!;
                  for (var todo in todos) {
                    String title = todo.title!;
                    if (title.toLowerCase().contains(query.toLowerCase())) {
                      newTodos.add(todo);
                    }
                  }
                  // final todo = snapshot.data!;
                  return ListView(
                      padding: const EdgeInsets.all(20),
                      children: newTodos.map(buildTodo).toList());
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
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return displayList(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildResults
    return displayList(context);
  }
}
