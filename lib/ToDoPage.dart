import 'package:flutter/material.dart';
import 'database.dart';
import 'ToDoItem.dart';
import 'ToDoItem_dao.dart';

class Other2Page extends StatefulWidget {
  const Other2Page({super.key});

  @override
  State<Other2Page> createState() => OtherPage2State();
}

class OtherPage2State extends State<Other2Page> {
  late TextEditingController _toDoNameController;
  double? myFontSize = 18;
  List<ToDoDb> myList = <ToDoDb>[];
  List<ToDoItem> list = <ToDoItem>[];
  late ToDoItemDao toDoItemDao;
  ToDoDb itemSelected = ToDoDb(null, "");

  @override
  void initState() {
    super.initState();
    _toDoNameController = TextEditingController();
    databaseStuff();
  }


  addToDoItem(String toDoName) async {
    ToDoDb toDoDb = ToDoDb(null, toDoName);
    await toDoItemDao.insertToDoItem(toDoDb);
    var updatedList = await toDoItemDao.findAllToDos();
    setState(() {
      myList = updatedList;
      itemSelected = ToDoDb(null, " ");
    });
  }

  deleteToDoItem(String toDoName) async {
    Navigator.pop(context);
    toDoItemDao.delete(toDoName);
    myList = await toDoItemDao.findAllToDos();
    setState(() {
      itemSelected = ToDoDb(null, " ");
    });
  }

  void databaseStuff() async {
    final database = await ToDoDataBase.accessDb();
    if (database != null) {
      toDoItemDao = database.toDoItemDao;
      toDoItemDao.findAllToDos().then(
              (list) {
            setState(() {
              myList = list;
            });
          }
      );
    }
  }

//Handle deletes
  void callDeleteOption(ToDoDb toDoDb) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: const Text(''),
            content: Text("Delete the item?"),
            actions: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                FilledButton(
                    onPressed: () => {Navigator.pop(context)},
                    child: Text('No')),
                FilledButton(
                    onPressed: () => deleteToDoItem(toDoDb.toDoName),
                    child: Text('Yes'))
              ])
            ],
          ),
    );
  }

  Widget toDoList() {
    return
      Column(
          children:[
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: TextField(
                  controller: _toDoNameController,
                  decoration: InputDecoration(
                      labelText: "To Do Name Goes Here",
                      border: OutlineInputBorder()
                  ),
                  style: TextStyle(fontSize: myFontSize)
              ),
            )
          ]
      ),
    Expanded(
      child:
    ListView.builder(
    itemCount: myList.length,
    itemBuilder: (context, rowNum) {
    ToDoDb toDoDb = myList[rowNum];
    return
    GestureDetector(
    onTap:() {
    setState(() {
    itemSelected = toDoDb;
    }
    );
    },
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
    Text(toDoDb.toDoName)
              ]
        ),
        );
          },
    ),
    )
    ]
      );
  }


  Widget detailsPage(ToDoDb? toDoDb) {
    return Column(mainAxisAlignment: MainAxisAlignment.start,
        children: [Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text((itemSelected.id.toString())),
              Text(itemSelected.toDoName)]),

          Row(mainAxisAlignment: MainAxisAlignment.center,

              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    callDeleteOption(itemSelected);
                    setState(() {

                    }
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Delete It'),
                )
              ]
          )
        ]);
  }

  Widget reactiveLayout() {
    var size = MediaQuery
        .sizeOf(context);
    var height = size.height;
    var width = size.width;

    if ((width > height) && (width > 720)) {
      return Row(children: [
        Expanded(flex: 1,
            child: toDoList()),
        Expanded(flex: 2,
            child: detailsPage(null))
      ]);
    }

    else //portrait mode
        {
      if (itemSelected.id == null) {
        return toDoList();
      }
      else {
        return detailsPage(null);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('To Do List Page', selectionColor: Colors.black,
                  style: TextStyle(fontSize: 24.0)),

              Expanded(child:
              reactiveLayout()),
            ]
        ), floatingActionButton: FloatingActionButton(
        onPressed: () {
          addToDoItem(_toDoNameController.text)
          ;
          _toDoNameController.clear();
        },
        tooltip: 'Add Item',
        child: const Icon(Icons.add))
    );
  }
}
