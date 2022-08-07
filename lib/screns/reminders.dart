import 'package:app_note/models/drawer.dart';
import 'package:app_note/models/iconbuttons.dart';
import 'package:app_note/models/search.dart';
import 'package:app_note/screns/home.dart';
import 'package:app_note/screns/archive.dart';
import 'package:app_note/screns/secretnote.dart';
import 'package:app_note/screns/login.dart';
import 'package:app_note/screns/settings.dart';
import 'package:app_note/screns/trash.dart';
import 'package:app_note/styles/loading.dart';
import 'package:app_note/styles/navigation.dart';
import 'package:app_note/styles/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Reminders extends StatelessWidget {
  const Reminders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Customtext(text: "Reminders"), actions: [
        iconbutton(() {
          showSearch(context: context, delegate: SearchBox());
        }, const Icon(Icons.search))
      ]),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.red, Colors.yellow],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight)),
                accountName: Customtext(
                  text: "lola raafat",
                  color: Colors.black,
                ),
                accountEmail: Customtext(
                    text: "lolaraafat1995@gmail.com", color: Colors.black),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Customtext(text: "LR"),
                )),
            drawer(
              "Notes",
              Icons.lightbulb_outline,
              tap: () {
                Navigation().navigateReplace(context, Home());
              },
            ),
            drawer("Secret Notes", Icons.https_outlined, tap: () {
              Navigation().navigatepop(context);
              Navigation().navigatepush(context, SecretNotes());
            }), // ListTile(
            drawer("Reminders", Icons.notifications_none_outlined, tap: (() {
              Navigation().navigatepop(context);
              Navigation().navigateReplace(context, const Reminders());
            })),

            drawer("Archive", Icons.archive_outlined, tap: () {
              Navigation().navigatepop(context);
              Navigation().navigateReplace(context, const Archive());
            }),
            drawer("Tarsh", Icons.delete_outline, tap: () {
              Navigation().navigatepop(context);
              Navigation().navigateReplace(context, const Trash());
            }),

            drawer("Settings", Icons.settings_outlined, tap: () {
              Navigation().navigatepop(context);
              Navigation().navigatepush(context, const Setting());
            }),

            drawer("Log Out", Icons.logout_outlined, tap: () async {
              showLoading(context);
              await FirebaseAuth.instance.signOut();

              Navigation().navigateReplace(context, const LogIn());
            })
          ],
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.notifications_none,
              size: 100,
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            Customtext(
              text: "Notes With Upcoming Reminders Appear Here",
              color: Colors.red,
              weight: FontWeight.bold,
            )
          ],
        ),
      ),
    );
  }
}
