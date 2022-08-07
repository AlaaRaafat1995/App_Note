import 'package:app_note/styles/text.dart';
import 'package:flutter/material.dart';

dialog(BuildContext context, String title, double height, Widget wid,
    {List<Widget>? actions}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Customtext(
            text: title,
          ),
          content: SizedBox(
            height: height,
            child: wid,
          ),
          actions: actions,
        );
      });

  return const Text("");
}
