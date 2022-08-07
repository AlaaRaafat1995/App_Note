import 'package:flutter/material.dart';

showLoading(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          content: SizedBox(
            height: 100,
            child: Center(
                child: CircularProgressIndicator(
              color: Colors.red,
            )),
          ),
        );
      });
}
