import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My_CST2235_Labs',
      theme: ThemeData(
       colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'CST2335 - Lab 2 - W25'),
        debugShowCheckedModeBanner: false,

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _counter = 0.0;
  var myFontSize = 30.0;

  void setNewValue(double value)
  {
    setState(() {
      _counter = value;
      myFontSize = value;
    });
  }


  void _incrementCounter() {
    setState(() {
          if( _counter<=99.0)
        _counter++;
    });
  }

  @override
    Widget build(BuildContext context) {

    return Scaffold(
      drawer:Drawer(child:Text("Hello, I made the burger!")),
    appBar: AppBar(

    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    // Here we take the value from the MyHomePage object that was created by
    // the App.build method, and use it to set our appbar title.
    title: Text(widget.title),
        actions: [
          OutlinedButton(onPressed: () { }, child:Text("David")),
          OutlinedButton(onPressed: (){ }, child: Text("Lab"))]
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
             Text(
              'BROWSE CATEGORIES',
                style: TextStyle(fontSize: myFontSize )
            ),
            Text(
              'Not sure about exactly which recipe you"re looking for? Do a search, or dive into our most popular categories.',
              style: TextStyle(fontSize: 16 )
            ),
            Text(
                'BY MEAT',
                style: TextStyle(fontSize: myFontSize )
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem( icon: Icon(Icons.access_alarm), label: 'Alarm Clock' ),
          BottomNavigationBarItem( icon: Icon(Icons.accessibility), label: 'You'  ),
        ],
          onTap: (buttonIndex) {  } ,
        ));
  }
}
