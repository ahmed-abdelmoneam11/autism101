import 'dart:ui';
import 'dart:io';
import 'Layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/auth_bloc.dart';
import 'package:autism101/BlocEvents/auth_bloc_events.dart';
import 'package:autism101/BlocStates/auth_bloc_state.dart';
import 'package:autism101/flush_bar.dart';
import 'package:autism101/Screens/user/home_screen.dart';

class ParentAccount2 extends StatefulWidget {
  final firstName;
  final lastName;
  final email;
  final password;
  ParentAccount2({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
  });
  @override
  _ParentAccountState createState() => _ParentAccountState();
}

class _ParentAccountState extends State<ParentAccount2> {
  late String gender;
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  late AuthBloc authBloc;
  late File profilePicture;
  bool hasProfilePicture = false;
  List<String> profilePictureOptions = [
    'Profile Picture',
    'Take photo',
    'Choose existing photo'
  ];
  String _selectedProfilePictureOption = "Profile Picture";

  @override
  void dispose() {
    _phoneController.dispose();
    _ageController.dispose();
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
          } else if (state is SignUpForParentErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is SignUpForParentSuccessState) {
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
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: Text('Create an Account',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 35)),
                ),
                //Phone Text Field.
                Container(
                  alignment: Alignment.center,
                  width: 330,
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20.0,
                    top: 10.0,
                  ),
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
                //Age Text Field.
                Container(
                  alignment: Alignment.center,
                  width: 330,
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    controller: _ageController,
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
                //Gender Label.
                Container(
                  padding: EdgeInsets.only(left: 50, top: 10),
                  alignment: Alignment.centerLeft,
                  child: Text('Gender ', style: TextStyle(fontSize: 25)),
                ),
                SizedBox(
                  height: 10.0,
                ),
                //Gender Buttons.
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.all(25)),
                    //Male Button.
                    OutlinedButton.icon(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        backgroundColor: Colors.grey.shade50,
                      ),
                      onPressed: () => {
                        setState(() {
                          gender = "male";
                        }),
                      },
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
                    //Female Button.
                    OutlinedButton.icon(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        backgroundColor: Colors.grey.shade50,
                      ),
                      onPressed: () => {
                        setState(() {
                          gender = "female";
                        }),
                      },
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
                //Picture Label.
                Container(
                  padding: EdgeInsets.only(left: 50, top: 10),
                  alignment: Alignment.centerLeft,
                  child: Text('Picture ', style: TextStyle(fontSize: 25)),
                ),
                SizedBox(
                  height: 10.0,
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
                SizedBox(height: 20.0),
                //Sign Up Button.
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
                SizedBox(height: 10.0),
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
    } else if (_ageController.text.isEmpty) {
      Warning().errorMessage(
        context,
        title: "Age field can't be empty !",
        message: "Please enter your age.",
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
        SignUpForParentButtonPressed(
          firstName: widget.firstName,
          lastName: widget.lastName,
          email: widget.email,
          phone: _phoneController.text,
          password: widget.password,
          age: _ageController.text,
          gender: gender,
          profilePicture: profilePicture,
        ),
      );
    }
  }
}
