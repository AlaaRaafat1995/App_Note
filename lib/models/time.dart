import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Time extends StatefulWidget {
  Time({Key? key, required this.text}) : super(key: key);
  String text;

  @override
  State<Time> createState() => _TimeState();
}

class _TimeState extends State<Time> {
  TimeOfDay time = TimeOfDay.fromDateTime(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        TimeOfDay? newtime =
            await showTimePicker(context: context, initialTime: time);

        if (newtime == null) {
          return;
        }
        if (newtime != null) {
          setState(() {
            time = newtime;
          });
        }
      },
      child: ListTile(
        title: Text(widget.text),
        trailing: Text(
          "${time.hour > 12 ? (time.hour) - 12 : time.hour}:${time.minute} ${time.hour > 12 ? "PM" : "AM"}",
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
