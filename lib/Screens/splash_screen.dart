import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:autism101/Screens/admin/admin_home.dart';
import 'package:autism101/Screens/user/home_screen.dart';
import 'package:autism101/Screens/LoginForm.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    Timer(Duration(seconds: 8), () {
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
            // builder: (context) => Admin_Home(),
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
      body: Stack(
        children: [
          //Logo.
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image(
              image: AssetImage("assets/images/splashgif.gif"),
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
