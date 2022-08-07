import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Textfield extends StatelessWidget {
  Textfield(
      {Key? key,
      required this.text,
      this.max,
      this.size,
      this.border,
      this.border1,
      this.border2,
      this.border3,
      this.save,
      this.valid,
      this.suffix,
      this.keyboardtype,
      required this.obscure,
      this.initial})
      : super(key: key);
  String text;
  int? max;
  double? size;
  InputBorder? border;
  InputBorder? border1;
  InputBorder? border2;
  InputBorder? border3;
  String? Function(String?)? valid;
  void Function(String?)? save;
  Widget? suffix;
  bool obscure;
  TextInputType? keyboardtype;
  String? initial;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          initialValue: initial,
          keyboardType: keyboardtype,
          obscureText: obscure,
          obscuringCharacter: "*",
          cursorColor: Colors.red,
          validator: valid,
          onSaved: save,
          maxLines: max,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 10),
            hintText: text,
            hintStyle: TextStyle(fontSize: size),
            enabledBorder: border,
            focusedBorder: border1,
            errorBorder: border2,
            focusedErrorBorder: border3,
            suffixIcon: suffix,
          ),
        ));
  }
}
