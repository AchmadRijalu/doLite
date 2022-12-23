import 'package:todolist_lite/models/todo.dart';

class toDo_lookup {
    toDo_lookup({ required this.todos });
    final List<Todo> todos;
    
    List<Todo> searchString(String string) {
        string = string.toLowerCase();
        
        final matching = todos.where((Todo) { return Todo.title!.toLowerCase().toString() == string; }).toList();
        if (matching.length > 0)  return matching;
        
        return todos.where((Todo) { return Todo.title!.toLowerCase().toString().contains(string); }).toList();
    }
}