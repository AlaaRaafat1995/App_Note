import 'package:app_note/models/time.dart';
import 'package:app_note/styles/switch.dart';
import 'package:app_note/styles/text.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  TimeOfDay time = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Customtext(text: "Setting")),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Customtext(
                      text: "Display aoptions",
                      color: Colors.red,
                    ),
                    SwitchTile(
                        text: Customtext(text: "Add new items to bottom")),
                    SwitchTile(
                        text: Customtext(text: "Move checked items to bottom")),
                    SwitchTile(
                        text: Customtext(
                      text: "Display rich link previews",
                    )),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Customtext(text: "Theme"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Customtext(text: "Reminder defaults", color: Colors.red),
                    Time(text: "Morning"),
                    Time(text: "Afternoon"),
                    Time(text: "Evening"),
                    Customtext(text: "Sharing", color: Colors.red),
                    SwitchTile(
                      text: Customtext(text: "Enable sharing"),
                    )
                  ])),
        ));
  }
}
