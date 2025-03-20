import 'package:floor/floor.dart';

@entity
class ToDoItem {

  @PrimaryKey(autoGenerate:true)
  final int? id;
  final String toDoItem;
  final String toDoDeets;

  ToDoItem(this.id, this.toDoItem, this.toDoDeets);

  @override
  String toString() {
    return "$id:$toDoItem:$toDoDeets";
  }
}


