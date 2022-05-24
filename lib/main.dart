import 'package:flutter/material.dart';
import 'package:todo_list/SecondPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'ToDo List',
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> todoItem = <String>[];

  void addTodoItem(String task) {
    if (task.isNotEmpty) {
      setState(() => todoItem.add(task));
    }
  }

  void removeTodoItem(int position) {
    setState(() => todoItem.removeAt(position));
  }

  void promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Mark${todoItem[index]} as complete?"),
            actions: <Widget>[
              TextButton(
                  child: const Text("Cancel"),
                  onPressed: () => Navigator.of(context).pop()),
              TextButton(
                  onPressed: () {
                    removeTodoItem(index);
                    Navigator.of(context).pop();
                  },
                  child: const Text("Complete"))
            ],
          );
        });
  }

  Widget buildTodoList() {
    return ListView.builder(
        itemCount: todoItem.length,
        itemBuilder: (BuildContext context, int index) {
          return buildTodoItem(todoItem[index], index);
        });
  }

  Widget buildTodoItem(String todoText, int index) {
    return ListTile(
      title: Text(todoText),
      onTap: () => promptRemoveTodoItem(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Todo List"),
          ),
          body: buildTodoList(),
          floatingActionButton: FloatingActionButton(
            splashColor: Colors.purple,
            onPressed: pushAddTodoScreen,
            tooltip: "Add Task",
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }

  void pushAddTodoScreen() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(title: Text("Add Item")),
          body: TextField(
            autofocus: true,
            onSubmitted: (String value) {
              addTodoItem(value);
              Navigator.pop(context);
            },
            decoration: const InputDecoration(
                hintText: "Write Todo Item",
                contentPadding: EdgeInsets.all(16.0)),
          ),
        );
      },
    ));
  }
}
