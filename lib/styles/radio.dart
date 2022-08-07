import 'package:flutter/material.dart';

class RadioList extends StatefulWidget {
  RadioList(
      {Key? key,
      required this.title,
      required this.value,
      required this.change,
      required this.text,
      required this.selected})
      : super(key: key);
  String title;
  late String value;
  void Function(Object?)? change;
  var text;
  bool selected;

  @override
  State<RadioList> createState() => _RadioListState();
}

class _RadioListState extends State<RadioList> {
  @override
  Widget build(BuildContext context) {
    return RadioListTile(
        selected: widget.selected,
        title: Text(widget.title),
        value: widget.value,
        groupValue: widget.text,
        onChanged: widget.change);
  }
}
