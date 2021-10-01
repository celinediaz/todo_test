import 'package:flutter/material.dart';
import 'package:todo_test/hero_dialog_route.dart';
import 'package:todo_test/add_todo_popup_card.dart';
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
    Task('Take out the papers and the trash', order: 0),
    Task('Scrub that kitchen floor', order: 1),
    Task('Finish cleaning up room', order: 2, checked: true),
    Task('Get all the garbage out of sight', order: 3),
  ];

  updateList() {
    setState((){
      List<Task> checkedList = this.items.where((element) => element.checked).toList();
      checkedList.sort((a,b) => a.order - b.order);
      List<Task> uncheckedList = this.items.where((element) => !element.checked).toList();
      uncheckedList.sort((a,b) => a.order - b.order);

      this.items.clear();
      this.items.addAll([...uncheckedList, ...checkedList]);
    });
  }

  final textCtrl = TextEditingController();

  openPopUp(void Function(String) onSave) {
    Navigator.of(context).push(HeroDialogRoute(
        builder: (context){
          return AddTodoPopupCard(
              textCtrl: textCtrl,
              onSave: (text){
                onSave(text);
                updateList();
                textCtrl.text = '';
                Navigator.of(context).pop();
              },
          );
        },
    ));
  }

  @override
  Widget build(BuildContext context) {
    updateList();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(widget.title),

      ),
      body: ListView(
        children: [
          ...this.items.map((e) => ListTile(
            leading: Checkbox(
              value: e.checked,
              onChanged: (bool? value){
                setState(() {
                  e.checked = !e.checked;
                  updateList();
                });
              },
            ),
            title: Text(e.text,
              style: TextStyle(
                color: e.checked ? Colors.grey.shade700 : Colors.black,
                decoration: e.checked ? TextDecoration.lineThrough : null,
              ),
            ),
            trailing: PopupMenuButton<String>(
              onSelected: (t) {
                switch(t){
                  case 'edit':
                    this.textCtrl.text = e.text;
                    openPopUp((text) =>
                    this.items.firstWhere((element) => element.order == e.order)
                      .text = text);
                    break;
                  case 'delete':
                    this.items.removeWhere((element) => element.order == e.order);
                    updateList();
                    break;
                }
              },
              icon: Icon(Icons.more_vert),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                side: BorderSide(color: Colors.purple.shade200, width:1),
              ),
              itemBuilder: (context){
                return[
                  PopupMenuItem<String>(
                    height:12,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.edit, color: Colors.purple.shade500),
                          Text(
                              'Edit',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                              color: Colors.purple.shade900,
                              ),
                          ),
                        ],
                        ),
                    value: 'edit',
                      ),
                  PopupMenuDivider(
                    height: 4,
                  ),
                  PopupMenuItem<String>(
                    height:12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.delete_rounded, color: Colors.redAccent.shade200),
                        Text(
                          'Delete',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.redAccent.shade700,
                          ),
                        ),
                      ],
                    ),
                    value: 'delete',
                  ),
                ];
              },
            ),
            //IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
            onTap: () {
              e.checked = !e.checked;
              updateList();
            },
          ))
      ]),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right:5.0),
        child: GestureDetector(
          onTap: () => openPopUp((text) => items.add(Task(text,
                          order: items.reduce((value, element) =>
                              element.order > value.order ? element : value)
                              .order + 1
                        )
          )),
          child: Hero(
            tag: 'add-todo-hero',
            child: Material(
              elevation:2,
              color: Colors.purple.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(46),
                side: BorderSide(
                  width: 3,
                  color: Colors.purple.shade200
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(
                  Icons.add_rounded,
                  color: Colors.purple.shade500,
                  size: 32
                )
              )
            )

          )
        )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}



