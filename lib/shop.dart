import 'package:flutter/material.dart';



class Other2Page extends StatefulWidget {
  const Other2Page({super.key});

  @override
  State<Other2Page> createState() => OtherPage2State();
}

class OtherPage2State extends State<Other2Page> {
  late TextEditingController _ingredientControl;
  late TextEditingController _quantityControl;
  String loginName = '';
  String loginName2 = '';
  late var profileString;

  double? myFontSize = 18;
  List<String> ingredientArray = [];
  List<String> quantityArray =  [];

  @override
  void initState() {
    super.initState();
    _ingredientControl = TextEditingController();
    _quantityControl = TextEditingController();
  }

  void manageArrays(String ingredientValue, String quantityValue){

    setState(() {
      ingredientArray.add(ingredientValue);
      quantityArray.add(quantityValue);
      print(ingredientArray + quantityArray);
      });
  }

  void handleLongPress(var rowNum){
    Navigator.pop(context);
    setState(() {
      ingredientArray.removeAt(rowNum);
      quantityArray.removeAt(rowNum);

    });
  }

//dialog box
  alertBox(var rowNum) {
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
                onPressed: () => handleLongPress(rowNum),
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

                    //add to list button here.
                    ElevatedButton.icon(
                      onPressed: () {
                        manageArrays(_ingredientControl.text, _quantityControl.text);
                        _ingredientControl.text = '';
                        _quantityControl.text = '';
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('ADD IT'),
                         )]),

              /*Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text('manage items')),
                    ),

              ])*/

            Expanded(child: ListView.builder(
                itemCount: ingredientArray.length,
                itemBuilder: (context, rowNum) {return GestureDetector(onLongPress: ()=> alertBox(rowNum),
                  child: Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [Text(ingredientArray[rowNum]),Text(quantityArray[rowNum])]
                ));
                },
                )
            )
            ],
    )
    );
  }
}
