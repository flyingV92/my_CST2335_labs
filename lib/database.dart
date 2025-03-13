// database.dart

// required package imports
import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'ingredient_dao.dart';
import 'ingredient.dart';
part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [IngredientDB])
abstract class AppDatabase extends FloorDatabase {
  IngredientDao get ingredientDao;

  static AppDatabase? myDataBase;

  AppDatabase.privateConstructor();

  static Future<AppDatabase?> accessDb() async {
    myDataBase ??= await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    return myDataBase;
  }

}

@entity
class IngredientDB {
  @PrimaryKey(autoGenerate:true)
  final int? id;
  final String ingredientName;
  final String ingredientQuantity;

  IngredientDB(this.id, this.ingredientName, this.ingredientQuantity);
}

