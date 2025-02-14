

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
  double? myFontSize = 18;

  //********
  @override
  void initState() {
    super.initState();
    _userFirstNameControl = TextEditingController();
    _userLastNameControl = TextEditingController();
    _userPhoneControl = TextEditingController();
    _userEmailControl = TextEditingController();

    var openSnackBar = SnackBar(
        content: Text("Welcome bac9k ${DataRepository.userLoginName} 9!"),
        action: SnackBarAction(label: 'Hide', onPressed: () {}),
        duration: Duration(seconds: 6));
    WidgetsBinding.instance.addPostFrameCallback(
            (_) => ScaffoldMessenger.of(context).removeCurrentSnackBar());
    WidgetsBinding.instance.addPostFrameCallback(
            (_) => ScaffoldMessenger.of(context).showSnackBar(openSnackBar));

  pullLogin();
}
//*******

  void pullLogin() async {
    var oldFirst = await DataRepository.prefs.getString('FirstName');
    var oldLast = await DataRepository.prefs.getString('LastName');
    var oldPhone = await DataRepository.prefs.getString('UserPhone');
    var oldEmail = await DataRepository.prefs.getString('UserEmail');
    if (oldFirst == '' || oldLast == '' || oldPhone == '' || oldEmail == '') {
      return;
    }
    else {
      _userFirstNameControl.text = oldFirst;
      _userLastNameControl.text = oldLast;
      _userPhoneControl.text = oldPhone;
      _userEmailControl.text = oldEmail;

      final snackBar = SnackBar( content: Text('Credentials loaded.'),
          action:SnackBarAction(label:'Hide', onPressed: (){ScaffoldMessenger.of(context).hideCurrentSnackBar();}));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void etPhoneHome (String uriInput, String category)  {
    Uri uriMethod;
    switch (category) {
      case '1':
       Uri uriMethod = Uri(scheme: 'tel', path: uriInput);

      break;
      case '2':
        Uri uriMethod = Uri(scheme: 'sms', path: uriInput);
      break;
      case '3':
        Uri uriMethod = Uri(scheme: 'mailto', path: uriInput,
            queryParameters: {'subject': 'Email Subject Here!'});
      break;
          };
    canLaunchUrl(uriMethod).then((bool itCan) {
  //LAB 5 DEMO: FOR TESTING IF IF ERRORS WORK.
     itCan = false;
      if(itCan)
    {
      if(category == '1') {
        final Uri smsUri = Uri(scheme: 'tel', path: uriInput.toString());
        print(smsUri);
        launchUrl(smsUri);
      }
      else if (category == '2') {
        final Uri phoneUri = Uri(scheme:'sms', path: uriInput.toString());
        print(phoneUri);
        launchUrl(phoneUri);
      }
      else if (category == '3') {
        final Uri emailUri = Uri(scheme: 'mailto', path: 'foo@foo.com',
            queryParameters: {'subject': 'Email Subject Here!'});
        print(emailUri);
        launchUrl(emailUri);
      }
    }

      /*
      else {
        var snackBar5 = (String? input) => SnackBar(content: Text(input ?? 'Non-specfic error'),
            action:SnackBarAction(label:'Hide', onPressed: (){ScaffoldMessenger.of(context).hideCurrentSnackBar();}));

        if(category ==  '1') {
          var input = "Can't do SMS here.";
          ScaffoldMessenger.of(context).showSnackBar(snackBar5(input));
        }
        else if(category == '2') {
          var input = "Can't phone home.";
          ScaffoldMessenger.of(context).showSnackBar(snackBar5(input));
        }
        else if(category == '3') {
          var input = "Can't email on this device.";
          ScaffoldMessenger.of(context).showSnackBar(snackBar5(input));
        };
  }*/ else {
alertBox();
        };
  }
    );}

  alertBox() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Uri Error'),
        content:
        const Text("Your device can't use that method."),
        actions: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            FilledButton(onPressed: () {;Navigator.pop(context);}, child: Text('OK')),
          ])
        ],
      ),
    );
  }

  void showSnackBar3(String loginName) {
    var loginTitle = loginName;
    var snackBar2 = SnackBar(
        content: Text("Welcome Back $loginTitle"),
        action: SnackBarAction(
            label: 'Hide',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            }));
    ScaffoldMessenger.of(context).showSnackBar(snackBar2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title:
              Text('Welcome to my other page, ${DataRepository.userLoginName} !'),
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
                  Text('You hit page two, ${DataRepository.userLoginName} !',
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
