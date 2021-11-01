import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui';

import 'Layout.dart';

class ParentAccount extends StatefulWidget {
  const ParentAccount({Key? key}) : super(key: key);

  @override
  _ParentAccountState createState() => _ParentAccountState();
}

class _ParentAccountState extends State<ParentAccount> {
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
                  hintText: 'First Name',
                  contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 10)),
              keyboardType: TextInputType.name,
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
                  hintText: 'Last Name',
                  contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 10)),
              keyboardType: TextInputType.name,
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
                  hintText: 'E-Mail',
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
                  hintText: 'Password',
                  contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 10)),
              keyboardType: TextInputType.visiblePassword,
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
                  hintText: 'Confirm Password',
                  contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 10)),
              keyboardType: TextInputType.visiblePassword,
            ),
          ),
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
                Navigator.pushReplacementNamed(context, "/parentAccount2");
              },
              child: Text(
                'Next',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/loginform');
            },
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Already Have An Account?',
                style: TextStyle(
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ]),
          ),
        ],
      )),
    ));
  }
}
