import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/profile_bloc.dart';
import 'package:autism101/BlocEvents/profile_bloc_events.dart';
import 'package:autism101/BlocStates/profile_bloc_state.dart';
import 'package:autism101/flush_bar.dart';

class EditProfile extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String profilePictureUrl;
  EditProfile({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profilePictureUrl,
  });
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  List<String> options = ['Take photo', 'Choose existing photo'];
  File? profilePicture;
  TextEditingController _password = TextEditingController();
  late TextEditingController _firstName;
  late TextEditingController _lastName;
  late TextEditingController _email;
  late ProfileBloc profileBloc;
  bool hasNewProfilePicture = false;
  var profilePictureUrl;

  @override
  void initState() {
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    _firstName = TextEditingController(text: widget.firstName);
    _lastName = TextEditingController(text: widget.lastName);
    _email = TextEditingController(text: widget.email);
    _password.clear();
    setState(() {
      profilePictureUrl = widget.profilePictureUrl;
    });
    super.initState();
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLodingState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: <Widget>[
                    CircularProgressIndicator(
                      color: Colors.lightBlue,
                    ),
                    Text("  Loading...")
                  ],
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is UpdateUserNameErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is UpdateProfileWithEmailAndNameErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is UpdateProfileWithEmailAndPictureErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is UpdateUserNameAndPictureErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is UpdateUserNameSuccessState ||
              state is UpdateProfileWithEmailAndNameSuccessState ||
              state is UpdateProfileWithEmailAndPictureSuccessState ||
              state is UpdateUserNameAndPictureSuccessState) {
            Navigator.pop(context);
          }
        },
        child: Stack(
          children: [
            //Background Color.
            Container(
              color: Colors.lightBlue,
            ),
            //Back Button.
            Positioned(
              top: 40.0,
              left: 15.0,
              child: Container(
                width: 35.0,
                height: 35.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                  color: Colors.white,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                  color: Colors.lightBlue,
                  iconSize: 20.0,
                ),
              ),
            ),
            //Screen Body.
            Positioned(
              top: 150.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                height: screenSize.height - 150.0,
                width: screenSize.width,
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      spreadRadius: 7,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        //profile image
                        CircleAvatar(
                          radius: 55.0,
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: hasNewProfilePicture
                                ? Image.file(
                                    profilePicture!,
                                    fit: BoxFit.fitWidth,
                                    height: 100.0,
                                    width: 100.0,
                                  )
                                : Image.network(
                                    profilePictureUrl,
                                    fit: BoxFit.fitWidth,
                                    height: 100.0,
                                    width: 100.0,
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        //user name
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //First Name Text Field.
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    "First Name",
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      color: Color(0xFFafaeae),
                                      fontWeight: FontWeight.w700,
                                      height: 1.0,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(
                                    5.0,
                                  ),
                                  child: Container(
                                    width: 170.0,
                                    height: 35.0,
                                    padding: EdgeInsets.only(
                                      top: 5.0,
                                      bottom: 5.0,
                                      left: 10.0,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2.0,
                                        color: Colors.lightBlue,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          45.0,
                                        ),
                                      ),
                                    ),
                                    child: TextField(
                                      controller: _firstName,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        height: 1.0,
                                      ),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(45.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(45.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(45.0),
                                        ),
                                      ),
                                      cursorColor: Colors.lightBlue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            //Last Name Text Field.
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    "Last Name",
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      color: Color(0xFFafaeae),
                                      fontWeight: FontWeight.w700,
                                      height: 1.0,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(
                                    5.0,
                                  ),
                                  child: Container(
                                    width: 170.0,
                                    height: 35.0,
                                    padding: EdgeInsets.only(
                                      top: 5.0,
                                      bottom: 5.0,
                                      left: 10.0,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2.0,
                                        color: Colors.lightBlue,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          45.0,
                                        ),
                                      ),
                                    ),
                                    child: TextField(
                                      controller: _lastName,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        height: 1.0,
                                      ),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(45.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(45.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(45.0),
                                        ),
                                      ),
                                      cursorColor: Colors.lightBlue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        //Email Text Field.
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: Text(
                                "Email",
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color: Color(0xFFafaeae),
                                  fontWeight: FontWeight.w700,
                                  height: 1.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 5.0,
                                left: 20.0,
                                right: 20.0,
                              ),
                              child: Container(
                                width: double.infinity,
                                height: 35.0,
                                padding: EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 5.0,
                                  left: 10.0,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2.0,
                                    color: Colors.lightBlue,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      45.0,
                                    ),
                                  ),
                                ),
                                child: TextField(
                                  controller: _email,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    height: 1.0,
                                  ),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(45.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(45.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(45.0),
                                    ),
                                  ),
                                  cursorColor: Colors.lightBlue,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 80.0,
                        ),
                        //Confirm Button.
                        Center(
                          child: Container(
                            width: 110.0,
                            height: 35.0,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(5.0),
                                backgroundColor: MaterialStateProperty.all(
                                  _firstName.text != widget.firstName ||
                                          _lastName.text != widget.lastName ||
                                          _email.text != widget.email ||
                                          hasNewProfilePicture
                                      ? Colors.lightBlue
                                      : Colors.grey,
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(45.0),
                                  ),
                                ),
                              ),
                              onPressed: _firstName.text != widget.firstName ||
                                      _lastName.text != widget.lastName ||
                                      _email.text != widget.email ||
                                      hasNewProfilePicture
                                  ? confirmEdits
                                  : null,
                              child: Text(
                                "Confirm",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            //Edit Profile Picture Button.
            Positioned(
              top: 250.0,
              left: 220.0,
              child: Container(
                width: 35.0,
                height: 35.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                  color: Colors.lightBlue,
                ),
                child: PopupMenuButton(
                  icon: Icon(
                    Icons.add_a_photo,
                    color: Colors.white,
                    size: 20.0,
                  ),
                  onSelected: (e) => {
                    if (e == options[0])
                      {
                        takeImageForProfil(),
                      }
                    else if (e == options[1])
                      {
                        chooseFileForProfil(),
                      },
                  },
                  itemBuilder: (context) {
                    return options.map((choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(
                          choice,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17.0,
                            color: Colors.black,
                            height: 1.0,
                          ),
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future chooseFileForProfil() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      profilePicture = File(pickedFile!.path);
      hasNewProfilePicture = true;
    });
  }

  Future takeImageForProfil() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      profilePicture = File(pickedFile!.path);
      hasNewProfilePicture = true;
    });
  }

  void confirmEdits() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Warning().errorMessage(
        context,
        title: "No internet connection !",
        message: "Please turn on wifi or mobile data",
        icons: Icons.signal_wifi_off,
      );
    } else if (_email.text != widget.email) {
      if (!_email.text.contains('@')) {
        Warning().errorMessage(
          context,
          title: 'Invalid email !',
          message: "Email must contain '@' ",
          icons: Icons.warning,
        );
      } else if (hasNewProfilePicture) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                elevation: 1.0,
                title: Text(
                  "Enter Password to Continue",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 21.0,
                    height: 1.3,
                  ),
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Color(0xFFafaeae),
                          fontWeight: FontWeight.w700,
                          height: 1.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5.0,
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 35.0,
                        padding: EdgeInsets.only(
                          top: 5.0,
                          bottom: 5.0,
                          left: 10.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2.0,
                            color: Colors.lightBlue,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              45.0,
                            ),
                          ),
                        ),
                        child: TextField(
                          controller: _password,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            height: 1.0,
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(45.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(45.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(45.0),
                            ),
                          ),
                          cursorColor: Colors.lightBlue,
                        ),
                      ),
                    ),
                  ],
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
                      'Ok',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                        height: 1.3,
                      ),
                    ),
                    onPressed: () {
                      if (_password.text.isEmpty) {
                        Warning().errorMessage(
                          context,
                          title: "Password field can't be empty !",
                          message: "Please enter your password.",
                          icons: Icons.warning,
                        );
                      } else {
                        profileBloc.add(
                          UpdateProfileWithEmailAndPicture(
                            firstName: _firstName.text,
                            lastName: _lastName.text,
                            email: _email.text,
                            password: _password.text,
                            picture: profilePicture!,
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              );
            });
      } else {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                elevation: 1.0,
                title: Text(
                  "Enter Password to Continue",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 21.0,
                    height: 1.3,
                  ),
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Color(0xFFafaeae),
                          fontWeight: FontWeight.w700,
                          height: 1.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5.0,
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 35.0,
                        padding: EdgeInsets.only(
                          top: 5.0,
                          bottom: 5.0,
                          left: 10.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2.0,
                            color: Colors.lightBlue,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              45.0,
                            ),
                          ),
                        ),
                        child: TextField(
                          controller: _password,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            height: 1.0,
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(45.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(45.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(45.0),
                            ),
                          ),
                          cursorColor: Colors.lightBlue,
                        ),
                      ),
                    ),
                  ],
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
                      'Ok',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                        height: 1.3,
                      ),
                    ),
                    onPressed: () {
                      if (_password.text.isEmpty) {
                        Warning().errorMessage(
                          context,
                          title: "Password field can't be empty !",
                          message: "Please enter your password.",
                          icons: Icons.warning,
                        );
                      } else {
                        profileBloc.add(
                          UpdateProfileWithEmailAndName(
                            firstName: _firstName.text,
                            lastName: _lastName.text,
                            email: _email.text,
                            password: _password.text,
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              );
            });
      }
    } else if (hasNewProfilePicture) {
      profileBloc.add(
        UpdateUserNameAndPicture(
          firstName: _firstName.text,
          lastName: _lastName.text,
          picture: profilePicture!,
        ),
      );
    } else {
      profileBloc.add(
        UpdateUserName(
          firstName: _firstName.text,
          lastName: _lastName.text,
        ),
      );
    }
  }
}
