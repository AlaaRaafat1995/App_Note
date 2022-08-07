import 'package:flutter/material.dart';

snake(context, String title) {
  final snackBar = SnackBar(
      content: Text(title),
      duration: const Duration(seconds: 5),
      backgroundColor: Colors.red,
      action: SnackBarAction(
        label: "close",
        textColor: Colors.white,
        onPressed: () {},
      ));
  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
