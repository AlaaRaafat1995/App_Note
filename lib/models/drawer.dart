import 'package:app_note/styles/text.dart';
import 'package:flutter/material.dart';

Widget drawer(String text, IconData icon, {void Function()? tap}) {
  return InkWell(
    onTap: tap,
    child: ListTile(
        leading: Icon(
          icon,
          color: Colors.red,
        ),
        title: Customtext(
          text: text,
          weight: FontWeight.bold,
          size: 17,
        )),
  );
}

Widget listtile(String text, IconData icon, {void Function()? tap}) {
  return InkWell(
    onTap: tap,
    child: ListTile(
        leading: Icon(
          icon,
          color: Colors.red,
        ),
        title: Customtext(
          text: text,
          weight: FontWeight.bold,
          size: 17,
        )),
  );
}
