import 'package:autism101/Screens/user/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui';

import 'LayoutForm.dart';

class Loginform extends StatefulWidget {
  const Loginform({Key? key}) : super(key: key);

  @override
  _LoginformState createState() => _LoginformState();
}

class _LoginformState extends State<Loginform> {
  bool passwordVisible = true;
  var colorOFtext = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [
              Colors.indigo.shade900,
              Colors.purpleAccent.shade400,
            ],
          ),
        ),
        child: LayoutForm(
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
                child: Text('Login',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 35)),
              ),
              //Textfields
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    hintText: 'E-mail',
                    contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 10)),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    hintText: 'Password',
                    contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                    suffixIcon: IconButton(
                      padding: EdgeInsets.only(right: 15),
                      icon: Icon(
                          passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    )),
                keyboardType: TextInputType.visiblePassword,
                obscureText: passwordVisible,
              ),
              //*********
              TextButton(
                onPressed: () {},
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: colorOFtext,
                      decoration: TextDecoration.underline,
                      decorationColor: colorOFtext,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 40))
                ]),
              ),
              SizedBox(height: 20),
              Container(
                height: 50,
                width: 310,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(11, 1, 77, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 120),
              Container(
                child: Row(
                  children: <Widget>[
                    Text(
                      "Don't have an account?..",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/Register');
                      },
                      child: Text(
                        'Create',
                        style: TextStyle(
                            color: colorOFtext,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
