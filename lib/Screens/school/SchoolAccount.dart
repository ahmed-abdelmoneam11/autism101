import 'dart:ui';
import 'dart:io';
import '../Layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:connectivity/connectivity.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/auth_bloc.dart';
import 'package:autism101/BlocEvents/auth_bloc_events.dart';
import 'package:autism101/BlocStates/auth_bloc_state.dart';
import 'package:autism101/flush_bar.dart';
import 'package:autism101/Screens/user/home_screen.dart';

class SchoolAccount extends StatefulWidget {
  const SchoolAccount({Key? key}) : super(key: key);

  @override
  _SchoolAccountstate createState() => _SchoolAccountstate();
}

class _SchoolAccountstate extends State<SchoolAccount> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _webSiteController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool passwordVisible = true;
  bool confirmPasswordVisible = true;
  bool hasProfilePicture = false;
  late File profilePicture;
  List<String> profilePictureOptions = [
    'Profile Picture',
    'Take photo',
    'Choose existing photo'
  ];
  String _selectedProfilePictureOption = "Profile Picture";
  late AuthBloc authBloc;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _webSiteController.dispose();
    _addressController.dispose();
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
          } else if (state is SignUpForSchoolErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is SignUpForSchoolSuccessState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
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
          child: Layout(
            Column(
              children: [
                //Create Account Label.
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
                    controller: _nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        hintText: 'Name',
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 20, 0, 10)),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                //Phone Number Text Field.
                Container(
                  alignment: Alignment.center,
                  width: 330,
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    controller: _phoneController,
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
                //WebSite Text Field.
                Container(
                  alignment: Alignment.center,
                  width: 330,
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    controller: _webSiteController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        hintText: 'Website',
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 20, 0, 10)),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                //Address Text Field.
                Container(
                  alignment: Alignment.center,
                  width: 330,
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    controller: _addressController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        hintText: 'Address',
                        contentPadding: const EdgeInsets.fromLTRB(30, 0, 0, 0)),
                    keyboardType: TextInputType.streetAddress,
                  ),
                ),
                //Password Text Field.
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
                //Confirm Password Text Field.
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
                //Picture Options.
                Container(
                  width: 200.0,
                  height: 40.0,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  ),
                  child: DropdownButton(
                    icon: Icon(
                      Icons.add_a_photo,
                      color: Colors.black,
                    ),
                    iconSize: 25.0,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.0,
                    ),
                    underline: Container(
                      width: 0.0,
                    ),
                    isExpanded: true,
                    hint: Text('Profile Picture'),
                    value: _selectedProfilePictureOption,
                    onChanged: (newValueOne) {
                      setState(() {
                        _selectedProfilePictureOption = newValueOne.toString();
                      });
                      checkForProfile();
                    },
                    items: profilePictureOptions.map((profileOption) {
                      return DropdownMenuItem(
                        child: Text(profileOption),
                        value: profileOption,
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                hasProfilePicture
                    ? Stack(
                        children: [
                          Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            width: 170.0,
                            height: 170.0,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              image: DecorationImage(
                                image: FileImage(
                                  profilePicture,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8.0,
                            right: 8.0,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  hasProfilePicture = false;
                                  _selectedProfilePictureOption =
                                      "Profile Picture";
                                });
                              },
                              child: Icon(
                                Icons.remove_circle,
                                size: 25.0,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(),
                SizedBox(height: 30),
                //SignUp Button.
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
                    onPressed: signUp,
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  checkForProfile() async {
    if (_selectedProfilePictureOption == "Choose existing photo") {
      chooseFileForProfil();
    } else if (_selectedProfilePictureOption == "Take photo") {
      takeImageForProfil();
    }
  }

  Future chooseFileForProfil() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      profilePicture = File(pickedFile!.path);
      hasProfilePicture = true;
    });
  }

  Future takeImageForProfil() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      profilePicture = File(pickedFile!.path);
      hasProfilePicture = true;
    });
  }

  void signUp() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Warning().errorMessage(
        context,
        title: "No internet connection !",
        message: "Please turn on wifi or mobile data",
        icons: Icons.signal_wifi_off,
      );
    } else if (_phoneController.text.isEmpty) {
      Warning().errorMessage(
        context,
        title: "Phone field can't be empty !",
        message: "Please enter your phone.",
        icons: Icons.warning,
      );
    } else if (_webSiteController.text.isEmpty) {
      Warning().errorMessage(
        context,
        title: "Website field can't be empty !",
        message: "Please enter your website.",
        icons: Icons.warning,
      );
    } else if (!_webSiteController.text.contains('@shool.com')) {
      Warning().errorMessage(
        context,
        title: 'Invalid website !',
        message: "Website must contain '@shool.com' ",
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
    } else if (hasProfilePicture == false) {
      Warning().errorMessage(
        context,
        title: "Profile picture can't be empty !",
        message: "Please take or choose profile picture",
        icons: Icons.warning,
      );
    } else {
      authBloc.add(
        SignUpForSchoolButtonPressed(
          name: _nameController.text,
          phone: _phoneController.text,
          webSite: _webSiteController.text,
          address: _addressController.text,
          password: _passwordController.text,
          profilePicture: profilePicture,
        ),
      );
    }
  }
}
