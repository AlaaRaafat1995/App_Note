import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Customtext extends StatelessWidget {
  Customtext(
      {Key? key,
      required this.text,
      this.color,
      this.size,
      this.weight,
      this.style,
      this.flow})
      : super(key: key);
  String text;
  Color? color;
  FontWeight? weight;
  double? size;
  FontStyle? style;
  TextOverflow? flow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: weight,
          fontStyle: style,
          overflow: flow),
    );
  }
}
