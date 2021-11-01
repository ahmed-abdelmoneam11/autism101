import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData myThemeData = ThemeData(
    scaffoldBackgroundColor: Color(0XFFF8F9FF),
    textTheme: TextTheme(
        subtitle1: TextStyle(
      fontSize: 17,
    )),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 18.0
      ),
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,

      )
    ));
