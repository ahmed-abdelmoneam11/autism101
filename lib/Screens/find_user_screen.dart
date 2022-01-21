import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:connectivity/connectivity.dart';
import 'LayoutForm.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/auth_bloc.dart';
import 'package:autism101/BlocEvents/auth_bloc_events.dart';
import 'package:autism101/flush_bar.dart';
import 'package:autism101/Screens/reset_password_screen.dart';

class FindUser extends StatefulWidget {
  @override
  _FindUserState createState() => _FindUserState();
}

class _FindUserState extends State<FindUser> {
  TextEditingController _emailController = TextEditingController();
  late AuthBloc authBloc;
  var colorOFtext = Colors.black;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
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
        child: LayoutForm(
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: [
              //Find User Label.
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
                child: Text(
                  'Find User By Email',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 28,
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              //Email Text Field.
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    hintText: 'E-mail',
                    contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 10)),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 50.0,
              ),
              //Find User Button.
              Container(
                height: 35.0,
                width: 200.0,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(11, 1, 77, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                  ),
                  onPressed: findUser,
                  child: Text(
                    'Find User',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void findUser() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Warning().errorMessage(
        context,
        title: "No internet connection !",
        message: "Please turn on wifi or mobile data",
        icons: Icons.signal_wifi_off,
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
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              elevation: 1.0,
              title: Text(
                "Sign Out",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 21.0,
                  height: 1.3,
                ),
              ),
              content: Text(
                "Confirmation Code will be sent to this email address",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                  height: 1.3,
                ),
              ),
              actions: [
                TextButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                      height: 1.3,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                      height: 1.3,
                    ),
                  ),
                  onPressed: () {
                    authBloc.add(
                      SendConfirmationCode(
                        email: _emailController.text,
                      ),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResetPasswordScreen(),
                      ),
                    );
                  },
                ),
              ],
            );
          });
    }
  }
}
