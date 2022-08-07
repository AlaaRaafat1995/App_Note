import 'package:app_note/screns/home.dart';
import 'package:app_note/screns/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

bool islogin = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    islogin = false;
  } else {
    islogin = true;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "App Note",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: islogin == false ? const LogIn() : Home());
  }
}
