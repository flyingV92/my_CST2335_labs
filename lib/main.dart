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
        drawer: Drawer(child: Text("Hello, I made the burger!")),
        appBar: AppBar(

            backgroundColor: Theme
                .of(context)
                .colorScheme
                .inversePrimary,
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text(widget.title),
            actions: [
              OutlinedButton(onPressed: () {}, child: Text("David")),
              OutlinedButton(onPressed: () {}, child: Text("Lab"))]
        ),
        body: Center(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                   Text('BROWSE CATEGORIES',style: TextStyle(fontSize: myFontSize),),
                  Text('Not sure about exactly which recipe you are looking for? Do a search, or dive into our most popular categories.',
                    style: TextStyle(fontSize: 16),),

                Text(
                    'BY MEAT',
                    style: TextStyle(fontSize: myFontSize, fontWeight: FontWeight.w700)
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:<Widget>[
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    CircleAvatar(
                        backgroundImage: AssetImage("images/1beef.jpg"),
                        radius: 50),
                    Text("BEEF", style: TextStyle(
                        fontSize: 20.0, backgroundColor: Colors.transparent, color:Colors.white, fontWeight: FontWeight.w700),),

                  ],
                ),
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    CircleAvatar(
                        backgroundImage: AssetImage("images/2chicken.webp"),
                        radius: 50),
                    Text("CHICKEN", style: TextStyle(
                        fontSize: 20.0, backgroundColor: Colors.transparent, color:Colors.white, fontWeight: FontWeight.w700),),

                  ],
                ),
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    CircleAvatar(
                        backgroundImage: AssetImage("images/3pork.webp"),
                        radius: 50),
                    Text("PORK", style: TextStyle(
                        fontSize: 20.0, backgroundColor: Colors.transparent, color:Colors.white, fontWeight: FontWeight.w700 ), ),

                  ],
                ),
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        CircleAvatar(
                            backgroundImage: AssetImage("images/4seafood.jpg"),
                            radius: 50),
                        Text("SEAFOOD", style: TextStyle(
                            fontSize: 20.0, backgroundColor: Colors.transparent, color:Colors.white, fontWeight: FontWeight.w700),),

                      ],
                    ),

              ],),
            Text(
                'BY COURSE',
                style: TextStyle(fontSize: myFontSize, fontWeight: FontWeight.w700)
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:<Widget>[
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: <Widget>[
                      CircleAvatar(
                          backgroundImage: AssetImage("images/5mains.jpg"),
                          radius: 50),
                      Text("Main Dishes", style: TextStyle(
                          fontSize: 16.0, backgroundColor: Colors.transparent, color:Colors.black, fontWeight: FontWeight.w700),),

                    ],
                  ),
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: <Widget>[
                      CircleAvatar(
                          backgroundImage: AssetImage("images/6salad.jpg"),
                          radius: 50),
                      Text("Salad Recipes", style: TextStyle(
                          fontSize: 16.0, backgroundColor: Colors.transparent, color:Colors.black, fontWeight: FontWeight.w700),),

                    ],
                  ),
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: <Widget>[
                      CircleAvatar(
                          backgroundImage: AssetImage("images/7sides.webp"),
                          radius: 50),
                      Text("Side Dishes", style: TextStyle(
                          fontSize: 16.0, backgroundColor: Colors.transparent, color:Colors.black, fontWeight: FontWeight.w700),),

                    ],
                  ),
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: <Widget>[
                      CircleAvatar(
                          backgroundImage: AssetImage("images/8crock.jpg"),
                          radius: 50),
                      Text("Crockpot", style: TextStyle(
                          fontSize: 16.0, backgroundColor: Colors.transparent, color:Colors.black, fontWeight: FontWeight.w700),),

                    ],
                  ),
  ],),
                Text(
                    'BY DESSERT',
                    style: TextStyle(fontSize: myFontSize, fontWeight: FontWeight.w700)
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:<Widget>[
                      Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: <Widget>[
                          CircleAvatar(
                              backgroundImage: AssetImage("images/icecream.jpeg"),
                              radius: 50),
                          Text("Ice Cream", style: TextStyle(
                              fontSize: 16.0, backgroundColor: Colors.transparent, color:Colors.black, fontWeight: FontWeight.w700),),

                        ],
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: <Widget>[
                          CircleAvatar(
                              backgroundImage: AssetImage("images/brownies.jpeg"),
                              radius: 50),
                          Text("Brownies", style: TextStyle(
                              fontSize: 16.0, backgroundColor: Colors.transparent, color:Colors.black, fontWeight: FontWeight.w700),),

                        ],
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: <Widget>[
                          CircleAvatar(
                              backgroundImage: AssetImage("images/pie.jpeg"),
                              radius: 50),
                          Text("Pie", style: TextStyle(
                              fontSize: 16.0, backgroundColor: Colors.transparent, color:Colors.black, fontWeight: FontWeight.w700),),

                        ],
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: <Widget>[
                          CircleAvatar(
                              backgroundImage: AssetImage("images/cookies.webp"),
                              radius: 50),
                          Text("Cookies", style: TextStyle(
                              fontSize: 16.0, backgroundColor: Colors.transparent, color:Colors.black, fontWeight: FontWeight.w700),),

                        ],
                      )
            //BottomNavigationBar: BottomNavigationBar(items: [
            //  BottomNavigationBarItem(
              //    icon: Icon(Icons.access_alarm), label: 'Alarm Clock'),
            //  BottomNavigationBarItem(
            //      icon: Icon(Icons.accessibility), label: 'You'),
          //  ],
           //   onTap: (buttonIndex) {},
            ],
                ),
              ],
            ),
        ),
    )
    ;
  }}
