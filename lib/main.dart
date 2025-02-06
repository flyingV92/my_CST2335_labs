import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Named Routes Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'GonqDrive - Mockup'),
      initialRoute:'/',
      routes:
  { '/OtherPage': (context) => OtherPage(),
  },

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class DataRepository{
  static String loginName = '';
  static String firstName = '';
  static String lastName = '';
  static String phoneNumber = '';
  static String emailAddress = '';
 }

class _MyHomePageState extends State<MyHomePage> {
  //var _counter = 0.0;
  var myFontSize = 50.0;
  late bool passCheck;
  late TextEditingController _logincontrol;
  late TextEditingController _passcontrol;
  var imageSource = '../images/qmark.png';
  var imageSourceBase = '../images/Qmark.png';
  var imageSourcePass = '../images/bulb.png';
  var imageSourceFail = '../images/stop.png';
  final EncryptedSharedPreferences prefs = EncryptedSharedPreferences();

  void saveLoginDetails()  {
    if (_logincontrol.value.text == "" || _passcontrol.value.text == "") {
      emptyFields();

      return;
    }
    else if (_passcontrol.value.text == 'QWERTY123') {
      setState(()  {
        imageSource = imageSourcePass;
         prefs.setString('Login', _logincontrol.value.text);
         prefs.setString('Password', _passcontrol.value.text);
        print(_logincontrol.text);
        DataRepository.loginName = _logincontrol.text;
        print(_passcontrol.text);
        Navigator.pop(context);
        Navigator.pushNamed( context, '/OtherPage');
      }
      );
    }
    else {
      setState(() {
        imageSource = imageSourceFail;
        Navigator.pop(context);
      });
    }

    }


  void clearLogin() async {
    await prefs.remove('LoginName');
    await prefs.remove('Password');
    Navigator.pop(context);
  }

  void closeBox() {
    Navigator.pop(context);

  }

  void emptyFields() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Empty Fields'),
              content: const Text('Login or Pass is empty'),
              actions: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FilledButton(onPressed: clearLogin, child: Text('OK'))
                    ])
              ],
            ));
  }
/*
  setImageChange() {
    if (_passcontrol.value.text == 'QWERTY123') {
      setState(() {
        imageSource = imageSourcePass;
      });
    } else {
      setState(() {
        imageSource = imageSourceFail;
      });
    }
  }
*/

  alertBox() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('You pressed login.'),
        content:
            const Text('Want to save your username/password for next time?'),
        actions: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            FilledButton(onPressed: clearLogin, child: Text('Cancel')),
            FilledButton(
                onPressed: () {
                  saveLoginDetails();
                  //setImageChange();
                },
                child: Text('OK'))
          ])
        ],
      ),
    );
  }

  @override
  void initState()  {
    super.initState();
    _logincontrol = TextEditingController();
    _passcontrol = TextEditingController();
    pullLogin();
    }


  void pullLogin() async {
    var oldLogin = await prefs.getString("Login");
    var oldPass = await prefs.getString('Password');
    if (oldLogin == '' || oldPass == '') {
      return;
    }
    else {
      _logincontrol.text = oldLogin;
      _passcontrol.text = oldPass;
      final snackBar = SnackBar( content: Text('Credentials loaded.'),
          action:SnackBarAction(label:'Hide', onPressed: (){ScaffoldMessenger.of(context).hideCurrentSnackBar();
            _logincontrol.text = '';
            _passcontrol.text = '';
            setState(() {
            imageSource = imageSourceBase;
          });
          }));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      setState(()  {
        imageSource = imageSourcePass;
       }
       );
  }
  }

  @override
  void dispose() {
    _passcontrol.dispose();
    _logincontrol.dispose();
    super.dispose();
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
        body: DecoratedBox(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/algonquin.jpg"), opacity: 0.2)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('Login Window', style: TextStyle(fontSize: myFontSize)),
                  TextField(
                      controller: _logincontrol,
                      decoration: InputDecoration(
                          hintText: "Username/Email",
                          labelText: "Enter your username",
                          border: OutlineInputBorder()),
                      obscureText: false,
                      style: TextStyle(fontSize: myFontSize)),
                  TextField(
                    controller: _passcontrol,
                    decoration: InputDecoration(
                        hintText: "Password",
                        labelText: "Enter your password",
                        border: OutlineInputBorder()),
                    obscureText: true,
                    style: TextStyle(fontSize: myFontSize),
                  ),
                  ElevatedButton(
                    onPressed: alertBox,
                    child: Padding(
                        padding: EdgeInsets.all(10.0), child: Text('Login')),
                  ),
                  Image.asset(imageSource, width: 300, height: 300)
                ])));
  }
}
