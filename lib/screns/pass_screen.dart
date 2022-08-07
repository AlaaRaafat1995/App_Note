import 'dart:async';

import 'package:app_note/screns/newsecretpage.dart';
import 'package:flutter/material.dart';
import 'package:passcode_screen/passcode_screen.dart';

class PassScreen extends StatefulWidget {
  const PassScreen({Key? key}) : super(key: key);

  @override
  State<PassScreen> createState() => _PassScreenState();
}

class _PassScreenState extends State<PassScreen> {
  final StreamController<bool> verificationNotifier =
      StreamController<bool>.broadcast();

  bool isAuthenticated = false;
  // void onPasscodeEntered(String enteredPasscode) {
  //   bool isValid = ("123456" == enteredPasscode);
  //   verificationNotifier.add(isValid);
  //   if (isValid) {
  //     setState(() {
  //       isAuthenticated = isValid;
  //     });
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => NewPage()));
  //   }
  // }

  void onPasscodeCancelled() {
    Navigator.maybePop(context);
  }

  @override
  void dispose() {
    verificationNotifier.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PasscodeScreen(
        title: const Text('Enter App Passcode',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 28)),
        passwordEnteredCallback: (enteredPasscode) {
          bool isValid = (enteredPasscode == "123456");
          verificationNotifier.add(false);
          if (isValid) {
            setState(() {
              isAuthenticated = isValid;
            });
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => NewSecretPage()));
          }
        },
        cancelButton: const Text("cancel"),
        deleteButton: const Text(
          'Delete',
          style: TextStyle(fontSize: 16, color: Colors.white),
          semanticsLabel: 'Delete',
        ),
        shouldTriggerVerification: verificationNotifier.stream,
        backgroundColor: Colors.black.withOpacity(0.8),
        cancelCallback: onPasscodeCancelled,
        passwordDigits: 6,
        isValidCallback: () {},
      ),
    );
  }
}
