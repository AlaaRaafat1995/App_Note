// ignore: file_names

import 'dart:io';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:app_note/models/drawer.dart';
import 'package:app_note/models/iconbuttons.dart';
import 'package:app_note/screns/editnote.dart';
import 'package:app_note/screns/new_page.dart';
import 'package:app_note/models/search.dart';
import 'package:app_note/screns/archive.dart';
import 'package:app_note/screns/login.dart';
import 'package:app_note/screns/pass_screen.dart';
import 'package:app_note/screns/reminders.dart';
import 'package:app_note/screns/secretnote.dart';
import 'package:app_note/screns/settings.dart';
import 'package:app_note/screns/trash.dart';
import 'package:app_note/styles/dialog.dart';
import 'package:app_note/styles/loading.dart';
import 'package:app_note/styles/navigation.dart';
import 'package:app_note/styles/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Home extends StatefulWidget {
  Home({Key? key, this.file}) : super(key: key);
  File? file;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CollectionReference users = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("Notes");

  int index = 0;
  List<IconData> items = [
    Icons.home,
    Icons.https_outlined,
    Icons.settings_outlined,
    Icons.account_circle_outlined
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: SpeedDial(
          activeIcon: Icons.close,
          overlayColor: Colors.black,
          child: const Icon(Icons.add),
          elevation: 0,
          spaceBetweenChildren: 15,
          spacing: 10,
          children: [
            SpeedDialChild(
                backgroundColor: Colors.white,
                foregroundColor: Colors.red,
                label: " Secret Note",
                onTap: () =>
                    {Navigation().navigatepush(context, const PassScreen())},
                labelStyle: const TextStyle(
                    color: Colors.red,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
                child: const Icon(Icons.lock_outlined)),
            SpeedDialChild(
                backgroundColor: Colors.white,
                foregroundColor: Colors.red,
                label: "Note",
                onTap: () => {Navigation().navigatepush(context, NewPage())},
                labelStyle: const TextStyle(
                    color: Colors.red,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
                child: const Icon(Icons.lock_open))
          ],
        ),
        bottomNavigationBar: AnimatedBottomNavigationBar(
          inactiveColor: Colors.white,
          activeColor: Colors.black,
          backgroundColor: Colors.red,
          icons: items,
          activeIndex: index,
          gapLocation: GapLocation.end,
          notchSmoothness: NotchSmoothness.sharpEdge,
          leftCornerRadius: 30,
          // rightCornerRadius: 30,
          onTap: (int i) {
            if (i == 0) {
              Navigation().navigateReplace(context, Home());
            }
            if (i == 1) {
              Navigation().navigatepush(context, SecretNotes());
            }
            if (i == 2) {
              Navigation().navigatepush(context, const Setting());
            }
            if (i == 3) {}
            setState(() {
              index = i;
            });
          },
        ),
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
                    text: "Lola Raafat",
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
        appBar: AppBar(title: Customtext(text: "My Notes"), actions: [
          iconbutton(() {
            showSearch(context: context, delegate: SearchBox());
          }, const Icon(Icons.search))
        ]),
        body: FutureBuilder<QuerySnapshot>(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, i) {
                  String docs = snapshot.data!.docs[i].id;

                  return Dismissible(
                      // direction: DismissDirection.vertical,
                      // secondaryBackground: Container(
                      //   padding: const EdgeInsets.only(left: 50),
                      //   color: Colors.yellow,
                      //   child: Column(
                      //     children: const [
                      //       Icon(Icons.archive_outlined),
                      //       Text("Archive")
                      //     ],
                      //   ),
                      // ),
                      // background: Container(
                      //   alignment: Alignment.center,
                      //   padding: const EdgeInsets.only(right: 50),
                      //   color: Colors.red,
                      //   child: Column(
                      //     children: const [
                      //       Icon(Icons.delete_outline_outlined),
                      //       Text("Delete")
                      //     ],
                      //   ),
                      // ),
                      // confirmDismiss: (direction) async {
                      //   await dialog(context, "Delete Confirmation", 30,
                      //       const Text("Do you want to delete this note"),
                      //       actions: [
                      //         ElevatedButton(
                      //             onPressed: () {
                      //               Navigation().navigatepop(context);
                      //             },
                      //             child: const Text("Cancel")),
                      //         ElevatedButton(
                      //             onPressed: () {
                      //               Navigation().navigatepop(context);
                      //             },
                      //             child: const Text("ok"))
                      //       ]);
                      // },
                      onDismissed: (direction) async {
                        setState(() {
                          users.doc(docs).delete();
                          FirebaseStorage.instance
                              .refFromURL(snapshot.data?.docs[i]["imageurl"])
                              .delete();
                        });
                      },
                      key: UniqueKey(),
                      child: InkWell(
                          onTap: () {
                            showLoading(context);

                            Navigation().navigatepush(
                                context,
                                EditNote(
                                  title: snapshot.data?.docs[i]["title"],
                                  note: snapshot.data?.docs[i]["note"],
                                  imageurl: snapshot.data?.docs[i]["imageurl"],
                                  docs: docs,
                                ));
                          },
                          child: Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    widget.file == null
                                        ? Container()
                                        : Image.network(
                                            snapshot.data!.docs[i]["imageurl"]),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Customtext(
                                        text: snapshot.data?.docs[i]["title"],
                                        weight: FontWeight.bold,
                                        size: 15,
                                        style: FontStyle.italic,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Customtext(
                                          text: snapshot.data?.docs[i]["note"]),
                                    ),
                                  ]))));
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
          future: users.get(),
        ));
  }
}
// create database
// create table
// open database
// insert data base
// get database
// update database'
// delete databases
