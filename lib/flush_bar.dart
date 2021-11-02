import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

class Warning {
  void errorMessage(BuildContext context,
      {required String title,
      required String message,
      required IconData icons}) {
    Flushbar(
      titleText: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
          color: Colors.white,
          height: 1.0,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
          color: Colors.white,
          height: 1.0,
        ),
      ),
      icon: Icon(
        icons,
        size: 30,
        color: Colors.red,
      ),
      borderWidth: 5,
      duration: Duration(seconds: 3),
      borderRadius: BorderRadius.circular(10.0),
    )..show(context);
  }
}
