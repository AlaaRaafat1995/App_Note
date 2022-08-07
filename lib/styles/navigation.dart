import 'package:flutter/material.dart';

class Navigation {
  navigatepush(BuildContext context, Widget route) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => route));
  }

  navigateReplace(BuildContext context, Widget route) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => route));
  }

  navigatepop(BuildContext context) {
    Navigator.of(context).pop();
  }
}
