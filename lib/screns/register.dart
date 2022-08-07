import 'package:app_note/auth/model.dart';
import 'package:app_note/auth/auth.dart';
import 'package:app_note/models/iconbuttons.dart';
import 'package:app_note/models/text_field.dart';
import 'package:app_note/screns/home.dart';
import 'package:app_note/screns/login.dart';
import 'package:app_note/styles/navigation.dart';
import 'package:app_note/styles/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formkey = GlobalKey<FormState>();
  var email, name, password;
  bool ispressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            iconbutton(() {
              Navigation().navigateReplace(context, const LogIn());
            }, const Icon(Icons.done))
          ],
          title: Customtext(text: "Register Form"),
          leading: Container(
              padding: const EdgeInsets.all(5),
              width: 50,
              height: 50,
              child: Image.asset(
                "images/app-icon.jpg",
                color: Colors.white,
              ))),
      body: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 80),
                Textfield(
                  keyboardtype: TextInputType.emailAddress,
                  obscure: false,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.red)),
                  border1: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.red)),
                  border2: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black)),
                  border3: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black)),
                  text: "Enter Your Name",
                  valid: (name) {
                    if (!(name!.startsWith(RegExp(r'[A-Z]')))) {
                      return "start with capital letter";
                    }
                    return null;
                  },
                  save: (val) {
                    name = val;
                  },
                ),
                Textfield(
                  keyboardtype: TextInputType.name,
                  obscure: false,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.red)),
                  border1: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.red)),
                  border2: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black)),
                  border3: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black)),
                  text: "Enter Your E-mail",
                  valid: (value) {
                    String p =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

                    RegExp regExp = RegExp(p);
                    if (value!.isEmpty) {
                      return ('Please, Enter Email');
                    } else if (!regExp.hasMatch(value)) {
                      return ('Please, Enter Valid Email');
                    } else {
                      return null;
                    }
                  },
                  save: (val) {
                    email = val;
                  },
                ),
                Textfield(
                  keyboardtype: TextInputType.number,
                  suffix: iconbutton(() {
                    setState(() {
                      ispressed = !ispressed;
                    });
                  },
                      ispressed
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility)),
                  obscure: !ispressed,
                  max: 1,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.red)),
                  border1: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.red)),
                  border2: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black)),
                  border3: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black)),
                  text: "Enter Your Password",
                  valid: (pass) {
                    RegExp regex = RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                    if (pass!.isEmpty) {
                      return 'Please enter password';
                    } else {
                      if (!regex.hasMatch(pass)) {
                        return 'Enter valid password';
                      } else {
                        return null;
                      }
                    }
                  },
                  save: (val) {
                    password = val;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    var formvalid = formkey.currentState;
                    if (formvalid!.validate()) {
                      formvalid.save();
                      Model usermodel =
                          Model(email: email, password: password, name: name);
                      final users = await Auth()
                          .signIn(context, email, password, usermodel, Home());
                      if (users != null) {
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(users.user.uid)
                            .set(usermodel.toMap());
                      }
                    }
                  },
                  child: Customtext(text: "Submit"),
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(80, 30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                )
              ],
            ),
          )),
    );
  }
}
