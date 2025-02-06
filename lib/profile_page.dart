import 'package:flutter/material.dart';
import 'package:my_cst2335_labs/main.dart';
import 'package:url_launcher/url_launcher.dart';

class OtherPage extends StatefulWidget {
  const OtherPage({super.key});

  @override
  State<OtherPage> createState() => OtherPageState();
}

class OtherPageState extends State<OtherPage> {
  TextEditingController? _firstControl;
  TextEditingController? _lastControl;
  TextEditingController? _phoneControl;
  TextEditingController? _emailControl;
  double? myFontSize = 18;

  @override
  void initState() {
    super.initState();

    var openSnackBar = SnackBar(
        content: Text("Welcome bac9k ${DataRepository.loginName} 9!"),
        action: SnackBarAction(label: 'Hide', onPressed: () {}),
        duration: Duration(seconds: 6));
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ScaffoldMessenger.of(context).removeCurrentSnackBar());
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ScaffoldMessenger.of(context).showSnackBar(openSnackBar));
  }

  void etPhoneHome () async {
    final Uri phoneUri = Uri(
        scheme: 'tel',
        path: '888-123-4567');
    await launchUrl(phoneUri);
    print(phoneUri);
  }
  void etSmsHome () async {
    final Uri smsUri = Uri(scheme: 'sms', path: '888-142-2423');
    await launchUrl(smsUri);
    print(smsUri);
  }

  void etEmailHome () async {
    final Uri emailUri = Uri(
        scheme: 'mailto',
        path: 'foo@foo.com',
        queryParameters: {'subject': 'Email Subject Here!'});
       await launchUrl(emailUri);
    print(emailUri);
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
        content: Text("Welcome Back $loginName!"),
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
              Text('Welcome to my other page, ${DataRepository.loginName} !'),
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
                  Text('You hit page two, ${DataRepository.loginName} !',
                      style: TextStyle(fontSize: 24.0)),
                  TextField(
                      controller: _firstControl,
                      decoration: InputDecoration(
                          labelText: "First Name",
                          border: OutlineInputBorder()),
                      obscureText: false,
                      style: TextStyle(fontSize: myFontSize)),
                  TextField(
                      controller: _lastControl,
                      decoration: InputDecoration(
                          labelText: "Last Name", border: OutlineInputBorder()),
                      obscureText: false,
                      style: TextStyle(fontSize: myFontSize)),
                  Row(children: <Widget>[
                    Flexible(
                        child: TextField(
                            controller: _phoneControl,
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
                  Row(children: <Widget>[
                    Flexible(
                        child: TextField(
                            controller: _emailControl,
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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text('Back to Login')),
                  ),
                ])));
  }
}
