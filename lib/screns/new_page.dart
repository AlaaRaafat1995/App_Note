import 'dart:io';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:app_note/auth/usernote.dart';
import 'package:app_note/models/drawer.dart';
import 'package:app_note/models/iconbuttons.dart';
import 'package:app_note/models/text_field.dart';
import 'package:app_note/screns/home.dart';
import 'package:app_note/styles/bottomsheet.dart';
import 'package:app_note/styles/dialog.dart';
import 'package:app_note/styles/loading.dart';
import 'package:app_note/styles/navigation.dart';
import 'package:app_note/styles/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class NewPage extends StatefulWidget {
  NewPage({
    Key? key,
  }) : super(key: key);

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  final formkey = GlobalKey<FormState>();

  var title, note, videourl, imageurl, gallerypath;
  DateTime time = DateTime.now();
  int index = 0;
  List<IconData> items = [
    Icons.add_box_outlined,
    Icons.color_lens_outlined,
    Icons.mic_none,
    Icons.more_vert
  ];
  bool ispressed = false;

  ImagePicker image = ImagePicker();
  File? file;

  XFile? galleryimage, cameraimage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SpeedDial(
        activeIcon: Icons.close,
        overlayColor: Colors.black,
        child: const Icon(Icons.image_search_outlined),
        elevation: 0,
        spaceBetweenChildren: 15,
        spacing: 10,
        children: [
          SpeedDialChild(
              backgroundColor: Colors.white,
              foregroundColor: Colors.red,
              label: "Take Photo",
              onTap: () async {
                cameraimage = await image.pickImage(source: ImageSource.camera);
                if (cameraimage != null) {
                  setState(() {
                    file = File(cameraimage!.path);
                  });
                }
              },
              labelStyle: const TextStyle(
                  color: Colors.red, fontSize: 17, fontWeight: FontWeight.bold),
              child: const Icon(Icons.camera_alt_outlined)),
          SpeedDialChild(
              backgroundColor: Colors.white,
              foregroundColor: Colors.red,
              label: "Add Photo",
              onTap: () async {
                galleryimage =
                    await image.pickImage(source: ImageSource.gallery);
                if (galleryimage != null) {
                  setState(() {
                    file = File(galleryimage!.path);
                  });
                }
              },
              labelStyle: const TextStyle(
                  color: Colors.red, fontSize: 17, fontWeight: FontWeight.bold),
              child: const Icon(Icons.image_outlined))
        ],
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        inactiveColor: Colors.white,
        activeColor: Colors.black,
        backgroundColor: Colors.red,
        icons: items,
        activeIndex: index,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.sharpEdge,
        leftCornerRadius: 30,
        rightCornerRadius: 30,
        onTap: (int i) {
          if (i == 0) {
            bottomsheet(
                context,
                Column(children: [
                  listtile("Drawing", Icons.draw_outlined),
                  listtile("Add Video", Icons.video_call_outlined,
                      tap: () async {
                    final XFile? video =
                        await image.pickVideo(source: ImageSource.gallery);
                    if (video != null) {
                      setState(() {
                        file = File(video.path);
                      });
                    }
                  }),
                  listtile("Checkboxes", Icons.check_box_outlined, tap: () {})
                ]),
                175);
          }
          if (i == 1) {}

          if (i == 2) {}
          if (i == 3) {
            bottomsheet(
                context,
                Column(children: [
                  listtile("Delete", Icons.delete_outlined),
                  listtile("Make a copy", Icons.copy),
                  listtile("Send", Icons.share_outlined, tap: () {
                    Navigation().navigatepop(context);
                    dialog(
                      context,
                      "Share Via",
                      150,
                      Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                iconbutton(
                                  () {},
                                  const Icon(Icons.whatsapp,
                                      color: Colors.green),
                                ),
                                const Text("Whatsapp"),
                              ],
                            ),
                            Column(
                              children: [
                                iconbutton(
                                  () {},
                                  const Icon(Icons.facebook,
                                      color: Colors.blue),
                                ),
                                const Text("facebook"),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(left: 25),
                                    child: iconbutton(
                                      () {},
                                      const Icon(
                                        Icons.bluetooth,
                                        color: Colors.red,
                                      ),
                                    )),
                                const Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text("Bluetooth"),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: iconbutton(
                                      () {},
                                      Image.asset(
                                        "images/google-drive.png",
                                        height: 20,
                                      )),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 30),
                                  child: Text("Google Drive"),
                                ),
                              ],
                            )
                          ],
                        )
                      ]),
                    );
                  })
                ]),
                175);
          }
          setState(() {
            index = i;
          });
        },
      ),
      appBar: AppBar(
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 15),
            child: Customtext(
              text:
                  " Edited at ${time.hour > 12 ? (time.hour) - 12 : time.hour}:${time.minute} ${time.hour > 12 ? "PM" : "AM"}",
              weight: FontWeight.bold,
              size: 17,
            ),
          ),
          iconbutton(() {
            setState(() {
              ispressed = !ispressed;
            });
          },
              ispressed == false
                  ? const Icon(Icons.push_pin_outlined)
                  : const Icon(Icons.push_pin)),
          iconbutton(() {}, const Icon(Icons.notification_add_outlined)),
          iconbutton(() async {
            showLoading(context);
            formkey.currentState!.save();
            if (file == null) {
              UserNote usernote = UserNote(title: title, note: note);

              await FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("Notes")
                  .doc()
                  .set(usernote.toMap());
              Navigation().navigateReplace(
                  context,
                  Home(
                    file: file,
                  ));
            } else {
              gallerypath = basename(galleryimage!.path);

              Reference usermedia = FirebaseStorage.instance
                  .ref(FirebaseAuth.instance.currentUser!.uid)
                  .child("$gallerypath");
              await usermedia.putFile(file!);
              imageurl = await usermedia.getDownloadURL();

              UserNote usernote =
                  UserNote(title: title, note: note, imageurl: imageurl);

              await FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("Notes")
                  .doc()
                  .set(usernote.toMap());
              Navigation().navigateReplace(
                  context,
                  Home(
                    file: file,
                  ));
            }
          }, const Icon(Icons.save_outlined))
        ],
      ),
      body: SingleChildScrollView(
          child: Form(
        key: formkey,
        child: Column(children: [
          file == null ? Container() : Image.file(file!),
          Textfield(
            keyboardtype: TextInputType.text,
            save: (val) {
              title = val;
            },
            obscure: false,
            text: "Title",
            max: 1,
            size: 20,
            border1: InputBorder.none,
            border: InputBorder.none,
          ),
          Textfield(
            keyboardtype: TextInputType.text,
            save: (val) {
              note = val;
            },
            obscure: false,
            text: "Note",
            max: 50,
            size: 17,
            border1: InputBorder.none,
            border: InputBorder.none,
          ),
        ]),
      )),
    );
  }
}
