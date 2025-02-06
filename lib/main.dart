import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
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
      title: 'gonqDrive',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'gONQDRIVER - Mockup'),
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
  static final EncryptedSharedPreferences prefs = EncryptedSharedPreferences();

  //this function should load the variables from EncryptedSharedPreferences
  static loadData() {
    prefs.getString('Login');
    prefs.getString('Password');
  }

    static loadProfile() {
  // String[] profileData = new String;
    prefs.getString('FirstName');
    prefs.getString('LastName');
    prefs.getString('UserPhone');
    prefs.getString('UserEmail');
  }

  //this function should save the variables to EncryptedSharedPreferences.
 static saveData(String userLoginName, String userPassword) {
   prefs.setString('Login', userLoginName);
   prefs.setString('Password', userPassword);
 }

 static saveProfile(String userFirstName, String userLastName, String userPhone, String userEmail) {
    prefs.setString('FirstName', userFirstName);
    prefs.setString('LastName', userLastName);
    prefs.setString('UserPhone', userPhone);
    prefs.setString('UserEmail', userEmail);
    print (prefs.getString('UserEmail'));
  }

  static String userLoginName = '';
  static String userPassword = '';

  static String? userFirstName;
  static String? userLastName;
  static String? userPhone;
  static  String? userEmail;
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

        DataRepository.userLoginName = _logincontrol.value.text;
        DataRepository.userPassword = _passcontrol.value.text;
        DataRepository.saveData(_logincontrol.value.text, _passcontrol.value.text );
      //  DataRepository.prefs.setString('Password', _passcontrol.value.text);
        //print(_logincontrol.text);
        DataRepository.userLoginName = _logincontrol.text;
       // print(_passcontrol.text);
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


   clearLogin() async {
    await prefs.remove('LoginName');
    await prefs.remove('Password');
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
                      FilledButton(onPressed: () {clearLogin();Navigator.pop(context);}, child: Text('OK'))
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
            FilledButton(onPressed: () {clearLogin();Navigator.pop(context);}, child: Text('Cancel')),
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
      var oldLogin = await DataRepository.prefs.getString("Login");
      var oldPass = await DataRepository.prefs.getString('Password');
      if (oldLogin == '' || oldPass == '') {
        return;
      }
      else {
        _logincontrol.text = oldLogin;
        _passcontrol.text = oldPass;
        final snackBar = SnackBar( content: Text('Credentials loaded.'),
            action:SnackBarAction(label:'Hide', onPressed: (){ScaffoldMessenger.of(context).hideCurrentSnackBar();
            //    _logincontrol.text = '';
            //   _passcontrol.text = '';
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
