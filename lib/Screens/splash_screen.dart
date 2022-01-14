import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:autism101/Screens/user/home_screen.dart';
import 'package:autism101/Screens/LoginForm.dart';

// FirebaseAuth auth = FirebaseAuth.instance;

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  // var user = auth.currentUser!.email;
  var token;
  @override
  void initState() {
    Timer(Duration(seconds: 4), () async {
      var prefs = await SharedPreferences.getInstance();
      setState(() {
        token = prefs.getString("TOKEN");
      });
      if (token == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Loginform(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      }
    });
    // Timer(
    //   Duration(seconds: 4),
    //   () => Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => user != null ? HomeScreen() : Loginform(),
    //     ),
    //   ),
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.blueGrey,
        ),
        Center(
          child: Container(
            padding: EdgeInsets.all(
              8.0,
            ),
            width: 200.0,
            height: 200.0,
            child: Image(
              image: AssetImage("assets/images/autismlogo.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 250.0,
          left: 100.0,
          child: Text(
            "Autism 101",
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
