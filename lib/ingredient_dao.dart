import 'database.dart';
import 'ingredient.dart';
import 'package:floor/floor.dart';

@dao
abstract class IngredientDao {
  @Query('SELECT * FROM IngredientDB')
  Future<List<IngredientDB>> findAllIngredients();

  @Query('DELETE FROM IngredientDB WHERE ingredientName = :ingredientName')
  Future<void> delete(String ingredientName);

  @insert
  Future<void> insertIngredient(IngredientDB ingredient);
}