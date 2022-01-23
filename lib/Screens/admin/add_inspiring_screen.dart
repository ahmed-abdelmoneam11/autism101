import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autism101/Blocs/admin_bloc.dart';
import 'package:autism101/BlocEvents/admin_bloc_events.dart';
import 'package:autism101/BlocStates/admin_bloc_state.dart';
import 'package:autism101/Screens/admin/admin_home.dart';
import 'package:autism101/flush_bar.dart';

class AddInspiringScreen extends StatefulWidget {
  @override
  _AddInspiringScreenState createState() => _AddInspiringScreenState();
}

class _AddInspiringScreenState extends State<AddInspiringScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _briefController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _caseController = TextEditingController();
  late AdminBloc adminBloc;
  late File image;
  bool hasImage = false;

  @override
  void dispose() {
    _nameController.dispose();
    _briefController.dispose();
    _dateController.dispose();
    _caseController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    adminBloc = BlocProvider.of<AdminBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add Inspiring People',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
        ),
      ),
      body: BlocListener<AdminBloc, AdminState>(
        listener: (context, state) {
          if (state is AdminLodingState) {
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
          } else if (state is AddInspiringSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AdminHome(),
              ),
            );
          } else if (state is AddInspiringErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        child: ListView(
          children: [
            //Movie Name Text Field.
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
                  contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                ),
                keyboardType: TextInputType.name,
              ),
            ),
            //Movie Brief Text Field.
            Container(
              alignment: Alignment.center,
              width: 330,
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: _briefController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  hintText: 'Brief',
                  contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                ),
                keyboardType: TextInputType.name,
              ),
            ),
            //Movie AgeRate Text Field.
            Container(
              alignment: Alignment.center,
              width: 330,
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  hintText: 'Date',
                  contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                ),
                keyboardType: TextInputType.name,
              ),
            ),
            //Movie Actors Text Field.
            Container(
              alignment: Alignment.center,
              width: 330,
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: _caseController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  hintText: 'Autism Case',
                  contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                ),
                keyboardType: TextInputType.name,
              ),
            ),
            //Movie Image.
            Container(
              alignment: Alignment.center,
              width: 330,
              padding: EdgeInsets.all(20),
              child: Center(
                child: Container(
                  width: 145.0,
                  height: 35.0,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(5.0),
                      backgroundColor: MaterialStateProperty.all(
                        Colors.lightBlue,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45.0),
                        ),
                      ),
                    ),
                    onPressed: chooseImage,
                    child: Text(
                      "Image",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            hasImage
                ? Stack(
                    children: [
                      Center(
                        child: Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          width: 170.0,
                          height: 170.0,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            image: DecorationImage(
                              image: FileImage(
                                image,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 5.0,
                        right: 130.0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              hasImage = false;
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
            Container(
              alignment: Alignment.center,
              width: 330,
              padding: EdgeInsets.all(20),
              child: Center(
                child: Container(
                  width: 145.0,
                  height: 35.0,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(5.0),
                      backgroundColor: MaterialStateProperty.all(
                        Colors.lightBlue,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45.0),
                        ),
                      ),
                    ),
                    onPressed: addInspiring,
                    child: Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future chooseImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedFile!.path);
      hasImage = true;
    });
  }

  addInspiring() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Warning().errorMessage(
        context,
        title: "No internet connection !",
        message: "Please turn on wifi or mobile data",
        icons: Icons.signal_wifi_off,
      );
    } else if (_nameController.text.isEmpty) {
      Warning().errorMessage(
        context,
        title: "Name field can't be empty !",
        message: "Please enter name.",
        icons: Icons.warning,
      );
    } else if (_briefController.text.isEmpty) {
      Warning().errorMessage(
        context,
        title: "Brief field can't be empty !",
        message: "Please enter brief.",
        icons: Icons.warning,
      );
    } else if (_dateController.text.isEmpty) {
      Warning().errorMessage(
        context,
        title: "Date field can't be empty !",
        message: "Please enter date.",
        icons: Icons.warning,
      );
    } else if (_caseController.text.isEmpty) {
      Warning().errorMessage(
        context,
        title: "Case field can't be empty !",
        message: "Please enter case.",
        icons: Icons.warning,
      );
    } else if (hasImage == false) {
      Warning().errorMessage(
        context,
        title: "Image can't be empty !",
        message: "Please choose image",
        icons: Icons.warning,
      );
    } else {
      adminBloc.add(
        AddInspiring(
          name: _nameController.text,
          brief: _briefController.text,
          date: _dateController.text,
          autismCase: _caseController.text,
          image: image,
        ),
      );
    }
  }
}
