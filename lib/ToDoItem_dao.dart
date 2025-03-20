import 'ToDoItem.dart';
import 'database.dart';
import 'package:floor/floor.dart';

@dao
abstract class ToDoItemDao {

  @Query('SELECT * FROM ToDoDB')
  Future<List<ToDoDb>> findAllToDos();

  @Query('DELETE FROM ToDoDB WHERE toDoName = :toDoName')
  Future<void> delete(String toDoName);

  @insert
  Future<void> insertToDoItem(ToDoDb toDoDb);
}