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

   //  if (DataRepository.userFirstName != '') {
    //    _userFirstNameControl?.value = DataRepository.userFirstName as TextEditingValue;
    //   _userLastNameControl?.value = DataRepository.userLastName as TextEditingValue;
    //   _userPhoneControl?.value = DataRepository.userPhone as TextEditingValue;
    //   _userEmailControl?.value = DataRepository.userEmail as TextEditingValue;



    var openSnackBar = SnackBar(
        content: Text("Welcome bac9k ${DataRepository.userFirstName} 9!"),
        action: SnackBarAction(label: 'Hide', onPressed: () {}),
        duration: Duration(seconds: 6));
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ScaffoldMessenger.of(context).removeCurrentSnackBar());
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ScaffoldMessenger.of(context).showSnackBar(openSnackBar));
  }

  void pullUserProfile() async {
    var oldUserFirstName = await DataRepository.prefs.getString("FirstName");
    var oldUserLastName = await DataRepository.prefs.getString("LastName");
    var oldUserPhoneNumber = await DataRepository.prefs.getString("userPhone");
    var oldUserEmailAddress = await DataRepository.prefs.getString("userEmail");

//TODO: fix this part up.
    if (oldUserFirstName == '' || oldUserLastName == '' ||
        oldUserPhoneNumber == '' || oldUserEmailAddress == '') {
      return;
    }
    else {
      _userFirstNameControl.text = oldUserFirstName;
      _userLastNameControl.text = oldUserLastName;
      _userPhoneControl.text = oldUserPhoneNumber;
      _userEmailControl.text = oldUserEmailAddress;
      final snackBar = SnackBar(
          content: Text('Profile loaded.'),
          action: SnackBarAction(label: 'Hide', onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          })
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
//*******



  void etPhoneHome () async {
    final Uri phoneUri = Uri(
        scheme: 'tel',
        path: '888-123-4567');
    await launchUrl(phoneUri);
   // print(phoneUri);
  }
  void etSmsHome () async {
    final Uri smsUri = Uri(scheme: 'sms', path: '888-142-2423');
    await launchUrl(smsUri);
  //  print(smsUri);
  }

  void etEmailHome () async {
    final Uri emailUri = Uri(
        scheme: 'mailto',
        path: 'foo@foo.com',
        queryParameters: {'subject': 'Email Subject Here!'});
       await launchUrl(emailUri);
   // print(emailUri);
  }
  /*
              else {
        final snackBar4 = SnackBar( content: Text('Cant access email.'),
            action:SnackBarAction(label:'Hide', onPressed: (){ScaffoldMessenger.of(context).hideCurrentSnackBar();
            }
            )
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar4);
      }
    }
    );
    }*/

  void showSnackBar3(String loginName) {
    var snackBar2 = SnackBar(
        content: Text("Welcome Back $loginName"),
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
              Text('Welcome to my other page, ${DataRepository.userFirstName} !'),
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
                  Text('You hit page two, ${DataRepository.userFirstName} !',
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
                        etPhoneHome();
                      },
                      icon: const Icon(Icons.phone),
                      label: const Text(''),
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                          etSmsHome();
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
                        etEmailHome();
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
                onPressed: () {
                  print('button pressed');

                  DataRepository.saveProfile(_userFirstNameControl.value.text, _userLastNameControl.value.text,_userPhoneControl.value.text, _userEmailControl.value.text);
                  print ("First Name is ${_userFirstNameControl.value.text}.");
                  print ("Last Name is ${_userLastNameControl.value.text}.");
                  print ("User Phone is ${_userPhoneControl.value.text}.");
                  print ("User Email is ${_userEmailControl.value.text}.");

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
