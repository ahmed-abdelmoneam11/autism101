import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui';

import '../Layout.dart';

class SchoolAccount extends StatefulWidget {
  const SchoolAccount({Key? key}) : super(key: key);

  @override
  _SchoolAccountstate createState() => _SchoolAccountstate();
}

class _SchoolAccountstate extends State<SchoolAccount> {
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
        child: Layout(Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0, 30, 0, 50),
              child: Text('Create an Account',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 35)),
            ),
            Container(
              alignment: Alignment.center,
              width: 330,
              padding: EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    hintText: 'Phone Number',
                    contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 10)),
                keyboardType: TextInputType.phone,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 330,
              padding: EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    hintText: 'Website',
                    contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 10)),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 330,
              padding: EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    hintText: 'Address',
                    contentPadding: const EdgeInsets.fromLTRB(30, 0, 0, 0)),
                keyboardType: TextInputType.streetAddress,
              ),
            ),
            SizedBox(height: 80),
            Container(
              height: 50,
              width: 140,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(11, 1, 77, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/loginform');
                },
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
