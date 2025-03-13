import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'database.dart';
import 'ingredient.dart';
import 'ingredient_dao.dart';

class Other2Page extends StatefulWidget {
  const Other2Page({super.key});

  @override
  State<Other2Page> createState() => OtherPage2State();
}


@entity
class OtherPage2State extends State<Other2Page> {
  late TextEditingController _ingredientControl;
  late TextEditingController _quantityControl;
  String loginName = '';
  String loginName2 = '';
  late var profileString;

  double? myFontSize = 18;
  List<String> ingredientArray = [];
  List<String> quantityArray =  [];
  List<IngredientDB> myList = [];
  List<Ingredient> list = [];
  late IngredientDao ingredientDao;

  @override
  void initState() {
    super.initState();
    _ingredientControl = TextEditingController();
    _quantityControl = TextEditingController();

    databaseStuff();
  }

  void manageArrays(String ingredientValue, String quantityValue) async {


    IngredientDB ingredient = new IngredientDB(
        null, ingredientValue, quantityValue);
    //String results = ingredient.toString();
    //List<String> results2 = results.split(":");
    //IngredientDB ingredient2 = new IngredientDB(int.parse(results2[0]), results[1], results[2]);
    await ingredientDao.insertIngredient(ingredient);
    List<IngredientDB>myList2 = await ingredientDao.findAllIngredients();
    myList = myList2;
    setState(()  {

    });
  }

  void handleLongPress(String ingredientName) async {
    Navigator.pop(context);
    ingredientDao.delete(ingredientName);
    List<IngredientDB>myList2 = await ingredientDao.findAllIngredients();
    myList = myList2;
    setState(()  {

    });
  }

  void databaseStuff() async{
    final database = await AppDatabase.accessDb();
    ingredientDao = database!.ingredientDao;
    database.ingredientDao.findAllIngredients().then(
            (list)
        {
          setState((){

            myList = list;
          } );
        }
        );
  }

//dialog box
  alertBox(var rowNum, String ingredientName) {
    var numNum = rowNum.toString();
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(''),
        content: Text("Do you want to delete the item?" + numNum ),
        actions: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            FilledButton(
                onPressed: () {
                  ;
                  Navigator.pop(context);
                },
                child: Text('No')),
            FilledButton(
               onPressed: () => handleLongPress(ingredientName),
              //onPressed() => ingredientDao.delete(rowNum);
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
              Text('Profile Page', selectionColor:Colors.black,style: TextStyle(fontSize: 24.0)),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                      children: [ Flexible ( child: TextField(
                          controller: _ingredientControl,
                          decoration: InputDecoration(
                              labelText: "ingredient goes here",
                              border: OutlineInputBorder()),
                          obscureText: false,
                          style: TextStyle(fontSize: myFontSize))),

                      Flexible (child: TextField(
                  controller: _quantityControl,
                          decoration: InputDecoration(
                              labelText: "quantity goes here",
                              border: OutlineInputBorder()),
                          obscureText: false,
                          style: TextStyle(fontSize: myFontSize))),


                    ElevatedButton.icon(
                      onPressed: () {
                        manageArrays(_ingredientControl.text, _quantityControl.text);
                        _ingredientControl.text = '';
                        _quantityControl.text = '';
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('ADD IT'),
                         )]),

            Expanded(child: ListView.builder(
                itemCount: myList.length,
                itemBuilder: (context, rowNum) {
                  IngredientDB ingredient = myList[rowNum];
                  return GestureDetector(onLongPress: ()=> alertBox(rowNum, ingredient.ingredientName),
                  child: Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [Text(ingredient.ingredientName),Text(ingredient.ingredientQuantity)]
                ));
                },
                )
            )
            ],
    )
    );
  }
}
