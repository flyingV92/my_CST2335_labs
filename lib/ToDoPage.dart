import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
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
  late TextEditingController _toDoDeetsController;
  double? myFontSize = 18;
  List<ToDoDb> myList = [];
  List<ToDoItem> list = [];
  late ToDoItemDao toDoItemDao;
  ToDoDb itemSelected = new ToDoDb(null, " ", " ");

  @override
  void initState() {
    super.initState();
    _toDoNameController = TextEditingController();
    _toDoDeetsController = TextEditingController();
    databaseStuff();
  }


  void addToDoItem(String toDoName, String toDoDeets) async {
    ToDoDb toDoDb = new ToDoDb(null, toDoName, toDoDeets);
    await toDoItemDao.insertToDoItem(toDoDb);
    List<ToDoDb>myList2 = await toDoItemDao.findAllToDos();
    myList = myList2;
    setState(() {});
  }

  void deleteToDoItem(String toDoName) async {
    Navigator.pop(context);
    toDoItemDao.delete(toDoName);
    List<ToDoDb>myList2 = await toDoItemDao.findAllToDos();
    myList = myList2;
    setState(() {itemSelected = ToDoDb(null, " ", " ");});
  }

  void databaseStuff() async{
    final database = await ToDoDataBase.accessDb();
    if (database != null) {
      toDoItemDao = database.toDoItemDao;

    database.toDoItemDao.findAllToDos().then(
        (list)
        {
          setState((){
            myList = list;
          } );
        }
      );
    }
    }

//Handle deletes
  void callDeleteOption(ToDoDb toDoDb) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(''),
        content: Text("Delete the item?"),
        actions: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            FilledButton(
                onPressed: () {Navigator.pop(context);},
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
        ListView.builder(
          itemCount: myList.length,
          itemBuilder: (context, rowNum) {
            ToDoDb toDoDb = myList[rowNum];
            return
            GestureDetector(onTap: ()=> {setState((){itemSelected = toDoDb;})},
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(toDoDb.toDoName)
                      ]
            ));
          },
        );
  }


  Widget detailsPage() {
      return Column(mainAxisAlignment: MainAxisAlignment.start,
        children: [Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text((itemSelected.id.toString())),
                  Text(itemSelected.toDoName)]),
        Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
              onPressed: () {
               setState(() {
                 callDeleteOption(itemSelected);
               }
               );
             },
        icon: const Icon(Icons.add),
        label: const Text('Delete It'),
          )]
    )
    ]);
  }

  Widget reactiveLayout() {
    var size = MediaQuery.sizeOf(context);
    var height = size.height;
    var width = size.width;
    if ((width > height) && (width > 720)) {
      return
        Row(
            children: [
              Expanded(
                  flex: 1,
                  child: toDoList()
              ),
              Expanded(
                  flex: 2,
                  child: detailsPage()
              )
            ]
        );
    }
    else if (height > width) {
      return
        Row(
            children: [
              Expanded(
                  flex: 1,
                  child: toDoList()
              ),
              Expanded(
                  flex: 2,
                  child: detailsPage()
              )
            ]
        );
    }
    else{
    return toDoList();
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
            Text('To Do List Page', selectionColor:Colors.black,style: TextStyle(fontSize: 24.0)),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ Flexible ( child: TextField(
                    controller: _toDoNameController,
                    decoration: InputDecoration(
                        labelText: "To Do Name Goes Here",
                        border: OutlineInputBorder()),
                    style: TextStyle(fontSize: myFontSize))),

                  Flexible (child: TextField(
                      controller: _toDoDeetsController,
                      decoration: InputDecoration(
                          labelText: "To Do Details Go Here",
                          border: OutlineInputBorder()),
                    style: TextStyle(fontSize: myFontSize))),

                  ElevatedButton.icon(
                    onPressed: () {
                      addToDoItem(_toDoNameController.text, _toDoDeetsController.text);
                      _toDoNameController.text = '';
                      _toDoDeetsController.text = '';
                                  },
                    icon: const Icon(Icons.add),
                    label: const Text('Add Item'),
                    )
                ]
            ),
            Expanded(child:
                reactiveLayout())

            //reactiveLayout()
    ]
        )
    );

  }
}
