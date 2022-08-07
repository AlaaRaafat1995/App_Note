import 'package:flutter/material.dart';

Widget iconbutton(void Function() pressed, Widget icon, {Color? color}) {
  return IconButton(onPressed: pressed, icon: icon);
}
