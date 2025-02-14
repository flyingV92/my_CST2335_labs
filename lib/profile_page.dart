


import 'package:flutter/material.dart';
import 'package:my_cst2335_labs/main.dart';
import 'package:url_launcher/url_launcher.dart';


class OtherPage extends StatefulWidget {
  const OtherPage({super.key});


  @override
  State<OtherPage> createState() => OtherPageState();
}

class OtherPageState extends State<OtherPage> {
  late TextEditingController _userFirstNameControl;
  late TextEditingController _userLastNameControl;
  late TextEditingController _userPhoneControl;
  late TextEditingController _userEmailControl;
   String loginName = '';
   String loginName2 = '';
  late var profileString;

  double? myFontSize = 18;

  //********
  @override
  void initState() {
    super.initState();

    _userFirstNameControl = TextEditingController();
    _userLastNameControl = TextEditingController();
    _userPhoneControl = TextEditingController();
    _userEmailControl = TextEditingController();
//TODO: review the lifecycle and get it to load the snackbar and widget with username at same time.
    loadProfile();
    setState((){loginName = loginName2;});
    displaySnack(input: loginName);
}

void loadProfile()async{
  profileString = await DataRepository.loadProfile();
  _userFirstNameControl.text = profileString[0];
  _userLastNameControl.text = profileString[1];
  _userPhoneControl.text = profileString[2];
  _userEmailControl.text = profileString[3];
  loginName2 = profileString[4];
  print(profileString[4]);
  print(loginName2);

}

  void etPhoneHome (String uriInput, String category)  {
    late Uri uriMethod;
    switch (category) {
      case '1':
       Uri uriMethod2 = Uri(scheme: 'tel', path: uriInput);
       uriMethod = uriMethod2;
      break;
      case '2':
        Uri uriMethod2 = Uri(scheme: 'sms', path: uriInput);
        uriMethod = uriMethod2;
      break;
      case '3':
        Uri uriMethod2 = Uri(scheme: 'mailto', path: uriInput,
            queryParameters: {'subject': 'Email Subject Here!'});
        uriMethod = uriMethod2;
      break;
          };
    canLaunchUrl(uriMethod).then((bool itCan) {
  //LAB 5 DEMO: FOR TESTING IF IF ERRORS WORK.
     //itCan = true;
      if(itCan) {
        launchUrl(uriMethod);
        print(uriMethod);
      } else {

          alertBox();
        };
      });
  }


  alertBox() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Uri Error'),
        content:
        const Text("Your device can't use this URL."),
        actions: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            FilledButton(onPressed: () {;Navigator.pop(context);}, child: Text('OK')),
          ])
        ],
      ),
    );
  }

  displaySnack({String input = 'user'}) {
    var openSnackBar = SnackBar(
        content: Text(
            "Welcome back $input!"),
        action: SnackBarAction(label: 'Close', onPressed: () {}),
        duration: Duration(seconds: 4));
    WidgetsBinding.instance.addPostFrameCallback(
            (_) => ScaffoldMessenger.of(context).removeCurrentSnackBar());
    WidgetsBinding.instance.addPostFrameCallback(
            (_) => ScaffoldMessenger.of(context).showSnackBar(openSnackBar));
        }

  @override
  Widget build(BuildContext context) {
    var loginTitle = loginName;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title:
              Text('Welcome to page two, $loginTitle!'),
        ),
        body: DecoratedBox(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("images/algonquin.jpg"),
              opacity: 0.2,
            )),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Profile Page',
                      style: TextStyle(fontSize: 24.0)),
                  TextField(
                      controller: _userFirstNameControl,
                      decoration: InputDecoration(
                          labelText: "First Name",
                          border: OutlineInputBorder()),
                      obscureText: false,
                      style: TextStyle(fontSize: myFontSize)),
                  TextField(
                      controller: _userLastNameControl,
                      decoration: InputDecoration(
                          labelText: "Last Name", border: OutlineInputBorder()),
                      obscureText: false,
                      style: TextStyle(fontSize: myFontSize)),
                  Row(children: <Widget>[
                    Flexible(
                        child: TextField(
                            controller: _userPhoneControl,
                            decoration: InputDecoration(
                                labelText: "Phone Number",
                                border: OutlineInputBorder()),
                            obscureText: false,
                            style: TextStyle(fontSize: myFontSize))),
                    //add phone and chat buttons here.
                    ElevatedButton.icon(
                      onPressed: () {
                        var string99 = _userPhoneControl.text;

                        etPhoneHome(string99, '1');
                      },
                      icon: const Icon(Icons.phone),
                      label: const Text(''),
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                          var string99 = _userPhoneControl.text;
                          etPhoneHome(string99, '2');
                        },
                        icon: const Icon(Icons.sms),
                        label: const Text('')),
                  ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                    Flexible(
                        child: TextField(
                            controller: _userEmailControl,
                            decoration: InputDecoration(
                                labelText: "Email Address",
                                border: OutlineInputBorder()),
                            obscureText: false,
                            style: TextStyle(fontSize: myFontSize))),
                    //add phone and chat buttons here.
                    ElevatedButton.icon(
                      onPressed: () {
                        var string99 = _userEmailControl.text;
                        etPhoneHome(string99, '3');
                      },
                      icon: const Icon(Icons.email),
                      label: const Text(''),
                    ),
                  ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text('Back to Login')),
                  ),
              ElevatedButton(
                onPressed: () async{
                  print('button pressed');

                  await DataRepository.saveProfile(_userFirstNameControl.value.text, _userLastNameControl.value.text,_userPhoneControl.value.text, _userEmailControl.value.text);

                       },
                child: Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Text('Save Data')),
              ),
                ]
            )
                ]
            )
        )
    );
  }
}
