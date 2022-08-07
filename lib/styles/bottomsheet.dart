import 'package:flutter/material.dart';

Widget bottomsheet(BuildContext context, Widget widget, double height,
    {Color? color}) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(color: color, height: height, child: widget);
      });
  return const Text("");
}
