import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

//void buttonClicked(){

//}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),

        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'GonqDrive - Mockup'),
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
  var myFontSize = 50.0;
  late bool passCheck;
  late TextEditingController _logincontrol;
  late TextEditingController _passcontrol;
  var imageSource = '../images/qmark.png';
  var imageSourcePass = '../images/bulb.png';
  var imageSourceFail = '../images/stop.png';

  String getText() {
    var myPass = _passcontrol.value.text;
    print (myPass);
    return myPass;

  }


   setImageChange() {
    if(_passcontrol.value.text == 'QWERTY123') {
      setState(() {
        imageSource = imageSourcePass;  });
    }
    else {
      setState(() {
        imageSource = imageSourceFail;      });
    }
    }


  @override
  void initState() {
    super.initState();
    _logincontrol = TextEditingController();
    _passcontrol = TextEditingController();
  }


  @override
  void dispose() {
    _passcontrol.dispose();
    _logincontrol.dispose();
    super.dispose();
  }
  void setNewValue(double value)
  {
    setState(() {
      _counter = value;
      myFontSize = value;
    });
  }


  void _incrementCounter() {
    setState(() {
          if( _counter <= 99.0) {
        _counter++;}
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body:
          DecoratedBox(
        decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("images/algonquin.jpg"), opacity: 0.2)),

        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

             Text(
              'Login Window',
                style: TextStyle(fontSize: myFontSize
                )
            ),
          TextField(controller: _logincontrol,
              decoration: InputDecoration(
                  hintText:"Username/Email",
                  labelText: "Enter your username",
                  border: OutlineInputBorder()),
          obscureText: false,
          style: TextStyle(fontSize: myFontSize)),

            TextField(controller: _passcontrol,
                decoration: InputDecoration(
                    hintText:"Password",
                    labelText: "Enter your password",
                    border: OutlineInputBorder()),
              obscureText: true,
            style: TextStyle(fontSize: myFontSize),),
            ElevatedButton(onPressed: setImageChange, child: Padding(
                padding: EdgeInsets.all(10.0),child: Text('Login')),),
           Image.asset(imageSource, width: 300, height: 300)

  ]
        )
          )
    );
  }
}
