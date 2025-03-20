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


@entity
class OtherPage2State extends State<Other2Page> {
  late TextEditingController _toDoNameController;
  late TextEditingController _toDoDeetsController;
  String loginName = '';
  String loginName2 = '';
  late var profileString;
  double? myFontSize = 18;
  List<ToDoDb> myList = [];
  List<ToDoItem> list = [];
  late ToDoItemDao toDoItemDao;

  @override
  void initState() {
    super.initState();
    _toDoNameController = TextEditingController();
    _toDoDeetsController = TextEditingController();
    databaseStuff();
  }

  void addToDoItem(String toDoName, String toDoDeets) async {
    print('r54534sdfdsfSFDFDFDFd');
    ToDoDb toDoDb = new ToDoDb(null, toDoName, toDoDeets);
    await toDoItemDao.insertToDoItem(toDoDb);
    List<ToDoDb>myList2 = await toDoItemDao.findAllToDos();
    myList = myList2;
    print(myList);
    print('99999');
    setState(() {});
  }

  void deleteToDoItem(String toDoName) async {
    Navigator.pop(context);
    toDoItemDao.delete(toDoName);
    List<ToDoDb>myList2 = await toDoItemDao.findAllToDos();
    myList = myList2;
    setState(() {});
  }

  void databaseStuff() async{
    final database = await ToDoDataBase.accessDb();
    toDoItemDao = database!.toDoItemDao;
    database.toDoItemDao.findAllToDos().then(
        (list)
        {
          setState((){
            myList = list;
          } );
        }
      );
    }

//Handle deletes
  void callDeleteOption(var rowNum, String toDoName) {
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
                onPressed: () => deleteToDoItem(toDoName),
                child: Text('Yes'))
          ])
        ],
      ),
    );
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
/*
                  Flexible (child: TextField(
                      controller: _toDoDeetsController,
                      decoration: InputDecoration(
                          labelText: "To Do Details Go Here",
                          border: OutlineInputBorder()),
                    style: TextStyle(fontSize: myFontSize))),
*/
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

            Expanded(child: ListView.builder(
              itemCount: myList.length,
              itemBuilder: (context, rowNum) {
                ToDoDb toDoDb = myList[rowNum];
                return GestureDetector(onLongPress: ()=> callDeleteOption(rowNum, toDoDb.toDoName),
                    child: Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [Text(toDoDb.toDoName)]
                    ));
              },
            )
            )
          ],
        )
    );
  }
}
