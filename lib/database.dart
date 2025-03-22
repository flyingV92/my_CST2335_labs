
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'ToDoItem_dao.dart';
part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [ToDoDb])

abstract class ToDoDataBase extends FloorDatabase {
  ToDoItemDao get toDoItemDao;

  static ToDoDataBase? myDataBase;

  static Future<ToDoDataBase?> accessDb() async {
    myDataBase ??= await $FloorToDoDataBase.databaseBuilder('app_database3.db').build();
    return myDataBase!;
  }

}

@entity
class ToDoDb {
  @PrimaryKey(autoGenerate:true)
  final int? id;
  final String toDoName;



  ToDoDb(this.id, this.toDoName);
}

