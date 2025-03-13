import 'package:floor/floor.dart';

@entity
class Ingredient {
//  static int ID = 1;
    @PrimaryKey(autoGenerate:true)
    final int? id;
  final String ingredientName;
  final String ingredientQuantity;

  Ingredient(this.id, this.ingredientName, this.ingredientQuantity);

  @override
  String toString() {
    return "$id:$ingredientName:$ingredientQuantity";
  }
}


