// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

AppBar appBarMain(BuildContext context) {
  return AppBar(
      title: Image.asset("assets/images/logo.png", height: 40)
  );
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.white54,
      ),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54)));
}

TextStyle simpleTextStyle(){
  return TextStyle(
  color: Colors.white,
    fontSize: 16
  );textFieldInputDecoration("email");
}

TextStyle mediumTextStyle(){
  return TextStyle(
  color: Colors.white,
    fontSize: 17
  );textFieldInputDecoration("email");
}
