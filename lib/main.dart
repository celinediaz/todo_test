import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do list App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'TO DO'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Task {
  String text;
  int order;
  bool checked;
  Task(this.text, {required this.order, this.checked: false});
}


class _MyHomePageState extends State<MyHomePage> {
  List<Task> items = [
    Task('A', order: 0),
    Task('B', order: 1),
    Task('C', order: 2, checked: true),
    Task('D', order: 3),
  ];

  updateList(e) {
    setState((){
      List<Task> checkedList = this.items.where((element) => element.checked).toList();
      checkedList.sort((a,b) => a.order - b.order);
      List<Task> uncheckedList = this.items.where((element) => !element.checked).toList();
      uncheckedList.sort((a,b) => a.order - b.order);

      this.items.clear();
      this.items.addAll([...uncheckedList, ...checkedList]);
    });
  }

  @override
  Widget build(BuildContext context) {
    updateList(this.items);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(widget.title),

      ),
      body: ListView(
        children: [
          ...this.items.map((e) => ListTile(
            leading: Checkbox(
              onChanged: (e){
              },
              value: e.checked,
            ),
            title: Text(e.text,
              style: TextStyle(
                color: e.checked ? Colors.grey.shade700 : Colors.black,
                decoration: e.checked ? TextDecoration.lineThrough : null,
              ),
            ),
            trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
            onTap: () {
              e.checked = !e.checked;
              updateList(e);
            },
          ))
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

