import 'package:app_note/auth/auth.dart';
import 'package:app_note/models/iconbuttons.dart';
import 'package:app_note/models/text_field.dart';
import 'package:app_note/screns/home.dart';
import 'package:app_note/screns/register.dart';
import 'package:app_note/styles/navigation.dart';
import 'package:app_note/styles/text.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final formkey = GlobalKey<FormState>();
  var email, password;
  bool ispressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(
                height: 80,
              ),
              SizedBox(
                height: 100,
                child: Image.asset(
                  "images/app-icon.jpg",
                  scale: 1,
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Textfield(
                  keyboardtype: TextInputType.emailAddress,
                  obscure: false,
                  save: (val) {
                    email = val;
                  },
                  valid: (value) {
                    String p =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

                    RegExp regExp = RegExp(p);
                    if (value!.isEmpty) {
                      return ('Please, Enter Email');
                    } else if (!regExp.hasMatch(value)) {
                      return ('Please, Enter Valid Email');
                    }
                    if (!(value.endsWith(".com"))) {
                      return ('Please, Enter Valid Email');
                    } else {
                      return null;
                    }
                  },
                  text: "Enter Your E-mail",
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Textfield(
                  keyboardtype: TextInputType.number,
                  save: (val) {
                    password = val;
                  },
                  obscure: !ispressed,
                  max: 1,
                  suffix: iconbutton(() {
                    setState(() {
                      ispressed = !ispressed;
                    });
                  },
                      ispressed
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility)),
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
                  text: "Enter Your Password",
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
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.only(left: 190, top: 10, bottom: 10),
                  child: Customtext(
                    text: "Forget Your Password ?",
                    color: Colors.grey[700],
                  )),
              TextButton(
                  onPressed: () {
                    Navigation().navigateReplace(context, const Register());
                  },
                  child: Customtext(text: "Register"),
                  style: TextButton.styleFrom(
                      primary: Colors.red, fixedSize: const Size(80, 40))),
              ElevatedButton(
                onPressed: () async {
                  var formvalid = formkey.currentState;
                  if (formvalid!.validate()) {
                    formvalid.save();
                    final users =
                        await Auth().logIn(context, email, password, Home());
                  }
                },
                child: const Text("Log In"),
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(100, 30),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ]),
          )),
    );
  }
}
