import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:connectivity/connectivity.dart';
import 'LayoutForm.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/auth_bloc.dart';
import 'package:autism101/BlocEvents/auth_bloc_events.dart';
import 'package:autism101/BlocStates/auth_bloc_state.dart';
import 'package:autism101/Screens/LoginForm.dart';
import 'package:autism101/flush_bar.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool passwordVisible = true;
  bool confirmPasswordVisible = true;
  var colorOFtext = Colors.black;
  TextEditingController _codeController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  late AuthBloc authBloc;

  @override
  void dispose() {
    _codeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LodingState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text("  Loading...")
                  ],
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is ResetPasswordErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is ResetPasswordSuccessState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => Loginform(),
              ),
              (route) => false,
            );
          }
        },
        child: Container(
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
              child: Column(
                children: [
                  //Reset Password Label.
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
                    child: Text(
                      'Reset Password',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 28.0,
                      ),
                    ),
                  ),
                  //code Text Field.
                  TextField(
                    controller: _codeController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        hintText: 'Confirmation Code',
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 20, 0, 10)),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20),
                  //Password Text Field.
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        hintText: 'Password',
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 20, 0, 10),
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
                  SizedBox(height: 20),
                  //Confirm Password Name Text Field.
                  TextField(
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
                  SizedBox(height: 20),
                  //Reset Button.
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
                      onPressed: resetPassword,
                      child: Text(
                        'Reset',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void resetPassword() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Warning().errorMessage(
        context,
        title: "No internet connection !",
        message: "Please turn on wifi or mobile data",
        icons: Icons.signal_wifi_off,
      );
    } else if (_codeController.text.isEmpty) {
      Warning().errorMessage(
        context,
        title: "Code field can't be empty !",
        message: "Please enter confirmation code",
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
      authBloc.add(
        ResetPassword(
          code: _codeController.text,
          newPassword: _passwordController.text,
        ),
      );
    }
  }
}
