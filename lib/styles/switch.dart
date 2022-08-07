import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SwitchTile extends StatefulWidget {
  SwitchTile({Key? key, required this.text}) : super(key: key);
  Widget text;

  @override
  State<SwitchTile> createState() => _SwitchTileState();
}

class _SwitchTileState extends State<SwitchTile> {
  bool ischanged = false;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
        title: widget.text,
        value: ischanged,
        onChanged: (val) {
          setState(() {
            ischanged = val;
          });
        });
  }
}
