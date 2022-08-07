import 'package:app_note/screns/new_page.dart';
import 'package:flutter/material.dart';

class Circle extends StatefulWidget {
  Circle({
    Key? key,
    required this.color,
    this.tap,
    this.wid,
  }) : super(key: key);
  Color? color;
  Widget? wid;
  void Function()? tap;

  @override
  State<Circle> createState() => _CircleState();
}

class _CircleState extends State<Circle> {
  bool isselected = false;
  Color? color1 = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: InkWell(
            onTap: () {
              setState(() {
                isselected = !isselected;
                color1 = !isselected ? Colors.blue : Colors.white;
              });
            },
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 21,
                  backgroundColor: color1,
                ),
                Positioned(
                  top: 1,
                  right: 0.5,
                  left: 0.5,
                  child: CircleAvatar(
                      child: !isselected
                          ? const Icon(
                              Icons.done,
                              color: Colors.black,
                            )
                          : Container(),
                      radius: 20,
                      backgroundColor: widget.color),
                ),
              ],
            )));
  }
}
