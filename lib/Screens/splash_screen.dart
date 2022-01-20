import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:autism101/Screens/user/home_screen.dart';
import 'package:autism101/Screens/LoginForm.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  FirebaseAuth auth = FirebaseAuth.instance;
  var token;
  @override
  void initState() {
    Timer(Duration(seconds: 4), () {
      if (auth.currentUser != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Loginform(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Stack(
        children: [
          //Logo.
          Positioned(
            left: 135.0,
            top: 230.0,
            child: Container(
              width: 150.0,
              height: 150.0,
              child: Image(
                image: AssetImage("assets/images/autismlogo.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          //App Name.
          Positioned(
            top: 450.0,
            left: 110.0,
            child: Container(
              child: Text(
                "Autism 101",
                style: TextStyle(
                  fontFamily: "Futura",
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
