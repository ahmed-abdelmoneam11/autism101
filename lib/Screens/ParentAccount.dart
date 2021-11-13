import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui';
import 'Layout.dart';
import 'package:connectivity/connectivity.dart';
import 'package:autism101/flush_bar.dart';
import 'package:autism101/Screens/ParentAccount2.dart';

class ParentAccount extends StatefulWidget {
  const ParentAccount({Key? key}) : super(key: key);

  @override
  _ParentAccountState createState() => _ParentAccountState();
}

class _ParentAccountState extends State<ParentAccount> {
  bool passwordVisible = true;
  bool confirmPasswordVisible = true;
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

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
        child: Layout(
          Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0, 30, 0, 50),
                child: Text('Create an Account',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 35)),
              ),
              //First Name Text Field.
              Container(
                alignment: Alignment.center,
                width: 330,
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      hintText: 'First Name',
                      contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 10)),
                  keyboardType: TextInputType.name,
                ),
              ),
              //Last Name Text Field.
              Container(
                alignment: Alignment.center,
                width: 330,
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      hintText: 'Last Name',
                      contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 10)),
                  keyboardType: TextInputType.name,
                ),
              ),
              //Email Name Text Field.
              Container(
                alignment: Alignment.center,
                width: 330,
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      hintText: 'E-Mail',
                      contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 10)),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              //Password Name Text Field.
              Container(
                alignment: Alignment.center,
                width: 330,
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
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
                    ),
                    hintText: 'Password',
                    contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: passwordVisible,
                ),
              ),
              //Confirm Password Name Text Field.
              Container(
                alignment: Alignment.center,
                width: 330,
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    suffixIcon: IconButton(
                      padding: EdgeInsets.only(right: 15),
                      icon: Icon(
                          confirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black),
                      onPressed: () {
                        setState(() {
                          confirmPasswordVisible = !confirmPasswordVisible;
                        });
                      },
                    ),
                    hintText: 'Confirm Password',
                    contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: confirmPasswordVisible,
                ),
              ),
              //Next Button.
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
                  onPressed: next,
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              //Log In Button.
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/loginform');
                },
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
          ),
        ),
      ),
    );
  }

  void next() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Warning().errorMessage(
        context,
        title: "No internet connection !",
        message: "Please turn on wifi or mobile data",
        icons: Icons.signal_wifi_off,
      );
    } else if (_firstNameController.text.isEmpty) {
      Warning().errorMessage(
        context,
        title: "First name field can't be empty !",
        message: "Please enter your first name.",
        icons: Icons.warning,
      );
    } else if (_lastNameController.text.isEmpty) {
      Warning().errorMessage(
        context,
        title: "last name field can't be empty !",
        message: "Please enter your last name.",
        icons: Icons.warning,
      );
    } else if (_emailController.text.isEmpty) {
      Warning().errorMessage(
        context,
        title: "Email field can't be empty !",
        message: "Please enter your email.",
        icons: Icons.warning,
      );
    } else if (!_emailController.text.contains('@')) {
      Warning().errorMessage(
        context,
        title: 'Invalid email !',
        message: "Email must contain '@' ",
        icons: Icons.warning,
      );
    } else if (_passwordController.text.isEmpty) {
      Warning().errorMessage(
        context,
        title: "Password field can't be empty !",
        message: "Please enter your password.",
        icons: Icons.warning,
      );
    } else if (_confirmPasswordController.text.isEmpty) {
      Warning().errorMessage(
        context,
        title: "ConfirmPassword field can't be empty !",
        message: "Please confirm your password.",
        icons: Icons.warning,
      );
    } else if (_passwordController.text != _confirmPasswordController.text) {
      Warning().errorMessage(
        context,
        title: "Password values doesn't match !",
        message: "Please confirm your password.",
        icons: Icons.warning,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ParentAccount2(
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            email: _emailController.text,
            password: _passwordController.text,
          ),
        ),
      );
    }
  }
}
