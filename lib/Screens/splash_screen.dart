import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:autism101/Screens/user/home_screen.dart';
import 'package:autism101/Screens/LoginForm.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  var user = auth.currentUser;
  @override
  void initState() {
    Timer(
      Duration(seconds: 4),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => user != null ? HomeScreen() : Loginform(),
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        Center(
          child: Container(
            padding: EdgeInsets.all(
              8.0,
            ),
            width: 300.0,
            height: 300.0,
            child: Image(
              image: AssetImage("assets/images/autismlogo.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 5.0,
          left: 5.0,
          child: Container(
            width: 200.0,
            height: 300.0,
            child: Image(
              image: AssetImage("assets/images/shapesmirror.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 5.0,
          right: 5.0,
          child: Container(
            width: 200.0,
            height: 300.0,
            child: Image(
              image: AssetImage("assets/images/shapes.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
