import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui';

import 'Layout.dart';

class ParentAccount2 extends StatefulWidget {
  const ParentAccount2({Key? key}) : super(key: key);

  @override
  _ParentAccountState createState() => _ParentAccountState();
}

class _ParentAccountState extends State<ParentAccount2> {
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
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 35)),
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
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 20, 0, 10)),
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
                        hintText: 'Age',
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 20, 0, 10)),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 50, top: 10),
                  alignment: Alignment.centerLeft,
                  child: Text('Gender ', style: TextStyle(fontSize: 25)),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.all(25)),
                    OutlinedButton.icon(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        backgroundColor: Colors.grey.shade50,
                      ),
                      onPressed: () => {},
                      icon: Icon(
                        Icons.male,
                        size: 30,
                        color: Colors.black,
                      ),
                      label: Text(
                        'male',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                    SizedBox(width: 30),
                    OutlinedButton.icon(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        backgroundColor: Colors.grey.shade50,
                      ),
                      onPressed: () => {},
                      icon: Icon(
                        Icons.female,
                        size: 30,
                        color: Colors.black,
                      ),
                      label: Text(
                        'female',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 60),
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
            ))));
  }
}
