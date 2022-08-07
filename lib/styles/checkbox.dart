import 'package:flutter/material.dart';

class Check extends StatefulWidget {
  Check({Key? key, required this.title}) : super(key: key);
  String? title;

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  bool ischecked = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        title: Text(widget.title!),
        value: ischecked,
        onChanged: (val) {
          setState(() {
            ischecked = val!;
          });
        });
  }
}
