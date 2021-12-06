import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'LayoutForm.dart';
import 'package:autism101/Screens/ParentAccount.dart';
import 'package:autism101/Screens/school/SchoolAccount.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 80),
                child: Text('Register as a: ',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 35)),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SchoolAccount(),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 35 / 100,
                    height: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      color: Color.fromRGBO(11, 1, 77, 1),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text(
                          'School',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Padding(padding: EdgeInsets.only(top: 25)),
                        Align(
                          child: Icon(
                            Icons.school,
                            color: Colors.white,
                            size: 40,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 40),
                Row(children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ParentAccount(),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 35 / 100,
                      height: 110,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        color: Color.fromRGBO(11, 1, 77, 1),
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Text(
                            'Parent',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Padding(padding: EdgeInsets.only(top: 25)),
                          Icon(
                            Icons.person_sharp,
                            color: Colors.white,
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                ])
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
