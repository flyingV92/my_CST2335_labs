import 'ToDoItem.dart';
import 'database.dart';
import 'package:floor/floor.dart';

@dao
abstract class ToDoItemDao {

  @Query('SELECT * FROM ToDoDb')
  Future<List<ToDoDb>> findAllToDos();

  @Query('DELETE FROM ToDoDb WHERE toDoName = :toDoName')
  Future<void> delete(String toDoName);

  @insert
  Future<void> insertToDoItem(ToDoDb toDoDb);
}