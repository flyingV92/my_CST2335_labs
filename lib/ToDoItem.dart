import 'package:floor/floor.dart';

@entity
class ToDoItem {

  @PrimaryKey(autoGenerate:true)
  final int? id;
  final String? toDoItem;


  ToDoItem(this.id, this.toDoItem);

  @override
  String toString() {
    return "$id:$toDoItem";
  }
}


